program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit5 in 'Unit5.pas' {Form5},
  hotseat in 'hotseat.pas' {Form6};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cross-zero';
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TForm2, Form2);
  //Application.CreateForm(TForm3, Form3);
 // Application.CreateForm(TAbout, About);
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
