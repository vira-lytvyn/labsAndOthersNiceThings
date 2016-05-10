//---------------------------------------------------------------------------

#include <vcl.h>
#include <math>
#include "APPROX.h"
#pragma hdrstop

////////////////////////////////////////////////////////////
//Цей VCL-application проект написав Горін Олег Ігорович, групи ФЕІ-12
//В проекті брали участь =) :
//      -процедура void grafik(int Ne,int Ngr,float Xe[10],
//    float Ye[10],float Xgr[1000],float Ygr[1000],
//    float al,float bl,float yal,float ybl) - для побудови графіка та
//    експериментальних точок.
//      -зовнішня процедура approximation у DLL файлі APPROX.DLL
//                                                    APPROX.LIB
//                                                    APPROX.H
//      -та інші функції-члени
////////////////////////////////////////////////////////////



#include "APPROXIMATION.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
TPoint mpoint1;
bool test[7]={true,true,true,true,true,false,false};
int Ngr,M,Ne,i,j;
float Xe[10];
float Ye[10];
float x[10];
float Xgr[1000];
float Ygr[1000];
float al,bl,yal,ybl;

//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
double Round(double n){
        float t;
        if (n>0)
        {
            t=n-floor(n);
            if (t>=0.5)
            {
                return floor(n)+1;
            }
            else
            {
                return floor(n);
            }
        }
        else
        {
            t=n-floor(n);
            if (t>=0.5)
            {
                return floor(n)-1;
            }
            else
            {
                return floor(n);
            }
        }
}
////////////////////////////////////////////////////////////
//виконав Горін Олег Ігорович, групи ФЕІ-12
////////////////////////////////////////////////////////////
//----------------------------------------
void grafik(int Ne,int Ngr,float Xe[10],
    float Ye[10],float Xgr[1000],float Ygr[1000],
    float al,float bl,float yal,float ybl)
{
    Form1->PaintBox1->Canvas->Pen->Color=clBtnFace;
    Form1->PaintBox1->Canvas->Pen->Width=1;
    Form1->PaintBox1->Canvas->Rectangle(0,0,
            Form1->PaintBox1->Width,Form1->PaintBox1->Height);
    static double MaxX=0,MaxY=0,MinX=0,MinY=0;
    static double  Kx=0,Ky=0,Zx=0,Zy=0,Gx=0,Gy=0,
                    xal=0,xbl=0,h=0,Krx=0,Kry=0,xx=0,yy=0;
    static int Me=0,i=0,KrokX=0,KrokY=0,l=0;
    Me=Form1->PaintBox1->Width;

    if ((al==Xgr[0])&&(bl==Xgr[Ngr-1]))
    {
        xal=Xgr[0];
        xbl=Xgr[Ngr-1];
        if (al>Xe[0]) xal=Xe[0];
        if (bl<Xe[Ne-1]) xbl=Xe[Ne-1];
    }
    /*Пошук екстремому значення функції f(x)*/
    MinX=xal; MaxX=xbl;
    MinY=Ygr[0]; MaxY=Ygr[0];
    for (i=0;i<Ngr;++i)
    {
        if (MaxY<Ygr[i]) MaxY=Ygr[i];
        if (MinY>Ygr[i]) MinY=Ygr[i];
        if (i<=Ne)
        {
            if (MaxY<Ye[i]) MaxY=Ye[i];
            if (MinY>Ye[i]) MinY=Ye[i];
        };
    };
    MinX=xal; MaxX=xbl;
    if (yal<MinY) MinY=yal;
    if (ybl>MaxY) MaxY=ybl;
    if (al<MinX)  MinX=al;
    if (bl>MaxX)  MaxX=bl;

    Form1->Label5->Caption="Ліва межа (<="+FloatToStr(MinX)+")";
    Form1->Label4->Caption="Права межа (>="+FloatToStr(MaxX)+")";
    Form1->Label6->Caption="Нижня межа (<="+FloatToStr(MinY)+")";
    Form1->Label7->Caption="Верхня межа (>="+FloatToStr(MaxY)+")";

    h=fabs(MaxX-MinX)/(Ngr-1);

    l=60; /*Відступ для підписів*/

    /*Побудова рамки*/
    Form1->PaintBox1->Canvas->Pen->Color=clBlue;
    Form1->PaintBox1->Canvas->Pen->Width=1;
    Form1->PaintBox1->Canvas->Pen->Style=psSolid;
    Form1->PaintBox1->Canvas->Rectangle(l,l,
        Form1->PaintBox1->Width-l,Form1->PaintBox1->Height-l);


    /*Обчислення коефіцієнтів масштабування*/
    Kx=(Form1->PaintBox1->Width-2*l)/(MaxX-MinX);
    Ky=(Form1->PaintBox1->Height-2*l)/(MinY-MaxY);
    Zx=(Form1->PaintBox1->Width*MinX-l*(MinX+MaxX))/(MinX-MaxX);
    Zy=(Form1->PaintBox1->Height*MaxY-l*(MinY+MaxY))/(MaxY-MinY);



    if ((MinX*MaxX<=0))             Gx=0;
    if ((MinX*MaxX>0))              Gx=MinX;
    if ((MinX*MaxX>0)&&(MinX<0))    Gx=MaxX;
    if ((MinY*MaxY<=0))             Gy=0;
    if ((MinY*MaxY>0)&&(MinY>0))    Gy=MinY;
    if ((MinY*MaxY>0)&&(MinY<0))    Gy=MaxY;


    Form1->PaintBox1->Canvas->Pen->Color=clBlack;
    Form1->PaintBox1->Canvas->Pen->Style=psSolid;
    Form1->PaintBox1->Canvas->Pen->Width=3;
    Form1->PaintBox1->Canvas->MoveTo(l,Round(Ky*Gy+Zy));
    Form1->PaintBox1->Canvas->LineTo(Round(Form1->PaintBox1->Width-l),
                                     Round(Ky*Gy+Zy));
    Form1->PaintBox1->Canvas->MoveTo(Round(Kx*Gx+Zx),l);
    Form1->PaintBox1->Canvas->LineTo(Round(Kx*Gx+Zx),
                                     Round(Form1->PaintBox1->Height-l));

    /*Обчислення відстаней між лініями градки*/
    KrokX=(Form1->PaintBox1->Width-2*l)/10;
    KrokY=(Form1->PaintBox1->Height-2*l)/10;
    /*Побудова градки*/

    Form1->PaintBox1->Canvas->Pen->Style=psDash;
    Form1->PaintBox1->Canvas->Pen->Color=clBlue;
    Form1->PaintBox1->Canvas->Pen->Width=1;

    for (i=1;i<=10;++i)
    {
        Form1->PaintBox1->Canvas->MoveTo(l,l+i*KrokY);
        Form1->PaintBox1->Canvas->LineTo(Form1->PaintBox1->Width-l,l+i*KrokY);
        Form1->PaintBox1->Canvas->MoveTo(l+i*KrokX,l);
        Form1->PaintBox1->Canvas->LineTo(l+i*KrokX,Form1->PaintBox1->Height-l);
    }
    xx=MinX;
    yy=MaxY;
    /*Обчислення крокy зміни значень масштабних підписів
     по осях Х та У відповідно*/
    Krx=(MaxX-MinX)/10;
    Kry=(MaxY-MinY)/10;
    for (i=0;i<=10;++i)
    {
        Form1->PaintBox1->Canvas->TextOutA(l+i*KrokX,
                                          Form1->PaintBox1->Height-l/2-5,
                                          FloatToStr(Round(xx*100)/100));
        xx=xx+Krx;
    };


    for (i=0;i<=10;i++)
    {
        Form1->PaintBox1->Canvas->TextOutA(l-32,l+i*KrokY,
                                        FloatToStr(Round(yy*100)/100));
        yy=yy-Kry;
    };
    /*Побудова графіка функції f точками*/
    Form1->PaintBox1->Canvas->Brush->Style=bsSolid;
    Form1->PaintBox1->Canvas->Brush->Color=clRed;
    for (i=0;i<Ne;++i)
        Form1->PaintBox1->Canvas->Ellipse(Round(Kx*Xe[i]+Zx)-3,
                                    Round(Ky*Ye[i]+Zy)-3,
                                    Round(Kx*Xe[i]+Zx)+3,
                                    Round(Ky*Ye[i]+Zy)+3);
    Form1->PaintBox1->Canvas->MoveTo(Round(Kx*Xgr[0]+Zx),
                                    Round(Ky*Ygr[0]+Zy));
    Form1->PaintBox1->Canvas->Pen->Width=2;
    Form1->PaintBox1->Canvas->Pen->Color=clGreen;
    for (i=0;i<Ngr;++i)
        Form1->PaintBox1->Canvas->LineTo(Round(Kx*Xgr[i]+Zx),
                                    Round(Ky*Ygr[i]+Zy));
    Form1->PaintBox1->Canvas->Brush->Color=clBtnFace;

}


