{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_DragWindow                             }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000dragwindow;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls, Menus,
  Forms, am2000options, am2000utils;


type
  // popup menu

  T_AM2000_DragWindow = class(TForm)
  private
    bi: TBitmapInfo;
    LastCursorPos: TPoint;
    FPaintParams: T_AM2000_PaintMenuItemParams;
    Buffer, TempBmp: TBitmap;
    bits, bits0: PByteArray;
    BitsSize: {$IFDEF Delphi4OrHigher}Cardinal{$ELSE}Integer{$ENDIF};
    NewLeft, NewTop: Integer;
    MouseCaptureControl: TControl;
    FOpacity: T_AM2000_Opacity;
    LastControl: TControl;
    
    procedure SetOpacity(const Value: T_AM2000_Opacity);

  protected
    procedure Paint; override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure wmMouseMove(var Msg: TWMMouse); message wm_MouseMove;
    procedure wmEraseBkgnd(var Msg: TWMEraseBkgnd); message wm_EraseBkgnd;
    procedure CreateParams(var Params: TCreateParams); override;

  public
    MouseCapture: Boolean;
    property Opacity: T_AM2000_Opacity read FOpacity write SetOpacity;

    constructor CreateRect(AFont: TFont; ARect: TRect; AOptions: T_AM2000_Options; ACtl3D: Boolean); virtual;
    destructor Destroy; override;

    procedure SilentShow;
    procedure SilentHide;
    procedure Repaint; override;
    procedure PaintFramedItem(Canvas: TCanvas; Rect: TRect; Color: TColor);

  end;


const
  ActiveDragWindow: T_AM2000_DragWindow = nil;

procedure SetDragCursor;
procedure RejectDragTarget;


implementation

uses
  am2000popupmenu, am2000menuitem, am2000desktop, am2000menubar;

var
  DragOpacityData, FrameOpacityData: P_AM2000_OpacityData;

{ Drag routines }

procedure RejectDragTarget;
var
  F: TForm;
begin
  Screen.Cursor:= crNo;

  InsertBeforeItem:= miNothingToInsert;
  InsertBeforeParent:= nil;
  LastInsertBeforeItem:= nil;

  if ActiveDragWindow <> nil
  then
    with ActiveDragWindow
    do begin
      SilentHide;

      if ActivePopupMenu <> nil
      then begin
        F:= TCustomPopupMenu2000(ActivePopupMenu).GetFormAtPos(LastCursorPos);

        if F <> nil
        then F.Invalidate;
      end;
    end;
end;

procedure SetDragCursor;
begin
  if Screen.Cursor <> crArrow
  then begin
    if (Screen.Cursor <> crNo)
    and (Screen.Cursor <> crArrow)
    then CursorDefault:= Screen.Cursor;

    Screen.Cursor:= crArrow;
  end;

  if ActiveDragWindow <> nil
  then ActiveDragWindow.SilentShow;
end;


{ T_AM2000_DragWindow }

constructor T_AM2000_DragWindow.CreateRect(AFont: TFont; ARect: TRect; AOptions: T_AM2000_Options; ACtl3D: Boolean);
var
  ImageHeaderSize: {$IFDEF Delphi4OrHigher}Cardinal{$ELSE}Integer{$ENDIF};
  X: Integer;

  procedure PaintActiveMenuItem(const ACanvas: TCanvas);
  begin
    with FPaintParams
    do begin
      State:= [isSelected];

      if ACtl3D
      then Include(State, isCtl3d);

      Canvas:= ACanvas;
      Item:= ActiveMenuItem;
      Handle:= ActiveMenuItem.Handle;
      PaintOptions.Assign(AOptions);
      MouseState:= [msMouseOver, msLeftButton];
      FullRepaint:= True;

      Images:= PaintParams.Images;

      mir.Assign(PaintParams.mir);
      mir.Top:= 0;
      mir.Height:= Height;

      if AOptions.Margins.Left > 0
      then Dec(mir.ItemLeft, mir.LineLeft)
      else mir.ItemLeft:= mir.LineLeft;
      
      Dec(mir.ShortcutLeft, mir.LineLeft);
      Dec(mir.BitmapLeft, mir.LineLeft);
      Dec(mir.TriangleLeft, mir.LineLeft);
      Dec(mir.GraphLeft, mir.LineLeft);

      mir.LineLeft:= 0;
      mir.LineRight:= Width;

      with Canvas
      do begin
        Brush.Color:= PaintOptions.Colors.Menu;
        FillRect(ClipRect);
      end;
    end;

    PaintMenuItem(@FPaintParams);
  end;

