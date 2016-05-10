#include <stdio.h>
#include <math.h>
#include <graphics.h>

const int n=480, ng=20;

float f(float x)
{
    if ((x >= 0) && (x <= M_PI ))
		return (1-x) / M_PI;
	if ((x > M_PI) && (x < 2 * M_PI))
		return 2 - (x / M_PI);
}

int main()
{
    float h,al,bl;
	float a[ng],b[ng],am,bm,tp,s[n],sg[n],w,t[n],as,bs;
    int i,n,k;
    al=0;
    bl=6.28;
    h=(bl-al)/n;
    t[0]=al;
    for (i=0;i<n;i++)
    {
        s[i]=f(t[i]);
        t[i+1]=t[i]+h;
    }
   
    am=0;
    bm=6.28;
    tp=bm-am;
    w=2*M_PI/tp;
    for (k=1;k<ng;k++)
    {
        as=0;
        bs=0;
        for (i=0;i<n;i++)
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
        a[0]=a[0]+s[i];
    }
    a[0]=a[0]*2/(n-1);	
        
    tp=t[n-1]-t[0];
    w=2*M_PI/tp;
    for (i=0;i<n;i++)
    {
        sg[i]=a[0]/2;
        for (k=1;k<ng;k++)
            sg[i]+=a[k]*cos(k*t[i]*w)+b[k]*sin(k*t[i]*w);
    }
    
    initgraph();
    //line(0,200,600,200);
	for(i=0;i<n-1;i++)
	{
		//putpixel(50*ceil(t[i]), 50*ceil(sg[i]),BLACK);
		//line(ceil(t[i]), ceil(sg[i]),ceil(t[i+1]), ceil(sg[i+1]));
	}
    closegraph();
  
    return 0;
}