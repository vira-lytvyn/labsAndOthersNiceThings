#include <iostream>

using namespace std;

int main ()
{
	int count = 0;
	char line [] = "Lytvyn Vira Vasylivna 19 FEI-32 Electronics\0";
	for ( int i = 0; i < 1000; i++)
	{
		if (( line [i] == ' ') || (line [i] == ',')) 
		{
			count ++;
		}			
		if ( line [i] == '\0')
		{
			break;
		}
	}
	count+=1;
	cout << count<< endl;
	return 0;
}

	
		

	



