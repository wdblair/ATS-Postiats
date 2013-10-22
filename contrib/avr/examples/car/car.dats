staload "SATS/main.sats"
staload "SATS/io.sats"
staload "SATS/pwm.sats"
staload "SATS/delay.sats"

staload Serial = "SATS/usart.sats"

staload "DATS/atmega328p/io.dats"
staload _ = "DATS/atmega328p/pwm.dats"
staload _ = "DATS/atmega328p/usart.dats"

#include "HATS/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

stadef m = atmega328p

extern
fun pulse_in {m:mcu} {w,b:int | b < w}
  (r: register(m, w), b: int b, state: int, timeout: ulint): ulint = "mac#"

extern
fun ltoa {n:int} (value: lint, buf: &(@[char][n]), radix: int): void = "mac#"

#define HIGH 1

fun{} measure_distance (): ulint = let
  val () = clearbits(PORTD<m>(), PORTD7)
  val () = _delay_us (2.0)
  val () = setbits (PORTD<m>(), PORTD7)
  val () = _delay_us (5.0)
  val () = clearbits (PORTD<m>(), PORTD7)
  val duration = pulse_in (PIND<m>(), PIND2, HIGH, 10000000ul)
in
  (duration / 29ul / 4ul)
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

fun left_forward (speed: natLt(256)): void =
  pwm_set_duty<m><t0><a> (speed)
  
fun left_backward (speed: natLt(256)): void =
  pwm_set_duty<m><t0><b> (speed)
      //
fun right_forward (speed: natLt(256)): void = 
  pwm_set_duty<m><t2><a> (speed)        

fun right_backward (speed: natLt(256)): void = 
  pwm_set_duty<m><t2><b> (speed)

(* Halt all motion *)
fun stop (): void = begin
  left_forward (0);
  right_forward (0);
  left_backward (0);
  right_forward (0);
end

implement main0 () = let
  val () = $Serial.init<m> (9600u)
  (*
    Setup our pwm channels
    The L298 H-Bridge chip needs the wave form
    between 25kHz and 40kHz. Phase correct does about 31kHz 
    with no clock prescaler (default)
  *)
  val () = begin
    pwm_start<m><phase_correct><t0> ();
    pwm_start<m><phase_correct><t2> ();
  end
  //Set input for our sonar
  val () = begin
    setbits (DDRD<m>(), DDD7);
    clearbits (DDRD<m>(), DDD2);
    clearbits (PORTD<m>(), PORTD2);
  end
  fun loop (speed: natLt(256)): void = let
    var buf = @[char][10] ('\0')
    val cmd = $Serial.rx<m> ()
    var next_speed : natLt(256) = speed
    val scale = 10
    // stop all motion
    val () = stop ()
    //decide where to go next
    val () = (case+ cmd of
      | 'f' => begin
        left_forward (speed);
        right_forward (speed);
      end
      | 'b' => begin
        left_backward (speed);
        right_backward (speed); 
      end
      | 'r' => begin
        left_forward (speed);
        right_backward (speed);
      end
      | 'l' => begin
        left_backward (speed);
        right_forward (speed);
      end
      | 'd' => {
        val dist = measure_distance<> ()
        val _ = ltoa (ulint_lint(dist), buf, 10)
        val () = print_buf (buf, 10)
        val () = buf.[0] := '\n'
        val () = buf.[1] := '\r'
        val () = buf.[2] := '\0'
        val () = print_buf (buf, 10)
      }
      | '+' => let
        val nxt = speed + scale
       in
        if nxt >= 256 then
          next_speed := 255
        else
          next_speed := nxt
       end
      | '-' => let
        val nxt = speed - scale
       in
        if nxt < 0 then
          next_speed := 0
        else
          next_speed := nxt
       end
      | 'q' => next_speed := 0
      | _  => ()
      ): void
  in
    loop (next_speed)
  end
  // start at 50% speed
in loop (128) end

%{^

typedef volatile uint8_t * register_t;

#define cycles_per_ms() (F_CPU / 1000)
#define ms_to_cycles(a) (a * cycles_per_ms())
#define cycles_to_ms(a) (a / cycles_per_ms())

/* 
   Measure the width of a pulse. 
   adapted from the same named Arduino function

   TODO: try to implement this using a timer instead,
   guestimating how long the instructions take seems a little
   hacky.
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

  //There are some magic values added to account for how long the loops are
  return cycles_to_ms (width * 21 + 16);
}
%}