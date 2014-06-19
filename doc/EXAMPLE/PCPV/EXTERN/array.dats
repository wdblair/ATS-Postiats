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

implement {} add_ptr_int{a}{l}{i} (p, i) =
  add_ptr_bsz (p, sizeof_t0ype{a}() * i)

implement {} succ_ptr_t0ype{a} (p) =
  add_ptr_bsz (p, sizeof_t0ype{a}())

extern
fun sub_ptr_ptr {p,q:addr} (ptr p, ptr q):<> size_t (p - q)

(**
  TODO: Incorporate this lemma to the SMT solver, this is true for all
  types.
*)
extern
praxi sizeof_lemma {a:t@ype}(): [sizeof(a) > 0] void

(**
Z3 can't decide this one interestingly enough...

extern
fun div_size_size {n,p:nat} (size_t n, size_t p):<> size_t (n/p)

implement {} ptr_offset {a}{l}{i} (p, pi) = let
  prval () = sizeof_lemma {a}()
  val offs = sub_ptr_ptr{l+sizeof(a)*i,l}(pi, p)
in
  div_size_size (offs, sizeof_t0ype{a}())
end
*)


extern
fun offset_size {a:t@ype}{l:addr}{i:nat} (
  ptr l, ptr (l+sizeof(a)*i), size_t (sizeof(a))
):<> size_t i = "mac#"

implement {} ptr_offset {a}{l}{i} (p, pi) =   
  offset_size{a} (p, pi, sizeof_t0ype{a}())
 
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

Z3 can't solve this one which is strange considering
both the list an livt_vt functions are appended fine.

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
val pi = add_ptr_int<>{a} (p, i)
val x = ptr_get0<a> (pf21 | pi)
//
prval ((*void*)) =
  pf := array_v_unsplit (pf1, array_v_cons (pf21, pf22))
//
} (* end of [array_get_at] *)

(* ****** ****** *)

(* end of [array.dats] *)
