unit Unit3;

interface

uses
  Windows, Graphics, Forms, Buttons, Dialogs, StdCtrls, Controls, Classes;

type
  TForm3 = class(TForm)
    SpeedButton2: TSpeedButton;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    function CopyScreen(FName:string):integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
function TForm3.CopyScreen(FName: string): integer;
var
hd:HDC;
canvas:Tcanvas;
Bit:Tbitmap;
begin
hd:=GEtDC(0);
canvas:=tcanvas.Create();
bit:=tbitmap.Create();
bit.Width:=screen.Width;
bit.Height:=screen.Height;
canvas.Handle:=hd;
bit.Canvas.CopyRect(Rect(0,0,bit.Width,bit.Height),Canvas,Rect(0,0,screen.Width,screen.Height));
bit.SaveToFile(Fname);
bit.Free;
ReleaseDC(0,hd);
canvas.Free;
result:=1;
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
begin
if savedialog1.Execute then begin
edit1.Text:=savedialog1.FileName;
speedbutton2.Enabled:=true;
end;
end;

procedure TForm3.SpeedButton2Click(Sender: TObject);
begin
copyscreen(edit1.Text);
end;

end.
