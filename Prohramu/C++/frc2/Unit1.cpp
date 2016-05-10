//---------------------------------------------------------------------------

#include <vcl.h>
#include <math.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "CSPIN"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
float pi = 3.141592;

int FinalAge, x1,x2,x3,y1,y2,y3,rnd;
float cc, AngleR,AngleL,StartAngle,ConCoef;

void line(float x1,float y1,float x2,float y2,TCanvas* c)
{
        c->MoveTo(ceil(x1),ceil(y1));
        c->LineTo(ceil(x2),ceil(y2));
}

void TriS(int age,float x1,float y1,float x2,float y2,float x3,float y3, TCanvas* c)
{
        float xd, yd, ye, xe, xf, yf;
        age++;
        if (age == FinalAge)
                {
                        line(x1,y1,x2,y2, Form1->Image1->Canvas);
                        line(x2,y2,x3,y3, Form1->Image1->Canvas);
                        line(x3,y3,x1,y1, Form1->Image1->Canvas);
                        Form1->Image1->Canvas->Refresh();
                        return;
                }
        else
                {
                        xd = ceil((x1+x2)/2);
                        yd = ceil((y1+y2)/2);
                        xe = ceil((x2+x3)/2);
                        ye = ceil((y2+y3)/2);
                        xf = ceil((x1+x3)/2);
                        yf = ceil((y1+y3)/2);
                        TriS(age,x1,y1,xd,yd,xf,yf,Form1->Image1->Canvas);
                        TriS(age,xd,yd,x2,y2,xe,ye,Form1->Image1->Canvas);
                        TriS(age,xf,yf,xe,ye,x3,y3,Form1->Image1->Canvas);
                }
}

void drawtree(int age,int kx,int ky,int R, float kut)
{
        int sx,sy;
        R = ceil(R-0.2*R);
        age++;
        if (age == FinalAge)
        {
                line(kx,ky,ceil(kx + R * sin(kut)), ceil(ky + R * cos(kut)), Form1->Image1->Canvas);
                sx = ceil(kx + R * sin(kut));
                sy = ceil(ky + R * cos(kut));
                line(sx,sy,ceil(sx + R * sin(kut-AngleL)), ceil(sy + R * cos(kut-AngleL)), Form1->Image1->Canvas);
                line(sx,sy,ceil(sx + R * cos(kut+AngleR)), ceil(sy + R * sin(kut+AngleR)),Form1->Image1->Canvas);
                return;
        }
        else
        {
                sx = ceil(kx + R * sin(kut));
                sy = ceil(ky + R * cos(kut));
                drawtree(age,sx,sy,R+random(rnd),kut-AngleL);
                drawtree(age,sx,sy,R+random(rnd),kut+AngleR);
                line(kx,ky,ceil(kx + R * sin(kut)), ceil(ky + R * cos(kut)),Form1->Image1->Canvas);
        }
}

void drawdragon(int age, float x1,float y1,float x2,float y2,float n)
{
        float dx,dy,AC,CD,AD,cx,cy;
        age++;
        if (age == FinalAge)
        {
                line(x1,y1,x2,y2, Form1->Image1->Canvas);
                return;
        }
        else
        {
                cx = (x2+x1)/2;
                cy = (y2+y1)/2;
                AC = sqrt(pow((cx-x1), 2)+pow((cy-y1), 2));
                dx = cx + AC * (cos(n+pi/2));
                dy = cy + AC * (sin(n+pi/2));
                drawdragon(age,x1,y1,dx,dy,n+45*cc);
                drawdragon(age,x2,y2,dx,dy,n+90*cc+45*cc);
        }
}

float Mn(int nn, int v, float r)
{
        float res;
        if (nn % (v*v*v*v) == 0)
                res = 1;
        else
        if (nn % (v*v*v) == 0)
                res = r;
        else
        if (nn % (v*v) == 0)
                res = r*r;
        else
        if (nn % (v) == 0)
                res = r*r*r;
        else
                res = r*r*r*r;
        return res;
}

