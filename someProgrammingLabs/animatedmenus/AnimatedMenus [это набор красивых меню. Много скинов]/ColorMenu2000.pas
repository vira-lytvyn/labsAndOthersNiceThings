
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TColorMenu2000 Component                        }
{                                                       }
{       Copyright © 1997-2002 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/tcolormenu2000/
//

unit ColorMenu2000;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  am2000, am2000menuitem;


const
  clAutomatic = TColor($90000000);
  clMore = TColor($90000001);
  clCustom = TColor($40000000);

type
  T_AM2000_ColorSelectionEvent = procedure(Sender: TObject; Color: TColor) of object;

  T_AM2000_ColorMenuOptions = set of (coIncludeAutomatic, coIncludeNone, coIncludeMoreColors, coStandardColors,
    coExtendedColors, coCustomColors, coSystemColors, coGrayColors);

  TColorMenu2000 = class(TPopupMenu2000)
  private
    FOnClick: T_AM2000_ColorSelectionEvent;
    FOnMoreColors: TNotifyEvent;
    FColorMenuOptions: T_AM2000_ColorMenuOptions;
    FAutomaticColor: TColor;
    FMoreColorsColor: TColor;
    FCustomColors: TStrings;
    FWidth, FHeight: Integer;
    FMoreColors, FColors: TMenuItem2000;
    FCurrentColor: TColor;

    function GetCustomColors: TStrings;
    procedure SetCustomColors(Value: TStrings);

    procedure CustomColorClick(Sender: TObject);
    procedure SystemColorClick(Sender: TObject);
    procedure MoreColorsClick(Sender: TObject);
    procedure AutomaticColorClick(Sender: TObject);
    procedure DrawColor(const Canvas: TCanvas; const X, Y, D, AWidth,
      AHeight: Integer; const Color: TColor);

  protected
    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;
    procedure UpdateComponentItems(Items: TMenuItem2000); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsCustomColorsStored: Boolean;

  published
    property AutomaticColor: TColor
      read FAutomaticColor write FAutomaticColor default clBlack;
    property MoreColorsColor: TColor
      read FMoreColorsColor write FMoreColorsColor default clWhite;
    property CustomColors: TStrings
      read GetCustomColors write SetCustomColors stored IsCustomColorsStored;
    property ColorMenuOptions: T_AM2000_ColorMenuOptions
      read FColorMenuOptions write FColorMenuOptions;
    property Width: Integer
      read FWidth write FWidth default 18;
    property Height: Integer
      read FHeight write FHeight default 18;
    property CurrentColor: TColor
      read FCurrentColor write FCurrentColor default clAutomatic;

    property OnClick: T_AM2000_ColorSelectionEvent
      read FOnClick write FOnClick;
    property OnMoreColors: TNotifyEvent
      read FOnMoreColors write FOnMoreColors;

  end;

function ColorToRGB(const Color: TColor): LongInt;
function ColorToRGBEx(const Color: TColor; const AColorMenu: TColorMenu2000): LongInt;
function ColorToIdent(const Color: Cardinal; var Ident: string): Boolean;

implementation

uses
  am2000buttonarray, am2000options, am2000utils;

const
  StandardColors: array [0..1, 0..7] of TColor = (
    (clBlack, clGray, clGreen, clMaroon, clOlive, clNavy, clPurple, clTeal),
    (clWhite, clSilver, clLime, clRed, clYellow, clBlue, clFuchsia, clAqua));
  StandardColorsHints: array [0..1, 0..7] of String = (
    ('Black', 'Gray', 'Green', 'Maroon', 'Olive', 'Navy', 'Purple', 'Teal'),
    ('White', 'Silver', 'Lime', 'Red', 'Yellow', 'Blue', 'Fuchsia', 'Aqua'));
  ExtendedColors: array [0..4, 0..7] of TColor = (
    ($000000, $003399, $003333, $003300, $663300, $800000, $993333, $333333),
    ($000080, $0066FF, $008080, $008000, $808000, $FF0000, $996666, $808080),
    ($0000FF, $0099FF, $00CC99, $669933, $CCCC33, $FF6633, $800080, $999999),
    ($FF00FF, $00CCFF, $00FFFF, $00FF00, $FFFF00, $FFCC00, $663399, $CCCCCC),
    ($CC99FF, $99CCFF, $99FFFF, $CCFFCC, $FFFFCC, $FFCC99, $FF99CC, $FFFFFF));
  ExtendedColorsHints: array [0..4, 0..7] of String = (
    ('Black', 'Brown', 'Olive Green', 'Dark Green', 'Dark Teal', 'Dark Blue', 'Indigo', 'Gray-80%'),
    ('Dark Red', 'Orange', 'Dark Yellow', 'Green', 'Teal', 'Blue', 'Blue-Gray', 'Gray-50%'),
    ('Red', 'Light Orange', 'Lime', 'Sea Green', 'Aqua', 'Light Blue', 'Violet', 'Gray-40%'),
    ('Pink', 'Gold', 'Yellow', 'Bright Green', 'Torquoise', 'Sky Blue', 'Plum', 'Gray-20%'),
    ('Rose', 'Tan', 'Light Yellow', 'Light Green', 'Light Torquoise', 'Pale Blue', 'Lavender', 'White'));



{$J+}

const
  LastAutomaticColor: LongInt = 1;
  LastMoreColor: LongInt = 0;

function ColorToRGB(const Color: TColor): LongInt;
begin
  Result:= ColorToRGBEx(Color, nil);
end;

function ColorToRGBEx(const Color: TColor; const AColorMenu: TColorMenu2000): LongInt;
begin
  if Color = clAutomatic
  then
    if (AColorMenu <> nil)
    and (AColorMenu is TColorMenu2000)
    then Result:= TColorMenu2000(AColorMenu).AutomaticColor
    else Result:= LastAutomaticColor

  else
  if Color = clMore
  then
    if (AColorMenu <> nil)
    and (AColorMenu is TColorMenu2000)
    then Result:= TColorMenu2000(AColorMenu).MoreColorsColor
    else Result:= LastMoreColor

  else
    Result:= Graphics.ColorToRGB(Color and not clCustom);
end;


{ TColorMenu2000 }

constructor TColorMenu2000.Create(AOwner: TComponent);
begin
  inherited;
  FCurrentColor:= clAutomatic;
  FAutomaticColor:= clBlack;
  FMoreColorsColor:= clWhite;
  FWidth:= 18;
  FHeight:= 18;
  FColorMenuOptions:= [coStandardColors];
end;

destructor TColorMenu2000.Destroy;
begin
  FCustomColors.Free;
  inherited;
end;

procedure TColorMenu2000.DrawColor(const Canvas: TCanvas; const X, Y, D, AWidth, AHeight: Integer; const Color: TColor);
var
  R: TRect;
begin
  R:= Rect(AWidth * X + D, AHeight * Y + D, 0, 0);
  R.Right:= R.Left + AWidth - 2*D;
  R.Bottom:= R.Top + AHeight - 2*D;
  Canvas.Brush.Color:= Options.Colors.DisabledText;
  Canvas.FrameRect(R);

  InflateRect(R, -1, -1);
  Canvas.Brush.Color:= Color;
  Canvas.FillRect(R);
end;

function ColorToIdent(const Color: Cardinal; var Ident: string): Boolean;
var
  I, J: Integer;
begin
  Ident:= '';

  if Color = $80000019
  then Ident:= 'Visited Link'
  else
  if Color = $8000001a
  then Ident:= 'Hovered Link'
  else begin
    Graphics.ColorToIdent(TColor(Color), Ident);
    if Ident = ''
    then begin
      for I:= 0 to 4
      do
        for J:= 0 to 7
        do
          if Color = ExtendedColors[I, J]
          then Ident:= ExtendedColorsHints[I, J];

      if Ident = ''
      then Ident:= '$' + IntToHex(Color and not clCustom, 6);
      
    end
    else begin
      if Copy(Ident, 1, 2) = 'cl'
      then Delete(Ident, 1, 2);

      I:= 2;
      while I < Length(Ident)
      do begin
        if Ident[I] in ['A'..'Z']
        then begin
          Insert(' ', Ident, I);
          Inc(I);
        end;

        Inc(I);
      end;

      Ident:=
        StringReplace(
        StringReplace(
        StringReplace(
        StringReplace(Ident, 'Btn', 'Button', [rfReplaceAll]),
          'Bk', 'Background', [rfReplaceAll]),
          'Dk', 'Dark', [rfReplaceAll]),
          '3 D', '3D', [rfReplaceAll]);
    end;
  end;

  Result:= True;
end;

procedure TColorMenu2000.CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean);
const
  Delta = 10.6667;

