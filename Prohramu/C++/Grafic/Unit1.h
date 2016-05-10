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
        TLabel *Label1;
        TEdit *Edit1;
        TEdit *Edit2;
        TComboBox *ComboBox1;
        TLabel *Label2;
        TBitBtn *BitBtn1;
        TComboBox *ComboBox2;
        TLabel *Label3;
        TComboBox *ComboBox3;
        TLabel *Label4;
        TSplitter *Splitter1;
        TPaintBox *Image1;
        void __fastcall BitBtn1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
