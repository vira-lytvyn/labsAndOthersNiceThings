#include <iostream>

using namespace std;

int Words_my ( char line [])
{
	int count = 0;
	int k = 0;
	for ( int i = 0; i < 1000; i++)
	{
		if (( line [i] == ' ') || (line [i] == ','))
		{
			count ++;
		}			
		k = i;
		if ( line [i] == '\0')
		{
			break;
		}
	}
	if ( k == 1)  
	{
		if (( line [k - 1] == ' ') || (line [k - 1] == ','))
		{
			return 0;
		}
		else 
		{
			return 1;
		}
	}
	count = count + 1;
	return count;
}

int main()
{
	char line [] = "Lytvyn Vira Vasylivna 19 FEI-32 Electronics\0";	
	//char line [] = " ";
	int count = Words_my(line);
	cout << "Kil'kict' sliv - " << count << endl;
	int b;
	cin>> b;
	return 0;
}

