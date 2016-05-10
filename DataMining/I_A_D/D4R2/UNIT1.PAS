unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
//PROGRAM D4R2
//Driver for routine FACTRL
uses
  unit2;
{$R *.DFM}
procedure TForm1.Button1Click(Sender: TObject);
var
  ACTUAL:array[1..5] of real;X:array[1..5] of integer;
  F:TextFile;  j:Integer;
const
  s1='#####';s2='%16.0f';
begin
  ACTUAL[1]:= 6;    ACTUAL[2]:= 24 ;
  ACTUAL[3]:= 120;   ACTUAL[4]:= 720;
  ACTUAL[5]:= 5040;
  X[1]:= 3;    X[2]:= 4;
  X[3]:= 5;    X[4]:= 6;
  X[5]:= 7;
  //输出计算结果到文件
  AssignFile(F, 'd:\delphi_shu\p4\d4r2.dat');
  Rewrite(F);
  Writeln(F, 'N            Actual        FACTRL(N)');
  For j:= 1 To 5 do
    Writeln(F,FormatFloat(s1,X[j]),Format(s2,[Actual[j]]),
                                    Format(s2,[FACTRL(X[j])]));
  CloseFile(F);
  //屏幕显示计算结果
  memo1.Lines.LoadFromFile('d:\delphi_shu\p4\d4r2.dat');
end;

end.
