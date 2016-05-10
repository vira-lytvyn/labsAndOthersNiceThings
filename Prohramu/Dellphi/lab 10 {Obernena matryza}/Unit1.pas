unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, XPMan;

    Const Eps=0.00001;

type
  TMatrix= array [1..50,1..50] of double;
  TVector= array [1..50] of double;
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    XPManifest1: TXPManifest;
    StringGrid3: TStringGrid;
    BitBtn4: TBitBtn;
    ComboBox1: TComboBox;
    Label3: TLabel;
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n : Integer;
  i, j, k :Integer;
  E, A, B, C : TMatrix;
  S : Real;

implementation

{$R *.dfm}

procedure TForm1.Edit1Change(Sender: TObject);
begin
try
  if Length(Edit1.Text)<>0 then
  begin
     n:=StrToInt(Edit1.Text);
     StringGrid1.ColCount:=n;
     StringGrid1.RowCount:=n;
     StringGrid2.ColCount:=n;
     StringGrid2.RowCount:=n;
     StringGrid3.ColCount:=n;
     StringGrid3.RowCount:=n;
  end;
except
    showmessage('Розмірність матриці повнна бути цілим числом');
end;
end;

Procedure Gauss_Jordan (var A : TMatrix;  N : Integer; var E : TMatrix);
Var
	p,l:Integer;  R:Double;
begin
    for i:=1 to N do
      for j:=1 to N do
      begin
        if i=j then E[i,j]:=1 else E[i,j]:=0;
      end;
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
		      ShowMessage('Обоерненої матриці не існує')
        else
		    if (k<>i) then
		    begin
			      For j:=i to N do
            begin
			        	R:=A[k,j];
			        	A[k,j]:=A[i,j];
			        	A[i,j]:=R;
                R:=E[k,j];
			        	E[k,j]:=E[i,j];
			        	E[i,j]:=R;
		      	end;
		    end;
        R:=A[i,i];
		    For j:=1 to N do
        begin
		      	A[i,j]:=A[i,j]/R;
            E[i,j]:=E[i,j]/R;
        end;
	    	For k:=i+1 to N do
	    	begin
	      		R:=A[k,i];
      			For j:=i to N do
            begin
		        		A[k,j]:=A [k,j] - R*A [i,j];
                E[k,j]:=E [k,j] - R*E [i,j];
            end;
        end;
   	end;
    i := N;
    R := A[i ,i];
    for j:=1 to N do
    begin
      A[i, j] := A[i, j] / R;
      E[i, j] := E[i, j] / R;
    end;
   for i := N  downto 1 do
    begin
      for j := i - 1 downto 1 do
      begin
        R := A[j, i];
        for k := 1 to N do
        begin
          A[j, k] := A[j, k] - R * A[i, k];
          E[j, k] := E[j, k] - R * E[i, k];
        end;
      end;
    end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
    Edit1.Text:='';
    For i:=1 to n do
    For j:=1 to n do
      begin
          StringGrid1.Cells[j-1, i-1]:='';
          StringGrid2.Cells[j-1, i-1]:='';
          StringGrid3.Cells[j-1, i-1]:='';
      end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
    try
	For i:=1 to n do
	For j:=1 to n do
	begin
		A[j,i]:=StrtoFloat(StringGrid1.Cells[j-1,i-1]);
	end;
  Gauss_Jordan(A,N,E);
	For i:=1 to n do
  For j:=1 to n do
    StringGrid2.Cells[j-1,i-1]:=FloatToStr(E[j,i]);
    except
        showmessage('Помилка. Користувач, Ви ввели некоректні дані');
    end;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
    StringGrid3.Visible:=True;
    Label3.Visible:=True;
    ComboBox1.Visible:=True;
    case ComboBox1.ItemIndex of
      0:  begin
              For i:=1 to n do
	              For j:=1 to n do
	            begin
		              A[j,i]:=StrtoFloat(StringGrid2.Cells[j-1,i-1]);
              end;
              Gauss_Jordan(A,N,E);
	            For i:=1 to n do
                For j:=1 to n do
              StringGrid3.Cells[j-1,i-1]:=FloatToStr(E[j,i]);
          end;
      1:  begin
              For i:=1 to n do
	              For j:=1 to n do
	              begin
		                A[j,i]:=StrtoFloat(StringGrid1.Cells[j-1,i-1]);
                    B[j,i]:=StrtoFloat(StringGrid2.Cells[j-1,i-1]);
	              end;
              for i:=1 to n do
                for j:=1 to n do
              begin
                  S:=0;
                  for k:=1 to n do
                    S:=S+A[i,k]*B[k,j];
                  C[i,j]:=S;
              end;
              for i:=0 to n-1 do
                for j:=0 to n-1 do
                  StringGrid3.Cells[j,i]:=FloatToStr(C[i+1,j+1]);
          end;
    end;
end;

end.
