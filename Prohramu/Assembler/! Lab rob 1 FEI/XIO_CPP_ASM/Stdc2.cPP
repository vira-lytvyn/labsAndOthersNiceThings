#include <stdio.h>
#include <conio.h>

int	main ()
{
	double	a, c ;
	float	b ;
	printf ("Input A[double]  : ") ;
	scanf  ("%lf", &a) ;
	printf ("\nInput B[float]  : ") ;
	scanf  ("%f", &b) ;
	c = a + b ;
	printf ("\n %8.3lf + %8.3f = %8.3lf\n", a, b, c) ;
	getch () ;
	return 0 ;
}
