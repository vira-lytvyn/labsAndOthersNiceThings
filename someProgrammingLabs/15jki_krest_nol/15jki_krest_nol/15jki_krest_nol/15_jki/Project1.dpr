program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Main},
  Unit2 in 'Unit2.pas' {Rules},
  Pre in 'Pre.pas' {ChoseLang};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Пятшанки';
  Application.CreateForm(TChoseLang, ChoseLang);
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TRules, Rules);
  Application.Run;
end.
