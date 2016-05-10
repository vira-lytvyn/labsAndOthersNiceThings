//---------------------------------------------------------------------------
#include <vcl.h>
#include <math.h>
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
float pi = 3.141592;

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

int opra (int n)
{
        int j;
        int opra;
        j = n;
        if (( j-1) % 4 == 0)
        opra = -1;
        else
        if (( j-3) % 4 == 0)
        opra = 1;
        else
        {
                j = floor (j / 2);
        }
        return (opra);
}

void __fastcall TForm1::BitBtn1Click(TObject *Sender)
{
TColor cl[16];
cl[0]=clBlack;
cl[1]=clBlue;
cl[2]=clAqua;
cl[3]=clInactiveCaption;
cl[4]=clActiveCaption;
cl[5]=clYellow;
cl[6]=clRed;
cl[7]=clGradientActiveCaption;
cl[8]=clGradientInactiveCaption;
cl[9]=clGreen;
cl[10]=clFuchsia;
cl[11]=clHotLight;
cl[12]=clLime;
cl[13]=clMaroon;
cl[14]=clPurple;
cl[15]=clSkyBlue;
switch (ComboBox1->ItemIndex)
      {
      case 0: {
                PaintBox1->Refresh();
                float P[640];
                float Q[640];
                float x[640]; float y[640];
                int A = 640;
                int k = 16;
                int M = 300;
                float xmax, ymax, xmin, ymin, R, dx, dy, x2, y2, j;
                int i, Nx, Ny;
                xmax = StrToFloat(Edit1->Text);
                ymax = StrToFloat(Edit3->Text);
                xmin = StrToFloat(Edit2->Text);
                ymin = StrToFloat(Edit4->Text);
                dx = (xmax - xmin)/(A - 1);
                dy = (ymax - ymin)/(A - 1);
                Q[0] = ymin;
                P[0] = xmin;
                for (i = 0; i <= A - 1; i++)
                        {
                                Q[i+1] = Q[i] + dy;
                                P[i+1] = P[i] + dx;
                        }
                for (int j = 0; j <= A - 1; j++)
                {
                        for (Nx = 0; Nx < A - 1; Nx++)
                        {
                                for (Ny = 0; Ny < A - 1; Ny++)
                                {
                                        x [0] = 0.0;
                                        y [0] = 0.0;
                                        P [0] = xmin + Nx*dx;
                                        Q [0] = ymin + Ny*dy;
                                        i = 0;
                                        do
                                        {
                                                x2 = x[j]*x[j];
                                                y2 = y[j]*y[j];
                                                R = x2 + y2;
                                                y [j + 1] = 2 * x [j] * y [j] + Q[Ny];
                                                x [j + 1] = x2 - y2 + P[Nx];
                                                i++;
                                        }
                                        while ((i>=k) || (R > M));
                                        if (i == k)
                                        {
                                        //PaintBox1->Canvas->Pixels[Nx][Ny];
                                        //PaintBox1->Canvas->Brush->Color = 0;
                                        i=0;
                                        }
                                        else
                                        {
                                        PaintBox1->Canvas->Pixels[Nx][Ny];
                                        PaintBox1->Canvas->Brush->Color = cl[i];
                                        }
                                }
                                Label2->Visible = false;
                                Edit1->Visible = false;
                                Edit2->Visible = false;
                                Edit3->Visible = false;
                                Edit4->Visible = false;
                                Label6->Visible = false;
                                Label7->Visible = false;
                        }
                        break;
                }
      }

     case 1: {
                PaintBox1->Refresh();
                int a = 729;
               // Sierpinski(0,0,a,a);
               break;
                }
     case 2: {
                PaintBox1->Refresh();
                int c = 640*16;
                int d = 3;
                float da =pi/2;
                int i, gm;
                float a,x,y;
   x = 150;
   y = 150;
   a = pi/2;
   for (i = 1; i < c+1; i++)
   {
     PaintBox1->Canvas->MoveTo( floor(x), floor(y) );
     PaintBox1->Canvas->LineTo( floor(x+d*cos(a)), floor( y-d*sin(a)));
     x = x+d*cos(a);
     y = y-d*sin(a);
     a = a-da*opra(i);
   }
   break;
  }
     case 3: {
                 PaintBox1->Refresh();
                 int it = StrToFloat(LabeledEdit1->Text);
                 int l=500;
                 int v = StrToFloat(Edit1->Text);
                 float r = StrToFloat(Edit2->Text);
                 int k = StrToInt(Edit5->Text);
                 float da=4*pi/5;
                 float a, x, y, xn, yn;
                 int i;
                 a = pi/2;
                 x = 270;
                 y = 555;
                 for (i = 1; i <= it; i++)
                 {
                        xn = x+sin(a)*l*Mn(i,v,r);
                        yn = y-cos(a)*l*Mn(i,v,r);
                        PaintBox1->Canvas->MoveTo(floor(x), floor(y));
                        PaintBox1->Canvas->LineTo(floor(xn), floor(yn));
                        x = xn;
                        y = yn;
                        a = a+da;
                 }
                 Label3->Visible = false;
                 Label4->Visible = false;
                 Label5->Visible = false;
                 Edit1->Visible = false;
                 Edit2->Visible = false;
                 Edit5->Visible = false;
                 LabeledEdit1->Visible = false;
                 break;
            }
     case 4: {
                PaintBox1->Refresh();
                float P; float x[640]; float y[640];
                float Q;
                int A = 640;
                int B = 640;
                int k = 16;
                int M = 300;
                P = StrToFloat(Edit3->Text);
                Q = StrToFloat(Edit4->Text);
                float xmax, ymax, xmin, ymin, R, dx, dy, x2, y2, j;
                int i, Nx, Ny;
                xmax = ymax;
                ymax = StrToFloat(Edit1->Text);
                xmin = ymin;
                ymin = StrToFloat(Edit2->Text);
                dx = (xmax - xmin)/(A - 1);
                dy = (ymax - ymin)/(B - 1);
                for (int j = 0; j < B - 1; j++)
                {
                for (Nx = 0; Nx < A - 1; Nx++)
                        {
                                for (Ny = 0; Ny < B - 1; Ny++)
                                {
                                        y[0] = ymin + Ny*dy;
                                        x[0] = xmin + Nx*dx;
                                        i = 0;
                                        while ((i<k) || (R > 2))
                                        {
                                                x2 = pow(x[j],2);
                                                y2 = pow(y[j],2);
                                                R = sqrt(x2 + y2);
                                                y [j + 1] = 2 * x[j] * y[j] + Q;
                                                x [j + 1] = x2 - y2 + P;
                                                i++;
                                        }
                                        if (i == k)
                                        i = 0;
                                        else
                                        PaintBox1->Canvas->Pixels[Nx][Ny] = cl[i];
                                }
                                Label2->Visible = false;
                                Edit1->Visible = false;
                                Edit2->Visible = false;
                                Edit3->Visible = false;
                                Edit4->Visible = false;
                                Label8->Visible = false;
                                Label9->Visible = false;
                                Label10->Visible = false;
                        }
                        break;
                }
             }
    }

}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn2Click(TObject *Sender)
{
        switch (ComboBox1->ItemIndex)
        {
                case 0: {
                        Label2->Visible = true;
                        Edit1->Visible = true;
                        Edit2->Visible = true;
                        Edit3->Visible = true;
                        Edit4->Visible = true;
                        Edit1->Clear();
                        Edit2->Clear();
                        Edit3->Clear();
                        Edit4->Clear();
                        Label6->Visible = true;
                        Label7->Visible = true;
                        break;
                        }
                case 1: {

                        }
                case 2: {

                        }
                case 3: {
                        Label3->Visible = true;
                        Label4->Visible = true;
                        Edit1->Visible = true;
                        Edit2->Visible = true;
                        Edit5->Visible = true;
                        LabeledEdit1->Visible = true;
                        Edit1->Clear();
                        Edit2->Clear();
                        Edit5->Clear();
                        LabeledEdit1->Clear();
                        Label5->Visible = true;

                        }
                case 4: {
                        Label2->Visible = true;
                        Edit1->Visible = true;
                        Edit2->Visible = true;
                        Edit3->Visible = true;
                        Edit4->Visible = true;
                        Edit1->Clear();
                        Edit2->Clear();
                        Edit3->Clear();
                        Edit4->Clear();
                        Label8->Visible = true;
                        Label9->Visible = true;
                        Label10->Visible = true;
                        }
                }

}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn3Click(TObject *Sender)
{
        PaintBox1->Refresh();
        Edit1->Visible = false;
        Edit2->Visible = false;
        Edit3->Visible = false;
        Edit4->Visible = false;
        Label1->Visible = false;
        Label2->Visible = false;
        Label3->Visible = false;
        Label4->Visible = false;
        Label5->Visible = false;
        Label6->Visible = false;
        Label7->Visible = false;
        Label8->Visible = false;
        Label9->Visible = false;
        Label10->Visible = false;
        LabeledEdit1->Visible = false;

}
//---------------------------------------------------------------------------

