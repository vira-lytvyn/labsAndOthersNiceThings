unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, shellapi;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
form2.Close;
end;

procedure TForm2.Label1Click(Sender: TObject);
begin
form2.Close;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
if form2.AlphaBlendValue=255 then begin
timer1.Enabled:=false;
end else
form2.AlphaBlendValue:=form2.AlphaBlendValue+5;
end;


procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form2.AlphaBlendValue:=0;
end;

procedure TForm2.Label2Click(Sender: TObject);
begin
form2.Close;
end;

procedure TForm2.Label3Click(Sender: TObject);
begin
ShellExecute(Application.Handle,'open','http://mvc2006.narod.ru',nil,nil,0);
end;

procedure TForm2.Label4Click(Sender: TObject);
begin
form2.Close;
end;

procedure TForm2.Label5Click(Sender: TObject);
begin
ShellExecute(Application.Handle,'open','mailto:SolarGS@yandex.ru?subject=About Image2Text',nil,nil,0);
end;

procedure TForm2.Label6Click(Sender: TObject);
begin
form2.Close;
end;

procedure TForm2.Label3MouseEnter(Sender: TObject);
begin
label3.Font.Color:=clred;
end;

procedure TForm2.Label3MouseLeave(Sender: TObject);
begin
label3.Font.Color:=clwhite;
end;

procedure TForm2.Label5MouseEnter(Sender: TObject);
begin
label5.Font.Color:=clblue;
end;

procedure TForm2.Label5MouseLeave(Sender: TObject);
begin
label5.Font.Color:=clwhite;
end;

end.
