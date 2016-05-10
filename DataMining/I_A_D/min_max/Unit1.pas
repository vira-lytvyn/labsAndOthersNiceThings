unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Math;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button3: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  //  procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const n=100000;
var
  Form1: TForm1;
   implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
   a:array [1..n] of real;
   i,j,k:integer ;
   c,min:real;
begin
    k:=StrToInt(Edit1.Text);
    for i:=1 to k do
       a[i]:=StrToFloat(StringGrid1.Cells[0,i-1]);
    min:=a[1];
    For i:=1 to k do
      If a[i]<min
      then
        min:=a[i];
      Edit4.Text:=FloatToStr(min);
end;

{procedure TForm1.Button2Click(Sender: TObject);
var
   a:array [1..n] of real;
   i,j,k:integer ;
   c,max:real;
begin
    k:=StrToInt(Edit1.Text);
    for i:=1 to k do
       a[i]:=StrToFloat(StringGrid1.Cells[0,i-1]);
    max:=a[1];
    For i:=1 to k do
      If a[i]>max
      then
       max:=a[i];
      Edit5.Text:=FloatToStr(max);
end;  }

procedure TForm1.Button3Click(Sender: TObject);
var k,i,a1,b1:integer;
a,b,c:real;
l:array [0..n] of real;
begin
    k:=StrToInt(Edit1.Text);
    a:=StrToFloat(Edit2.Text);
    b:=StrToFloat(Edit3.Text);
    if a>b  then
    begin
         c:=a;
         a:=b;
         b:=c;
    end;
    StringGrid1.RowCount:=k;

    a1:=round(a*10000000);
    b1:=round(b*10000000);
    for I := 1 to k do
         begin
              l[i]:=RandomRange(a1,b1)/10000000;
              StringGrid1.Cells[0,i-1]:=FloatToStr(l[i]);
         end;
end;

end.
