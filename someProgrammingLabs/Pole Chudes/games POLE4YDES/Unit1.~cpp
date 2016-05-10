//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
slovo ob;
int Num_vopros;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------



void __fastcall TForm1::FormCreate(TObject *Sender)
{
ListBox1->Items->LoadFromFile("test.txt");
Label2->Caption="";
Label3->Caption="";
Label4->Caption="";
Label5->Caption="";
Label6->Caption="";
Label7->Caption="";
Label8->Caption="";
Label9->Caption="";
Label10->Caption="";
Label11->Caption="";
Num_vopros=1;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
ob.get_s(Num_vopros);
Form1->Edit1->Text="";
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
 Num_vopros+=2;
}
//---------------------------------------------------------------------------

