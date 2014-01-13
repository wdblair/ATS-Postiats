staload "array.sats"

extern
fun random_int_range {start,stop:nat} (
  int start, int stop
): [s:nat | start <= s; s <= stop] int s

extern
fun {a:t@ype} partition {n,len,i:nat | i < len; len <= n} {buf: array} (
  &array (a, n, buf) >> array (a, n, partitioned (buf, n-1, i)), int len
): void

implement {a}
quicksort {n} {..} {buf} (arr, start, stop) = let
  val len = stop - start
in
  if len <= 1 then
    ()
  else let
    val pivot = random_int_range (start, stop)
    val () = partition (arr, len)
    val left_stop =
      if pivot = start then
        pivot
      else
        pivot - 1
    val right_start = 
      if pivot = stop then
        pivot
      else
        pivot+1
  in
    quicksort (arr, start, left_stop);
    quicksort (arr, right_start, stop);
  end
end