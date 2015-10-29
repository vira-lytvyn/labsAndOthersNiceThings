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
	} while (STATE != 0); 
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

void write_int(int num) 
{
	idata char buf[32]; 
	char *pbuf = buf; 
	int bytes, cnt; 
	init_lcd(); 
	clear_lcd(); 
	bytes = 0;
	bytes += sprintf(buf + bytes, "U = %3.2f",5*(num/255.0));  
	for (cnt = 0; cnt < bytes; cnt++) 
	     write_char(pbuf++);
}

void main(void) 
{ 
	int i ;
	while(1){ 
	    P2 = 0x00; 
		for (i=0; i< 100; i++ );
	    do{
	  	  P2 += 1;
		  for (i=0; i< 100; i++ );
	    }while(P0&0x01);
	    for (i=0; i< 1000; i++ ) ;
		 write_int(P2);	  
		for (i=0; i< 1000; i++ ) ;
	  
	}
} 