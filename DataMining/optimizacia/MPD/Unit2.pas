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
label M;
var
a,b,eps,g,c,q,p,x:real;
begin
  a:=StrtoFloat(Edit1.Text);
  b:=StrtoFloat(Edit2.Text);
  g:=StrtoFloat(Edit3.Text);
   eps:=0.001;
    if a>b then
   begin
      c:=a;
      a:=b;
      b:=c;
   end;

M:
   if abs(f(b)-f(a))<g then
      x:=(a+b)/2
      else

     begin
       p:=(a+b)/2+eps;
       q:=(a+b)/2-eps;
       if f(p)<f(q) then
       begin
          a:=p;
       end
       else
       begin
         b:=q;

       end;
       goto M;
     end;
        Label5.Caption:=FloatToStr(x);

end;

end.
