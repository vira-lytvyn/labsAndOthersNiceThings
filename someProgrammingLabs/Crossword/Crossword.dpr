program Crossword;

uses
  Forms,
  Controls,
  Crossword_Main in 'Crossword_Main.pas' {fmMain},
  Crossword_DM in 'Crossword_DM.pas' {DM: TDataModule},
  Crossword_Login in 'Crossword_Login.pas' {fmLogin},
  Crossword_Variants in 'Crossword_Variants.pas' {fmVariants},
  Crossword_Print in 'Crossword_Print.pas' {fmPrint};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfmLogin, fmLogin);
  if fmLogin.ShowModal = mrCancel
  then Application.Terminate
  else Application.Run;
end.
