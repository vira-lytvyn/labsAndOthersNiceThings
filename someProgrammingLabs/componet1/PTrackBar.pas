{*******************************************************************************

    Version: 1.0
    TPTrackBar - delphi component similar to standard TTrackBar, but more
      functional and simply for use.
    Copyright (C) 2005-2006 Pelesh Yaroslav Vladimirovich
    mailto:yaroslav@pelesh.in.ua
    http://pelesh.in.ua

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

*******************************************************************************}

unit PTrackBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TPTrackBarOrientation = (toVertical, toHorizontal);

  TPTrackBar = class(TCustomControl)
  private
    { Private declarations }
    FOrientation: TPTrackBarOrientation;
    FShadowColor: TColor;
    FHighlightColor: TColor;
    FTrackColor: TColor;
    FSelectionColor: TColor;
    FPosition: integer;
    FMin: integer;
    FMax: integer;
    FThickness: integer;
    FPadding: integer;
    FDragging: boolean;
    FSliderVisible: boolean;
    FClickFocus: boolean;
    FPageSize: integer;
    FLineSize: integer;
    FChanging: boolean;
    FOnChange: TNotifyEvent;
    FOnBeginChange: TNotifyEvent;
    FOnEndChange: TNotifyEvent;
    FPosHighlight: boolean;
    FPosHighlightColor: TColor;
    FSelStart: integer;
    FSelEnd: integer;
    FFocusPadding: integer;
    FWheelAccumulator: integer;
    procedure BeginChange;
    procedure EndChange;
    function ValByOrientation(ValHorisontal, ValVertical: integer): integer;
    procedure Draw3DRect(TopLeftColor, BottomRightColor: TColor; Rect: TRect);
    procedure GoToPosition(X, Y: integer);
    function GetSliderRect: TRect;
    function GetTrackLineRect: TRect;
    function GetPosHighlightRect: TRect;
    function GetSelectionRect: TRect;
    function GetPosCoordinate(Pos: integer): integer;
    function GetPosStep: double;
    procedure SetHighlightColor(const Value: TColor);
    procedure SetSelectionColor(const Value: TColor);
    procedure SetShadowColor(const Value: TColor);
    procedure SetTrackColor(const Value: TColor);
    procedure SetMin(Value: integer);
    procedure SetMax(Value: integer);
    procedure SetPosition(Value: integer);
    procedure SetThickness(Value: integer);
    procedure SetPadding(const Value: integer);
    procedure SetOrientation(const Value: TPTrackBarOrientation);
    procedure SetSliderVisible(const Value: boolean);
    procedure SetPosHighlight(const Value: boolean);
    procedure SetPosHighlightColor(const Value: TColor);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNKeyUp(var Message: TWMKeyUp); message CN_KEYUP;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure SetSelEnd(const Value: integer);
    procedure SetSelStart(const Value: integer);
    procedure SetFocusPadding(const Value: integer);
  protected
    { Protected declarations }
    procedure Paint; override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    { Public declarations }
    property Changing: boolean read FChanging;
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property Align;
    property Anchors;
    property Constraints;
    property Enabled;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property DragCursor;
    property DragKind;
    property DragMode;
    property ParentColor;
    property Color;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property PageSize: integer read FPageSize write FPageSize;
    property LineSize: integer read FLineSize write FLineSize;
    property ClickFocus: boolean read FClickFocus write FClickFocus;
    property SliderVisible: boolean read FSliderVisible write SetSliderVisible;
    property ShadowColor: TColor read FShadowColor write SetShadowColor;
    property HighlightColor: TColor read FHighlightColor write SetHighlightColor;
    property TrackColor: TColor read FTrackColor write SetTrackColor;
    property SelectionColor: TColor read FSelectionColor write SetSelectionColor;
    property PosHighlight: boolean read FPosHighlight write SetPosHighlight;
    property PosHighlightColor: TColor read FPosHighlightColor write SetPosHighlightColor;
    property Min: integer read FMin write SetMin;
    property Max: integer read FMax write SetMax;
    property Position: integer read FPosition write SetPosition;
    property Thickness: integer read FThickness write SetThickness;
    property Padding: integer read FPadding write SetPadding;
    property FocusPadding: integer read FFocusPadding write SetFocusPadding;
    property SelEnd: integer read FSelEnd write SetSelEnd;
    property SelStart: integer read FSelStart write SetSelStart;
    property Orientation: TPTrackBarOrientation read FOrientation write SetOrientation;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnBeginChange: TNotifyEvent read FOnBeginChange write FOnBeginChange;
    property OnEndChange: TNotifyEvent read FOnEndChange write FOnEndChange;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Pelesh', [TPTrackBar]);
