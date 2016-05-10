#include <stdio.h>
#include <math.h>
const int n=1000, ng=20;

int main()
{
    int i,k;
    float a[ng],b[ng],am,bm,tp,s[n],w,t[n],as,bs;
    FILE *fa,*fbk,*ft,*fs;
    fs=fopen("zn_s.txt","rt");
    ft=fopen("zn_t.txt","rt");
    for (i=0;i<=n;i++)
    {
        fscanf(fs,"%f",&s[i]);
        fscanf(ft,"%f",&t[i]);
    }
    fclose(fs);
    fclose(ft);
    am=0;
    bm=1000;
    tp=bm-am;
    w=2*M_PI/tp;
    for (k=1;k<=ng;k++)
    {
        as=0;
        bs=0;
        for (i=1;i<=n;i++)
        {
            as=as+s[i]*cos(k*w*t[i]);
            bs=bs+s[i]*sin(k*w*t[i]);
        }
        a[k]=as*2/(n-1);
        b[k]=bs*2/(n-1);
    }
    a[0]=0;
    for (i=0;i<=n;i++)
    {
        fscanf(fs,"%f",&s[i]);
        a[0]=a[0]+s[i];
    }
    a[0]=a[0]*2/(n-1);
    fa=fopen("./zn_ak.txt","w");
    fbk=fopen("./zn_bk.txt","w");
    for (int k=0;k<=ng;k++)
    {
        fprintf(fa,"%f\n",a[k]);
        fprintf(fbk,"%f\n",b[k]);
    }
    fclose(fa);
    fclose(fbk);
    return 0;
}
