
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_TextControl                            }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000text;

interface

uses
  Windows, Classes, Graphics, Menus, Controls, ExtCtrls,
  am2000options;

type
  // text options
  T_AM2000_TextControl = class(T_AM2000_MenuControl)
  private
    FColor: TColor;
    FHighColor: TColor;
    FFont: TFont;
    FParentFontName: Boolean;
    FParentFontSize: Boolean;
    FIgnoreMargins: Boolean;
    FHighFont: TFont;

    procedure SetFont(const Value: TFont);
    procedure SetHighFont(const Value: TFont);

  public
    constructor Create(AParent: TMenuItem); override;
    destructor Destroy; override;

    procedure Paint(Params: P_AM2000_PaintMenuItemParams); override;
    procedure Assign(Source: TPersistent); override;

    function GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer; override;
    function GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer; override;

  published
    property Color        : TColor
      read FColor write FColor default clNone;
    property HighlightColor        : TColor
      read FHighColor write FHighColor default clNone;
    property Font: TFont
      read FFont write SetFont;
    property HighlightFont: TFont
      read FHighFont write SetHighFont;
    property ParentFontName: Boolean
      read FParentFontName write FParentFontName default True;
    property ParentFontSize: Boolean
      read FParentFontSize write FParentFontSize default True;
    property IgnoreMargins: Boolean
      read FIgnoreMargins write FIgnoreMargins default False;

  end;


implementation

uses
  SysUtils,
  am2000cache, am2000menuitem, am2000utils;


{ T_AM2000_TextControl }

constructor T_AM2000_TextControl.Create(AParent: TMenuItem);
begin
  inherited;
  FFont:= TFont.Create;
  FHighFont:= TFont.Create;
  FColor:= clNone;
  FHighColor:= clNone;
  FParentFontName:= True;
  FParentFontSize:= True;
end;

destructor T_AM2000_TextControl.Destroy;
begin
  FFont.Free;
  FHighFont.Free;
  inherited;
end;


function GetStrExtentPoint(DC: HDC; S: String; Width: Integer): TPoint;
var
  Size: TSize;
  W, H, I: Integer;
  S1: String;
begin
  W:= 0;
  H:= 0;

  while S <> '' do begin
    S1:= S;
    repeat
      GetTextExtentPoint32(DC, PChar(S1), Length(S1), Size);
      if Size.cX >= Width then begin
        I:= Length(S1);
        while (I > 0) and (S1[I] <> ' ') do Dec(I);
        if I = 0 then Break;
        Delete(S1, I, MaxInt);
      end;
    until Size.cX < Width;

    if W < Size.cX then W:= Size.cX;
    Inc(H, Size.cY);
    Delete(S, 1, Length(S1) +1);
  end;

  Result:= Point(W, H);
end;

procedure T_AM2000_TextControl.Paint(Params: P_AM2000_PaintMenuItemParams);
var
  OldFont: TFont;
  R: TRect;
  P, Right, TFlags: Integer;
  S, S1: String;
