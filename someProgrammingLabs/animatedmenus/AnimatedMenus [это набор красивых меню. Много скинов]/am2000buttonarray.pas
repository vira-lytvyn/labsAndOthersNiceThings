 
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_ButtonArrayControl                     }
{                                                       }
{       Copyright (c) 1997-2002 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000buttonarray;

{$I am2000.inc}

interface

uses
  Windows, Classes, Graphics, Menus, Controls,
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  am2000options;

type

  // TButtonArrayOptions
  T_AM2000_ButtonArrayControl = class(T_AM2000_MenuControl)
  private
    LastLeft, LastRight, LastTop, LastBottom: Integer;
    FRows         : Integer;
    FColumns      : Integer;
    FHints        : TStrings;
    FItemIndex    : Integer;
    FAllowAllUp   : Boolean;
    FBitmap       : TBitmap;
    FCount        : Integer;
    TempBmp       : TBitmap;

    procedure SetHints(Value: TStrings);
    procedure SetItemIndex(Value: Integer);
    procedure SetBitmap(const Value: TBitmap);

  public
    LastItemIndex : Integer;

    constructor Create(AParent: TMenuItem); override;
    destructor Destroy; override;

    procedure Paint(Params: P_AM2000_PaintMenuItemParams); override;
    procedure Assign(Source: TPersistent); override;
    procedure Click; override;

    function GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer; override;
    function GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer; override;

    function GetIndexAt(X, Y: Integer): Integer;

  published
    property Rows         : Integer
      read FRows write FRows default 1;
    property Columns         : Integer
      read FColumns write FColumns default 1;
    property Hints        : TStrings
      read FHints write SetHints;
    property ItemIndex    : Integer
      read FItemIndex write SetItemIndex default -1;
    property AllowAllUp   : Boolean
      read FAllowAllUp write FAllowAllUp default True;
    property Bitmap       : TBitmap
      read FBitmap write SetBitmap;
    property Count        : Integer
      read FCount write FCount default 0;

  end;



implementation

uses
  CommCtrl, Dialogs, SysUtils, StdCtrls, ExtCtrls,
  am2000menuitem, am2000utils;


{ T_AM2000_ButtonArrayControl }

constructor T_AM2000_ButtonArrayControl.Create;
begin
  inherited;

  FAllowAllUp:= True;
  FItemIndex:= -1;
  LastItemIndex:= -1;
  FRows:= 1;
  FColumns:= 1;
  FBitmap:= TBitmap.Create;
  TempBmp:= TBitmap.Create;
  FHints:= TStringList.Create;
end;

destructor T_AM2000_ButtonArrayControl.Destroy;
begin
  FHints.Free;
  FBitmap.Free;
  TempBmp.Free;
  inherited;
end;

function T_AM2000_ButtonArrayControl.GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  Result:= Bitmap.Height +4;
end;

function T_AM2000_ButtonArrayControl.GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  Result:= Bitmap.Width +2;
  ClearBitmap(TempBmp);
end;

procedure T_AM2000_ButtonArrayControl.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
  ClearBitmap(TempBmp);
end;

procedure T_AM2000_ButtonArrayControl.SetHints(Value: TStrings);
begin
  FHints.Assign(Value);
end;

procedure T_AM2000_ButtonArrayControl.SetItemIndex(Value: Integer);
begin
  if Value <> -1
  then TMenuItem2000(Parent).TurnSiblingsOff;

  LastItemIndex:= FItemIndex;
  FItemIndex:= Value;

  if not((csLoading in Parent.ComponentState)
  or (csDestroying in Parent.ComponentState))
  then GlobalRepaint;
end;

procedure T_AM2000_ButtonArrayControl.Paint(Params: P_AM2000_PaintMenuItemParams);
// draws TMenuItem2000 with ControlStyle = ctlButtonArray
// many thanks to Frédéric Schneider for the improvements to this routine
var
  R: TRect;
  I, J, NextLII: Integer;
  il: HImageList;
  Bmp: TBitmap;
  Size: TPoint;

  DefaultDraw: Boolean;
  Item2000: TMenuItem2000;
{$IFNDEF Delphi4OrHigher}
  ODS: T_AM2000_OwnerDrawState;
{$ELSE}
  ODS: TOwnerDrawState;
{$ENDIF}
begin
  with Params^
  do begin
    Item2000:= TMenuItem2000(Item);

    DefaultDraw:= not(
{$IFNDEF Delphi4OrHigher}
      (Item is TMenuItem2000) and
{$ENDIF}
      (Assigned(Item2000.OnDrawItem) or
       Assigned(Item2000.OnAdvancedDrawItem)));


    // before draw
    if (Item is TMenuItem2000)
    and Assigned(Item2000.OnBeforeDrawItem)
    then Item2000.OnBeforeDrawItem(Item, DefaultDraw);

    // draw item
    if
{$IFNDEF Delphi4OrHigher}
      (Item is TMenuItem2000) and
{$ENDIF}
    Assigned(Item2000.OnDrawItem)
    then begin
      Item2000.OnDrawItem(Item, Canvas, mir.LineRect, isSelected in State);
      if not DefaultDraw then Exit;
    end;

    // advanced draw item
    if
{$IFNDEF Delphi4OrHigher}
      (Item is TMenuItem2000) and
{$ENDIF}
    Assigned(Item2000.OnAdvancedDrawItem)
    then begin
      ODS:= [];
      if isSelected in State then Include(ODS, odSelected);
      if isSelected in State then Include(ODS, odFocused);
      if isDisabled in State then Include(ODS, odGrayed);
      if isDisabled in State then Include(ODS, odDisabled);
{$IFNDEF Delphi4}
      if isDefault  in State then Include(ODS, odDefault);
{$ENDIF}
      if isChecked  in State then Include(ODS, odChecked);

      Item2000.OnAdvancedDrawItem(Item, Canvas, mir.LineRect, ODS);
      if not DefaultDraw then Exit;
    end;
  end;


  if (FBitmap = nil)
  or (FBitmap.Empty)
  then Exit;

  with Params^, PaintOptions
  do begin
    // draw background
    if Canvas.Brush.Color <> PaintOptions.Colors.Menu
    then Canvas.Brush.Color:= PaintOptions.Colors.Menu;
    if Canvas.Brush.Style <> bsSolid
    then Canvas.Brush.Style:= bsSolid;

    R:= mir.LineRect;
    Canvas.FillRect(R);
    InflateRect(R, -1, -1);
    Canvas.FrameRect(R);

    // create temporary bitmap (because this code is very slow)
    if TempBmp.Empty
    then begin
      with TempBmp, Canvas
      do begin
        Width:= Bitmap.Width;
        Height:= Bitmap.Height;
        Brush.Style:= bsSolid;
        Brush.Color:= PaintOptions.Colors.Menu;
        FillRect(ClipRect);
      end;

      Bmp:= TBitmap.Create;
      Bmp.Assign(Bitmap);

      // draw bitmap
      il:= ImageList_Create(Bitmap.Width, Bitmap.Height, ilc_Color24 + ilc_Mask, 1, 1);
      ImageList_AddMasked(il, Bmp.Handle, Bmp.Canvas.Pixels[0, Bitmap.Height -1]);
      ImageList_Draw(il, 0, TempBmp.Canvas.Handle, 0, 0, ild_Normal);
      ImageList_Destroy(il);

      Bmp.Free;
    end;

    // fast draw the bitmap
    BitBlt(Canvas.Handle, mir.LineLeft +1, mir.Top +2, Bitmap.Width, Bitmap.Height,
      TempBmp.Canvas.Handle, 0, 0, SrcCopy);

    // count
    if Count = 0 then Count:= Rows * Columns;

    // draw rectangle
    // get size
    Size:= Point(Bitmap.Width div Columns, Bitmap.Height div Rows);

    // draw item index
    if (ItemIndex >=0)
    then begin
      I:= ItemIndex mod Columns;
      J:= ItemIndex div Columns;

      R:= Rect(I * Size.X + mir.LineLeft +1, J * Size.Y + mir.Top +2, 0, 0);
      R.Right:= R.Left + Size.X;
      R.Bottom:= R.Top + Size.Y;

      // draw edge
      Frame3D(Canvas, R, PaintOptions.Colors.FrameShadow, PaintOptions.Colors.Frame, 1);
//      DrawEdge(Canvas.Handle, R, bdr_SunkenOuter, bf_Rect)
    end;


    // save coordinates
    LastLeft:= mir.LineLeft;
    LastRight:= mir.LineRight;
    LastTop:= mir.Top;
    LastBottom:= mir.Top + mir.Height;

    // draw current item
    NextLii:= -1;

    if (isSelected in State)
    and (MousePos.X > mir.LineLeft -2)
    and (MousePos.X < mir.LineRight)
    and (MousePos.Y > mir.Top -1)
    and (MousePos.Y < mir.Top + mir.Height)
    then begin
      I:= (MousePos.X - mir.LineLeft -1) div Size.X;
      J:= (MousePos.Y - mir.Top -2) div Size.Y;

      NextLII:= I + J * Columns;
      if (I >= 0) and (I < Columns)
      and (J >= 0) and (J < Rows)
      and (NextLII < Count)
      then begin
        // get current item's size
        R:= Rect(I * Size.X + mir.LineLeft +1, J * Size.Y + mir.Top +2, 0, 0);
        R.Right:= R.Left + Size.X;
        R.Bottom:= R.Top + Size.Y;

        // draw edge
        if (msLeftButton in MouseState)
        then Frame3D(Canvas, R, Colors.FrameShadow, Colors.Frame, 1)
        else Frame3D(Canvas, R, Colors.Frame, Colors.FrameShadow, 1);

      end { acceptable I and J } ;
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

    LastItemIndex:= NextLII;
  end;
end;

function T_AM2000_ButtonArrayControl.GetIndexAt(X, Y: Integer): Integer;
var
  I, J: Integer;
  Size: TPoint;
begin
  Result:= -1;
  if (X > LastLeft)
  and (X < LastRight)
  and (Y > LastTop -1)
  and (Y < LastBottom)
  then begin
    Size:= Point(Bitmap.Width div Columns, Bitmap.Height div Rows);
    I:= (X - LastLeft -2) div Size.X;
    J:= (Y - LastTop -2) div Size.Y;
    Result:= I + J * Columns;
  end;
end;

procedure T_AM2000_ButtonArrayControl.Assign(Source: TPersistent);
var
  S: T_AM2000_ButtonArrayControl;
begin
  inherited;

  if Source is T_AM2000_ButtonArrayControl
  then begin
    S:= T_AM2000_ButtonArrayControl(Source);

    Rows:= S.Rows;
    Columns:= S.Columns;
    ItemIndex:= S.ItemIndex;
    AllowAllUp:= S.AllowAllUp;
    Count:= S.Count;

    Hints.Assign(S.Hints);
    Bitmap.Assign(S.Bitmap);
  end;
end;

procedure T_AM2000_ButtonArrayControl.Click;
begin
  inherited;
  ItemIndex:= LastItemIndex;
end;

end.
