datasort array = (*abstract*)

stacst array_sub : (array, int(*begin*), int(*end*)) -> array
stadef subarray = array_sub

stacst array_select : (array, int(*index*)) -> t@ype
stadef select = array_select

stacst array_store : (array, int(*index*), t@ype) -> array
stadef store = array_store

(* 
  I'm not sure how to express permutation with SMT solvers...
*)
stacst permutation : (array, array) -> bool

stacst partitioned : (
  array, int(*start0*), int(*stop0*), int(*start1*), int(*stop1*)
) -> bool

stacst sorted : (array, int(*begin*), int(*end*)) -> bool

abstype array (a:t@ype, n:int, buf: array) = ptr

fun {a:t@ype}
quicksort_sub_array {n:nat}
  {start,stop:nat | start <= stop; stop < n} {buf: array} (
  &array(a, n, buf) >> array(a, n, buf'),
  int start, int stop
): #[buf':array | sorted(buf', start, stop)] void