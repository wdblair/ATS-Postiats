staload _ = "prelude/DATS/integer.dats"

(**
  Check the orderedness of a list
*)
fun
ordered (xs: List0(int)): bool = let
  fun loop (y: int, ys: List0(int)): bool =
    case+ ys of
      | list_nil () => true
      | list_cons (z, zss) =>
        if y > z then
          false
        else
          loop (z, zss)
in
    case+ xs of 
      | list_nil () => true
      | list_cons (x, xss) => loop (x, xss)
end // end of [ordered]

(* ****** ****** *)

staload "./list.sats"
staload "./stampseq.sats"

(* ****** ****** *)

// 
(* ****** ****** *)

absprop SORTED (xs:stmsq, n:int)

extern
praxi
SORTED_elim
  {xs:stmsq}{n:int}
  (pf: SORTED(xs, n)): [sorted(xs, n)] void
//
extern
praxi
SORTED_nil(): SORTED (nil, 0)
extern
praxi
SORTED_sing{x:stamp}(): SORTED (sing(x), 1)
extern
praxi
SORTED_cons
  {x:stamp}
  {xs:stmsq}{n:pos}
  {x <= select(xs,0)}
  (pf: SORTED (xs, n)): SORTED (cons(x, xs), n+1)
extern
praxi
SORTED_uncons
  {x:stamp}
  {xs:stmsq}{n:pos}
  (pf: SORTED (cons(x, xs), n)): [x <= select(xs,0)] SORTED (xs, n-1)
//
extern
praxi
SORTED_uncons
  {x:stamp}{xs:stmsq}{n:pos}
  (pf: SORTED (cons(x, xs), n)): [x <= select(xs,0)] SORTED (xs, n-1)
//
(* ****** ****** *)

// assume T(a:t@ype, xs:stamp) = a

(* ****** ****** *)
//
extern
fun {a:t@ype} insord
  {x0:stamp}
  {xs:stmsq}{n:nat}
(
  pf: SORTED(xs, n) | x0: T(a, x0), xs: list (a, xs, n)
) : [i:nat]
(
  SORTED (insert(xs, i, x0), n+1) | list (a, insert(xs, i, x0), n+1)
)
//
(* ****** ****** *)

implement {a}
insord {x0}{xs}{n} (pf | x0, xs) =
(
case+ xs of
| list_nil () =>
    #[0 | (SORTED_sing{x0}() | list_cons (x0, list_nil))]
| list_cons {..} {xs1}{x} (x, xs1) =>
  (
    if x0 <= x
      then
        #[0 | (SORTED_cons{x0}{xs} (pf) | list_cons (x0, xs))]
      else let
        prval (pfs) = SORTED_uncons {x}{xs1} (pf)
        val [i:int] (pfres | ys1) = insord {x0} (pfs | x0, xs1)
      in
        #[i+1 | (SORTED_cons{x} (pfres) | list_cons (x, ys1))]
      end // end of [if]
    // end of [if]
  )
) (* end of [insort] *)

(* ****** ****** *)

extern
fun {a:t@ype} sort
  {xs:stmsq}{n:int}
  (xs: list (a, xs, n)): [ys:stmsq] (SORTED (ys, n) | list (a, ys, n))

implement {a}
sort (xs) =
(
case+ xs of
| list_nil () =>
    (SORTED_nil() | list_nil())
| list_cons (x, xs1) => let
    val (pf1 | ys1) = sort (xs1) in insord (pf1 | x, ys1)
  end // end of [list_cons]
) (* end of [sort] *)

(* ****** ****** *)

implement main0 () = let
  val xs = $list{int} (10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
  val xs = list_stampseq_of_list (xs)
  (** 
    Need to implement a comparison operator
  *)
  extern
  castfn _t {a:t@ype} {xs:stamp} (T(a, xs)): a
  //
  implement lte_T_T<int> {x1,x2} (x, y) =
    let
      val lt = _t{int}(x) <= _t{int}(y)
      extern castfn bless (
        bool
      ): bool (x1 <= x2)
  in
      bless (lt)
  end
  //
  val (pfsorted | xs) = sort<int> (xs)

  val xs = list_of_list_stampseq{int} (xs)
in
  assert(ordered (xs));
  println! ("sort test passes!")
end // end of [main0]

(* end of [list_insort.dats] *)
