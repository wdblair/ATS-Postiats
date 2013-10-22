staload "SATS/io.sats"
staload "SATS/delay.sats"

staload "DATS/atmega328p/io.dats"

#include "HATS/atspre_staload.hats"

stadef m: mcu = atmega328p

(*
 25kHz = f_cpu / (2 * TOP)
*)
#define TOP 319u

implement main0 () = let
  val () = begin
    (*
      Phase Correct PWM using no prescaler
      
      output waveform on both PB1 and PB2
    *)
    setbits (TCCR1A<m>(), WGM11, COM1A1, COM1B1);
    setbits (TCCR1B<m>(), CS10, WGM13);
    (*
      We want a 25kHz frequency on the wave form.
      This is the "typical" frequency specified on the
      L298 H-Bridge Driver
    *)
    setval (ICR1<m>(), TOP);
    (*
      Set the Compare Pins to Output
    *)
    setbits (DDRB<m>(), DDB1, DDB2);
  end
  //
  fun set_duty (d: uint): void = begin
    setval (OCR1A<m>(), d);
    setval (OCR1B<m>(), d);
  end
  //
  fun brighter (i: uint): void =
    if i = TOP then
      dimmer (i)
    else let
      val () = set_duty (i)
      val () = _delay_ms (20.0)
    in
      brighter (succ (i))
    end
  and dimmer (i: uint): void = 
    if i = 0u then
      brighter (0u)
    else let
      val () = set_duty (i)
      val () = _delay_ms (20.0)
    in
      dimmer (pred (i))
    end
  //
in brighter (0u) end