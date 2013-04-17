staload "pats_smt_solver.sats"

(* ****** ****** *)

local
  abstype config
in
  implement make_context () = ctx where {
    val conf = $extfcall(config, "Z3_mk_config")
    val ctx = $extfcall(context, "Z3_mk_context_rc", conf)
  }
end

