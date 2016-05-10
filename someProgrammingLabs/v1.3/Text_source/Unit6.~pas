unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls;

type
  TForm6 = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Button1: TButton;
    ColorDialog1: TColorDialog;
    TrackBar1: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;
  Temp:Integer;

implementation
uses Unit1;
{$R *.dfm}

procedure TForm6.FormCreate(Sender: TObject);
begin
temp:=0;
FormStyle:=fsStayOnTop;
Form6.Top:=Form1.Top+Podsvetka;
Form6.Left:=Form1.Left+7;
Form6.ClientWidth:=Form1.ClientWidth;
end;

procedure TForm6.N1Click(Sender: TObject);
begin
FlagPodsvetka:=0;
Form6.AlphaBlend:=False;
TrackBar1.Visible:=False;
Button1.Visible:=False;
Close;
end;

procedure TForm6.N3Click(Sender: TObject);
begin
if(ColorDialog1.Execute=True)then
Form6.Color:=ColorDialog1.Color;
end;

procedure TForm6.TrackBar1Change(Sender: TObject);
begin
Form6.AlphaBlendValue:=255-TrackBar1.Position;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
if(TrackBar1.Position=0)then
Form6.AlphaBlend:=False;
TrackBar1.Visible:=False;
if(temp=1)then
begin
Podsvetka:=Form6.Top-Form1.Top;
temp:=0;
end;
Button1.Visible:=False;
Form6.BorderStyle:=bsNone;
Form6.ClientHeight:=18;
Form6.Top:=Form1.Top+Podsvetka;
Form6.Left:=Form1.Left+7;
Form6.ClientWidth:=Form1.ClientWidth;
end;

procedure TForm6.N4Click(Sender: TObject);
begin
TrackBar1.Position:=255-Form6.AlphaBlendValue;
TrackBar1.Visible:=True;
Button1.Visible:=True;
end;

procedure TForm6.N5Click(Sender: TObject);
begin
temp:=1;
Form6.BorderStyle:=bsDialog;
Form6.ClientHeight:=21;
Form6.Button1.Visible:=True;
end;

end.
