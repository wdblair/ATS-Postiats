/**
   This is quicksort copied from quicksort.dats.

   The idea  here is  to show  that it's  fairly easy  to just  copy a
   solution from one language to another. Arriving at this program (or
   more complicated ones) without the reasoning tools we provide in ATS
   would be much more difficult, as incremental changes to any program
   can't  be  checked against  a  formal specification. Instead,
   runtime testing and debuggers can be used, but they don't provide
   the guarantees that we can provide statically.
*/
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

void swap (int *a, int *b) {
  int tmp = *a;

  *a = *b;
  *b = tmp;
}

int partition (int *ar, int p, int n) {
  int *pn;
  int *pi;
  int *pindex;

  pn = ar + (n - 1);
  pi = ar + p;
  
  swap (pi, pn);

  int xn = *pn;
  
  for(pi = ar, pindex = ar; pi != pn; pi++)
    if (*pi < xn)
      swap (pi, pindex++);
  
  swap (pindex, pn);

  return pindex - ar;
}

void quicksort (int *ar, int n) {
  if (n <= 1) {
    return;
  }
  int pivot = (int) rand () % n;
  
  int p = partition (ar, pivot, n);
  
  quicksort (ar, p);
  quicksort (ar+p+1, n-p-1);
}

int main () {
  srand (time (NULL));

  int buf[10] = {10, 9 , 8, 7, 6, 5, 4, 3, 2, 1};
  
  quicksort (buf, 10);

  for (int i = 0; i < 10; i++) {
    printf ("%d ,", buf[i]);
  }

  printf ("\n");

  return 0;
}
