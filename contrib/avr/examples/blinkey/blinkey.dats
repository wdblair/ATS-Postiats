staload "SATS/main.sats"
staload "SATS/io.sats"
staload "SATS/delay.sats"

staload "DATS/atmega328p/io.dats"

#define ATS_DYNLOADFLAG 0

stadef m = atmega328p

implement main() = 0 where {
  val _ = setbits(DDRB<m>(), DDB3)
  val () = while(true) {
    val () = flipbits(PORTB<m>(), PORTB3)
    val () = _delay_ms(250.0)
  }
}
