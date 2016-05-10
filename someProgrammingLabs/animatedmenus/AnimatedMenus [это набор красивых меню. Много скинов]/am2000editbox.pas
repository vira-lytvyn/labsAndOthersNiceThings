
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_EditControl                         }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000editbox;

{$I am2000.inc}

interface

uses
  Windows, Classes, Graphics, Menus, Controls, ExtCtrls,
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  am2000options;

type
  T_AM2000_EditboxEditingEvent = procedure (Sender: TObject; var AllowEdit: Boolean);

  T_AM2000_EditboxEditedEvent = procedure (Sender: TObject; var S: String;
    var AcceptChanges: Boolean) of object;

  T_AM2000_EditboxChangeEvent = procedure (Sender: TObject; var S: String) of object;

  // editbox options
  T_AM2000_EditControl = class(T_AM2000_MenuControl)
  private
    R             : TRect;
    LastCanvas    : TCanvas;
    LastText      : String;
    Timer         : TTimer;
    VisibleCaret  : Boolean;

    FAutoSelect   : Boolean;
    FColor        : TColor;
    FMaxLength    : Integer;
    FReadOnly     : Boolean;
    FText         : String;
    FSelStart     : Integer;
    FSelLength    : Integer;
    FCaretPos     : Integer;
    FFirstPos     : Integer;
    FMinWidth     : Integer;

    FOnChange     : T_AM2000_EditboxChangeEvent;
    FOnEdited     : T_AM2000_EditboxEditedEvent;
    FOnEditing    : T_AM2000_EditboxEditingEvent;

    procedure SetCaretPos(const Value: Integer);

    procedure CheckPos;
    function ClearSel: Boolean;

    procedure OnBlinkCaret(Sender: TObject);

  public
    constructor Create(AParent: TMenuItem); override;
    destructor Destroy; override;

    procedure Paint(Params: P_AM2000_PaintMenuItemParams); override;
    procedure Assign(Source: TPersistent); override;

    function GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer; override;
    function GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer; override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;

    function BeginEdit(X, Y: Integer): Boolean;
    procedure CancelEdit(AcceptChanges: Boolean);

    property OnEditing    : T_AM2000_EditboxEditingEvent
      read FOnEditing write FOnEditing;
    property OnEdited     : T_AM2000_EditboxEditedEvent
      read FOnEdited write FOnEdited;
    property OnChange     : T_AM2000_EditboxChangeEvent
      read FOnChange write FOnChange;

  published
    property AutoSelect   : Boolean
      read FAutoSelect write FAutoSelect default True;
    property Color        : TColor
      read FColor write FColor default clWindow;
    property MaxLength    : Integer
      read FMaxLength write FMaxLength default 0;
    property ReadOnly     : Boolean
      read FReadOnly write FReadOnly default False;
    property Text         : String
      read FText write FText;
    property MinWidth     : Integer
      read FMinWidth write FMinWidth default 0;
  end;


implementation

uses
  SysUtils, Forms,
  am2000popupmenu, am2000menuitem, am2000utils;


{ T_AM2000_EditControl }

constructor T_AM2000_EditControl.Create(AParent: TMenuItem);
begin
  inherited;
  FAutoSelect:= True;
  FColor:= clWindow;

  Timer:= TTimer.Create(nil);
  Timer.Enabled:= False;
  Timer.Interval:= GetCaretBlinkTime;
  Timer.OnTimer:= OnBlinkCaret;
end;

destructor T_AM2000_EditControl.Destroy;
begin
  Timer.Free;
  inherited;
end;


procedure T_AM2000_EditControl.Paint(Params: P_AM2000_PaintMenuItemParams);
  // thanks to Frédéric Schneider for improvements in this routine
var
  X, DX: Integer;
  S: String;
  R1: TRect;
