%{#
#include "CATS/cycbuf.cats"
%}

viewtypedef cycbuf_t (
  a:t@ype, n:int, s:int, w: addr, r: addr
) = $extype_struct "cycbuf_t" of {
  pfwrite= a @ w,
  pfread=  a @ r,
  w= ptr w,
  r= ptr r,
  n = uint n,
  size= uint s,
  data= @[a][s]
}