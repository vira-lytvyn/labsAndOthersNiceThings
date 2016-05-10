{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Windows XP Theme Manager Support                }
{                                                       }
{       Copyright (c) 1997-2002 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit am2000theme;

{$I am2000.inc}

interface

uses
  Windows, Messages, Graphics, Classes, Controls, StdCtrls, Forms,
  ExtCtrls, ComCtrls, Buttons, Dialogs;

type

  T_AM2000_Panel = class(ExtCtrls.TPanel)
  protected
    procedure Paint; override;

  end;

{$IFNDEF Delphi7OrHigher}
  TTabSheet = class(ComCtrls.TTabSheet)
  private
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure PaintWindow(DC: HDC); override;
  end;
{$ENDIF}

{  TPanel = class(ExtCtrls.TPanel)
  private
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure PaintWindow(DC: HDC); override;
  end;}

{$IFDEF Delphi3OrHigher}
  TSplitter = class(ExtCtrls.TSplitter)
  protected
    procedure Paint; override;
  end;
{$ENDIF}

{$IFNDEF Delphi7OrHigher}
  TGroupBox = class(StdCtrls.TGroupBox)
  private
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure PaintWindow(DC: HDC); override;
  end;

  TScrollBox = class(Forms.TScrollBox)
  private
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure PaintWindow(DC: HDC); override;
  end;

  TCheckBox = class(StdCtrls.TCheckBox)
  private
    FBuffer: TBitmap;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWmPaint); message WM_Paint;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TRadioButton = class(StdCtrls.TRadioButton)
  private
    FBuffer: TBitmap;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWmPaint); message WM_PAINT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TSpeedButton = class(Buttons.TSpeedButton)
  private
//    FBuffer: TBitmap;
    procedure WMEraseBkgnd(var Msg: TWmEraseBkgnd); message WM_ERASEBKGND;

  protected
    procedure Paint; override;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;


//  public
//    constructor Create(AOwner: TComponent); override;
//    destructor Destroy; override;
  end;
{$ENDIF}

  THEMESIZE = (
    TS_MIN,             // minimum size
    TS_TRUE,            // size without stretching
    TS_DRAW);           // size that theme mgr will use to draw part

  TThemeSize = THEMESIZE;

const
  hThemeLibrary: HModule = 0;
  hTabTheme: THandle = 0;
  hButtonTheme: THandle = 0;
  hComboTheme: THandle = 0;
  hEditTheme: THandle = 0;
  hToolbarTheme: THandle = 0;
  themelib = 'uxtheme.dll';

  TABP_PANE          = 9;
  TABP_BODY          = 10;
  BP_CHECKBOX        = 3;
  BP_GROUPBOX        = 4;
  BP_PUSHBUTTON      = 1;
  BP_RADIOBUTTON     = 2;
  PBS_NORMAL         = 1;
  PBS_HOT            = 2;
  PBS_PRESSED        = 3;
  PBS_DISABLED       = 4;
  PBS_DEFAULTED      = 5;

  CBS_UNCHECKEDNORMAL    = 1;
  CBS_UNCHECKEDHOT       = 2;
  CBS_UNCHECKEDPRESSED   = 3;
  CBS_UNCHECKEDDISABLED  = 4;
  CBS_CHECKEDNORMAL      = 5;
  CBS_CHECKEDHOT         = 6;
  CBS_CHECKEDPRESSED     = 7;
  CBS_CHECKEDDISABLED    = 8;

  RBS_UNCHECKEDNORMAL    = 1;
  RBS_UNCHECKEDHOT       = 2;
  RBS_UNCHECKEDPRESSED   = 3;
  RBS_UNCHECKEDDISABLED  = 4;
  RBS_CHECKEDNORMAL      = 5;
  RBS_CHECKEDHOT         = 6;
  RBS_CHECKEDPRESSED     = 7;
  RBS_CHECKEDDISABLED    = 8;

  GBS_NORMAL             = 1;

  CP_DROPDOWNBUTTON      = 1;

  CBXS_NORMAL            = 1;
  CBXS_HOT               = 2;
  CBXS_PRESSED           = 3;
  CBXS_DISABLED          = 4;

  EP_EDITTEXT      = 1;
  EP_CARET         = 2;

  ETS_NORMAL            = 1;
  ETS_HOT               = 2;
  ETS_SELECTED          = 3;
  ETS_DISABLED          = 4;
  ETS_FOCUSED           = 5;
  ETS_READONLY          = 6;
  ETS_ASSIST            = 7;

  TP_BUTTON               = 1;
  TP_DROPDOWNBUTTON       = 2;
  TP_SPLITBUTTON          = 3;

  TS_NORMAL            = 1;
  TS_HOT               = 2;
  TS_PRESSED           = 3;
  TS_DISABLED          = 4;
  TS_CHECKED           = 5;
  TS_HOTCHECKED        = 6;


