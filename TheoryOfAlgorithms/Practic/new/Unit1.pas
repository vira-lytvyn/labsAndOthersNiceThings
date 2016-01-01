unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    Edit3: TEdit;
    Label3: TLabel;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n:integer;
  //s:string;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  a:array[1..100,1..100] of longint;
  b:array[1..100]of boolean;
  d:array[1..100] of longint;
   l:array[1..100] of integer;
  q, i, j, m, v: integer;
  s,p,o:string[50]; k:string;
begin
  s:='';
  q := StrToInt(Edit1.Text);
  if (q < 1) or (q > n) then
      begin
          q := 1;
      end;
  for i := 1 to n do
     for j := 1 to n do
          a[j, i] := StrToInt(StringGrid1.Cells[i - 1, j - 1]);
  fillchar(b,sizeof(b),0);
  fillchar(d,sizeof(d), 10000);
  d[q] := 0;
  for i:=1 to n do
  begin
      m:=1000;
      for j:=1 to n do
      if ((d[j] <= m) and (not b[j]) ) then
      begin
          m:=d[j];
          v:=j;
      end;
      b[v] := true;
      for j:=1 to n do
      if ((a[v,j]<>0)and (not b[j])and (d[v]+a[v,j]<d[j])) then
      begin
           d[j]:=d[v]+a[v,j];
      end;
         s:=s+inttostr(v);
  end;
  ListBox1.Clear;
  for i := 1 to n do

  if ((i=strtoint(Edit2.text)) and (q=strtoint(edit1.text))) then
  begin
  //  for j := 1 to i do
   // begin
  //    p:=p+s[j];
  //  end;
  j:=1;
  p:='';
  k:=Inttostr(i);
  while (strtoint(s[j])<>i) do
        begin
            p:=p+s[j]+'->';
            j:=j+1;
        end;
  p:=p+InttoStr(i);

  ListBox1.Items.Append('Початкова вершина: '+IntToStr(q) + ' - Кінцева вершина: ' + IntToStr(i) + ' найкоротший шлях: ' + IntToStr(d[i])+': '+ p);
  end;
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
     StringGrid1.ColCount:=6;
     StringGrid1.RowCount:=6;
     StringGrid1.Cells[0,0]:=IntToStr(0);
     StringGrid1.Cells[0,1]:=IntToStr(0);
     StringGrid1.Cells[0,2]:=IntToStr(0);
     StringGrid1.Cells[0,3]:=IntToStr(0);
     StringGrid1.Cells[0,4]:=IntToStr(0);
     StringGrid1.Cells[0,5]:=IntToStr(0);
     StringGrid1.Cells[1,0]:=IntToStr(4);
     StringGrid1.Cells[1,1]:=IntToStr(0);
     StringGrid1.Cells[1,2]:=IntToStr(1);
     StringGrid1.Cells[1,3]:=IntToStr(0);
     StringGrid1.Cells[1,4]:=IntToStr(0);
     StringGrid1.Cells[1,5]:=IntToStr(0);
     StringGrid1.Cells[2,0]:=IntToStr(2);
     StringGrid1.Cells[2,1]:=IntToStr(0);
     StringGrid1.Cells[2,2]:=IntToStr(0);
     StringGrid1.Cells[2,3]:=IntToStr(0);
     StringGrid1.Cells[2,4]:=IntToStr(0);
     StringGrid1.Cells[2,5]:=IntToStr(0);
     StringGrid1.Cells[3,0]:=IntToStr(0);
     StringGrid1.Cells[3,1]:=IntToStr(5);
     StringGrid1.Cells[3,2]:=IntToStr(8);
     StringGrid1.Cells[3,3]:=IntToStr(0);
     StringGrid1.Cells[3,4]:=IntToStr(0);
     StringGrid1.Cells[3,5]:=IntToStr(0);
     StringGrid1.Cells[4,0]:=IntToStr(0);
     StringGrid1.Cells[4,1]:=IntToStr(0);
     StringGrid1.Cells[4,2]:=IntToStr(10);
     StringGrid1.Cells[4,3]:=IntToStr(2);
     StringGrid1.Cells[4,4]:=IntToStr(0);
     StringGrid1.Cells[4,5]:=IntToStr(0);
     StringGrid1.Cells[5,0]:=IntToStr(0);
     StringGrid1.Cells[5,1]:=IntToStr(0);
     StringGrid1.Cells[5,2]:=IntToStr(0);
     StringGrid1.Cells[5,3]:=IntToStr(6);
     StringGrid1.Cells[5,4]:=IntToStr(3);
     StringGrid1.Cells[5,5]:=IntToStr(0);
     n:=6;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     StringGrid1.ColCount:=StrToInt(Edit3.Text);
     StringGrid1.RowCount:=StrToInt(Edit3.Text);
     n:=StrToInt(Edit3.Text);
end;

end.
