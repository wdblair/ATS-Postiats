staload "array.sats"

typedef Array (l:addr, a:t@ype, n:int) = [buf:array] array (l, a, n, buf)

(*
(* A fully sorted array *)
typedef SortedArray (l:addr, a:t@ype, n:int) = [buf:array | sorted(buf, 0, n-1)] array (l, a, n, buf)

(* An only partially sorted with the first i elements sorted. *)
typedef PartialSortedArray (l:addr, a:t@ype, i: int, n:int) = [buf:array | sorted(buf, 0, i-1)] array (l, a, i, n, buf)
*)
(*
  This is still too verbose, but I can cut it down.
*)

fun {a:t@ype}
insertion_sort {l:addr} {buf:array} {n:nat} (
  arr: array (l, a, n , buf), n: int n
): [buf': array | sorted (buf', n-1)] array (l, a, n, buf') =
if n <= 1 then
  arr
else let
  fun loop {buf:array} {i:pos | i <= n | sorted (buf, i-1)} .<n-i>. (
    arr: array (l, a, n, buf), i: int i
  ): [buf':array | sorted(buf', n-1)] array (l, a, n, buf') =
    if i = n then
      arr
    else let
      //
      fun {a:t@ype}
      inner_loop {j:int | ~1 <= j; j < i} .<j+1>. {buf:array |
        (*
          The meaning of this predicate is that the sub array i in [0,j] is sorted and
          at i is less then or equal to an element k in (j+1,i]. This allows us to slide 
          the current value into its sorted position and state the final array is indeed 
          sorted from the interval i-1+1 = i
        *)
        sorted_split (buf, 0, j+1, i)
      } (
        arr: array (l, a, n, buf), j: int j
      ): [buf':array | sorted (buf', i)] array (l, a , n, buf') =
        if j = ~1 then
          arr
        else if arr[j] <= arr[j+1] then
          arr
        else let
          val next = swap (arr, j, j+1)
        in
          inner_loop (next, j-1)
        end
      //
      val arr = inner_loop (arr, i-1)
    in
      loop (arr, i+1)
    end
  //
in
  loop (arr, 1)
end