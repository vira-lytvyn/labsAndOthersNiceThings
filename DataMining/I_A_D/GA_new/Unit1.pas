unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, TeEngine, Series, TeeProcs, Chart;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Edit5: TEdit;
    Label5: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Button2: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  N: Integer;
  X_M, Y_M, P : array of Real;



implementation

uses Math;

{$R *.dfm}

function F(x : Real) : Real;
begin
    f := ( 1 / x ) - ( 1 / ( ln( x ) ) );
end;

function tabul (a, b : Real ) : Real;
var h : Real;
    i: Integer;
begin
   h := ( b - a ) / N;
   X_M [ 0 ] := a ;
   for i := 0 to N - 1 do
   begin
      Y_M [ i ] := F (X_M [ i ]);
      P [i] := 1 / Y_M [i];
      X_M [i + 1] := X_M [i] + h;
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var a, b, P_s, max, max_X, max_Y, min_X, min_Y, eps : Real;
    i, first, second, third, k_NI, k_MAX, m, j : Integer;
    temp_p: array of array of Real;
    C : array of array of Integer;
begin
    a := StrToFloat(Edit6.Text);
    b := StrToFloat(Edit7.Text);
    N := StrToInt(Edit1.Text);
    eps := StrToFloat(Edit5.Text);
    k_MAX := StrToInt(Edit4.Text);
    SetLength (X_M, N);
    SetLength (P, N);
    SetLength (Y_M, N);
    tabul(a, b);   // створення початкової популяції

    P_s := 0;
    for i := 0 to N - 1 do
    begin
        P_s := P_s + P[i];
    end;
    P_s := P_s / N;
    Memo1.Text := 'Ітерація 0 (Pс = ' + FloatToStr(P_s) + '):' +#13+#10 +#13+#10;
    for i := 0 to N - 1 do
    begin
    Memo1.Text := Memo1.Text + 'X[' + IntToStr(i + 1) + '] = ' + FloatToStr(X_M[i]) + '          ' +
                               'Y[' + IntToStr(i + 1) + '] = ' + FloatToStr(Y_M[i]) + '          ' +
                               'P[' + IntToStr(i + 1) + '] = ' + FloatToStr(P[i]) +#13+#10;
    end;
    k_NI := 1;
  while (k_NI < k_MAX)  do
  begin
    SetLength (temp_p, N);
    for i := 0 to N - 1 do
        SetLength (temp_p[i], 3);
    for i := 0 to N - 1 do
    begin
        first := Random(N);
        second := Random(N);
        third := Random(N);
        max := P[first];
        temp_p[i,0] := X_M[first];
        temp_p[i,1] := Y_M[first];
        temp_p[i,2] := P[first];
        if (P[second] > max) then
        begin
            max := P[second];
            temp_p[i,0] := X_M[second];
            temp_p[i,1] := Y_M[second];
            temp_p[i,2] := P[second];
        end;
        if (P[third] > max) then
        begin
            max := P[third];
            temp_p[i,0] := X_M[third];
            temp_p[i,1] := Y_M[third];
            temp_p[i,2] := P[third];
        end;
    end;
    P_s := 0;
    for i := 0 to N - 1 do
    begin
        P_s := P_s + temp_p [i, 2];
    end;
    P_s := P_s / N;   /////////////////////////////////////////////////
    Memo1.Text := 'Ітерація ' + IntToStr(k_NI) + ' (Pс = ' + FloatToStr(P_s) + '):' +#13+#10 +#13+#10;
    for i := 0 to N - 1 do
    begin
    Memo1.Text := Memo1.Text + 'X[' + IntToStr(i + 1) + '] = ' + FloatToStr(temp_p [i, 0]) + '          ' +
                               'Y[' + IntToStr(i + 1) + '] = ' + FloatToStr(temp_p [i, 1]) + '          ' +
                               'P[' + IntToStr(i + 1) + '] = ' + FloatToStr(temp_p [i, 2]) +#13+#10;
    end;
    // кодування
    max_X := temp_p [0, 0];
    min_X := temp_p [0, 0];
    max_Y := temp_p [0, 1];
    min_Y := temp_p [0, 1];
    for i := 0 to N - 1 do
    begin
        if (temp_p [i, 0] > max_X) then max_X := temp_p [i, 0];
        if (temp_p [i, 0] < min_X) then min_X := temp_p [i, 0];
        if (temp_p [i, 1] > max_Y) then max_X := temp_p [i, 1];
        if (temp_p [i, 1] < min_Y) then min_Y := temp_p [i, 1];
    end;
    max := (max_X - min_X);
    if ((max_Y - min_Y) > max) then max := (max_Y - min_Y);
    m := Ceil(Log2(max/eps));
    SetLength (C, N);
    for i:=0 to N-1 do
        SetLength(C[i], m);
    for i := 0 to N-1 do
    begin
        //C[i] := (power(2,m)*i/max); //extended valye instead of array of bits
    end;

    k_NI := k_NI + 1;
  end;
end;

end.
