//---------------------------------------------------------------------------
#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <dstring.h>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:
        TListBox *ListBox1;
        TGroupBox *GroupBox1;
        TPanel *Panel1;
        TPanel *Panel3;
        TLabel *Label3;
        TPanel *Panel4;
        TLabel *Label4;
        TPanel *Panel5;
        TLabel *Label5;
        TPanel *Panel6;
        TLabel *Label6;
        TPanel *Panel7;
        TLabel *Label7;
        TPanel *Panel8;
        TLabel *Label8;
        TPanel *Panel9;
        TLabel *Label9;
        TPanel *Panel10;
        TLabel *Label10;
        TPanel *Panel11;
        TLabel *Label11;
        TGroupBox *GroupBox2;
        TPanel *Panel12;
        TGroupBox *GroupBox3;
        TEdit *Edit1;
        TButton *Button1;
        TPanel *Panel2;
        TLabel *Label2;
        TEdit *Edit2;
        TButton *Button2;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
public:
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//------------------------------------------------------------------------------
#endif
//------------------------------------------------------------------------------
class bukva
{
public:
        char* c;
};
//------------------------------------------------------------------------------
class slovo:public bukva
{
public:
      char* s1;
      char* s2;
      char clovo[10];
      AnsiString ot;
      AnsiString chto;
      AnsiString temp;
//------------------------------------------------------------------------------
void get_s(int _n)
{
 int d;
 Form1->Edit2->Text="";

 // AnsiString
 ot = Form1->ListBox1->Items->Strings[_n];
 // AnsiString
 chto = Form1->Edit1->Text;

char* s1=new char[10];
char* s2;
s1=ot.c_str();
s2=chto.c_str();
          Form1->Edit2->Text=Form1->ListBox1->Items->Strings[_n-1];
          d=StrLen(s1);
            int i=0;
            for (i=0;i<d;i++)
                if (s1[i]==s2[0])
                    {
                     vivod(i+1,s2);
                    }
}
//------------------------------------------------------------------------------
void vivod(int _num, char *sl)
{
 
switch(_num)
{
case  1: Form1->Label2->Caption=sl; temp.Insert(sl,temp.Length()+1);break;
case  2: Form1->Label3->Caption=sl;temp.Insert(sl,temp.Length()+1);break;
case  3: Form1->Label4->Caption=sl;temp.Insert(sl,temp.Length()+1);break;
case  4: Form1->Label5->Caption=sl;temp.Insert(sl,temp.Length()+1);break;
case  5: Form1->Label6->Caption=sl;temp.Insert(sl,temp.Length()+1);break;
case  6: Form1->Label7->Caption=sl;temp.Insert(sl,temp.Length()+1);break;
case  7: Form1->Label8->Caption=sl;temp.Insert(sl,temp.Length()+1);break;
case  8: Form1->Label9->Caption=sl;temp.Insert(sl,temp.Length()+1);break;
case  9: Form1->Label10->Caption=sl;temp.Insert(sl,temp.Length()+1);break;
case 10: Form1->Label11->Caption=sl;temp.Insert(sl,temp.Length()+1);break;
}

if (temp.Length()==StrLen(ot.c_str()))
{
 ShowMessage("Otgadal");
 clear();
}
}
//------------------------------------------------------------------------------
void clear()
{
temp="";
Form1->Label2->Caption="";
Form1->Label3->Caption="";
Form1->Label4->Caption="";
Form1->Label5->Caption="";
Form1->Label6->Caption="";
Form1->Label7->Caption="";
Form1->Label8->Caption="";
Form1->Label9->Caption="";
Form1->Label10->Caption="";
Form1->Label11->Caption="";
}
//------------------------------------------------------------------------------
};
