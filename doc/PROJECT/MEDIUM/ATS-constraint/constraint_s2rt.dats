(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./constraint.sats"

(* ****** ****** *)

implement
s2rt_is_int (srt) = 
  case+ srt of
    | S2RTint () => true
    | _ =>> false

implement
s2rt_is_addr (srt) = 
  case+ srt of
    | S2RTaddr () => true
    | _ =>> false

implement
s2rt_is_bool (srt) = 
  case+ srt of
    | S2RTbool () => true
    | _ =>> false
    
(* ****** ****** *)

implement
fprint_s2rt
  (out, s2t0) = let
in
//
case+ s2t0 of
//
| S2RTint () => fprint (out, "S2RTint()")
| S2RTaddr () => fprint (out, "S2RTaddr()")
| S2RTbool () => fprint (out, "S2RTbool()")
//
| S2RTfun () => fprint (out, "S2RTfun()")
| S2RTtup () => fprint (out, "S2RTtup()")
| S2RTerr () => fprint (out, "S2RTerr()")
//
| S2RTignored () => fprint (out, "S2RTignored()")
//
end // end of [fprint_s2rt]

(* ****** ****** *)

(* end of [constraint_s2rt.dats] *)
