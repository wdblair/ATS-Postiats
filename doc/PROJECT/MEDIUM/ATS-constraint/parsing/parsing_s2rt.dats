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

implement
parse_s2rt
  (jsv0) = let
  val- ~Some_vt (jsv) =
    jsonval_get_field (jsv0, "s2rt_name")
  val- JSONstring (name) = jsv
in
//
case+ name of
//
| "s2rt_bas" => let
  val- ~Some_vt (jsv) =
    jsonval_get_field (jsv0, "s2rt_args")
  val- JSONstring (srt) = jsv
  in
    case+ srt of
      | "int" => S2RTint ()
      | "addr" => S2RTaddr ()
      | "bool" => S2RTbool ()
      | "rat" => S2RTrat ()
      //
      | "array" => S2RTarray ()
      | "stampseq" => S2RTarray ()
      | "infseq" => S2RTarray ()
      | "bit8" => S2RTbitvec (8)
      | _ => S2RTignored ()
  end
| "s2rt_fun" => let
  val- ~Some_vt (jsv) =
    jsonval_get_field (jsv0, "s2rt_args")
  val- JSONarray (args) = jsv
  //
  implement list_map$fopr<jsonval><s2rt> (x) =
    parse_s2rt (x)
  //
  val arguments = list_of_list_vt {s2rt} (
    list_map<jsonval><s2rt> (args)
  )
  val- ~Some_vt (jsv) =
    jsonval_get_field (jsv0, "s2rt_res")
  //
  val ret = parse_s2rt (jsv)
  in
    S2RTfun (arguments, ret)
  end
| _(*rest*) => S2RTignored ()
//
end // end of [parse_s2rt]

(* ****** ****** *)

(* end of [parsing_s2rt] *)
