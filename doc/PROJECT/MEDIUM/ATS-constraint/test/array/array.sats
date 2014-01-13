datasort array = (*abstract*)

stacst array_sub : (array, int(*begin*), int(*end*)) -> array
stadef subarray = array_sub

stacst array_select : (array, int(*index*)) -> t@ype
stadef select = array_select

stacst array_store : (array, int(*index*), t@ype) -> array
stadef store = array_store

stacst partitioned : (
  array, int(*length*), int(*pivot*)
) -> array

stacst sorted : (array, int(*begin*), int(*end*)) -> array

abstype array (a:t@ype, n:int, buf: array) = ptr

fun {a:t@ype} 
quicksort {n:nat} {start,stop:nat | start <= stop; stop < n} {buf: array} (
  &array(a, n, buf) >> array(a, n, sorted(buf, start, stop)),
  int start, int stop
): void
