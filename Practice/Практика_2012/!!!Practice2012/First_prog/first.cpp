#include <iostream>
#include <string.h>

using namespace std;

int main()
{
	char line_inp [] = "LytvynViraVasylivna19FEI-32Elektronics";
	int i = strlen ( line_inp );
	for (int j = 0; j < i; j++)
	{	
		cout << line_inp [ j ] << endl;
	}
	int b;
	cin>> b;
	return 0;
}
