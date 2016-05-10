unit Unit2;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;
Function GAMMLN(xx:real):real;
Function FACTRL(N:integer):REAL;

implementation
Function GAMMLN(xx:real):real;
CONST
  STP=2.50662827465; HALF=0.5; ONE=1.0; FPF=5.5;
var
  x,tmp,ser:double;
  j:integer;
  cof:array[1..6] of double;
BEGIN
  COF[1]:=76.18009173;      COF[2]:=-86.50532033;
  COF[3]:=24.01409822;      COF[4]:=-1.231739516;
  COF[5]:= 0.120858003e-2;  COF[6]:=-0.536382e-5;
  X:=XX-ONE;
  TMP:=X+FPF;
  TMP:=(X+HALF)*Ln(TMP)-TMP;
  SER:=ONE;
  For J:=1 To 6 do
    BEGIN
      X:=X+ONE;
      SER:=SER+COF[J]/X
    END;
  GAMMLN:=TMP+Ln(STP*SER);
end;

Function FACTRL(N:integer):REAL;
var
  GLNTOP:integer;
  GLA:array[1..33] of real;
  J:INTEGER;
begin
  GLNTOP:=0;
  GLA[1]:= 1;
  If N < 0 Then  ShowMessage('警告：现在N<0，请修改程序');
  If N = 0 Then
    FACTRL:= GLA[N+1]
  else If N <= 32 Then
  begin
      For J:= GLNTOP + 1 To N do
        GLA[J + 1]:= J * GLA[J];
      GLNTOP:= N;
      FACTRL:= GLA[N + 1];
  end
  else If N>32 then
    FACTRL:= Exp(GAMMLN(N + 1));
end;

end.
