#include <stdio.h>
#include <math.h>
const int n=1000, ng=20;
int main()
{
    int i,k;
    float t[n],a[ng],b[ng],w,tp,s[n];
    FILE *fa,*fbk,*ft,*fsm;
    ft=fopen("zn_t.txt","rt");
    for (i=0;i<n;i++)
        fscanf(ft,"%f",&t[i]);
    fclose(ft);
    fa=fopen("zn_ak.txt","rt");
    fbk=fopen("zn_bk.txt","rt");
    for (i=0;i<ng;i++)
    {
        fscanf(fa,"%e",&a[i]);
        fscanf(fbk,"%e",&b[i]);
    }
    fclose(fa);
    fclose(fbk);

    tp=t[n-1]-t[0];
    w=2*M_PI/tp;
    fsm=fopen("zn_sm.txt","wt");
    for (i=0;i<n;i++)
    {
        s[i]=a[0]/2;
        for (k=1;k<ng;k++)
            s[i]+=a[k]*cos(k*t[i]*w)+b[k]*sin(k*t[i]*w);
        fprintf(fsm,"%f\n",s[i]);
    }
    fclose(fsm);
    return 0;
}
