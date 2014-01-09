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

stacst or_bv8_bv8: (bv8, bv8) -> bv8
stadef lor = or_bv8_bv8

stacst xor_bv8_bv8: (bv8, bv8) -> bv8
stadef xor = xor_bv8_bv8

stacst sub_bv8_bv8: (bv8, bv8) -> bv8
stadef - = sub_bv8_bv8

stacst eq_bv8_bv8: (bv8, bv8) -> bool
stadef == = eq_bv8_bv8

abst@ype uint8_t0ype (b:bv8)
typedef uint8 (b:bv8) = uint8_t0ype (b)

fun land_bv8_bv8 {l,r:bv8} (
  uint8 (l), uint8 (r)
): uint8 (l land r) = "mac#"
overload land with land_bv8_bv8

fun lor_bv8_bv8 {l,r:bv8} (
  uint8 (l), uint8 (r)
): uint8 (l lor r) = "mac#"

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
