#include <stdio.h>
#include <math.h>
#include <graphics.h>

const int n=480, ng=20;
int main()
{
    int i,k;
    float t[n],sign[n],a[ng],b[ng],w,tp,s[n];
    FILE *fa,*fbk,*ft,*fsm,*fsign;
    ft=fopen("zn_th.txt","rt");
	fsign=fopen("zn_sh.txt","rt");
    for (i=0;i<n;i++)
    {
        fscanf(ft,"%f",&t[i]);
	    fscanf(fsign,"%f",&sign[i]);
    }
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
    
    initgraph();
    line(0,200,640,200);
	for(i=0;i<n-1;i++)
	{
		putpixel(ceil(100*t[i]), ceil(100*s[i])+100,BLACK);
		line(ceil(100*t[i]), -ceil(100*sign[i])+200,ceil(100*t[i+1]), -ceil(100*sign[i+1])+200);
	}
    closegraph();
    
    return 0;
}
