//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
TFishka f;
TDoska doska;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormPaint(TObject *Sender)
{
doska.draw();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
f.init(StrToInt(Edit1->Text),StrToInt(Edit2->Text),clBlue,1);
f.draw();
//f.count_1++;
Edit5->Text=IntToStr(f.count_1);
Button1->Enabled=false;
Edit1->Enabled=false;Edit1->Text="";
Edit2->Enabled=false;Edit2->Text="";

if (Button2->Enabled==false)
   { Button2->Enabled=true;
     Edit3->Enabled=true;
     Edit4->Enabled=true;
   }
   else
   {
   Button2->Enabled=false;
   }
   f.Game_over();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
f.init(StrToInt(Edit3->Text),StrToInt(Edit4->Text),clRed,2);
f.draw();
//f.count_2++;
Edit6->Text=IntToStr(f.count_2);
Button2->Enabled=false;
Edit3->Enabled=false;Edit3->Text="";
Edit4->Enabled=false;Edit4->Text="";

if (Button1->Enabled==false)
   {
     Button1->Enabled=true;
     Edit1->Enabled=true;
     Edit2->Enabled=true;

   }else{Button1->Enabled=false;}   f.Game_over();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Timer1Timer(TObject *Sender)
{
f.draw_greed();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
Edit5->Text=IntToStr(f.count_1);
Edit6->Text=IntToStr(f.count_2);
Edit3->Enabled=false;
Edit4->Enabled=false;       
}
//---------------------------------------------------------------------------

