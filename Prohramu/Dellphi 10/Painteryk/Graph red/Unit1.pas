unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ColorGrd, StdCtrls, Spin, ExtCtrls, ExtDlgs;

type
  TForm1 = class(TForm)
    Image1: TImage;
    SpinEdit1: TSpinEdit;
    ColorGrid1: TColorGrid;
    SavePictureDialog1: TSavePictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ColorGrid1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Image1.Canvas.Pen.Color:=ColorGrid1.ForegroundColor;
Image1.Canvas.Brush.Color:=ColorGrid1.BackgroundColor;
Image1.Canvas.FillRect(BoundsRect);
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
Image1.Canvas.Pen.Width:=SpinEdit1.Value;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
With Image1.Canvas do
Case Button of
mbleft:moveto(x,y);
mbright:FloodFill(x,y,Pixels[x,y],fsSurface);
end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if(ssleft in shift) then Image1.Canvas.LineTo(x,y);
end;

procedure TForm1.ColorGrid1Change(Sender: TObject);
begin
Image1.Canvas.Pen.Color:=ColorGrid1.ForegroundColor;
Image1.Canvas.Brush.Color:=ColorGrid1.BackgroundColor;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
SavePictureDialog1.DefaultExt := GraphicExtension(TBitmap);
SavePictureDialog1.Filter := GraphicFilter(TBitmap);
if SavePictureDialog1.Execute then
Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
  {save the graphic }
end;

end.