function IsThemeEnabled: Boolean;

function DrawThemeBackground(hTheme: THandle; hdc: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; pClipRect: PRect): HRESULT;

function OpenThemeData(hwnd: HWND; pszClassList: LPCWSTR): THandle;

function CloseThemeData(hTheme: THandle): HRESULT;

function DrawThemeText(hTheme: THandle; hdc: HDC; iPartId, iStateId: Integer;
  pszText: String; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
  const pRect: TRect): HRESULT;

function GetThemePartSize(hTheme: THandle; hdc: HDC; iPartId, iStateId: Integer;
  prc: PRect; eSize: TThemeSize; psz: PSize): HRESULT;


implementation

uses
  Registry, CommCtrl,
  am2000utils, am2000menubar, am2000cache;

const
  pDrawThemeBackground: function (hTheme: THandle; hdc: HDC; iPartId, iStateId: Integer;
    const pRect: TRect; pClipRect: PRect): HRESULT stdcall = nil;
  pOpenThemeData: function (hwnd: HWND; pszClassList: LPCWSTR): THandle stdcall = nil;
  pCloseThemeData: function (hTheme: THandle): HRESULT stdcall = nil;
  pDrawThemeParentBackground: function (hwnd: HWND; hdc: HDC; prc: PRECT): HRESULT stdcall = nil;
  pDrawThemeText: function (hTheme: THandle; hdc: HDC; iPartId, iStateId: Integer;
    pszText: LPCWSTR; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
    const pRect: TRect): HRESULT stdcall = nil;
  pGetThemePartSize: function (hTheme: THandle; hdc: HDC; iPartId, iStateId: Integer;
    prc: PRect; eSize: TThemeSize; psz: PSize): HRESULT stdcall = nil;

function IsThemeEnabled: Boolean;
var
  ThemeActive, DisableThemes: Boolean;
  Registry: TRegistry;
begin
  Registry:= TRegistry.Create;
  try
    if Registry.OpenKey('\Software\Microsoft\Windows\CurrentVersion\ThemeManager', False)
    then
      ThemeActive:= (Registry.ReadString('ThemeActive') = '1')
    else
      ThemeActive:= False;

    if (Registry.OpenKey('\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers', False))
    then
      DisableThemes:= (Pos('DISABLETHEMES', Registry.ReadString(Application.ExeName)) > 0)
    else
      DisableThemes:= False;

  finally
    Registry.CloseKey;
    Registry.Free;
  end;

  Result:= ThemeActive and not DisableThemes;
end;

function DrawThemeBackground(hTheme: THandle; hdc: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; pClipRect: PRect): HRESULT;
begin
  Result:= ERROR_INVALID_HANDLE;

  if hThemeLibrary = 0
  then Exit;

  if not Assigned(pDrawThemeBackground)
  then pDrawThemeBackground:= GetProcAddress(hThemeLibrary, 'DrawThemeBackground');

  if Assigned(pDrawThemeBackground)
  then Result:= pDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect)
  else Result:= ERROR_INVALID_MODULETYPE;
