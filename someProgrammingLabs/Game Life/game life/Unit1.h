//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TGroupBox *GroupBox1;
        TGroupBox *GroupBox2;
        TGroupBox *GroupBox3;
        TEdit *Edit1;
        TEdit *Edit2;
        TEdit *Edit3;
        TEdit *Edit4;
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TLabel *Label6;
        TButton *Button1;
        TButton *Button2;
        TLabel *Label7;
        TLabel *Label8;
        TEdit *Edit5;
        TEdit *Edit6;
        TShape *Shape1;
        TShape *Shape2;
        TTimer *Timer1;
        void __fastcall FormPaint(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
class TCells
{
public:
        int size;
        void init(_size){size=_size;}
};
class TDoska:public TCells
{
public:
  TDoska()
   {
    init(33);
   }
 void draw()
 {

for (int i=0;i<10;i++)
for (int j=0;j<10;j++)
{
 Form1->Canvas->Brush->Color=clWhite;
 Form1->Canvas->Ellipse(i*size,j*size,(i+1)*size,(j+1)*size);
 }
}
};
//---------------------------------------------------------------------------
class TFishka
{
public:
        int mas[10][10];
        TColor color[10][10];
        int x,y,size;
        int count_1,count_2;
//-------------
        TFishka();
//-------------
        void draw_greed()
        {
        int i,j;
        for ( i=0;i<10;i++)
        for ( j=0;j<10;j++)
        {
         Form1->Canvas->Brush->Color=color[i][j];
         Form1->Canvas->Ellipse(i*size,j*size,(i+1)*size,(j+1)*size);
        }
        }
//-------------
        void draw()
        {
                Form1->Canvas->Brush->Color=color[x][y];
                Form1->Canvas->Ellipse(x*size,y*size,(x+1)*size,(y+1)*size);
        }
//-------------
        void init(int _x, int _y, TColor _c, int __gamer);
//-------------
        void Game_over()
        {
int i,j,t1,t2,_gamer;
t1=100;_gamer=0;t2=0;

for (i=0;i<10;i++)
for (j=0;j<10;j++)
if (mas[i][j]==1){t2++;}

if (t2==t1)
{
if (count_1>count_2){_gamer=1;} else {_gamer=2;}
Form1->Button1->Enabled=false;
Form1->Button2->Enabled=false;
ShowMessage("Game Over!!! Выиграл игрок ["+IntToStr(_gamer)+"]");
}
}
//-------------
};
//------------------------------------------------------------------------------
void TFishka::init(int _x, int _y, TColor _c, int __gamer)
{
 int temp;
 x=_x;
 y=_y;
temp=0;
 if (mas[x][y]==0)     {color[x][y]=_c;     mas[x][y]=1;     temp++;}
 if (mas[x+1][y]==0)   {color[x+1][y]=_c;   mas[x+1][y]=1;   temp++;}
 if (mas[x-1][y]==0)   {color[x-1][y]=_c;   mas[x-1][y]=1;   temp++;}
 if (mas[x][y+1]==0)   {color[x][y+1]=_c;   mas[x][y+1]=1;   temp++;}
 if (mas[x][y-1]==0)   {color[x][y-1]=_c;   mas[x][y-1]=1;   temp++;}
 if (mas[x+1][y-1]==0) {color[x+1][y-1]=_c; mas[x+1][y-1]=1; temp++;}
 if (mas[x+1][y+1]==0) {color[x+1][y+1]=_c; mas[x+1][y+1]=1; temp++;}
 if (mas[x-1][y-1]==0) {color[x-1][y-1]=_c; mas[x-1][y-1]=1; temp++;}
 if (mas[x-1][y+1]==0) {color[x-1][y+1]=_c; mas[x-1][y+1]=1; temp++;}

switch(__gamer)
{
case 1 : count_1+=temp;break;
case 2 : count_2+=temp;break;
}
}
//------------------------------------------------------------------------------
TFishka::TFishka()
{
 for (int i=0;i<10;i++)
  for (int j=0;j<10;j++)
 {color[i][j]=clWhite;
 mas[i][j]=0;}
 count_1=0;
 count_2=0;
  size=33;
}




