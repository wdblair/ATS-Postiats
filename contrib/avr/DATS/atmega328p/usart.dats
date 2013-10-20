staload "SATS/io.sats"
staload "SATS/usart.sats"

staload "DATS/atmega328p/io.dats"

stadef mcu = atmega328p

extern
castfn char_of_uint8 (_: uint8): char

extern
castfn uint8_of_char (_: char): [n:nat | n < 256] int n

implement init<mcu>(baud) = {
  val ubrr = F_CPU / (16ul * g0uint2uint_uint_ulint(baud))
  val ubrr = g0uint2uint_ulint_uint(ubrr)
  val () = setval(UBRR0H<mcu>(), UBRR0L<mcu>(), ubrr)
  //Mode is Asynchronous 8-N-1
  val () = clear_and_setbits (UCSR0C<mcu>(), UCSZ01, UCSZ00)
  val () = clear_and_setbits (UCSR0B<mcu>(), RXEN0, TXEN0)
}

implement rx<mcu>() = c where {
  val () = loop_until_bit_is_set (UCSR0A<mcu>(), RXC0)
  val c = char_of_uint8 (value(UDR0<mcu>()))
}

implement tx<mcu>(c) = 0 where {
  val () = loop_until_bit_is_set (UCSR0A<mcu>(), UDRE0)
  val () = setval (UDR0<mcu>(), uint8_of_char(c))
}

////
implement async_init<mcu> (baud) = {
  val ubrr = make_ubrr (baud)
  val _ = assert (ubrr > 0)
  val () = setval (
    UBRR0H<mcu>(), UBRR0L<mcu>(), ubrr
  )
  val () = setbits (UCSR0C<mcu>(), UCSZ01, UCSZ00)
  val () = setbits (UCSR0B<mcu>(), RXEN0, TXEN0, RXCIE0, TXCIE0)
}