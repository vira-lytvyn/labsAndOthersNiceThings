unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons;

type
  TMatrix= array [1..50,1..50] of real;
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Button2: TButton;
    StringGrid3: TStringGrid;
    BitBtn1: TBitBtn;
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n1, m1, n2, m2:Integer;
implementation

{$R *.dfm}

procedure TForm1.Edit1Change(Sender: TObject);
begin
    n1:=StrToInt(Edit1.Text);
    StringGrid1.RowCount:=n1;
    StringGrid3.RowCount:=n1;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
    m1:=StrToInt(Edit2.Text);
    StringGrid1.ColCount:=m1;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
    n2:=StrToInt(Edit3.Text);
    StringGrid2.RowCount:=n2;
end;

procedure TForm1.Edit4Change(Sender: TObject);
begin
    m2:=StrToInt(Edit4.Text);
    StringGrid2.ColCount:=m2;
    StringGrid3.ColCount:=m2;
end;

procedure TForm1.Button2Click(Sender: TObject);
Var	A, B, C : TMatrix;
    k, i, j : integer;
    S : Real;
begin
    if m1<>n2 then
    Application.MessageBox(' Множення неможливе ','Error!!!',MB_OK)
    else
    begin
	    For i:=1 to n1 do
	    For j:=1 to m1 do
	    begin
          A[i,j]:=StrToFloat(StringGrid1.Cells[j-1,i-1]);
  	  end;
      For i:=1 to n2 do
	    For j:=1 to m2 do
      begin
          B[i,j]:=StrToFloat(StringGrid2.Cells[j-1,i-1]);
      end;
      for i:=1 to n1 do
      for j:=1 to m2 do
      begin
          S:=0;
          for k:=1 to n2 do
            S:=S+A[i,k]*B[k,j];
          C[i,j]:=S;
      end;
      for i:=0 to n1-1 do
      for j:=0 to m2-1 do
          StringGrid3.Cells[j,i]:=FloatToStr(C[i+1,j+1]);
    end;
end;
end.
