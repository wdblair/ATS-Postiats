(*
  Generic utilities for working with the usart module.
*)

staload "SATS/io.sats"
staload "SATS/usart.sats"

(*
  The cast functions really need some shorthands
*)
implement{} make_ubrr (baud) = let
  val ubrr = F_CPU / (16ul * g0uint2uint_uint_ulint(baud))
in g0uint2uint_ulint_uint(ubrr) end

// g1uint2uint_ulint_uint