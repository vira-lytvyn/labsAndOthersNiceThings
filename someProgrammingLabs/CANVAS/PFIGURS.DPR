program Pfigurs;

uses
  Forms,
  Ufigurs in 'Ufigurs.pas' {FFig};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFFig, FFig);
  Application.Run;
end.
