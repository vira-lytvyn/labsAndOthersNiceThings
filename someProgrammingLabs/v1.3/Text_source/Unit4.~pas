unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm4 = class(TForm)
    Button1: TButton;
    TrackBar1: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm4.FormCreate(Sender: TObject);
begin
FormStyle:=fsStayOnTop;
end;

procedure TForm4.TrackBar1Change(Sender: TObject);
begin
Form1.AlphaBlendValue:=255-TrackBar1.Position;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
if(TrackBar1.Position=0)then
Form1.AlphaBlend:=False;
Close;
end;

end.
