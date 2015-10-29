#include <atmel/at89x51.h>

void delay (int msec)
{
	volatile long i ;
	int n = msec * 20 ;
	for (i = 0 ; i < n ; ++i)
		;
}

char g_dig = 0 ;

void show_digit ()
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
	P0 = digits [g_dig] ;
}

void button1_click () 
{
	if (g_dig == 9)
		g_dig = 0 ;
	else
		++g_dig ;
	show_digit () ; 
}

void button2_click ()
{
	if (g_dig == 0)
		g_dig = 9 ;
	else
		--g_dig ;
	show_digit () ;
}



typedef struct 
{
	char delay ;
	char status ;
} button_status ; 

void main ()
{
	int cnt_led ;
	button_status bs1, bs2 ;

	P1 = 0x01 ;
	P2 = 0x4f ;
	//P0 = 0xb0 ;
	show_digit () ;
	P3 = 0x03 ;


	cnt_led = 0 ;

	bs1.delay = 0 ;
	bs1.status = 0 ;
	bs2.delay = 0 ;
	bs2.status = 0 ;

	for (;;)
	{
		delay (1) ;
		++ cnt_led ;
		if (cnt_led == 500)
		{
			cnt_led = 0 ;
			P1 ^= 0x01 ;
		}

		if ((P3 & 0x01) == 0 && bs1.status == 0) // pressed
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
		if ((P3 & 0x01) == 1 && bs1.status == 1) //released
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
					button1_click () ;
				}				
			}
		}
		//button2 handled
		if ((P3 & 0x02) == 0 && bs2.status == 0) // pressed
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
		if ((P3 & 0x02) == 0x02 && bs2.status == 1) //released
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
					button2_click () ;
				}				
			}
		}
	}
}
