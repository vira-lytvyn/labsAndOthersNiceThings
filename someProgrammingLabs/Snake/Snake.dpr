program Snake;

uses
  Forms,
  Snake1 in 'Snake1.pas' {fmMain},
  Snake2 in 'Snake2.pas' {fmStart},
  Snake3 in 'Snake3.pas' {fmRecords};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Игра "Змейка"';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