void __fastcall TForm1::SpeedButton1Click(TObject *Sender)
{

        switch (ComboBox1->ItemIndex)
        {
        case 0: {
                Image1->Canvas->Refresh();
                Image1->Canvas->Brush->Color = clAqua;
                Image1->Canvas->Pen->Color = clBlue;
                Image1->Canvas->Rectangle(0,0,Image1->Width,Image1->Height);
                x1 = 1;
                y1 = 1;
                x2 = 436;
                y2 = 720;
                x3 = 872;
                y3 = 1;
                Image1->Canvas->CleanupInstance();
                Image1->Canvas->Rectangle(0,0,872,720);
                if (StrToInt(CSpinEdit1->Text) > 0)
                {
                        FinalAge = StrToInt(CSpinEdit1->Text);
                        TriS(0,x1,y1,x2,y2,x3,y3,Form1->Image1->Canvas);
                }
                LabeledEdit1->Visible = false;
                LabeledEdit2->Visible = false;
                LabeledEdit3->Visible = false;
                LabeledEdit4->Visible = false;
                LabeledEdit5->Visible = false;
                LabeledEdit6->Visible = false;
                LabeledEdit7->Visible = false;
                break;
                }
        case 1: {
                Image1->Canvas->Refresh();
                Image1->Canvas->Brush->Color = clAqua;
                Image1->Canvas->Pen->Color = clBlue;
                int StartX,StartY,StartHeight;
                long int i,j,iter,Total;
                   {
                        ConCoef = (pi/180);
                        AngleL = StrToInt(LabeledEdit1->Text)*ConCoef;
                        AngleR = StrToInt(LabeledEdit2->Text)*ConCoef;
                        StartHeight = StrToInt(LabeledEdit4->Text);
                        StartAngle = pi;
                        StartX = 436;
                        StartY = 700;
                        rnd = StrToInt(LabeledEdit3->Text);
                        Image1->Canvas->Refresh();
                        Image1->Canvas->Brush->Color = clAqua;
                        Image1->Canvas->Rectangle(0,0,Image1->Width,Image1->Height);
                        if ((StrToInt(CSpinEdit1->Text)>0) && (rnd>=0))
                        {
                                FinalAge = StrToInt(CSpinEdit1->Text);
                                drawtree(0,StartX,StartY,StartHeight,StartAngle);
                        }
                        LabeledEdit1->Visible = true;
                        LabeledEdit2->Visible = true;
                        LabeledEdit3->Visible = true;
                        LabeledEdit4->Visible = true;
                        LabeledEdit5->Visible = false;
                        LabeledEdit6->Visible = false;
                        LabeledEdit7->Visible = false;
                   }
                   break;
                }
        case 2: {
                        Image1->Canvas->Refresh();
                        Image1->Canvas->Brush->Color = clAqua;
                        Image1->Canvas->Pen->Color = clBlue;
                        float dil = StrToFloat(LabeledEdit7->Text);
                        x1 = 245;
                        y1 = 260;
                        x2 = 700;
                        y2 = 260;
                        cc = (pi/dil);
                        FinalAge = StrToInt(CSpinEdit1->Text);
                        Image1->Canvas->Rectangle(0,0,Image1->Width,Image1->Height);
                        drawdragon(0,x1,y1,x2,y2,0);
                        break;
                        LabeledEdit7->Visible = true;
                        LabeledEdit6->Visible = false;
                        LabeledEdit5->Visible = false;
                        LabeledEdit4->Visible = false;
                        LabeledEdit3->Visible = false;
                        LabeledEdit2->Visible = false;
                        LabeledEdit1->Visible = false;
                }
        case 3: {
                        Image1->Canvas->Refresh();
                        Image1->Canvas->Brush->Color = clAqua;
                        Image1->Canvas->Rectangle(0,0,Image1->Width,Image1->Height);
                        Image1->Canvas->Pen->Color = clBlue;
                        int it = StrToInt(CSpinEdit1->Text);
                        int l=450;
                        int v = StrToInt(LabeledEdit5->Text);
                        float r = StrToFloat(LabeledEdit6->Text);
                        float da=4*pi/5;
                        float a, x, y, xn, yn;
                        a = 0;
                        x = 200;
                        y = 450;
                        for (int i = 1; i <= it; i++)
                        {
                                xn = x+sin(a)*l*Mn(i,v,r);
                                yn = y-cos(a)*l*Mn(i,v,r);
                                Image1->Canvas->Brush->Color = clBlue;
                                Image1->Canvas->MoveTo(floor(x), floor(y));
                                Image1->Canvas->LineTo(floor(xn), floor(yn));
                                x = xn;
                                y = yn;
                                a = a+da;
                        }
                        LabeledEdit5->Visible = true;
                        LabeledEdit6->Visible = true;
                        LabeledEdit7->Visible = false;
                        LabeledEdit4->Visible = false;
                        LabeledEdit3->Visible = false;
                        LabeledEdit1->Visible = false;
                        LabeledEdit2->Visible = false;
                        break;
                }
                
        }

}
//---------------------------------------------------------------------------
void __fastcall TForm1::ComboBox1Change(TObject *Sender)
{
        switch (ComboBox1->ItemIndex)
        {
                case 0: {
                        LabeledEdit1->Visible = false;
                        LabeledEdit2->Visible = false;
                        LabeledEdit3->Visible = false;
                        LabeledEdit4->Visible = false;
                        LabeledEdit5->Visible = false;
                        LabeledEdit6->Visible = false;
                        LabeledEdit7->Visible = false;
                        break;
                }
                case 1: {
                        LabeledEdit1->Visible = true;
                        LabeledEdit2->Visible = true;
                        LabeledEdit3->Visible = true;
                        LabeledEdit4->Visible = true;
                        LabeledEdit5->Visible = false;
                        LabeledEdit6->Visible = false;
                        LabeledEdit7->Visible = false;
                        break;
                }
                case 2: {
                        LabeledEdit7->Visible = true;
                        LabeledEdit6->Visible = false;
                        LabeledEdit5->Visible = false;
                        LabeledEdit4->Visible = false;
                        LabeledEdit3->Visible = false;
                        LabeledEdit2->Visible = false;
                        LabeledEdit1->Visible = false;
                        break;
                }
                case 3: {
                        LabeledEdit5->Visible = true;
                        LabeledEdit6->Visible = true;
                        LabeledEdit7->Visible = false;
                        LabeledEdit4->Visible = false;
                        LabeledEdit3->Visible = false;
                        LabeledEdit1->Visible = false;
                        LabeledEdit2->Visible = false;
                        break;
                }
        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
                        LabeledEdit1->Visible = false;
                        LabeledEdit2->Visible = false;
                        LabeledEdit3->Visible = false;
                        LabeledEdit4->Visible = false;
                        LabeledEdit5->Visible = false;
                        LabeledEdit6->Visible = false;
                        LabeledEdit7->Visible = false;
}
//---------------------------------------------------------------------------

