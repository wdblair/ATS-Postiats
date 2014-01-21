staload "array.sats"

extern
fun
random_int_range {start,stop:nat} (
  int start, int stop
): [s:nat | start <= s; s <= stop] int s

extern
fun {a:t@ype} swap {l:addr} {buf:array} {i,j,n:int} (
  &array (l, a, n, buf) >> array (l, a, n, swap (buf,i,j)), int i, int j
): void

local

(* See the ATS-constraint project for these definitions. *)
stacst
partitioned_left : 
  (array, int (*start*), int (*pindex*), int(*pivot*)) -> bool

stacst
partitioned_right : 
  (array, int (*i*), int (*pindex*), int(*pivot*)) -> bool
  
in

(*
implement {a}
partition {start,stop,pivot,n} {buf} (buf, pivot, start, stop) = let
    val () = swap (buf, pivot, stop)
    //
    fun loop {buf: array} {i, pi:nat | i <= stop}  (
      buf: &array(a, n,  buf) >> array (a, n, buf'), 
      i: int i, pivotIndex: int pi
    ): #[buf': array] [p:nat] int p =
      if i = stop then let
        val () = swap (buf, pivotIndex, stop)
      in
        pivotIndex
      end
      else if buf[i] <= buf[stop] then let
        val () = swap (buf, i, pivotIndex)
      in
        loop (buf, succ(i), succ (pivotIndex))
      end
      else 
        loop (buf, succ(i), pivotIndex)
  in
    loop (buf, 0, 0)
  end
end
*)

end

extern
fun {a:t@ype}
partition {l:addr} {start, stop, pivot, n:nat
  | start <= pivot; pivot <= stop; stop < n
} {buf: array} (
  array (l, a, n, buf), int pivot, int start, int stop
): [buf':array] [p:nat | 
  start <= p; p <= stop; 
  partitioned (buf', start, p, stop)
] (array (l, a, n, buf'), int p)

absview Split (l:addr, r: addr)

(*
  This is intended to be a proof function to split a partitioned array
  into the views of the left and right sub-arrays.
*)
extern
fun {a:t@ype} split {l:addr} {n, p:int}
  {buf:array | partitioned (buf, 0, p, n - 1)}  (
  array (l, a, n, buf), int p
): [left,right: array] [r:addr]
  (Split (l,r) | array (l, a, p, left), array (r, a, n - p - 1, right))
  
stacst merged_array :
  (array, array(* left *), array (*right*), int (*pivot*), int (*n*)) -> bool
stadef merged = merged_array

(* 
  One item that's missing is using a linear type to make sure the two
  sub arrays are a permutation of the original arrays.
*)

(* 
  This is also intended to be a proof function that returns a view of an 
  array of length n + m + 1.
*)
extern
fun {a:t@ype}
merge {l,r:addr} {n,m,p:int}
  {left,right:array} (
  Split (l,r) | array (l, a, n, left), array(r, a , m, right), int p
): [final: array | merged (final, left, right, p, n+m);
  partitioned (final, 0, p, n+m)
] array (l, a, n+m+1, final)

implement {a}
quicksort (arr, n) =
if n <= 1 then
  arr
else let
  val p = random_int_range (0, n-1)
  val (parted, pivot) = partition (arr, p, 0, n - 1)
  val (pf | left, right) = split (parted, pivot)
  //
  val sorted_left  = quicksort (left, pivot);
  val sorted_right = quicksort (right, n - pivot - 1);
  //
  val new = merge (pf | sorted_left, sorted_right, pivot)
in
  new
end