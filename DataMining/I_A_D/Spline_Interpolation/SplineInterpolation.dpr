program SplineInterpolation;

uses
  Forms,
  MForm in 'MForm.pas' {Form1},
  class_interpolator in 'class_interpolator.pas',
  class_node in 'class_node.pas',
  unit_sle in 'unit_sle.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