end;

function OpenThemeData(hwnd: HWND; pszClassList: LPCWSTR): THandle;
begin
  Result:= ERROR_INVALID_HANDLE;

  if hThemeLibrary = 0
  then Exit;

  if not Assigned(pOpenThemeData)
  then pOpenThemeData:= GetProcAddress(hThemeLibrary, 'OpenThemeData');

  if Assigned(pOpenThemeData)
  then Result:= pOpenThemeData(hwnd, pszClassList)
  else Result:= ERROR_INVALID_MODULETYPE;
end;

function CloseThemeData(hTheme: THandle): HRESULT;
begin
  Result:= ERROR_INVALID_HANDLE;

  if hThemeLibrary = 0
  then Exit;

  if not Assigned(pCloseThemeData)
  then pCloseThemeData:= GetProcAddress(hThemeLibrary, 'CloseThemeData');

  if Assigned(pCloseThemeData)
  then Result:= pCloseThemeData(hTheme)
  else Result:= ERROR_INVALID_MODULETYPE;
end;

function DrawThemeText(hTheme: THandle; hdc: HDC; iPartId, iStateId: Integer;
  pszText: String; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
  const pRect: TRect): HRESULT;
var
  W: PWideChar;
begin
  Result:= ERROR_INVALID_HANDLE;

  if hThemeLibrary = 0
  then Exit;

  if not Assigned(pDrawThemeText)
  then pDrawThemeText:= GetProcAddress(hThemeLibrary, 'DrawThemeText');

  if Assigned(pDrawThemeText)
  then begin
    GetMem(W, iCharCount *2 +2);
    MultiByteToWideChar(0, 0, PChar(pszText), iCharCount, W, iCharCount);
    Result:= pDrawThemeText(hTheme, hdc, iPartId, iStateId, W,
      iCharCount, dwTextFlags, dwTextFlags2, pRect);
    FreeMem(W);
  end
  else
    Result:= ERROR_INVALID_MODULETYPE;
end;

function GetThemePartSize(hTheme: THandle; hdc: HDC; iPartId, iStateId: Integer;
  prc: PRect; eSize: TThemeSize; psz: PSize): HRESULT;
begin
  Result:= ERROR_INVALID_HANDLE;

  if hThemeLibrary = 0
  then Exit;

  if not Assigned(pGetThemePartSize)
  then pGetThemePartSize:= GetProcAddress(hThemeLibrary, 'GetThemePartSize');

  if Assigned(pGetThemePartSize)
  then Result:= pGetThemePartSize(hTheme, hdc, iPartId, iStateId, prc, eSize, psz)
  else Result:= ERROR_INVALID_MODULETYPE;
end;


{ T_AM2000_Panel }

procedure T_AM2000_Panel.Paint;
var
  R: TRect;
begin
  inherited;

  R:= GetClientRect;
  R.Left:= R.Right - GetSystemMetrics(sm_CxHScroll);
  R.Top:= R.Bottom - GetSystemMetrics(sm_CyVScroll);
  DrawFrameControl(Canvas.Handle, R, dfc_Scroll, dfcs_ScrollSizeGrip);
end;


{ TTabSheet }

{$IFNDEF Delphi7OrHigher}
procedure TTabSheet.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if hThemeLibrary <> 0
  then
    Message.Result:= 1
  else
    inherited;
end;

procedure TTabSheet.PaintWindow(DC: HDC);
begin
  if (hThemeLibrary <> 0)
  and (hTabTheme = 0)
  then begin
    hTabTheme:= OpenThemeData(Handle, 'TAB');
  end;

  if hTabTheme <> 0
  then
    DrawThemeBackground(hTabTheme, DC, TABP_BODY, 0, ClientRect, nil)
  else
    inherited;
