program FormEx;

uses
  Forms,
  Forms1 in 'Forms1.pas' {formMain},
  PassWord in 'PassWord.pas' {PasswordDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
