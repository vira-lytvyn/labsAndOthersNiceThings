#include <iostream>
#include <string.h>

using namespace std;

int main()
{
	char line [] = "Lytvyn Vira Vasylivna 19 FEI-32 Electronics ";
	int k = 0;
	int m = 0;
	for ( int i = 0; i < 1000; i++)
	{
		if ( line [i] == ' ') 
		{
			k = i;
			for (int j = m; j < k; j++)
			{
				cout << line[j];
			}
			cout << endl;
			m = k + 1;
			//delete(line,0,k);
		}			
		if ( line [i] == '\0')
		{
			break;
		}
	}
	int b;
	cin>> b;
	return 0;
}