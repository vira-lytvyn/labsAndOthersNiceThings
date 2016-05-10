#include <iostream>
#include <math.h>
using namespace std;
float a, b, c, d, x1, x2;
int main ()
{	
	cout<<"Input a, b, c"<<endl;
	cin>> a>> b>> c;
	if ((a == 0) && (b == 0))
	{
		cout<<"rivnanna e nesymisne"<<endl;
		return 0 ;
	}
	if ((a == 0) && (c == 0))
	{
		cout <<"x1=0";
		return 0 ;
	}
	if ((b == 0) && (c == 0))
	{
		cout <<"x1 = x2 = 0"<<endl;
		return ( 0 ) ;
	}	
	if (a == 0)
	{
		cout <<"rivnannay ne e kvadratne i mae odun korin"<<"\t";
		x1 = -c/b;
		cout <<"x1 = "<<x1<<endl;
		return ( 0 ) ;
	}
	if ((b == 0)&&((a < 0) && (c < 0)) || ((a > 0)&&(c > 0)))
	{
		cout<<"diisnyh rozvazkiv nemaje"<<endl;
		return ( 0 ) ;
	}	
	d = b * b - 4 * a * c;
	if ( d < 0 )
	{
		cout<<"diisnyh rozvazkiv nemaje"<<endl;
		return ( 0 ) ;
	}
	if ( d == 0 )
	{
		x1 = (-b)/(2*a);
		cout <<"1 rozvazok: x= "<<x1<<endl;
		return ( 0 ) ;
	}
	x1 = ( - b - sqrt (d) ) / ( 2 * a );
        x2 = ( - b + sqrt (d) ) / ( 2 * a );
        cout<<"2 rozvazky:\t"<<x1<<"\t"<<x2<<endl;
        return ( 0 ) ;
}