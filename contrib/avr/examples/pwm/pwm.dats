staload "SATS/main.sats"
staload "SATS/io.sats"
staload "SATS/delay.sats"
staload "SATS/global.sats"

staload "prelude/DATS/integer.dats"

#define ATS_DYNLOADFLAG 0

staload "DATS/atmega328p/io.dats"

stadef p = atmega328p

fun setup () : void = {
  val () = setbits(TCCR2A<p>(), WGM20, WGM21, COM2A1)
  val () = setbits(TCCR2B<p>(), CS20)
  val () = setbits(DDRB<p>(), DDB3)
}

fun set_pwm_output(duty: natLt(256)): void =
  setval(OCR2A<p>(), duty)
  
implement main () = 0 where {
  val () = setup()
  val () = while(true) {
    var i : [n:nat] int n
    val () = for( i := 0; i < 256; i := i + 1) {
      val () = set_pwm_output(i)
      val () = _delay_ms(2.5)
    }
    val () = for( i := 0; i < 256; i := i + 1) {
      val () = set_pwm_output(255 - i)
      val () = _delay_ms(2.5)
    }
  }
}