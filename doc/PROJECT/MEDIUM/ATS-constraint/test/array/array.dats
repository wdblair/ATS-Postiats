staload "array.sats"

extern
fun 
random_int_range {start,stop:nat} (
  int start, int stop
): [s:nat | start <= s; s <= stop] int s

extern
fun {a:t@ype}
partition {start,stop,i,n:nat | stop < n}
  {buf: array} (
  &array (a, n, buf) >> array (a, n, buf'), int i, int start, int stop
): #[buf':array]
    [
      p:nat | start <= p; p <= stop;
      partitioned (buf', start, p, stop)
    ] int p


implement {a}
quicksort_sub_array (arr, start, stop) =
if start >= stop then
  ()
else let
  val p = random_int_range (start, stop)
  val pivot = partition (arr, p, start, stop)
in
  quicksort_sub_array (arr, start, pivot);
  quicksort_sub_array (arr, pivot + 1, stop);
end