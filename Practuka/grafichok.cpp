#include <iostream>
#include <math.h>
#include <graphics.h>
#include <stdio.h>
#include <conio.h>
float f(float x,int p);
int main()
{
	float X[640];
	float Y[480];
	int i;
	int t=0;
	initgraph();
	for(int t=0;t<2;t++)
	{
		for ( i=0; i<100; i++)
		{
			Y[i+t*100] = f(X[i+t*100],t);
			X[i+1+t*100] = X[i+t*100]+0.01;
		}
	}
	line(1,1,1,480);
	line(1,240,640,240);
	for ( i=0; i<200; i++)
	{
		putpixel ( ceil (100* X [ i ] ), ceil (100 * Y [ i ] )) ;
	}

    closegraph();
    return 0;
}

float f(float x, int p)
{
	if ((x >= (0+ p*2*M_PI)) && (x <=( M_PI + p*2*M_PI)))
		return (1-x) / M_PI;
	if ((x > (M_PI+ p*2*M_PI)) && (x < (2 * M_PI+ p*2*M_PI)))
		return 2 - (x / M_PI);
}
