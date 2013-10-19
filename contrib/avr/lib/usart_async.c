/*
  The internal buffer for the interrupt driven serial interface.
*/
#include "CATS/cycbuf.cats"

cycbuf_t read_buffer  = {NULL, NULL, 0, 128, [0 ... 127] = 0};
cycbuf_t write_buffer = {NULL, NULL, 0, 128, [0 ... 127] = 0};
