staload "array.sats"
 
(*A normal array with a static one associated with it. *)
typedef Array (a:t@ype, n:int) = [buf:array] array (a, n, buf)

(* A fully sorted array *)
typedef SortedArray (a:t@ype, n:int) = 
  [buf:array | sorted(buf, n-1)] array (a, n, buf)

(* An array with the first i elements sorted. *)
typedef PartialSortedArray (a:t@ype, i: int, n:int) = 
  [buf:array | sorted(buf, i-1)] array (a, n, buf)
  
fun {a:t@ype}
insertion_sort {n:nat} (
  ar: Array (a, n), n: int n
): SortedArray (a, n) =
//
if n <= 1 then
  ar
else let
  //
  fun loop {i:pos | i <= n} .<n-i>. (
    part: PartialSortedArray (a, i, n), i: int i
  ): SortedArray (a, n) =
    if i = n then
      part
    else let
      //
      fun {a:t@ype}
      inner_loop {j:int | ~1 <= j; j < i} .<j+1>.
      {buf:array | sorted_split (buf, 0, j+1, i)} (
        split: array (a, n, buf), j: int j
      ): PartialSortedArray (a , i+1, n) =
        if j = ~1 then
          split
        else if split[j] <= split[j+1] then
          split
        else let
          val ar = swap (split, j, j+1)
        in
          inner_loop (ar, j-1)
        end
      //
      val p = inner_loop (part, i-1)
    in
      loop (p, i+1)
    end
  //
in
  loop (ar, 1)
end