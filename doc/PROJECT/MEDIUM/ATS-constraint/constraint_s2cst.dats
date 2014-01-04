(*
** Implementing Static Constants
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./constraint.sats"

(* ****** ****** *)

typedef
s2cst_struct = @{
  s2cst_name= symbol
, s2cst_stamp= stamp
, s2cst_srt= s2rt
} (* end of [s2cst_struct] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
assume s2cst_type = ref (s2cst_struct)
//
in (* in of [local] *)

implement
s2cst_make
  (name, stamp, srt) = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<s2cst_struct> ()
//
val () = p->s2cst_name := name
val () = p->s2cst_stamp := stamp
val () = p->s2cst_srt := srt
//
in
  $UN.castvwtp0{s2cst}((pfat, pfgc | p))
end // end of [s2cst_make]

implement
s2cst_get_name
  (s2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (s2c)
in
  p->s2cst_name
end // end of [let]
) (* end of [s2cst_get_name] *)

implement
s2cst_get_stamp
  (s2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (s2c)
in
  p->s2cst_stamp
end // end of [let]
) (* end of [s2cst_get_stamp] *)

implement
s2cst_get_srt
  (s2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (s2c)
in
  p->s2cst_srt
end // end of [let]
) (* end of [s2cst_get_srt] *)

end // end of [local]

(* ****** ****** *)

implement
fprint_s2cst
  (out, s2c) =
  fprint! (out, s2c.name, "(", s2c.stamp, ")")
// end of [fprint_s2cst]

(* ****** ****** *)

implement
compare_s2cst_s2cst
  (s2c1, s2c2) = compare (s2c1.stamp, s2c2.stamp)
// end of [compare_s2cst_s2cst]

implement
equal_s2cst_s2cst
  (s2c1, s2c2) = s2c1.stamp = s2c2.stamp
// end of [equal_s2cst_s2cst]

implement
equal_string_s2cst 
  (name, s2c) = let
    val name = symbol_make (name)
in
  name = s2cst_get_name (s2c)
end // end of [equal_string_s2cst]

(* ****** ****** *)

(* end of [constraint_s2cst.dats] *)
