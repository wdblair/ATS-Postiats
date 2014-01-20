staload "array.sats"

extern
fun
random_int_range {start,stop:nat} (
  int start, int stop
): [s:nat | start <= s; s <= stop] int s

extern
fun {a:t@ype}
partition {start, stop, pivot, n:nat
  | start <= pivot; pivot <= stop; stop < n
} {buf: array} (
  &array (a, n, buf) >> array (a, n, buf'), int pivot, int start, int stop
): #[buf':array] [p:nat | start <= p; p <= stop; partitioned (buf', start, p, stop)] int p
    
extern
fun {a:t@ype} swap {buf:array} {i,j,n:int} (
  &array (a, n, buf) >> array (a, n, swap (buf,i,j)), int i, int j
): void

local

(* See the ATS-constraint project for these definitions. *)
stacst
partitioned_left : (array, int (*start*), int (*pindex*), int(*pivot*)) -> bool

stacst
partitioned_right : (array, int (*i*), int (*pindex*), int(*pivot*)) -> bool

in

(*
implement {a}
partition {start,stop,pivot,n} {buf} (buf, pivot, start, stop) = let
    val () = swap (buf, pivot, stop)
    //
    fun loop {buf: array} {i, pi:nat | i <= stop}  (
      buf: &array(a, n,  buf) >> array (a, n, buf'), i: int i, pivotIndex: int pi
    ): #[buf': array] [p:nat] int p =
      if i = stop then let
        val () = swap (buf, pivotIndex, stop)
      in
        pivotIndex
      end
      else if buf[i] <= buf[stop] then let
        val () = swap (buf, i, pivotIndex)
      in
        loop (buf, succ(i), succ (pivotIndex))
      end
      else 
        loop (buf, succ(i), pivotIndex)
  in
    loop (buf, 0, 0)
  end
end
*)

end

implement {a}
quicksort_sub_array (arr, start, stop) =
if start >= stop then
  ()
else let
  val p = random_int_range (start, stop)
  val pivot = partition (arr, p, start, stop)
in
  quicksort_sub_array (arr, start, pivot);
  quicksort_sub_array (arr, pivot, stop);
end