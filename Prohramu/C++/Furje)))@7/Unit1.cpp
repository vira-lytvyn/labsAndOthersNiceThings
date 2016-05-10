//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <math.h>

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
float al,bl,h,h1,maxx,maxy,minx,miny,kx,ky,zx,zy,gx,gy,cx,cy,gx0,gy0;
int k, x, y, i,Ne,krokx,kroky,l, Ng, mx,my, g;

//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

 float f(float x, float TP )
  {
   if (x < TP / 2)
   {
        return 3;
   }
   else
   if ((x >= TP / 2) && (x < 3 * TP / 4))
       return 4 * (TP - 2 * x) / TP;
   else
       return 8 *(x - TP) / TP;
   //{    f:=1/(1+25*x*x);      } //
 }

//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn1Click(TObject *Sender)
{
        float *Xe, *Ye, *yg;
        float *a, *b, *c;
        int k, x, y, i,Ne,krokx,kroky,l, Ng, mx,my ;
        float al,bl,h,h1,maxx,maxy,minx,miny,kx,ky,zx,zy,gx,gy,cx,cy,gx0,gy0;
        float xx,yy;
        float KOM, g, d, w, TP, s;
        al = StrToFloat(Edit1->Text);
        bl = StrToFloat(Edit2->Text);
        Ng = StrToInt(Edit3->Text);
        l=60;
        maxx=Xe[Ne-1];
        minx=Xe[0];
        maxy=Ye[0];
        miny=Ye[0];
        TP = bl - al ;
        Xe[0] = al;
        for (int j=0; j<Ne-1; j++)            //{Табуляція функції //
        {
                Ye[j] = f(Xe[j], TP);
                Xe[j+1] = Xe[j]+h;
        }
        for(i=0;i<Ne-1;i++)
        {
                if (maxy<Ye[i])
                {
                        maxy=Ye[i];
                }
                if (miny>Ye[i])
                {
                        miny=Ye[i];
                }
        }
        w = 2*3.14159/TP;
        for (k = 1; k < Ng; k++)
                 {
                        KOM = k*w;
                        g = 0;
                        d = 0;
                        for (i = 1; i < Ne; i++)
                        {
                                s = KOM * Xe [i];
                                g = g + Ye [i] * cos (s);
                                d = d + Ye [i] * sin (s);
                        }
                        a [k] = 2 * g/Ne;
                        b [k] = 2 * d/Ne;
                        c [k] = sqrt ( pow ( a [k], 2 ) + pow (b [k], 2));
                 }
                 a [0] = 0;
                 for (i = 1; i < Ne; i++)
                 a [0] += Ye[i];
                a [0] = a [0] / Ne;
                for (i = 0; i < Ne - 1; i++)
                {
                        s = 0;
                        d = Xe [i] * w;
                        for (k = 1; k < Ng; k++)
                        {
                                KOM = k * d;
                                s += b [k] * sin (KOM) + a [k] * cos (KOM);
                        }
                        yg[i] = a [0] + s;
                }
        }

        mx=640;
my=480;
kx=(mx-2*l)/(maxx-minx);
ky=(my-2*l)/(miny-maxy);
zx=(mx*minx-l*(minx+maxx))/(minx-maxx);
zy=(my*maxy-l*(miny+maxy))/(maxy-miny);
if (minx*maxx<=0)                 //{"плаваючі" осі}
{gx=0;}
if (minx*maxx>0)
{gx=minx;}
if ((minx*maxx>0) && (minx<0))
{gx=maxx;}
if (miny*maxy<=0)
{gy=0;}
if ((miny*maxy>0) && (miny>0))
{gy=miny;}
if ((miny*maxy>0) && (miny<0))
{gy=maxy;}
gx0=kx*gx+zx;            //{координати (0,0)}
gy0=ky*gy+zy;

krokx=(mx-2*l)/10;
kroky=(my-2*l)/10;

if (minx* maxx<0)
        cx =(abs(minx)*krokx)/(gx0-l);
else
        cx =(abs(maxx-minx)*krokx)/(mx-2*l);
if (miny*maxy<0)
  cy =(abs(maxy)*kroky)/(gy0-l);
else
  cy =(abs(maxy-miny)*kroky)/(my-2*l);
