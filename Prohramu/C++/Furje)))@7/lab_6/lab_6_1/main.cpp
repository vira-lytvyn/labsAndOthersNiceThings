#include <stdio.h>
#include <math.h>

float s(float t)
{
    if (t<=500)
        return 4e-6*t;
    else
    if (t>500)
        return -4e-6*t+4e-3;
}

int main()
{
    float t,h,y,a,b;
    int i,n;
    FILE *fs,*ft;
    fs=fopen("zn_s.txt","wt");
    ft=fopen("zn_t.txt","wt");
    a=0;
    b=1000;
    n=1000;
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
