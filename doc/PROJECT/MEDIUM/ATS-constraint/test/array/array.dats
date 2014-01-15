staload "array.sats"

extern
fun 
random_int_range {start,stop:int} (
  int start, int stop
): [s:int | start <= s; s <= stop] int s

extern
fun {a:t@ype}
partition {start,stop,i,n:int | stop < n}
  {buf: array} (
  &array (a, n, buf) >> array (a, n, buf'), int i, int start, int stop
): #[buf':array]
    [
      p:nat | start <= p; p <= stop;
      partitioned (buf', start, p, stop)
    ] int p

extern
fun swap {a:t@ype} {buf:array} {i,j,n:int} (
  &array (a, n, buf) >> array (a, n, swap (buf,i,j)), int i, int j
): void

implement {a}
partition {start,stop,i,n} {buf} (buf, i, start, stop) = let
  // Swap the pivot with the last element
  val () = swap (buf, i, stop)
  fun loop (): [p:int | partitioned (buf,start,p,end)] int p
in
  
end
  
////

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