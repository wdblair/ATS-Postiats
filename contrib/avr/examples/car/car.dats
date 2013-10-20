staload "SATS/main.sats"
staload "SATS/io.sats"
staload "SATS/delay.sats"

staload Serial = "SATS/usart.sats"

staload "DATS/atmega328p/io.dats"
staload _ = "DATS/atmega328p/usart.dats"

#include "HATS/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

stadef m = atmega328p

#define LEFTMOTOR1 PINB0  
#define LEFTMOTOR2 PINB1

#define RIGHTMOTOR1 PIND6
#define RIGHTMOTOR2 PIND7

fun move_forward (): void = begin
  setbits (PORTB<m>(), LEFTMOTOR1);
  setbits (PORTD<m>(), RIGHTMOTOR1);
  //
  clearbits (PORTB<m>(), LEFTMOTOR2);
  clearbits (PORTD<m>(), RIGHTMOTOR2);
end
  
fun move_backward (): void = begin
  clearbits (PORTB<m>(), LEFTMOTOR1);
  clearbits (PORTD<m>(), RIGHTMOTOR1);
  //
  setbits (PORTB<m>(), LEFTMOTOR2);
  setbits (PORTD<m>(), RIGHTMOTOR2);
end

fun stop (): void = begin
  clearbits (PORTB<m>(), LEFTMOTOR1, LEFTMOTOR2);
  clearbits (PORTD<m>(), RIGHTMOTOR1, RIGHTMOTOR2);
end

extern
fun pulse_in {m:mcu} {w,b:int | b < w}
  (r: register(m, w), b: int b, state: int, timeout: ulint): ulint = "mac#"

extern
fun ltoa {n:int} (value: lint, buf: &(@[char][n]), radix: int): void = "mac#"

#define HIGH 1

fun{} measure_distance (): ulint = let
  val () = clearbits(PORTD<m>(), PORTD3)
  val () = _delay_us (2.0)
  val () = setbits (PORTD<m>(), PORTD3)
  val () = _delay_us (5.0)
  val () = clearbits (PORTD<m>(), PORTD3)
  val duration = pulse_in (PIND<m>(), PIND2, HIGH, 10000000ul)
in
  (duration / 29ul / 2ul)
end

fun{} print_buf {n:nat} (buf: &(@[char][n]), n: int n): void = let
  fun loop {i:nat | i <= n} (buf: &(@[char][n]), i: int i): void =
    if i = n then
      ()
    else if buf.[i] = '\0' then
      ()
    else let
      val _ = $Serial.tx<m> (buf.[i])
    in loop (buf, succ(i)) end
    
in loop(buf, 0) end 

extern castfn ulint_lint (_: ulint): lint

implement main0 () = let
  val () = $Serial.init<m> (9600u)
  //Turn the wheels on
  val () = begin
    setbits (DDRB<m>(), DDB0, DDB1);
    setbits (DDRD<m>(), DDD3, DDD6, DDD7);
    clearbits (DDRD<m>(), DDD2);
    clearbits (PORTD<m>(), PORTD2);
  end
  //Give it a few seconds
  val () = _delay_ms (3000.0)
  //
  fun loop(): void = let
    var buf = @[char][10]('\0')
    val dist = measure_distance<> ()
    val _ = ltoa (ulint_lint(dist), buf, 10)
    val () = print_buf (buf, 10)
    val () = buf.[0] := '\n'
    val () = buf.[1] := '\r'
    val () = buf.[2] := '\0'
    val () = print_buf (buf, 10)
    val () = _delay_ms(2000.0)
  in
    loop ()
  end
  (*
  fun loop(): void = let
    val () = begin
      move_forward ();
      _delay_ms (1000.0);
      stop ();
      _delay_ms (1000.0);
      move_backward();
      _delay_ms (1000.0);
      stop ();
      _delay_ms (1000.0);
    end
  in loop () end
  *)
  //
in loop () end

%{^

typedef volatile uint8_t * register_t;

#define cycles_per_ms() (F_CPU / 1000)
#define ms_to_cycles(a) (a * cycles_per_ms())
#define cycles_to_ms(a) (a / cycles_per_ms())

/* 
   Measure the width of a pulse. 
   adapted from the same named Arduino function
*/
unsigned long pulse_in (register_t port, int i, int state, unsigned long timeout) {
  uint8_t bit  = _BV(i);
  uint8_t mask = (state ? bit : 0);
  unsigned long width = 0;

  // convert the timeout from microseconds to a number of times through
  // the initial loop; it takes 16 clock cycles per iteration.
  unsigned long numloops = 0;
  unsigned long maxloops = ms_to_cycles(timeout) / 16;
  
  // wait for any previous pulse to end
  while ((*port & bit) == mask)
    if (numloops++ == maxloops)
      return 0;
       
  // wait for the pulse to start
  while ((*port & bit) != mask)
    if (numloops++ == maxloops)
      return 0;
  
  // wait for the pulse to stop
  while ((*port & bit) == mask) {
    if (numloops++ == maxloops)
      return 0;
    width++;
  }

  //There are some magic values added about how long the loops are
  return cycles_to_ms (width * 21 + 16);
}

%}