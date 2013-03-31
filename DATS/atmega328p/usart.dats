staload "SATS/io.sats"
staload "SATS/usart.sats"

staload "DATS/atmega328p/io.dats"

staload "prelude/DATS/integer.dats"

stadef mcu = atmega328p

extern
castfn char_of_uint8(_: uint8): char

extern
castfn uint8_of_char(_: char): [n:nat | n < 256] int n

implement init<mcu>(baud) = {
  val ubrr = ubrr_of_baud(baud)
  val () = setval(UBRR0H<mcu>(), UBRR0L<mcu>(), ubrr)
  //Mode is Asynchronous 8-N-1
  val () = setbits(UCSR0C<mcu>(), UCSZ01, UCSZ00)
  val () = setbits(UCSR0B<mcu>(), RXEN0, TXEN0)
}

implement rx<mcu>() = c where {
  val () = loop_until_bit_is_set(UCSR0A<mcu>(), RXC0)
  val c = char_of_uint8(value(UDR0<mcu>()))
}

implement tx<mcu>(c) = 0 where {
  val () = 
   if c = '\n' then {
      val _ = tx<mcu>('\r')
   }
   val () = loop_until_bit_is_set(UCSR0A<mcu>(), UDRE0)
   val () = setval(UDR0<mcu>(), uint8_of_char(c))
}