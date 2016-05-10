program DLL;

uses
  Forms,
  DLL_1 in 'DLL_1.pas' {fmFahrToCels};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmFahrToCels, fmFahrToCels);
  Application.Run;
end.
