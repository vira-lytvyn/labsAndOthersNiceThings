program saper;

uses
  Forms,
  saper_1 in 'saper_1.pas' {Form1},
  saper_2 in 'saper_2.pas' {AboutForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Сапер';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
