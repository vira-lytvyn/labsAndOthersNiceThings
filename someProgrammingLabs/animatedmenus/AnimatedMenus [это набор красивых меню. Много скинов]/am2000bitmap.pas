
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_BitmapControl                          }
{                                                       }
{       Copyright (c) 1997-2002 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000bitmap;

interface

uses
  Windows, Classes, Graphics, Menus, Controls,
  am2000options;

type

  // Bitmap menu control options
  T_AM2000_BitmapControl = class(T_AM2000_MenuControl)
  private
    FTransparent  : Boolean;
    FNumGlyphs    : Integer;
    FBitmap       : TBitmap;
    FDrawCaption  : Boolean;

    procedure SetBitmap(Value: TBitmap);
    procedure SetNumGlyphs(const Value: Integer);

  public
    constructor Create(AParent: TMenuItem); override;
    destructor Destroy; override;

    procedure Paint(Params: P_AM2000_PaintMenuItemParams); override;
    procedure Assign(Source: TPersistent); override;

    function GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer; override;
    function GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer; override;


  published
//    property Transparent  : Boolean
//      read FTransparent write FTransparent default False;
    property NumGlyphs    : Integer
      read FNumGlyphs write SetNumGlyphs default 1;
    property Bitmap       : TBitmap
      read FBitmap write SetBitmap;
//    property DrawCaption  : Boolean
//      read FDrawCaption write FDrawCaption default True;
// Color
// ParentColor
// HighlightColor
// GlyphLayout
  end;


implementation

uses
  SysUtils,
  am2000menuitem, am2000utils, am2000cache;


{ T_AM2000_BitmapControl }

constructor T_AM2000_BitmapControl.Create(AParent: TMenuItem);
begin
  inherited;
  FTransparent:= True;
  FDrawCaption:= True;
  FNumGlyphs:= 1;
  FBitmap:= TBitmap.Create;
end;

destructor T_AM2000_BitmapControl.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure T_AM2000_BitmapControl.SetBitmap(Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure T_AM2000_BitmapControl.Paint(Params: P_AM2000_PaintMenuItemParams);
var
  DX, X: Integer;
  OldPalette: HPalette;
begin
  if (FBitmap = nil)
  or (FBitmap.Empty)
  then Exit;

  with Params^
  do begin
    // select bitmap

    DX:= FBitmap.Width div FNumGlyphs;
    X:= 0;
    if (FNumGlyphs > 1) and (isDisabled in State)  then X:= DX
    else
    if (FNumGlyphs > 2) and (isPressed in State) then X:= 2 * DX
    else
    if (FNumGlyphs > 3) and (isSelected in State)  then X:= 3 * DX;

    // draw
    OldPalette:= 0;
    if (FBitmap.Palette <> 0) then begin
      OldPalette:= SelectPalette(Canvas.Handle, FBitmap.Palette, True);
      RealizePalette(Canvas.Handle);
    end;

    BitBlt(Canvas.Handle, mir.LineLeft, mir.Top, mir.LineRight - mir.LineLeft, mir.Height,
      FBitmap.Canvas.Handle, X, 0, Canvas.CopyMode);

    if OldPalette <> 0
    then SelectPalette(Canvas.Handle, OldPalette, True);
  end;
end;

function T_AM2000_BitmapControl.GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  if
    (FBitmap <> nil)
  then
    Result:= FBitmap.Height
  else
    Result:= 0;
end;

function T_AM2000_BitmapControl.GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  if
    (FBitmap <> nil)
  then
    Result:= FBitmap.Width div FNumGlyphs
  else
    Result:= 0;
end;

procedure T_AM2000_BitmapControl.SetNumGlyphs(const Value: Integer);
begin
  if
    (Value > 0) and (Value < 5)
  then
    FNumGlyphs:= Value
  else
    raise Exception.Create(SValueMustBeBetween1And4);
end;

procedure T_AM2000_BitmapControl.Assign(Source: TPersistent);
var
  S: T_AM2000_BitmapControl;
begin
  inherited;

  if Source is T_AM2000_BitmapControl
  then begin
    S:= T_AM2000_BitmapControl(Source);

    NumGlyphs:= S.NumGlyphs;
    
    Bitmap.Assign(S.Bitmap);
  end;
end;

end.
