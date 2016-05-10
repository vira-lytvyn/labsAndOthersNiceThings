//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
float Xe[640];
float Ye[640];
float *Xg; float *Yg;
int L, g, t, j, gx0, gy0, i,Ne,Ngr,krokx,kroky,mx,my;
float al,bl,hg,h,krx,kry,MaxX,MaxY,MinX,MinY,kx,ky,zx,zy,gx,gy,ax,by,cx,cy;
float xx,yy;

/*void rozrah( float al, float bl, int Ne, int Ngr) //var Xe,Ye,Yg :Vector );
{
	h = ( bl - al ) / ( Ne - 1 );
	Xe [ 0 ] = al;
	for (i = 0; i < (Ne - 1); i++)
		{
		 // Ye [ i ] = f ( Xe [i]);
		  Xe [ i + 1 ] = Xe [ i ] + h;
		}
	al = Xe [ 0 ];
	bl = Xe [Ne - 1];
	//Fur (Xe, Ye, Ne, Yg);
	L = 15;
	MinX = Xe [ 0 ];
	MaxX = Xe [Ne - 1];
	MinYg =Yg[0];
	MaxYg =Yg[0];
	for (i=0; i < (Ngr - 1); i++)
	  {
		if (MaxYg<Yg[i])
			MaxYg = Yg[i];
		if (MinYg>Yg[i])
			MinYg = Yg[i];
	  }
	MinY = Ye[0];
	MaxY = Ye[0];
	for (i = 0; i < (Ne - 1); i++)
	  {
		if (MaxY<Ye[i])
			MaxY:=Ye[i];
		if (MinY>Ye[i])
			MinY:=Ye[i];
	  }
	if (MaxY<MaxYg)
		MaxY=MaxYg;
	if (MinY>MinYg)
		MinY=MinYg;
	Kx = (Form2.Image1.ClientWidth-2*L)/(MaxX-MinX);
	Ky = (Form2.Image1.ClientHeight-2*L)/(MinY-MaxY);
	Zx =( Form2.Image1.ClientWidth*MinX-L*(MinX+MaxX))/(MinX-MaxX);
	Zy = (Form2.Image1.ClientHeight*MaxY-L*(MinY+MaxY))/(MaxY-MinY);
	if  (MinX*MaxX<=0)
		Gx =0;
	if ( minX*MaxX>0)
		Gx =MinX;
	if (( MinX*MaxX>0)and(MinX<0))
		Gx =MaxX;
	if ( MinY*MaxY <=0)
	Gy =0;
	if ((MinY*MaxY>0)and(MinY>0))
		Gy =MinY;
	if ((MinY*MaxY>0)and(MinY<0))
		Gy =MaxY;
	ay  = Kx * Gx + Zx;
	bx  = Ky * Gy + Zy;
} */
/*void Gratka();
{
       with Form2.Image1.Canvas do
		 {
          Pen.Color:=clteal;
          pen.Width:=2;
          MoveTo(L,Round(bx));
          LineTo(Round(Form2.Image1.ClientWidth-L),Round(bx));
          MoveTo(Round(ay),L);
          lineTo(Round(ay),Form2.Image1.ClientHeight-L);
            KrokX:=(Form2.Image1.ClientWidth-2*L)div 10;
  			KrokY:=(Form2.Image1.ClientHeight-2*L)div 10;
          for i:=0 to 10 do
		  {
          	Pen.Color:=clteal;
          	pen.Width:=1;
          	pen.Style:=psDot;
          	MoveTo(L,L+i*KrokY);
          	LineTo(Form2.Image1.ClientWidth-L,L+i*KrokY);
          	MoveTo(L+i*KrokX,L);
          	LineTo(L+i*KrokX,Form2.Image1.ClientHeight-L);
			}
          Krx:=(MaxX-MinX)/10;
          Kry:=(MaxY-MinY)/10;
          xx:=minx;
          yy:=maxy;
          For i:=0 to 10 do
			  {
               Pen.Color:=clblack;
               Pen.Style:=psdash;
               TextOut(L+i*KrokX+10,Round(Ky*Gy+Zy)-L+10,FloatToStrF(xx,ffGeneral,0,0));
               TextOut(Round(Kx*Gx+Zx)-25,L+i*KrokY+25,FloatToStrF(yy,ffGeneral,0,0));
               XX:=XX+KrX;
               yy:=yy-KrY;
			  }
	   }
}  */


/*
void LAGRANG (float al, float bl, int Ngr)
{
	try {
		 Xg = new float [Ngr];
		 Yg = new float [Ngr];
		 hg = (bl - al) / Ngr;
		 Xg[0] = al;
		 for (i = 0; i < Ngr -1; i++) {
			 Yg [i] = I_L ( Xg [i]);
			 Xg [i+1] = Xg [ i ] + hg;
		 }
	}
	catch(EConvertError &e)
	{
	   ShowMessage("Шановний користувач, ви ввели не коректні дані");
	}
}    */

void __fastcall TForm1::BitBtn1Click(TObject *Sender)
{
	al = StrToFloat( Edit1->Text);
	bl = StrToFloat( Edit2->Text);
	Ne = StrToInt( Edit3->Text);
	Ngr = StrToInt( Edit4->Text);

	/*if (KL = 0)
	{
	for (i = 0; i < (Ne - 1); i++) {
			R = Ye [i];
			for (j = 0; j < (Ne - 1); j++) {
				if (i!=j) {
					R = R / (Xe [i] - Xe [j])
				}
		}
		KP [i] = R;
	}
	KL = 1;
	}
	S = 0;
	for (i = 0; i < (Ne - 1); i++) {
		R = KP [i];
		for (j = 0; j< (Ne - 1); j++) {
			if (i != j) {
				R - R * (X - Xe [j])
			}
		}
		S = S + R;
	}
	I_L = S;  */
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
	delete Xg [];
	delete Yg [];
}
//---------------------------------------------------------------------------

