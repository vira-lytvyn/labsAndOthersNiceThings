#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void main()
{
	float h,z,zn;
	int t[364],i;
	FILE *fd,*fc;
	z=3*3.14/2;
	h=6.28/365;
	fd=fopen("dani.txt","wt");
	fc=fopen("data","w");
	for (i=0;i<365;i++)
	{
		z=z+h;
		zn=30*sin(z)+random(11)-random(6);
		t[i]=ceill(zn);
		fprintf(fd,"%i\n",t[i]);
		fprintf(fc,"%i\n",t[i]);
	}
	fclose(fd);
	fclose(fc);
}
