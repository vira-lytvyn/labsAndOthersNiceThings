#include <stdio.h>
#include <REG52.H>
sbit RW = P3^5;
sbit RS = P3^6;
sbit EN = P3^7;
sbit BUSY = P1^7;
unsigned char STATE;
void wait_lcd (void)
{
	do {
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
	P1 = 0x0F;
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
void s_lcd(void)
{
	EN = 1;
	RS = 0;
	RW = 0;
	P1 = 0xC0;
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
	//float f1 = 3.141592;
	int bytes, cnt, delay;
	//bytes = sprintf(buf, "%s", "PI == ");
	//bytes += sprintf(buf + bytes, "%8.6f\n", f1);
	bytes = sprintf(buf, "%s", "LABARATORNA_WORK");
	init_lcd();
	clear_lcd();
	//delay = 0;
	for (cnt = 0; cnt < bytes; cnt++)
	{	  	
		//delay = 0;
		write_char(pbuf++);
		//while(delay < 3000)
		//{
			//delay++;
		//}
		//if (cnt = bytes - 1)
		//{
			//cnt = 0;
			//clear_lcd();
		//}
	}
	s_lcd();
	bytes = sprintf(buf2, "%s", "INFORMATION_LCD");
	for (cnt = 0; cnt < bytes; cnt++)
	{
		write_char(pbuf2++);
	}
	while(1);
}