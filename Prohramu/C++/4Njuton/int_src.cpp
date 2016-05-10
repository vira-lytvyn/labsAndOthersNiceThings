#include <iostream>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
using namespace std;
float f(float x);
float p1(float x, float dx);
float p2(float x, float dx);

int main ()
{
	float a, b, z, x1, dx, eps, Dx;
	int k, kmax;
	cout <<"vvedit dodatni mezi a, b"<<endl;
	cin>> a>> b;
	if (( a < 0 ) || ( b < 0 )) 
	{
		cout<<"Shanovnuy korustyvach, vvedeni mezi ne korektni"<<endl;
		return ( 0 );
	}
	cout <<"vvedit tochnist eps=  ta maksymalnu kilkist iteratsij Kmax="<<endl;
	cin>> eps>> kmax;
	if ( eps <= 0 )
	{
		cout <<"vvedena tochnist je nekorektnojy"<<endl;
		return ( 0 );
	}
	if (a > b)
	{
		z = a;
		a = b;
		b = z;
	}	
	dx = 0.00001;
	x1=b;
	if ( f ( b ) * p2 ( b, dx ) < 0 )
	{
		x1=a;
		if ( f ( a ) * p2 ( a, dx ) < 0 ) 
		{
			cout<<"Dlya zadanoho rivnannya zbiznist ne harantujetsa";
		}
	}
	for(k=0; k<kmax;k++)
	{
		Dx = f ( x1 ) / p1 ( x1, dx );		
		x1 = x1 - Dx;	
		if(fabs(Dx)<eps)
		{
			cout<<"korin x="<<x1<<"\tznajdeno za k= "<<k<<"\titerazij"<<endl;
			break;
		}
		if (( k == kmax - 1 ) && (fabs(Dx) > eps))
			cout <<"Za zadany kilkist podiliv znajty korin ne vdalosya"<<endl;
	}		
	
}
float f (float x)
{
	//float y = 3 * x - 4 * log ( x ) - 5;
	return 3 * x - 4 * log ( x ) - 5;//x*x-4;
	}
float p1(float x, float dx)
	{
		float y = ( f ( x + dx ) - f ( x ) ) / dx;
		return y;
}
float p2(float x, float dx)
	{
		float y = ( f ( x + dx ) + f ( x - dx ) - 2 * f ( x ) ) / ( dx * dx );
		return y;	
}