g = 0;
while ((gx0+g*krokx)<(mx-l))
{        // {побудова вертикальних ліній гратки в 1, 4 чвертях}
  Image1->Canvas->MoveTo(gx0+g*krokx,l);
  Image1->Canvas->LineTo(gx0+g*krokx, my-l);
  Image1->Canvas->Pen->Color = clTeal;
  Image1->Canvas->Pen->Style = psDash;
  Image1->Canvas->Pen->Width = 1;
  if ((gx0+g*krokx)<(mx-l-10))
   {
        Image1->Canvas->MoveTo(gx0+g*krokx, gy0-5);
        Image1->Canvas->LineTo(gx0+g*krokx, gy0+5);
   }
  g = g+1;
}
for (i=1; i<g-1; i++)
  {
    if (minx*maxx<0)
      {
        Image1->Canvas->TextOutA(gx0+i*krokx, gy0+10, FloatToStrF((0+i*cx),ffGeneral,2,5));
      }
    else
        Image1->Canvas->TextOutA(gx0+i*krokx, gy0+10, FloatToStrF((minx+i*cx),ffGeneral,2,5));
   }
g = 0;
while ((gx0-g*krokx)>l)
  {       //{побудова вертикальних ліній гратки в 2, 3 чвертях}
    Image1->Canvas->MoveTo(gx0-g*krokx, l);
    Image1->Canvas->LineTo(gx0-g*krokx, my-l);
    Image1->Canvas->Pen->Color = clTeal;
    Image1->Canvas->Pen->Style = psDash;
    Image1->Canvas->Pen->Width =1;
    Image1->Canvas->MoveTo(gx0-g*krokx, gy0-5);
    Image1->Canvas->LineTo(gx0-g*krokx, gy0+5);
    g=g+1;
  }
for (i=1; i<g-1; i++)
  {
    if (minx*maxx<0)
      Image1->Canvas->TextOutA(gx0-i*krokx, gy0+10, FloatToStrF((0-i*cx), ffGeneral,2,5));
    else
      Image1->Canvas->TextOutA(gx0-i*krokx, gy0+10, FloatToStrF((maxx-i*cx), ffGeneral,2,5));
  }
int t = 1;
while ((gy0-t*kroky)>l)
  {             //{побудова горизонтальних ліній гратки в 1, 2 чвертях}
    Image1->Canvas->MoveTo(l,gy0-t*kroky);
    Image1->Canvas->LineTo(mx-l,gy0-t*kroky);
    Image1->Canvas->Pen->Color =clTeal;
    Image1->Canvas->Pen->Style =psDash;
    Image1->Canvas->Pen->Width =1;
  Image1->Canvas->MoveTo(gx0-5,gy0-t*kroky);
  Image1->Canvas->LineTo(gx0+5, gy0-t*kroky);
  t = t+1;
}
for (i=1;i<t-1; i++)
  {
    if (miny*maxy<0)
      Image1->Canvas->TextOutA(gx0-28, gy0-i*kroky, FloatToStrF((0+i*cy), ffGeneral,2,5));
  else
      Image1->Canvas->TextOutA(gx0-28, gy0-i*kroky, FloatToStrF((miny+i*cy), ffGeneral,2,5));
  }
 t = 1;
while ((gy0+t*kroky)<(my-l))
  {          //{побудова горизонтальних ліній гратки в 1, 2 чвертях}
     Image1->Canvas->MoveTo(l, gy0+t*kroky);
     Image1->Canvas->LineTo(mx-l, gy0+t*kroky);
     Image1->Canvas->Pen->Color = clTeal;
     Image1->Canvas->Pen->Style = psDash;
     Image1->Canvas->Pen->Width = 1;
     Image1->Canvas->MoveTo(gx0-5,gy0+t*kroky);
     Image1->Canvas->LineTo(gx0+5, gy0+t*kroky);
     t = t+1;
  }
for (i=1;i<t-1; i++)
  {
    if (maxy*miny<0)
      Image1->Canvas->TextOutA(gx0-28, gy0+i*kroky, FloatToStrF((0-i*cy), ffGeneral,2,5));
  else
      Image1->Canvas->TextOutA(gx0-28, gy0+i*kroky, FloatToStrF((maxy-i*cy), ffGeneral,2,5));
  }
