staload "SATS/io.sats"
staload "SATS/delay.sats"

staload "DATS/atmega328p/io.dats"

#include "HATS/atspre_staload.hats"

stadef m: mcu = atmega328p

#define TOP 255

implement main0 () = let
  val () = begin
    (*
      Phase Correct PWM using no prescaler
      
      output waveform on both PD5 and PD6
    *)
    setbits (TCCR0A<m>(), WGM00, COM0A1, COM0B1);
    setbits (TCCR0B<m>(), CS00);
    (*
      We want a 25kHz frequency on the wave form.
      This is the "typical" frequency specified on the
      L298 H-Bridge Driver
    *)
    (*
      Set the Compare Pins to Output
    *)
    setbits (DDRD<m>(), DDD5, DDD6);
  end
  //
  fun set_duty (d: natLt(256)): void = begin
    setval (OCR0A<m>(), d);
    setval (OCR0B<m>(), d);
  end
  //
  fun brighter (i: natLt(256)): void =
    if i = TOP then
      dimmer (i)
    else let
      val () = set_duty (i)
      val () = _delay_ms (20.0)
    in
      brighter (succ (i))
    end
  and dimmer (i: natLt(256)): void = 
    if i = 0 then
      brighter (0)
    else let
      val () = set_duty (i)
      val () = _delay_ms (10.0)
    in
      dimmer (pred (i))
    end
  //
in brighter (0) end