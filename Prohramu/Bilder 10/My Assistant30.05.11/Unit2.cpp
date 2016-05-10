//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm2 *Form2;
//---------------------------------------------------------------------------
__fastcall TForm2::TForm2(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------




void __fastcall TForm2::NewCtrlN1Click(TObject *Sender)  // Новий документ
{
	/*if (RichEdit1->Modified) {
		switch (Application->MessageBoxA("Document was modified. Save?'", "Error", ?)) {
		case 0:

        default:
			;
		}    */
	/*if RichEdit1.Modified = true then
begin
case Application.MessageBox('Документ был изменён. Сохранить?', 'Внимание!',
  MB_YESNOCANCEL + MB_ICONQUESTION) of
  IDYES:
begin
  N6.Click;
if RichEdit1.Modified = false then
begin
  RichEdit1.Clear;
  OpenFile:='';
  Form1.Caption:='Текстовый редактор';
  RichEdit1.Modified:= false;
end;
end;
  IDNO:
begin
  RichEdit1.Clear;
  OpenFile:='';
  Form1.Caption:='Текстовый редактор';
  RichEdit1.Modified:= false;
end;
end;
end
else
begin
  RichEdit1.Clear;
  OpenFile:='';
  Form1.Caption:='Текстовый редактор';
  RichEdit1.Modified:= false;
end;*/

}
//---------------------------------------------------------------------------

void __fastcall TForm2::OpenCtrlO1Click(TObject *Sender)  // Open
{
    if (RichEdit1->Modified)
  {

	  switch (MessageBox(NULL, "Document was modified! Save?", "Request for saving", MB_YESNOCANCEL | MB_ICONQUESTION))
	  {
	  case IDCANCEL:
	  {
		Abort;
	  }
	  case IDYES:
	  {
		SaveCtrlS1Click(Sender);
		if (!(RichEdit1->Modified))
		{
			if (OpenTextFileDialog1->Execute())
			{
				RichEdit1->Lines->LoadFromFile(OpenDialog1->FileName);
				OpenFile() = OpenTextFileDialog1->FileName;
				Form2->Caption =  ExtractFileName(OpenFile) + "- My Assistant" ;
				RichEdit1->Modified = false;
			}
		}
	  IDNO:
	  {
		   if (OpenTextFileDialog1->Execute())
		   {
				RichEdit1->Lines->LoadFromFile(OpenTextFileDialog1->FileName);
				OpenFile = Open
		   }
	  }
	  }
	  }
  }
 /*/ IDNO:
/*{
if (OpenTextFileDialog1->Execute()){
  RichEdit1->Lines->LoadFromFile(OpenTextFileDialog1->FileName);
  /*OpenFile = OpenTextFileDialog1->FileName;
  Label1->Caption = ExtractFileName();
  RichEdit1->Modified = false;
}
}  */
//end;
//end
/*if (OpenTextFileDialog1->Execute())
{
  RichEdit1->Lines->LoadFromFile(OpenTextFileDialog1->FileName);
  /*OpenFile = OpenTextFileDialog1->FileName;
  Label1->Caption = ExtractFileName(OpenFile); */
  /*RichEdit1->Modified = false;
} */
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SaveCtrlS1Click(TObject *Sender) //Зберегти
{
   /*	if (OpenFile()) {
		RichEdit1->Lines->SaveToFile(OpenFile());   */
	   //	RichEdit1->Modified = false;
	  /* SaveAsCtrlAltS1->Click;
									*/
	/*
    begin
if OpenFile <> '' then
begin
  RichEdit1.Lines.SaveToFile(OpenFile);
  RichEdit1.Modified:= false;
end
else
  N7.Click;
end;
	*/
}
//---------------------------------------------------------------------------

void __fastcall TForm2::SaveAsCtrlAltS1Click(TObject *Sender)  // Save As
{
	//SetPriorityClass(ProcessHandle,HIGH_PRIORITY_CLASS);
	if (SaveTextFileDialog1->Execute())
	{
		RichEdit1->Lines->SaveToFile(SaveDialog1->FileName);
	}
	OpenDialog1->FileName = SaveDialog1->FileName;
	Form2->Caption = SaveDialog1->FileName+"- My Assistant";
	Application->Title = ExtractFileName(SaveDialog1->FileName);
	//SetPriorityClass(ProcessHandle, NORMAL_PRIORITY_CLASS);

		/*
		if (SaveDialog1.Execute=True) then
RichEdit1.Lines.SaveToFile(SaveDialog1.FileName);
OpenDialog1.FileName:=SaveDialog1.FileName;
Form1.Caption:='Text  '+SaveDialog1.FileName;
Application.Title:=ExtractFileName(SaveDialog1.FileName);
SetPriorityClass(ProcessHandle,NORMAL_PRIORITY_CLASS);
	   case SaveTextFileDialog1.FilterIndex of
  1: SaveTextFileDialog1.DefaultExt:='txt';
end;
if SaveTextFileDialog1.Execute then
begin
  RichEdit1.Lines.SaveToFile(SaveTextFileDialog1.FileName);
  OpenFile:=SaveTextFileDialog1.FileName;
  Form1.Caption:='Текстовый редактор - '+ExtractFileName(OpenFile);
  RichEdit1.Modified:= false;
end
	*/
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Setting1Click(TObject *Sender)  //  parametry druku

{
	PrinterSetupDialog1->Execute();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::PrintCtrlP1Click(TObject *Sender) // druk
{
   if(PrintDialog1->Execute() == True){
		RichEdit1->Print(Application->Title);
   }
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Exit1Click(TObject *Sender)  // vuhid
{
	   Close();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::FoundCtrlF1Click(TObject *Sender)//  Poshuk
{
	FindDialog1->Execute();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::ChangeCtrl1Click(TObject *Sender) // Zamina
{
	 ReplaceDialog1->Execute();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Inserttime1Click(TObject *Sender)   //Vstavyty chas
{
   RichEdit1->SelText = DateTimeToStr(Now());
}
//---------------------------------------------------------------------------

void __fastcall TForm2::ransferwords1Click(TObject *Sender)  // Perenos po slovah
{
	if (RichEdit1->ScrollBars == ssVertical)
	{
		RichEdit1->ScrollBars = ssBoth;
	}
	else
	{
        RichEdit1->ScrollBars = ssVertical;
	}
}
//---------------------------------------------------------------------------

void __fastcall TForm2::Font1Click(TObject *Sender)      // Shryft
{
	FontDialog1->Font = RichEdit1->Font;
	if (FontDialog1->Execute())
	RichEdit1->Font = FontDialog1->Font;
}
//---------------------------------------------------------------------------


void __fastcall TForm2::FormCloseQuery(TObject *Sender, bool &CanClose)
{
  if (RichEdit1->Modified)
  {

	  switch (MessageBox(NULL, "Document was modified! Save?", "Request for saving", MB_YESNOCANCEL | MB_ICONQUESTION))
	  {
	  case IDCANCEL:
	  {
		Abort;
	  }
	  case IDYES:
	  {
		SaveCtrlS1Click(Sender);
		if (RichEdit1->Modified)
		{
			CanClose = False;
		}
	  }
	  default:
          ;
	  }
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm2::FindDialog1Find(TObject *Sender)
{
	/*int  StartPos, ToPos, FoundPos;
	TSearchTypes  Opt;
	if (frMatchCase in(FindDialog1->Options)  )
	{
		Opt = [stMatchCase];
	}
	if (frWholeWord in FindDialog1->Options)
	{
		Opt = Opt+[stWholeWord];
	}
	StartPos = RichEdit1->SelStart+RichEdit1->SelLength;
  ToPos = Length(RichEdit1->Text)-StartPos;
  FoundPos = RichEdit1->FindText(FindDialog1->FindText, StartPos, ToPos, Opt);
  if (FoundPos != -1)
  {
	  RichEdit1->SelStart = FoundPos;
	  RichEdit1->SelLength = Length(FindDialog1->FindText);
	  RichEdit1->SetFocus;
  }
  else
	MessageBox(FindDialog1->Handle, 'Поиск завершён!', '', MB_ICONIFORMATION); */
}
//---------------------------------------------------------------------------

void __fastcall TForm2::ReplaceDialog1Find(TObject *Sender)
{
/*
var
  StartPos, ToPos, FoundPos: Integer;
  Opt: TSearchTypes;
begin
if frMatchCase in ReplaceDialog1.Options then
  Opt:=[stMatchCase];
if frWholeWord in ReplaceDialog1.Options then
  Opt:=Opt+[stWholeWord];
StartPos:=RichEdit1.SelStart+RichEdit1.SelLength;
ToPos:=Length(RichEdit1.Text)-StartPos;
FoundPos:=RichEdit1.FindText(ReplaceDialog1.FindText, StartPos, ToPos, Opt);
if FoundPos<>-1 then
begin
  RichEdit1.SelStart:=FoundPos;
  RichEdit1.SelLength:=Length(ReplaceDialog1.FindText);
  RichEdit1.SetFocus;
end
else
  MessageBox(ReplaceDialog1.Handle, 'Поиск завершён!', '', MB_ICONINFORMATION);
end;
*/
}
//---------------------------------------------------------------------------

void __fastcall TForm2::ReplaceDialog1Replace(TObject *Sender)
{
/*
var
  i, StartPos, ToPos, FoundPos: Integer;
  Opt: TSearchTypes;
begin
if frMatchCase in ReplaceDialog1.Options then
  Opt:=[stMatchCase];
if frWholeWord in ReplaceDialog1.Options then
  Opt:=Opt+[stWholeWord];
  i:=0;
repeat
  StartPos:=RichEdit1.SelStart+RichEdit1.SelLength;
  ToPos:=Length(RichEdit1.Text)-StartPos;
  FoundPos:=RichEdit1.FindText(ReplaceDialog1.FindText, StartPos, ToPos, Opt);
if FoundPos<>-1 then
begin
  RichEdit1.SelStart:=FoundPos;
  RichEdit1.SelLength:=Length(ReplaceDialog1.FindText);
  RichEdit1.SelText:=ReplaceDialog1.ReplaceText;
  RichEdit1.SetFocus;
  inc(i);
end;
until (FoundPos=-1) or not(frReplaceAll in ReplaceDialog1.Options);
if i=0 then
  MessageBox(ReplaceDialog1.Handle, 'Поиск завершён!', '', MB_ICONINFORMATION)
else
if frReplaceAll in ReplaceDialog1.Options then
  ShowMessage('Произведено '+IntToStr(i)+' замен');
end;
*/
}
//---------------------------------------------------------------------------


void __fastcall TForm2::FormCreate(TObject *Sender)
{
	RichEdit1->Text = "";
}
//---------------------------------------------------------------------------


void __fastcall TForm2::BitBtn6Click(TObject *Sender)  // parametry storinky
{
     PageSetupDialog1->Execute();
}
//---------------------------------------------------------------------------

