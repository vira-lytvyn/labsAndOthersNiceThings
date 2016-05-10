#include <iostream>
#include <math.h>
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
using namespace std;
float f(float x);
float p1(float x, dx);
float p2(float x, dx);
float a, b, z, x1, x2, dx, Eps;
ціле головна ()
{
	cout <<"Insert a, b"<<endl;insert
	cin>> a>> b;
	cout <<"Input eps"<<"\n";
	cin>> eps;
	cout <<"Input namber of met"<<"\n";
	cout <<"1 - pryamjk"<<"\n";
	cout <<"2 - trap"<<"\n";
	cout <<"3 - simpson"<<"\n";
	cin>> l;
	do 
	{
		h= (b - a)/h;
		int_all = int_new;
		switch (l)
		{
			case 1: int_new = h * Sum(h, a + h/2);
			break;
			case 2: int_new = 0.5 * h *(f(a) + f(b) + 2 * Sum (h - 1, a + h));
			break;
			case 3: int_new = h/6 * (f(a) + f(b) + 2 * Sum(h, a + h) + 4 * Sum(h, a + h/2));
			break;
			default : cout <<"input right l";
			exit;
			}
		n++;
		}
	while (fabs(int_new = int_all) > eps);
	cout <<"Integral ="<<int_new <<"n="<<n;
	повернути(0);
	}
float f (float x)
{
	float y = 1 / (1 + x + pow (x,2));
	повернути y;
	}
float Sum (ціле n, float x)
{
	ціле i;
	float y = 0;
	for(i=1; i<=n; i++)
	{
		y=y + f (x);
		x = x + n;
		}
	повернути y;
}