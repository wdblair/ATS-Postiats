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
      //
      (** 
         As far as the constraint solver is concerned, there
         shouldn't be any difference between a non-linear and
         linear unboxed type. 
      *)
      | "t@ype" => S2RTt0ype ()
      // patsopt doesn't seem consistent for flat types.
      | "viewt0ype" => S2RTt0ype ()
      //
      (**
        There really should be a distinction here between flat types
        and boxed types if only because
          \forall t,s:type sizeof(t) == sizeof(s)
      *)
      | "type" => S2RTt0ype () where {
        val () = fprintln! (stderr_ref, "type encountered!")
      }
      | "viewtype" =>  S2RTt0ype () where {
        val () = fprintln! (stderr_ref, "viewtype encountered!")
      }
      | _ => let
        val () = fprintln! (stderr_ref, "Could not understand sort :", srt)
      in
        S2RTignored ()
      end
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