begin
  TFlags:= dt_NoClip or dt_VCenter or dt_WordBreak;
  with Params^, mir, Canvas
  do begin
    if FIgnoreMargins
    then Right:= LineRight -3
    else Right:= LineRight - PaintOptions.Margins.Right -3;

    // alignment
    if (PaintOptions.Alignment = taCenter)
    then TFlags:= TFlags or dt_Center;

    if (PaintOptions.Alignment = taRightJustify)
    or (not (isLeftToRight in State))
    then TFlags:= TFlags or dt_Right;

    if (isGraphBack in State)
    then begin
      if Brush.Style <> bsClear
      then Brush.Style:= bsClear;
    end
    else
      if Brush.Style <> bsSolid
      then Brush.Style:= bsSolid;

    // highlighted
    OldFont:= TFont.Create;
    OldFont.Assign(Font);

    if isSelected in State
    then begin
      if FHighColor <> clNone
      then begin
        Brush.Color:= FHighColor;
        FillRect(LineRect);
      end;

      if FParentFontName
      and (FHighFont.Name <> Font.Name)
      then FHighFont.Name:= Font.Name;

      if FParentFontSize
      and (FHighFont.Size <> Font.Size)
      then FHighFont.Size:= Font.Size;

      Font:= FHighFont;
    end

    // normal
    else begin
      if not (isGraphBack in State)
      then begin
        Brush.Color:= FColor;
        FillRect(LineRect);
      end;

      if FParentFontName
      and (FFont.Name <> Font.Name)
      then FFont.Name:= Font.Name;

      if FParentFontSize
      and (FFont.Size <> Font.Size)
      then FFont.Size:= Font.Size;

      Font:= FFont;
    end;

    if FIgnoreMargins
    then R:= Rect(LineLeft +3, Top +3, Right, 0)
    else R:= Rect(ItemLeft, Top +3, Right, 0);

    S:= Parent.Caption;
    repeat
      P:= Pos(SNewLine, S);
      if P = 0 then P:= Pos(#13, S);
      if P = 0 then P:= Length(S) +1;

      S1:= Copy(S, 1, P -1);
      if S1 = '' then S1:= ' ';
      with GetStrExtentPoint(Handle, S1, iMaxItemWidth -6) do
        R.Bottom:= R.Top + Y;

      DrawText(Handle, PChar(S1), P -1, R, TFlags);

      if (P < Length(S))
      and (S[P] = #13)
      then Delete(S, 1, P)
      else Delete(S, 1, P +1);

      R.Top:= R.Bottom;

    until S = '';

    // checkmark
    if Parent.Checked
    then
      if Parent.RadioItem
      then DrawBitmapHandle(Canvas, 0, 0, bmpRadioItem, [isChecked], PaintOptions, mir.BitmapRect)
      else DrawBitmapHandle(Canvas, 0, 0, bmpCheckMark, [isChecked], PaintOptions, mir.BitmapRect);

    // triangle
    if HasSubMenu(Parent)
    then DrawSubmenuTriangle(Canvas, State + [isSubmenu], PaintOptions, mir.TriangleRect);

    Font.Assign(OldFont);
    OldFont.Free;
  end;
end;

function T_AM2000_TextControl.GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
var
  DC: HDC;
  OldFont: HFont;
  MaxY, P, Width: Integer;
  S, S1: String;
begin
  MaxY:= 0;

  DC:= CreateDC('DISPLAY', nil, nil, nil);

  if FParentFontName
  and (FFont.Name <> Font.Name)
  then FFont.Name:= Font.Name;

  if FParentFontSize
  and (FFont.Size <> Font.Size)
  then FFont.Size:= Font.Size;

  OldFont:= SelectObject(DC, FFont.Handle);

//  if FIgnoreMargins
//  then
  Width:= iMaxItemWidth -6;
//  else Width:= iMaxItemWidth - Options.Margins.Left - Options.Margins.Right -3;

  S:= Parent.Caption;
  repeat
    P:= Pos(SNewLine, S);
    if P = 0 then P:= Pos(#13, S);
    if P = 0 then P:= Length(S) +1;

    S1:= Copy(S, 1, P -1);
    if S1 = '' then S1:= ' ';
    with GetStrExtentPoint(DC, S1, Width) do
      Inc(MaxY, Y);

    if P < Length(S)
    then begin
      if (S[P] = #13)
      then Delete(S, 1, P)
      else Delete(S, 1, P +1);

      if S = '' then S:= ' ';
    end
    else
      Break;
      
  until S = '';

  SelectObject(DC, OldFont);
  DeleteDC(DC);

  Result:= MaxY +6;
end;

function T_AM2000_TextControl.GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
var
  DC: HDC;
  OldFont: HFont;
  MaxX, P, Width: Integer;
  S: String;
begin
  MaxX:= 0;
  DC:= CreateDC('DISPLAY', nil, nil, nil);
  OldFont:= SelectObject(DC, Font.Handle);

//  if FIgnoreMargins
//  then
  Width:= iMaxItemWidth -6;
//  else Width:= iMaxItemWidth - Options.Margins.Left - Options.Margins.Right -3;

  S:= Parent.Caption;
  repeat
    P:= Pos(SNewLine, S);
    if P = 0 then P:= Pos(#13, S);
    if P = 0 then P:= Length(S) +1;

    with GetStrExtentPoint(DC, Copy(S, 1, P -1), Width) do
      if MaxX < X then MaxX:= X;

    if (P < Length(S))
    and (S[P] = #13)
    then Delete(S, 1, P)
    else Delete(S, 1, P +1);
  until S = '';

  SelectObject(DC, OldFont);
  DeleteDC(DC);

  Result:= MaxX +6;

  if not FIgnoreMargins
  then Inc(Result, Options.Margins.Left + Options.Margins.Right);
end;

procedure T_AM2000_TextControl.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure T_AM2000_TextControl.SetHighFont(const Value: TFont);
begin
  FHighFont.Assign(Value);
end;

procedure T_AM2000_TextControl.Assign(Source: TPersistent);
var
  S: T_AM2000_TextControl;
begin
  inherited;

  if Source is T_AM2000_TextControl
  then begin
    S:= T_AM2000_TextControl(Source);

    Color:= S.Color;
    HighlightColor:= S.HighlightColor;
    ParentFontName:= S.ParentFontName;
    ParentFontSize:= S.ParentFontSize;
    IgnoreMargins:= S.IgnoreMargins;

    Font.Assign(S.Font);
    HighlightFont.Assign(S.HighlightFont);
  end;
end;

end.
