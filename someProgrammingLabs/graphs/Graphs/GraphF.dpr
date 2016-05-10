program GraphF;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  MyMath in '..\MyUnits\MyMath.pas',
  Unit2 in 'Unit2.pas' {AboutForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
