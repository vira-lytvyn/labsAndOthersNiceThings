unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi, ExtCtrls, ColorGrd, Menus, Buttons, ExtDlgs, StdCtrls, Spin, ComCtrls;

type

  TToolType=(ttline, ttrect, ttellipse, ttroundrect, ttspray, ttpen, tterase);
   TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Image1: TImage;
    ColorDialog1: TColorDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    SBPen: TSpeedButton;
    TabSheet2: TTabSheet;
    SBLine: TSpeedButton;
    TabSheet4: TTabSheet;
    SBRectang: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    TabSheet5: TTabSheet;
    SBErase: TSpeedButton;
    TabSheet6: TTabSheet;
    SpeedButton1: TSpeedButton;
    RadioGroup1: TRadioGroup;
    TabSheet7: TTabSheet;
    SpeedButton4: TSpeedButton;
    StatusBar1: TStatusBar;
    procedure OnCreate(Sender: TObject);
    procedure OnDestroy(Sender: TObject);
    procedure OnOpenClick(Sender: TObject);
    procedure OnSaveClick(Sender: TObject);
    procedure OnUndoClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SBPenClick(Sender: TObject);
    procedure SBLineClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SBRectangClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SBEraseClick(Sender: TObject);
    private
    { Private declarations }
  public
    { Public declarations }
    PenWide: Integer;
    Drawing: Boolean;
    mousepos1, mousepos2: TPoint;
    activeTool: TToolType;
    procedure DrawShape(TopLeft, BottomRight: TPoint; AMode: TPenMode);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
var BitMap :TBitMap;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
  Drawing:=true;
  mousepos1:=point(x,y);
  mousepos2:=mousepos1;
  image1.Canvas.MoveTo(x,y);
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Drawing then
  begin
    DrawShape(mousepos1, mousepos2, pmNotXor);
    mousepos2 := Point(X, Y);
    DrawShape(mousepos1, mousepos2, pmNotXor);
  end;
  StatusBar1.Panels[0].Text := Format('X=%d, Y=%d', [X, Y]);
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if Drawing then
  begin
    DrawShape(mousepos1, Point(X, Y), pmCopy);
    Drawing := False;
  end;
end;

procedure TForm1.OnCreate(Sender: TObject);
begin
  Drawing:= false;
 	BitMap:=TBitMap.Create;
	Image1.Canvas.Brush.Color:=clWhite;
	with Image1.Canvas do
		FillRect(Rect(0,0,Width,Height));
	BitMap.Assign(Image1.Picture);
end;

procedure TForm1.OnDestroy(Sender: TObject);
begin
	BitMap.Free;
  Drawing:= false;
end;

procedure TForm1.OnOpenClick(Sender: TObject);
begin
	if OpenPictureDialog1.Execute then
    begin
    	Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
        BitMap.Assign(Image1.Picture);
    end;
end;

procedure TForm1.OnSaveClick(Sender: TObject);
begin
	if SavePictureDialog1.Execute then
	begin
		BitMap.Assign(Image1.Picture);
		BitMap.SaveToFile(SavePictureDialog1.FileName);
	end;
end;

procedure TForm1.OnUndoClick(Sender: TObject);
begin
    Image1.Picture.Assign(BitMap);
end;

procedure TForm1.SBEraseClick(Sender: TObject);
begin
    activetool := tterase;
end;

procedure TForm1.SBLineClick(Sender: TObject);
begin
  activetool:= ttline;
end;

procedure TForm1.SBPenClick(Sender: TObject);
begin
    activetool:= ttpen;
end;

procedure TForm1.SBRectangClick(Sender: TObject);
begin
  activetool:=ttrect;
end;

procedure TForm1.DrawShape(TopLeft, BottomRight: TPoint; AMode: TPenMode);
begin
  with Image1.Canvas do
  begin
    Pen.Mode := AMode;
    case activeTool of
      tterase:
        begin
          image1.Canvas.Pen.Mode := pmWhite;
          image1.Canvas.Pen.Width:=SpinEdit4.Value;
          Image1.Canvas.LineTo(BottomRight.X, BottomRight.Y);
        end;
      ttpen:
        begin
          //if form1.RadioGroup1.ItemIndex = 0 then
          image1.Canvas.Pen.Mode := pmCopy;
          image1.Canvas.Pen.Width:=SpinEdit1.Value;
          Image1.Canvas.LineTo(BottomRight.X, BottomRight.Y);
        end;
      ttLine:
        begin
          if form1.RadioGroup1.ItemIndex = 0
            then
               image1.Canvas.Pen.Mode := pmCopy;
          image1.Canvas.Pen.Width := SpinEdit3.Value;
          Image1.Canvas.MoveTo(TopLeft.X, TopLeft.Y);
          Image1.Canvas.LineTo(BottomRight.X, BottomRight.Y);
        end;
      ttRect:
        begin
          if form1.RadioGroup1.ItemIndex = 0
            then
               image1.Canvas.Pen.Mode := pmCopy;
          image1.Canvas.Pen.Width := SpinEdit5.Value;
          image1.Canvas.Brush.Style:=bsclear;
          Image1.Canvas.Rectangle(TopLeft.X, TopLeft.Y, BottomRight.X,BottomRight.Y);
        end;
      ttEllipse:
        begin
          if form1.RadioGroup1.ItemIndex = 0
            then
               image1.Canvas.Pen.Mode := pmCopy;
          image1.Canvas.Pen.Width := SpinEdit5.Value;
          image1.Canvas.Brush.Style:=bsclear;
          Image1.Canvas.Ellipse(Topleft.X, TopLeft.Y, BottomRight.X, BottomRight.Y);
        end;
      ttRoundRect:
        begin
          if form1.RadioGroup1.ItemIndex = 0
            then
               image1.Canvas.Pen.Mode := pmCopy;
          image1.Canvas.Pen.Width := SpinEdit5.Value;
          image1.Canvas.Brush.Style:=bsclear;
          Image1.Canvas.RoundRect(TopLeft.X, TopLeft.Y, BottomRight.X, BottomRight.Y, (TopLeft.X - BottomRight.X) div 2, (TopLeft.Y - BottomRight.Y) div 2);
        end;
      ttspray:
        begin                                                                                                  begin
          randomize;
          image1.Canvas.Pen.Width := SpinEdit2.Value;
          image1.Canvas.Pixels[topleft.x+random(image1.Canvas.Pen.Width), topleft.y+random(image1.Canvas.Pen.Width)] :=image1.Canvas.Pen.Color;
          image1.Canvas.Pixels[bottomright.x+random(image1.Canvas.Pen.Width), bottomright.y+random(image1.Canvas.Pen.Width)]:=image1.Canvas.Pen.Color;
        end;
    end;
    end;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
    if colordialog1.Execute then
 image1.Canvas.Pen.Color:=colordialog1.Color;
 speedbutton1.Glyph:=tbitmap.create;
 speedbutton1.Glyph.Width:=speedbutton1.Width;
 speedbutton1.Glyph.Height:=speedbutton1.Height;
 speedbutton1.Glyph.Canvas.Brush.Color:=colordialog1.Color;
 speedbutton1.Caption:='';
 speedbutton1.Glyph.Canvas.Rectangle(2,2,speedbutton1.Width-6,speedbutton1.Height-6);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  activetool:=ttroundrect;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  activetool:=ttellipse;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  activetool:=ttspray;
end;

end.
