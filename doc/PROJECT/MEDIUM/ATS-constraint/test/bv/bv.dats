staload "bv.sats"

assume ubitvec8_t0ype (b:bv8) = $extype "uint8"

stacst one: bv8

typedef UBitVec8 = [b:bv8 | (b land bv8(1)) == bv8(1)] ubitvec8 (b)

extern
praxi initize_lemma (&UBitVec8? >> UBitVec8): void

local
  var control : UBitVec8
  
  prval () = initize_lemma (control)
in
end