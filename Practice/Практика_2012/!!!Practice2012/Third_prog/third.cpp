#include <iostream>
#include <algorithm>

using namespace std;

int main()
{
	char Line_inp [] = "Lytvyn Vira Vasylivna 19 FEI-32 Electronics";
	int count = 0;
	for ( int i = 0; i < 1000; i++)
	{
		while ( Line_inp [i] != '\0')
		{	
			count ++;
		}
		if ( Line_inp [i] = '\0')
			{
				break;
			}
	}
	return 0;
}
char My_Reverse (char A [], int count)
{
	char B [] = "";
	for ( int i = 1; i <= count; i++)
	{
		B = copy (i-1, i+1, 1) + B; 
	}
	return 0;
}