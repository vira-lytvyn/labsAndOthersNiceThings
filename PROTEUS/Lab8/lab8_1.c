#include <reg51.h>

#define LCD P1 
unsigned char fset = 0x38;	  		
unsigned char Cursor_ON = 0x0e;	  	
unsigned char Clear_Lcd = 0x01;	  	
unsigned char Cursor_Right = 0x06; 	
unsigned char Cursor_HOME = 0x02;	
  
sbit RW = P3^0;	
sbit RS = P3^1;	
sbit E = P3^2;	
sbit busy = P1^7;

void getReady()
{
	E = 0;
	busy = 1;
	RS = 0;	
	RW = 1;	
	while (busy == 1) 
	{
		E = 0;
		E = 1;
	}
  	E = 1;
}

void writeCmd(unsigned char cmd)
{
	getReady();
	E = 0;     
	LCD = cmd;
	RS = 0;
	RW = 0;
	E = 1;
	E = 0;
}

void init()			 

{				 
	writeCmd(fset);
	writeCmd(Cursor_ON);
	writeCmd(Clear_Lcd);
	writeCmd(Cursor_Right);
	writeCmd(Cursor_HOME);
}

void delay(int Count)
{
	int k;
	for (k=0; k<Count; k++)
	{
		TMOD=0x01;
		TH0=0xFC;
		TL0=0x28;
		TR0=1;
		while (!TF0){};
		TR0=0;
		TF0=0;
	};
} 
 
void writeString(unsigned char *str)
{
	unsigned char i;
	unsigned int j;
	getReady();
	E = 0;
	for(i=0;str[i]!='\0';i++)
	{
		LCD=str[i];
		RS = 1;
		RW = 0;
		E = 1;
		E = 0;
		for(j=0;j<7000;j++);
		delay(5);
	}
 }
 
void main(void)
{
	unsigned char l1=0x00;
	unsigned char l2=0xc0;
	unsigned char l3=0x90;
	unsigned char l4=0xd0;

	int k=0;
	init ();   		      
	for(;;)	                
  	{
		writeCmd (Clear_Lcd);
		writeCmd (l1);
 		writeString("*** FEIm-51 ***");
  		writeCmd (l2);
		writeString ("// lab8-LCD //");
		writeCmd(l3);
		writeString ("Hooray!!! :)");
		writeCmd (l4);
		writeString ("GL&HF ;)");
		delay(3);
		for(k=0;k<70000;k++);
   	}
}
