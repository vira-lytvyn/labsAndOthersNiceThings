
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TColorBox2000 Component                         }
{                                                       }
{       Copyright © 1997-2002 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/
//

unit ColorBox2000;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Graphics,
  ColorMenu2000, am2000options, am2000theme;

type
  TColorBox2000State = (csNormal, csMouseOver, csDroppedDown);

  TColorBox2000 = class(TCustomControl)
  private
    FColorMenu: TColorMenu2000;
    FFlat: Boolean;
    State: TColorBox2000State;
    EditRect, ButtonRect: TRect;
    FOnChange: T_AM2000_ColorSelectionEvent;
    FCurrentColorTitle: String;
    IgnoreMouseDown: Boolean;
    FBuffer: TBitmap;

    function GetAutomaticColor: TColor;
    function GetColorBoxHeight: Integer;
    function GetColorBoxWidth: Integer;
    function GetColorMenuOptions: T_AM2000_ColorMenuOptions;
    function GetCustomColors: TStrings;
    function GetMoreColorsColor: TColor;
    function GetAnimatedSkin: T_AM2000_AnimatedSkin;
    function GetCurrentColor: TColor;

    function IsCustomColorsStored: Boolean;
    procedure SetAutomaticColor(const Value: TColor);
    procedure SetColorBoxHeight(const Value: Integer);
    procedure SetColorBoxWidth(const Value: Integer);
    procedure SetColorMenuOptions(const Value: T_AM2000_ColorMenuOptions);
    procedure SetCustomColors(const Value: TStrings);
    procedure SetMoreColorsColor(const Value: TColor);
    procedure SetFlat(const Value: Boolean);
    procedure SetCurrentColor(const Value: TColor);

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure wmEraseBkgnd(var Msg: TWMEraseBkgnd); message wm_EraseBkgnd;
    procedure SetAnimatedSkin(const Value: T_AM2000_AnimatedSkin);
    procedure ColorClick(Sender: TObject; Color: TColor);

  protected
    procedure Paint; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoEnter; override;
    procedure DoExit; override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    destructor Destroy; override;

  published
    property AutomaticColor: TColor
      read GetAutomaticColor write SetAutomaticColor default clBlack;
    property MoreColorsColor: TColor
      read GetMoreColorsColor write SetMoreColorsColor default clWhite;
    property CustomColors: TStrings
      read GetCustomColors write SetCustomColors stored IsCustomColorsStored;
    property ColorMenuOptions: T_AM2000_ColorMenuOptions
      read GetColorMenuOptions write SetColorMenuOptions;
    property ColorBoxWidth: Integer
      read GetColorBoxWidth write SetColorBoxWidth default 18;
    property ColorBoxHeight: Integer
      read GetColorBoxHeight write SetColorBoxHeight default 18;
    property Flat: Boolean
      read FFlat write SetFlat default True;
    property CurrentColor: TColor
      read GetCurrentColor write SetCurrentColor default clAutomatic;
    property AnimatedSkin: T_AM2000_AnimatedSkin
      read GetAnimatedSkin write SetAnimatedSkin;

    property Color default clWindow;
    property ParentColor default False;
    property Font;
    property ParentFont;
    property Width default 155;
    property Height default 22;
    property TabStop default True;
    property TabOrder;
    property Visible;
{$IFDEF Delphi4OrHigher}
    property Anchors;
{$ENDIF}

    property OnChange: T_AM2000_ColorSelectionEvent
      read FOnChange write FOnChange;
    
  end;

procedure Register;


implementation

uses ExtCtrls, am2000utils;

procedure Register;
begin
  RegisterComponents('Animated Menus', [TColorBox2000]);
end;


{ TColorBox2000 }

constructor TColorBox2000.Create(AOwner: TComponent);
begin
  inherited;

  SetBounds(Left, Top, 155, 22);
  ControlStyle:= [csClickEvents, csOpaque];
  ParentColor:= False;
  Color:= clWindow;
  TabStop:= True;
  FFlat:= True;
  FCurrentColorTitle:= 'Automatic';

  FColorMenu:= TColorMenu2000.Create(nil);
  FColorMenu.Options.Animation:= anSlide;
  FColorMenu.ShowHint:= True;
  FColorMenu.OnClick:= ColorClick;

  FBuffer:= TBitmap.Create;
end;

destructor TColorBox2000.Destroy;
begin
  FBuffer.Free;
  FColorMenu.Free;
  inherited;
end;

function TColorBox2000.GetAutomaticColor: TColor;
begin
  Result:= FColorMenu.AutomaticColor;
end;

function TColorBox2000.GetColorBoxHeight: Integer;
begin
  Result:= FColorMenu.Height;
end;

function TColorBox2000.GetColorBoxWidth: Integer;
begin
  Result:= FColorMenu.Width;
end;

function TColorBox2000.GetColorMenuOptions: T_AM2000_ColorMenuOptions;
begin
  Result:= FColorMenu.ColorMenuOptions;
end;

function TColorBox2000.GetCustomColors: TStrings;
begin
  Result:= FColorMenu.CustomColors;
end;

function TColorBox2000.GetMoreColorsColor: TColor;
begin
  Result:= FColorMenu.MoreColorsColor;
end;

function TColorBox2000.GetCurrentColor: TColor;
begin
  Result:= FColorMenu.CurrentColor;
end;

function TColorBox2000.IsCustomColorsStored: Boolean;
begin
  Result:= FColorMenu.IsCustomColorsStored;
end;

procedure TColorBox2000.SetAutomaticColor(const Value: TColor);
begin
  FColorMenu.AutomaticColor:= Value;
end;

procedure TColorBox2000.SetColorBoxHeight(const Value: Integer);
begin
  FColorMenu.Height:= Value;
end;

procedure TColorBox2000.SetColorBoxWidth(const Value: Integer);
begin
  FColorMenu.Width:= Value;
end;

procedure TColorBox2000.SetColorMenuOptions(
  const Value: T_AM2000_ColorMenuOptions);
begin
  FColorMenu.ColorMenuOptions:= Value;
end;

procedure TColorBox2000.SetCustomColors(const Value: TStrings);
begin
  FColorMenu.CustomColors:= Value;
end;

procedure TColorBox2000.SetMoreColorsColor(const Value: TColor);
begin
  FColorMenu.MoreColorsColor:= Value;
end;

procedure TColorBox2000.SetCurrentColor(const Value: TColor);
begin
  FColorMenu.CurrentColor:= Value;
end;

procedure TColorBox2000.Paint;
const
  ComboBoxStates: array [TColorBox2000State] of Integer = (CBXS_NORMAL, CBXS_HOT, CBXS_PRESSED);
  EditBoxStates: array [Boolean] of Integer = (ETS_NORMAL, ETS_FOCUSED);

var
  R: TRect;
begin
  if (hThemeLibrary <> 0)
  and (hComboTheme = 0)
  then begin
    hComboTheme:= OpenThemeData(Handle, 'COMBOBOX');
    hEditTheme:= OpenThemeData(Handle, 'EDIT');
  end;


  with FBuffer, Canvas
  do begin
    R:= ClientRect;

    if (hEditTheme <> 0)
    then begin
      DrawThemeBackground(hEditTheme, Handle, EP_EDITTEXT, EditBoxStates[Focused], R, nil)

    end

    else begin
      Brush.Color:= clBtnFace;

      // outer rectangle
      if Flat
      then
        if State = csNormal
        then begin
          FrameRect(R);
          InflateRect(R, -1, -1);
        end
        else
          Frame3D(Canvas, R, clBtnShadow, clBtnHighlight, 1)

      else;

      FrameRect(R);
    end;


    // draw the button
    R:= ButtonRect;

    if (hComboTheme <> 0)
    then begin
      InflateRect(R, 1, 1);
      DrawThemeBackground(hComboTheme, Handle, CP_DROPDOWNBUTTON, ComboBoxStates[State], R, nil)
    end

    else begin
      FillRect(R);

      if Flat
      then
        if State = csNormal
        then begin
          Brush.Color:= clBtnHighlight;
          FrameRect(R);
          Inc(R.Left);
          FrameRect(R);
        end
        else begin
          FrameRect(R);
          Inc(R.Left);

          if State = csMouseOver
          then Frame3D(Canvas, R, clBtnHighlight, clBtnShadow, 1)
          else begin
            Frame3D(Canvas, R, clBtnShadow, clBtnHighlight, 1);
            OffsetRect(R, 1, 1);
          end;
        end

      else;

      // draw the arrow
      if Pen.Color <> clBlack
      then Pen.Color:= clBlack;

      R.Top:= (R.Top + R.Bottom - 3) div 2;
      R.Left:= (R.Left + R.Right - 5) div 2;

      Brush.Color:= clBlack;
      PolyGon([Point(R.Left, R.Top), Point(R.Left +4, R.Top), Point(R.Left +2, R.Top +2)]);
    end;



    // draw the edit area
    // selected/not selected
    Brush.Color:= Color;
    FillRect(EditRect);

    // draw title
    Font.Assign(Self.Font);

    if Focused
    then begin
      Brush.Color:= clHighlight;
      R:= EditRect;
      InflateRect(R, -1, -1);
      FillRect(R);
      Font.Color:= clHighlightText;
    end;

    R:= EditRect;
    Inc(R.Left, 1 + R.Bottom - R.Top);

    DrawText(Handle, PChar(FCurrentColorTitle), Length(FCurrentColorTitle), R, dt_VCenter or dt_SingleLine);

    // draw color
    R:= Rect(EditRect.Left +3, EditRect.Top +3, 0, EditRect.Bottom -3);
    R.Right:= R.Left + R.Bottom - R.Top;
    Brush.Color:= clBlack;
    FrameRect(R);

    InflateRect(R, -1, -1);
    Brush.Color:= ColorToRGBEx(CurrentColor, FColorMenu);
    FillRect(R);

  end;

  BitBlt(Canvas.Handle, 0, 0, Width, Height, FBuffer.Canvas.Handle, 0, 0, SrcCopy);
end;

procedure TColorBox2000.SetFlat(const Value: Boolean);
begin
  if Value <> FFlat
  then begin
    FFlat:= Value;
    Invalidate;
  end;
end;

procedure TColorBox2000.CMMouseEnter(var Message: TMessage);
begin
  State:= csMouseOver;
  Invalidate;
end;

procedure TColorBox2000.CMMouseLeave(var Message: TMessage);
begin
  State:= csNormal;
  Invalidate;
end;

procedure TColorBox2000.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if (FColorMenu.FormOnScreen)
  or (ssLeft in Shift)
  then State:= csDroppedDown
  else State:= csMouseOver;
  Paint;
end;

procedure TColorBox2000.wmEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
end;

procedure TColorBox2000.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  R: TRect;
//  S: TSize;
begin
  inherited;

  R:= Rect(0, 0, Width, Height);
  if (R.Left <> R.Right)
  and (R.Top <> R.Right)
  then begin
    InflateRect(R, -2, -2);
    ButtonRect:= R;
    ButtonRect.Left:= ButtonRect.Right - Round((R.Bottom - R.Top) * 2 / 3) -2;

    if hThemeLibrary <> 0
    then begin
      Dec(ButtonRect.Left, 2);
    end;

    SubtractRect(EditRect, R, ButtonRect);
    Dec(EditRect.Right, 2);
  end;

  if FBuffer <> nil
  then begin
    FBuffer.Width:= AWidth;
    FBuffer.Height:= AHeight;
  end;
end;

procedure TColorBox2000.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  C: TComponent;
begin
  inherited;

  SetFocus;

  if IgnoreMouseDown
  then begin
    IgnoreMouseDown:= False;
    Exit;
  end;

  State:= csDroppedDown;
  Paint;

  with Parent.ClientToScreen(Point(Left + Width - 155, Top + Height))
  do FColorMenu.Popup(X, Y);

  if (GetKeyState(vk_LButton) < 0)
  then begin
    GetCursorPos(P);
    C:= FindDragTarget(P, True);
    IgnoreMouseDown:= C = Self;
  end;

  State:= csNormal;
  Paint;
end;

procedure TColorBox2000.SetAnimatedSkin(
  const Value: T_AM2000_AnimatedSkin);
begin
  FColorMenu.AnimatedSkin:= Value;
end;

function TColorBox2000.GetAnimatedSkin: T_AM2000_AnimatedSkin;
begin
  Result:= FColorMenu.AnimatedSkin;
end;

procedure TColorBox2000.ColorClick(Sender: TObject; Color: TColor);
begin
  if Color = clAutomatic
  then FCurrentColorTitle:= 'Automatic'
  else
  if Color = clMore
  then FCurrentColorTitle:= '$' + IntToHex(ColorToRGB(Color), 6)
  else ColorToIdent(Color, FCurrentColorTitle);

  if Assigned(FOnChange)
  then FOnChange(Self, Color);
end;

procedure TColorBox2000.DoEnter;
begin
  inherited;
  Invalidate;
end;

procedure TColorBox2000.DoExit;
begin
  inherited;
  Paint;
end;

end.

