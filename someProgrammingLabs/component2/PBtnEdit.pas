{*******************************************************************************

    Version: 1.0
    TPBtnEdit - delphi component, edit control with buttons
    Copyright (C) 2006 Pelesh Yaroslav Vladimirovich
    mailto:yaroslav@pelesh.in.ua
    http://pelesh.in.ua

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

*******************************************************************************}

unit PBtnEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, CommCtrl, JwaTheme, ComObj;

type
  TPBtnEditAlignment = (alLeft, alRight, alCenter);
  TPGlyphType = (gtEllipsis, gtCustom);
  TPCustomBtnEdit = class;

  TPEditButton = class(TCollectionItem)
  private
    FEnabled: boolean;
    FDown: boolean;
    FImageIndex: TImageIndex;
    FCursor: TCursor;
    FHint: string;
    FGlyphType: TPGlyphType;
    FWidth: Integer;
    FOnClick: TNotifyEvent;
    procedure SetDown(Value: boolean);
    procedure SetEnabled(Value: boolean);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetCursor(Value: TCursor);
    procedure SetWidth(Value: Integer);
    procedure SetGlyphType(Value: TPGlyphType);
    function GetParent: TPCustomBtnEdit;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Enabled: boolean read FEnabled write SetEnabled;
    property Down: boolean read FDown write SetDown;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex;
    property Cursor: TCursor read FCursor write SetCursor;
    property Hint: string read FHint write FHint;
    property GlyphType: TPGlyphType read FGlyphType write SetGlyphType;
    property Width: Integer read FWidth write SetWidth;
  end;

  TPEditButtons = class(TCollection)
  private
    FPCustomBtnEdit: TPCustomBtnEdit;
    function GetItem(Index: Integer): TPEditButton;
    procedure SetItem(Index: Integer; Value: TPEditButton);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(PCustomBtnEdit: TPCustomBtnEdit);
    function Add: TPEditButton;
    property Items[Index: Integer]: TPEditButton read GetItem write SetItem; default;
  end;

  TPCustomBtnEdit = class(TEdit)
  private
    FEditButtons: TPEditButtons;
    FTrackingIndex: Integer;
    FTrackingButtonDown: boolean;
    FAlignment: TPBtnEditAlignment;
    FImages: TCustomImageList;
    FImageChangeLink: TChangeLink;
    FThemeHandle: HTHEME;
    FUseThemes: boolean;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure WMCreate(var Message: TMessage); message WM_CREATE;
    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure SetEditButtons(Value: TPEditButtons);
    procedure SetAlignment(Value: TPBtnEditAlignment);
    procedure SetImages(Value: TCustomImageList);
    procedure SetUseThemes(Value: boolean);
    function IsCursorOverButton(CursorPos: TPoint; Index: Integer): boolean; overload;
    function IsCursorOverButton(CursorPos: TPoint): boolean; overload;
    function GetOverButtonIndex(CursorPos: TPoint): Integer;
    function GetButtonRect(Index: Integer): TRect;
    procedure UpdateButton(Index: Integer);
    procedure UpdateButtons;
    procedure TrackButton(CursorPos: TPoint);
    procedure ProcessButtonClick(Index: Integer);
    procedure ImageListChange(Sender: TObject);
    function GetInputRect: TRect;
    function ImageExists(Index: Integer): boolean;
    procedure DrawGlyph(DC: HDC; Rect: TRect; Enabled, Down: boolean; ImgIndex: Integer);
    procedure DrawEllipsis(DC: HDC; Rect: TRect; Enabled, Down: boolean);
    function DrawButton(DC: HDC; Index: Integer): TRect;
    procedure DrawBtnEdge(DC: HDC; Rect: TRect; Enabled, Down: boolean);
    procedure DrawBtnThemeEdge(DC: HDC; Rect: TRect; Enabled, Down: boolean);
    procedure CreateThemeHandle;
    procedure FreeThemeHandle;
    function CanUseThemes: boolean;
  protected
    property EditButtons: TPEditButtons read FEditButtons write SetEditButtons;
    property Alignment: TPBtnEditAlignment read FAlignment write SetAlignment;
    property Images: TCustomImageList read FImages write SetImages;
    property UseThemes: boolean read FUseThemes write SetUseThemes;
    procedure WndProc(var Message: TMessage); override;
    procedure PaintWindow(DC: HDC); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure BoundsChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  end;

  TPBtnEdit = class(TPCustomBtnEdit)
  private
  protected
  public
  published
    property EditButtons;
    property Alignment;
    property Images;
    property UseThemes;
  end;