begin
  with Params^, Canvas
  do begin
    LastCanvas:= Canvas;
    DrawBackground(Canvas, State, PaintOptions, mir.LineRect);

    // draw the caption
    if isSelected in State
    then Font.Color:= PaintOptions.Colors.HighlightText
    else Font.Color:= PaintOptions.Colors.MenuText;

    R:= mir.LineRect;

    if (Item.Caption <> '')
{$IFDEF Delphi4OrHigher}
    or not Item.Bitmap.Empty
{$ELSE}
    or (not (Item is TMenuItem2000))
    or (TMenuItem2000(Item).Bitmap.Empty) 
{$ENDIF}
    then begin
      Inc(R.Left, 2);

      if Brush.Style <> bsClear
      then Brush.Style:= bsClear;

      DrawCaption(Canvas, Item.Caption, Params.State, taLeftJustify, R, not (isShowAccelerators in State));

      // draw edit box
      Brush.Style:= bsSolid;

      R.Left:= AmpTextWidth(Canvas, Item.Caption) +5;
      if R.Left < mir.ItemLeft -1 then R.Left:= mir.ItemLeft -2;
    end;

    InflateRect(R, -2, -2);

    if isSelected in State
    then begin
      DrawEdge(Handle, R, bdr_SunkenOuter, bf_Rect);
      InflateRect(R, -1, -1);
    end;

    Brush.Color:= FColor;
    FillRect(R);

    // draw text
    if isSelected in State
    then InflateRect(R, -2, 0)
    else InflateRect(R, -3, 0);

    // draw text
    if FText <> ''
    then begin
      Font.Color:= clWindowText;
      DrawText(Handle, PChar(@FText[FFirstPos +1]), -1, R, dt_VCenter + dt_SingleLine + dt_NoPrefix);
    end;

    // draw selection
    if FSelLength > 0
    then begin
      R1:= R;
      InflateRect(R1, 0, -1);

      // sel start
      if FSelStart > FFirstPos
      then begin
        S:= Copy(FText, FFirstPos +1, FSelStart - FFirstPos);
        Inc(R1.Left, TextWidth(S));
        X:= FSelStart;
        DX:= FSelLength;
      end
      else begin
        X:= FFirstPos;
        DX:= FSelLength - (FFirstPos - FSelStart);
      end;

      S:= Copy(FText, X +1, DX);

      // draw selection
      Brush.Color:= clHighlight;
      Font.Color:= clHighlightText;
      DrawText(Handle, PChar(S), -1, R1, dt_VCenter + dt_SingleLine + dt_NoPrefix);
    end;

    // draw caret
    if (isPressed in State)
    or (isFramed in State)
    then begin
      S:= Copy(FText, FFirstPos +1, FCaretPos - FFirstPos);
      X:= R.Left + TextWidth(S);

      Pen.Style:= psSolid;
      if VisibleCaret
      then Pen.Color:= clWindowText
      else Pen.Color:= FColor;
      PolyLine([Point(X, R.Top +1), Point(X, R.Top + TextHeight('|') +1)]);
    end;

    if isFramed in State
    then begin
      if Brush.Color <> clBlack
      then Brush.Color:= clBlack;

      if Brush.Style <> bsSolid
      then Brush.Style:= bsSolid;

      R1:= mir.LineRect;
      FrameRect(R1);
      InflateRect(R1, -1, -1);
      FrameRect(R1);
    end;
  end;
end;

function T_AM2000_EditControl.GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  Result:= Canvas.TextHeight(Parent.Caption + FText + 'Hp') +8;
end;

function T_AM2000_EditControl.GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
var
  X: Integer;
begin
  X:= AmpTextWidth(Canvas, FText);
  if X < FMinWidth then X:= FMinWidth;
  Result:= AmpTextWidth(Canvas, Parent.Caption) + X +5;
end;


procedure T_AM2000_EditControl.KeyDown(var Key: Word;
  Shift: TShiftState);
  // symbol keys
var
  S: String;
  L: Integer;

  procedure CheckStr(var S: String);
  var
    I: Integer;
  begin
    for I:= 1 to Length(S) do
      if S[I] < #32 then S[I]:= #32;
  end;