end;
{$ENDIF}


{ TPanel

procedure TPanel.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if hTabTheme <> 0
  then
    Message.Result:= 1
  else
    inherited;
end;

procedure TPanel.PaintWindow(DC: HDC);
var
  R: TRect;
begin
  if hTabTheme <> 0
  then begin
    R:= Parent.ClientRect;
    OffsetRect(R, -Left, -Top);
    DrawThemeBackground(hTabTheme, DC, TABP_BODY, 0, R, nil);
  end
  else
    inherited;
end;


{ TGroupBox }

{$IFNDEF Delphi7OrHigher}
procedure TGroupBox.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if (hThemeLibrary <> 0)
  or not (Parent is TTabSheet)
  then
    Message.Result:= 1
  else
    inherited;
end;

procedure TGroupBox.PaintWindow(DC: HDC);
var
  R, R1: TRect;
  H: Integer;
  oldh: HGdiObj;
begin
  if (hThemeLibrary <> 0)
  and (hButtonTheme = 0)
  then begin
    hButtonTheme:= OpenThemeData(Handle, 'BUTTON');
  end;

  if hButtonTheme <> 0
  then begin
    R:= ClientRect;
    if Parent is  TTabSheet
    then begin
      R1:= Parent.ClientRect;
      OffsetRect(R1, -Left, -Top);
      DrawThemeBackground(hTabTheme, DC, TABP_BODY, 0, R1, nil);
    end
    else begin
      Canvas.Brush.Color:= Color;
      Canvas.FillRect(R);
    end;

    H:= Canvas.TextHeight('0');

    Inc(R.Top, H div 2 +1);
    DrawThemeBackground(hButtonTheme, DC, BP_GROUPBOX,
      GBS_NORMAL, R, nil);

    oldh:= SelectObject(DC, Font.Handle);

    R:= Rect(8, 0, Canvas.TextWidth(Caption) +8, H);

    if Parent is TTabSheet
    then DrawThemeBackground(hTabTheme, DC, TABP_BODY, 0, R1, @R)
    else Canvas.FillRect(R);

    DrawThemeText(hButtonTheme, DC, BP_GROUPBOX,
      GBS_NORMAL, Caption, Length(Caption),
      dt_SingleLine or dt_VCenter, 0, R);
    SelectObject(DC, oldh);

  end
  else
    inherited;
end;


{ TScrollBox }

procedure TScrollBox.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if hTabTheme <> 0
  then
    Message.Result:= 1
  else
    inherited;
end;

procedure TScrollBox.PaintWindow(DC: HDC);
var
  R: TRect;
begin
  if hTabTheme <> 0
  then begin
    R:= Parent.ClientRect;
    Dec(R.Top, Top + VertScrollBar.Position);
    DrawThemeBackground(hTabTheme, DC, TABP_BODY, 0, R, nil);
  end
  else
    inherited;
end;


{ TCheckBox }

constructor TCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FBuffer:= TBitmap.Create;
end;

destructor TCheckBox.Destroy;
begin
  FBuffer.Free;
  inherited;
end;

procedure TCheckBox.WMPaint(var Message: TWMPaint);
const
  CheckBoxStates: array [{Checked} Boolean, 1..4] of Integer =
    ((cbs_UncheckedNormal, cbs_UncheckedHot, cbs_UncheckedPressed, cbs_UncheckedDisabled),
     (cbs_CheckedNormal, cbs_CheckedHot, cbs_CheckedPressed, cbs_CheckedDisabled));
var
  DC: HDC;
  PS: TPaintStruct;
  State: Integer;
  P: TPoint;
  R: TRect;
  oldh: HGdiObj;
begin
  if (hThemeLibrary <> 0)
  and (hButtonTheme = 0)
  then begin
    hButtonTheme:= OpenThemeData(Handle, 'BUTTON');
  end;

  if hButtonTheme <> 0
  then begin
    DC:= Message.DC;
    if DC = 0
    then DC:= BeginPaint(Handle, PS);

    if not Enabled
    then State:= 4
    else begin
      GetCursorPos(P);

      if FindDragTarget(P, True) <> Self
      then State:= 1
      else
      if (GetKeyState(vk_LButton) < 0)
      then State:= 3
      else State:= 2;
    end;

    if (FBuffer.Width <> ClientWidth)
    or (FBuffer.Height <> ClientHeight)
    then begin
      FBuffer.Width:= ClientWidth;
      FBuffer.Height:= ClientHeight;
    end;


    if (Parent.Parent <> nil)
    then begin
      R:= Parent.Parent.ClientRect;
      OffsetRect(R, -Parent.Left, -Parent.Top);
    end
    else
      R:= Parent.ClientRect;

    OffsetRect(R, -Left, -Top);

    if Parent is TTabSheet
    then begin
      if Parent is TScrollingWinControl
      then Dec(R.Top, TScrollingWinControl(Parent).VertScrollBar.Position);

      DrawThemeBackground(hTabTheme, FBuffer.Canvas.Handle, TABP_BODY, 0, R, nil);
    end
    else begin
      FBuffer.Canvas.Brush.Color:= Color;
      FBuffer.Canvas.FillRect(ClientRect);
    end;

    R:= ClientRect;
    R.Right:= R.Left + (R.Bottom - R.Top);
    DrawThemeBackground(hButtonTheme, FBuffer.Canvas.Handle, BP_CHECKBOX,
      CheckBoxStates[Checked, State], R, nil);

    R.Left:= R.Right +2;
    R.Right:= ClientWidth;
    oldh:= SelectObject(FBuffer.Canvas.Handle, Font.Handle);
    DrawThemeText(hButtonTheme, FBuffer.Canvas.Handle, BP_CHECKBOX,
      CheckBoxStates[Checked, State], Caption, Length(Caption),
      dt_SingleLine or dt_VCenter, 0, R);

    if Focused
    then begin
      R.Right:= R.Left + FBuffer.Canvas.TextWidth(StripAmpersands(Caption)) -1;
      InflateRect(R, 2, -1);
      FBuffer.Canvas.DrawFocusRect(R);
    end;
    SelectObject(FBuffer.Canvas.Handle, oldh);

    BitBlt(DC, 0, 0, ClientWidth, ClientHeight, FBuffer.Canvas.Handle, 0, 0, SrcCopy);

    if Message.DC = 0
    then EndPaint(Handle, PS);
  end
  else
    inherited;
end;

procedure TCheckBox.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if (hTabTheme <> 0)
  or not (Parent is TTabSheet)
  then
    Message.Result:= 1
  else
    inherited;
end;



{ TRadioButton }

constructor TRadioButton.Create(AOwner: TComponent);
begin
  inherited;
  FBuffer:= TBitmap.Create;
end;

destructor TRadioButton.Destroy;
begin
  FBuffer.Free;
  inherited;
end;

procedure TRadioButton.WMPaint(var Message: TWMPaint);
const
  CheckBoxStates: array [{Checked} Boolean, 1..4] of Integer =
    ((rbs_UncheckedNormal, rbs_UncheckedHot, rbs_UncheckedPressed, rbs_UncheckedDisabled),
     (rbs_CheckedNormal, rbs_CheckedHot, rbs_CheckedPressed, rbs_CheckedDisabled));
var
  DC: HDC;
  PS: TPaintStruct;
  State: Integer;
  P: TPoint;
  R: TRect;
  oldh: HGdiObj;
begin
  if (hThemeLibrary <> 0)
  and (hButtonTheme = 0)
  then begin
    hButtonTheme:= OpenThemeData(Handle, 'BUTTON');
  end;

  if hButtonTheme <> 0
  then begin
    DC:= Message.DC;
    if DC = 0
    then DC:= BeginPaint(Handle, PS);

    if not Enabled
    then State:= 4
    else begin
      GetCursorPos(P);

      if FindDragTarget(P, True) <> Self
      then State:= 1
      else
      if (GetKeyState(vk_LButton) < 0)
      then State:= 3
      else State:= 2;
    end;

    if (FBuffer.Width <> ClientWidth)
    or (FBuffer.Height <> ClientHeight)
    then begin
      FBuffer.Width:= ClientWidth;
      FBuffer.Height:= ClientHeight;
    end;


    if (Parent.Parent <> nil)
    then begin
      R:= Parent.Parent.ClientRect;
      OffsetRect(R, -Parent.Left, -Parent.Top);
    end
    else
      R:= Parent.ClientRect;

    OffsetRect(R, -Left, -Top);


    DrawThemeBackground(hTabTheme, FBuffer.Canvas.Handle, TABP_BODY, 0, R, nil);

    R:= ClientRect;
    R.Right:= R.Left + (R.Bottom - R.Top);
    DrawThemeBackground(hButtonTheme, FBuffer.Canvas.Handle, bp_RadioButton,
      CheckBoxStates[Checked, State], R, nil);

    R.Left:= R.Right +2;
    R.Right:= ClientWidth;
    oldh:= SelectObject(FBuffer.Canvas.Handle, Font.Handle);
    DrawThemeText(hButtonTheme, FBuffer.Canvas.Handle, bp_RadioButton,
      CheckBoxStates[Checked, State], Caption, Length(Caption),
      dt_SingleLine or dt_VCenter, 0, R);

    if Focused
    then begin
      R.Right:= R.Left + FBuffer.Canvas.TextWidth(StripAmpersands(Caption)) -1;
      InflateRect(R, 2, -1);
      FBuffer.Canvas.DrawFocusRect(R);
    end;
    SelectObject(FBuffer.Canvas.Handle, oldh);

    BitBlt(DC, 0, 0, ClientWidth, ClientHeight, FBuffer.Canvas.Handle, 0, 0, SrcCopy);

    if Message.DC = 0
    then EndPaint(Handle, PS);
  end
  else
    inherited;
end;

procedure TRadioButton.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if hTabTheme <> 0
  then
    Message.Result:= 1
  else
    inherited;
end;

{$ENDIF}

{$IFDEF Delphi3OrHigher}
type
  TMyTabSheet = class(TTabSheet)
  end;

{ TSplitter }
procedure TSplitter.Paint;
begin
  if hThemeLibrary <> 0
  then
    TMyTabSheet(Parent).PaintWindow(Canvas.Handle)
  else
    inherited;
end;
{$ENDIF}


{$IFNDEF Delphi7OrHigher}
{ TSpeedButton }

procedure TSpeedButton.CMMouseenter(var Msg: TMessage);
begin
  inherited;
  Paint;
end;

procedure TSpeedButton.CMMouseleave(var Msg: TMessage);
begin
  inherited;
  Paint;
end;

procedure TSpeedButton.Paint;
var
  Result, State, NG, TextFlags: Integer;
  PaintRect, R: TRect;
{-$IFNDEF Delphi4OrHigher}
  P: TPoint;
{-$ENDIF}
  S: TSize;
  old: HFont;
  Theme: Cardinal;
begin
  if (hThemeLibrary <> 0)
  then begin
    if (hToolbarTheme = 0)
    then hToolbarTheme:= OpenThemeData(0, 'TOOLBAR');
    if (hButtonTheme = 0)
    then hButtonTheme:= OpenThemeData(0, 'BUTTON');
    if (hTabTheme = 0)
    then hTabTheme:= OpenThemeData(0, 'TAB');
  end;

  if hToolbarTheme <> 0
  then begin
    S.cx:= 0;
    FillChar(PaintRect, SizeOf(PaintRect), 0);
    GetTextExtentPoint32(Canvas.Handle, PChar(Caption), Length(Caption), S);
//    TextRect:= Rect(0, 0, S.cx, S.cy);

    NG:= 0;
    State:= TS_NORMAL;
    Theme:= hToolbarTheme;
    if not Enabled
    then begin
      NG:= 1;
      State:= TS_DISABLED;
      Theme:= hButtonTheme;
    end
    else
    if Down
    then begin
      if NumGlyphs > 2
      then NG:= 2;
      State:= TS_PRESSED;
    end
    else begin
      GetCursorPos(P);
      if FindDragTarget(P, True) = Self
      then
      if (GetKeyState(vk_LButton) < 0)
      then begin
        if NumGlyphs > 2
        then NG:= 2;
        State:= TS_PRESSED;
      end
      else begin
        if NumGlyphs > 3
        then NG:= 3;
        State:= TS_HOT;
      end;
    end;

    if State <> 1
    then
      DrawThemeBackground(Theme, Canvas.Handle, TP_BUTTON, State, ClientRect, nil)

    else begin
      if Parent is TTabControl
      then begin
        R:= TTabControl(Parent).DisplayRect;
        OffsetRect(R, -Left, -Top);
        DrawThemeBackground(hTabTheme, Canvas.Handle, TABP_BODY, 0, R, nil);
      end
      else begin
        R:= Parent.ClientRect;
        Canvas.Brush.Color:= Color;
        Canvas.FillRect(R);
      end;
    end;

    TextFlags:= dt_VCenter or dt_SingleLine or dt_Center;
    R:= ClientRect;
    if State = ts_Pressed
    then OffsetRect(R, 1, 1);

    if not Glyph.Empty
    then begin
      PaintRect:= Rect(0, 0, Glyph.Width div NumGlyphs, Glyph.Height);

      if S.cx > 0 then Inc(S.cx, 3);
      OffsetRect(PaintRect, (Width - PaintRect.Right - S.cx) div 2,
        (Height - PaintRect.Bottom) div 2 +1);

      if State = ts_Pressed
      then OffsetRect(PaintRect, 1, 1);
      R.Left:= PaintRect.Right +3;
      TextFlags:= TextFlags and not dt_Center;

      if (Enabled)
      or (NG <= NumGlyphs -1)
      then
        TransBlt(Canvas, PaintRect.Left, PaintRect.Top, NG, NumGlyphs, Glyph.Handle,
          clNone, clNone, 0)
      else
        NewDisabledBlt(Canvas, PaintRect.Left, PaintRect.Top, NG, NumGlyphs, Glyph.Handle,
          clBtnHighlight, clBtnShadow, clNone);
    end;

    old:= 0;
    if Canvas.Font.Name <> Font.Name
    then begin
      old:= SelectObject(Canvas.Handle, Font.Handle);
    end;

    DrawThemeText(Theme, Canvas.Handle, TP_BUTTON, State, PChar(Caption), Length(Caption),
      TextFlags, 0, R);

    if old <> 0
    then SelectObject(Canvas.Handle, old);

  end
  else
    inherited;
end;

procedure TSpeedButton.WMEraseBkgnd(var Msg: TWmEraseBkgnd);
begin
  Msg.Result:= 1;
end;
{$ENDIF}


initialization
  if IsThemeEnabled
  then hThemeLibrary:= LoadLibrary(themelib);

finalization
  if hTabTheme <> 0
  then CloseThemeData(hTabTheme);

  if hButtonTheme <> 0
  then CloseThemeData(hButtonTheme);

  if hComboTheme <> 0
  then CloseThemeData(hComboTheme);

  if hEditTheme <> 0
  then CloseThemeData(hEditTheme);

  if hToolbarTheme <> 0
  then CloseThemeData(hToolbarTheme);

  if hThemeLibrary <> 0
  then FreeLibrary(hThemeLibrary);

end.

