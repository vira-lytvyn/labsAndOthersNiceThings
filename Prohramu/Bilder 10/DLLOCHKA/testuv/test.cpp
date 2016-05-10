//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "DLLOCHKA.h"
#include "test.h"
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
void __fastcall TForm1::Button1Click(TObject *Sender)
{
float cel = StrToFloat(Edit1->Text);
	Edit2->Text = Cel_Far(cel);
}
//---------------------------------------------------------------------------
