unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
function f(x:real):real;
begin
     f:=x+sqr(ln(x));
end;
procedure TForm2.Button1Click(Sender: TObject);
label K;
var
a,b,g,d,c,w,x,fd,fc:real;
begin
  a:=StrtoFloat(Edit1.Text);
  b:=StrtoFloat(Edit2.Text);
  g:=StrtoFloat(Edit3.Text);
   if a>b then
   begin
      w:=a;
      a:=b;
      b:=w;
   end;
    K:
     d:=a+(b-a)*(sqrt(5)-1)/2;
     fd:=f(d);
     c:=b-(b-a)*(sqrt(5)-1)/2;
     fc:=f(c);
  //   while abs(b-a)<g do
    //  begin
         if fc>=fd then
         begin
           //b:=d;
           //d:=c;
           //c:=b-(b-a)*(sqrt(5)-1)/2;
           //fd:=fc;
           //fc:=f(c);
           a:=c;
          end
          else
          begin
          //a:=c;
           //c:=d;
           //d:=a+(b-a)*(sqrt(5)-1)/2;
           //fc:=fd;
           //fd:=f(d);
           b:=d;
          end;
        if abs(b-a)<g then
                 begin
      x:=(a+b)/2;

      Label5.Caption:=FloatToStr(x);
                 end
                 else
                 goto K;
end;

end.
