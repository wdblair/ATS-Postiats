staload "SATS/io.sats"
staload "SATS/interrupt.sats"
staload "SATS/fifo.sats"

(* ****** ****** *)

fun{} make_ubrr (baud: uint): uint

fun {m:mcu} init (
  baud: uint
): void

fun {m:mcu} rx (): char

fun {m:mcu} tx (c: char): int

fun ubrr_of_baud (baud: uint): uint 
  = "mac#avr_libats_ubrr_of_baud"
  
fun {m:mcu} async_init (
  baud: uint
): void

fun {m:mcu} async_rx (
  _: !INT_SET | 
): char

fun {m:mcu} async_tx (
  _: !INT_SET | c: char
) : int
