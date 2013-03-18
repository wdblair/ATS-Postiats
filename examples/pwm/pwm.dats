(*
  The state is stored in .bss for now since a long running loop
  is not possible in the current ATS2 compiler  
    (recursion would blow up the stack)
*)
staload "SATS/main.sats"
staload "SATS/io.sats"
staload "SATS/delay.sats"
staload "SATS/global.sats"

staload "prelude/DATS/integer.dats"

stadef p = atmega328p

staload "DATS/iom328p.dats"

#define ATS_DYNLOADFLAG 0

#define brighter 1
#define dimmer ~1

%{^
  typedef struct {
    atstype_int delta;
    atstype_int brightness;
  } state_t;
  
  static state_t state;
%}

typedef state_t = $extype_struct "state_t "of {
  delta= [n:int | n == 1 || n == ~1] int n,
  brightness= natLt(256)
}

val state = viewkey_make {state_t} (
  $extval([l:addr] ptr l, "&state")
)

implement setup () = {
  val (pf | s) = global_get(state)
  val () = setbits(TCCR2A<p>(), WGM20, WGM21, COM2A1)
  val () = setbits(TCCR2B<p>(), CS20)
  val () = setbits(DDRB<p>(), DDB3)
  prval () = global_return(state, pf)
}

fun set_pwm_output(duty: natLt(256)): void = 
  setval(OCR2A<p>(), duty)

implement event () = let
  val (pf | s) = global_get(state)
  val bright = !s.brightness
  val delta = !s.delta
  val () = set_pwm_output(bright)
in
    if bright + delta = 256 then {
      val delta = ~1
      prval () = global_return(state, pf)
    }
    else if bright + delta < 0 then {
      val () = !s.delta := 1
      prval () = global_return(state, pf)
    }
    else {
      val () =
        !s.brightness := bright + delta
      val () = _delay_ms(2.5)
      prval () = global_return(state, pf)
    }
end