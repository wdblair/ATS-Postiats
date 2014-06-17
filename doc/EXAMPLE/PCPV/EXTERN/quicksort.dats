staload "stampseq.sats"
staload "array.sats"

(*
  Partition an array by a pivot chosen by the user. The static types
  provide the following guarantees:
    - The resulting array at pointer l is of length n
    - That the array is partitioned by a pivot
    - That the pivot in the resulting array is the element xs[piv] which
      the user gave as the desired pivot.
      
  Props may be added to assure that the result is a permutation of
  the original array, but this example is verbose enough :D
*)
extern
fun {a:t@ype}
partition {l:addr} {xs:stmsq} {pivot,n:nat | pivot < n} (
  array_v (a, l, xs, n) | p: ptr l, int pivot, int n
): [p:nat | p < n]
   [ys: stmsq | partitioned (ys, p, n);
    select(xs, pivot) == select (ys, p)]
  (array_v (a, l, ys, n) | int p)
  
(*

We first swap the desired pivot to the last spot in the array. Then we
start at i=0  and maintain a partition index. Any  element to the left
of this index  is <= a[n-1] (the  pivot). Any element to  the right of
this index,  up until the current  element i, must be  greater than or
equal to the pivot.

part_left and part_right are two predicates defined
to enforce these invariance.

(define-fun part-left ((a (Array Int Int)) (pindex Int) (last Int))
  (forall ((i Int))
    (=> ( and (<= 0 i) (< i pindex) )
      (<= (select a i) (select a last)))))
      
(define-fun part-left ((a (Array Int Int)) (i Int) (pindex Int) (last Int))
  (forall ((j Int))
    (=> ( and (<= pindex j) (j < i))
      ((select a last) <= (select a j)))))

If we encounter an element less than the pivot, we swap it with the
current pindex and increment pindex by one.

When we're all done, and i = n - 1, we've reached the pivot, and so from
our loop invariants, if we swap the pointer at n-1 with pindex, we'll have
an array partitioned by the desired pivot. As an added bonus, we have a
termination metric to enforce the loop to terminate.

*)

macdef succ1 = ptr1_succ


implement {a}
partition {l}{xs}{pivot,n} (pf | p, pivot, n) = let
  val pi = add_ptr_int<a>(p , pivot)
  val pn = add_ptr_int<a>(p , (n - 1))
  val () = array_ptrswap<a> {l}{..}{..}{pivot, n-1} (pf | pi, pn)
  val xn = array_ptrget<a> {l}{..}{..}{n-1} (pf | pn)
  //
  fun loop {ps:stmsq} {i, pind: nat | pind <= i; i <= n-1 |
    part_left (ps, pind, n-1);
    part_right (ps, i, pind, n-1);
    select (ps, n-1) == select (xs, pivot)
  } .<n-i>. (
    pf: array_v (a, l, ps, n) | 
      pi: ptr (l+i*sizeof(a)), pind: ptr (l+pind*sizeof(a))
  ): [ys:stmsq]
     [p:nat | p < n;
      partitioned (ys, p, n); select (ys, p) == select (xs, pivot)] (
    array_v (a, l, ys, n) | int p
  ) =
    if pi = pn then let
      val () = array_ptrswap<a>{l}{..}{..}{pind,n-1}(pf | pind, pn)
    in 
      (pf | ptr_offset<a>{l}{pind}(pind)
    end
    else let
      val xi = array_ptrget<a> {l}{..}{..}{i} (pf | pi)
    in
      if xi < xn then let
          val () = array_ptrswap<a> {l}{..}{..}{i, pind}(pf | pi, pind)
        in
          loop {swap_at(ps,i,pind)}{i+1, pind+1} (pf | add_ptr_int<a>(pi,1), add_ptr_int<a>(pind, 1))
        end
      else
        loop {ps} {i+1,pind} (pf | add_ptr_int<a>(pi,1), pind)
    end
  //
in loop {swap_at(xs,pivot,n-1)} {0,0} (pf | p, p) end

extern
fun rand_int {n:nat} (int n): [s:nat | s < n] int s

absprop PARTED (a:t@ype, l:addr, xs: stmsq, p:int, n:int)

extern
praxi 
PARTED_make 
  {l:addr}{a:t@ype}
  {n,p:nat | p < n}
  {xs:stmsq | partitioned (xs, p, n)}
(!array_v (a, l, xs, n), int p): PARTED(a, l, xs, p, n)

extern
praxi partitioned_lemma
  {l:addr}{a:t@ype}
  {xs:stmsq} {p,n:nat | p < n}
  {ls,rs:stmsq} (
  PARTED(a, l, xs, p, n),
  !array_v (a, l, ls, p),
  !T(a, select(xs, p)) @ l+p*sizeof(a),
  !array_v (a, l+((p+1)*sizeof(a)), rs, n - p - 1)
): [
  lte (ls, p, select(xs, p)); lte (select(xs, p), rs, n - p - 1)
] void

(* ****** ****** *)

fun {a:t@ype}
quicksort {l:addr} {xs:stmsq} {n:nat} .<n>. (
  pf: array_v (a, l, xs, n) | p: ptr l, n: int n
): [ys:stmsq | sorted (ys, n)] (
  array_v (a, l, ys, n) | void
) =
  if n <= 1 then
    (pf | ())
  else let
    val pivot = rand_int (n)
    val (pf | pi) = partition (pf | p, pivot, n)
    val parted = PARTED_make (pf, pi)
    //
    prval (left, right) = array_v_split (pf, pi)
    prval array_v_cons (pfpiv, right) = right
    //
    val (left  | ()) = quicksort (left | p, pi)
    val nxt = add_ptr_int<a> (p, pi)
    val (right | ()) = quicksort (right | add_ptr_int<a>(nxt, 1), n - pi - 1)
    
    //
    prval () = partitioned_lemma (parted, left, pfpiv, right)
    //
    prval (pf) = array_v_unsplit (left, array_v_cons (pfpiv, right))
  in
    (pf | ())
  end