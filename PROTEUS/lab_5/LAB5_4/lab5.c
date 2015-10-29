#include <stdio.h>
#include <math.h>
#include "REG51.h"
void delay (int N)
{ int k;
for (k=0; k<N; k++)
{ TMOD=0x01;
TH0=0xD8;
TL0=0xF0;
TR0=1;
while (!TF0) {};
TR0=0;
TF0=0;
}
}
void main ()
{ int N,l;
while (1) {
if (P3!=0xFB)
{
N=25;
for (l=0;l<8;l++)
{
P1 = pow(0x02,l); 
delay (N);
}
}
else
{
N=50;
for (l=7;l>0;l--)
{
P1 = pow(0x02,l); 
delay (N);
}
}
}
return;
}