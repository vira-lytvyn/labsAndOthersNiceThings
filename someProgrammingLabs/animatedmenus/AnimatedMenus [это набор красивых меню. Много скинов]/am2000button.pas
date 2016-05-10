
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_ButtonControl                          }
{                                                       }
{       Copyright (c) 1997-2002 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000button;

{$I am2000.inc}

interface

uses
  SysUtils, Windows, Graphics, Menus, Classes,
  am2000options;

type

  // TButtonOptions - options for ControlType = ctButton
  T_AM2000_ButtonControl = class(T_AM2000_MenuControl)
  private
    FAllowAllUp   : Boolean;
    FBorderFrame  : Boolean;
    FDown         : Boolean;

    procedure SetDown(Value: Boolean);

  public
    constructor Create(AParent: TMenuItem); override;

    procedure Paint(Params: P_AM2000_PaintMenuItemParams); override;
    procedure Assign(Source: TPersistent); override;

    procedure Click; override;

    function GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer; override;

  published
    property AllowAllUp   : Boolean
      read FAllowAllUp write FAllowAllUp default True;
    property BorderFrame  : Boolean
      read FBorderFrame write FBorderFrame default True;
    property Down         : Boolean
      read FDown write SetDown default False;

  end;



implementation

uses
  ExtCtrls,
  am2000menuitem, am2000utils;


// draws TMenuItem2000 with ControlStyle = ctlButton
procedure DrawMenuItemButton(Canvas: TCanvas;
            Item: TMenuItem2000;
            Options: T_AM2000_MenuOptions;
            State: T_AM2000_ItemState;
            MouseState: T_AM2000_MouseState;
            mir: T_AM2000_MenuItemRect);
var
  R: TRect;
begin
  if not (Item.ControlOptions is T_AM2000_ButtonControl)
  then Exit;

  // clear background
  R:= mir.LineRect;
  DrawBackground(Canvas, [], Options, R);
  InflateRect(R, -1, -1);

  with Item.ControlOptions as T_AM2000_ButtonControl, Canvas
  do begin
    if (msLeftButton in MouseState)
    or (Down and not (isSelected in State))
    then begin
      if Options.Colors.Sunken <> clNone
      then DrawSolidBackground(Canvas, R, Options.Colors.Sunken)
      else DrawPatternBackground(Canvas, R);

      Frame3D(Canvas, R, Options.Colors.FrameShadow, Options.Colors.Frame, 1);
    end
    else
      if isSelected in State
      then
        if Down
        then Frame3D(Canvas, R, Options.Colors.FrameShadow, Options.Colors.Frame, 1)
        else Frame3D(Canvas, R, Options.Colors.Frame, Options.Colors.FrameShadow, 1);

    Brush.Style:= bsClear;
    Font.Color:= Options.Colors.MenuText;
    DrawCaption(Canvas, Item.Caption, State, taCenter, R, not (isShowAccelerators in State));

    if Item.HasBitmap
    then begin
      R:= mir.BitmapRect;
      OffsetRect(R, 5, 0);
      DrawBitmapHandle(Canvas, Item.Bitmap.Handle, Item.NumGlyphs, 0, [], nil, R);
    end;

    if BorderFrame
    then begin
      Brush.Color:= clBtnShadow;
      if Brush.Style <> bsSolid
      then Brush.Style:= bsSolid;

      R:= mir.LineRect;
      InflateRect(R, -6, -4);
      FrameRect(R);
    end;

    if isFramed in State
    then
      with Canvas
      do begin
        if Brush.Color <> clBlack
        then Brush.Color:= clBlack;

        if Brush.Style <> bsSolid
        then Brush.Style:= bsSolid;

        R:= mir.LineRect;
        FrameRect(R);
        InflateRect(R, -1, -1);
        FrameRect(R);
      end;
  end;
end;


{ T_AM2000_ButtonControl }

constructor T_AM2000_ButtonControl.Create;
begin
  inherited;
  FAllowAllUp:= True;
  FBorderFrame:= True;
end;

procedure T_AM2000_ButtonControl.Paint(Params: P_AM2000_PaintMenuItemParams);
begin
  with Params^ do
    DrawMenuItemButton(Canvas, TMenuItem2000(Parent), PaintOptions, State, MouseState, mir)
end;

function T_AM2000_ButtonControl.GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  Result:= Canvas.TextHeight(Parent.Caption) +11;
end;

procedure T_AM2000_ButtonControl.SetDown(Value: Boolean);
begin
  if Value <> False
  then TMenuItem2000(Parent).TurnSiblingsOff;

  if FAllowAllUp or Value
  then FDown:= Value;

  if not((csLoading in Parent.ComponentState)
  or (csDestroying in Parent.ComponentState))
  then GlobalRepaint;
end;

procedure T_AM2000_ButtonControl.Assign(Source: TPersistent);
var
  S: T_AM2000_ButtonControl;
begin
  inherited;

  if Source is T_AM2000_ButtonControl
  then begin
    S:= T_AM2000_ButtonControl(Source);

    AllowAllUp:= S.AllowAllUp;
    BorderFrame:= S.BorderFrame;
    Down:= S.Down;
  end;
end;

procedure T_AM2000_ButtonControl.Click;
begin
  inherited;
  Down:= True;
end;


end.
