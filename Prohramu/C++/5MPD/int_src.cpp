#include <iostream>
#include <math.h>
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
using namespace std;
float f(float x);

int main()
{
	float a, b, c, z, eps;
	int k, kmax;
	cout <<"Vvedit korektni DODATNI mezi a, b"<<endl;
	cin>> a>> b;
	cout <<"vvedit tochnist eps=  ta maksymalnu kilkist podiliv Kmax="<<endl;
	cin>> eps>> kmax;
	if (( a < 0 ) || ( b < 0 )) 
	{
		cout<<"Shanovnuy korustyvach, vam potribni okylyaru"<<endl;
		return ( 0 );
	}
	if (fabs ( b - a ) < ( 2 * eps ))
	{
		cout<<"vvedeni mezi nadto mali"<<endl;
		return ( 0 );
	}
	if ( eps <= 0 )
	{
		cout <<"vvedena tochnist je ne korektnojy"<<endl;
		return ( 0 );
	}
	if ( kmax < 0 )
	cout <<"Shanovnuy korustyvach, kilkist podiliv ne moze bytu vidjemna"<<endl;
	if ( a == b )
	{
		if (fabs ( f ( a ) ) < eps)
		cout<<"Vvedena vamu tochka je korenem rivnaynnay"<<endl;
		else
		cout<<"vvedeni mezi je nekorektni"<<endl;
		return ( 0 );
	}
    	if (a > b)
	{
		z = a;
		a = b;
		b = z;
	}
	k = 0;
	if (fabs ( f ( a ) ) < eps) 
	{
		cout<<"korenem je meza a= "<<"\t"<<a<<endl;
		return ( 0 );
	}
	else
	if (fabs ( f ( b ) ) < eps) 
	{
		cout<<"korenem je meza b= "<<"\t"<<b<<endl;
		return ( 0 );
	}
	for(k=0; k<kmax;k++)
	{
		c = (a + (0.5 * ( b - a ))) ;
		k = k + 1;
		if ( f ( a ) * f ( c ) > 0 ) 
			a = c; 
		else 
			b = c;
		if(fabs ( f ( c ) ) < eps)
		{
			cout<<"korin x="<<"\t"<<c<<"  znajdeno za k= "<<"\t"<<k<<"  podiliv"<<endl;
			break;
		}
		if (( k == kmax - 1 ) && (fabs ( f ( c ) )))
			cout <<"Za zadany kilkist podiliv znajty korin ne vdalosya"<<endl;
	}
	return 0;
}
float f(float x)
{
	return x*x-4;
}