begin
  BlockRelease(True);

  // errors
  if ((FCaretPos = 0) and (FSelLength = 0) and ((Key = vk_Left) or (Key = vk_Back) or (Key = vk_Home)))
  or ((FCaretPos = Length(FText)) and (FSelLength = 0) and ((Key = vk_Right) or (Key = vk_Delete) or (Key = vk_End)))
  or (FReadOnly and ((Key = vk_Back) or (Key = vk_Delete)))
  then begin
    MessageBeep(0);
    Key:= 0;
    Exit;
  end;

  // key
  case Key of
    vk_Left:
      begin
        if ssShift in Shift then
          if (FSelStart = FCaretPos) or (FSelLength = 0)
          then begin
            if FCaretPos = 0 then Exit;
            FSelStart:= FCaretPos -1;
            Inc(FSelLength);
          end
          else
            Dec(FSelLength)

        else
          FSelLength:= 0;

        SetCaretPos(FCaretPos -1);
      end;

    vk_Right:
      begin
        // add selection
        if ssShift in Shift then begin
          if FSelLength = 0
          then FSelStart:= FCaretPos;

          if (FSelStart = FCaretPos) and (FSelLength <> 0)
          then begin
            FSelStart:= FCaretPos +1;
            Dec(FSelLength);
          end
          else
            if FCaretPos < Length(FText)
            then Inc(FSelLength);

        end
        else
          FSelLength:= 0;

        SetCaretPos(FCaretPos +1);
      end;

    vk_Back:
      if not ClearSel then begin
        Delete(FText, FCaretPos, 1);
        SetCaretPos(FCaretPos -1);

        if Assigned(FOnChange)
        then FOnChange(Parent, FText);
      end;

    vk_Delete:
      begin
        if ssShift in Shift
        then begin
          // cut and place to clipboard
          CopyToClipboard(Copy(FText, FSelStart +1, FSelLength));
          ClearSel;
          Repaint;
        end
        else
        if ssCtrl in Shift then begin
          // clear selection
          ClearSel;
          Repaint;
        end
        else begin
          if not ClearSel then Delete(FText, FCaretPos +1, 1);
          Repaint;
        end;

        if Assigned(FOnChange)
        then FOnChange(Parent, FText);
      end;

    vk_Home:
      if ssShift in Shift then begin
        if (FSelLength = 0) or (FSelStart >= FCaretPos)
        then Inc(FSelLength, FCaretPos)
        else FSelLength:= FSelStart;

        FSelStart:= 0;
        SetCaretPos(0);
      end
      else
      begin
        FSelLength:= 0;
        SetCaretPos(0);
      end;

    vk_End:
      if ssShift in Shift then begin
        L:= Length(FText);
        if (FSelLength = 0) or (FSelStart < FCaretPos)
        then Inc(FSelLength, L - FCaretPos)
        else begin
          L:= L - FSelStart - FSelLength;
          FSelStart:= FSelStart + FSelLength;
          FSelLength:= L;
        end;

        SetCaretPos(Length(FText));
      end
      else
      begin
        FSelLength:= 0;
        SetCaretPos(Length(FText));
      end;

    vk_Insert:
      if (ssShift in Shift) and IsClipboardFormatAvailable(cf_Text) then begin
        // insert from clipboard
        S:= PasteFromClipboard;
        if S <> '' then begin
          ClearSel;
          CheckStr(S);
          Insert(S, FText, FCaretPos +1);
          SetCaretPos(FCaretPos + Length(S));
        end;
      end
      else
      if ssCtrl in Shift then begin
        // copy to clipboard
        CopyToClipboard(Copy(FText, FSelStart +1, FSelLength));
      end;

    86: // V
      if (ssCtrl in Shift) and IsClipboardFormatAvailable(cf_Text) then begin
        // insert from clipboard
        S:= PasteFromClipboard;
        if S <> ''
        then begin
          ClearSel;
          CheckStr(S);
          Insert(S, FText, FCaretPos +1);
          SetCaretPos(FCaretPos + Length(S));

          if Assigned(FOnChange)
          then FOnChange(Parent, FText);
        end;
      end
      else
        Exit;

    88: // X
      if ssCtrl in Shift
      then begin
        // cut and place to clipboard
        CopyToClipboard(Copy(FText, FSelStart +1, FSelLength));
        ClearSel;
        Repaint;

        if Assigned(FOnChange)
        then FOnChange(Parent, FText);
      end
      else
        Exit;

    67: // C
      if ssCtrl in Shift
      then begin
        CopyToClipboard(Copy(FText, FSelStart +1, FSelLength));
      end
      else
        Exit;

    else
      Exit;
  end;

  Key:= 0;
  VisibleCaret:= True;
  Timer.Enabled:= False;
  Repaint;
  Timer.Enabled:= True;

  BlockRelease(False);
end;

procedure T_AM2000_EditControl.KeyPress(var Key: Char);
  // character keys
