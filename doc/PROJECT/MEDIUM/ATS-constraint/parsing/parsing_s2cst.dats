(*
** Parsing constraints in JSON format
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "./../constraint.sats"
//
(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

staload "./parsing.sats"
staload "./parsing.dats"

(* ****** ****** *)

extern
fun the_s2cstmap_find (stamp): s2cstopt_vt
extern
fun the_s2cstmap_insert (s2c: s2cst): void

(* ****** ****** *)

local
//
staload FM =
"libats/SATS/funmap_avltree.sats"
staload _(*FM*) =
"libats/DATS/funmap_avltree.dats"
staload _ =
"libats/DATS/qlist.dats"
//
typedef map = $FM.map (stamp, s2cst)
//
var mymap: map = $FM.funmap_nil ()
val the_s2cstmap =
  ref_make_viewptr{map} (view@mymap | addr@mymap)
//
implement
$FM.compare_key_key<stamp> = compare_stamp_stamp
//
in (* in of [local] *)

implement
the_s2cstmap_find
  (k0) = let
//
val (vbox(pf) | p) = ref_get_viewptr (the_s2cstmap)
//
in
  $effmask_ref ($FM.funmap_search_opt (!p, k0))
end // end of [the_s2cstmap_find]

implement
the_s2cstmap_insert
  (s2c0) = let
//
val k0 = s2c0.stamp
val (vbox(pf) | p) = ref_get_viewptr (the_s2cstmap)
val-~None_vt ((*void*)) = $effmask_ref ($FM.funmap_insert_opt (!p, k0, s2c0))
//
in
  // nothing
end // end of [the_s2cstmap_find]

implement the_s2cstmap_listize 
  () = let
//
val (vbox(pf) | p) = ref_get_viewptr (the_s2cstmap)
val constants = $effmask_ref (list_of_list_vt (
  $FM.funmap_listize (!p)
))
//
implement list_map$fopr<@(stamp, s2cst)><s2cst> (x) = x.1
//
//
in
  $effmask_ref ( list_of_list_vt (
    list_map<@(stamp, s2cst)><s2cst> (constants)
  ))
end // end of [the_s2cstmap_listize]

end // end of [local]

(* ****** ****** *)

implement
parse_s2cst
  (jsv0) = let
(*
val () =
println! ("parse_s2cst: jsv0 = ", jsv0)
*)
//
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "s2cst_stamp")
//
val stamp = parse_stamp (jsv2)
//
val opt = the_s2cstmap_find (stamp)
//
in
//
case+ opt of
| ~Some_vt (s2c) => s2c
| ~None_vt ((*void*)) => s2c where
  {
    val-~Some_vt (jsv1) =
      jsonval_get_field (jsv0, "s2cst_name")
    val sym = parse_symbol (jsv1)
    val-~Some_vt (jsv2) =
      jsonval_get_field (jsv0, "s2cst_srt")
    val srt = parse_s2rt (jsv2)
    val-~Some_vt (jsv3) =
      jsonval_get_field (jsv0, "s2cst_supcls")
    val supcls = parse_s2explst (jsv3)
    val s2c = s2cst_make (sym, stamp, srt)
    val () = s2cst_set_supcls (s2c, supcls)
    //
    val () = the_stamp_counter_parse_new (stamp)
    //
    val ((*void*)) = the_s2cstmap_insert (s2c)
  } (* end of [None_vt] *)
//
end // end of [parse_s2cst]

(* ****** ****** *)

(* end of [parsing_s2cst.dats] *)
