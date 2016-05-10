unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons;

  Const Eps=0.00001;
type
  TMatrix= array [1..50,1..50] of double;
  TVector= array [1..50] of double;
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n:Integer;
implementation

{$R *.dfm}
procedure Gauss(A:TMatrix; B:TVector; N:Integer; var X:TVector);
Var
	i,j,k:Integer;  R:Double;
begin
	For i:=1 to N-1 do
	begin
		k:=i;
		R:=abs(A[i,i]);
		For j:=i+1 to N do
		begin
			if (abs(A[j,i])>R) then
			begin
				k:=j;
				R:=abs(A[j,i]);
			end;
		end;
		if (R<eps) then
		begin
			Application.MessageBox('система вироджена','Помилка!!!',MB_OK);
			Halt;
		end
		
		else

		if (k<>i) then
		begin
			R:=B[k];
			B[k]:=B[i];
			B[i]:=R;
			For j:=i to N do
			begin 
				R:=A[k,j];
				A[k,j]:=A[i,j];
				A[i,j]:=R;
			end;
		end;

		R:=A[i,i];
		B[i]:=B[i]/R;
		For j:=1 to N do
			A[i,j]:=A[i,j]/R;

		For k:=i+1 to N do
		begin
			R:=A[k,i];
			B[k]:=B[k]-R*B[i];
			A[k,i]:=0;
			For j:=i+1 to N do
				A[k,j]:=A[k,j]-R*A[i,j];
		end;
	end;
	if (abs(A[n,n])<eps) then
	begin
		Application.MessageBox('система вироджена','Помилка!!!',MB_OK);
		Halt;
	end
	else
		X[n]:=B[n]/A[n,n];
	For i:=N-1 downto 1 do 
	begin
		R:=B[i];
		For j:=i+1 to N do 
			R:=R-A[i,j]*X[j];
      X[i]:=R;
	end;
end;



procedure TForm1.Button1Click(Sender: TObject);
Var 
	A:TMatrix; B,X:TVector;
	i,j:Integer;
begin
	For i:=1 to n do
	For j:=1 to n do
	begin
		A[i,j]:=StrtoFloat(StringGrid1.Cells[j-1,i-1]);
		B[j]:=StrToFloat(StringGrid2.Cells[0,j-1]);
	end;
	Gauss(A,B,N,X);

	For i:=1 to n do
		StringGrid3.Cells[0,i-1]:=FloatToStr(X[i]);

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if Length(Edit1.Text)<>0 then
  begin
     n:=StrToInt(Edit1.Text);
     StringGrid1.RowCount:=n;
     StringGrid2.RowCount:=n;
     StringGrid1.ColCount:=n;
     StringGrid3.RowCount:=n;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
Var
	i,j:Integer;
begin
    Edit1.Text:='';
    For i:=1 to n do
    begin
	    For j:=1 to n do
          StringGrid1.Cells[j-1,i-1]:='';
      StringGrid2.Cells[0,i-1]:='';
      StringGrid3.Cells[0,i-1]:='';
    end;

end;
end.
