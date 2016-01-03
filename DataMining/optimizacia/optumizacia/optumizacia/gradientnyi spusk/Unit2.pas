unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button1: TButton;
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
 function Sign(x:real):real;
begin

if x=0 then  Result:=0;
if x>0 then Result:=1
else Result:=-1;
end;
procedure TForm2.Button1Click(Sender: TObject);
var x0,g,h,e,eps,i,i1,x,xx:real;
label M;
begin
    h:=0.8;
    e:=0.0001;
    eps:=0.001;
    x0:=0.3;

M:
    begin
        g:=(f(x0+eps)-f(x0))/eps;
        i:=sign(round(g));
        x:=x0-h*g;
        g:=(f(x)-f(x0))/(x-x0);
        x0:=x;
        i1:=sign(round(g));
    end;
    if abs(g)<e then
      xx:=x
    else
    begin
      if i1=i then
         h:=h*1.6
         else
         begin
         h:=h/2;
         end;
         i:=i1;
         goto M;
    end;
    label3.Caption:=FloatToStr(xx);

end;

end.
