(* ****** ****** *)
//
// HX-2014-01-25:
// infseq-indexed arrays
//
(* ****** ****** *)

staload "./array.sats"
staload "./stampseq.sats"

(* ****** ****** *)

extern
fun {a:t@ype} insord
  {l:addr}
  {xs:stmsq}
  {n,n1:int}
  {i:nat | i <= n1; n1 < n; sorted(remove(xs, i), n1)}
(
  pf: array_v (a, l, xs, n) | p: ptr(l+i*sizeof(a)), i: int(i)
) : [ys:stmsq | sorted(ys, n1+1)] (array_v (a, l, ys, n) | void)

(* ****** ****** *)

implement
insord {..} {..} {n,n1} {i} (pf | p, i) = let
in
//
if i > 0
then let
  val x = array_ptrget {..}{..}{..}{i} (pf | p)
  val p1 = p - 1
  val x1 = array_ptrget {..}{..}{..}{i-1} (pf | p1)
in
  if x1 <= x
    then (pf | ())
    else let
      val () =
        array_ptrswap {..}{..}{..}{i,i-1} (pf | p, p1)
     in 
      insord {..}{..}{n,n1}{i-1} (pf | p1, i-1)
      // end of [val]
     end (* else *)
  // end of [if]
end (*then*)
else (pf | ())
//
end // end of [insord]

(* ****** ****** *)

(* end of [array_insort.dats] *)
