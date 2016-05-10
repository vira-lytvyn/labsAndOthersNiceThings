unit UGrEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, Buttons, ExtDlgs, Clipbrd;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    MainMenu1: TMainMenu;
    MFile: TMenuItem;
    SBBrush: TSpeedButton;
    N1: TMenuItem;
    Undo: TMenuItem;
    SBColor: TSpeedButton;
    SBRect: TSpeedButton;
    MOpen: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    SBRectang: TSpeedButton;
    SBFillRec: TSpeedButton;
    SBErase: TSpeedButton;
    SBPen: TSpeedButton;
    SBLine: TSpeedButton;
    MSave: TMenuItem;
    MCut: TMenuItem;
    MCopy: TMenuItem;
    MPaste: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UndoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBBrushClick(Sender: TObject);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MOpenClick(Sender: TObject);
    procedure MCopyClick(Sender: TObject);
    procedure MPasteClick(Sender: TObject);
    procedure MSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

var BitMap,BMCopy:TBitMap;
    R,R0:TRect;
    X0,Y0,X1,Y1:longint;
    RBegin:boolean=false;
    REnd:boolean=false;
    RDrag:boolean=false;

procedure TForm1.FormCreate(Sender: TObject);
var HW,i:integer;
begin
BitMap:=TBitMap.Create;
{задание свойств кисти основного и вспомогательного цветов}
 Image1.Canvas.Brush.Color:=clBlack;
 Image2.Canvas.Brush.Color:=clWhite;
{заполнение окон основного и вспомогательного цветов}
 with Image1.Canvas do FillRect(Rect(0,0,Width,Height));
 with Image2.Canvas do FillRect(Rect(0,0,Width,Height));
{задание ширины элемента палитры цветов}
 HW:=Image4.Width div 10;
{закраска элементов палитры цветов}
 with Image4.Canvas do
  for i:=1 to 10 do begin
   case i of
    1:Brush.Color:=clBlack;
    2:Brush.Color:=clAqua;
    3:Brush.Color:=clBlue;
    4:Brush.Color:=clFuchsia;
    5:Brush.Color:=clGreen;
    6:Brush.Color:=clLime;
    7:Brush.Color:=clMaroon;
    8:Brush.Color:=clRed;
    9:Brush.Color:=clYellow;
    10:Brush.Color:=clWhite;
   end;
   Rectangle((i-1)*HW,0,i*HW,Height);
  end;
{рисование креста на холсте - только для тестирования}
 with Image3 do begin
  Canvas.MoveTo(0,0);
  Canvas.LineTo(Width,Height);
  Canvas.MoveTo(0,Height);
  Canvas.LineTo(Width,0);
 end;
 BitMap.Assign(Image3.Picture);
end;

procedure TForm1.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if(Sender = Image4) or SBColor.Down then
{режим установки основного и вспомогательного цветов}
 begin
  if(Button=mbLeft)
   then with Image1.Canvas do begin
  {установка основного цвета}
    Brush.Color:=(Sender as TImage).Canvas.Pixels[X,Y];
    FillRect(Rect(0,0,Width,Height));
   end
   else with Image2.Canvas do begin
  {установка вспомогательного цвета}
    Brush.Color:=(Sender as TImage).Canvas.Pixels[X,Y];
    FillRect(Rect(0,0,Width,Height));
   end;
 end
 else with Image3.Canvas do begin
   X0:=X;
   Y0:=Y;
  if SBPen.Down
   then begin
{режим карандаша}
    MoveTo(X,Y);
    Pen.Color:=Image1.Canvas.Brush.Color;
   end
  else if SBLine.Down then begin
{режим линии}
   X1:=X;
   Y1:=Y;
   Pen.Mode:=pmNotXor;
   Pen.Color:=Image1.Canvas.Brush.Color;
  end
  else if SBBrush.Down then begin
{режим закраски указанной области холста}
  if Button=mbLeft
   then Brush.Color:=Image1.Canvas.Brush.Color
   else Brush.Color:=Image2.Canvas.Brush.Color;
   FloodFill(X,Y,Pixels[X,Y],fsSurface);
  end
  else if SBErase.Down
   then begin
{режим ластика}
    R:=Rect(X-6,Y-6,X+6,Y+6);
    DrawFocusRect(R);
    Brush.Color:=Image2.Canvas.Brush.Color;
    FillRect(Rect(X-5,Y-5,X+5,Y+5));
   end
  else if SBRect.Down or SBRectang.Down or SBFillRec.Down
  then begin
{режим работы с фрагментом}
   if REnd then begin
{стирание прежней рамки}
    DrawFocusRect(R);
    if (X<R.Right) and (X>R.Left) and (Y>R.Top) and (Y<R.Bottom)
{режим начала перетаскивания фрагмента}
     then begin
{установка флагов}
      RDrag:=true;
      REnd:=false;
{запоминание начального положения перетаскиваемого фрагмента}
      R0.TopLeft:=R.TopLeft;
      R0.BottomRight:=R.BottomRight;
{запоминание изображения}
      BitMap.Assign(Image3.Picture);
{установка цвета кисти}
      Brush.Color:=Image2.Canvas.Brush.Color;
      MCopy.Enabled:=false;
      MCut.Enabled:=false;
     end;
    end
     else begin
{режим начала рисования рамки фрагмента}
      RBegin:=true;
      REnd:=false;
      R.TopLeft:=Point(X,Y);
      R.BottomRight:=Point(X,Y);
      DrawFocusRect(R);
     end;
   end;
 end;
end;

procedure TForm1.UndoClick(Sender: TObject);
begin
 Image3.Picture.Assign(BitMap);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
