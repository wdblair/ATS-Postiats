(*
  Generic utilities for working with the usart device.
*)

staload "SATS/io.sats"
staload "SATS/usart.sats"

(*
  The cast functions really need some shorthands
  
  If I want an unsigned int, I should just be able to do
  
  (uint)variable
 
  I know this isn't very explicit, but making people memorize
  
  g(1|0)(uint|int)2(uint|int)_(uint|size|ulint|ullint|int|lint)_(uint|size|ulint|ullint|int|lint)

  Just seems a little over the top. We can just define symbols for each
  destination type and overload them with the functions given above.
  
  Whether you're going from g(0|1)uint  to g(0|1)int limits the number of possible combinations.
  The pattern above doesn't even include fixed width numbers which are pervasive in embedded code.
*)
implement{} make_ubrr {n} (baud) = let
  val ubrr = F_CPU / (16ul * g1uint2uint_uint_ulint(baud))
in g1uint2uint_ulint_uint(ubrr) end