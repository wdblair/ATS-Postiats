#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "constraint.sats"
staload "solving/solver.sats"

staload ERR = "solving/error.sats"

(* ****** ****** *)

typedef s2cast_fun_type = (&env, s2explst) -<fun1> formula

local
  vtypedef env = smtenv  
  typedef tfun = s2cast_fun_type
  
  assume s2cfunmap = s2cstmap (tfun)
  
  var the_s2cfunmap: s2cfunmap = s2cstmap_nil ()
in
  val the_s2cfunmap =
    ref_make_viewptr (view@ (the_s2cfunmap) | addr@ (the_s2cfunmap))
end

extern
fun constraint3_initialize_map (map: &s2cfunmap): void

implement constraint3_initialize () = let
  prval (vbox pf | p) = ref_get_viewptr (the_s2cfunmap)
in
  $effmask_ref (constraint3_initialize_map (!p))
end

implement constraint3_initialize_map (map) = let
  typedef tfun = s2cast_fun_type
in
end

(* ****** ****** *)