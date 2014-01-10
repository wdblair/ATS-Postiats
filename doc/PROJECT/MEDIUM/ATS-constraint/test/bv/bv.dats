staload "bv.sats"

assume ubitvec8_t0ype (b:bv8) = $extype "uint8"

stacst one: bv8

//typedef controller = [b:bv8 | (b land one) == one] ubitvec8 (b)

typedef BitVec8 = [b:bv8] ubitvec8 (b)

extern
praxi initize_lemma (&BitVec8? >> BitVec8): void

local
  var control : BitVec8
  
  prval () = initize_lemma (control)
in
end