program Effects;

uses
  Forms,
  Effects1 in 'Effects1.pas' {formMain},
  Effects2 in 'Effects2.pas' {formBlend},
  Effects3 in 'Effects3.pas' {formShift},
  Effects4 in 'Effects4.pas' {formTransp};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformBlend, formBlend);
  Application.CreateForm(TformShift, formShift);
  Application.CreateForm(TformTransp, formTransp);
  Application.Run;
end.
