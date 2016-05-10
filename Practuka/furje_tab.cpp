#include <stdio.h>
#include <math.h>

float s(float x)
{
    if ((x >= 0) & (x <= 3.14 ))
		return (1-x) / 3.14;
	if ((x > 3.14) & (x < 2 * 3.14))
		return 2 - (x / 3.14);
}

int main()
{
    float t,h,y,a,b;
    int i,n;
    FILE *fs,*ft;
    fs=fopen("zn_sh.txt","wt");
    ft=fopen("zn_th.txt","wt");
    a=0;
    b=480;
    n=480;
    h=(b-a)/n;
    t=a;
    for (i=0;i<n;i++)
    {
        y=s(t);
        fprintf(fs,"%f\n",y);
        fprintf(ft,"%f\n",t);
        t+=h;
    }
    fclose(fs);
    fclose(ft);
    return 0;
}
