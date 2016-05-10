unit Effects3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TformShift = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    btnClose: TButton;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formShift: TformShift;

implementation

{$R *.dfm}

procedure TformShift.Timer1Timer(Sender: TObject);
begin
  if Width < 300
  then Width := Width + 20
  else Timer1.Enabled := False;
end;

procedure TformShift.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

end.
