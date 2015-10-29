#include <stdio.h>  
#include <REG52.H>  

sbit RW = P3^5;  
sbit RS = P3^6;  
sbit EN = P3^7;  
sbit BUSY = P1^7;

unsigned char STATE;

void delay(int N) 
{
	int  k; 
	for (k=0; k<N; k++) 
	{
		TMOD=0x01;
		TH0=0xD8;
		TL0=0xF0;
		TR0=1;
		while (!TF0)
		{};
		TR0=0;
		TF0=0;
	}  
} 

void wait_lcd(void)  
{  
	do 
	{
		EN = 1;
		RS = 0;
		RW = 1;
		P1 = 0xFF;
		STATE = BUSY;
		EN = 0;
	} 
	while (STATE != 0);
	RW = 0;  
}

void s_lcd(void)
{
	EN = 1;
	RS = 0;
	RW = 0;
	P1 = 0xC0;
	EN = 0;
	wait_lcd();
}

void init_lcd(void)  
{  
	EN = 1;
	RS = 0;
	RW = 0;
	P1 = 0x38;
	EN = 0;
	wait_lcd();
	EN = 1;
	RS = 0;
	RW = 0;
	P1 = 0x0E;
	EN = 0;
	wait_lcd();
	EN = 1;
	RS = 0;
	RW = 0;
	P1 = 0x06;
	EN = 0;
	wait_lcd();  
}

void clear_lcd(void)  
{
	EN = 1;
	RS = 0;
	RW = 0;
	P1 = 0x01;
	EN = 0;
	wait_lcd();  
}  

void write_char(unsigned char *c1)  
{
	EN = 1;
	RS = 1;
	RW = 0;
	P1 = *c1;
	EN = 0;
	wait_lcd();  
}
  
void main(void)  
{
	idata char buf[16];
	idata char buf2[16];
	char *pbuf = buf;
	char *pbuf2 = buf2;
	float f1 = 3.141592;
	int bytes, cnt;
	int step1 = 0;
	int step2 = 0;
	while (1)
	{
		pbuf = buf;
		pbuf2 = buf2;
		bytes = sprintf(buf, "%s", "LABORATORY_WORK");
		init_lcd();
		clear_lcd();
		for (cnt = 0; cnt < step1; cnt++)
	    	write_char(' ');
		for (cnt = 0; cnt < bytes - step1; cnt++)
			write_char(pbuf++);
		step1 = step1 + 1;
		if (step1 > bytes - 1)
		{
			step1 = 0;
		}
		if (step1 > 2 * bytes - 1)
		{
			step1 = 0;
		}
		s_lcd();
		bytes = sprintf(buf2, "%s", "LSD_INFORMATION");
		for (cnt = 0; cnt < step2; cnt++)
	    	write_char(' '); 
		for (cnt = 0; cnt < bytes - step2; cnt++)
			write_char(pbuf2++);

		step2 = step2 + 1;

		if (step2 > bytes - 1)
		{
			step2 = 0;
		}

		//delay(100);
	}
	while(1);  
}