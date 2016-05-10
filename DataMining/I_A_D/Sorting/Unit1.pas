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
    Button2: TButton;
    StringGrid2: TStringGrid;
    Button3: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
  //  procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const n=1000;
var
  Form1: TForm1;
   implementation

{$R *.dfm}

{procedure TForm1.Button1Click(Sender: TObject);
var
   a:array [1..n] of real;
   i,j,k:integer ;
   c:real;
begin
    k:=StrToInt(Edit1.Text);
    for i:=1 to k do
       a[i]:=StrToFloat(StringGrid1.Cells[0,i-1]);
    For i:=1 to k do
      For j:=1 to k-i do
      If a[j]>a[j+1]
      then
      Begin
           c:=a[j];
           a[j]:=a[j+1];
           a[j+1]:=c;
      End;
    for i:=1 to k do
      StringGrid2.Cells[0,i-1]:=FloatToStr(a[i]);
end; }

procedure TForm1.Button2Click(Sender: TObject);
var
   a:array [1..n] of real;
   i,j,k:integer ;
   c:real;
begin
    k:=StrToInt(Edit1.Text);
    for i:=1 to k do
       a[i]:=StrToFloat(StringGrid1.Cells[0,i-1]);
    For i:=1 to k do
      For j:=1 to k-i do
      If a[j]<a[j+1]
      then
      Begin
           c:=a[j];
           a[j]:=a[j+1];
           a[j+1]:=c;
      End;
    for i:=1 to k do
      StringGrid2.Cells[0,i-1]:=FloatToStr(a[i]);
end;

procedure TForm1.Button3Click(Sender: TObject);
var k,i,a1,b1:integer;
a,b,c:real;
l:array [1..n] of real;
begin
    k:=StrToInt(Edit1.Text);
    a:=StrTofLOAT(Edit2.Text);
    b:=StrToFloat(Edit3.Text);
    if a>b  then
    begin
         c:=a;
         a:=b;
         b:=c;
    end;
    StringGrid1.RowCount:=k;
    StringGrid2.RowCount:=k;
    a1:=round(a*1000000);
    b1:=round(b*1000000);
    for I := 1 to k do
         begin
              l[i]:=RandomRange(a1,b1)/1000000;
              StringGrid1.Cells[0,i-1]:=FloatToStr(l[i]);
         end;
end;

end.