BitMap.Free;
end;

procedure TForm1.SBBrushClick(Sender: TObject);
begin
 if (Sender as TSpeedButton).Down
  then BitMap.Assign(Image3.Picture);
 RBegin:=false;
 RDrag:=false;
 REnd:=false;
end;

procedure TForm1.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if not (ssLeft in Shift) then exit;
{режим линии}
if SBLine.Down then with Image3.Canvas do begin
{стирание прежней линии}
  MoveTo(X0,Y0);
  LineTo(X1,Y1);
{рисование новой линии}
  MoveTo(X0,Y0);
  LineTo(X,Y);
{запоминание новых координат конца линии}
  X1:=X;
  Y1:=Y;
 end
else if SBPen.Down
 then Image3.Canvas.LineTo(X,Y)
 else if SBErase.Down
   then with Image3.Canvas do begin
{режим ластика}
    DrawFocusRect(R);
    R:=Rect(X-6,Y-6,X+6,Y+6);
    DrawFocusRect(R);
    FillRect(Rect(X-5,Y-5,X+5,Y+5));
   end
 else if (SBRect.Down and (RBegin or RDrag))
 or SBRectang.Down or SBFillRec.Down
 then with Image3.Canvas do begin
  if RBegin then begin
{Режим рисования рамки фрагмента}
    DrawFocusRect(R);
    if X0<X then begin R.Left:=X0; R.Right:=X end
    else begin R.Left:=X; R.Right:=X0 end;
    if Y0<Y then begin R.Top:=Y0; R.Bottom:=Y end
    else begin R.Top:=Y; R.Bottom:=Y0 end;
    DrawFocusRect(R);
   end
  else if SBRect.Down then begin
{Режим перетаскивания фрагмента}
{восстановление изображения под перетаскиваемым фрагментом}
   CopyRect(R,BitMap.Canvas,R);
{если не нажата клавиша Ctrl - стирание изображения в R0}
   if not (ssCtrl in Shift)
    then FillRect(R0);
{формирование нового положения фрагмента }
   R.Left:=R.Left+X-X0;
   R.Right:=R.Right+X-X0;
   R.Top:=R.Top+Y-Y0;
   R.Bottom:=R.Bottom+Y-Y0;
{запоминание положения курсора мыши}
   X0:=X;
   Y0:=Y;
{рисование фрагмента в новом положении}
   CopyRect(R,BitMap.Canvas,R0);
{рисование рамки}
   DrawFocusRect(R);
  end;
 end;
end;

procedure TForm1.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
with Image3.Canvas do begin
if SBLine.Down then begin
 MoveTo(X0,Y0);
 LineTo(X1,Y1);
 Pen.Mode:=pmCopy;
 MoveTo(X0,Y0);
 LineTo(X,Y);
 end
else if SBRect.Down then begin
 if RDrag then DrawFocusRect(R);
 if RBegin and not REnd
  then begin
   REnd:=true;
   MCopy.Enabled:=true;
   MCut.Enabled:=true;
  end
 end
 else if SBRectang.Down
 then begin
  Brush.Color:=Image1.Canvas.Brush.Color;
  FrameRect(R);
 end
 else if SBFillRec.Down
 then begin
  Brush.Color:=Image2.Canvas.Brush.Color;
  Pen.Color:=Image1.Canvas.Brush.Color;
  Rectangle(R.Left,R.Top,R.Right,R.Bottom);
 end
 else if SBErase.Down
   then Image3.Canvas.DrawFocusRect(R);
 RBegin:=false;
 RDrag:=false;
end;
end;

procedure TForm1.MOpenClick(Sender: TObject);
begin
 if OpenPictureDialog1.Execute then begin
  Image3.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  BitMap.Assign(Image3.Picture);
 end;
end;

procedure TForm1.MCopyClick(Sender: TObject);
{var
 MyFormat: Word;
 AData: THandle;
 APalette: HPALETTE;}
begin
 Image3.Canvas.DrawFocusRect(R);
 BMCopy:=BitMap.Create;
 BMCopy.Width:=R.Right-R.Left;
 BMCopy.Height:=R.Bottom-R.Top;
 try
  BMCopy.Canvas.Copyrect(Rect(0,0,BMCopy.Width,BMCopy.Height),Image3.Canvas,R);
  Image3.Canvas.DrawFocusRect(R);
{  BMCopy.SaveToClipBoardFormat(MyFormat,AData,APalette);
  ClipBoard.SetAsHandle(MyFormat,AData);}
  ClipBoard.Assign(BMCopy);
  if (Sender as TMenuItem).Name='MCut'
   then begin
    Image3.Canvas.Brush.Color:=clWhite;
    Image3.Canvas.FillRect(R);
   end;
 finally
  BMCopy.Free;
 end;
end;

procedure TForm1.MPasteClick(Sender: TObject);
begin
 BMCopy:=BitMap.Create;
 try
  try
   BMCopy.LoadFromClipBoardFormat(cf_BitMap,
                         ClipBoard.GetAsHandle(cf_Bitmap),0);
   {BMCopy.Assign(ClipBoard);}
   Image3.Canvas.CopyRect(Rect(0,0,BMCopy.Width,BMCopy.Height),
         BMCopy.Canvas,Rect(0,0,BMCopy.Width,BMCopy.Height));
  finally
   BMCopy.Free;
  end;
 except
  On EInvalidGraphic do ShowMessage('Ошибочный формат графики');
 end;
end;            

procedure TForm1.MSaveClick(Sender: TObject);
begin
 If SavePictureDialog1.Execute
  then begin
    BitMap.Assign(Image3.Picture);
    BitMap.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

end.