if (minx*maxx<=0)
  if (miny*maxy<=0)
    Image1->Canvas->TextOutA(gx0, gy0+10, FloatToStr((0.0)));     // {побудова осей}
    Image1->Canvas->Pen->Color=clTeal;
    Image1->Canvas->Pen->Style =psSolid;
    Image1->Canvas->Pen->Width =3;
    Image1->Canvas->MoveTo(l, gy0);
    Image1->Canvas->LineTo( floor(mx-l), gy0);
    Image1->Canvas->MoveTo(gx0,l);
    Image1->Canvas->LineTo(gx0,  floor(my-l));
  Image1->Canvas->MoveTo(  floor(mx-l), gy0);                       //{побудова стрілок}
  Image1->Canvas->LineTo(  floor(mx-l)-10, gy0-5);
  Image1->Canvas->MoveTo(  floor(mx-l), gy0);
  Image1->Canvas->LineTo(  floor(mx-l)-10, gy0+5);
  Image1->Canvas->MoveTo(gx0,l);
  Image1->Canvas->LineTo(gx0-5,l+10);
  Image1->Canvas->MoveTo(gx0,l);
  Image1->Canvas->LineTo(gx0+5,l+10);


        Krokx =600/Ng;
        Max = c[1];
        for (i = 2; i < Ng; i++)
        if (c[i] > Max)
                Max:=c[i];
        Ky = 300/max;
        Image1->Canvas->Pen->Color=clTeal;
        Image1->Canvas->Pen->Style =psSolid;
        Image1->Canvas->Pen->Width =3;
        Image1->Canvas->LineTo(20, 400, 620, 400);
        Image1->Canvas->LineTo (20, 20, 20, 400);
        mx=640;
my=480;
kx=(mx-2*l)/(maxx-minx);
ky=(my-2*l)/(miny-maxy);
zx=(mx*minx-l*(minx+maxx))/(minx-maxx);
zy=(my*maxy-l*(miny+maxy))/(maxy-miny);
if (minx*maxx<=0)                 //{"плаваючі" осі}
{gx=0;}
if (minx*maxx>0)
{gx=minx;}
if ((minx*maxx>0) && (minx<0))
{gx=maxx;}
if (miny*maxy<=0)
{gy=0;}
if ((miny*maxy>0) && (miny>0))
{gy=miny;}
if ((miny*maxy>0) && (miny<0))
{gy=maxy;}
gx0=kx*gx+zx;            //{координати (0,0)}
gy0=ky*gy+zy;

krokx=(mx-2*l)/10;
kroky=(my-2*l)/10;

if (minx* maxx<0)
        cx =(abs(minx)*krokx)/(gx0-l);
else
        cx =(abs(maxx-minx)*krokx)/(mx-2*l);
if (miny*maxy<0)
  cy =(abs(maxy)*kroky)/(gy0-l);
else
  cy =(abs(maxy-miny)*kroky)/(my-2*l);
g = 0;
while ((gx0+g*krokx)<(mx-l))
{        // {побудова вертикальних ліній гратки в 1, 4 чвертях}
  Image1->Canvas->MoveTo(gx0+g*krokx,l);
  Image1->Canvas->LineTo(gx0+g*krokx, my-l);
  Image1->Canvas->Pen->Color = clTeal;
  Image1->Canvas->Pen->Style = psDash;
  Image1->Canvas->Pen->Width = 1;
  if ((gx0+g*krokx)<(mx-l-10))
   {
        Image1->Canvas->MoveTo(gx0+g*krokx, gy0-5);
        Image1->Canvas->LineTo(gx0+g*krokx, gy0+5);
   }
  g = g+1;
}
for (i=1; i<g-1; i++)
  {
    if (minx*maxx<0)
      {
        Image1->Canvas->TextOutA(gx0+i*krokx, gy0+10, FloatToStrF((0+i*cx),ffGeneral,2,5));
      }
    else
        Image1->Canvas->TextOutA(gx0+i*krokx, gy0+10, FloatToStrF((minx+i*cx),ffGeneral,2,5));
   }
