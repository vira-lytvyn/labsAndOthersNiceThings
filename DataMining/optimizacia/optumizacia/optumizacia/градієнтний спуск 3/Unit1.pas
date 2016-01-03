unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function f(x:real):real;
begin
     f:=x+sqr(ln(x));
end;
function Sign(x:real):real;
begin
      if x=0 then  Sign:=0;
      if x>0 then  Sign:=1;
      if x<0 then  Sign:=-1;

end;
function pohidna(x,dx:real):real;
begin
     pohidna:=(f(x+dx)-f(x))/dx;
end;
procedure TForm1.Button1Click(Sender: TObject);
var
    x0,g,h,e,eps,i,i1,x,xx:real;
label M;
begin
    h:=StrToFloat(Edit1.Text);
    e:=StrToFloat(Edit2.Text);
    x0:=StrToFloat(Edit3.Text);
    eps:=StrToFloat(Edit4.Text);
M:
    begin
        g:=(f(x0+eps)-f(x0))/eps;
        i:=sign(round(g));
        x:=x0-h*g;
        g:=(f(x)-f(x0))/(x-x0);
        x0:=x;
        i1:=sign(g);
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
    label6.Caption:=FloatToStr(xx);
    label8.Caption:=FloattoStr(f(xx));
    label10.Caption:=FloatToStr(g);
end;

end.