begin
  inherited CreateNew(nil {$IFDEF CBuilder1}, 0{$ENDIF});

  ControlStyle:= ControlStyle + [csCaptureMouse];
  FormStyle:= fsStayOnTop;
  BoundsRect:= ARect;
  BorderStyle:= bsNone;
  Cursor:= crArrow;
  GetCursorPos(LastCursorPos);
  FPaintParams.mir:= T_AM2000_MenuItemRect.Create;
  FPaintParams.PaintOptions:= T_AM2000_MenuOptions.Create(Self);
  MouseCapture:= True;

  // build opacity data
  BuildOpacityData(30, FrameOpacityData);
  Canvas.Font.Assign(AFont);

  if Assigned(pSetLayeredWindowAttributes)
  then begin
    X:= GetWindowLong(Handle, gwl_ExStyle);
    if X and ws_ex_Layered = 0
    then SetWindowLong(Handle, gwl_ExStyle, X or ws_ex_Layered);

    pSetLayeredWindowAttributes(Handle, 0, 180, lwa_Alpha);
  end
  else begin
    // build opacity data
    BuildOpacityData(70, DragOpacityData);
  end;


  // create buffer & get source image
  Buffer:= TBitmap.Create;
  Buffer.Handle:= CreateCompatibleBitmap(Buffer.Canvas.Handle, Width, Height);
{$IFDEF Delphi3OrHigher}
  Buffer.PixelFormat:= pf24bit;
{$ENDIF}
  Buffer.Canvas.Font.Assign(AFont);

  PaintActiveMenuItem(Buffer.Canvas);

  // get menu item image
  GetDibSizes(Buffer.Handle, ImageHeaderSize, BitsSize);
  GetMem(bits, BitsSize);
  GetMem(bits0, BitsSize);

  GetDib(Buffer.Handle, Buffer.Palette, bi, bits0^);


  if Assigned(pSetLayeredWindowAttributes)
  then begin
    FPaintParams.Canvas:= Self.Canvas;
    Buffer.Free;
    Buffer:= nil;
  end
  else begin
    // reserve desktop image
    TempBmp:= TBitmap.Create;
    TempBmp.Handle:= CreateCompatibleBitmap(TempBmp.Canvas.Handle, Width, Height);
{$IFDEF Delphi3OrHigher}
    TempBmp.PixelFormat:= pf24bit;
{$ENDIF}

    Desktop.GetBitmapNoLock(TempBmp.Canvas.Handle, Left, Top, Width, Height);
  end;

  NewLeft:= Left;
  NewTop:= Top;
end;

procedure T_AM2000_DragWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle:= Params.ExStyle or WS_EX_TOOLWINDOW;
  Params.WindowClass.style:= Params.WindowClass.style or CS_SAVEBITS;
end;

destructor T_AM2000_DragWindow.Destroy;
begin
  SilentHide;

  if ActiveDragWindow = Self
  then ActiveDragWindow:= nil;

  FPaintParams.mir.Free;
  FPaintParams.mir:= nil;
  FPaintParams.PaintOptions.Free;
  FPaintParams.PaintOptions:= nil;

  Buffer.Free;
  TempBmp.Free;

  FreeMemAndNil(bits);
  FreeMemAndNil(bits0);

  inherited Destroy;
end;

procedure T_AM2000_DragWindow.wmMouseMove(var Msg: TWMMouse);
var
  P: TPoint;
  F: TForm;
  I: Integer;
  CurrentControl: TControl;
begin
  if not MouseCapture
  then begin
    inherited;
    Exit;
  end;

  // get control under cursor
  CurrentControl:= nil;
  GetCursorPos(P);

  if (ActiveMenuBarList <> nil)
  then
    for I:= 0 to ActiveMenuBarList.Count -1
    do
      with TCustomMenuBar2000(ActiveMenuBarList[I]), ScreenToClient(P)
      do
        if PtInRect(ClientRect, Point(X, Y))
        then begin
          Perform(wm_MouseMove, Msg.Keys, MakeLong(X, Y));
          CurrentControl:= TCustomMenuBar2000(ActiveMenuBarList[I]);

          if Screen.Cursor <> crArrow
          then SetDragCursor;
        end;

  if (CurrentControl = nil)
  and AssignedActivePopupMenu2000Form
  then begin
    F:= TCustomPopupMenu2000(ActivePopupMenu).GetFormAtPos(P);
    if F <> nil
    then
      with F.ScreenToClient(LastCursorPos)
      do begin
        F.Perform(wm_MouseMove, Msg.Keys, MakeLong(X, Y));
        CurrentControl:= F;
      end;
  end;

  if (CurrentControl <> LastControl)
  and (LastControl <> nil)
  then begin
    InsertBeforeItem:= nil;     
    LastControl.Perform(cm_MouseLeave, 0, 0);
  end;

  if (CurrentControl = nil)
  then RejectDragTarget;

  LastControl:= CurrentControl;


  inherited;

  NewLeft:= Left + P.X - LastCursorPos.X;
  NewTop:= Top + P.Y - LastCursorPos.Y;

  if (NewLeft = Left)
  and (NewTop = Top)
  then Exit;

  Paint;

  SetBounds(NewLeft, NewTop, Width, Height);

  LastCursorPos:= P;
