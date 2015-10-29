#include <atmel/at89x51.h>

void delay (int msec)
{
	volatile long i ;
	int n = msec * 10 ;
	for (i = 0 ; i < n ; ++i) ;
}
char number[4]={0xf1,0xf2,0xf4,0xf8};

char digit[4] = {0, 0, 0, 0};

char g_dig = 0 ;

void show_digit()
{
	#define A  (1<<0)
	#define B  (1<<1)
	#define C  (1<<2)
	#define D  (1<<3)
	#define E  (1<<4)
	#define F  (1<<5)
	#define G  (1<<6)
	#define DP (1<<7)

	const digits [10] = 
	{
		~(A | B | C | D | E | F) , // 0
		~(B | C) , // 1
		~(A | B | G | E | D) , // 2
		~(A | B | C | G | D) , // 3
		~(F | G | B | C), // 4
		~(A | F | G | C | D), //5
		~(A | F | E | D | C | G), // 6
		~(A | B | C), // 7
		~(A | B | C | D | E | F | G), // 8
		~(A | B | C | D | F | G) // 9
	} ;
	P3=digits[g_dig];
}

typedef struct 
{
	char delay ;
	char status ;
} button_status ; 

void digit_calc(unsigned int t)
{
	unsigned int temp,res;
 	temp=t;
 	res=temp/1000;			
 	digit[3]=res;
 	temp=temp-res*1000;
 
 	res=temp/100;			
 	digit[2]=res;
 	temp=temp-res*100;
 
 	res=temp/10;			
 	digit[1]=res;
 	temp=temp-res*10;
 
 	digit[0]=temp;		
}
				   
void main ()
{
	unsigned int t;
	button_status bs1, bs2 ;
	char start ;
	char i ;
	unsigned int z, s ;
	bs1.delay = 0 ;	
	bs1.status = 0 ;
	bs2.delay = 0 ;
	bs2.status = 0 ;	 
	P2 = 0x00 ;	
	P1 = 0x03;		 
	t = 1234 ;
	start = 0;
	i = 0;
	z=0;
	s=1234;
	while(1)
	{		
			P2 = ~number[i];
			digit_calc(t);
			g_dig=digit[i];	
				
			show_digit();
			delay(25);			
			//for(z=0;z<2000;z++);	 
			if (++i==4) 
			{
				i=0;
				t=t+start;
				if (t==10000) t=0;
			}		 
		
				//*****       start		  *****
		if ((P1 & 0x01) == 0 && bs1.status == 0) // pressed
		{
			if (bs1.delay == 0) 
			{
				bs1.delay = 10 ;
			}
			else
			{
				-- bs1.delay ;
				if (bs1.delay == 0)
				{
					bs1.status = 1 ;
				}
			}
		}
		if ((P1 & 0x01) == 1 && bs1.status == 1) //released
		{
			if (bs1.delay == 0)
			{
				bs1.delay = 10 ; 
			}
			else
			{
				-- bs1.delay ;
				if (bs1.delay == 0)
				{
					bs1.status = 0 ;
					start=1;
				}				
			}
		}
				//*****      stop	  *****
		if ((P1 & 0x02) == 0 && bs2.status == 0) // pressed
		{
			if (bs2.delay == 0) 
			{
				bs2.delay = 10 ;
			}
			else
			{
				-- bs2.delay ;
				if (bs2.delay == 0)
				{
					bs2.status = 1 ;
				}
			}
		}
		if ((P1 & 0x02) == 0x02 && bs2.status == 1) //released
		{
			if (bs2.delay == 0)
			{
				bs2.delay = 10 ; 
			}
			else
			{
				-- bs2.delay ;
				if (bs2.delay == 0)
				{
					bs2.status = 0 ;
					start=0;
				}				
			}
		}

					
	}		
}


