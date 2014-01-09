(*
  An interface that aims to  extend the statics to  handle fixed
  width bit vectors.
*)

(*
  We can  declare an abstract  sort by using the  datasort declaration
  and not providing any constructors along with it.
  
  From the perspective of the external constraint solver, the sort will
  just be called "bv8". In our parser, we can turn this into a bitvector
  of lenght 8.
*)
datasort bv8 = (*abstract*)

(*
  Z3 can transform an integer into a fixed width bit vector. I'm not
  sure about other SMT solvers.
*)
stacst bv8_of_int: (int) -> bv8
stadef bv8 = bv8_of_int

stacst and_bv8_bv8: (bv8, bv8) -> bv8
stadef land = and_bv8_bv8

stacst sub_bv8_bv8: (bv8, bv8) -> bv8
stadef - = sub_bv8_bv8

stacst equal_bv8_bv8: (bv8, bv8) -> bool
stadef == = equal_bv8_bv8

abst@ype uint8_t0ype (b:bv8)
typedef uint8 (b:bv8) = uint8_t0ype (b)

(*
  A number n is a power of two iff (n & (n -1)) = 0
*)
stadef power_of_two
  (b:bv8) = (b land (b - bv8(1))) == bv8(0)
  
(*
  Check whether a number is a power of two. Any implementation
  is now obligated to be equivalent to our definition of what
  makes a power of two.
*)
fun is_power_of_two {n:bv8} (uint8 (n)): bool (power_of_two (n))

fun land_bv8_bv8 {l,r:bv8} (
  uint8 (l), uint8 (r)
): uint8 (l land r) = "mac#"
overload land with land_bv8_bv8

fun sub_bv8_bv8 {l,r:bv8} (
  uint8 (l), uint8 (r)
): uint8 (l - r) = "mac#"
overload - with sub_bv8_bv8

fun equal_bv8_bv8 {l,r:bv8} (
  uint8 (l), uint8 (r)
): bool (l == r)
overload = with equal_bv8_bv8

symintr bv8 

castfn bv8_of_int {n:int} (uint n): uint8 (bv8 (n))

overload bv8 with bv8_of_int
