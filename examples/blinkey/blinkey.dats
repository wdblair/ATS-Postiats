staload "SATS/main.sats"
staload "SATS/io.sats"
staload "SATS/delay.sats"

staload "DATS/iom328p.dats"

#define ATS_DYNLOADFLAG 0

stadef m = atmega328p

implement setup() = {
  val _ = setbits(DDRB<m>(), DDB3)
}

implement event () = {
  val _ = flipbits(PORTB<m>(), PORTB3)
  val _ = _delay_ms(250.0)
}
