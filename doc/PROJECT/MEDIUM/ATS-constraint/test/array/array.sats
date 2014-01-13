datasort array = (*abstract*)

stacst array_sub : (array, int(*begin*), int(*end*)) -> array
stadef subarray = array_sub

stacst array_select : (array, int(*index*)) -> t@ype
stadef select = array_select

stacst array_store : (array, int(*index*), t@ype) -> array
stadef store = array_store

(* 
  I'm not sure how to express permutation in the SMT solver's
  interface...
*)
stacst permutation : (array, array) -> bool

stacst partitioned_array : (
  array, int(*start0*), int(*stop0*), int(*start1*), int(*stop1*)
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