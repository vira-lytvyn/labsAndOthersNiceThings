unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit3: TEdit;
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
function pohidna(x,dx:real):real;
begin
     pohidna:=(f(x+0.0001 )-f(x))/0.0001;
end;

Function n(k:integer):integer;
  begin
    n:=k;
  end;
procedure TForm2.Button1Click(Sender: TObject);
var
  a,b,c,x,fmin,g:real;
  l,z,i,k,a1,b1:integer;
  xi,fxi:array [1..30000] of real;
begin
   a:=StrtoFloat(Edit1.Text);
   b:=StrtoFloat(Edit2.Text);
   z:=StrToInt(Edit3.Text);
   if z<=30000 then
      begin
   l:=n(z);
   if a>b then
   begin
      c:=a;
      a:=b;
      b:=c;
   end;
   a1:=round(a*100000000);
   b1:=round(b*100000000);
   for i := 1 to l do
   begin
      randomize();
      xi[i]:=(a1+random(b1))/100000000;
   end;
   for i := 1 to l do
   begin
      fxi[i]:=f(xi[i]);
   end;
   fmin:=fxi[1];
   k:=1;
   for i := 2 to l do
   begin
      if fxi[i]<=fmin then
      begin
          fmin:=fxi[i];
          k:=i;
      end;
   end;
   x:=xi[k];
   Label4.Caption:=FloatToStr(x);
   Label6.Caption:=FloattoStr(f(x));
   Label8.Caption:=Floattostr(pohidna(x,g));
      end
      else
      ShowMessage('Кількість точок перевищує допустиме значення');
end;

end.
