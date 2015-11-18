/**
 * Sample 2 popen.c
 * Give some orders to vdisp by using popen.
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void)
{
	FILE *fp;
	int i, j;

	if ((fp=popen("bin/vdisp", "w")) == NULL) {
		exit(1);
	}

	i = 0;
	while (i < 20) {
		j = 0;
		while (j < 80) {
			fprintf(fp, "%d %d a\n", i, j);
			j += 1;
		}
		fprintf(fp, "/update\n");
		i += 1;
	}
	pclose(fp);

	return 0;
}