procedure Register;

implementation

uses
  Clipbrd;

procedure Register;
begin
  RegisterComponents('Pelesh', [TPBtnEdit]);
end;

{ TPEditButton }

constructor TPEditButton.Create(Collection: TCollection);
begin
  inherited;
  FDown := false;
  FEnabled := true;
  FImageIndex := -1;
  FCursor := crDefault;
  FWidth := GetSystemMetrics(SM_CXVSCROLL);
end;

function TPEditButton.GetDisplayName: string;
begin
  Result := 'Button' + IntToStr(Index);
end;

function TPEditButton.GetParent: TPCustomBtnEdit;
begin
  Result := TPCustomBtnEdit(TPEditButtons(Collection).GetOwner);
end;

procedure TPEditButton.SetCursor(Value: TCursor);
var
  BtnEdit: TPCustomBtnEdit;
begin
  if FCursor <> Value then
  begin
    FCursor := Value;
    BtnEdit := GetParent;
    if BtnEdit <> nil then
      BtnEdit.Perform(CM_CURSORCHANGED, 0, 0);
  end;
end;

procedure TPEditButton.SetDown(Value: boolean);
begin
  if Value <> FDown then
  begin
    FDown := Value;
    Changed(false);
  end;
end;

procedure TPEditButton.SetEnabled(Value: boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    Changed(false);
  end;
end;

procedure TPEditButton.SetGlyphType(Value: TPGlyphType);
begin
  if Value <> FGlyphType then
  begin
    FGlyphType := Value;
    Changed(false);
  end;
end;

procedure TPEditButton.SetImageIndex(Value: TImageIndex);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    Changed(false);
  end;
end;

procedure TPEditButton.SetWidth(Value: Integer);
begin
  if Value <> FWidth then
  begin
    FWidth := Value;
    Changed(true);
  end;
end;

{ TPEditButtons }

function TPEditButtons.Add: TPEditButton;
begin
  Result := TPEditButton(inherited Add);
end;

constructor TPEditButtons.Create(PCustomBtnEdit: TPCustomBtnEdit);
begin
  inherited Create(TPEditButton);
  FPCustomBtnEdit := PCustomBtnEdit;
end;

function TPEditButtons.GetItem(Index: Integer): TPEditButton;
begin
  Result := TPEditButton(inherited GetItem(Index));
end;

function TPEditButtons.GetOwner: TPersistent;
begin
  Result := FPCustomBtnEdit;
end;

procedure TPEditButtons.SetItem(Index: Integer; Value: TPEditButton);
begin
  inherited SetItem(Index, Value);
end;

procedure TPEditButtons.Update(Item: TCollectionItem);
begin
  if Item <> nil then
    FPCustomBtnEdit.UpdateButton(Item.Index)
  else
    FPCustomBtnEdit.UpdateButtons;
end;

{ TPCustomBtnEdit }

constructor TPCustomBtnEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditButtons := TPEditButtons.Create(Self);
  FTrackingIndex := -1;
  FTrackingButtonDown := false;
  FAlignment := alLeft;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FThemeHandle := 0;
  FUseThemes := true;
end;

procedure TPCustomBtnEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TPBtnEditAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited;
  Params.Style := Params.Style or ES_MULTILINE or Alignments[FAlignment];
end;

destructor TPCustomBtnEdit.Destroy;
begin
  FEditButtons.Free;
  FImageChangeLink.Free;
  FreeThemeHandle;
  inherited;
end;

function TPCustomBtnEdit.GetButtonRect(Index: Integer): TRect;
var
  i: Integer;
begin
  FillChar(Result, SizeOf(Result), 0);
  if (Index > -1) and (Index < FEditButtons.Count) then
  begin
    Result.Left := Width - 4;
    for i := Index to FEditButtons.Count - 1 do
      Dec(Result.Left, FEditButtons[i].Width);

    Result.Right := Result.Left + FEditButtons[Index].Width;
    Result.Bottom := Height - 4;
  end;
end;

function TPCustomBtnEdit.GetOverButtonIndex(CursorPos: TPoint): Integer;
var
  i: Integer;
begin
  Result := -1;
  if FEditButtons.Count < 1 then
    Exit;

  for i := 0 to FEditButtons.Count - 1 do
    if IsCursorOverButton(CursorPos, i) then
    begin
      Result := i;
      Break;
    end;
end;

function TPCustomBtnEdit.IsCursorOverButton(CursorPos: TPoint; Index: Integer): boolean;
begin
  Result := PtInRect(GetButtonRect(Index), CursorPos);
end;

procedure TPCustomBtnEdit.ImageListChange(Sender: TObject);
begin
  if HandleAllocated and (Sender = FImages) then
    Invalidate;
end;

function TPCustomBtnEdit.IsCursorOverButton(CursorPos: TPoint): boolean;
begin
  Result := GetOverButtonIndex(CursorPos) > -1;
end;

procedure TPCustomBtnEdit.KeyPress(var Key: Char);
begin
  if (Key = #13) or (Key = #10) then
    Key := #0
  else
    inherited;
end;

procedure TPCustomBtnEdit.PaintWindow(DC: HDC);
var
  i: Integer;
  BtnRect: TRect;
begin
  if FEditButtons.Count > 0 then
  begin
    for i := 0 to FEditButtons.Count - 1 do
    begin
      BtnRect := DrawButton(DC, i);
      ExcludeClipRect(DC, BtnRect.Left, BtnRect.Top, BtnRect.Right, BtnRect.Bottom);
    end;
  end;

  inherited;
end;

procedure TPCustomBtnEdit.ProcessButtonClick(Index: Integer);
begin
  if Assigned(FEditButtons[Index].OnClick) then
    FEditButtons[Index].OnClick(Self);
end;

procedure TPCustomBtnEdit.SetAlignment(Value: TPBtnEditAlignment);
begin
  if Value <> FAlignment then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TPCustomBtnEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  BoundsChanged;
end;

procedure TPCustomBtnEdit.SetEditButtons(Value: TPEditButtons);
begin
  FEditButtons.Assign(Value);
end;

procedure TPCustomBtnEdit.SetImages(Value: TCustomImageList);
begin
  if FImages <> nil then
    FImages.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end;
  Invalidate;
end;

procedure TPCustomBtnEdit.TrackButton(CursorPos: TPoint);
var
  OldState: boolean;
begin
  OldState := FTrackingButtonDown;
  FTrackingButtonDown := IsCursorOverButton(CursorPos, FTrackingIndex){ or
    FEditButtons[FTrackingIndex].Down};
  if FTrackingButtonDown <> OldState then
    UpdateButton(FTrackingIndex);
end;

procedure TPCustomBtnEdit.UpdateButton(Index: Integer);
var
  BtnRect: TRect;
begin
  if (Index > -1) and (Index < FEditButtons.Count) then
  begin
    BtnRect := GetButtonRect(Index);
    InvalidateRect(Handle, @BtnRect, false);
  end;
end;

procedure TPCustomBtnEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  CursorPos: TPoint;
begin
  CursorPos := Point(Message.XPos, Message.YPos);
  if not IsCursorOverButton(CursorPos) then
    inherited;
end;

procedure TPCustomBtnEdit.WMLButtonDown(var Message: TWMLButtonDown);
var
  CursorPos: TPoint;
  BtnIndex: Integer;
begin
  CursorPos := Point(Message.XPos, Message.YPos);
  BtnIndex := GetOverButtonIndex(CursorPos);
  if BtnIndex > -1 then
  begin
    MouseCapture := true;
    FTrackingIndex := BtnIndex;
    TrackButton(CursorPos);
  end
  else
    inherited;
end;

procedure TPCustomBtnEdit.WMLButtonUp(var Message: TWMLButtonUp);
begin
  if FTrackingIndex > -1 then
  begin
    MouseCapture := false;
    TrackButton(Point(-1, -1));
    if IsCursorOverButton(Point(Message.XPos, Message.YPos), FTrackingIndex) then
      ProcessButtonClick(FTrackingIndex);
    FTrackingIndex := -1;
    FTrackingButtonDown := false;
  end
  else
    inherited;

end;

procedure TPCustomBtnEdit.WMMouseMove(var Message: TWMMouseMove);
begin
  if FTrackingIndex > -1 then
    TrackButton(Point(Message.XPos, Message.YPos))
  else
    inherited;
end;

procedure TPCustomBtnEdit.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TPCustomBtnEdit.WMRButtonDown(var Message: TWMRButtonDown);
begin
  if not IsCursorOverButton(Point(Message.XPos, Message.YPos)) then
    inherited;
end;

procedure TPCustomBtnEdit.WMSetCursor(var Message: TWMSetCursor);
var
  CursorPos: TPoint;
  BtnIndex: Integer;
  Curs: TCursor;
begin
  GetCursorPos(CursorPos);
  CursorPos := ScreenToClient(CursorPos);
  BtnIndex := GetOverButtonIndex(CursorPos);
  if BtnIndex > -1 then
  begin
    if (csDesigning in ComponentState) then
      Curs := crArrow
    else
    begin
      if (FEditButtons[BtnIndex].FCursor = crDefault) or
        not FEditButtons[BtnIndex].Enabled then
      begin
        if Assigned(Parent) then
          Curs := Parent.Cursor
        else
          Curs := crArrow;
      end
      else
        Curs := FEditButtons[BtnIndex].FCursor;
    end;

    Windows.SetCursor(Screen.Cursors[Curs]);
    Message.Result := 1;
  end
  else
    inherited;
end;

procedure TPCustomBtnEdit.WndProc(var Message: TMessage);
var
  BtnIndex: Integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    case Message.Msg of
      WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_LBUTTONDBLCLK, WM_RBUTTONDBLCLK:
      begin
        BtnIndex := GetOverButtonIndex(Point(Message.LParamLo, Message.LParamHi));
        if BtnIndex > -1 then
        begin
          if Message.Msg = WM_LBUTTONDBLCLK then
            Message.Msg := WM_LBUTTONDOWN;
          if FEditButtons[BtnIndex].Enabled then
            inherited;
        end
        else
          inherited;

      end;
    else
      inherited;
    end;

  end
  else
    inherited;
end;

procedure TPCustomBtnEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FImages) then
  begin
    FImages := nil;
    Invalidate;
  end;
end;

procedure TPCustomBtnEdit.CMHintShow(var Message: TCMHintShow);
var
  BtnIndex: Integer;
begin
  inherited;
  if Message.Result = 0 then
  begin
    BtnIndex := GetOverButtonIndex(Message.HintInfo^.CursorPos);
    if BtnIndex > -1 then
    begin
      Message.HintInfo^.HintStr := FEditButtons[BtnIndex].Hint;
      Message.HintInfo^.CursorRect := GetButtonRect(BtnIndex);
    end
    else
      Message.HintInfo^.CursorRect := GetInputRect;
  end;
end;

function TPCustomBtnEdit.GetInputRect: TRect;
var
  i: Integer;
begin
  SetRect(Result, 0, 0, Width, Height);
  if FEditButtons.Count > 0 then
  begin
    Dec(Result.Right, 4);
    for i := 0 to FEditButtons.Count - 1 do
      Dec(Result.Right, FEditButtons[i].Width);
  end;
end;

procedure TPCustomBtnEdit.WMPaste(var Message: TMessage);
var
  TextToPaste: string;
  BreakPos: Integer;
begin
  {if clipboard has text with breaks then emulate pasting of
   only first line as this do simple edit control}

  TextToPaste := Clipboard.AsText; //if not CF_TEXT then epmty string
  BreakPos := Pos(#13#10, TextToPaste);

  if BreakPos > 0 then
  begin
    if BreakPos > 1 then //BreakPos > 1 becouse we don`t need paste empty string
    begin
      TextToPaste := Copy(TextToPaste, 1, BreakPos - 1);
      SetSelTextBuf(PChar(TextToPaste));
    end;
  end
  else
    inherited;
end;

procedure TPCustomBtnEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TPCustomBtnEdit.UpdateButtons;
begin
  BoundsChanged;
  Invalidate;
end;

procedure TPCustomBtnEdit.BoundsChanged;
var
  InputRect: TRect;
begin
  if HandleAllocated then
  begin
    InputRect := GetInputRect;
    SendMessage(Handle, EM_SETRECTNP, 0, Cardinal(@InputRect));
    SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  end;
end;

function TPCustomBtnEdit.DrawButton(DC: HDC; Index: Integer): TRect;
var
  DrawDown, DrawEnabled: boolean;
begin
  Result := GetButtonRect(Index);

  DrawDown := ((Index = FTrackingIndex) and FTrackingButtonDown)
    or FEditButtons[Index].Down;
  DrawEnabled := FEditButtons[Index].Enabled and Self.Enabled;

  if CanUseThemes then
    DrawBtnThemeEdge(DC, Result, DrawEnabled, DrawDown)
  else
    DrawBtnEdge(DC, Result, DrawEnabled, DrawDown);

  case FEditButtons[Index].GlyphType of
    gtCustom:
      DrawGlyph(DC, Result, DrawEnabled, DrawDown, FEditButtons[Index].ImageIndex);
    gtEllipsis:
      DrawEllipsis(DC, Result, DrawEnabled, DrawDown);
  end;
end;

procedure TPCustomBtnEdit.CreateThemeHandle;
begin
  FThemeHandle := 0;
  if IsThemesAPIAvailable then
    FThemeHandle := OpenThemeData(Handle, StringToLPOLESTR('Button'));
end;

procedure TPCustomBtnEdit.FreeThemeHandle;
begin
  if FThemeHandle <> 0 then
  begin
    CloseThemeData(FThemeHandle);
    FThemeHandle := 0;
  end;
end;

function TPCustomBtnEdit.ImageExists(Index: Integer): boolean;
begin
  Result := Assigned(FImages) and (Index > -1) and (Index < FImages.Count);
end;

procedure TPCustomBtnEdit.DrawGlyph(DC: HDC; Rect: TRect; Enabled,
  Down: boolean; ImgIndex: Integer);
var
  Canvas: TCanvas;
  GlyphX, GlyphY: Integer;
begin
  if ImageExists(ImgIndex) then
  begin
    GlyphX := Rect.Left + (Rect.Right - Rect.Left - FImages.Width) div 2;
    GlyphY := Rect.Top + (Rect.Bottom - Rect.Top - FImages.Height) div 2;
    if Down then
    begin
      Inc(GlyphX);
      Inc(GlyphY);
    end;

    Canvas := TCanvas.Create;
    try
      Canvas.Handle := DC;
      FImages.Draw(Canvas, GlyphX, GlyphY, ImgIndex, Enabled);
    finally
      Canvas.Free;
    end;
  end;
end;

procedure TPCustomBtnEdit.WMThemeChanged(var Message: TMessage);
begin
  RecreateWnd;
  Message.Result := 1;
end;

procedure TPCustomBtnEdit.SetUseThemes(Value: boolean);
begin
  if FUseThemes <> Value then
  begin
    FUseThemes := Value;
    if IsThemesAPIAvailable and HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TPCustomBtnEdit.WMCreate(var Message: TMessage);
begin
  inherited;
  if FUseThemes then
    CreateThemeHandle;
end;

procedure TPCustomBtnEdit.WMDestroy(var Message: TMessage);
begin
  FreeThemeHandle;
  inherited;
end;

function TPCustomBtnEdit.CanUseThemes: boolean;
begin
  Result := FUseThemes and (FThemeHandle <> 0);
end;

procedure TPCustomBtnEdit.DrawEllipsis(DC: HDC; Rect: TRect; Enabled, Down: boolean);
const
  EnabledWidth: array [boolean] of Integer = (11, 10);
  EnabledHeight: array [boolean] of Integer = (3, 2);
var
  EX, EY: Integer;

  procedure Ellipsis(X, Y, BrushColor: Integer);
  var
    SaveBrush: HBRUSH;
  begin
    SaveBrush := SelectObject(DC, GetSysColorBrush(BrushColor));
    PatBlt(DC, X, Y, 2, 2, PATCOPY);
    PatBlt(DC, X + 4, Y, 2, 2, PATCOPY);
    PatBlt(DC, X + 8, Y, 2, 2, PATCOPY);
    SelectObject(DC, SaveBrush);
  end;

begin
  EX := Rect.Left + (Rect.Right - Rect.Left - EnabledWidth[Enabled]) div 2;
  EY := Rect.Top + (Rect.Bottom - Rect.Top - EnabledHeight[Enabled]) div 2;

  if Down then
  begin
    Inc(EX);
    Inc(EY);
  end;

  if Enabled then
  begin
    Ellipsis(EX, EY, COLOR_BTNTEXT);
  end
  else
  begin
    Ellipsis(EX + 1, EY + 1, COLOR_BTNHILIGHT);
    Ellipsis(EX, EY, COLOR_BTNSHADOW);
  end;
end;

procedure TPCustomBtnEdit.DrawBtnEdge(DC: HDC; Rect: TRect; Enabled,
  Down: boolean);
const
  StateEdge: array [boolean] of UINT = (EDGE_RAISED, EDGE_SUNKEN);
begin
  DrawEdge(DC, Rect, StateEdge[Down], BF_RECT or BF_MIDDLE);
end;

procedure TPCustomBtnEdit.DrawBtnThemeEdge(DC: HDC; Rect: TRect; Enabled,
  Down: boolean);
const
  StateEdge: array [boolean] of UINT = (PBS_NORMAL, PBS_PRESSED);
var
  DrawState: Cardinal;
begin
  if not Enabled then
    DrawState := PBS_DISABLED
  else
    DrawState := StateEdge[Down];

  if IsThemeBackgroundPartiallyTransparent(FThemeHandle, BP_PUSHBUTTON, DrawState) then
    DrawThemeParentBackground(Handle, DC, @Rect);
  DrawThemeBackground(FThemeHandle, DC, BP_PUSHBUTTON, DrawState, Rect, nil);
end;

end.
