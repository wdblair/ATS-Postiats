(* ****** ****** *)
//
// HX-2014-01-25:
// infseq-indexed arrays
//
(* ****** ****** *)

staload "./array.sats"

(* ****** ****** *)

staload "./stampseq.sats"

(* ****** ****** *)

implement {a} ptr_get0 (pf | p) = !p

(**
  By default, just use the sizeof function
  given by ATS.
*)
implement {a} sizeof_t0ype () = sizeof<a>

implement {a} add_ptr_int {l}{i} (p, i) =
  add_ptr_bsz (p, sizeof_t0ype<a>() * i)

implement {a} succ_ptr_t0ype (p) =
  add_ptr_bsz (p, sizeof_t0ype<a>())


local

prfun
lemma
  {l:addr}{a:t@ype}{xs:stmsq}
  {n:int}{i:nat | i <= n} .<i>.
(
  pf: array_v(a, l, xs, n), i: size_t (i)
) : (
  array_v (a, l, take(xs, i), i)
, array_v (a, l+sizeof(a)*i, drop(xs, i), n-i)
) = let
in
//
if i = 0
then
  (array_v_nil (), pf)
else let
  prval array_v_cons (pf1, pf2) = pf
  prval (pf21, pf22) = array_v_split (pf2, i-1)
in
  (array_v_cons (pf1, pf21), pf22)
end // end of [else]
//
end // end of [lemma]

in (* in-of-local *)

primplement
array_v_split (pf, i) = lemma (pf, i)

end // end of [local]

(* ****** ****** *)

(**

Z3 Can't solve this one on its own, but
with an append prop it should be easy.

local

prfun
lemma
  {a:t@ype}{l:addr}{xs,ys:stmsq}
  {m,n:nat} .<m+n>.
(
  xs: array_v(a, l, xs, m),
  ys: array_v(a, l+sizeof(a)*m, ys, n)
) : (
  array_v (a, l, append(xs, m, ys, n), m+n)
) = 
  case+ xs of
    | array_v_nil () => ys
    | array_v_cons (x, xss) => let
      val tail = array_v_unsplit (xss, ys)
    in
      array_v_cons (x, tail)
    end
// end of [lemma]

in (* in-of-local *)

primplement
array_v_unsplit (xs, ys) = lemma (xs, ys)

end // end of [local]

*)
    
(* ****** ****** *)

implement {a}
array_get_at
  (pf | p, i) = x where
{
//
prval (pf1, pf2) = array_v_split (pf, i)
prval array_v_cons (pf21, pf22) = pf2
//
val pi = add_ptr_int<a> (p, i)
val x = ptr_get0<a> (pf21 | pi)
//
prval ((*void*)) =
  pf := array_v_unsplit (pf1, array_v_cons (pf21, pf22))
//
} (* end of [array_get_at] *)

(* ****** ****** *)

(* end of [array.dats] *)
