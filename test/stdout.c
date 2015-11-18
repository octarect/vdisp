/**
 * Sample 1 stdout.c
 * Command vdisp to show characters by standard-output.
 */
#include <stdio.h>

int main(void)
{
  int i, j;

  for (i = 0; i < 5; i++)
    for (j = 0; j < 5; j++)
      printf("%d %d @\n", i, j);

  printf("/update\n");

  return 0;
}
