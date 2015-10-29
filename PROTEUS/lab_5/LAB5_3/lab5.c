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
{ int N;
int i,p,s; 
int l;
int sum; int del;
while (1) {
N=50;
for (l=0;l<8;l++)
{
P3 = pow(0x02,l); 
delay (N);
}
///////////////////////////////////
sum=1;
for (l=1;l<8;l++)
{
P3 = sum+pow(0x02,l);
sum=pow(0x02,l);
delay (N);
}

sum=0x02+1;
for (l=2;l<8;l++)
{
P3 = sum+pow(0x02,l);
sum=pow(0x02,l)+pow(0x02,l-1);
delay (N);
}

sum=0x04+0x02+1;
for (l=3;l<8;l++)
{
P3 = sum+pow(0x02,l);
sum=pow(0x02,l)+pow(0x02,l-1)+pow(0x02,l-2);
delay (N);
}

sum=0x08+0x04+0x02+1;
for (l=4;l<8;l++)
{
P3 = sum+pow(0x02,l);
sum=pow(0x02,l)+pow(0x02,l-1)+pow(0x02,l-2)+pow(0x02,l-3);
delay (N);
}

sum=0x10+0x08+0x04+0x02+1;
for (l=5;l<8;l++)
{
P3 = sum+pow(0x02,l);
sum=pow(0x02,l)+pow(0x02,l-1)+pow(0x02,l-2)+pow(0x02,l-3)+pow(0x02,l-4);
delay (N);
}

sum=0x20+0x10+0x08+0x04+0x02+1;
for (l=6;l<8;l++)
{
P3 = sum+pow(0x02,l);
sum=pow(0x02,l)+pow(0x02,l-1)+pow(0x02,l-2)+pow(0x02,l-3)+pow(0x02,l-4)+pow(0x02,l-5);
delay (N);
} 
 
N=30;
s=6;
sum=0x80+0x40+0x20+0x10+0x08+0x04+0x02;
for (p=0;p<7;p++)
{
  del=sum;
  for (l=8;l>s;l--)
  {
  P3 = del;
  del=del-pow(0x02,l-1)+pow(0x02,l-(s+2)); 
  delay (N);
  }
  sum=sum-pow(0x02,p+1);
  s--;
} 
  
}
return;
}