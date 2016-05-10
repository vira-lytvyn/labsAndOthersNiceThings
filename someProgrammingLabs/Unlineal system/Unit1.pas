unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids;
Const
	n = 3;
type
TMatrix= array [1..n,1..n] of double;
TVector= array [1..n] of double;
  TForm1 = class(TForm)
	Button1: TButton;
	Label4: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    Label8: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
	  procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
	{ Private declarations }
  public
	{ Public declarations }
  end;

var
  Form1: TForm1;
  Eps : Double;

implementation

{$R *.dfm}

procedure FM(var F:TVector; x:TVector;  N:Integer);
begin
	F[1]:=x[1]+exp(x[1]-1)+sqr(x[2]+x[3])-27;
	F[2]:=x[1]*exp(x[2]-2)+sqr(x[3])-10;
	F[3]:=x[3]+sin(x[2]-2)+sqr(x[2])-7;
end;

procedure Jac(Var Ja:TMatrix; x:TVector;Q:Real; N:Integer);
Var
	i,j:Integer;
	FP,F:TVector;
begin
    Q:=Eps*0.001;
	FM(F,X,N);
	For j:=1 to N do
	begin
		X[j]:=X[j]+Q;
		FM(FP,X,N);
		For i:=1 to N do
			Ja[i,j]:=(FP[i]-F[i])/Q;
	X[j]:=X[j]-Q;
	end;
end;

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
			Application.MessageBox('Sorry!!! The system is degenerate','Err',MB_OK);
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
		Application.MessageBox('Sorry!!! The system is degenerate','Err',MB_OK);
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

procedure TForm1.BitBtn1Click(Sender: TObject);
Var
    j :Integer;
begin
    Edit2.Color := clWindow;
    Edit3.Color := clWindow;
     Edit2.Text := '';
     Edit3.Text := '';
     Edit4.Text := '';
     For j:=0 to n do
     Begin
      StringGrid1.Rows[ j ].Clear;
      StringGrid2.Rows[ j ].Clear;
     End;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var F, Dx, X :TVector;
	Dxmax, Q : Real;
	Ja:TMatrix;
	k,i, j, Kmax :Integer;
begin
try
      if TryStrToInt(Edit3.Text, Kmax)then
          Kmax := StrToInt(Edit3.Text)
      else
    begin
       Application.MessageBox('Text, you have insert is not an entire numeral','Error!!!',MB_OK);
       Edit3.Color := clRed;
    end;
      if TryStrToFloat(Edit2.Text, Eps ) then
          Eps := StrToFloat(Edit2.Text)
      else
    begin
       Application.MessageBox('Text, you have insert is not an real numeral','Error!!!',MB_OK);
       Edit2.Color := clRed;
    end;
    For j:=0 to n do
	 begin
    if TryStrToFloat(StringGrid1.Cells[0,j], X[j]) then
       X[j]:=StrtoFloat(StringGrid1.Cells[0,j])
    else
       begin
          Application.MessageBox('Text, you have insert is not an real numeral','Error!!!',MB_OK);
          StringGrid1.Rows[j].Clear;
       end;
    end;
	k:=0;
	repeat
		FM(F,X,N);
		Jac(Ja,X,Q,N);
		Gauss(Ja,F,N,Dx);
		Dxmax:=0;
		For i:=1 to N do
		begin
			X[i]:=X[i]-Dx[i];
		if (abs(Dx[i])>Dxmax) then Dxmax:=abs(Dx[i]);
    end;
        k:=k+1;
	until (Dxmax<Eps);
  if (k>Kmax) then
			begin
				Application.MessageBox('Sorry, but it is imposible to find result for yours KMax with yours Eps','Error!!!',MB_OK);
        For j:=1 to n do
	      begin
		        StringGrid2.Rows[j-1].Clear;
	      end;
			end;
	For j:=1 to n do
	begin
		StringGrid2.Cells[0,j-1]:=FloatToStr(X[j]);
	end;
    Edit4.Text := FloatToStr(k);
   except
        begin
				Application.MessageBox('Sorry, but it is imposible to find result','Error!!!',MB_OK);
				//halt;
			  end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	StringGrid1.RowCount := n;
	StringGrid2.RowCount := n;
end;

end.