end;

procedure T_AM2000_DragWindow.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  SilentHide;
  EndCustomization(Screen.Cursor <> crNo);
  Release;
end;

procedure T_AM2000_DragWindow.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if ssRight in Shift
  then begin
    SilentHide;
    EndCustomization(False);
    Release;
  end;
end;


procedure T_AM2000_DragWindow.SilentShow;
begin
  if MouseCapture
  then begin
    MouseCaptureControl:= GetCaptureControl;
    SetCaptureControl(Self);
  end;

  ShowWindow(Handle, sw_ShowNA);
  SetWindowPos(Handle, hwnd_TopMost, Left, Top, Width, Height, FormFlags);
end;

procedure T_AM2000_DragWindow.SilentHide;
begin
  if MouseCapture
  then SetCaptureControl(MouseCaptureControl);
  
  ShowWindow(Handle, sw_Hide);
end;


procedure T_AM2000_DragWindow.Paint;
var
  F: TForm;
  POC: TWmPaintOnCanvas;
begin
  if ActiveMenuItem = nil
  then Exit;

  if Assigned(pSetLayeredWindowAttributes)
  then begin
    PaintMenuItem(@FPaintParams);
    Exit;
  end;

  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  then Exit;

  // get desktop
  BitBlt(Buffer.Canvas.Handle, 0, 0, Width, Height, Desktop.Handle, NewLeft, NewTop, SrcCopy);
  BitBlt(Buffer.Canvas.Handle, Left - NewLeft, Top - NewTop, Width, Height, TempBmp.Canvas.Handle, 0, 0, SrcCopy);

  // get underlying menu
  if ActivePopupMenu <> nil
  then begin
    FillChar(POC, SizeOf(POC), 0);
    POC.pFrom.X:= NewLeft;
    POC.pFrom.Y:= NewTop;
    F:= TCustomPopupMenu2000(ActivePopupMenu).Form;
    F.Perform(wm_PaintOnCanvas, Buffer.Canvas.Handle, Integer(@POC));
  end;

  if DragOpacityData <> nil
  then begin
    BitBlt(TempBmp.Canvas.Handle, 0, 0, Width, Height, Buffer.Canvas.Handle, 0, 0, SrcCopy);
    GetDib(Buffer.Handle, Buffer.Palette, bi, bits^);
    ProcessOpacityData(bits0, bits, bits, @bits[BitsSize -1], DragOpacityData);
    SetDIBitsToDevice(Canvas.Handle, 0, 0, Width, Height, 0, 0, 0, Height, bits, bi, Dib_Rgb_Colors);
  end
  else
    BitBlt(Canvas.Handle, 0, 0, Width, Height, Buffer.Canvas.Handle, 0, 0, SrcCopy);
end;

procedure T_AM2000_DragWindow.PaintFramedItem(Canvas: TCanvas; Rect: TRect; Color: TColor);
var
  Y, X, I, C, D, BitsPerLine: Cardinal;
  R, G, B: Byte;
begin
  // we need to process it only once with Windows 2000;
  if FrameOpacityData <> nil
  then begin
    C:= ColorToRGB(Color);
    R:= GetRValue(C);
    G:= GetGValue(C);
    B:= GetBValue(C);

    D:= bi.bmiHeader.biBitCount shr 3;
    BitsPerLine:= BitsSize div Height;

    for Y:= 0 to Height -1
    do
      for X:= 0 to Width -1
      do begin
        I:= BitsPerLine * Y + X * D;
        bits[I +2]:= R;
        bits[I +1]:= G;
        bits[I]:= B;
      end;

    ProcessOpacityData(bits0, bits, bits, @bits[BitsSize -1], FrameOpacityData);

    if Assigned(pSetLayeredWindowAttributes)
    then begin
      FreeMem(FrameOpacityData);
      FrameOpacityData:= nil;
    end;
  end;

  SetDIBitsToDevice(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
    0, 0, 0, Height, bits, bi, Dib_Rgb_Colors);
end;

procedure T_AM2000_DragWindow.wmEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  Paint;
end;

procedure T_AM2000_DragWindow.Repaint;
begin
  Paint;
end;

procedure T_AM2000_DragWindow.SetOpacity(const Value: T_AM2000_Opacity);
begin
  FOpacity := Value;

  if Assigned(pSetLayeredWindowAttributes)
  then
    pSetLayeredWindowAttributes(Handle, 0, Round((255 * Value)/100), lwa_Alpha)
    
  else begin
    BuildOpacityData(Value, DragOpacityData);
    BuildOpacityData(100 - Value, FrameOpacityData);
  end;

  Paint;
end;

initialization
finalization
  FreeMemAndNil(DragOpacityData);

end.