end;

function MaxVal(a, b: integer): integer;
begin
  if a > b then Result := a else Result := b;
end;

function MinVal(a, b: integer): integer;
begin
  if a < b then Result := a else Result := b;
end;

constructor TPTrackBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csOpaque];
  Width := 150;
  Height := 30;
  FDragging := false;
  FChanging := false;
  FLineSize := 1;
  FPageSize := 2;
  FMin := 0;
  FMax := 10;
  FSelStart := 0;
  FSelEnd := 0;
  FPosition := 0;
  FThickness := 6;
  FPadding := 10;
  FFocusPadding := 0;
  FOrientation := toHorizontal;
  FClickFocus := false;
  FSliderVisible := true;
  FPosHighlight := true;
  FShadowColor := clBtnShadow;
  FHighLightColor := clBtnHighlight;
  FTrackColor := clWindow;
  FSelectionColor := clHighlight;
  FPosHighlightColor := clBtnText;
end;

function TPTrackBar.GetPosStep: double;
begin
  Result := (ValByOrientation(Width, Height) - FPadding * 2) / MaxVal(1, (Max - Min));
end;

function TPTrackBar.GetPosCoordinate(Pos: integer): integer;
begin
  Result := FPadding + Trunc(GetPosStep * (Pos - Min));
end;

function TPTrackBar.GetSliderRect: TRect;
var
  SliderWidth, SliderHeight: integer;
begin
  SliderHeight := FThickness * 3;
  SliderWidth := SliderHeight div 2;

  Result.Top := ValByOrientation((Height - SliderHeight) div 2,
    Height - GetPosCoordinate(FPosition) - SliderWidth div 2);
  Result.Left := ValByOrientation(GetPosCoordinate(FPosition) - SliderWidth div 2,
    (Width - SliderHeight) div 2);

  Result.Right := Result.Left + ValByOrientation(SliderWidth, SliderHeight);
  Result.Bottom := Result.Top + ValByOrientation(SliderHeight, SliderWidth);
end;

procedure TPTrackBar.GoToPosition(X, Y: integer);
var
  p: integer;
begin
  p := ValByOrientation(FMin + Round((X - FPadding) / GetPosStep),
    FMax - Round((Y - FPadding) / GetPosStep));
  Position := MaxVal(FMin, MinVal(Max, p));
end;

procedure TPTrackBar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    BeginChange;
    if FClickFocus then
      SetFocus;
    FDragging := true;
    GoToPosition(X, Y);
  end;
  inherited;
end;

procedure TPTrackBar.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FDragging then
    GoToPosition(X, Y);
  inherited;
end;

procedure TPTrackBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  FDragging := false;
  EndChange;
  inherited;
end;

procedure TPTrackBar.SetMax(Value: integer);
begin
  if Value <> FMax then
  begin
    FMax := MaxVal(FMin, Value);
    FPosition := MinVal(FPosition, FMax);
    FSelEnd := MinVal(FSelEnd, FMax);
    FSelStart := MinVal(FSelStart, FMax);
    Invalidate;
  end;
end;

procedure TPTrackBar.SetMin(Value: integer);
begin
  if Value <> FMin then
  begin
    FMin := MinVal(FMax, Value);
    FPosition := MaxVal(FPosition, FMin);
    FSelStart := MaxVal(FSelStart, FMin);
    FSelEnd := MaxVal(FSelEnd, FMin);
    Invalidate;
  end;
end;

procedure TPTrackBar.Paint;
var
  r: TRect;
begin
    // Slider
    if FSliderVisible then
    begin
      r := GetSliderRect;
      Canvas.Brush.Color := Color;
      Canvas.FillRect(r);
      Draw3DRect(FHighlightColor, FShadowColor, r);
      ExcludeClipRect(Canvas.Handle, r.Left, r.Top, r.Right, r.Bottom);
    end;

    // Track line
    r := GetTrackLineRect;
    if Enabled then
      Canvas.Brush.Color := FTrackColor
    else
      Canvas.Brush.Color := Color;
    Canvas.FillRect(r);

    // Position highlight
    if FPosHighlight then
    begin
      Canvas.Brush.Color := FPosHighlightColor;
      Canvas.FillRect(GetPosHighlightRect);
    end;

    // Selection
    Canvas.Brush.Color := FSelectionColor;
    Canvas.FillRect(GetSelectionRect);


    Draw3DRect(FShadowColor, FHighlightColor, r);
    ExcludeClipRect(Canvas.Handle, r.Left, r.Top, r.Right, r.Bottom);

    // Background
    r := GetClientRect;
    Canvas.Brush.Color := Color;
    Canvas.FillRect(r);

    // Focus
    InflateRect(r, -FFocusPadding, -FFocusPadding);
    if Focused then
      DrawFocusRect(Canvas.Handle, r);
