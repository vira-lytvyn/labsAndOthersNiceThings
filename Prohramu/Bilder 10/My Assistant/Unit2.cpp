//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm2 *Form2;
int Zakladka;
//---------------------------------------------------------------------------
__fastcall TForm2::TForm2(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------




void __fastcall TForm2::NewCtrlN1Click(TObject *Sender)  //
{
	if (RichEdit1->Lines->Count>0)
  {
   if (MessageBox(0," Save this document? ",
   "Click Yes або No !",MB_YESNO)==IDYES)
    {
	 SaveCtrlS1Click(Sender);
	}
  }
 RichEdit1->Clear();
 StatusBar1->Panels->Items[0]->Text="Doc1";
}
//---------------------------------------------------------------------------

void __fastcall TForm2::OpenCtrlO1Click(TObject *Sender)  //
{
	    if (OpenDialog1->Execute())
		RichEdit1->Lines->LoadFromFile(OpenDialog1->FileName);
		StatusBar1->Panels->Items[0]->Text=OpenDialog1->FileName;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SaveCtrlS1Click(TObject *Sender) //
{
   if (SaveDialog1->Execute()){
   RichEdit1->Lines->SaveToFile(SaveDialog1->FileName);
   StatusBar1->Panels->Items[0]->Text=SaveDialog1->FileName;
   }

}
//---------------------------------------------------------------------------

void __fastcall TForm2::SaveAsCtrlAltS1Click(TObject *Sender)  //
{
if (SaveDialog1->Execute()){
   RichEdit1->Lines->SaveToFile(SaveDialog1->FileName);
   StatusBar1->Panels->Items[0]->Text=SaveDialog1->FileName;
   }
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Setting1Click(TObject *Sender)  //
{
	PrinterSetupDialog1->Execute();

}
//---------------------------------------------------------------------------


void __fastcall TForm2::Exit1Click(TObject *Sender)  //
{
	   Close();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::FoundCtrlF1Click(TObject *Sender)//
{
	FindDialog1->Execute();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::ChangeCtrl1Click(TObject *Sender) //
{
	 ReplaceDialog1->Execute();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Inserttime1Click(TObject *Sender)   //
{
	RichEdit1->SelText = DateTimeToStr(Now());
}
//---------------------------------------------------------------------------

void __fastcall TForm2::FormCreate(TObject *Sender)
{
	RichEdit1->Text = "";
}
//---------------------------------------------------------------------------


void __fastcall TForm2::SelectAllCtrlA1Click(TObject *Sender)
{
	RichEdit1->SelectAll();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::InsertCtrlV1Click(TObject *Sender)
{
	RichEdit1->PasteFromClipboard();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::CopyCtrlC1Click(TObject *Sender)
{
	RichEdit1->CopyToClipboard();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::CutCtrlX1Click(TObject *Sender)
{
	  RichEdit1->CutToClipboard();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::UndoCtrlZ1Click(TObject *Sender)
{
	RichEdit1->Undo();
}
//---------------------------------------------------------------------------


void __fastcall TForm2::Increeseshift1Click(TObject *Sender)
{
	RichEdit1->Font->Size = RichEdit1->Font->Size + 1;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Degreeseshift1Click(TObject *Sender)
{
	   RichEdit1->Font->Size = RichEdit1->Font->Size - 1;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Normalshift1Click(TObject *Sender)
{
	RichEdit1->Font->Size = 12;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::On1Click(TObject *Sender)
{
	RichEdit1->ReadOnly = true;
	On1->Enabled = false;
	Off1->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Off1Click(TObject *Sender)
{
	 RichEdit1->ReadOnly = false;
	 On1->Enabled = true;
	 Off1->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Deleteline1Click(TObject *Sender)
{
	RichEdit1->Lines->Delete(RichEdit1->CaretPos.y);
}
//---------------------------------------------------------------------------


void __fastcall TForm2::Deleteselections1Click(TObject *Sender)
{
	RichEdit1->ClearSelection();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Redo1Click(TObject *Sender)
{
	RichEdit1->ClearUndo();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::CopyAll1Click(TObject *Sender)
{
	RichEdit1->SelectAll();
	RichEdit1->CopyToClipboard();
	RichEdit1->SelLength = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::ransparency1Click(TObject *Sender)
{
	  Form2->AlphaBlend = Enabled;

}
//---------------------------------------------------------------------------


void __fastcall TForm2::Increece1Click(TObject *Sender)
{
		RichEdit1->Font->Size = RichEdit1->Font->Size+1;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Dicreece1Click(TObject *Sender)
{
		RichEdit1->Font->Size = RichEdit1->Font->Size-1;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Normal1Click(TObject *Sender)
{
		RichEdit1->Font->Size = 12;
}
//---------------------------------------------------------------------------


void __fastcall TForm2::Autoscrolling1Click(TObject *Sender)
{
	if (Timer1->Enabled == False) {
	Timer1->Enabled = True;

	}
}
//---------------------------------------------------------------------------

void __fastcall TForm2::More1Click(TObject *Sender)
{
	if(Form2->Timer1->Interval<=5000)
	Form2->Timer1->Interval = Form2->Timer1->Interval+100;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Less1Click(TObject *Sender)
{
	 if(Form2->Timer1->Interval>=100)
	 Form2->Timer1->Interval = Form2->Timer1->Interval-100;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Setting2Click(TObject *Sender)
{
	FontDialog1->Font = RichEdit1->Font;
	if (FontDialog1->Execute())
	RichEdit1->Font = FontDialog1->Font;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Create1Click(TObject *Sender)
{
	Zakladka = RichEdit1->CaretPos.y;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Delete1Click(TObject *Sender)
{
	  Zakladka = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Goto1Click(TObject *Sender)
{
	if ((Zakladka>0)& (Zakladka <= RichEdit1->Lines->Capacity) ) {
		RichEdit1->Lines->Move(RichEdit1->Lines->Capacity+1, Zakladka);
		RichEdit1->Lines->Delete(Zakladka);
	}
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Off2Click(TObject *Sender)
{
	int CState;
	CState = ShowCursor(False);
	On2->Enabled = True;
	Off2->Enabled = False;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::On2Click(TObject *Sender)
{
	int CState;
	CState = ShowCursor(True);
	Off2->Enabled = True;
	On2->Enabled = False;
}
//---------------------------------------------------------------------------

void __fastcall TForm2::ransferwords1Click(TObject *Sender)
{
	if (RichEdit1->ScrollBars == ssVertical)
	{
		RichEdit1->ScrollBars = ssBoth;
	}
	else {
		RichEdit1->ScrollBars = ssVertical;
	}

}
//---------------------------------------------------------------------------

void __fastcall TForm2::Help2Click(TObject *Sender)
{
	TForm * Formochka= new TForm(this);
TLabel* label=new TLabel(Application);
TLabel* lab=new TLabel(Application);
TImage* im =new TImage(Application);
im->Parent=Formochka;
im->Left=5;
im->Top=5;
im->Show();
Formochka->Caption="About Program";
Formochka->Left=300;
Formochka->Top=400;
Formochka->Color= clYellow;
label->Parent=Formochka;
label->Font->Name = "Times New Roman";
label->Font->Height = 40;
label->Font->Color = clBlue;
label->Caption="My Assistsnt";
label->Left=5;
label->Top=5;
label->Show();
lab->Parent=Formochka;
lab->Font->Name = "Times New Roman";
lab->Font->Height = 20;
lab->Font->Color = clAqua;
lab->Caption="Write  to the autor : BateRfluy@gmail.com";
lab->Left=5;
lab->Top=110;
lab->Show();
Formochka->ShowModal();
delete Formochka;

}
//---------------------------------------------------------------------------


void __fastcall TForm2::SpeedButton12Click(TObject *Sender)
{
if (ColorDialog1->Execute()) {
	RichEdit1->Font->Color = ColorDialog1->Color;
}
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton10Click(TObject *Sender)
{
	Create1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton8Click(TObject *Sender)
{
	Off2Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::BitBtn6Click(TObject *Sender)
{
	Setting1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::BitBtn5Click(TObject *Sender)
{
	PrintCtrlP1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::BitBtn4Click(TObject *Sender)
{
	Setting2Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton1Click(TObject *Sender)
{
	NewCtrlN1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton2Click(TObject *Sender)
{
	OpenCtrlO1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton3Click(TObject *Sender)
{
	SaveCtrlS1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton4Click(TObject *Sender)
{
	SaveAsCtrlAltS1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton5Click(TObject *Sender)
{
	CopyCtrlC1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton6Click(TObject *Sender)
{
	InsertCtrlV1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton7Click(TObject *Sender)
{
	CutCtrlX1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Pagesetting1Click(TObject *Sender)
{
	PageSetupDialog1->Execute();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::PrintCtrlP1Click(TObject *Sender)
{
	PrintDialog1->Execute();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::BitBtn1Click(TObject *Sender)
{
	Pagesetting1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton9Click(TObject *Sender)
{
	On1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SpeedButton11Click(TObject *Sender)
{
	Autoscrolling1Click(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::BitBtn2Click(TObject *Sender)
{
	UndoCtrlZ1Click(Sender);
}
//---------------------------------------------------------------------------

