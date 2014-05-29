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

local

prfun
lemma
  {l:addr}{a:t@ype}{xs:stmsq}
  {n:int}{i:nat | i <= n} .<i>.
(
  pf: array_v(a, l, xs, n), i: int (i)
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

staload _ = "prelude/DATS/integer.dats"
staload _ = "prelude/DATS/pointer.dats"

implement {a}
array_get_at {l}{xs}{n}{i}
  (pf | p, i) = x where
{
//
prval (pf1, pf2) = array_v_split{a}{l}{xs}{n}{i} (pf, i)
prval array_v_cons {a} {l1} (pf21, pf22) = pf2
//
val pi = ptr_add (p, i)
val x = ptr_get0 (pf21 | pi)
//
prval ((*void*)) =
  pf := array_v_unsplit (pf1, array_v_cons (pf21, pf22))
//
} (* end of [array_get_at] *)

(* ****** ****** *)

(* end of [array.dats] *)