end;

procedure TPTrackBar.SetPosition(Value: integer);
var
  Rect1, Rect2: TRect;
begin
  if Value <> FPosition then
  begin
    Rect1 := GetSliderRect;
    FPosition := MinVal(FMax, MaxVal(FMin, Value));
    Rect2 := GetSliderRect;

    if not EqualRect(Rect1, Rect2) then
    begin
      UnionRect(Rect1, Rect1, Rect2);
      InvalidateRect(Handle, @Rect1, false);
    end;

    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TPTrackBar.SetThickness(Value: integer);
begin
  if Value <> FThickness then
  begin
    FThickness := MaxVal(Value, 2);
    Invalidate;
  end;
end;

procedure TPTrackBar.SetHighlightColor(const Value: TColor);
begin
  if Value <> FHighlightColor then
  begin
    FHighlightColor := Value;
    Invalidate;
  end;
end;

procedure TPTrackBar.SetSelectionColor(const Value: TColor);
begin
  if Value <> FSelectionColor then
  begin
    FSelectionColor := Value;
    Invalidate;
  end;
end;

procedure TPTrackBar.SetShadowColor(const Value: TColor);
begin
  if Value <> FShadowColor then
  begin
    FShadowColor := Value;
    Invalidate;
  end;
end;

procedure TPTrackBar.SetTrackColor(const Value: TColor);
begin
  if Value <> FTrackColor then
  begin
    FTrackColor := Value;
    Invalidate;
  end;
end;

procedure TPTrackBar.Draw3DRect(TopLeftColor, BottomRightColor: TColor;
  Rect: TRect);
var
  r, b: integer;
begin
  r := Rect.Right - 1;
  b := Rect.Bottom - 1;

  Canvas.Pen.Color := TopLeftColor;
  Canvas.Polyline([Point(Rect.Left, b), Point(Rect.Left, Rect.Top),
    Point(r, Rect.Top)]);

  Canvas.Pen.Color := BottomRightColor;
  Canvas.Polyline([Point(r, Rect.Top), Point(r, b),
    Point(Rect.Left, b)]);
end;

function TPTrackBar.GetTrackLineRect: TRect;
begin
  if FOrientation = toHorizontal then
  begin
    Result.Left := FPadding;
    Result.Right := Width - FPadding;

    Result.Top := (Height - FThickness) div 2;
    Result.Bottom := Result.Top + FThickness;
  end
  else
  begin
    Result.Left := (Width - FThickness) div 2;
    Result.Right := Result.Left + FThickness;

    Result.Top := FPadding;
    Result.Bottom := Height - FPadding;
  end;
end;

function TPTrackBar.GetPosHighlightRect: TRect;
begin
  if FOrientation = toHorizontal then
  begin
    Result.Left := FPadding;
    Result.Right := GetPosCoordinate(FPosition);

    Result.Top := (Height - FThickness) div 2;
    Result.Bottom := Result.Top + FThickness;
  end
  else
  begin
    Result.Left := (Width - FThickness) div 2;
    Result.Right := Result.Left + FThickness;

    Result.Top := Height - GetPosCoordinate(FPosition);
    Result.Bottom := Height - FPadding;
  end;
end;

function TPTrackBar.GetSelectionRect: TRect;
begin
  if FOrientation = toHorizontal then
  begin
    Result.Left := GetPosCoordinate(FSelStart);
    Result.Right := GetPosCoordinate(FSelEnd);

    Result.Top := (Height - FThickness) div 2;
    Result.Bottom := Result.Top + FThickness;
  end
  else
  begin
    Result.Left := (Width - FThickness) div 2;
    Result.Right := Result.Left + FThickness;

    Result.Top := Height - GetPosCoordinate(FSelEnd);
    Result.Bottom := Height - GetPosCoordinate(FSelStart);
  end;
end;

procedure TPTrackBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TPTrackBar.SetPadding(const Value: integer);
begin
  if Value <> FPadding then
  begin
    FPadding := MaxVal(0, Value);
    Invalidate;
  end;
end;

