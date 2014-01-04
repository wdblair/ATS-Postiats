(*
** ATS constaint-solving
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./constraint.sats"

(* ****** ****** *)

assume stamp_t0ype = int

(* ****** ****** *)

implement stamp_make (x) = x

(* ****** ****** *)

implement stamp_get_int (stmp) = stmp

(* ****** ****** *)

implement
fprint_stamp
  (out, stamp) = fprint_int (out, stamp)
// end of [fprint_stamp]

(* ****** ****** *)

implement
compare_stamp_stamp (s1, s2) = g0int_compare (s1, s2)

implement
equal_stamp_stamp (s1, s2) = compare (s1, s2) = 0

(* ****** ****** *)

(* end of [constraint_stamp.dats] *)