begin
  BlockRelease(True);
  Timer.Enabled:= False;

  if FReadOnly
    or ((FMaxLength > 0)
    and (Length(FText) >= FMaxLength))
    or (Key < #32)
  then
    MessageBeep(0)
  else begin
    // clear selection
    if ClearSel
    and (FCaretPos > 0)
    then FCaretPos:= FCaretPos -1;

    // insert key
    Insert(Key, FText, FCaretPos +1);
    SetCaretPos(FCaretPos +1);

    if Assigned(FOnChange)
    then FOnChange(Parent, FText);
  end;

  Key:= #0;
  VisibleCaret:= True;
  Repaint;
  Timer.Enabled:= True;
  BlockRelease(False);
end;

function T_AM2000_EditControl.ClearSel: Boolean;
  // clear selection
begin
  if FSelLength > 0
  then begin
    Delete(FText, FSelStart +1, FSelLength);
    FSelLength:= 0;
    FCaretPos:= FSelStart;
    Result:= True;
  end
  else
    Result:= False;
end;


procedure T_AM2000_EditControl.CheckPos;
var
  W, LW: Integer;
begin
  // correct left bound
  if FCaretPos < 0 then FCaretPos:= 0;
  if FCaretPos <= FFirstPos then FFirstPos:= FCaretPos -6;
  if FFirstPos < 0 then FFirstPos:= 0;

  // correct right bound
  if FCaretPos > Length(FText) then FCaretPos:= Length(FText);

  // correct width
  LW:= R.Right - R.Left;
  if
    (LastCanvas <> nil) and (LW <> 0)
  then
    repeat
      W:= LastCanvas.TextWidth(Copy(FText, FFirstPos +1, FCaretPos - FFirstPos));
      if W > LW then Inc(FFirstPos);
    until W <= LW;
end;

procedure T_AM2000_EditControl.SetCaretPos(const Value: Integer);
begin
  FCaretPos:= Value;
  CheckPos;
  Repaint;
end;

function T_AM2000_EditControl.BeginEdit(X, Y: Integer): Boolean;
var
  I, DX: Integer;
  F: TForm;
begin
  BlockRelease(True);

  Result:= True;
  if Assigned(FOnEditing)
  then FOnEditing(Parent, Result);

  if not Result
  then Exit;

  LastText:= FText;

  // set cursor position
  if
    (LastCanvas <> nil) and (R.Left <> 0)
  then begin
    I:= 0;
    repeat
      Inc(I);
      DX:= LastCanvas.TextWidth(Copy(FText, FFirstPos +1, I));
    until (R.Left + DX > X) or (FFirstPos + I > Length(FText));

    FCaretPos:= FFirstPos + I -1;
  end;

  // init selection
  if FAutoSelect
  then begin
    FSelStart:= 0;
    FSelLength:= Length(FText);
  end;

  // disable popupmenuform
  F:= GetPopupMenuForm(Parent);
  if F <> nil
  then begin
    PostMessage(F.Handle, wm_SetState, ssEnabled, 0);
    PostMessage(F.Handle, wm_SetState, ssFocusItem, LongInt(Parent));
  end;

  // init caret
  VisibleCaret:= True;
  Repaint;
  Timer.Enabled:= True;

  BlockRelease(False);
end;

procedure T_AM2000_EditControl.CancelEdit(AcceptChanges: Boolean);
begin
  BlockRelease(True);

  Timer.Enabled:= False;

  if Assigned(FOnEdited)
  then FOnEdited(Parent, FText, AcceptChanges);

  if not AcceptChanges
  then begin
    FText:= LastText;
    LastText:= '';
  end;
  FSelLength:= 0;
  FFirstPos:= 0;
  Repaint;

  // call parent's OnClick
  if AcceptChanges
  and Assigned(Parent.OnClick)
  and not Assigned(FOnEdited)
  then Parent.OnClick(Parent);

  BlockRelease(False);
end;

procedure T_AM2000_EditControl.OnBlinkCaret(Sender: TObject);
begin
  VisibleCaret:= not VisibleCaret;
  Repaint;
end;

procedure T_AM2000_EditControl.Assign(Source: TPersistent);
var
  S: T_AM2000_EditControl;
begin
  inherited;

  if Source is T_AM2000_EditControl
  then begin
    S:= T_AM2000_EditControl(Source);

    AutoSelect:= S.AutoSelect;
    Color:= S.Color;
    MaxLength:= S.MaxLength;
    ReadOnly:= S.ReadOnly;
    Text:= S.Text;
    MinWidth:= S.MinWidth;
  end;
end;

end.
