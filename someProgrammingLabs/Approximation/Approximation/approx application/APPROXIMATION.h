//---------------------------------------------------------------------------

#ifndef APPROXIMATIONH
#define APPROXIMATIONH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TStringGrid *StringGrid1;
    TPaintBox *PaintBox1;
    TButton *Button1;
    TCheckBox *CheckBox1;
    TEdit *Edit1;
    TEdit *Edit2;
    TEdit *Edit3;
    TCheckBox *CheckBox2;
    TCheckBox *CheckBox3;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TLabel *Label5;
    TEdit *Edit4;
    TEdit *Edit5;
    TCheckBox *CheckBox4;
    TCheckBox *CheckBox5;
    TEdit *Edit6;
    TEdit *Edit7;
    TCheckBox *CheckBox6;
    TCheckBox *CheckBox7;
    TLabel *Label6;
    TLabel *Label7;
    TStringGrid *StringGrid2;
    TLabel *Label8;
    TCheckBox *CheckBox8;
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
