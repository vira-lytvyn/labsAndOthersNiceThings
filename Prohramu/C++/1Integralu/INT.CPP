#include <iostream.h>
#include <math.h>
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
float f(float x);
float Sum(int n, float x);
float h;
int main ()
{
	clrscr();
	float a, b, eps; 
	float int_new;
	float int_old;
   	int_new=0;
	int_old=0;
	int n, l;
	int repeat = 1;
	cout <<"Input a, b"<<"\n";
	cin>> a>> b;
	cout <<"Input eps"<<"\n";
	cin>> eps;
	do
	{
	cout <<"Input n"<<"\n";
	cin>> n;
	cout <<"\n Input number of met"<<"\n";
	cout <<"1 - pryamjk"<<"\n";
	cout <<"2 - trap"<<"\n";
	cout <<"3 - simpson"<<"\n";
	cout <<"or other digit for exit"<<"\n";
	cin>> l;
	h= (b - a)/n;
	switch (l)
		{
			case 1: int_new = h * Sum(n, a + h/2);
			break;
			case 2: int_new = 0.5 * h *(f(a) + f(b) + 2 * Sum (n - 1, a + h));
			break;
			case 3: int_new = h/6 * (f(a) + f(b) + 2 * Sum(n, a + h) + 4 * Sum(n, a + h/2));
			break;
			default : repeat=0;
			break;
		}
	do
	{
		n++;
		int_old=int_new;
		h= (b - a)/n;
		switch (l)
		{
			case 1: int_new = h * Sum(n, a + h/2);
			break;
			case 2: int_new = 0.5 * h *(f(a) + f(b) + 2 * Sum (n - 1, a + h));
			break;
			case 3: int_new = h/6 * (f(a) + f(b) + 2 * Sum(n, a + h) + 4 * Sum(n, a + h/2));
			break;
			default : repeat=0;
            break;
		}
	}
	while (fabs(int_new - int_old) > eps);
	if(repeat==0)
		break;
	else
		cout <<"Integral = "<<int_new <<"\t n="<<n<<"\n"//;
	}
	while(repeat==1);
	return(0);
	}
float f (float x)
{
	float y = 1 / (1 + x + pow (x,2));
	//float y = x;
	return y;
	}
float Sum (int n, float x)
{
	int i;
	float y = 0;
	for(i=1; i<=n; i++)
	{
		y=y + f (x);
		x = x + h;
	}
	return y;
}