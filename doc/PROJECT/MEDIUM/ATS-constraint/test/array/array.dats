staload "array.sats"

extern
fun random_int_range {start,stop:nat} (
  int start, int stop
): [s:nat | start <= s; s <= stop] int s

extern
fun {a:t@ype}
partition {start,stop,i,n:nat | start <= i; i <= stop; stop < n} {buf: array} (
  &array (a, n, buf) >> array (a, n, buf'), int i, int start, int stop
): #[buf':array]
    [
      p:nat | start <= p; p <= stop;
      partitioned (buf', start, p, p+1, stop)
    ] int p
    
implement {a}
quicksort_sub_array (arr, start, stop) = let
  val len = stop - start
in
  if len <= 1 then
    ()
  else let
    val p = random_int_range (start, stop)
    val pivot = partition (arr, p, start, stop)
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
    quicksort_sub_array (arr, start, left_stop);
    quicksort_sub_array (arr, right_start, stop);
  end
end
