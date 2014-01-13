datasort array = (*abstract*)

stacst array_select : (array, int(*index*)) -> t@ype
stadef select = array_select

stacst array_store : (array, int(*index*), t@ype) -> array
stadef store = array_store

(* 
  I'm not sure how to express a permutation in the SMT solver's
  interface...
*)
stacst permutation : (array, array) -> bool

stacst partitioned_array : (
  array, int(*start*), int (*pivot*), int(*stop*)
) -> bool
stadef partitioned = partitioned_array

stacst sorted_array : (array, int(*begin*), int(*end*)) -> bool
stadef sorted = sorted_array

abstype array (a:t@ype, n:int, buf: array) = ptr

fun {a:t@ype}
quicksort_sub_array {n:nat}
  {start,stop:nat | start <= stop; stop < n} {buf: array} (
  &array(a, n, buf) >> array(a, n, buf'),
  int start, int stop
): #[buf':array | sorted(buf', start, stop)] void

fun {a:t@ype}
quicksort {buf:array} {n:nat} (
  &array(a, n, buf) >> array(a, n, buf'), int n
): #[buf':array | sorted (buf', 0, n)] void