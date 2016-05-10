//---------------------------------------------------------------------------

#ifndef Unit2H
#define Unit2H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
#include <Buttons.hpp>
#include <Menus.hpp>
#include <ActnList.hpp>
#include <ExtDlgs.hpp>
#include <Windows.h>
#include <Messages.hpp>
#include <SysUtils.hpp>
#include <Variants.hpp>
#include <ActnMan.hpp>
#include <ActnColorMaps.hpp>
#include <XPMan.hpp>
#include <ShellAPI.hpp>
/*, , , ,
  ,
  , , ; */
//---------------------------------------------------------------------------
class TForm2 : public TForm
{
__published:	// IDE-managed Components
	TOpenDialog *OpenDialog1;
	TPageControl *PageControl1;
	TTabSheet *TabSheet1;
	TTabSheet *TabSheet2;
	TMainMenu *MainMenu1;
	TMenuItem *Menu1;
	TMenuItem *File1;
	TMenuItem *Correct1;
	TMenuItem *Format1;
	TMenuItem *Help1;
	TMenuItem *NewCtrlN1;
	TMenuItem *OpenCtrlO1;
	TMenuItem *SaveCtrlS1;
	TMenuItem *SaveAsCtrlAltS1;
	TMenuItem *Print1;
	TMenuItem *Exit1;
	TMenuItem *Setting1;
	TMenuItem *PrintCtrlP1;
	TMenuItem *UndoCtrlZ1;
	TMenuItem *CutCtrlX1;
	TMenuItem *CopyCtrlC1;
	TMenuItem *InsertCtrlV1;
	TMenuItem *DeleteCtrlD1;
	TMenuItem *SelectAllCtrlA1;
	TMenuItem *FoundCtrlF1;
	TMenuItem *ChangeCtrl1;
	TMenuItem *Inserttime1;
	TMenuItem *ransferwords1;
	TMenuItem *Font1;
	TMenuItem *Help2;
	TRichEdit *RichEdit1;
	TActionList *ActionList1;
	TReplaceDialog *ReplaceDialog1;
	TFindDialog *FindDialog1;
	TOpenTextFileDialog *OpenTextFileDialog1;
	TSaveTextFileDialog *SaveTextFileDialog1;
	TFontDialog *FontDialog1;
	TPrintDialog *PrintDialog1;
	TPrinterSetupDialog *PrinterSetupDialog1;
	TPopupMenu *PopupMenu1;
	TSpeedButton *SpeedButton1;
	TSpeedButton *SpeedButton2;
	TSpeedButton *SpeedButton3;
	TSpeedButton *SpeedButton4;
	TSpeedButton *SpeedButton5;
	TSpeedButton *SpeedButton6;
	TSpeedButton *SpeedButton7;
	TColorDialog *ColorDialog1;
	TTabSheet *TabSheet3;
	TSpeedButton *SpeedButton9;
	TBitBtn *BitBtn1;
	TBitBtn *BitBtn4;
	TBitBtn *BitBtn5;
	TBitBtn *BitBtn6;
	TStatusBar *StatusBar1;
	TSaveDialog *SaveDialog1;
	TPageSetupDialog *PageSetupDialog1;
	void __fastcall NewCtrlN1Click(TObject *Sender);
	void __fastcall OpenCtrlO1Click(TObject *Sender);
	void __fastcall SaveCtrlS1Click(TObject *Sender);
	void __fastcall SaveAsCtrlAltS1Click(TObject *Sender);
	void __fastcall Setting1Click(TObject *Sender);
	void __fastcall PrintCtrlP1Click(TObject *Sender);
	void __fastcall Exit1Click(TObject *Sender);
	void __fastcall FoundCtrlF1Click(TObject *Sender);
	void __fastcall ChangeCtrl1Click(TObject *Sender);
	void __fastcall Inserttime1Click(TObject *Sender);
	void __fastcall ransferwords1Click(TObject *Sender);
	void __fastcall Font1Click(TObject *Sender);
	void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
	void __fastcall FindDialog1Find(TObject *Sender);
	void __fastcall ReplaceDialog1Find(TObject *Sender);
	void __fastcall ReplaceDialog1Replace(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall BitBtn6Click(TObject *Sender);

private:	// User declarations
public:		// User declarations
	__fastcall TForm2(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm2 *Form2;
//---------------------------------------------------------------------------
#endif