void __fastcall TForm1::FormCreate(TObject *Sender)
{

    PaintBox1->Left=0;
    PaintBox1->Top=0;
    PaintBox1->Width=Form1->ClientWidth;
    for (int i=1;i<=10;++i)
    {
        StringGrid1->Cells[i][0]=IntToStr(i);
        StringGrid1->Cells[i][1]=IntToStr(i);
    };
    StringGrid1->Cells[0][1]="X";
    StringGrid1->Cells[0][2]="Y";
    StringGrid1->Cells[1][2]="1";
    StringGrid1->Cells[2][2]="4";
    StringGrid1->Cells[3][2]="9";
    StringGrid1->Cells[4][2]="16";
    StringGrid1->Cells[5][2]="25";
    StringGrid1->Cells[6][2]="36";
    StringGrid1->Cells[7][2]="49";
    StringGrid1->Cells[8][2]="64";
    StringGrid1->Cells[9][2]="81";
    StringGrid1->Cells[10][2]="100";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
    try {
        Ne=StrToInt(Edit1->Text);
        test[1]=true;
        CheckBox1->Checked=true;
    }
    catch (...)
    {
        ShowMessage("Введіть правильно Ne \n (цілочисельний тип)");
        test[1]=false;
        CheckBox1->Checked=false;
    };
    try {
        M=StrToInt(Edit2->Text);
        test[2]=true;
        CheckBox2->Checked=true;
    }
    catch (...)
    {
        ShowMessage("Введіть правильно степінь полінома \n (цілочисельний тип)");
        test[2]=false;
        CheckBox2->Checked=false;
    };
    try {
        Ngr=StrToInt(Edit3->Text);
        test[3]=true;
        CheckBox3->Checked=true;
    }
    catch (...)
    {
        ShowMessage("Введіть правильно Ngr \n (цілочисельний тип)");
        test[3]=false;
        CheckBox3->Checked=false;
    };
    try {
        al=StrToFloat(Edit4->Text);
        test[4]=true;
        CheckBox4->Checked=true;
    }
    catch (...)
    {
        ShowMessage("Введіть правильно ліву межу \n (дійсний тип)");
        test[4]=false;
        CheckBox4->Checked=false;
    };
    try {
        bl=StrToFloat(Edit5->Text);
        test[5]=true;
        CheckBox5->Checked=true;
    }
    catch (...)
    {
        ShowMessage("Введіть правильно праву межу \n (дійсний тип)");
        test[6]=false;
        CheckBox5->Checked=false;
    };
    try {
        yal=StrToFloat(Edit6->Text);
        test[6]=true;
        CheckBox6->Checked=true;
    }
    catch (...)
    {
        ShowMessage("Введіть правильно нижню межу \n (дійсний тип)");
        test[6]=false;
        CheckBox6->Checked=false;
    };
    try {
        ybl=StrToFloat(Edit7->Text);
        test[7]=true;
        CheckBox7->Checked=true;
    }
    catch (...)
    {
        ShowMessage("Введіть правильно верхню межу \n (дійсний тип)");
        test[7]=false;
        CheckBox7->Checked=false;
    };
    if (test[1]&&test[2]&&test[3]&&test[4]&&test[5]) test[0]=true;
    else test[0]=false;
    if (test[0])
    {
        try {
            for (i=0;i<StrToInt(Edit1->Text);++i)
                Xe[i]=StrToFloat(StringGrid1->Cells[i+1][1]);
            test[0]=true;
            CheckBox8->Checked=true;
        }
        catch (...)
        {
            ShowMessage("Введіть правильно "+IntToStr(i+1)
                +"-у абцису \n експериметальних даних");
            test[0]=false;
            CheckBox8->Checked=false;
        }
        try {
            for (i=0;i<StrToInt(Edit1->Text);++i)
                Ye[i]=StrToFloat(StringGrid1->Cells[i+1][2]);
            test[0]=true;
            CheckBox8->Checked=true;
        }
        catch (...)
        {
            ShowMessage("Введіть правильно "+IntToStr(i+1)
                +"-у ординату \n експериметальних даних");
            test[0]=false;
            CheckBox8->Checked=false;
        }

        for (i=0;i<10;++i)
            x[i]=0;
        approximation(Xe,Ye,Ne,M,x,Xgr,Ygr,Ngr,al,bl);
        StringGrid2->Cells[0][0]="K[1]"; StringGrid2->Cells[0][1]=FloatToStr(x[0]);
        StringGrid2->Cells[1][0]="K[2]"; StringGrid2->Cells[1][1]=FloatToStr(x[1]);
        StringGrid2->Cells[2][0]="K[3]"; StringGrid2->Cells[2][1]=FloatToStr(x[2]);
        StringGrid2->Cells[3][0]="K[4]"; StringGrid2->Cells[3][1]=FloatToStr(x[3]);
        StringGrid2->Cells[4][0]="K[5]"; StringGrid2->Cells[4][1]=FloatToStr(x[4]);
        StringGrid2->Cells[5][0]="K[6]"; StringGrid2->Cells[5][1]=FloatToStr(x[5]);
        StringGrid2->Cells[6][0]="K[7]"; StringGrid2->Cells[6][1]=FloatToStr(x[6]);
        StringGrid2->Cells[7][0]="K[8]"; StringGrid2->Cells[7][1]=FloatToStr(x[7]);
        StringGrid2->Cells[8][0]="K[9]"; StringGrid2->Cells[8][1]=FloatToStr(x[8]);
        StringGrid2->Cells[9][0]="K[10]";StringGrid2->Cells[9][1]=FloatToStr(x[9]);
        grafik(Ne,Ngr,Xe,Ye,Xgr,Ygr,al,bl,yal,ybl);
    };
}
////////////////////////////////////////////////////////////
//виконав Горін Олег Ігорович, групи ФЕІ-12
////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------
