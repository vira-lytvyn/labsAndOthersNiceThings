unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    Button2: TButton;
    Edit3: TEdit;
    Label3: TLabel;
    Button3: TButton;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button4: TButton;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n,nn:integer;
    a,p:array[1..100,1..100] of integer;
  q, i, j, m, v: integer;
  k:integer;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
for i := 1 to nn do
for j := 1 to nn do
    a[i, j] := StrToInt(StringGrid1.Cells[i - 1, j - 1]);

    for i:=1 to nn do
for j:=1 to nn do
begin
    if i=j
    then
        p[i,j]:=0
    else
        p[i,j]:=j;
end;

for k:=1 to nn do
    for i:=1 to nn do
    begin
    for j:=1 to nn do
    if (a[k,j]=10000) or (a[i,k]=10000)
    then
      continue
    else
    if (a[i,k]+a[k,j] <a[i,j])  then
    begin
        a[i,j]:=a[i,k]+a[k,j];
        p[i,j]:=k;
    end;
    end;

for i := 1 to nn do
for j := 1 to  nn do
   begin
      Stringgrid2.Cells[i-1,j-1]:=IntToStr(a[i,j]);
      Stringgrid3.Cells[i-1,j-1]:=InttoStr(p[i,j]);
   end;                                                                                                                                                                                            if v=3 then     StringGrid3.Cells[1,2]:=InttoStr(1);
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
     StringGrid1.ColCount:=4;
     StringGrid1.RowCount:=4;
     StringGrid1.Cells[0,0]:=IntToStr(0);
     StringGrid1.Cells[0,1]:=IntToStr(10000);
     StringGrid1.Cells[0,2]:=IntToStr(10000);
     StringGrid1.Cells[0,3]:=IntToStr(4);

     StringGrid1.Cells[1,0]:=IntToStr(-2);
     StringGrid1.Cells[1,1]:=IntToStr(0);
     StringGrid1.Cells[1,2]:=IntToStr(10000);
     StringGrid1.Cells[1,3]:=IntToStr(5);

     StringGrid1.Cells[2,0]:=IntToStr(3);
     StringGrid1.Cells[2,1]:=IntToStr(2);
     StringGrid1.Cells[2,2]:=IntToStr(0);
     StringGrid1.Cells[2,3]:=IntToStr(5);

     StringGrid1.Cells[3,0]:=IntToStr(-3);
     StringGrid1.Cells[3,1]:=IntToStr(10000);
     StringGrid1.Cells[3,2]:=IntToStr(-3);
     StringGrid1.Cells[3,3]:=IntToStr(0);
     v:=3;
     nn:=4;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     StringGrid1.ColCount:=StrToInt(Edit3.Text);
     StringGrid1.RowCount:=StrToInt(Edit3.Text);
     nn:=StrToInt(Edit3.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
a,b,i,j,n,k,z:integer;
s,o:string[20];
p1:array[1..100,1..100] of integer;
begin
n:=4;
for i := 1 to n do
      for j := 1 to n do
      begin
           p1[i,j]:=StrtoInt(StringGrid3.Cells[i-1,j-1]);

      end;

a:=StrtoInt(edit1.Text);
b:=StrtoInt(edit2.Text);

j:=a;
k:=p1[b,a];
if k=a then
s:=s+Inttostr(k)+'>'
else
begin
  s:=s+inttostr(a)+'>';

  if k<a then
  begin
  for z := 1 to k do
   s:=s+inttostr(z)+'>';
  end
 else
  begin

    for z:=a+1 to k do

    s:=s+inttostr(z)+'>';

  end;
end;
s:=s+inttostr(b);
Label5.Caption:=s;
end;


end.
