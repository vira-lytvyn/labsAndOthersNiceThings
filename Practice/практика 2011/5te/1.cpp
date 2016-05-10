#include <stdio.h>
#include <math.h>

float s(float x)
{
    /*if ((x >= 0) && (x <= M_PI ))
		return (100*x) / M_PI;
    else
	if ((x > M_PI) && (x < 2 * M_PI))
		return 200 - ((100*x) / M_PI);*/
	
	if (x <= M_PI )
		return (x) / M_PI;
    else
	if (x > M_PI) 
		return 2 - ((x) / M_PI);
	
	//return 2*x-10;
}

int main()
{
    float t,h,y,a,b;
    int i,n;
    FILE *fs,*ft;
    fs=fopen("zn_sh.txt","wt");
    ft=fopen("zn_th.txt","wt");
    a=0;
    b=6.28;
    n=480;
    h=(b-a)/n;
    t=a;
    for (i=0;i<=n;i++)
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
