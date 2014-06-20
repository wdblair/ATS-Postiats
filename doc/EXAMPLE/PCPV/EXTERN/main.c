#include <stdio.h>
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

int main () {
  
  int buf[10] = {10, 9 , 8 , 7, 6, 5 ,4 , 3, 2, 1};
  
  libc_qsort (buf, 10, sizeof(int), cmp_int);
  
  for (int i = 0; i < 9; i++) {
    assert(buf[i] < buf[i+1]);
    assert(buf[i] == buf[i+1] - 1);
  }

  printf("Sorting test passed!\n");
}
