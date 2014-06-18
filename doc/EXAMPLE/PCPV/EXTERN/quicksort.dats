staload "stampseq.sats"
staload "array.sats"

staload _ = "array.dats"

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
  array_v (a, l, xs, n) | p: ptr l, size_t (pivot), size_t (n)
): [p:nat | p < n]
   [ys: stmsq | partitioned (ys, p, n);
    select(xs, pivot) == select (ys, p)]
  (array_v (a, l, ys, n) | size_t (p))

// assume T(a:t@ype, x: stamp) = a

fun {a:t@ype}
compare_ptr_ptr {p,q:addr}{x,y:stamp} (
  pfp: !T(a,x) @ p, pfq: !T(a,y) @ q | p: ptr p, q: ptr q
): int (sgn(x - y)) = let
  val x = ptr_get0<a>(pfp | p)
  val y = ptr_get0<a>(pfq | q)
in
  compare (x, y)
end

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
      partitioned(ys, p, n); select (ys, p) == select (xs, pivot)] (
    array_v (a, l, ys, n) | size_t (p)
  ) =
    if eq_ptr_int<a>{l}{i,n-1} (pi, pn) then let
      val () = array_ptrswap<a>{l}{..}{..}{pind,n-1}(pf | pind, pn)
    in 
      (pf | ptr_offset<a>{l}{pind}(pind))
    end
    else let
      (**
        Though the following is fairly verbose, I really
        like how programming with theorem proving is used
        here to prove that:
        
          -  my pointer arithmetic is safe
          -  the result accomplishes the goal of the algorithm
              (i.e. the array that lies at address l is a partitioned array)
      *)
      //
      prval (front, last) = array_v_split (pf, n-1)
      prval array_v_cons (pfn , ns) = last
      prval (pff, pfis) = array_v_split (front, ptr_offset<a>{l}{i}(pi))
      prval array_v_cons (pfi, pfiss) = pfis
      //
      val sgn = compare_ptr_ptr (pfi, pfn | pi, pn)
      //
      prval front = array_v_unsplit (pff, array_v_cons(pfi, pfiss))
      prval last = array_v_cons (pfn, ns)
      prval () = pf := array_v_unsplit (front, last)
      //
    in
      if sgn < 0 then let
          val () = array_ptrswap<a>{l}{..}{..}{i, pind}(pf | pi, pind)
        in
          loop {swap_at(ps,i,pind)}{i+1, pind+1} (
            pf | succ_ptr_t0ype<a>(pi), succ_ptr_t0ype<a>(pind)
          )
        end
      else
        loop {ps} {i+1,pind} (pf | succ_ptr_t0ype<a>(pi), pind)
    end
  // end of [loop]
in loop {swap_at(xs,pivot,n-1)} {0,0} (pf | p, p) end

extern
fun rand_int {n:nat} (size_t (n)): [s:nat | s < n] size_t (s)

absprop Parted (a:t@ype, l:addr, xs: stmsq, p:int, n:int)

extern
praxi 
Parted_make 
  {l:addr}{a:t@ype}
  {n,p:nat | p < n}
  {xs:stmsq | partitioned (xs, p, n)}
(!array_v (a, l, xs, n), size_t (p)): Parted(a, l, xs, p, n)

extern
praxi partitioned_lemma
  {l:addr}{a:t@ype}
  {xs:stmsq} {p,n:nat | p < n}
  {ls,rs:stmsq} (
  Parted(a, l, xs, p, n),
  !array_v (a, l, ls, p),
  !T(a, select(xs, p)) @ l+p*sizeof(a),
  !array_v (a, l+((p+1)*sizeof(a)), rs, n - p - 1)
): [
  lte (ls, p, select(xs, p)); lte (select(xs, p), rs, n - p - 1)
] void

(* ****** ****** *)

fun {a:t@ype}
quicksort {l:addr} {xs:stmsq} {n:nat} .<n>. (
  pf: array_v (a, l, xs, n) | p: ptr l, n: size_t (n)
): [ys:stmsq | sorted (ys, n)] (
  array_v (a, l, ys, n) | void
) =
  if n <= 1 then
    (pf | ())
  else let
    val pivot = rand_int (n)
    val (pf | pi) = partition (pf | p, pivot, n)
    prval parted = Parted_make (pf, pi)
    //
    prval (left, right) = array_v_split (pf, pi)
    prval array_v_cons (pfpiv, right) = right
    //
    val (left  | ()) = quicksort (left | p, pi)
    val nxt = add_ptr_int<a> (p, pi)
    val (right | ()) = quicksort (right | succ_ptr_t0ype<a>(nxt), n - pi - 1)
    //
    prval () = partitioned_lemma (parted, left, pfpiv, right)
    //
    prval (pf) = array_v_unsplit (left, array_v_cons (pfpiv, right))
  in
    (pf | ())
  end
  
(* ****** ****** *)
  
(**
  We can use the templated version above to implement a function
  in the standard C Library while also verifying its functional 
  correctness.
  
  We make use of local template instantiation
  in order to support this.
*)

typedef compare_fn(a:t@ype) = {l1,l2:addr} {x1,x2:stamp}
  (T(a, x1) @ l1, T(a, x2) @ l2 | ptr (l1), ptr (l2)) -> int (sgn(x1-x2))

extern
fun libc_qsort {a:t@ype}{l:addr}{xs:stmsq}{n:int} (
  pf: array_v (a, l, xs, n) |
    ptr l, size_t (n), size_t (sizeof(a)), compare_fn (a)
): void = "#ext"