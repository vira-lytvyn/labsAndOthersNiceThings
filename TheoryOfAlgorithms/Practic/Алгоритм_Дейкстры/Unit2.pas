unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls;
  
type
  TForm2 = class(TForm)
    SpeedButton1: TSpeedButton;
    Image1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Timer1: TTimer;
    Label6: TLabel;
    Label7: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    private
    { Déclarations privées }
    public
    { Déclarations publiques }
  end;
  
var
  Form2: TForm2;
  
implementation

{$R *.dfm}

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  AnimateWindow(Handle, 360, AW_BLEND or AW_HIDE);
  close;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  if(label2.font.Color=clWindowText)then
  begin
    label2.Font.color:=cllime;
    label6.Font.color:=cllime;
    label7.Font.color:=cllime;
  end
  else
  begin
    if(label2.font.Color=cllime)then
    begin
      label2.Font.color:=clred;
      label6.Font.color:=clred;
      label7.Font.color:=clred;
    end
    else
      if(label2.font.Color=clred)then
    begin
      label2.Font.color:=clWindowText;
      label6.Font.color:=clWindowText;
      label7.Font.color:=clWindowText;
    end;
  end;
end;

end.
