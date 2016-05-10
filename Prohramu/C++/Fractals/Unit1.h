//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TPanel *Panel2;
        TComboBox *ComboBox1;
        TLabel *Label1;
        TBitBtn *BitBtn1;
        TPaintBox *PaintBox1;
        TSplitter *Splitter1;
        TEdit *Edit1;
        TEdit *Edit2;
        TLabel *Label2;
        TLabeledEdit *LabeledEdit1;
        TBitBtn *BitBtn2;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TEdit *Edit3;
        TEdit *Edit4;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label10;
        TBitBtn *BitBtn3;
        TEdit *Edit5;
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall BitBtn2Click(TObject *Sender);
        void __fastcall BitBtn3Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
