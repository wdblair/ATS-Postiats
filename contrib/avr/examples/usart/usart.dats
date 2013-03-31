(*
  Trying a simple serial interface with polling
*)

staload "SATS/io.sats"
staload Serial = "SATS/usart.sats"

staload _ = "prelude/DATS/integer.dats"

staload _ = "DATS/atmega328p/io.dats"
staload _ = "DATS/atmega328p/usart.dats"

#define ATS_DYNLOADFLAG 0

stadef mcu = atmega328p

implement main () = 0 where {
  val () = $Serial.init<mcu>(9600u)
  val () = while(true) {
    val c = $Serial.rx<mcu>()
    val _ = $Serial.tx<mcu>(c)
  }
}