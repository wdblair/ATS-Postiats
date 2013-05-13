/*
  Data Structure for a Circular Buffer
*/
typedef struct {
  char *w;
  char *r;
  uint8_t count;
  char buf[];
} cycbuf_t;
