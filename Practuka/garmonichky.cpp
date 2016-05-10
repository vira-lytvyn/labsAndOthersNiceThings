#include <iostream>
#include <math.h>
#include <graphics.h>
#include <stdio.h>
#include <conio.h>
typedef float Vector1 [640];
typedef float Vector2 [480];
float f(float x);
void Furje(Vector1 X, Vector2 Y, double Tp, Vector2 Yg);
int i,k;
float w,KOM,s,G,D;
double Tp;
Vector1 X, a;
Vector2 Y, Yg, b;
int main()
{
	int i;
	initgraph();
	line(1,1,1,480);
	line(1,240,640,240);
	for ( i=0; i<=500; i++)
	{
		Y[i] = f(X[i]);
		X[i+1] = X[i]+0.01;
	}
	putpixel ( ceil ( 100 * X [ i ] ), ceil ( 100 * Y [ i ] + 240 ) ) ;
	Furje(X,Y,Tp,Yg);
	for ( int k=0; k<25; k++)
	{
		KOM=k*w;
		G=0;
		D=0;
		for (i=0; i<500; i++)
		{
			s=KOM*X[i];
			G=G+Y[i]*cos(s);
			D=D+Y[i]*sin(s);
		}
		a[k]=20*G/500;
		printf("%f\n",a[k]);
		b[k]=2*D/500;
	}
	
        closegraph();
    return 0;
}
float f(float x)
{
  //  if (%(i))
	return 2*x;
}
void Furje(Vector1 X, Vector2 Y, double Tp, Vector2 Yg)
{
    w=2*M_PI/Tp;
    for (k=0; k<25; k++)
    {
        KOM=k*w;
        G=0;
        D=0;
        for (i=0; i<500; i++)
        {
            s=KOM*X[i];
            G=G+Y[i]*cos(s);
            D=D+Y[i]*sin(s);
        }
        a[k]=2*G/500;
        b[k]=2*D/500;
    }
    a[0]=0;
    for (i=0; i<500; i++)
        a[0]=a[0]+Y[i];
    a[0]=a[0]/500;
    for (i=0; i<500; i++)
    {
        s=0;
        D=X[i]*w;
        for (k=0; k<25; k++)
        {
            KOM=k*D;
            s=s+b[k]*sin(KOM)+a[k]*cos(KOM);
        }
        Yg[i]=a[0]+s;
    }
}
