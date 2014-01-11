staload "bv.sats"

typedef Ctrl = [b:bit8 | (b land bit8(1)) == bit8(1)] bit8 (b)

extern
praxi initize_lemma (&Ctrl? >> Ctrl): void

local
  var control : Ctrl
  
  prval () = initize_lemma (control)
in
end

(*
 Try to set ctrl to something such that
 ctrl & 0x1 != 0x1
 and observe that the invariant is violated. 
*)
fun make_controller (): Ctrl = let 
  val ctrl = bit8(1u)
in
 ctrl
end
