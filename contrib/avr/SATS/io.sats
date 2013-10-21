(*
  All template definitions for IO ports, interrupt service routines, and
  such.
*)

%{#
#include "CATS/io.cats"
%}

staload "SATS/atomic.sats"

sortdef mcu = tkind

stacst atmega328p : mcu

abst@ype register(mcu, width:int) = $extype "volatile void *"

fun value {m: mcu} (
  r: register(m, 8)
): uint8 = "mac#avr_libats_value_8bit"

macdef F_CPU = $extval([f:pos] ulint f, "F_CPU")

(* ****** ****** *)

fun loop_until_bit_is_set {m:mcu} (
  _: register(m, 8), n: natLt(8)
): void = "mac#loop_until_bit_is_set_8bit"

(* ****** ****** *)

symintr setval

fun setval_8bit {m:mcu} (
  r: register(m, 8), value: natLt(256)
): void = "mac#avr_libats_setval_8bit"

overload setval with setval_8bit

fun setval_16bit {m:mcu} (
  high: register(m, 16), value: uint
): void = "mac#avr_libats_setval_16bit"

overload setval with setval_16bit

(* ****** ****** *)

(*
  Just assume we're using the Atmega328p for now
*)
#include "SATS/iom328p.sats"
#include "SATS/io_bits.sats"