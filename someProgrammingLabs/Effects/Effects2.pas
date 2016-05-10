unit Effects2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TformBlend = class(TForm)
    Timer1: TTimer;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formBlend: TformBlend;
  BlendUp: Boolean;

implementation

{$R *.dfm}

procedure TformBlend.Timer1Timer(Sender: TObject);
begin
  case BlendUp of
     True: if AlphaBlendValue < 235
           then AlphaBlendValue := AlphaBlendValue + 20
           else begin
             AlphaBlend := False;
             AlphaBlendValue := 255;
             Timer1.Enabled := False;
           end;
    False: if AlphaBlendValue > 40
           then AlphaBlendValue := AlphaBlendValue - 40
           else begin
             AlphaBlendValue := 1;
             Close;
           end;
  end;
end;

procedure TformBlend.FormShow(Sender: TObject);
begin
  AlphaBlendValue := 0;
  AlphaBlend := True;
  BlendUp := True;
  Timer1.Enabled := True;
end;

procedure TformBlend.btnCloseClick(Sender: TObject);
begin
  AlphaBlend := True;
  BlendUp := False;
  Timer1.Enabled := True;
end;

end.
