unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, XPMan;
   Const E=0.00001;
type
  TMatrix= array [1..50,1..50] of double;
  TVector= array [1..50] of double;
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    Label2: TLabel;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    XPManifest1: TXPManifest;
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n: Integer;

implementation

{$R *.dfm}
procedure Decomp (Var A: TMatrix; N: Integer; Var Change: Integer);
Var i, j, k: Integer;
    R:Real;
Begin
    Change :=1;
    R:= abs (A[1, 1]);
    for j:=2 to N do
    begin
        if Abs (A[j, 1])>R then
        begin
            Change :=j;
            R:= Abs (A[j, 1]);
        end
        else
        if R<E then
        begin
            Application.MessageBox('������� ���������', '�������!!!', MB_OK);
        end;
    end;
    if k<>1 then
    begin
        for i:=1 to N do
        Begin
            R:= A[Change, i];
            A[Change, i]:=A[1, i];
            A[1, i]:=R;
        end;
    end;
    for i:=2 to N do
        A[1, i]:=A[1,i]/A[1,1];
    for i:=2 to N do
    begin
        for k:=i to N do
        begin
            R:=0;
            for j:=1 to i-1 do
                R:= R + A[k, j]*A[j, i];
            A[k,i]:= A[k,i]-R;
        end;
        if abs (A[i, i])<E then
        begin
            Application.MessageBox('������� ���������', '�������', MB_OK);
        end;
        for k:= i+1 to N do
        begin
            R:=0;
            for j:=1 to i-1 do
                R:=R+ A[i, j]*A[j,k];
            A[i,k]:=(A[i, k]-R)/A[i,i];
        end;
    end;
end;

procedure Solve (A: TMatrix; Var b, x: TVector; Change, N: Integer);
Var i, j : Integer;
    R: Real;
Begin
    if  Change <> 1 then
    begin
        R := b[Change];
        b[Change] := b[1];
        b[1]:= R;
    end;
    b[1]:=b[1]/A[1, 1];
    for i:=2 to N do
    begin
        R:=0;
        for j:=1 to i-1 do
            R:=R+A[i,j]*b[j];
        b[i]:=(b[i]-R)/A[i,i];
    end;
    x[N]:=b[N];
    for i:=1 to N-1 do
    begin
        R:= 0;
        for j:=N+1-i to N do
            R:= R+A[N-i, j]*x[j];
        x[N-i]:=b[N-i]-R;
    end;
end;



procedure TForm1.Edit1Change(Sender: TObject);
begin
  if Length(Edit1.Text)<>0 then
  begin
     n:=StrToInt(Edit1.Text);
     StringGrid1.ColCount:=n;
     StringGrid1.RowCount:=n;
     StringGrid2.RowCount:=n;
     StringGrid2.ColCount:=0;
     StringGrid3.ColCount:=n;
     StringGrid3.RowCount:=n;
     StringGrid4.RowCount:=n;
     StringGrid4.ColCount:=0;
  end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
Var
	A :TMatrix; B,X:TVector;
	i, j, Change:Integer;
begin
	For i:=1 to n do
      begin
	    For j:=1 to n do
		        A[i,j]:=StrtoFloat(StringGrid1.Cells[j-1,i-1]);
            B[i]:=StrToFloat(StringGrid2.Cells[0,i-1]);
        end;
  Decomp (A,N,Change);
  Solve (A,B,X,Change,N);
	For i:=1 to n do
        StringGrid4.Cells[0,i-1]:=FloatToStrF(X[i], fffixed, 3, 3);
    for i := 1 to N do
       begin
        for j := 1 to N do
           StringGrid3.Cells[j - 1, i - 1] := FloatToStrF(A[i,j], fffixed, 3, 3);
       end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
Var
	i,j:Integer;
begin
    Edit1.Text:='';
    For i:=1 to n do
    begin
	    For j:=1 to n do
      begin
          StringGrid1.Cells[j-1, i-1]:='';
          StringGrid3.Cells[j-1, i-1]:='';
      end;
    StringGrid2.Cells[0,i-1]:='';
    StringGrid4.Cells[0,i-1]:='';
    end;
end;

end.
