/*
  The internal buffer for the interrupt driven serial library.
*/
#include "CATS/cycbuf.cats"

cycbuf_t inbound = {NULL, NULL, 0, 128, [0...127=0]};
cycbuf_t outbound;
