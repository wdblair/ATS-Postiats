(*
** A test for atspkgreloc
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define
ATS_PACKNAME "atspkgreloc_test02"

(* ****** ****** *)
//
require
"{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/SATS/intinf_vt.sats"
//
(* ****** ****** *)

staload "{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/SATS/intinf.sats"
staload T = "{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/SATS/intinf_t.sats"
staload _ = "{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/DATS/intinf_t.dats"
staload _ = "{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/DATS/intinf_vt.dats"

(* ****** ****** *)

fun
fact{i:nat}
(
  x: int (i)
) : $T.Intinf = let
in
//
if x = 0
  then $T.int2intinf(1)
  else let
    val r1 = fact (x - 1)
  in
    $T.mul_int_intinf (x, r1)
  end // end of [else]
// end of [if]
//
end // end of [fact]

(* ****** ****** *)

overload print with $T.print_intinf

(* ****** ****** *)

implement
main0 () = () where
{
//
val N = 100
val () = println! ("fact(", N, ") = ", fact(N))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)
