program Beep;

uses
  Forms,
  Beep1 in 'Beep1.pas' {fmMain},
  BeepThread in 'BeepThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
