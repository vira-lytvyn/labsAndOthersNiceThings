unit UCopyM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    BCopy1: TButton;
    BCopy2: TButton;
    Image3: TImage;
    CBCopyMode: TComboBox;
    BLoad1: TButton;
    BLoad2: TButton;
    procedure BCopy1Click(Sender: TObject);
    procedure BCopy2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBCopyModeChange(Sender: TObject);
    procedure BLoad1Click(Sender: TObject);
    procedure BLoad2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

var CM:longint;

procedure TForm1.BCopy1Click(Sender: TObject);
begin
Image3.Canvas.CopyMode:=CM;
Image3.Canvas.CopyRect(Rect(0,0,200,200),Image1.Canvas,Rect(0,0,200,200));
end;

procedure TForm1.BLoad1Click(Sender: TObject);
begin
 Image3.Canvas.CopyMode:=cmSrcCopy;
 Image3.Canvas.CopyRect(Rect(0,0,200,200),Image1.Canvas,Rect(0,0,200,200));
end;

procedure TForm1.BCopy2Click(Sender: TObject);
begin
 Image3.Canvas.CopyMode:=CM;
 Image3.Canvas.Copyrect(Rect(0,0,200,200),Image2.Canvas,Rect(0,0,200,200));
end;

procedure TForm1.BLoad2Click(Sender: TObject);
begin
 Image3.Canvas.CopyMode:=cmSrcCopy;
 Image3.Canvas.Copyrect(Rect(0,0,200,200),Image2.Canvas,Rect(0,0,200,200));
end;

procedure TForm1.FormCreate(Sender: TObject);
var HW1,HW2,i:integer;
begin
CBCopyMode.ItemIndex:=10;
CM:=cmSrcCopy;
HW1:=Image1.Height div 10;
HW2:=Image2.Width div 10;
for i:=1 to 10 do begin
 case i of
  1: begin
      Image1.Canvas.Brush.Color:=clBlack;
      Image2.Canvas.Brush.Color:=clBlack;
     end;
  2: begin
      Image1.Canvas.Brush.Color:=clAqua;
      Image2.Canvas.Brush.Color:=clAqua;
     end;
  3: begin
      Image1.Canvas.Brush.Color:=clBlue;
      Image2.Canvas.Brush.Color:=clBlue;
     end;
  4: begin
      Image1.Canvas.Brush.Color:=clFuchsia;
      Image2.Canvas.Brush.Color:=clFuchsia;
     end;
  5: begin
      Image1.Canvas.Brush.Color:=clGreen;
      Image2.Canvas.Brush.Color:=clGreen;
     end;
  6: begin
      Image1.Canvas.Brush.Color:=clLime;
      Image2.Canvas.Brush.Color:=clLime;
     end;
  7: begin
      Image1.Canvas.Brush.Color:=clMaroon;
      Image2.Canvas.Brush.Color:=clMaroon;
     end;
  8: begin
      Image1.Canvas.Brush.Color:=clRed;
      Image2.Canvas.Brush.Color:=clRed;
     end;
  9: begin
      Image1.Canvas.Brush.Color:=clYellow;
      Image2.Canvas.Brush.Color:=clYellow;
     end;
  10:begin
      Image1.Canvas.Brush.Color:=clWhite;
      Image2.Canvas.Brush.Color:=clWhite;
     end;
  end;
   Image1.Canvas.Rectangle(0,(i-1)*HW1,Width,i*HW1);
   Image2.Canvas.Rectangle((i-1)*HW2,0,i*HW2,Height);
  end;
end;

procedure TForm1.CBCopyModeChange(Sender: TObject);
begin
 case CBCopyMode.ItemIndex of
  0:CM:=cmBlackness;
  1: CM:=cmDstInvert;
  2: CM:=cmMergeCopy;
  3: CM:=cmMergePaint;
  4: CM:=cmNotSrcCopy;
  5: CM:=cmNotSrcErase;
  6: CM:=cmPatCopy;
  7: CM:=cmPatInvert;
  8: CM:=cmPatPaint;
  9: CM:=cmSrcAnd;
  10:CM:=cmSrcCopy;
  11:CM:=cmSrcErase;
  12:CM:=cmSrcInvert;
  13:CM:=cmSrcPaint;
  14:CM:=cmWhiteness;
 end;
end;

end.