var
  MI: TMenuItem2000;
  X, Y, Y1: Integer;
  S: String;
  C: TColor;
begin
  LastAutomaticColor:= FAutomaticColor;

  if coIncludeAutomatic in FColorMenuOptions
  then begin
    MI:= TMenuItem2000.Create(Owner);
    MI.Caption:= 'Automatic';
    MI.Control:= ctlButton;
    MI.OnClick:= AutomaticColorClick;

    with MI.Bitmap, Canvas
    do begin
      Width:= 16;
      Height:= 16;
      Brush.Style:= bsSolid;
      Brush.Color:= Rgb($FE, $FE, $FE);
      FillRect(ClipRect);
    end;

    DrawColor(MI.Bitmap.Canvas, 0, 0, 2, 16, 16, FAutomaticColor);

    if CurrentColor = clAutomatic
    then MI.AsButton.Down:= True;

    Items.Add(MI);
    Items.Add(am2000menuitem.NewLine);
  end;


  // none button
  if coIncludeNone in FColorMenuOptions
  then begin
    MI:= TMenuItem2000.Create(Owner);
    MI.Caption:= 'None';
    MI.Control:= ctlButton;
    MI.OnClick:= AutomaticColorClick;

    if CurrentColor = clNone
    then MI.AsButton.Down:= True;

    Items.Add(MI);
    Items.Add(am2000menuitem.NewLine);
  end;


  // standard colors
  if (coStandardColors in FColorMenuOptions)
  or (coExtendedColors in FColorMenuOptions)
  or (coGrayColors in FColorMenuOptions)
  then begin
    MI:= TMenuItem2000.Create(Owner);
    MI.Control:= ctlButtonArray;
    MI.OnClick:= CustomColorClick;
    FColors:= MI;

    with MI.AsButtonArray
    do begin
      Y1:= 0;
      Columns:= 8;

      if (coExtendedColors in FColorMenuOptions)
      then Rows:= 5
      else
      if (coStandardColors in FColorMenuOptions)
      then Rows:= 2;

      if (coGrayColors in FColorMenuOptions)
      then Rows:= Rows +3;

      Count:= Rows * Columns;
      Bitmap.Width:= Columns * FWidth;
      Bitmap.Height:= Rows * FHeight;

      with Bitmap.Canvas
      do begin
        Brush.Style:= bsSolid;
        Brush.Color:= Rgb($FE, $FE, $FE);
        FillRect(ClipRect);
      end;

      // gray colors
      if (coGrayColors in FColorMenuOptions)
      then begin
        Y1:= 3;
        for Y:= 0 to 2
        do
          for X:= 0 to Columns -1
          do begin
            C:= Round(255 - Delta * (X + Y *8));
            DrawColor(Bitmap.Canvas, X, Y, 3, FWidth, FHeight, RGB(C, C, C));

            if (X = 0) and (Y = 0)
            then Hints.Add('White')
            else
            if (X = 7) and (Y = Y1 -1)
            then Hints.Add('Black')
            else Hints.Add('Gray-' + IntToStr(100 - Round(100 * C / 256)) + '%');

            if FCurrentColor = C
            then ItemIndex:= Y * Columns + X;
          end;
      end;

      if (coExtendedColors in FColorMenuOptions)
      then
        for Y:= 0 to 4
        do
          for X:= 0 to Columns -1
          do begin
            DrawColor(Bitmap.Canvas, X, Y + Y1, 3, FWidth, FHeight, ExtendedColors[Y, X]);
            Hints.Add(ExtendedColorsHints[Y, X]);

            if FCurrentColor = ExtendedColors[Y, X]
            then ItemIndex:= Y * Columns + X + Y1 * Columns;
          end

      else
      if (coStandardColors in FColorMenuOptions)
      then
        for Y:= 0 to 1
        do
          for X:= 0 to Columns -1
          do begin
            DrawColor(Bitmap.Canvas, X, Y + Y1, 3, FWidth, FHeight, StandardColors[Y, X]);
            Hints.Add(StandardColorsHints[Y, X]);

            if FCurrentColor = StandardColors[Y, X]
            then ItemIndex:= Y * Columns + X + Y1 * Columns;
          end;
    end;

    Items.Add(MI);
  end;

  if (coSystemColors in FColorMenuOptions)
  then begin
    Items.Add(am2000menuitem.NewLine);
    MI:= TMenuItem2000.Create(Owner);
    MI.Control:= ctlButtonArray;

    with MI.AsButtonArray
    do begin
      X:= 0;
      Y:= 0;
      Count:= COLOR_ENDCOLORS +1;
      Columns:= 8;
      Rows:= Count div Columns;
      if Rows * Columns < Count
      then Rows:= Rows +1;

      Bitmap.Width:= Columns * FWidth;
      Bitmap.Height:= Rows * FHeight;

      with Bitmap.Canvas
      do begin
        Brush.Style:= bsSolid;
        Brush.Color:= Rgb($FE, $FE, $FE);
        FillRect(ClipRect);
      end;

      for Y1:= COLOR_SCROLLBAR to COLOR_ENDCOLORS
      do begin
{$IFDEF Delphi7OrHigher}
        C:= Y1 or clSystemColor;
{$ELSE}
        C:= Y1 or $80000000;
{$ENDIF}        
        ColorToIdent(C, S);

        if FCurrentColor = C
        then ItemIndex:= Y1 - COLOR_SCROLLBAR;

        DrawColor(Bitmap.Canvas, X, Y, 3, FWidth, FHeight, GetSysColor(Y1));
        Hints.Add(S);

        Inc(X);
        if X >= Columns
        then begin
          Inc(Y);
          X:= 0;
        end;
      end;
    end;

    MI.OnClick:= SystemColorClick;
    Items.Add(MI);
  end;

  // custom colors
  if (coCustomColors in FColorMenuOptions)
  and (FCustomColors <> nil)
  and (FCustomColors.Count > 0)
  then begin
    Items.Add(am2000menuitem.NewLine);

    MI:= TMenuItem2000.Create(Owner);
    MI.OnClick:= CustomColorClick;
    MI.Control:= ctlButtonArray;

    with MI.AsButtonArray
    do begin
      Columns:= 8;
      Rows:= FCustomColors.Count div Columns;
      if Rows * Columns < FCustomColors.Count
      then Rows:= Rows +1;

      Count:= FCustomColors.Count;
      Bitmap.Width:= Columns * FWidth;
      Bitmap.Height:= Rows * FHeight;

      with Bitmap.Canvas
      do begin
        Brush.Style:= bsSolid;
        Brush.Color:= Rgb($FE, $FE, $FE);
        FillRect(ClipRect);
      end;

      X:= 0;
      Y:= 0;
      for Y1:= 0 to FCustomColors.Count -1
      do begin
        S:= FCustomColors[Y1];
        S:= Copy(S, Pos('=', S) +1, MaxInt);
        C:= StrToInt('$' + S);
        DrawColor(Bitmap.Canvas, X, Y, 3, FWidth, FHeight, TColor(C));

        if (FCurrentColor = (C or clCustom))
        then ItemIndex:= Y1;

        Inc(X);
        if X = Columns
        then begin
          X:= 0;
          Inc(Y);
        end;
      end;
    end;

    Items.Add(MI);
  end;

  // more colors
  if coIncludeMoreColors in FColorMenuOptions
  then begin
    Items.Add(am2000menuitem.NewLine);

    MI:= TMenuItem2000.Create(Owner);
    MI.Caption:= '&More Colors...';
    MI.OnClick:= MoreColorsClick;

    with MI.Bitmap, Canvas
    do begin
      Width:= 16;
      Height:= 16;
      Brush.Style:= bsSolid;
      Brush.Color:= Rgb($FE, $FE, $FE);
      FillRect(ClipRect);
    end;

    DrawColor(MI.Bitmap.Canvas, 0, 0, 2, 16, 16, FMoreColorsColor);
    Items.Add(MI);
    FMoreColors:= MI;
  end;
