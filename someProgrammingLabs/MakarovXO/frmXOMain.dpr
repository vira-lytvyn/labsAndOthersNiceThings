program frmXOMain;

uses
  Forms,
  unitXOMain in 'unitXOMain.pas' {frmXO},
  unitXOAI in 'unitXOAI.pas',
  unitFrmAbout in 'unitFrmAbout.pas' {frmAbout},
  unitFrmOptions in 'unitFrmOptions.pas' {frmOptions};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmXO, frmXO);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
