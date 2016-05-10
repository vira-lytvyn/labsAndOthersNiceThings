#include <iostream>
#include <math.h>
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
using namespace std;
float a, E, x1, x2, x3, l;
int k;
int main ()
{	
	cout <<"vvedit doslidjzyvane chuslo a= ta pohubky E="<<endl;
	cin>> a>>E;
	if ( a < 0 )
	{
		cout <<"korin ne vuznachenuj na mnozuni dijsnux chusel";
		return ( 0 );
	}
	if ( E < 0 )
	{
		cout <<"pohybka ne moze butu vidjemnoju";
		return ( 0 );
	}
	if ( a == 0 )
	{
		cout<<"korin x=0";
		return ( 0 );
        }
	cout<<"vvedit prubluzne znachennya korenya l= ";
	cin>> l ;
	x1 = l ;
	x2 = 0.5 * ( x1 + ( a / x1 ) ) ;
        	x3 = - x2 ;
	k = 1 ;
        do
	{
		x1 = x2;
		x2 = 0.5 * ( x1 + ( a / x1 ) );
		x3 = - 1 * ( x2 );
		k = k + 1;
	}
	while ( fabs ( x2 - x1 ) > E );
	if ( k == 1 ) 
		cout<<"Vu vvelu odyn iz koreniv \n";
	cout<<"koreni x1= "<<x2 <<"x2= " <<x3 <<"za k= "<<k  <<"podiliv";
	return ( 0 );
}
        