end;

procedure TColorMenu2000.UpdateComponentItems(Items: TMenuItem2000);
begin
  Items.Clear;
  CreateComponentItems(Items, False);
end;

function TColorMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Color Menu Items';
end;

procedure TColorMenu2000.CustomColorClick(Sender: TObject);
var
  X, Y: Integer;
begin
  if Assigned(FOnClick)
  then
    with TMenuItem2000(Sender).AsButtonArray
    do begin
      X:= ItemIndex mod Columns;
      Y:= ItemIndex div Columns;
      FCurrentColor:= Bitmap.Canvas.Pixels[X * FWidth +5, Y * FWidth +5];

      if Sender <> FColors
      then FCurrentColor:= FCurrentColor or clCustom;

      FOnClick(Sender, FCurrentColor);
    end;
end;

procedure TColorMenu2000.MoreColorsClick(Sender: TObject);
var
  C: TColorDialog;
begin
  if Assigned(FOnMoreColors)
  then FOnMoreColors(Sender)
  else begin
    FMoreColors.TurnSiblingsOff;

    C:= TColorDialog.Create(Owner);
    C.Color:= FMoreColorsColor;

    if FCustomColors <> nil
    then C.CustomColors:= FCustomColors;
    
    C.Options:= [cdFullOpen];

    if C.Execute
    then begin
      FMoreColorsColor:= C.Color;
      LastMoreColor:= C.Color;
      FCurrentColor:= clMore;

      if Assigned(FOnClick)
      then FOnClick(Sender, clMore);

      if C.CustomColors.Count > 0
      then CustomColors:= C.CustomColors;
    end;

    C.Free;
  end;
