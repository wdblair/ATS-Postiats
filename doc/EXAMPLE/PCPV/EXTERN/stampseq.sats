(* ****** ****** *)
//
// HX-2014-01-25
// [stampseq]: infinte sequence of stamps
//
(* ****** ****** *)

sortdef stamp = int

(* ****** ****** *)

datasort
stampseq = (* abstract *)

(* ****** ****** *)

sortdef stmsq = stampseq

(* ****** ****** *)

stacst stampseq_nil : () -> stampseq
stacst stampseq_sing : (stamp) -> stampseq
stacst stampseq_cons : (stamp, stampseq) -> stampseq
stacst stampseq_head : stampseq -> stamp
stacst stampseq_tail : stampseq -> stampseq

(* ****** ****** *)

stadef nil = stampseq_nil
stadef sing = stampseq_sing
stadef cons = stampseq_cons
stadef tail = stampseq_tail
stadef head = stampseq_head

(* ****** ****** *)
//
stacst stampseq_get_at : (stampseq, int) -> stamp
stacst stampseq_set_at : (stampseq, int, stamp) -> stampseq
//
stadef select = stampseq_get_at
stadef update = stampseq_set_at
//
(* ****** ****** *)
//
stacst stampseq_swap_at : (stampseq, int, int) -> stampseq
//
stadef swap_at = stampseq_swap_at
//
(* ****** ****** *)

stacst stampseq_equaln
  : (stampseq, stampseq, int) -> bool
stadef equaln = stampseq_equaln

(* ****** ****** *)
//
stacst stampseq_take
  : (stampseq, int(*n*)) -> stampseq // take the first n elements
stacst stampseq_drop
  : (stampseq, int(*n*)) -> stampseq // drop the first n elements
//
(* ****** ****** *)

stadef take = stampseq_take
stadef drop = stampseq_drop

(* ****** ****** *)
//
stacst
stampseq_insert : (stampseq, int, stamp) -> stampseq
//
stacst stampseq_remove : (stampseq, int) -> stampseq
//
(* ****** ****** *)

stadef insert = stampseq_insert
stadef remove = stampseq_remove

(* ****** ****** *)

stacst stampseq_append : (stampseq, int, stampseq, int) -> stampseq
stacst stampseq_revapp : (stampseq, int, stampseq, int) -> stampseq

(* ****** ****** *)

stadef append = stampseq_append
stadef revapp = stampseq_revapp

(* ****** ****** *)

stacst lt_stamp_stampseq
  : (stamp, stampseq, int(*n*)) -> bool // stamp < stampseq[i] for i <= n
stacst lte_stamp_stampseq
  : (stamp, stampseq, int(*n*)) -> bool // stamp <= stampseq[i] for i <= n

(* ****** ****** *)

stadef lt = lt_stamp_stampseq; stadef lte = lt_stamp_stampseq

(* ****** ****** *)

stacst lt_stampseq_stamp
  : (stampseq, int(*n*), stamp) -> bool // stampseq[i] < stamp for i <= n
stacst lte_stampseq_stamp
  : (stampseq, int(*n*), stamp) -> bool // stampseq[i] <= stamp for i <= n

(* ****** ****** *)

stadef lt = lt_stampseq_stamp; stadef lte = lte_stampseq_stamp

(* ****** ****** *)

stacst stampseq_sorted : (stampseq, int) -> bool // stampseq[<n] is sorted
stadef sorted = stampseq_sorted

(* ****** ****** *)

stacst stampseq_partitioned : (stampseq, int, int, int) -> bool
stadef partitioned 
  (xs:stampseq, p: int, n:int) =  stampseq_partitioned (xs, 0, p, n-1)
  
(* ****** ****** *)

stacst
stampseq_partitioned_left :
  (stampseq, int (*pindex*), int(*pivot*)) -> bool

stadef part_left (xs: stampseq, pindex: int, pivot: int) =
  stampseq_partitioned_left (xs, pindex, pivot)

stacst
stampseq_partitioned_right :
  (stampseq, int (*i*), int (*pindex*), int(*pivot*)) -> bool
  
stadef part_right (xs: stampseq, i: int, pindex: int, pivot: int) =
  stampseq_partitioned_right (xs, i, pindex, pivot)
  
(* ****** ****** *)

(* end of [stampseq.sats] *)
