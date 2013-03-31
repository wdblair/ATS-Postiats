staload "SATS/atomic.sats"

(* 
  A FIFO interface meant to be shared between
  an ISR and application code.
*)

absviewt@ype fifo (a:t@ype, capacity: int, size:int)

fun {a:t@ype} insert {s:pos} {n:nat | n < s} (
   lpf: !atomic |
   f : &fifo(a,n,s) >> fifo(a, n+1, s), x: a
) : void

fun {a:t@ype} remove {s,n:pos | n <= s} (
  lpf: !atomic |
  f: &fifo(a,n,s) >> fifo(a, n-1, s), x: &a? >> a
) : void

fun {a:t@ype} peek {s,n:pos | n <= s} (
  lpf: !atomic |
  f: &fifo(a, n, s), x: &a? >> a
) : void

fun {a:t@ype} peek_tail {s, n:pos | n <= s} (
  lpf: !atomic |
  f: &fifo(a, n, s), x: &a? >> a
) : void

fun {a:t@ype} empty {s,n:nat | n <= s} (
  lpf: !atomic | f: &fifo(a, n, s)
) : bool (n == 0)

fun {a:t@ype} full {s,n:nat | n <= s} (
  lpf: !atomic | f: &fifo(a, n, s)
) : bool (n == s)