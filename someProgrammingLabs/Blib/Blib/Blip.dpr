program Blip;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
//  myabout in '..\..\OBJREPOS\MYABOUT.pas' {AboutBox},
  About in 'About.pas' {AboutBox1},
  Load in 'Load.pas' {LoadForm},
  Designer in 'Designer.pas' {DesignerForm},
  BtnMess in 'BtnMess.pas' {BtnMessages},
  QHelp in 'QHelp.pas' {QHelpForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
//  Application.CreateForm(TAboutBox1, AboutBox1);
  Application.CreateForm(TLoadForm, LoadForm);
  Application.CreateForm(TDesignerForm, DesignerForm);
  Application.CreateForm(TBtnMessages, BtnMessages);
  Application.CreateForm(TQHelpForm, QHelpForm);
  Application.Run;
end.
