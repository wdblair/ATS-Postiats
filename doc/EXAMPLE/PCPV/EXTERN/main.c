#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include <assert.h>

/**
   Here we demonstrate our code being used as a normal libc
   function in your typical C code.
*/
extern
void libc_qsort (void *base, size_t nmemb, size_t size,
                 int (*cmp)(const void *, const void *));

int cmp_int (const void *x, const void *y) {
  int ix = *(const int*)x;
  int iy = *(const int*)y;
  
  return ix - iy;
}

#define N 1048576

int main () {
  int *buf = calloc(N, sizeof(int));
  
  assert(buf != NULL);

  for (int i = 0; i < N; i++) {
    buf[i] = (int)random() % INT_MAX;
  }
  
  libc_qsort (buf, N, sizeof(int), cmp_int);
  
  for (int i = 0; i < (N - 1); i++) {
    assert(buf[i] <= buf[i+1]);
  }
  
  printf("Sorting test passed!\n");
}