procedure TPTrackBar.SetOrientation(const Value: TPTrackBarOrientation);
begin
  if Value <> FOrientation then
  begin
    FOrientation := Value;
    if ComponentState * [csLoading, csUpdating] = [] then
      SetBounds(Left, Top, Height, Width);
    Invalidate;
  end;
end;

function TPTrackBar.ValByOrientation(ValHorisontal,
  ValVertical: integer): integer;
begin
  if FOrientation = toHorizontal then
    Result := ValHorisontal
  else
    Result := ValVertical;
end;

procedure TPTrackBar.SetSliderVisible(const Value: boolean);
begin
  if Value <> FSliderVisible then
  begin
    FSliderVisible := Value;
    Invalidate;
  end;
end;

procedure TPTrackBar.CMFocusChanged(var Message: TCMFocusChanged);
begin
  inherited;
  Invalidate;
end;

procedure TPTrackBar.CNKeyDown(var Message: TWMKeyDown);
begin
  case Message.CharCode of
    VK_UP:
    begin
      BeginChange;
      Position := FPosition + ValByOrientation(-FLineSize, FLineSize);
    end;
    VK_DOWN:
    begin
      BeginChange;
      Position := FPosition + ValByOrientation(FLineSize, -FLineSize);
    end;
    VK_LEFT:
    begin
      BeginChange;
      Position := FPosition - FLineSize;
    end;
    VK_RIGHT:
    begin
      BeginChange;
      Position := FPosition + FLineSize;
    end;
    VK_PRIOR:
    begin
      BeginChange;
      Position := FPosition + ValByOrientation(-FPageSize, FPageSize);
    end;
    VK_NEXT:
    begin
      BeginChange;
      Position := FPosition + ValByOrientation(FPageSize, -FPageSize);
    end;
    VK_HOME:
    begin
      BeginChange;
      Position := ValByOrientation(FMin, FMax);
    end;
    VK_END:
    begin
      BeginChange;
      Position := ValByOrientation(FMax, FMin);
    end;
  else
    inherited;
  end;
end;

procedure TPTrackBar.CNKeyUp(var Message: TWMKeyDown);
begin
  EndChange;
  inherited;
end;

procedure TPTrackBar.BeginChange;
begin
  if not FChanging then
  begin
    FChanging := true;
    if Assigned(FOnBeginChange) then
      FOnBeginChange(Self);
  end;
end;

procedure TPTrackBar.EndChange;
begin
  if FChanging then
  begin
    FChanging := false;
    if Assigned(FOnEndChange) then
      FOnEndChange(Self);
  end;
end;

procedure TPTrackBar.SetPosHighlight(const Value: boolean);
begin
  if Value <> FPosHighlight then
  begin
    FPosHighlight := Value;
    Invalidate;
  end;
end;

procedure TPTrackBar.SetPosHighlightColor(const Value: TColor);
begin
  if Value <> FPosHighlightColor then
  begin
    FPosHighlightColor := Value;
    Invalidate;
  end;
end;

procedure TPTrackBar.SetSelEnd(const Value: integer);
begin
  if Value <> FSelEnd then
  begin
    FSelEnd := MaxVal(MinVal(Value, FMax), FMin);
    FSelStart := MinVal(FSelStart, FSelEnd);
    Invalidate;
  end;
end;

procedure TPTrackBar.SetSelStart(const Value: integer);
begin
  if Value <> FSelStart then
  begin
    FSelStart := MinVal(MaxVal(Value, FMin), FMax);
    FSelEnd := MaxVal(FSelEnd, FSelStart);
    Invalidate;
  end;
end;

procedure TPTrackBar.SetFocusPadding(const Value: integer);
begin
  if Value <> FFocusPadding then
  begin
    FFocusPadding := MaxVal(0, Value);
    Invalidate;
  end;
end;

// $#@&*! VCL Delphi 5 code do OnWheelDown/Up two times
procedure TPTrackBar.WMMouseWheel(var Message: TWMMouseWheel);
var
  IsNeg: boolean;
begin
  with Message do
  begin
    Inc(FWheelAccumulator, WheelDelta);
    IsNeg := FWheelAccumulator < 0; // And this $#@&*! statement must be here!
    while Abs(FWheelAccumulator) >= WHEEL_DELTA do
    begin
      FWheelAccumulator := Abs(FWheelAccumulator) - WHEEL_DELTA;
      if IsNeg then
        Position := FPosition + ValByOrientation(FLineSize, -FLineSize)
      else
        Position := FPosition + ValByOrientation(-FLineSize, FLineSize);
    end;
  end;
  inherited;
end;

end.
