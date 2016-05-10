program mat1_var3_code;

uses
  Forms,
  form_main in 'form_main.pas' {FormMain},
  mat_code in 'mat_code.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
