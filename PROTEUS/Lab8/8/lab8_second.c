#include <stdio.h>  
#include <REG52.H>  

//Start pins

sbit RW = P3^5;  
sbit RS = P3^6;  
sbit EN = P3^7;  
sbit BUSY = P1^7;

//End pins region

unsigned char STATE;

 //Delay function
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

//Clean whole lcd display
void clear_lcd(void)  
{
	EN = 1;
	RS = 0;
	RW = 0;
	P1 = 0x01;
	EN = 0;
	wait_lcd();  
}  

//Add char to lcd
void write_char(unsigned char *c1)  
{
	EN = 1;
	RS = 1;
	RW = 0;
	P1 = *c1;
	EN = 0;
	wait_lcd();  
}

// Main logic
 
void main(void)  
{
	// Data preparation

	idata char buf[16];

	idata char buf2[16];

	char *pbuf = buf;

	char *pbuf2 = buf2;

	int bytes, cnt;
	 
	int marker1 = 0;

	int marker2 = 0;

	int DelayTo = 50;

	// End Data preparation

	// Start main logic
	while (1)
	{
		pbuf = buf;

		pbuf2 = buf2;

		bytes = sprintf(buf, "%s", "LABORATORNA_JOB"); // Save text for viewing

		init_lcd();	   // Start lcd
		clear_lcd();   // Clean lcd

		for (cnt = 0; cnt < marker1; cnt++)
	    	write_char(' ');  // Add empty cell
		for (cnt = 0; cnt < bytes - marker1; cnt++)
			write_char(pbuf++);
		marker1 = marker1 + 1;
		if (marker1 > bytes - 1)
		{
			marker1 = 0;		  // Start again
		}

		s_lcd();  // Transfotm to second line on lcd

		bytes = sprintf(buf2, "%s", "LCD_INFORMATION"); // Save second text for viewing
		for (cnt = 0; cnt < marker2; cnt++)
	    	write_char(' '); 	// Add empty cell
		for (cnt = 0; cnt < bytes - marker2; cnt++)
			write_char(pbuf2++);

		marker2 = marker2 + 1;

		if (marker2 > bytes - 1)
		{
			marker2 = 0;		// Start again
		}

		delay(DelayTo);
	}
	while(1);  
}