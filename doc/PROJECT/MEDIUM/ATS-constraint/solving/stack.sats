(**
  An interface for a stack.
*)

absvtype stack (a:vtype)

fun stack_nil {a:vtype} (): stack (a)

fun stack_listize {a:vtype} (stack (a)): List0_vt (a)

fun stack_push {a:vtype} (&stack (a)): void

fun stack_pop {a:vtype} (&stack (a)): Option_vt (a)