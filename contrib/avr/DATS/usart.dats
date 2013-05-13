(*
  Generic utilities for usart device.
*)

staload "SATS/io.sats"
staload "SATS/usart.sats"

// The cast functions really need some shorthands
implement make_ubrr {n} (baud) = let
  val ubrr = F_CPU / (16ul * g1uint2uint_uint_ulint(baud))
in g1uint2uint_ulint_uint(ubrr) end
