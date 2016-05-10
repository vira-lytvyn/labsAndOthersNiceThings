program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ABOUT in 'ABOUT.pas' {AboutBox},
  ABOUT1 in 'ABOUT1.pas' {AboutBox1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TAboutBox1, AboutBox1);
  Application.Run;
end.
