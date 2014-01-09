staload "bv.sats"

assume uint8_t0ype (b:bv8) = $extype "uint8"

stacst one: bv8

typedef controller = [b:bv8 | (b land one) == one] uint8 (b)

extern
praxi initize_lemma (&controller? >> controller): void

local
  var control : controller
  
  prval () = initize_lemma (control)
in
end