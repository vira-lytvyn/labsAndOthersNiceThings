unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ColorGrd, Menus, Buttons, ExtDlgs, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    ColorGrid1: TColorGrid;
    ImageBG: TImage;
    ImageFG: TImage;
    SBRect: TSpeedButton;
    SBLine: TSpeedButton;
    SBErase: TSpeedButton;
    SBEyeD: TSpeedButton;
    SBBrush: TSpeedButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SBPen: TSpeedButton;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    SpinEdit1: TSpinEdit;
    Image1: TImage;
    procedure OnCreate(Sender: TObject);
    procedure OnDestroy(Sender: TObject);
    procedure OnOpenClick(Sender: TObject);
    procedure OnSaveClick(Sender: TObject);
    procedure OnUndoClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpinEdit1Change(Sender: TObject);
    procedure ColorGrid1Change(Sender: TObject);
    procedure SBBrushClick(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SBLineClick(Sender: TObject);
    procedure SBPenClick(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
var BitMap:TBitMap;
	X0,Y0,X1,Y1:Integer;
    R, R0:TRect;
    seValue:Integer;
    RBegin:boolean=false;
    REnd:boolean=false;
    RDrag:boolean=false;

procedure TForm1.ColorGrid1Change(Sender: TObject);
begin
	ImageBG.Canvas.Brush.Color:=ColorGrid1.BackgroundColor;
	ImageFG.Canvas.Brush.Color:=ColorGrid1.ForegroundColor;
	with ImageBG.Canvas do
    	FillRect(Rect(0,0,Width,Height));
	with ImageFG.Canvas do
		FillRect(Rect(0,0,Width,Height));
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	if(Sender = ColorGrid1) then
	begin
		if(Button=mbLeft) then
        	with ImageFG.Canvas do
            begin
				Brush.Color:=ColorGrid1.ForegroundColor;
    			FillRect(Rect(0,0,Width,Height));
   			end
   		else
        	with ImageBG.Canvas do
            begin
    			Brush.Color:=ColorGrid1.BackgroundColor;
    			FillRect(Rect(0,0,Width,Height));
			end;
	end
    else if SBEyeD.Down then
	begin
		if(Button=mbLeft) then
        	with ImageFG.Canvas do
            begin
				Brush.Color:=(Sender as TImage).Canvas.Pixels[X,Y];
    			FillRect(Rect(0,0,Width,Height));
   			end
   		else
        	with ImageBG.Canvas do
            begin
    			Brush.Color:=(Sender as TImage).Canvas.Pixels[X,Y];
    			FillRect(Rect(0,0,Width,Height));
			end;
	end

	else
    	with Image1.Canvas do
        begin
   			X0:=X;
   			Y0:=Y;
  			if SBPen.Down then
            begin
				MoveTo(X,Y);
    			Pen.Color:=ImageFG.Canvas.Brush.Color;
   			end
  			else if SBLine.Down then
            begin
   				X1:=X;
   				Y1:=Y;
   				Pen.Mode:=pmNotXor;
   				Pen.Color:=ImageFG.Canvas.Brush.Color;
  			end
  			else if SBBrush.Down then
            begin
  				if Button=mbLeft then
                	Brush.Color:=ImageFG.Canvas.Brush.Color
   				else
                	Brush.Color:=ImageBG.Canvas.Brush.Color;
  	 			FloodFill(X,Y,Pixels[X,Y],fsSurface);
  			end
  			else if SBErase.Down then
            begin
            	SpinEdit1.Visible:=True;
                seValue:=SpinEdit1.Value;
    			R:=Rect(X-seValue,Y-seValue,X+seValue,Y+seValue);
    			DrawFocusRect(R);
    			Brush.Color:=ImageBG.Canvas.Brush.Color;
    			FillRect(Rect(X-seValue+1,Y-seValue+1,X+seValue+1,Y+seValue+1));
   			end
        	else if SBRect.Down then
            begin
   				if REnd then
                begin
    				DrawFocusRect(R);
    				if (X<R.Right) and (X>R.Left) and (Y>R.Top) and (Y<R.Bottom)then
                    begin
      					RDrag:=true;
      					REnd:=false;
                        R0.TopLeft:=R.TopLeft;
      					R0.BottomRight:=R.BottomRight;
      					BitMap.Assign(Image1.Picture);
      					Brush.Color:=ImageBG.Canvas.Brush.Color;
     				end;
    			end
     			else
                begin
      				RBegin:=true;
      				REnd:=false;
      				R.TopLeft:=Point(X,Y);
      				R.BottomRight:=Point(X,Y);
      				DrawFocusRect(R);
     			end;
   			end;
 		end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
	if not (ssLeft in Shift) then exit;
	if SBLine.Down then with Image1.Canvas do
    begin
  		MoveTo(X0,Y0);
  		LineTo(X1,Y1);
  		MoveTo(X0,Y0);
  		LineTo(X,Y);
  		X1:=X;
  		Y1:=Y;
	end
	else if SBPen.Down then
    	Image1.Canvas.LineTo(X,Y)
 	else if SBErase.Down then
    with Image1.Canvas do
    begin
    	DrawFocusRect(R);
    	R:=Rect(X-seValue,Y-seValue,X+seValue,Y+seValue);
    	DrawFocusRect(R);
    	FillRect(Rect(X-seValue+1,Y-seValue+1,X+seValue-1,Y+seValue-1));
   	end
 	else if (SBRect.Down and (RBegin or RDrag)) then
    	with Image1.Canvas do
        begin
  			if RBegin then
            begin
    			DrawFocusRect(R);
    			if X0<X then
                begin
                	R.Left:=X0;
                    R.Right:=X
                end
    		else
            begin
            	R.Left:=X;
                R.Right:=X0
            end;
    		if Y0<Y then
            begin
            	R.Top:=Y0;
                R.Bottom:=Y
            end
    		else
            begin
            	R.Top:=Y;
                R.Bottom:=Y0
            end;
    		DrawFocusRect(R);
   		end
  		else if SBRect.Down then
        begin
			CopyRect(R,BitMap.Canvas,R);
           	if not (ssCtrl in Shift) then
           		FillRect(R0);
           	R.Left:=R.Left+X-X0;
   			R.Right:=R.Right+X-X0;
   			R.Top:=R.Top+Y-Y0;
   			R.Bottom:=R.Bottom+Y-Y0;
   			X0:=X;
   			Y0:=Y;
   			CopyRect(R,BitMap.Canvas,R0);
   			DrawFocusRect(R);
  		end;
 	end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	with Image1.Canvas do
    begin
		if SBLine.Down then
        begin
 			MoveTo(X0,Y0);
 			LineTo(X1,Y1);
 			Pen.Mode:=pmCopy;
 			MoveTo(X0,Y0);
 			LineTo(X,Y);
 		end
		else if SBRect.Down then
        begin
 			if RDrag then DrawFocusRect(R);
 			if RBegin and not REnd then
   				REnd:=true;
 		end
 		else if SBErase.Down then
        	Image1.Canvas.DrawFocusRect(R);
 		RBegin:=false;
 		RDrag:=false;
	end;
end;

procedure TForm1.OnCreate(Sender: TObject);
begin
	BitMap:=TBitMap.Create;
	ImageBG.Canvas.Brush.Color:=ColorGrid1.BackgroundColor;
	ImageFG.Canvas.Brush.Color:=ColorGrid1.ForegroundColor;
	with ImageBG.Canvas do
    	FillRect(Rect(0,0,Width,Height));
	with ImageFG.Canvas do
		FillRect(Rect(0,0,Width,Height));
	Image1.Canvas.Brush.Color:=clWhite;
	with Image1.Canvas do
		FillRect(Rect(0,0,Width,Height));
	BitMap.Assign(Image1.Picture);
end;

procedure TForm1.OnDestroy(Sender: TObject);
begin
	BitMap.Free;
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

procedure TForm1.SBBrushClick(Sender: TObject);
begin
	if (Sender as TSpeedButton).Down then
    	BitMap.Assign(Image1.Picture);
	RBegin:=false;
	RDrag:=false;
	REnd:=false;
end;

procedure TForm1.SBLineClick(Sender: TObject);
begin
	SpinEdit1.Visible:=True;
end;

procedure TForm1.SBPenClick(Sender: TObject);
begin
	SpinEdit1.Visible:=True;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
	seValue:=SpinEdit1.Value;
    Image1.Canvas.Pen.Width:=seValue;
end;

end.
