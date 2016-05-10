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
//---------------------------------------------------------------------------
class TForm2 : public TForm
{
__published:	// IDE-managed Components
	TOpenDialog *OpenDialog1;
	TPageControl *PageControl1;
	TTabSheet *TabSheet1;
	TTabSheet *TabSheet2;
	TLabel *Label1;
	TLabel *Label2;
	TPanel *Panel2;
	TBitBtn *BitBtn2;
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
	TMenuItem *View1;
	TMenuItem *Onlyread1;
	TMenuItem *On1;
	TMenuItem *Off1;
	TMenuItem *Deleteselections1;
	TMenuItem *Deleteline1;
	TMenuItem *CopyAll1;
	TMenuItem *ransparency1;
	TMenuItem *Increece1;
	TMenuItem *Dicreece1;
	TMenuItem *Normal1;
	TMenuItem *Autoscrolling1;
	TMenuItem *Speeds1;
	TMenuItem *More1;
	TMenuItem *Less1;
	TTimer *Timer1;
	TMenuItem *Setting2;
	TMenuItem *Laying1;
	TMenuItem *Create1;
	TMenuItem *Goto1;
	TMenuItem *Delete1;
	TMenuItem *Mause1;
	TMenuItem *Off2;
	TMenuItem *On2;
	TOpenPictureDialog *OpenPictureDialog1;
	TSpeedButton *SpeedButton8;
	TSpeedButton *SpeedButton10;
	TSpeedButton *SpeedButton11;
	TSpeedButton *SpeedButton12;
	TMenuItem *Pagesetting1;
	TPageSetupDialog *PageSetupDialog1;
	void __fastcall NewCtrlN1Click(TObject *Sender);
	void __fastcall OpenCtrlO1Click(TObject *Sender);
	void __fastcall SaveCtrlS1Click(TObject *Sender);
	void __fastcall SaveAsCtrlAltS1Click(TObject *Sender);
	void __fastcall Setting1Click(TObject *Sender);
	void __fastcall Exit1Click(TObject *Sender);
	void __fastcall FoundCtrlF1Click(TObject *Sender);
	void __fastcall ChangeCtrl1Click(TObject *Sender);
	void __fastcall Inserttime1Click(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall SelectAllCtrlA1Click(TObject *Sender);
	void __fastcall InsertCtrlV1Click(TObject *Sender);
	void __fastcall CopyCtrlC1Click(TObject *Sender);
	void __fastcall CutCtrlX1Click(TObject *Sender);
	void __fastcall UndoCtrlZ1Click(TObject *Sender);
	void __fastcall Increeseshift1Click(TObject *Sender);
	void __fastcall Degreeseshift1Click(TObject *Sender);
	void __fastcall Normalshift1Click(TObject *Sender);
	void __fastcall On1Click(TObject *Sender);
	void __fastcall Off1Click(TObject *Sender);
	void __fastcall Deleteline1Click(TObject *Sender);
	void __fastcall Deleteselections1Click(TObject *Sender);
	void __fastcall Redo1Click(TObject *Sender);
	void __fastcall CopyAll1Click(TObject *Sender);
	void __fastcall ransparency1Click(TObject *Sender);
	void __fastcall Increece1Click(TObject *Sender);
	void __fastcall Dicreece1Click(TObject *Sender);
	void __fastcall Normal1Click(TObject *Sender);
	void __fastcall Autoscrolling1Click(TObject *Sender);
	void __fastcall More1Click(TObject *Sender);
	void __fastcall Less1Click(TObject *Sender);
	void __fastcall Setting2Click(TObject *Sender);
	void __fastcall Create1Click(TObject *Sender);
	void __fastcall Delete1Click(TObject *Sender);
	void __fastcall Goto1Click(TObject *Sender);
	void __fastcall Off2Click(TObject *Sender);
	void __fastcall On2Click(TObject *Sender);
	void __fastcall ransferwords1Click(TObject *Sender);
	void __fastcall Help2Click(TObject *Sender);
	void __fastcall SpeedButton12Click(TObject *Sender);
	void __fastcall SpeedButton10Click(TObject *Sender);
	void __fastcall SpeedButton8Click(TObject *Sender);
	void __fastcall BitBtn6Click(TObject *Sender);
	void __fastcall BitBtn5Click(TObject *Sender);
	void __fastcall BitBtn4Click(TObject *Sender);
	void __fastcall SpeedButton1Click(TObject *Sender);
	void __fastcall SpeedButton2Click(TObject *Sender);
	void __fastcall SpeedButton3Click(TObject *Sender);
	void __fastcall SpeedButton4Click(TObject *Sender);
	void __fastcall SpeedButton5Click(TObject *Sender);
	void __fastcall SpeedButton6Click(TObject *Sender);
	void __fastcall SpeedButton7Click(TObject *Sender);
	void __fastcall Pagesetting1Click(TObject *Sender);
	void __fastcall PrintCtrlP1Click(TObject *Sender);
	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall SpeedButton9Click(TObject *Sender);
	void __fastcall SpeedButton11Click(TObject *Sender);
	void __fastcall BitBtn2Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TForm2(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm2 *Form2;
//---------------------------------------------------------------------------
#endif