end;

procedure TColorMenu2000.AutomaticColorClick(Sender: TObject);
begin
  with TMenuItem2000(Sender), AsButton
  do begin
    Down:= True;

    if Caption = 'Automatic'
    then FCurrentColor:= clAutomatic
    else FCurrentColor:= clNone;

    if Assigned(FOnClick)
    then FOnClick(Sender, FCurrentColor);
  end;
end;

function TColorMenu2000.GetCustomColors: TStrings;
begin
  if FCustomColors = nil
  then FCustomColors:= TStringList.Create;
  Result:= FCustomColors;
end;

function TColorMenu2000.IsCustomColorsStored: Boolean;
begin
  Result:= (FCustomColors <> nil) and (FCustomColors.Count > 0)
end;

procedure TColorMenu2000.SetCustomColors(Value: TStrings);
begin
  if (Value <> nil) and (Value.Count > 0)
  then
    CustomColors.Assign(Value)

  else begin
    FCustomColors.Free;
    FCustomColors:= nil;
  end;
end;


procedure TColorMenu2000.SystemColorClick(Sender: TObject);
begin
  if Assigned(FOnClick)
  then
    with TMenuItem2000(Sender).AsButtonArray
    do begin
{$IFDEF Delphi7OrHigher}
      FCurrentColor:= ItemIndex or clSystemColor;
{$ELSE}
      FCurrentColor:= ItemIndex or $80000000;
{$ENDIF}
      FOnClick(Sender, FCurrentColor);
    end;
end;


end.

