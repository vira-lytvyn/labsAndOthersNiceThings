//******************************************************************************
//
// License:
// --------
// This unit is freely distributable without licensing fees and is
// provided without guarantee or warrantee expressed or implied. This unit
// is Public Domain. Feel free to use or enhance this code. You can use the
// program for any purpose you see fit.
//
//******************************************************************************
program varyag;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  rtsmain in 'rtsmain.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
// This code is public domain, feel free to do with it any descent thing.
end.
