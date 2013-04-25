// Showing that 2x + 2y = 1 is unsatisfiable
extern
praxi _2x2y {x,y:int | x*2 + y*2 != 1} (
  x: int x, y: int y
): void

extern
fun getint (): [n:int] int n

//
val x = getint()
val y = getint()
//

prval _= _2x2y (x, y)