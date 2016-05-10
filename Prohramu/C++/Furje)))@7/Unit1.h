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
        TSplitter *Splitter1;
        TLabel *Label1;
        TComboBox *ComboBox1;
        TLabel *Label2;
        TEdit *Edit1;
        TEdit *Edit2;
        TLabel *Label3;
        TComboBox *ComboBox2;
        TLabel *Label4;
        TLabel *Label5;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TPaintBox *Image1;
        TPaintBox *Image2;
        TLabel *Label6;
        TLabel *Label7;
        TEdit *Edit3;
        void __fastcall BitBtn2Click(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