g = 0;
while ((gx0-g*krokx)>l)
  {       //{побудова вертикальних ліній гратки в 2, 3 чвертях}
    Image1->Canvas->MoveTo(gx0-g*krokx, l);
    Image1->Canvas->LineTo(gx0-g*krokx, my-l);
    Image1->Canvas->Pen->Color = clTeal;
    Image1->Canvas->Pen->Style = psDash;
    Image1->Canvas->Pen->Width =1;
    Image1->Canvas->MoveTo(gx0-g*krokx, gy0-5);
    Image1->Canvas->LineTo(gx0-g*krokx, gy0+5);
    g=g+1;
  }
for (i=1; i<g-1; i++)
  {
    if (minx*maxx<0)
      Image1->Canvas->TextOutA(gx0-i*krokx, gy0+10, FloatToStrF((0-i*cx), ffGeneral,2,5));
    else
      Image1->Canvas->TextOutA(gx0-i*krokx, gy0+10, FloatToStrF((maxx-i*cx), ffGeneral,2,5));
  }
int t = 1;
while ((gy0-t*kroky)>l)
  {             //{побудова горизонтальних ліній гратки в 1, 2 чвертях}
    Image1->Canvas->MoveTo(l,gy0-t*kroky);
    Image1->Canvas->LineTo(mx-l,gy0-t*kroky);
    Image1->Canvas->Pen->Color =clTeal;
    Image1->Canvas->Pen->Style =psDash;
    Image1->Canvas->Pen->Width =1;
  Image1->Canvas->MoveTo(gx0-5,gy0-t*kroky);
  Image1->Canvas->LineTo(gx0+5, gy0-t*kroky);
  t = t+1;
}
for (i=1;i<t-1; i++)
  {
    if (miny*maxy<0)
      Image1->Canvas->TextOutA(gx0-28, gy0-i*kroky, FloatToStrF((0+i*cy), ffGeneral,2,5));
  else
      Image1->Canvas->TextOutA(gx0-28, gy0-i*kroky, FloatToStrF((miny+i*cy), ffGeneral,2,5));
  }
 t = 1;
while ((gy0+t*kroky)<(my-l))
  {          //{побудова горизонтальних ліній гратки в 1, 2 чвертях}
     Image1->Canvas->MoveTo(l, gy0+t*kroky);
     Image1->Canvas->LineTo(mx-l, gy0+t*kroky);
     Image1->Canvas->Pen->Color = clTeal;
     Image1->Canvas->Pen->Style = psDash;
     Image1->Canvas->Pen->Width = 1;
     Image1->Canvas->MoveTo(gx0-5,gy0+t*kroky);
     Image1->Canvas->LineTo(gx0+5, gy0+t*kroky);
     t = t+1;
  }
for (i=1;i<t-1; i++)
  {
    if (maxy*miny<0)
      Image1->Canvas->TextOutA(gx0-28, gy0+i*kroky, FloatToStrF((0-i*cy), ffGeneral,2,5));
  else
      Image1->Canvas->TextOutA(gx0-28, gy0+i*kroky, FloatToStrF((maxy-i*cy), ffGeneral,2,5));
  }
if (minx*maxx<=0)
  if (miny*maxy<=0)
    Image1->Canvas->TextOutA(gx0, gy0+10, FloatToStr((0.0)));     // {побудова осей}
    Image1->Canvas->Pen->Color=clTeal;
    Image1->Canvas->Pen->Style =psSolid;
    Image1->Canvas->Pen->Width =3;
    Image1->Canvas->MoveTo(l, gy0);
    Image1->Canvas->LineTo( floor(mx-l), gy0);
    Image1->Canvas->MoveTo(gx0,l);
    Image1->Canvas->LineTo(gx0,  floor(my-l));
  Image1->Canvas->MoveTo(  floor(mx-l), gy0);                       //{побудова стрілок}
  Image1->Canvas->LineTo(  floor(mx-l)-10, gy0-5);
  Image1->Canvas->MoveTo(  floor(mx-l), gy0);
  Image1->Canvas->LineTo(  floor(mx-l)-10, gy0+5);
  Image1->Canvas->MoveTo(gx0,l);
  Image1->Canvas->LineTo(gx0-5,l+10);
  Image1->Canvas->MoveTo(gx0,l);
  Image1->Canvas->LineTo(gx0+5,l+10);


//---------------------------------------------------------------------------
void __fastcall TForm1::BitBtn2Click(TObject *Sender)
{
        Edit1->Text = "";
        Edit2->Text = "";
        Edit3->Text = "";
}
//---------------------------------------------------------------------------

