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
fun
partition {l:addr} {xs:stmsq} {pivot,n:nat | pivot < n} (
  array_v (l, xs, n) | p: ptr l, int pivot, int n
): [p:nat | p < n]
   [ys: stmsq | partitioned (ys, p, n); 
    select(xs, pivot) == select (ys, p)]
  (array_v (l, ys, n) | int p)

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


implement
partition {l}{xs}{pivot,n} (pf | p, pivot, n) = let
  val pi = p + pivot
  val pn = p + (n - 1)
  val () = array_ptrswap {l}{..}{..}{pivot, n-1} (pf | pi, pn)
  val xn = array_ptrget {l}{..}{..}{n-1} (pf | pn)
  //
  fun loop {ps:stmsq} {i, pind: nat | pind <= i; i <= n-1 |
    part_left (ps, pind, n-1);
    part_right (ps, i, pind, n-1);
    select (ps, n-1) == select (xs, pivot)
  } .<n-i>. (
    pf: array_v (l, ps, n) | pi: ptr (l+i), pind: ptr (l+pind)
  ): [ys:stmsq] 
     [p:nat | p < n;
      partitioned (ys, p, n); select (ys, p) == select (xs, pivot)] (
    array_v (l, ys, n) | int p
  ) =
    if pi = pn then let
      val () = array_ptrswap {l}{..}{..}{pind,n-1}(pf | pind, pn)
    in 
      (pf | ptr_offset{l}{pind}(pind))
    end
    else let
      val xi = array_ptrget {l}{..}{..}{i} (pf | pi)
    in
      if xi < xn then let
          val () = array_ptrswap {l}{..}{..}{i, pind}(pf | pi, pind)
        in
          loop {swap_at(ps,i,pind)}{i+1, pind+1} (pf | pi+1, pind+1)
        end
      else
        loop {ps} {i+1,pind} (pf | pi+1, pind)
    end
  //
in loop {swap_at(xs,pivot,n-1)} {0,0} (pf | p, p) end