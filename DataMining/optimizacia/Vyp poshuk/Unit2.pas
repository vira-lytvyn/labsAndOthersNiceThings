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
var
  a,b,c,x,fmin:real;
  i,k,a1,b1:integer;
  xi,fxi:array[1..10000]of real;
begin
   a:=StrtoFloat(Edit1.Text);
   b:=StrtoFloat(Edit2.Text);
   if a>b then
   begin
      c:=a;
      a:=b;
      b:=c;
   end;
   a1:=round(a*1000);
   b1:=round(b*1000);
   for i := 1 to 10000 do
   begin
      randomize();
      xi[i]:=(a1+random(b1))/1000;
   end;
   for i := 1 to 10000 do
   begin
      fxi[i]:=f(xi[i]);
   end;
   fmin:=fxi[1];
   k:=1;
   for i := 2 to 10000 do
   begin
      if fxi[i]<=fmin then
      begin
          fmin:=fxi[i];
          k:=i;
      end;
   end;
   x:=xi[k];
   Label4.Caption:=FloatToStr(x);
end;

end.
