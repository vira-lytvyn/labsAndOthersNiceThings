
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       TCustomPopupMenu2000 and TPopupMenu200Form      }
{                                                       }
{       Copyright (c) 1997-2002 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit am2000popupmenu;

{$I am2000.inc}

interface

uses
  {$IFDEF ACTIVEX}ActiveX, ComServ, AxCtrls, AnimatedMenusXP_tlb, {$ENDIF}
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  Windows, Messages, SysUtils, Graphics, StdCtrls, ExtCtrls,
  Forms, Dialogs, Buttons, ComCtrls, Menus,
  am2000options, am2000menuitem, am2000utils,
  Classes, Controls;


type
  // popup menu
  TCustomPopupMenu2000 = class(T_AM2000_PopupMenu, ISkin
    {$IFDEF ACTIVEX}, IMenu, IPopupMenu{$ENDIF})
  private
    FEMI2000         : TEditableMenuItem2000; // layer for compatibility with Delphi and your apps
    FSBPanelNo       : Integer;
    FStatusBar       : TStatusBar;
    FOnMenuCommand   : TNotifyEvent;
    FOnMenuClose     : T_AM2000_MenuCloseEvent;
    FFont            : TFont;
{$IFDEF ActiveX}
    FFontAdapter     : T_AM2000_FontAdapter;
{$ENDIF}
    FParentFont      : Boolean;
    FParentShowHint  : Boolean;
    FShowHint        : Boolean;
    FSystemFont      : Boolean;
    FOnCloseQuery    : TCloseQueryEvent;
    FOptions         : T_AM2000_MenuOptions;
    FCtl3D           : Boolean;
    FSystemCtl3D     : Boolean;
    FSystemShadow    : Boolean;
    FSystemSelectionFade : Boolean;
    PopupX           : Integer;
    PopupY           : Integer;
    FComponentItem          : TMenuItem2000;
    FComponentItems         : TList;
    FComponentItemsParent   : TMenuItem;
    FComponentItemsMenuIndex: Integer;
    FOnContextMenu   : TNotifyEvent;
    FForm            : TForm;
    FAnimatedSkin    : T_AM2000_AnimatedSkin;
    FDisabledImages  : TCustomImageList;
    FHotImages       : TCustomImageList;

{$IFNDEF Delphi4OrHigher}
    FImages          : TCustomImageList;
    FBiDiMode        : TBiDiMode;
{$ENDIF}

    function ISkin.Title = GetTitle;
    function ISkin.Colors = GetColors;
    function ISkin.Margins = GetMargins;
    function ISkin.Skin = GetSkin;
    function ISkin.Opacity = GetOpacity;
    function ISkin.Ctl3D = GetCtl3D;
    function ISkin.Animation = GetAnimation;
    function ISkin.Flags = GetFlags;
    function ISkin.Font = GetFont;
    function ISkin.SystemFont = GetSystemFont;
    function ISkin.ParentFont = GetParentFont;
    function ISkin.SystemCtl3D = GetSystemCtl3D;
    function ISkin.SystemShadow = GetSystemShadow;
    function ISkin.SystemSelectionFade = GetSystemSelectionFade;
    function ISkin.Images = GetImages;
    function ISkin.DisabledImages = GetDisabledImages;
    function ISkin.HotImages = GetHotImages;

    function IsFontStored: Boolean;
    function IsShowHintStored: Boolean;
    function GetMenuItem2000: TMenuItem2000;
    procedure SetFont(Value: TFont);
    procedure SetParentFont(Value: Boolean);
    procedure SetShowHint(Value: Boolean);
    procedure SetParentShowHint(Value: Boolean);
    procedure SetSystemFont(Value: Boolean);
    procedure SetOptions(Value: T_AM2000_MenuOptions);
    procedure SetVersion(Value: T_AM2000_Version);
    function GetVersion: T_AM2000_Version;
    function GetOptions: T_AM2000_MenuOptions;
    procedure SetAnimatedSkin(const Value: T_AM2000_AnimatedSkin);
    function GetFont: TFont;
    procedure SetCtl3D(const Value: Boolean);
    function IsCtl3DStored: Boolean;
    function GetSelected: TMenuItem;
    procedure SetSelected(const Value: TMenuItem);

    function HasColors: Boolean;
    function HasTitle: Boolean;
    function HasMargins: Boolean;
    function HasSkin: Boolean;
    function GetTitle: T_AM2000_Title;
    function GetColors: T_AM2000_Colors;
    function GetMargins: T_AM2000_Margins;
    function GetSkin: T_AM2000_Skin;
    function GetOpacity: T_AM2000_Opacity;
    function GetCtl3D: Boolean;
    function GetAnimation: T_AM2000_Animation;
    function GetFlags: T_AM2000_Flags;
    function GetSystemFont: Boolean;
    function GetParentFont: Boolean;
    function GetSystemCtl3D: Boolean;
    function GetSystemShadow: Boolean;
    function GetSystemSelectionFade: Boolean;
    function GetImages: TCustomImageList;
    function GetDisabledImages: TCustomImageList;
    function GetHotImages: TCustomImageList;

{$IFDEF ACTIVEX}
    // activex support
    function Get_Items: IMenuItem; safecall;
    function Get_Name: WideString; safecall;

    function  Get_ShowHint: WordBool; safecall;
    procedure Set_ShowHint(Value: WordBool); safecall;
    function  Get_Options: IMenuOptions; safecall;
    function  Get_Font: IFont; safecall;
    function  Get_SystemFont: WordBool; safecall;
    procedure Set_SystemFont(Value: WordBool); safecall;
    function  Get_Ctl3D: WordBool; safecall;
    procedure Set_Ctl3D(Value: WordBool); safecall;
    function  Get_SystemCtl3D: WordBool; safecall;
    procedure Set_SystemCtl3D(Value: WordBool); safecall;
    function  Get_ParentFont: WordBool; safecall;
    procedure Set_ParentFont(Value: WordBool); safecall;
    function  Get_SystemShadow: WordBool; safecall;
    procedure Set_SystemShadow(Value: WordBool); safecall;
    function  Get_SystemSelectionFade: WordBool; safecall;
    procedure Set_SystemSelectionFade(Value: WordBool); safecall;
{$ENDIF}

  protected
    function GetForm: TForm; virtual;
    procedure AssignMenuItems(var DestItems: TMenuItem; var DestHandle: HMenu); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;

    procedure DoCloseQuery(Sender: TObject; var CanClose: Boolean); dynamic;

    function GetComponentItemsCaption: String; virtual;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); virtual;
    procedure UpdateComponentItems(Items: TMenuItem2000); virtual;

  public
    ComponentLoaded  : Boolean;
    MenuItems        : TMenuItem;
    MenuHandle       : HMenu;
    ParentSkin       : ISkin;
    AttachedTo       : TMenuItem2000;

    property StatusBar       : TStatusBar
      read FStatusBar write FStatusBar;
    property StatusBarIndex  : Integer
      read FSBPanelNo write FSBPanelNo default 0;
    property ShowHint        : Boolean
      read FShowHint write SetShowHint stored IsShowHintStored;
    property Options         : T_AM2000_MenuOptions
      read GetOptions write SetOptions;
    property Font            : TFont
      read GetFont write SetFont stored IsFontStored;
    property SystemFont      : Boolean
      read FSystemFont write SetSystemFont default True;
    property Ctl3D           : Boolean
      read FCtl3D write SetCtl3D stored IsCtl3DStored;
    property SystemCtl3D     : Boolean
      read FSystemCtl3D write FSystemCtl3D default False;
    property SystemShadow    : Boolean
      read FSystemShadow write FSystemShadow default False;
    property SystemSelectionFade : Boolean
      read FSystemSelectionFade write FSystemSelectionFade default True;
    property ParentShowHint  : Boolean
      read FParentShowHint write SetParentShowHint default True;
    property ParentFont      : Boolean
      read FParentFont write SetParentFont default False;
    property AnimatedSkin    : T_AM2000_AnimatedSkin
      read FAnimatedSkin write SetAnimatedSkin;

    property Items2000       : TMenuItem2000
      read GetMenuItem2000;

    property OnMenuCommand   : TNotifyEvent
      read FOnMenuCommand write FOnMenuCommand;
    property OnMenuClose     : T_AM2000_MenuCloseEvent
      read FOnMenuClose write FOnMenuClose;
    property OnCloseQuery    : TCloseQueryEvent
      read FOnCloseQuery write FOnCloseQuery;
    property OnContextMenu   : TNotifyEvent
      read FOnContextMenu write FOnContextMenu;

{$IFNDEF Delphi4OrHigher}
    property Images : TCustomImageList
      read FImages write FImages;

    property BiDiMode: TBiDiMode
      read FBiDiMode write FBiDiMode;
{$ENDIF}

    property DisabledImages: TCustomImageList
      read FDisabledImages write FDisabledImages;
    property HotImages : TCustomImageList
      read FHotImages write FHotImages;

    property Form: TForm
      read GetForm;

    property Selected: TMenuItem
      read GetSelected write SetSelected;

    property Version: T_AM2000_Version
      read GetVersion write SetVersion stored False;

      
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;                     override;
    procedure Assign(Source: TPersistent);  override;

    procedure Popup(X, Y: Integer);         override;
    procedure PopupAsync(X, Y: Integer);    virtual;
    function FormOnScreen: Boolean;
    function GetTopMostForm: TForm;
    function GetFormAtPos(const P: TPoint): TForm;
    procedure PrepareForPopup(AddEmpty: Boolean); virtual;
    procedure UpdateFromOptions;

    function FindItem(Value: Word; Kind: TFindItemKind): TMenuItem2000;
    function GetISkin: ISkin;

    function IsShortCut(var Msg: TWMKey): Boolean;
{$IFDEF Delphi4OrHigher}
    override;
{$ENDIF}

    procedure Refresh;
    procedure Repaint;
    procedure DoLoaded;
    procedure ResetSkin;

  published
{$IFDEF DesignTime}
    property Items       : TEditableMenuItem2000
      read FEMI2000;
{$ELSE}
    property Items       : TMenuItem2000
      read GetMenuItem2000;
{$ENDIF}

  end;


  // template
  TCustomPopupMenu2000Form = class(TForm)
  end;

function GetPopupMenuForm(Item: TMenuItem): TForm;

function CreateFloatingMenuForm(
  const AOwner: TComponent;
  const AItems: TMenuItem;
  const AOptions: T_AM2000_Options;
  const APopupMenu: TCustomPopupMenu2000;
  const ALeft, ATop: Integer): TForm;

implementation
uses
{$IFDEF Delphi4OrHigher} MultiMon, {$ENDIF}
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  CommCtrl, MmSystem, ShellApi,
  am2000menubar, am2000mainmenu, am2000hintwindow, am2000cache,
  am2000dropshadow, am2000desktop, am2000dragwindow, am2000skin, am2000theme;

const
  COLOR_GRADIENTACTIVECAPTION = 27;
  COLOR_GRADIENTINACTIVECAPTION = 28;

  clGradientActiveCaption = TColor(COLOR_GRADIENTACTIVECAPTION or $80000000);
  clGradientInactiveCaption = TColor(COLOR_GRADIENTINACTIVECAPTION or $80000000);

  FormsCount: Integer = 0;

type
  T_AM2000_PMF = (fsSelectedChanged, fsMouseChanged, fsPaintMenu, fsFromBottomToTop,
    fsFromRightToLeft, fsDrawDisabled, fsIgnoreMouseMove, fsBecomingDraggable, fsAnimated,
    fsKillAnimate, fsDisabled, fsCtl3d, fsShowHidden, fsHiddenArrow, fsHiddenAsRegular,
    fsNoDrawCanvas, fsScrollBars, fsFraming, fsIgnoreNextMouseUp, fsIgnoreNextMenuUp, fsDesigning,
    fsShowAccelerators, fsClicked, fsAllowFreeMem, fsHotTrack, fsPreview, fsMenuPopulated, fsIgnoreAnimation,
    fsReleaseAfterHide, fsNewUnhide, fsSibling, fsFamily);

  T_AM2000_PMFState = set of T_AM2000_PMF;

{$IFNDEF Delphi4OrHigher}
  TWMMouseWheel = packed record
    Msg: Cardinal;
    Keys: SmallInt;
    WheelDelta: SmallInt;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint);
      1: (
        Pos: TSmallPoint;
        Result: Longint);
  end;
{$ENDIF}

  TDelta = ShortInt;

  TDeltaArray = array [0..1024*1024] of TDelta; // array of delta bits
  PDeltaArray = ^TDeltaArray;


  T_AM2000_Bits = class
  private
    FSource, FDestination, FBackground: PByteArray;
    FDelta: PDeltaArray;
    FBitmap, FDestBitmap: HBitmap;
    FBitsSize, FBytesPerLine: {$IFDEF Delphi4OrHigher}Cardinal{$ELSE}Integer{$ENDIF};
    FDestDC: HDC;
    FDestOld: HGdiObj;
    bm: Windows.TBitmap;

    function GetBackground: PByteArray;
    function GetDeltaArray: PDeltaArray;
    function GetDestination: PByteArray;

  public
    BitmapInfo: TBitmapInfo;

    destructor Destroy; override;
    procedure SetSourceBitmap(const ABitmap: HBitmap; const ABits: Pointer);

    procedure Clear;
    procedure ClearAll;
    procedure SetDestinationBitsToCanvas(const DC: HDC;
      const DestX, DestY, Width, Height, SrcX, SrcY: Integer);
    procedure MoveBackgroundToDestination;
    procedure GetBackgroundBits(const ABitmap: HBitmap; const ABits: Pointer);

    property Source: PByteArray read FSource;
    property Destination: PByteArray read GetDestination;
    property Background: PByteArray read GetBackground;
    property Delta: PDeltaArray read GetDeltaArray;

    property BytesPerLine: {$IFDEF Delphi4OrHigher}Cardinal{$ELSE}Integer{$ENDIF}
      read FBytesPerLine;
    property BitsSize: {$IFDEF Delphi4OrHigher}Cardinal{$ELSE}Integer{$ENDIF}
      read FBitsSize;

  end;

  TPopupMenu2000Form = class(TCustomPopupMenu2000Form)
  private
    OpacityBits, AnimationBits, UnhideBits: T_AM2000_Bits;

    Buffer, Back, TempBuffer: TBitmap;
    BufferBits, TempBufferBits: Pointer;
    FSelectedIndex, LastSelectedIndex, ItemWidth, ShortcutWidth,
      ItemHeight, DX, DY, ParentMenuIndex, CurHiddenCount, CurStep,
      FirstVisibleIndex, LastVisibleIndex, FWheelAccumulator,
      RealWidth, RealHeight, LastRealHeight,
      TimeStart: Integer;

    Animation, SaveAnimation: T_AM2000_Animation;

    PopupSkin: ISkin;
    PopupMenu: TCustomPopupMenu2000;
    SubMenuForm, ParentMenuForm: TPopupMenu2000Form;
    MenuHandle: HMenu;
    Options: T_AM2000_MenuOptions;
    MouseState: T_AM2000_MouseState;

    State: T_AM2000_PMFState;
    ToolTipWindow: T_AM2000_ToolTipWindow;

    // items rects
    FiLeft, FiWidth: Integer;
    ItemRects: TList;
    FocusItem: TMenuItem;

    DropShadow: T_AM2000_DropShadow;
    ScrollDelta: Double;
    CurRect, ScrollRect, ScrollUpRect, ScrollDownRect, ScrollBoxRect, LastCursorRect: TRect;
    LastScrollBoxPos: TPoint;
    MouseCaptureControl: TControl;

    Ole2ObjectWindow: HWnd;

    procedure InitializeMenuState;

    procedure wmKeyDown(var Msg: TWMKeyDown);      message wm_KeyDown;
    procedure wmSysKeyDown(var Msg: TWMKeyDown);   message wm_SysKeyDown;
    procedure wmChar(var Msg: TWMChar);            message wm_Char;

    procedure cmMouseEnter(var Msg: TMessage);     message cm_MouseEnter;
    procedure cmMouseLeave(var Msg: TMessage);     message cm_MouseLeave;
    procedure wmSetFocus(var Msg: TWMSetFocus);    message wm_SetFocus;
    procedure wmActivate(var Msg: TWMActivate);    message wm_Activate;
    procedure wmMouseActivate(var Msg: TWMMouseActivate); message wm_MouseActivate;
    procedure cmShowingChanged(var Msg: TMessage); message cm_ShowingChanged;
    procedure wmEraseBkgnd(var Msg: TWMEraseBkgnd); message wm_EraseBkgnd;

    procedure wmShowAnimated(var Msg: TMessage);   message wm_ShowAnimated;
    procedure wmSilentHide(var Msg: TMessage);     message wm_SilentHide;
    procedure wmKillAnimation(var Msg: TMessage);  message wm_KillAnimation;
    procedure wmKillTimer(var Msg: TMessage);      message wm_KillTimer;
    procedure wmUnhide(var Msg: TMessage);         message wm_Unhide;

    procedure wmSetState(var Msg: TMessage);       message wm_SetState;
    procedure wmPaintOnCanvas(var Msg: TMessage);  message wm_PaintOnCanvas;
    procedure wmSetMenuItem(var Msg: TMessage);    message wm_SetMenuItem;
    procedure wmMouseWheel(var Msg: TWMMouseWheel);message wm_MouseWheel;
    procedure wmGetForm(var Msg: TMessage);        message wm_GetForm;
    procedure wmGetState(var Msg: TMessage);       message wm_GetState;

    procedure PostMenuSelectMessage;

    // utilities
    procedure SetSelectedIndex(Value: Integer);
    procedure OnPopupTimer(Sender: TObject);
    procedure SearchActiveMenuForShortcut(var Msg: TWMKey);
    procedure DestroySubMenuForm;
    procedure CreateSubMenuForm(Menu: TPopupMenu; Handle: HMenu; Items: TMenuItem);
    procedure RebuildToolTipWindow(Recreate: Boolean);
    procedure OnHotTrack(Sender: TObject);
    procedure SetSelected(const AItem: TMenuItem);

    // bounds management
    procedure RebuildBounds;
    function GetItemRect(Index: Integer): TRect;
    function GetMenuItemHeight(const M: TMenuItem): Integer;
    function GetMenuItemHeightIndex(Index: Integer): Integer;
    function GetRealHeight: Integer; virtual;
    function GetRealWidth: Integer;  virtual;
    function GetRealLeft: Integer; virtual;
    function GetRealTop: Integer; virtual;
    procedure GetOptions(Items: TMenuItem; Menu: TCustomPopupMenu2000; var Options: T_AM2000_MenuOptions);
    procedure OnUnhideTimer(Sender: TObject);
    procedure AnimatedHide;
    function GetLastVisibleIndex: Integer;
    function GetMenuItemByIndex(const Index: Integer; const Items: TMenuItem): TMenuItem;
    function GetIndexByMenuItem(const Item: TMenuItem): Integer;
    procedure CheckOrigin(const CurAnim: T_AM2000_Animation; var NewLeft, NewTop, NewWidth, NewHeight: Integer);

    // painting
    procedure InitializePaintParams;
    procedure PaintBevelAndBorder(const Bounds: TRect);
    procedure PaintFrame3D;
    procedure PaintBackground;
    procedure PaintBackgroundPart(Y: Integer);
    procedure PaintDragPane;
    procedure PaintHiddenArrow;
    procedure PaintScrollBars;
    procedure PaintBufferOnCanvas(const DC: HDC; const ReGetDiBits: Boolean);
    procedure DoClick(const MI: TMenuItem; const SelectFirst: Boolean);
    procedure DoClickWin32(mii: TMenuItemInfo);
    function GetFirstVisibleIndex: Integer;
    function GetDropShadow: Boolean;
    function GetHighestForm: TPopupMenu2000Form;
    function GetLowestForm: TPopupMenu2000Form;
    function GetPopupPoint(const ASelectedIndex: Integer): TPoint;

  protected
    procedure Paint; override;

    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DblClick; override;

{$IFDEF Delphi4OrHigher}
    procedure DoClose(var Action: TCloseAction); override;
{$ENDIF}

    procedure CreateParams(var Params: TCreateParams); override;

  public
    CurMenuItem, MenuItems: TMenuItem;

    property SelectedIndex: Integer read FSelectedIndex write SetSelectedIndex;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Animate: Boolean; virtual;
    procedure SilentShow;
    procedure SilentHide;
    procedure Repaint; override;

    procedure PopupSubMenuForm(SelectFirst: Boolean);
    function GetCurMenuItem: TMenuItem;
    function GetMenuItemIndex(const Index: Integer): TMenuItem;

    // bounds management
    function GetIndexAt(X, Y: Integer): Integer;
    procedure OnScrollTimer(Sender: TObject);

    procedure Refresh;
    procedure Update; override;

  end;


{$IFDEF Delphi6OrHigher}
  {$ALIGN 8}
{$ELSE}
  {$ALIGN ON}
{$ENDIF}

  
  // forgot about this
  TFalseMenu = class(TComponent)
  private
{$IFDEF Delphi4OrHigher}
    FBiDiMode: TBiDiMode;
{$ENDIF}
    FItems: TMenuItem;
  end;


var
  MenuOpacityData: P_AM2000_OpacityData;
  MenuOpacity: T_AM2000_Opacity;

{ GetPopupMenuForm }

function GetPopupMenuForm(Item: TMenuItem): TForm;
var
  M: TMenu;
  MB: TCustomMenuBar2000;
{$IFNDEF Delphi4OrHigher}
  MI: TMenuItem;
{$ENDIF}
begin
  Result:= nil;

  if Item is TMenuItem2000
  then M:= TMenuItem2000(Item).GetMenu
  else
{$IFDEF Delphi4OrHigher}
    M:= Item.GetParentMenu;
{$ELSE}
  begin
    MI:= Item;
    while MI.Parent <> nil
    do MI:= MI.Parent;
    M:= TMenu(MI.Owner);
  end;
{$ENDIF}

  if M is TCustomPopupMenu2000
  then
    Result:= TCustomPopupMenu2000(M).Form
  else
  if M is TCustomMainMenu2000
  then begin
    MB:= GetMenuBarFromMenu(M);
    if MB <> nil
    then Result:= MB.MenuComponent.Form;
  end;

  if Result = nil
  then Exit;

  while (Result <> nil)
  and (TPopupMenu2000Form(Result).MenuItems <> Item.Parent)
  do Result:= TPopupMenu2000Form(Result).SubMenuForm;
end;

procedure CallMenuMsgFilter(AWindow: HWND; AMessage, wParam, lParam: UINT);
var
  Msg: TMsg;
begin
  Msg.hwnd:= AWindow;
  Msg.Message:= AMessage;
  Msg.wParam:= wParam;
  Msg.lParam:= lParam;
  CallMsgFilter(Msg, MSGF_MENU);
end;

procedure CallMenuMsgFilterPt(AWindow: HWND; AMessage, wParam, lParam: UINT;
  pt: TPoint);
var
  Msg: TMsg;
begin
  Msg.hwnd:= AWindow;
  Msg.Message:= AMessage;
  Msg.wParam:= wParam;
  Msg.lParam:= lParam;
  Msg.pt:= pt;
  CallMsgFilter(Msg, MSGF_MENU);
end;

procedure DoMouseMove(F: TForm; Shift: TShiftState; X, Y: Integer);
begin
  TCustomPopupMenu2000Form(F).MouseMove(Shift, X, Y);
end;

function CreateFloatingMenuForm;
var
  I: Integer;
  F: TPopupMenu2000Form;
begin
  // hide previous floating menu
  for I:= 0 to FloatingMenusList.Count -1
  do
    with TPopupMenu2000Form(FloatingMenusList[I])
    do
      if MenuItems = AItems
      then begin
        FloatingMenusList.Delete(I);
        Close;
        Break;
      end;

  F:= TPopupMenu2000Form.Create(AOwner);

  // Draggable pane clicked!
  if AOptions.Caption <> ''
  then F.Caption:= AOptions.Caption
  else
  if GetCaption(AItems) <> ''
  then F.Caption:= StripAmpersands(GetCaption(AItems))
  else F.Caption:= 'Animated Menus';

  // set window properties
  F.MenuItems:= AItems;
  F.MenuHandle:= AItems.Handle;
  F.PopupMenu:= APopupMenu;
  F.Options:= T_AM2000_MenuOptions.Create(AItems);
  F.Options.Assign(AOptions);
  
  F.InitializeMenuState;
  F.BorderStyle:= bsToolWindow;
  F.Animation:= anHSlide;

  Include(F.State, fsBecomingDraggable);
  Include(F.State, fsShowHidden);
  Include(F.State, fsHiddenAsRegular);
  Include(F.State, fsPaintMenu);

  // rebuild bounds
  F.RebuildBounds;

  F.RealWidth:= F.GetRealWidth;
  F.RealHeight:= F.GetRealHeight;

  F.SetBounds(ALeft, ATop, F.RealWidth, F.RealHeight);

  with F.ClientRect
  do
    F.SetBounds(ALeft, ATop,
      F.Width - Right + F.RealWidth, F.Height - Bottom + F.RealHeight +2);


  F.Buffer.Handle:= CreateDibSectionEx(F.Buffer.Canvas.Handle, F.RealWidth, F.RealHeight, nil);
  F.LastVisibleIndex:= F.GetLastVisibleIndex;

  // paint menu
  F.Paint;

  SendMessage(F.Handle, WM_SysCommand, $F012, 0);  // system message

  // tooltip window
  F.RebuildToolTipWindow(True);

  Exclude(F.State, fsBecomingDraggable);
  FloatingMenusList.Add(F);
  Result:= F;
end;



{ T_AM2000_Bits }

destructor T_AM2000_Bits.Destroy;
begin
  ClearAll;
  inherited;
end;

procedure T_AM2000_Bits.Clear;
begin
  FSource:= nil;
  FreeMemAndNil(FDelta);

  if FDestination <> nil
  then begin
    SelectObject(FDestDC, FDestOld);
    DeleteObject(FDestBitmap);
    DeleteDC(FDestDC);
    FDestination:= nil;
  end;
end;

procedure T_AM2000_Bits.ClearAll;
begin
  Clear;
  FreeMemAndNil(FBackground);
end;

function T_AM2000_Bits.GetBackground: PByteArray;
begin
  if FBackground = nil
  then raise Exception.Create('Background data not set.');

  Result:= FBackground;
end;

function T_AM2000_Bits.GetDeltaArray: PDeltaArray;
begin
  if FDelta = nil
  then ReGetMem(FDelta, FBitsSize * SizeOf(TDelta));

  Result:= FDelta;
end;

function T_AM2000_Bits.GetDestination: PByteArray;
begin
  if FDestination = nil
  then begin
    FDestDC:= CreateCompatibleDC(0);
    FDestBitmap:= CreateDibSectionEx(FDestDC, bm.bmWidth, bm.bmHeight, @FDestination);
    FDestOld:= SelectObject(FDestDC, FDestBitmap);
  end;

  Result:= FDestination;
end;

procedure T_AM2000_Bits.GetBackgroundBits(const ABitmap: HBitmap; const ABits: Pointer);
var
  InfoHeaderSize, ImageSize: {$IFDEF Delphi4OrHigher}Cardinal{$ELSE}Integer{$ENDIF};
begin
  GetDibSizes(ABitmap, InfoHeaderSize, ImageSize);
  if FBitsSize < ImageSize
  then FBitsSize:= ImageSize;

  ReGetMem(FBackground, FBitsSize);
  Move(ABits^, FBackground^, ImageSize);
end;

procedure T_AM2000_Bits.SetSourceBitmap(const ABitmap: HBitmap; const ABits: Pointer);
var
  InfoHeaderSize: {$IFDEF Delphi4OrHigher}Cardinal{$ELSE}Integer{$ENDIF};
begin
  if FBitmap <> ABitmap
  then FBitmap:= ABitmap;

  Clear;
  FSource:= ABits;
  GetDibSizes(FBitmap, InfoHeaderSize, FBitsSize);
  GetObject(FBitmap, SizeOf(bm), @bm);

  if bm.bmHeight <> 0
  then FBytesPerLine:= FBitsSize div bm.bmHeight
  else FBytesPerLine:= 0;
end;

procedure T_AM2000_Bits.SetDestinationBitsToCanvas(const DC: HDC;
  const DestX, DestY, Width, Height, SrcX, SrcY: Integer);
begin
  BitBlt(DC, DestX, DestY, Width, Height, FDestDC, SrcX, bm.bmHeight - Height, SrcCopy);
end;

procedure T_AM2000_Bits.MoveBackgroundToDestination;
begin
  Move(FBackground^, Destination^, FBitsSize);
  FreeMemAndNil(FBackground);
end;



{ TCustomPopupMenu2000 }

constructor TCustomPopupMenu2000.Create(AOwner: TComponent);
begin
  inherited;

  FParentFont:= False;
  FSystemFont:= True;
  FParentShowHint:= True;
  FSystemSelectionFade:= True;
  FCtl3D:= True;

  // we don't need TMenuItem so we just destoy it
  // and create TMenuItem2000 instead of.
  TFalseMenu(Self).FItems.Free;
  TFalseMenu(Self).FItems:= TMenuItem2000.Create(Self);
{$IFDEF Delphi4OrHigher}
  TFalseMenu(Self).FBiDiMode:= bdLeftToRight;
{$ENDIF}
{$IFDEF DesignTime}
  FEMI2000:= TEditableMenuItem2000.Create(Self);
{$ENDIF}

  FOptions:= T_AM2000_MenuOptions.Create(Self);

  if (csDesigning in ComponentState)
  and (GetComponentItemsCaption <> '')
  then begin
    FComponentItem:= NewItem2000('::::' + GetComponentItemsCaption, '', False, False, nil, 0, '');
    Items.Add(FComponentItem);
  end;

  if not (csDesigning in ComponentState)
  and ((AOwner = nil)
  or not (csDesigning in AOwner.ComponentState))
  then InstallWindowsHooks;
end;

destructor TCustomPopupMenu2000.Destroy;
var
  I: Integer;
begin
  ParentSkin:= nil;
  RemoveWindowsHooks;

 // hide previous floating menu
{  if (FloatingMenusList <> nil)
  and (FForm <> nil)
  then begin
    I:= FloatingMenusList.IndexOf(FForm);


    for I:= 0 to FloatingMenusList.Count -1
    do
      with TPopupMenu2000Form(FloatingMenusList[I])
      do
        if PopupMenu = Self
        then begin
          FloatingMenusList.Delete(I);
          Close;
          Break;
        end;
  end;}

  if (FForm <> nil)
  and (Owner = nil)
  then FForm.Free;

  FFont.Free;
  FOptions.Free;
  FComponentItems.Free;
{$IFDEF ActiveX}
  FFontAdapter.Free;
{$ENDIF}
{$IFDEF DesignTime}
  FEMI2000.Free;
{$ENDIF}

  if MenuDesigner <> nil
  then MenuDesigner.Perform(wm_Close, 0, 0);

  if FAnimatedSkin <> nil
  then begin
    FAnimatedSkin.Remove(Self);
    FAnimatedSkin:= nil;
  end;
  
  inherited;
end;

procedure TCustomPopupMenu2000.Popup(X, Y: Integer);
begin
  PopupAsync(X, Y);

  while (not (csDestroying in ComponentState))
  and FormOnScreen
  do begin
    ProcessMessages;
    Sleep(20);
  end;

  if ActivePopupMenu = Self
  then ActivePopupMenu:= nil;

  Desktop.Clear;
end;

procedure TCustomPopupMenu2000.PopupAsync(X, Y: Integer);
var
  I: Integer;
begin
  KillActivePopupMenu2000(False, False);

  // event
  if Assigned(OnPopup)
  then OnPopup(Self);

  // init items
  PrepareForPopup(True);

  with TPopupMenu2000Form(Form)
  do begin
    ParentMenuForm:= nil;
    AssignMenuItems(MenuItems, MenuHandle);

    // remove hidden items
    if not (PopupComponent is TCustomMenuBar2000)
    then Perform(wm_SetState, ssHidden, 0);

    {if not (fsPreview in State)
    then }ActivePopupMenu:= Self;

    // set animation options
    if (MenuItems <> nil)
    and (MenuItems is TMenuItem2000)
    and TMenuItem2000(MenuItems).HasOptions
    then
      with T_AM2000_Options(TMenuItem2000(MenuItems).Options)
      do TPopupMenu2000Form(Form).Animation:= Animation

    else
      Animation:= FOptions.Animation;

    Include(State, fsSelectedChanged);

    // show menu
    if (not IsWindowEnabled(Handle))
    then EnableWindow(Handle, True);

    PopupX:= X;
    PopupY:= Y;
    SetBounds(X, Y, 0, 0);

    // animation
    try
      if Animate then Exit;
    except
    end;

    SilentHide;
    if ActivePopupMenu = Self
    then ActivePopupMenu:= nil;
  end;
end;

procedure TCustomPopupMenu2000.AssignMenuItems(var DestItems: TMenuItem; var DestHandle: HMenu);
  // assigns menu items to TCustomPopupMenu2000Form
begin
  if MenuItems <> nil
  then DestItems:= Self.MenuItems
  else DestItems:= Self.Items2000;

  if MenuHandle <> 0
  then DestHandle:= Self.MenuHandle
  else DestHandle:= DestItems.Handle;
end;

function TCustomPopupMenu2000.FormOnScreen: Boolean;
begin
  Result:= (FForm <> nil)
    and (FForm.Height > 0)
    and (FForm.Width > 0)
    and (FForm.BorderStyle = bsNone);
end;

function TCustomPopupMenu2000.GetTopMostForm: TForm;
begin
  Result:= TPopupMenu2000Form(Form).GetLowestForm;
end;

function TCustomPopupMenu2000.GetFormAtPos(const P: TPoint): TForm;
var
  F: TPopupMenu2000Form;
begin
  F:= TPopupMenu2000Form(Form);
  while (F <> nil) and not PtInRect(F.BoundsRect, P)
  do F:= F.SubMenuForm;
  Result:= F;
end;

function TCustomPopupMenu2000.IsFontStored: Boolean;
begin
  Result:= not (FParentFont or FSystemFont);
end;

function TCustomPopupMenu2000.IsShowHintStored: Boolean;
begin
  Result:= not FParentShowHint;
end;

function TCustomPopupMenu2000.GetMenuItem2000: TMenuItem2000;
begin
  Result:= TMenuItem2000(inherited Items);
end;

function TCustomPopupMenu2000.GetFont: TFont;
begin
  if FFont = nil
  then FFont:= TFont.Create;

  Result:= FFont;
end;

procedure TCustomPopupMenu2000.SetFont(Value: TFont);
begin
  if Value <> nil
  then Font.Assign(Value)
  else begin
    FFont.Free;
    FFont:= nil;
  end;
end;

procedure TCustomPopupMenu2000.SetParentFont(Value: Boolean);
begin
  FParentFont:= Value;
  if Value
  then begin
    FSystemFont:= False;
    SetFont(nil);
  end;
end;

procedure TCustomPopupMenu2000.SetSystemFont(Value: Boolean);
begin
  FSystemFont:= Value;
  if Value
  then begin
    FParentFont:= False;
    SetFont(nil);
  end;
end;

procedure TCustomPopupMenu2000.SetShowHint(Value: Boolean);
begin
  if FShowHint <> Value then begin
    FShowHint:= Value;
    FParentShowHint:= False;
  end;
end;

procedure TCustomPopupMenu2000.SetParentShowHint(Value: Boolean);
begin
  if FParentShowHint <> Value then
    FParentShowHint:= Value;

  if FParentShowHint then
    if Owner is TControl
    then FShowHint:= TControl(Owner).ShowHint
    else FShowHint:= False;

end;

procedure TCustomPopupMenu2000.SetOptions(Value: T_AM2000_MenuOptions);
begin
  FOptions.Assign(Value);
end;

procedure TCustomPopupMenu2000.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove)
  then begin
{$IFNDEF Delphi4OrHigher}
    if (AComponent = FImages) then FImages:= nil;
{$ENDIF}
    if (AComponent = FStatusBar) then FStatusBar:= nil;
    if (AComponent = FAnimatedSkin) then SetAnimatedSkin(nil);
    if (AComponent = AttachedTo) then AttachedTo:= nil;
  end;
end;

procedure TCustomPopupMenu2000.PrepareForPopup(AddEmpty: Boolean);
var
  I: Integer;
  MI, MI2: TMenuItem2000;
begin
  if not ComponentLoaded
  then Loaded;

  if (FComponentItems <> nil)
  then begin
    // create basic item
    MI:= TMenuItem2000.Create(Owner);

    // create/update component items
    if FComponentItems.Count = 0
    then begin
      for I:= 0 to FComponentItems.Count -1
      do TMenuItem2000(FComponentItems[I]).Free;

      CreateComponentItems(MI, AddEmpty);
      
    end
    else begin
      for I:= 0 to FComponentItems.Count -1
      do begin
        MI2:= TMenuItem2000(FComponentItems[I]);
        MI2.Parent.Delete(MI2.MenuIndex);
        MI.Add(MI2);
      end;

      UpdateComponentItems(MI);
    end;

    // clear
    FComponentItems.Clear;

    // copy component items
    for I:= 0 to MI.Count -1
    do begin
      FComponentItems.Add(MI[0]);
      MI2:= MI[0];
      MI.Delete(0);
      FComponentItemsParent.Insert(FComponentItemsMenuIndex + I, MI2);
    end;
    
    // free basic menu item
    MI.Free;
  end;

  if (AddEmpty)
  and (Items.Count = 0)
  and (MenuItems = nil)
  and (MenuHandle = 0)
  then Items.Add(NewItem(SEmptyCaption, 0, False, False, nil, 0, ''));
end;

function TCustomPopupMenu2000.IsShortCut(var Msg: TWMKey): Boolean;
begin
  Result:= IsShortCutEx(Msg, Items2000, csDesigning in ComponentState);
end;

function TCustomPopupMenu2000.FindItem(Value: Word; Kind: TFindItemKind): TMenuItem2000;
begin
  Result:= TMenuItem2000(inherited FindItem(Value, Kind));
end;

procedure TCustomPopupMenu2000.Loaded;
var
  MI: TMenuItem2000;

  function FindItemByCaption(Items: TMenuItem2000; Caption: String): TMenuItem2000;
  var
    I: Integer;
  begin
    Result:= nil;

    for I:= 0 to Items.Count -1
    do begin
      if (Items[I].Caption = Caption)
      and (Items[I] <> FComponentItem)
      then begin
        Result:= Items[I];
        Exit;
      end;

      if Items[I].Count > 0
      then begin
        Result:= FindItemByCaption(Items[I], Caption);
        if Result <> nil
        then Exit;
      end;
    end;
  end;

begin
  inherited;

  if (GetComponentItemsCaption <> '')
  then begin
    MI:= FindItemByCaption(Items2000, '::::' + GetComponentItemsCaption);

    if (csDesigning in ComponentState)
    then begin
      // remove component item
      if MI <> nil
      then FComponentItem.Free;
    end
    else begin
      // remove component item
      if MI <> nil
      then begin
        FComponentItemsParent:= MI.Parent;
        FComponentItemsMenuIndex:= MI.MenuIndex;
      end
      else begin
        FComponentItemsParent:= Items2000;
        FComponentItemsMenuIndex:= 0;
      end;

      FComponentItems:= TList.Create;

      MI.Free;
    end;
  end;

  LoadMenu(Self);

  ComponentLoaded:= True;
end;

procedure TCustomPopupMenu2000.SetVersion(Value: T_AM2000_Version);
begin
end;

procedure TCustomPopupMenu2000.DoCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FOnCloseQuery)
  then FOnCloseQuery(Sender, CanClose);
end;

function TCustomPopupMenu2000.GetComponentItemsCaption: String;
begin
  Result:= '';
end;

procedure TCustomPopupMenu2000.CreateComponentItems(Items: TMenuItem2000;
  AddEmpty: Boolean);
begin
  if (AddEmpty)
  and (GetCount(Items) = 0)
  then Items.Add(NewItem(SEmptyCaption, 0, False, False, nil, 0, ''));
end;

procedure TCustomPopupMenu2000.UpdateComponentItems(Items: TMenuItem2000);
begin
end;

function TCustomPopupMenu2000.GetForm: TForm;
begin
  if FForm = nil
  then begin
    FForm:= TPopupMenu2000Form.Create(nil);
    TPopupMenu2000Form(FForm).PopupMenu:= Self;
  end;

  Result:= FForm;
end;

procedure TCustomPopupMenu2000.Refresh;
begin
  if (not ((csLoading in ComponentState)
  or (csDestroying in ComponentState)))
  and FormOnScreen
  then TPopupMenu2000Form(Form).Refresh;
end;

procedure TCustomPopupMenu2000.Repaint;
begin
  if (not ((csLoading in ComponentState)
  or (csDestroying in ComponentState)))
  and FormOnScreen
  then TPopupMenu2000Form(Form).Repaint;
end;

function TCustomPopupMenu2000.GetVersion: T_AM2000_Version;
begin
  Result:= SVersion;
end;

function TCustomPopupMenu2000.GetOptions: T_AM2000_MenuOptions;
begin
  Result:= FOptions;

  if ComponentState * [csLoading, csReading, csDesigning] = []
  then SoftenColors(FOptions.Colors, mfSoftColors in FOptions.Flags);
end;

procedure TCustomPopupMenu2000.SetAnimatedSkin(
  const Value: T_AM2000_AnimatedSkin);
var
  TempSkin: TCustomAnimatedSkin2000;
begin
  if (FAnimatedSkin = Value)
  then Exit;

  if (FAnimatedSkin <> nil)
  then FAnimatedSkin.Remove(Self);

  FAnimatedSkin:= Value;

  if (FAnimatedSkin <> nil)
  then
    FAnimatedSkin.AssignTo(Self)

  else
    with TCustomAnimatedSkin2000.Create(nil)
    do begin
      AssignTo(Self);
      Free;
    end;
end;

procedure TCustomPopupMenu2000.UpdateFromOptions;
begin
  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  then Exit;

  Refresh;
end;

procedure TCustomPopupMenu2000.DoLoaded;
begin
  Loaded;
end;

function TCustomPopupMenu2000.HasColors: Boolean;
begin
  Result:= Options.HasColors;
end;

function TCustomPopupMenu2000.HasTitle: Boolean;
begin
  Result:= Options.HasTitle;
end;

function TCustomPopupMenu2000.HasMargins: Boolean;
begin
  Result:= Options.HasMargins;
end;

function TCustomPopupMenu2000.HasSkin: Boolean;
begin
  Result:= Options.HasSkin;
end;

function TCustomPopupMenu2000.GetTitle: T_AM2000_Title;
begin
  Result:= Options.Title;
end;

function TCustomPopupMenu2000.GetColors: T_AM2000_Colors;
begin
  Result:= Options.Colors;
end;

function TCustomPopupMenu2000.GetMargins: T_AM2000_Margins;
begin
  Result:= Options.Margins;
end;

function TCustomPopupMenu2000.GetSkin: T_AM2000_Skin;
begin
  Result:= Options.Skin;
end;

function TCustomPopupMenu2000.GetAnimation: T_AM2000_Animation;
begin
  Result:= Options.Animation;
end;

function TCustomPopupMenu2000.GetCtl3D: Boolean;
begin
  Result:= FCtl3D;
end;

function TCustomPopupMenu2000.GetFlags: T_AM2000_Flags;
begin
  Result:= Options.Flags;
end;

function TCustomPopupMenu2000.GetOpacity: T_AM2000_Opacity;
begin
  Result:= Options.Opacity;
end;

function TCustomPopupMenu2000.GetParentFont: Boolean;
begin
  Result:= FParentFont;
end;

function TCustomPopupMenu2000.GetSystemCtl3D: Boolean;
begin
  Result:= FSystemCtl3D;
end;

function TCustomPopupMenu2000.GetSystemFont: Boolean;
begin
  Result:= FSystemFont;
end;

function TCustomPopupMenu2000.GetSystemSelectionFade: Boolean;
begin
  Result:= FSystemSelectionFade;
end;

function TCustomPopupMenu2000.GetSystemShadow: Boolean;
begin
  Result:= FSystemShadow;
end;

function TCustomPopupMenu2000.GetImages: TCustomImageList;
begin
  Result:= Images;
end;

function TCustomPopupMenu2000.GetDisabledImages: TCustomImageList;
begin
  Result:= FDisabledImages;
end;

function TCustomPopupMenu2000.GetHotImages: TCustomImageList;
begin
  Result:= FHotImages;
end;

function TCustomPopupMenu2000.GetISkin: ISkin;
begin
  if AnimatedSkin = nil
  then Result:= ISkin(Self)
  else Result:= AnimatedSkin.GetISkin;
end;





{$IFDEF ACTIVEX}
function TCustomPopupMenu2000.Get_Items: IMenuItem;
begin
  Result:= Items2000 as IMenuItem;
end;

function TCustomPopupMenu2000.Get_Name: WideString;
begin
  Result:= Name;
end;

function TCustomPopupMenu2000.Get_Ctl3D: WordBool;
begin
  Result:= FCtl3D;
end;

function TCustomPopupMenu2000.Get_Font: IFont;
begin
  if FFontAdapter = nil
  then FFontAdapter:= T_AM2000_FontAdapter.Create(Font);

  Result:= FFontAdapter;
end;

function TCustomPopupMenu2000.Get_Options: IMenuOptions;
begin
  Result:= Options;
end;

function TCustomPopupMenu2000.Get_ShowHint: WordBool;
begin
  Result:= FShowHint;
end;

function TCustomPopupMenu2000.Get_SystemFont: WordBool;
begin
  Result:= FSystemFont;
end;

function TCustomPopupMenu2000.Get_ParentFont: WordBool;
begin
  Result:= FParentFont;
end;

function TCustomPopupMenu2000.Get_SystemCtl3D: WordBool;
begin
  Result:= FSystemCtl3D;
end;

function TCustomPopupMenu2000.Get_SystemSelectionFade: WordBool;
begin
  Result:= SystemSelectionFade;
end;

function TCustomPopupMenu2000.Get_SystemShadow: WordBool;
begin
  Result:= SystemShadow;
end;

procedure TCustomPopupMenu2000.Set_Ctl3D(Value: WordBool);
begin
  Ctl3D:= Value;
end;

procedure TCustomPopupMenu2000.Set_ShowHint(Value: WordBool);
begin
  ShowHint:= Value;
end;

procedure TCustomPopupMenu2000.Set_SystemFont(Value: WordBool);
begin
  SystemFont:= Value;
end;

procedure TCustomPopupMenu2000.Set_ParentFont(Value: WordBool);
begin
  ParentFont:= Value;
end;

procedure TCustomPopupMenu2000.Set_SystemCtl3D(Value: WordBool);
begin
  SystemCtl3D:= Value;
end;

procedure TCustomPopupMenu2000.Set_SystemSelectionFade(Value: WordBool);
begin
  SystemSelectionFade:= Value;
end;

procedure TCustomPopupMenu2000.Set_SystemShadow(Value: WordBool);
begin
  SystemShadow:= Value;
end;
{$ENDIF}


procedure TCustomPopupMenu2000.Assign(Source: TPersistent);
begin
  if Source is TMenu
  then begin
    CopyMenuProperties(TMenu(Source), Self);
    Items.Assign(TMenu(Source).Items);

    if Source is TPopupMenu
    then
      with TPopupMenu(Source)
      do begin
        Self.Alignment:= Alignment;
        Self.AutoPopup:= AutoPopup;
{$IFDEF Delphi4OrHigher}
        Self.TrackButton:= TrackButton;
{$ENDIF}        
      end;

    if Source is TCustomPopupMenu2000
    then
      with TCustomPopupMenu2000(Source)
      do begin
        Self.ComponentLoaded:= ComponentLoaded;
        Self.StatusBar:= StatusBar;
        Self.StatusBarIndex:= StatusBarIndex;
        Self.ShowHint:= ShowHint;
        Self.Options.Assign(Options);
        Self.Font:= Font;
        Self.SystemFont:= SystemFont;
        Self.FCtl3D:= Ctl3D;
        Self.FSystemCtl3D:= SystemCtl3D;
        Self.FSystemShadow:= SystemShadow;
        Self.FSystemSelectionFade:= SystemSelectionFade;
        Self.Images:= Images;
        Self.DisabledImages:= DisabledImages;
        Self.HotImages:= HotImages;
        Self.ParentShowHint:= ParentShowHint;
        Self.ParentFont:= ParentFont;
        Self.AnimatedSkin:= AnimatedSkin;
        Self.OnMenuCommand:= OnMenuCommand;
        Self.OnMenuClose:= OnMenuClose;
        Self.OnCloseQuery:= OnCloseQuery;
        Self.OnContextMenu:= OnContextMenu;
      end;
  end
  else
    inherited;
end;

procedure TCustomPopupMenu2000.SetCtl3D(const Value: Boolean);
begin
  FSystemCtl3D:= False;
  FCtl3D:= Value;
end;

function TCustomPopupMenu2000.IsCtl3DStored: Boolean;
begin
  Result:= not FSystemCtl3D;
end;

procedure TCustomPopupMenu2000.ResetSkin;
begin
  AnimatedSkin:= nil;
end;

function TCustomPopupMenu2000.GetSelected: TMenuItem;
begin
  with TPopupMenu2000Form(Form)
  do
    if FSelectedIndex <> -1
    then Result:= GetMenuItemIndex(FSelectedIndex)
    else Result:= GetMenuItemIndex(LastSelectedIndex);
end;

procedure TCustomPopupMenu2000.SetSelected(const Value: TMenuItem);
var
  P: TPoint;
begin
  if not FormOnScreen
  then begin
    P:= Point(0, 0);

    if Owner is TControl
    then P:= TControl(Owner).ClientToScreen(P);

    PopupAsync(P.X, P.Y);
  end;
  
  TPopupMenu2000Form(Form).SetSelected(Value);
end;



{ TPopupMenu2000Form }

constructor TPopupMenu2000Form.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner {$IFDEF CBuilder1}, 0{$ENDIF});

  // own initializaton
  ControlStyle:= ControlStyle - [csCaptureMouse];
  FSelectedIndex:= itNothing;
  CurHiddenCount:= 0;
  LastSelectedIndex:= itNothing;
  Animation:=  anVSlide;
  BorderStyle:= bsNone;
  FormStyle:= fsStayOnTop;
  Position:= poDesigned;

  Buffer:= TBitmap.Create;
{$IFDEF Delphi3OrHigher}
  Buffer.PixelFormat:= pf24bit;
{$ENDIF}
  Buffer.Canvas.Font.Assign(Font);

  Back:= TBitmap.Create;
{$IFDEF Delphi3OrHigher}
  Back.PixelFormat:= pf24bit;
{$ENDIF}

  ItemRects:= TList.Create;

  SetBounds(0, 0, 0, 0);
end;

procedure TPopupMenu2000Form.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle:= Params.ExStyle or WS_EX_TOOLWINDOW;
  Params.WindowClass.style:= Params.WindowClass.style or CS_SAVEBITS;
end;

destructor TPopupMenu2000Form.Destroy;
begin
  PopupSkin:= nil;
  MenuItems:= nil;

  Back.Free; Back:= nil;
  Buffer.Free; Buffer:= nil;
  TempBuffer.Free; TempBuffer:= nil;
  Options.Free;
  ItemRects.Free;
  DropShadow.Free;

  // free bits
  OpacityBits.Free;
  AnimationBits.Free;
  UnhideBits.Free;

  ToolTipWindow.Free;

  // this checking is necessary when submenu going to be killed
  // by MainForm (Owner property), not by ParenTCustomPopupMenu2000
  if (ParentMenuForm <> nil)
  and (ParentMenuForm.SubMenuForm = Self)
  then ParentMenuForm.SubMenuForm:= nil;

  if (SubMenuForm <> nil)
  then begin
    SubMenuForm.Release;
    SubMenuForm:= nil;
  end;

  if (ParentMenuForm = nil)
  and (PopupMenu <> nil)
  and (PopupMenu.FForm = Self)
  then PopupMenu.FForm:= nil;

  if FloatingMenusList <> nil
  then FloatingMenusList.Remove(Self);

  inherited Destroy;
end;


{ Properties }

function TPopupMenu2000Form.GetRealHeight: Integer;
begin
  Result:= GetItemRect(ItemRects.Count -1).Bottom +
    Options.Margins.Border +
    Options.Margins.Bevel +
    Options.Margins.BevelInner;

  // options
  with Options
  do begin
    if HasSkin
    and (Skin.BackgroundLayout = blExpandMenu)
    and (Result < Skin.Background.Height)
    then Result:= Skin.Background.Height;

    if HasTitle
    and Title.Visible
    and (Title.Position = atBottom)
    then Inc(Result, Title.Width);
  end;


  // hidden arrow
  if fsHiddenArrow in State
  then Inc(Result, iHiddenButtonHeight +6);

  // ctl3d
  if (BorderStyle = bsNone)
  and (fsCtl3d in State)
  then Inc(Result, 2);
  
end;

function TPopupMenu2000Form.GetRealWidth: Integer;
begin
  with Options.Margins
  do Result:= FiWidth + (Border + Bevel + BevelInner + Frame) *2;

  // options
  with Options
  do begin
    if HasSkin
    and (Skin.BackgroundLayout = blExpandMenu)
    and (Result < Skin.Background.Width)
    then Result:= Skin.Background.Width;

    if HasTitle
    and Title.Visible
    and (Title.Position in [atLeft, atRight])
    then Inc(Result, Title.Width);
  end;

  // ctl3d
  if (BorderStyle = bsNone)
  and (fsCtl3d in State)
  then Inc(Result, 4);

  // scrollbars
  if (fsScrollbars in State)
  and (Integer(NonClientMetrics.iScrollWidth) <> 0)
  then Inc(Result, Integer(NonClientMetrics.iScrollWidth) + iScrollBarOffset);

end;

function TPopupMenu2000Form.GetRealLeft: Integer;
  // thanks to Rolf Moser for correction of this routine
  // thanks to Milan Tomic for helping in another correction
var
  DesktopRight: Integer;
begin
{$IFDEF Delphi4OrHigher}
  DesktopRight:= Screen.DesktopLeft + Screen.DesktopWidth;
{$ELSE}
  DesktopRight:= Screen.Width;
{$ENDIF}

  if Left + RealWidth > DesktopRight
  then begin
    Result:= DesktopRight - RealWidth;

    if fsFromRightToLeft in State
    then Dec(Result, (DesktopRight - Left - Width));
  end
  else begin
    Result:= Left;

    if fsFromRightToLeft in State
    then Dec(Result, (RealWidth - Width));
  end;
end;

function TPopupMenu2000Form.GetRealTop: Integer;
  // thanks to Rolf Moser for correction of this routine
  // thanks to Milan Tomic for helping in another correction
var
  DesktopBottom: Integer;
begin
{$IFDEF Delphi4OrHigher}
  DesktopBottom:= Screen.DesktopTop + Screen.DesktopHeight;
{$ELSE}
  DesktopBottom:= Screen.Height;
{$ENDIF}

  if Top + RealHeight > DesktopBottom
  then begin
    Result:= DesktopBottom - RealHeight;

    if fsFromBottomToTop in State
    then Dec(Result, (DesktopBottom - Top - Height));
  end
  else begin
    Result:= Top;

    if fsFromBottomToTop in State
    then Dec(Result, (RealHeight - Height));
  end;
end;

function TPopupMenu2000Form.GetIndexAt(X, Y: Integer): Integer;
var
  I, H, B: Integer;
  P: TPoint;
begin
  P:= Point(X, Y);
  if (BorderStyle = bsNone)
  then begin
    B:= Options.Margins.Bevel + Options.Margins.BevelInner;

    if (fsCtl3D in State)
    then Inc(B, 2);
  end
  
  else
    B:= 0;

  H:= Options.Margins.Border + B;

  Result:= itNothing;
  if (MenuHandle = 0)
  or (Y <= H)
  then Exit;

  // is title visible?
  if Options.HasTitle then
    with Options.Title do
      if Visible
      and (((Position = atLeft) and (X <= Width))
      or   ((Position = atRight) and (X >= Buffer.Width - Width))
      or   ((Position = atTop) and (Y <= Width))
      or   ((Position = atBottom) and (Y >= Buffer.Height - Width)))
      then Exit;
      

  // is menu draggable?
  if (Options.Draggable)
  and (BorderStyle = bsNone)
  and (Y <= iDraggablePaneHeight +4)
  then begin
    Result:= itDragPane;
    Exit;
  end;


  // hidden arrow?
  if (fsHiddenArrow in State)
  and PtInRect(Rect(0, Buffer.Height - B - iHiddenButtonHeight, Buffer.Width,
    Buffer.Height - B), P)
  then begin
    Result:= itHiddenArrow;
    Exit;
  end;

  // check scrollbars
  if (fsScrollBars in State)
  then begin
    if PtInRect(ScrollUpRect, P)
    then Result:= itScrollUp
    else
    if PtInRect(ScrollDownRect, P)
    then Result:= itScrollDown
    else
    if PtInRect(ScrollBoxRect, P)
    then Result:= itScrollBox
    else
    if PtInRect(Rect(ScrollRect.Left, ScrollUpRect.Bottom, ScrollRect.Right, ScrollBoxRect.Top), P)
    then Result:= itScrollPageUp
    else
    if PtInRect(Rect(ScrollRect.Left, ScrollBoxRect.Bottom, ScrollRect.Right, ScrollDownRect.Top), P)
    then Result:= itScrollPageDown;

    if (Result <> itNothing)
    or (P.X > ScrollRect.Left -2)
    then Exit;
  end;

  // count all menu items
  if (FirstVisibleIndex > 0)
  then Inc(P.Y, GetItemRect(FirstVisibleIndex).Top - B);

  // add framing
  if (fsFraming in State)
  then Inc(P.Y, ItemHeight div 2);

  for I:= FirstVisibleIndex to ItemRects.Count -1
  do
    if PointInRect(GetItemRect(I), P)
    then begin
      Result:= I;
      Exit;
    end;
end;

function TPopupMenu2000Form.GetLastVisibleIndex: Integer;
var
  H: Integer;
begin
  H:= RealHeight;

  if (BorderStyle = bsNone)
  then
    if (fsCtl3D in State)
    then Dec(H, 2*Options.Margins.Border +4)
    else Dec(H, 2*Options.Margins.Border);

  if (FirstVisibleIndex > 0)
  then Inc(H, GetItemRect(FirstVisibleIndex).Top);

  Dec(H, 10);

  Result:= FirstVisibleIndex +1;
  while (Result < ItemRects.Count)
  and (GetItemRect(Result).Bottom < H)
  do Inc(Result);
end;

function TPopupMenu2000Form.GetFirstVisibleIndex: Integer;
var
  H, B: Integer;
begin
  B:= GetItemRect(LastVisibleIndex).Bottom;
  H:= RealHeight;

  if (BorderStyle = bsNone)
  then
    if (fsCtl3D in State)
    then Dec(H, 2*Options.Margins.Border +4)
    else Dec(H, 2*Options.Margins.Border);

  Dec(H, 10);

  Result:= LastVisibleIndex -1;
  while (Result > 0)
  and (B - GetItemRect(Result).Top < H)
  do Dec(Result);
end;

procedure TPopupMenu2000Form.SetSelectedIndex(Value: Integer);
var
  Direction: Integer;
  M: TMenuItem;
begin
  if (Value <> SelectedIndex)
  then begin

    if Value > FSelectedIndex
    then Direction:= 1
    else Direction:= -1;

    LastSelectedIndex:= FSelectedIndex;
    FSelectedIndex:= Value;
    Include(State, fsSelectedChanged);

    if MenuHandle = 0 then Exit;

    mii.fMask:= miim_Type + miim_State;
    repeat
      // in case if LastSelectedItem = itNothing
      if (FSelectedIndex = LastSelectedIndex) then Break;

      if FSelectedIndex < 0
      then FSelectedIndex:= ItemRects.Count -1;

      if FSelectedIndex >= ItemRects.Count
      then begin
        FSelectedIndex:= itNothing;

        // show hidden menu items
        if fsHiddenArrow in State
        then begin
          StopTimer;
          Include(State, fsShowHidden);
          SilentHide;
          Animate;
          Exit;
        end;
      end;

      // no enabled items available
      if (FSelectedIndex = LastSelectedIndex)
      then Break;

      // try to find ordinal menu item
      M:= GetMenuItemIndex(FSelectedIndex);
      if (M <> nil)
      and (not IsSeparatorItem(M))
      and (IsEnabled(M) or (not (mfNoHighDisabled in Options.Flags)))
      then Break;

      // Win32 menu item
      if (M = nil)
      and (FSelectedIndex >= 0)
      then begin
        mii.dwTypeData:= Z;
        mii.cch:= SizeOf(Z) -1;
        if GetMenuItemInfo(MenuHandle, FSelectedIndex, True, mii)
        and (mii.fType and mft_Separator = 0)
        and (mii.fState and (mfs_Grayed + mfs_Disabled) = 0)
        then Break;
      end;

      Inc(FSelectedIndex, Direction);

    until False;

    Include(State, fsDrawDisabled);

    CheckShowHint(GetCurMenuItem, False, Self);

    // set context
    if (CurMenuItem <> nil)
    then HelpContext:= CurMenuItem.HelpContext;
  end;
end;

procedure TPopupMenu2000Form.GetOptions(Items: TMenuItem; Menu: TCustomPopupMenu2000; var Options: T_AM2000_MenuOptions);
  // returns options for the current submenu
var
  Item: TMenuItem2000;
begin
  Inc(GlobalRepaintLockCount);

  if Options = nil
  then Options:= T_AM2000_MenuOptions.Create(Items);

  if (Menu <> nil)
  then
    with Options, T_AM2000_ItemOptions(Options)
    do begin
      AssignPropertiesOnly(Menu.Options, True);
      Flags:= Menu.Options.Flags;
      ParentColors:= True;
      ParentMargins:= True;
      ParentSkin:= True;
      ParentTitle:= True;
    end;

  // assign current options
  if (Items <> nil)
  and (Items is TMenuItem2000)
  then begin
    Item:= TMenuItem2000(Items);

    while (Item <> nil)
    do with T_AM2000_ItemOptions(Options)
      do begin
        if Item.AnimatedSkin <> nil
        then begin
          PopupSkin:= ISkin(TCustomAnimatedSkin2000(Item.AnimatedSkin));
          Item.AnimatedSkin.AssignTo(Options);
          Dec(GlobalRepaintLockCount);
          Exit;
        end
        else
        if Item.HasOptions
        then begin
          Options.AssignPropertiesOnly(Item.Options, False);

          if ParentColors
          then begin
            if Item.Options.HasColors
            then Colors:= Item.Options.Colors
            else Colors:= nil;

            if not Item.Options.ParentColors
            then ParentColors:= False;
          end;

          if ParentMargins
          then begin
            if Item.Options.HasMargins
            then Margins:= Item.Options.Margins
            else Margins:= nil;

            if not Item.Options.ParentMargins
            then ParentMargins:= False;
          end;

          if ParentSkin
          then begin
            if Item.Options.HasSkin
            then Skin:= Item.Options.Skin
            else Skin:= nil;

            if not Item.Options.ParentSkin
            then ParentSkin:= False;
          end;

          if ParentTitle
          then begin
            if Item.Options.HasTitle
            then Title:= Item.Options.Title
            else Title:= nil;

            if not Item.Options.ParentTitle
            then ParentTitle:= False;
          end;
        end;

        Item:= Item.Parent;
      end;
  end;

  // popup menu options
  if Menu <> nil
  then begin
    if (Menu is TCustomPopupMenu2000)
    and (TCustomPopupMenu2000(Menu).ParentSkin <> nil)
    then PopupSkin:= TCustomPopupMenu2000(Menu).ParentSkin
    else PopupSkin:= ISkin(Menu);
    

    if T_AM2000_ItemOptions(Options).ParentColors
    then
      if PopupSkin.HasColors
      then Options.Colors:= PopupSkin.Colors
      else Options.Colors:= nil;

    if T_AM2000_ItemOptions(Options).ParentMargins
    then
      if PopupSkin.HasMargins
      then Options.Margins:= PopupSkin.Margins
      else Options.Margins:= nil;

    if T_AM2000_ItemOptions(Options).ParentTitle
    then
      if PopupSkin.HasTitle
      then Options.Title:= PopupSkin.Title
      else Options.Title:= nil;

    if T_AM2000_ItemOptions(Options).ParentSkin
    then
      if PopupSkin.HasSkin
      then Options.Skin:= PopupSkin.Skin
      else Options.Skin:= nil;
  end;

  Dec(GlobalRepaintLockCount);
end;



{ Events }

procedure TPopupMenu2000Form.WMActivate(var Msg: TWMActivate);
var
  F: Forms.TForm;
begin
  if (Msg.Active = wa_Active)
  and (Owner is Forms.TForm)
  then begin
    F:= Forms.TForm(Owner);
    while (F.FormStyle = fsMdiChild)
    and (F.Owner is Forms.TForm)
    do F:= Forms.TForm(F.Owner);

    if (F is Forms.TForm)
    and (F.Visible)
    and not (csDestroying in F.ComponentState)
    then SendMessage(F.Handle, wm_NCActivate, 1, 0);

  end
  else
    inherited;

end;

// many thanks to Jordan Russell again!...
procedure TPopupMenu2000Form.WMMouseActivate(var Msg: TWMMouseActivate);
begin
  Msg.Result:= ma_NoActivate;
  if (Owner is Forms.TForm) then
    SetActiveWindow(Forms.TForm(Owner).Handle);
end;

procedure TPopupMenu2000Form.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  Include(MouseState, msMouseOver);
end;

procedure TPopupMenu2000Form.CMMouseLeave(var Msg: TMessage);
begin
  inherited;

  if not (msMouseOver in MouseState)
  then Exit;
  
  MouseState:= [];
  if (fsAnimated in State)
  or (fsDisabled in State)
  or (GetCurMenuItem = nil)
  or (csDestroying in CurMenuItem.ComponentState)
  then Exit;

  // exit event
  if (CurMenuItem is TMenuItem2000)
  and Assigned(TMenuItem2000(CurMenuItem).OnExit)
  then TMenuItem2000(CurMenuItem).OnExit(CurMenuItem);

  // no menu or no submenu
  if not (HasSubMenu(CurMenuItem)
  or HasSubMenuWin32(MenuHandle, FSelectedIndex))
  then begin
    LastSelectedIndex:= FSelectedIndex;
    FSelectedIndex:= itNothing;
    Include(State, fsSelectedChanged);
    Invalidate;
  end;

  // moving items
  if fsFraming in State
  then begin
    if not IsOkControlUnderCursor
    then RejectDragTarget;

    Include(State, fsPaintMenu);
    Paint;
  end;

  // clear status bar
  SetStatusBarText('');

  // hottrack
  if (fsHotTrack in State)
  then begin
    if not IsOkControlUnderCursor
    then SetTimer(nHotTrackTimeout, OnHotTrack);
  end;
end;

procedure TPopupMenu2000Form.WMSetFocus(var Msg: TWMSetFocus);
begin
  if (fsAnimated in State)
  and (Owner is Forms.TForm)
  and (Forms.TForm(Owner).Visible)
  then Forms.TForm(Owner).SetFocus
  else inherited;
end;

procedure TPopupMenu2000Form.CMShowingChanged(var Msg: TMessage);
begin
  // Skip Application.UpdateVisible
  // that shows annoying 'application icon' on taskbar
  if Showing
  then begin
    ShowWindow(Handle, sw_ShowNoActivate);
    SetWindowPos(Handle, hwnd_Top, Left, Top, Width, Height, FormFlags);
  end
  else
    ShowWindow(Handle, sw_Hide);
end;

procedure TPopupMenu2000Form.wmEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  PaintBufferOnCanvas(Canvas.Handle, False);
  Msg.Result:= 1;
end;

procedure TPopupMenu2000Form.MouseDown;
var
  I: Integer;
  F, F1: TPopupMenu2000Form;
begin
  if fsDisabled in State
  then Exit;

  if ssLeft in Shift
  then
    if msLeftButton in MouseState
    then Exit
    else Include(MouseState, msLeftButton);

  if ssRight in Shift
  then
    if msRightButton in MouseState
    then Exit
    else Include(MouseState, msRightButton);
    
  Include(State, fsMouseChanged);

  // hide tooltip
  if (ToolTipWindow <> nil)
  then ToolTipWindow.Deactivate;

  // click on dragpane
  I:= GetIndexAt(X, Y);
  if (Options.Draggable)
  and (I = itDragPane)
  and (Button = mbLeft)
  and not (fsPreview in State)
  then begin
    RestoreCursorDefault(crIBeam);
    F:= TPopupMenu2000Form(CreateFloatingMenuForm(Owner, Self.MenuItems, Options, PopupMenu, Left, Top));

    // kill opened menus
    if AssignedActivePopupMenu2000Form
    then
      KillActivePopupMenu2000(True, False)
    else begin
      F1:= Self;
      while (F1 <> nil)
      and (F1.BorderStyle = bsNone)
      do begin
        F1.Perform(wm_KillTimer, 0, 0);
        F1.Perform(wm_KillAnimation, 0, 0);
        F1.Perform(wm_HideSilent, 0, 1);
        F1:= F1.ParentMenuForm;
      end;
    end;

    F.Refresh;
    F.Show;
  end

  // bottom scroll
  else
  if (I >= itScrollFirst)
  and (I <= itScrollLast)
  then begin
    if (I = itScrollDown)
    and (LastVisibleIndex < ItemRects.Count -1)
    then Inc(FirstVisibleIndex)

    else
    if (I = itScrollPageDown)
    then
      if (LastVisibleIndex < ItemRects.Count -1 - LastVisibleIndex + FirstVisibleIndex)
      then Inc(FirstVisibleIndex, LastVisibleIndex - FirstVisibleIndex)
      else begin
        LastVisibleIndex:= ItemRects.Count -1;
        FirstVisibleIndex:= GetFirstVisibleIndex;
      end

    else
    if (I = itScrollUp)
    and (FirstVisibleIndex > 0)
    then Dec(FirstVisibleIndex)

    else
    if (I = itScrollPageUp)
    then begin
      Dec(FirstVisibleIndex, LastVisibleIndex - FirstVisibleIndex);
      
      if FirstVisibleIndex < 0
      then FirstVisibleIndex:= 0;

      LastVisibleIndex:= GetLastVisibleIndex;
    end

    else
    if (I = itScrollBox)
    then GetCursorPos(LastScrollBoxPos);


    LastVisibleIndex:= GetLastVisibleIndex;
    Repaint;

    if (not IsTimerSet(nShortScrollingTimeout, OnScrollTimer))
    and (not IsTimerSet(nScrollingTimeout, OnScrollTimer))
    then begin
      StopTimer;
      SetTimer(nScrollingTimeout, OnScrollTimer);
    end;

    Exit;
  end

  // ordinary paint
  else
  if I >= 0
  then begin
    if fsDisabled in State
    then begin
      Exclude(State, fsDisabled);
      DestroySubMenuForm;
    end;

    ActiveMenuItem:= GetMenuItemIndex(I);

    if fsPreview in State
    then begin
      if FormDesigner <> nil
      then FormDesigner.SelectComponent(ActiveMenuItem);

      if (SubMenuForm <> nil)
      or HasSubmenu(ActiveMenuItem)
      then OnPopupTimer(Self);

      if (PopupMenu.PopupComponent is TCustomMenuBar2000)
      then TCustomMenuBar2000(PopupMenu.PopupComponent).UpdateMenuBar(False);

      GetHighestForm.RePaint;

      Exit;
    end;

    if (GetCurMenuItem <> nil)
    and (CurMenuItem is TMenuItem2000)
    and Assigned(TMenuItem2000(CurMenuItem).OnMouseDown)
    then
{$IFDEF TRIAL}
      ShowTrialWelcome;
{$ELSE}
      with GetItemRect(I)
      do TMenuItem2000(CurMenuItem).OnMouseDown(CurMenuItem, Button, Shift, X - Left, Y - Top);
{$ENDIF}
  end;

  Paint;
end;

procedure TPopupMenu2000Form.MouseUp;
var
  MI: TMenuItem;
  P: TPoint;
  Target: TControl;
  TempPopupMenu: TPopupMenu;

begin
  if fsDisabled in State
  then Exit;

  if not (ssLeft  in Shift)
  then Exclude(MouseState, msLeftButton);

  if not (ssRight in Shift)
  then Exclude(MouseState, msRightButton);

  Include(State, fsMouseChanged);

  StopTimer;

  // exit when animated
  if (fsAnimated in State)
  or (fsKillAnimate in State)
  then Exit;

  if fsIgnoreNextMouseUp in State
  then begin
    if Button = mbLeft
    then Exclude(State, fsIgnoreNextMouseUp);
    
    Exit;
  end;

  // if hidden arrow is pressed
  if SelectedIndex = itHiddenArrow
  then begin
    Paint;
    Sleep(50);
    OnUnhideTimer(nil);
    Exit;
  end;

  // moving menu items
  if fsFraming in State
  then begin
    // end moving
    Exclude(State, fsFraming);
    EndCustomization(True);

    // resizing
    RebuildBounds;
    RealWidth:= GetRealWidth;
    RealHeight:= GetRealHeight;
    SetBounds(Left, Top, RealWidth, RealHeight);
    Buffer.Width:= RealWidth - (Width - ClientWidth);
    Buffer.Height:= RealHeight - (Height - ClientHeight);
    LastVisibleIndex:= GetLastVisibleIndex;

    // repaint
    Repaint;
    Exit;
  end;

  MI:= GetCurMenuItem;

  // autocheck
{$IFDEF Delphi6OrHigher}
  if (MI <> nil)
  and MI.AutoCheck
{$ELSE}
  if (MI <> nil)
  and (MI is TMenuItem2000)
  and (TMenuItem2000(MI).AutoCheck)
{$ENDIF}
  then begin
    TMenuItem2000(MI).Checked:= not TMenuItem2000(MI).Checked;
    Include(State, fsPaintMenu);
  end;

  Paint;


  // onMouseUp
  if (MI <> nil)
  and (MI is TMenuItem2000)
  and Assigned(TMenuItem2000(MI).OnMouseUp)
  then
{$IFDEF TRIAL}
    ShowTrialWelcome;
{$ELSE}
    with GetItemRect(SelectedIndex)
    do TMenuItem2000(MI).OnMouseUp(CurMenuItem, Button, Shift, X - Left, Y - Top);
{$ENDIF}

  // popup context menu
  if (Button = mbRight)
  then begin
    if (MI <> nil)
    and (MI is TMenuItem2000)
    then begin
      TempPopupMenu:= nil;

      if (fsPreview in State)
      then begin
        if MenuDesigner <> nil
        then MenuDesigner.Perform(wm_GetPopupMenu, 0, Integer(@TempPopupMenu))
      end
      else begin
        if Assigned(Self.PopupMenu.OnContextMenu)
        then Self.PopupMenu.OnContextMenu(MI);
        TempPopupMenu:= TMenuItem2000(MI).PopupMenu;
      end;

      if TempPopupMenu <> nil
      then begin
        Include(State, fsDisabled);
        DestroySubMenuForm;

        // on popup event
        if (TempPopupMenu is TCustomPopupMenu2000)
        and Assigned(TCustomPopupMenu2000(TempPopupMenu).OnPopup)
        then TCustomPopupMenu2000(TempPopupMenu).OnPopup(MI);

        // create context menu as submenu
        CreateSubMenuForm(TempPopupMenu, TempPopupMenu.Items.Handle, TempPopupMenu.Items);
        TempPopupMenu.PopupComponent:= MI;
        SubMenuForm.Animation:= Self.Options.Animation;

        // show context menu
        GetCursorPos(P);
        SubMenuForm.SetBounds(P.X, P.Y, 0, 0);
        SubMenuForm.Animate;
      end;
    end // mi is clicked

    // relay mouse events on mousecapture
    else
    if MouseCapture
    then begin
      GetCursorPos(P);
      Target:= FindDragTarget(P, True);
      if IsOkControl(Target)
      and (Target <> Self)
      and (Target is TWinControl)
      then
        with Target.ScreenToClient(ClientToScreen(Point(X, Y)))
        do PostMessage(TWinControl(Target).Handle, wm_RButtonUp, 0, MakeLong(X, Y));
    end;

    Exit;
  end; // button = mbright

  // nothing is selected
  if (SelectedIndex = itNothing)
  or (SelectedIndex = itTopScroll)
  or (SelectedIndex = itBottomScroll)
  or ((X + Y > 0) and (not IsOkControlUnderCursor))
{$IFNDEF ActiveX}
  or (fsPreview in State)
{$ENDIF}
  then Exit;

  // cancel editing
  if (fsDisabled in State)
  and (FocusItem <> nil)
  and (FocusItem is TMenuItem2000)
  and (SelectedIndex <> GetIndexAt(X, Y))
  then begin
    TMenuItem2000(FocusItem).AsEdit.CancelEdit(True);
    Exclude(State, fsDisabled);
    FocusItem:= nil;
    Paint;
    Exit;
  end;

  // clear status bar
  SetStatusBarText('');

  if SubMenuForm <> nil
  then begin
    Exclude(State, fsDisabled);
    PopupSubMenuForm(False);
    Exit;
  end;

  // paint
  Sleep(50);

  if (MI <> nil)
  and (MenuItems.IndexOf(MI) <> -1)
  then begin
    if (not IsEnabled(MI))
    or IsSeparatorItem(MI)
    then Exit;

    // is editbox
    if (MI is TMenuItem2000)
    and (TMenuItem2000(MI).Control = ctlEditbox)
    then begin
      TMenuItem2000(MI).AsEdit.BeginEdit(X, Y);
      Exit;
    end;

    DoClick(MI, (X + Y = 0));
  end
  else begin
    mii.fMask:= miim_Type + miim_ID + miim_Submenu;
    mii.dwTypeData:= Z;
    mii.cch:= SizeOf(Z) -1;
    if (not GetMenuItemInfo(MenuHandle, SelectedIndex + CurHiddenCount, True, mii))
    or (mii.fType and mft_Separator <> 0)
    or (mii.fState and mfs_Disabled <> 0)
    then Exit;

    DoClickWin32(mii);
  end;
end;

procedure TPopupMenu2000Form.DoClick(const MI: TMenuItem; const SelectFirst: Boolean);
var
  CanClose: Boolean;
  F: TPopupMenu2000Form;
  AnimationFlag: Boolean;
  BoolTemp: Bool;
  I: Integer;
  R: TRect;
{$IFDEF TRIAL}
  S: String;
{$ENDIF}

  procedure CheckHiddenSeparator(Index, Delta: Integer; Items: TMenuItem);
    // look for first not-a-hidden menu item
    // if the separator exists between current menu item and first not-a-hidden
    // then promote the separator too
  var
    M, SeparatorItem: TMenuItem;
    mic: Integer;
  begin
    // exit if hidden items are hidden
    if not (fsShowHidden in State) then Exit;

    SeparatorItem:= nil;
    mic:= ItemRects.Count;
    repeat
      Index:= Index + Delta;

      // exit if no not-a-hidden item found
      if (Index < 0)
      or (Index >= mic)
      then Exit;

      M:= GetMenuItemByIndex(Index, Items);

      // exit if no not-a-hidden item found
      if (M = nil)
      and (Index < mic)
      then Exit;

      // separator found
      if (M <> nil)
      and (SeparatorItem = nil)
      and IsSeparatorItem(M)
      then SeparatorItem:= M;

      // hidden menu item
      if (M is TMenuItem2000)
      and TMenuItem2000(M).Hidden
      then Continue;

      // not-a-hidden item found!
      if (SeparatorItem <> nil)
      and (SeparatorItem is TMenuItem2000)
      and ((M = nil) or IsSeparatorItem(M))
      then begin
        TMenuItem2000(SeparatorItem).Hidden:= False;
        SaveMenuItem(SeparatorItem);
      end;

      Exit;
    until False;
  end;

  procedure PromoteMenuItem(MI: TMenuItem);
    // clear hidden flag at menu item and all parents
  begin
    if (MI is TMenuItem2000)
    and (TMenuItem2000(MI).Hidden)
    and (EnablePromotion)
    then begin
      TMenuItem2000(MI).Hidden:= False;
      SaveMenuItem(MI);

      // and show separators
      CheckHiddenSeparator(LastSelectedIndex, -1, MI.Parent);
      CheckHiddenSeparator(LastSelectedIndex, 1, MI.Parent);
    end;

    // check parents
    if MI <> nil
    then
      PromoteMenuItem(MI.Parent);
  end;

begin
  // ordinary menu item
  if HasSubmenu(MI)
  then begin
    MI.Click;
    PopupSubMenuForm(SelectFirst);
    Exit;
  end;

  // clear hidden flag at MI and it's parents
  PromoteMenuItem(MI);

  // check OnCloseQuery
  CanClose:= not (fsPreview in State);

  if CanClose
  then PopupMenu.DoCloseQuery(MI, CanClose);

  if CanClose
  then begin
    // start animation
    if (SelectedIndex >= 0)
    and (SelectedIndex < ItemRects.Count)
    and ((Animation = anFadeIn)
    or ((PopupSkin <> nil)
    and PopupSkin.SystemSelectionFade
    and SystemParametersInfo(SPI_GetSelectionFade, 0, @BoolTemp, 0)
    and BoolTemp))
    then begin
      AnimationFlag:= True;

      // start animation
      if ActiveDragWindow <> nil
      then ActiveDragWindow.Free;

      R:= GetItemRect(SelectedIndex);
      InflateRect(R, Options.Margins.Frame, 0);
      OffsetRect(R, Self.Left, Self.Top);
      ActiveMenuItem:= GetCurMenuItem;
      ActiveDragWindow:= T_AM2000_DragWindow.CreateRect(Buffer.Canvas.Font, R, Options, fsCtl3D in State);

      with T_AM2000_DragWindow(ActiveDragWindow)
      do begin
        MouseCapture:= False;
        Opacity:= Options.Opacity;
        SilentShow;
      end;

      ProcessPaintMessages;
    end
    else
      AnimationFlag:= False;

    // close the menu
    // check for popup menu
    F:= ParentMenuForm;
    while (F <> nil)
    and (F.PopupMenu = PopupMenu)
    do F:= F.ParentMenuForm;

    if (F <> nil)
    and (fsDisabled in F.State)
    then begin
      Exclude(F.State, fsDisabled);
      F.SubMenuForm.Release;
    end
    else
      KillActivePopupMenu2000(True, True);

    FullShowCaret;
    if MenuSoundResource
    then PlaySound(PChar(MenuCommandSound), HInstance, snd_Resource + snd_Async + snd_NoDefault + snd_NoStop)
    else sndPlaySound(PChar(MenuCommandSound), snd_Async + snd_NoDefault + snd_NoStop);

    if AnimationFlag
    then begin
      for I:= Options.Opacity div 10 -1 downto 0
      do begin
        T_AM2000_DragWindow(ActiveDragWindow).Opacity:= I * 10;

        if Assigned(pSetLayeredWindowAttributes)
        then Sleep(nTimeout *2)
        else Sleep(nTimeout);
      end;

      ActiveDragWindow.Free;

      AnimationFlag:= False;
    end;
  end;

  if Assigned(PopupMenu.OnMenuCommand)
  then PopupMenu.OnMenuCommand(MI);

  // Click
{$IFDEF TRIAL}
  S:= '';
  if ((not (PopupMenu.PopupComponent is TCustomMenuBar2000))
  or (PopupMenu.PopupComponent.Owner = nil)
  or (PopupMenu.PopupComponent.Owner.ClassName <> SDesignerClassName))
  then begin
    ShowTrialWelcome;
  end
  else
{$ENDIF}
  MI.Click;

{$IFDEF Delphi6OrHigher}
  if MI.AutoCheck
  then TMenuItem2000(MI).Checked:= not TMenuItem2000(MI).Checked;
{$ENDIF}

  // show must go on
  if (not CanClose)
  then begin
    if (ToolTipWindow <> nil)
    then ToolTipWindow.Activate;

    SetTimer(nPopupSubmenuTimeout, OnPopupTimer);

    Include(State, fsPaintMenu);
    Paint;
  end;
end;

procedure TPopupMenu2000Form.DoClickWin32(mii: TMenuItemInfo);
var
  wID: Integer;
  CanClose: Boolean;
  hWnd: THandle;
  MI: TMenuItem;
begin
  if mii.hSubmenu <> 0
  then begin
    PopupSubMenuForm(False);
    Exit;
  end;

  wID:= mii.wID;
  StopTimer;
  CanClose:= True;
  PopupMenu.DoCloseQuery(nil, CanClose);

  if CanClose
  then begin
    // close the menu
    KillActivePopupMenu2000(True, False);
      
    if Owner is TForm
    then SendMessage(TForm(Owner).Handle, wm_NCActivate, 1, 0);
    FullShowCaret;

    if MenuSoundResource
    then PlaySound(PChar(MenuCommandSound), HInstance, snd_Resource + snd_Async + snd_NoDefault + snd_NoStop)
    else sndPlaySound(PChar(MenuCommandSound), snd_Async + snd_NoDefault + snd_NoStop);
  end;

  if Assigned(PopupMenu.OnMenuCommand)
  then PopupMenu.OnMenuCommand(nil);

  // send message
  if (Ole2ObjectWindow <> 0)
  then
    if (fsMenuPopulated in State)
    then begin
      MI:= FindItem2000(TForm(Owner), wID, fkCommand);
      if IsEnabled(MI)
      then MI.Click;
    end
    else
      PostMessage(Ole2ObjectWindow, wm_Command, wID, 0)

  else begin

    if Owner is TForm
    then hWnd:= TForm(Owner).Handle
    else
    if PopupMenu.PopupComponent.Owner is TForm
    then hWnd:= TForm(PopupMenu.PopupComponent.Owner).Handle
    else
    if (PopupMenu.PopupComponent is TCustomMenuBar2000)
    and (TCustomMenuBar2000(PopupMenu.PopupComponent).OwnerForm <> nil)
    then hWnd:= TCustomMenuBar2000(PopupMenu.PopupComponent).OwnerForm.Handle
    else hWnd:= 0;

    PostMessage(hWnd, wm_Command, wID, 0)
  end;

  // show must go on
  if (not CanClose)
  then begin
    if (ToolTipWindow <> nil)
    then ToolTipWindow.Activate;

    SetTimer(nPopupSubmenuTimeout, OnPopupTimer);

    Include(State, fsPaintMenu);
    Paint;
  end;
end;

procedure TPopupMenu2000Form.DblClick;
begin
  inherited;

  if (fsPreview in State)
  and (FormDesigner <> nil)
  then begin
    FormDesigner.ShowMethod(GetCurMenuItem, 'Click');
    SilentHide;
  end;
end;

procedure TPopupMenu2000Form.MouseMove(Shift: TShiftState; X, Y: Integer);
  // thanks to Frédéric Schneider for improvements in this routine
var
  R: TRect;
  P: TPoint;
  I, L: Integer;         
  Target: TControl;
  CanMove: Boolean;
begin
  Include(MouseState, msMouseOver);

  if GetKeyState(vk_LButton) < 0
  then Include(MouseState, msLeftButton)
  else Exclude(MouseState, msLeftButton);
  
  if GetKeyState(vk_RButton) < 0
  then Include(MouseState, msRightButton)
  else Exclude(MouseState, msRightButton);

  if (fsAnimated in State)
  or (fsKillAnimate in State)
  or (fsDisabled in State)
  then Exit;

  // menu message filter
  GetCursorPos(P);
  if PtInRect(LastCursorRect, P)
  then Exit;

  LastCursorRect:= Rect(P.X -2, P.Y -2, P.X +2, P.Y +2); 

  Target:= FindDragTarget(P, True);
  CallMenuMsgFilterPt(GetHighestForm.Handle, wm_MouseMove, 0, MakeLong(P.X, P.Y), P);

  // relay mouse move
  if (ToolTipWindow <> nil)
  then ToolTipWindow.RelayMouseMove(SmallPoint(X, Y));

  // change mouse cursor
  if (GetCurMenuItem is TMenuItem2000)
  and (TMenuItem2000(CurMenuItem).Control = ctlEditbox)
  then begin
    if (BorderStyle = bsNone)
    then
      if (fsCtl3D in State)
      then L:= Options.Margins.Border +2
      else L:= Options.Margins.Border
    else
      L:= 0;

    Inc(L, AmpTextWidth(Buffer.Canvas, GetCaption(CurMenuItem)) +5);

    R:= GetItemRect(FSelectedIndex);
    if R.Left < L then R.Left:= L;
    InflateRect(R, 0, -2);

    if PtInRect(R, Point(X, Y))
    then SetCursor(crIBeam)
    else RestoreCursorDefault(crIBeam);

  end
  else
    RestoreCursorDefault(crIBeam);


  if fsIgnoreMouseMove in State
  then begin
    Exclude(State, fsIgnoreMouseMove);
    Exit;
  end;

  if IsTimerSet(nPopupSubmenuTimeout, OnPopupTimer)
  or IsTimerSet(nShortPopupSubmenuTimeout, OnPopupTimer)
  then StopTimer;

  // set parentmenuform highlight
  if (ParentMenuForm <> nil)
  and (Target = Self)
  and (not (fsDisabled in ParentMenuForm.State))
  and (ParentMenuForm.FSelectedIndex <> ParentMenuIndex)
  then
    with ParentMenuForm
    do begin
      LastSelectedIndex:= FSelectedIndex;
      FSelectedIndex:= Self.ParentMenuIndex;
      Include(State, fsSelectedChanged);
      Exclude(State, fsDrawDisabled);
      Paint;
    end;

  // set highlight
  I:= GetIndexAt(X, Y);
  if (I <> SelectedIndex)
{$IFDEF Delphi3OrHigher}
  and ((I <> itNothing)
  or (not (Target is TToolButton)))
{$ENDIF}
  then begin
    if (not (fsDesigning in State))
    and (not (fsFraming in State))
    and (not (fsPreview in State))
    then begin
      // OnExit
      if (GetCurMenuItem <> nil)
      and (CurMenuItem is TMenuItem2000)
      and Assigned(TMenuItem2000(CurMenuItem).OnExit)
      then TMenuItem2000(CurMenuItem).OnExit(CurMenuItem);

      LastSelectedIndex:= FSelectedIndex;
      FSelectedIndex:= I;
      Include(State, fsSelectedChanged);
      Exclude(State, fsDrawDisabled);

      // OnEnter and OnMoOuseMove events
      if (GetCurMenuItem <> nil)
      and (CurMenuItem is TMenuItem2000)
      then begin
        CurRect:= GetItemRect(SelectedIndex);

        if Assigned(TMenuItem2000(CurMenuItem).OnEnter)
        then TMenuItem2000(CurMenuItem).OnEnter(CurMenuItem);

        if Assigned(TMenuItem2000(CurMenuItem).OnMouseMove)
        then TMenuItem2000(CurMenuItem).OnMouseMove(CurMenuItem, Shift, X - CurRect.Left, Y - CurRect.Top);
      end;

      // place message
      PostMenuSelectMessage;
    end

    else begin
      LastSelectedIndex:= FSelectedIndex;
      FSelectedIndex:= I;
      Include(State, fsSelectedChanged);
    end;

    // start moving
    if IsCustomization(Options.Customizable or (fsPreview in State))
    then begin
      CanMove:= True;
      if (not (fsFraming in State))
      and (ActiveMenuItem is TMenuItem2000)
      and Assigned(TMenuItem2000(ActiveMenuItem).OnStartDrag)
      then TMenuItem2000(ActiveMenuItem).OnStartDrag(ActiveMenuItem, CanMove);

      if not CanMove
      then Exit;

      if (SelectedIndex <> -1)
      or (LastSelectedIndex <> 0)
      then SetInsertBeforeItem(GetMenuItemIndex(SelectedIndex));

      if (InsertBeforeItem = nil)
      then
        if (SelectedIndex = itHiddenArrow)
        or (SelectedIndex = itBottomScroll)
        or PtInRect(GetItemRect(ItemRects.Count -1), Point(X, Y))
        then
          SetInsertBeforeItem(miInsertAtTheEnd)

        else
        if not IsOkControlUnderCursor
        then begin
          RejectDragTarget;
          Paint;
          Exit;
        end;

      InsertBeforeParent:= MenuItems;
      Include(State, fsFraming);
      if PopupMenu.PopupComponent is TCustomMenuBar2000
      then PostMessage(TCustomMenuBar2000(PopupMenu.PopupComponent).Handle, wm_SetState, ssFraming, 1);

      // drag window
      if ActiveDragWindow = nil
      then begin
        R:= GetItemRect(LastSelectedIndex);
        if (R.Left = R.Right)
        or (R.Top = R.Bottom)
        then Exit;

        InflateRect(R, Options.Margins.Frame, 0);
        OffsetRect(R, Self.Left, P.Y - (R.Top + R.Bottom) div 2);
        ActiveDragWindow:= T_AM2000_DragWindow.CreateRect(Buffer.Canvas.Font, R, Options, fsCtl3D in State);
        T_AM2000_DragWindow(ActiveDragWindow).SilentShow;
      end;

      SetDragCursor;
    end;

    // repaint
    Paint;

    // show menu item hint
    SetStatusBarText('');
    CheckShowHint(GetCurMenuItem, True, Self);

    // is it hidden arrow?
    if (SelectedIndex = itHiddenArrow)
    then begin
      StopTimer;
      DestroySubmenuForm;
      SetTimer(nShowHiddenTimeout, OnUnhideTimer);
      Exit;
    end;

    if (SelectedIndex = itDragPane)
    then SetCursor(crSize)
    else RestoreCursorDefault(crSize);
  end

  else
  if (I = itScrollBox)
  and (msLeftButton in MouseState)
  then begin
    if Abs(LastScrollBoxPos.Y - P.Y) < ScrollDelta
    then Exit;

    L:= Round((P.Y - LastScrollBoxPos.Y) / ScrollDelta);
    if (L = 0)
    then Exit

    else
    if (L < 0)
    then begin
      Inc(FirstVisibleIndex, L);
      if FirstVisibleIndex < 0
      then FirstVisibleIndex:= 0;

      LastVisibleIndex:= GetLastVisibleIndex;
    end

    else
    begin
      Inc(LastVisibleIndex, L);
      if LastVisibleIndex >= ItemRects.Count
      then LastVisibleIndex:= ItemRects.Count -1;

      FirstVisibleIndex:= GetFirstVisibleIndex;
    end;

    LastScrollBoxPos:= P;
    Repaint;
  end

  else begin
    if (GetCurMenuItem <> nil)
    and (CurMenuItem is TMenuItem2000)
    then begin
      // OnMouseMove event
      if Assigned(TMenuItem2000(CurMenuItem).OnMouseMove)
      then TMenuItem2000(CurMenuItem).OnMouseMove(CurMenuItem, Shift, X - CurRect.Left, Y - CurRect.Top);

      // ctlButtonArray control
      if (TMenuItem2000(CurMenuItem).Control = ctlButtonArray)
      then
        with TMenuItem2000(CurMenuItem), AsButtonArray do
          if GetIndexAt(X, Y) <> LastItemIndex
          then begin
            Self.Paint;
            CheckShowHint(GetCurMenuItem, True, Self);
          end;
    end;

    if MouseCapture
    and IsOkControl(Target)
    and (Target <> Self)
    and (Target is TWinControl)
    then
      with Target.ScreenToClient(ClientToScreen(Point(X, Y)))
      do PostMessage(TWinControl(Target).Handle, wm_MouseMove, 0, MakeLong(X, Y));
  end;

  // skip when designing
//
//  then Exit;

  // process menu popup
  if HasSubMenu(CurMenuItem)
  then
    if (FormDesigner <> nil)
    then begin
      if (CurMenuItem = InsertBeforeItem)
      then OnPopupTimer(nil);
    end
    else
    if (State * [fsFraming, fsPreview] <> [])
    then
      OnPopupTimer(nil)
    else
    if (SubMenuForm <> nil)
    then
      SetTimer(nShortPopupSubmenuTimeout, OnPopupTimer)
    else
      SetTimer(nPopupSubmenuTimeout, OnPopupTimer)

  else
    SetTimer(nPopupSubmenuTimeout, OnPopupTimer);
end;

procedure TPopupMenu2000Form.SearchActiveMenuForShortcut(var Msg: TWMKey);
  // just a symbol key - seeking for menu item
var
  I, Count, MIC: Integer;
  MI: TMenuItem;
  S: String;
begin
  CurHiddenCount:= 0;
  Count:= ItemRects.Count;
  MIC:= GetCount(MenuItems);
  if Count < MIC
  then Count:= MIC;

  for I:= 0 to Count -1
  do begin
    if I < MIC
    then begin
      MI:= MenuItems[I];
      if (not (IsVisible(MI) and IsEnabled(MI)))
      then begin
        if (MI is TMenuItem2000)
        and (TMenuItem2000(MI).Hidden and not (fsShowHidden in State))
        then Inc(CurHiddenCount);
        
        Continue;
      end
      else
        S:= GetCaption(MI);
    end

    else begin
      MI:= nil;
      mii.fMask:= miim_ID + miim_Type + miim_State;
      mii.dwTypeData:= @Z;
      mii.cch:= SizeOf(Z) -1;
      if (not GetMenuItemInfo(MenuHandle, I, True, mii))
      or (mii.fType and mft_Separator <> 0)
      or (mii.fState and (mfs_Disabled + mfs_Grayed) <> 0)
      then Continue;

      S:= StrPas(Z);
    end;

    if IsAccel2(Msg.CharCode, S)
    then begin
      LastSelectedIndex:= FSelectedIndex;
      FSelectedIndex:= I - CurHiddenCount;

      if (MI <> nil)
      then DoClick(MI, False)
      else
      if (mii.fState and (mfs_Grayed + mfs_Disabled) = 0)
      then MouseUp(mbLeft, [], 0, 0)
      else MessageBeep(0);

      Msg.Result:= 1;
      Exit;
    end;
  end { for  };

  MessageBeep(0);
end;

procedure TPopupMenu2000Form.wmKeyDown(var Msg: TWMKeyDown);
  // keyboard events
var
  M: TMsg;
  Shift: TShiftState;
  hwnd: THandle;
begin
  // handle focus item
  if (FocusItem <> nil)
  and (fsDisabled in State)
  and (FocusItem is TMenuItem2000)
  then begin
    // get shift state
    Shift:= [];
    if GetKeyState(vk_Shift) < 0    then Include(Shift, ssShift);
    if GetKeyState(vk_Control) < 0  then Include(Shift, ssCtrl);
    if Msg.KeyData and AltMask <> 0 then Include(Shift, ssAlt);

    // handle char
    case Msg.CharCode of
      vk_Escape, vk_Return:
        begin
          TMenuItem2000(FocusItem).AsEdit.CancelEdit(Msg.CharCode = vk_Return);
          Exclude(State, fsDisabled);
          FocusItem:= nil;
          Paint;
          Msg.Result:= 1;
        end;

      else
        // send char
        TMenuItem2000(FocusItem).ControlOptions.KeyDown(Msg.CharCode, Shift);
    end;

    // set result
    if Msg.CharCode = 0 then Msg.Result:= 1;
  end

  // other menu item
  else

  case Msg.CharCode of
    // click item
    vk_Return:
      begin
        hwnd:= GetHighestForm.Handle;
        MouseUp(mbLeft, [], 0, 0);
        CallMenuMsgFilter(hwnd, wm_KeyDown, vk_Return, 0);
        Msg.Result:= 1;
      end;

    vk_Up:
      begin
        SelectedIndex:= SelectedIndex -1;

        if (SelectedIndex > LastVisibleIndex)
        or (SelectedIndex < FirstVisibleIndex)
        then 
          if (SelectedIndex < LastVisibleIndex)
          then begin
            Dec(FirstVisibleIndex);
            LastVisibleIndex:= GetLastVisibleIndex;
          end
          else
            while LastVisibleIndex < SelectedIndex
            do begin
              Inc(FirstVisibleIndex);
              LastVisibleIndex:= GetLastVisibleIndex;
            end;


        StopTimer;
        Paint;
        PostMenuSelectMessage;
        Msg.Result:= 1;
      end;

    vk_Tab:
      begin
        if GetKeyState(vk_Shift) < 0
        then SelectedIndex:= SelectedIndex -1
        else SelectedIndex:= SelectedIndex +1;

        StopTimer;
        Msg.Result:= 1;
      end;

    vk_Down:
      begin
        if GetKeyState(vk_Control) < 0
        then begin
          StopTimer;
          Include(State, fsShowHidden);
          SilentHide;
          Animate;
        end
        else begin
          SelectedIndex:= SelectedIndex +1;

          if (SelectedIndex > LastVisibleIndex)
          or (SelectedIndex < FirstVisibleIndex)
          then begin
            if (SelectedIndex > LastVisibleIndex)
            then Inc(FirstVisibleIndex)
            else FirstVisibleIndex:= SelectedIndex;

            LastVisibleIndex:= GetLastVisibleIndex;
          end;

          StopTimer;
          Paint;
        end;
        
        PostMenuSelectMessage;
        Msg.Result:= 1;
      end;

    vk_Left:
      if ParentMenuForm <> nil
      then begin
        if not (fsAnimated in State)
        then SilentHide;

        Release;
        Msg.Result:= 1;
      end
      else begin
        hwnd:= GetHighestForm.Handle;
        CallMenuMsgFilter(hwnd, wm_KeyDown, vk_Left, 0);
      end;

    vk_Right:
      if (GetCurMenuItem <> nil)
      and IsEnabled(CurMenuItem)
      and (HasSubmenu(CurMenuItem)
      or HasSubMenuWin32(MenuHandle, FSelectedIndex))
      then begin
        PopupSubMenuForm(True);
        Msg.Result:= 1;
      end
      else begin
        hwnd:= GetHighestForm.Handle;
        CallMenuMsgFilter(hwnd, wm_KeyDown, vk_Right, 0);
      end;

    vk_Escape:
      begin
        if fsFraming in State
        then begin
          // cancel moving
          Exclude(State, fsFraming);
          Include(State, fsSelectedChanged);
          Include(State, fsMouseChanged);
          Include(State, fsIgnoreNextMouseUp);

          EndCustomization(False);

          Repaint;
        end
        else begin
          if not (fsAnimated in State)
          then SilentHide;

          if (ParentMenuForm <> nil)
          then begin
            Exclude(ParentMenuForm.State, fsDisabled);
            Release;
          end
          else begin
            KillActivePopupMenu2000(False, False);
            if (PopupMenu.PopupComponent is TCustomMenuBar2000)
            and (TCustomMenuBar2000(PopupMenu.PopupComponent).RaisedForm <> nil)
            then TCustomMenuBar2000(PopupMenu.PopupComponent).RaisedForm.SilentHide;
          end;
        end;

//        CallMenuMsgFilter(Handle, wm_KeyDown, vk_Left, 0);
        Msg.Result:= 1;
      end;

    vk_F1:
      if (Application.HelpFile <> '')
      and (GetCurMenuItem <> nil)
      and (CurMenuItem.HelpContext <> 0)
      then begin
        KillActivePopupMenu2000(True, False);
        if (PopupMenu <> nil)
        and (PopupMenu.Owner is TForm)
        and (biHelp in TForm(PopupMenu.Owner).BorderIcons)
        then Application.HelpCommand(HELP_CONTEXTPOPUP, CurMenuItem.HelpContext)
        else Application.HelpCommand(HELP_CONTEXT, CurMenuItem.HelpContext);

        // We have to remove the next message that is in the queue.
        PeekMessage(M, 0, 0, 0, pm_Remove);
        Msg.Result:= 1;
      end;

    else
      if (not (fsPreview in State))
      and (Msg.CharCode <> vk_Shift)
      and (Msg.CharCode <> vk_Control)
      then begin
        SearchActiveMenuForShortcut(Msg);
        Msg.Result:= 1;
      end;
  end;

  // hide tooltip
  if (ToolTipWindow <> nil)
  then ToolTipWindow.Deactivate;
end;

procedure TPopupMenu2000Form.wmChar(var Msg: TWMChar);
var
  C: Char;
begin
  // handle focus item
  if (FocusItem <> nil)
  and (fsDisabled in State)
  then begin
    // send char
    C:= Char(Msg.CharCode);

    if (FocusItem is TMenuItem2000)
    then TMenuItem2000(FocusItem).ControlOptions.KeyPress(C);

    // set result
    if C = #0 then Msg.Result:= 1;
  end;
end;

procedure TPopupMenu2000Form.wmSysKeyDown(var Msg: TWMKeyDown);
begin
  // hide active menu
  if (Msg.CharCode = vk_Menu) or (Msg.CharCode = vk_F10)
  then begin
    KillActivePopupMenu2000(True, False);

    if (PopupMenu <> nil)
    and (PopupMenu.PopupComponent is TCustomMenuBar2000)
    then TCustomMenuBar2000(PopupMenu.PopupComponent).SetDisableAltKeyUp(True);

    FullShowCaret;
    Msg.Result:= 1;
    Exit;
  end;

  // handle as menu key
  wmKeyDown(Msg);
end;


procedure TPopupMenu2000Form.OnPopupTimer(Sender: TObject);
var
  NotWin32Submenu, NotDelphiSubmenu, NotAttachSubmenu: Boolean;
begin
  if fsDisabled in State then Exit;

  StopTimer;

  if fsSelectedChanged in State
  then begin
    Exclude(State, fsSelectedChanged);
    GetCurMenuItem;

    // this is because DrawDisabled = True when selecton is moved by kbd
    // and = False when is moved by the mouse :)
    if not (fsDrawDisabled in State)
    then CheckShowHint(CurMenuItem, True, Self);

    // if submenu is not actual
    if (CurMenuItem = nil)
    and (SubMenuForm <> nil)
    and (MenuHandle <> 0)
    and (FSelectedIndex <> itNothing)
    then begin
      mii.fMask:= miim_State + miim_SubMenu;
      GetMenuItemInfo(MenuHandle, FSelectedIndex, True, mii);
      NotWin32Submenu:= mii.hSubMenu <> SubMenuForm.MenuHandle;
    end
    else
      NotWin32Submenu:= True;


    NotDelphiSubmenu:= (SubmenuForm = nil)
      or (SubMenuForm.MenuItems = nil) or (CurMenuItem <> SubMenuForm.MenuItems);
    NotAttachSubmenu:= (SubmenuForm = nil)
      or (not (CurMenuItem is TMenuItem2000))
      or (TMenuItem2000(CurMenuItem).AttachMenu = nil)
      or (TMenuItem2000(CurMenuItem).AttachMenu.Items <> SubMenuForm.MenuItems);

    if (SubMenuForm = nil)
    or (NotWin32Submenu and NotDelphiSubmenu and NotAttachSubmenu)
    then PopupSubMenuForm(False);

  end;
end;

procedure TPopupMenu2000Form.OnUnhideTimer(Sender: TObject);
begin
  StopTimer;

  // check is mouse cursor still over the hidden arrow
  if (SelectedIndex = itHiddenArrow)
  or (Sender = nil)
  then begin
    Include(State, fsShowHidden);
    Include(State, fsNewUnhide);
    Include(State, fsAnimated);

    LastRealHeight:= RealHeight - iHiddenButtonHeight -6;

    RebuildBounds;
    RealWidth:= GetRealWidth;
    RealHeight:= GetRealHeight;

    Buffer.Handle:= CreateDibSectionEx(Buffer.Canvas.Handle, RealWidth, RealHeight, @BufferBits);

    if OpacityBits <> nil
    then begin
      Desktop.GetBitmapNoLock(Buffer.Canvas.Handle, Left, Top, RealWidth, RealHeight);
      OpacityBits.GetBackgroundBits(Buffer.Handle, BufferBits);
    end;


    DY:= (RealHeight - LastRealHeight) div nSteps;

    FSelectedIndex:= itNothing;
    Include(State, fsPaintMenu);
    Paint;

    if UnhideBits = nil
    then UnhideBits:= T_AM2000_Bits.Create
    else UnhideBits.Clear;

    UnhideBits.SetSourceBitmap(Buffer.Handle, BufferBits);

    if (OpacityBits <> nil)
    then begin
      if TempBuffer = nil
      then TempBuffer:= TBitmap.Create;
      
      TempBuffer.Handle:= CreateDibSectionEx(TempBuffer.Canvas.Handle, RealWidth, RealHeight, @TempBufferBits);

      OpacityBits.Clear;
      OpacityBits.SetSourceBitmap(TempBuffer.Handle, TempBufferBits);
    end;

    SaveAnimation:= Animation;
    Animation:= anVertSlide;
    SendMessage(Handle, wm_ShowAnimated, GetCurrentTime, nTimeout);
  end;
end;

procedure TPopupMenu2000Form.OnScrollTimer(Sender: TObject);
var
  P: TPoint;
begin
  if not IsTimerSet(nShortScrollingTimeout, OnScrollTimer)
  then begin
    StopTimer;
    SetTimer(nShortScrollingTimeout, OnScrollTimer);
  end;
  
  GetCursorPos(P);
  P:= ScreenToClient(P);
  MouseDown(mbLeft, [ssLeft], P.X, P.Y);
end;

procedure TPopupMenu2000Form.DestroySubMenuForm;
var
  Msg: TMsg;
begin
  if SubMenuForm = nil then Exit;

  Include(SubMenuForm.State, fsKillAnimate);
  Include(SubMenuForm.State, fsReleaseAfterHide);
  SubMenuForm.ParentMenuForm:= nil;
  SubMenuForm.SilentHide;
  SubMenuForm:= nil;

  ProcessPaintMessages;
end;

procedure TPopupMenu2000Form.CreateSubMenuForm(Menu: TPopupMenu; Handle: HMenu; Items: TMenuItem);
var
  WP: TWindowPlacement;
begin
  if (Menu is TCustomPopupMenu2000)
  or (Menu = nil)
  then
  try
    if (not Application.ShowMainForm)
    then GetWindowPlacement(Application.Handle, @WP);

    SubMenuForm:= TPopupMenu2000Form.Create(Owner);

    if (not Application.ShowMainForm)
    and (WP.showCmd = sw_Hide)
    then ShowWindow(Application.Handle, sw_Hide);

    SubMenuForm.Font.Assign(Font);
    SubMenuForm.ParentMenuForm:= Self;
    SubMenuForm.MenuHandle:=     Handle;
    SubMenuForm.MenuItems:=      Items;
    SubMenuForm.ParentMenuIndex:=SelectedIndex;
    SubMenuForm.Animation:=      Animation;
    SubMenuForm.PopupMenu:=      PopupMenu;

    SubMenuForm.GetOptions(GetCurMenuItem, PopupMenu, SubMenuForm.Options);

  except
    SubMenuForm:= nil
  end;
end;

function TPopupMenu2000Form.GetPopupPoint(const ASelectedIndex: Integer): TPoint;
begin
  // get x and y
  if ((ParentMenuForm = nil)
  and (PopupMenu.BiDiMode <> bdLeftToRight))
  or (fsFromRightToLeft in State)
  then
    Result.X:= 5
  else begin
    Result.X:= ClientWidth -5;
    if (fsScrollBars in State)
    then Dec(Result.X, Integer(NonClientMetrics.iScrollWidth) + iScrollBarOffset);
  end;

  Result.Y:= GetItemRect(ASelectedIndex).Top - Options.Margins.Bevel
    - Options.Margins.BevelInner - Options.Margins.Border;

  if fsCtl3d in State
  then Dec(Result.Y, 2);

  if FirstVisibleIndex > 0
  then Dec(Result.Y, GetItemRect(FirstVisibleIndex).Top);
end;

procedure TPopupMenu2000Form.PopupSubMenuForm(SelectFirst: Boolean);
var
  hSubMenu: HMenu;
  Item: TMenuItem;
  Popup: TPopupMenu;
begin
  // destroy previous submenu form
  DestroySubmenuForm;

  hSubMenu:= 0;
  Popup:= nil;
  Item:= GetCurMenuItem;

  if not IsEnabled(Item)
  then Exit;

  if Item <> nil
  then begin
    if (Item is TMenuItem2000)
    and (TMenuItem2000(Item).AttachMenu <> nil)
    then begin
      Popup:= TMenuItem2000(Item).AttachMenu;
      Popup.PopupComponent:= CurMenuItem;

      TCustomPopupMenu2000(Popup).PrepareForPopup(True);
      Item:= Popup.Items;
    end;

    // if disabled or empty or no menu attached then exit
    if IsEnabled(Item)
    and HasSubmenu(Item)
    then hSubMenu:= Item.Handle
    else hSubMenu:= 0;  // = exit
  end

  // second try - use GetMenuItemInfo()
  else
  if FSelectedIndex >= 0
  then begin
    mii.fMask:= miim_State + miim_SubMenu;
    GetMenuItemInfo(MenuHandle, FSelectedIndex, True, mii);
    hSubMenu:= mii.hSubMenu;

    // if disabled then exit
    if mii.fState and (mfs_Disabled + mfs_Grayed) <> 0
    then hSubMenu:= 0; // = exit
  end;

  // check for active submenu (menu already open)
  if (SubMenuForm <> nil)
  and ((Item = SubMenuForm.MenuItems)
  or (hSubMenu = SubmenuForm.MenuHandle))
  // no submenu found - exit
  or (hSubMenu = 0)
  // trying to insert menu into own submenu
  or ((fsFraming in State) and (Item = ActiveMenuItem))
  then Exit;


  // on click event
  if (Item <> nil)
  and Assigned(Item.OnClick)
  then
    if GetCurMenuItem <> nil
    then Item.OnClick(CurMenuItem)
    else Item.OnClick(Item);

  // init popup menu
  if (Popup <> nil)
  then begin
    Popup.PopupComponent:= CurMenuItem;

    // on popup event
    if Assigned(Popup.OnPopup)
    then Popup.OnPopup(CurMenuItem);
  end;

  CreateSubMenuForm(Popup, hSubMenu, Item);


  // siblings
  if fsFamily in State
  then Include(SubMenuForm.State, fsSibling)
  else Include(State, fsFamily);

  // set first selected
  if SelectFirst
  then begin
    SubMenuForm.FSelectedIndex:= 0;
    Include(SubMenuForm.State, fsIgnoreAnimation);
  end;

  // convert point
  with ClientToScreen(GetPopupPoint(FSelectedIndex))
  do
    SubMenuForm.SetBounds(X, Y, 0, 0);

{$IFDEF Delphi4OrHigher}
  SubMenuForm.DefaultMonitor:= dmActiveForm;
{$ENDIF}

  SubMenuForm.Animate;
end;

function TPopupMenu2000Form.GetCurMenuItem: Menus.TMenuItem;
begin
  Result:= GetMenuItemIndex(SelectedIndex);
end;

function TPopupMenu2000Form.GetMenuItemByIndex(const Index: Integer;
  const Items: TMenuItem): TMenuItem;
var
  I, C: Integer;
  M: TMenuItem;
begin
  Result:= nil;
  if (Items = nil)
  or (Index < 0)
  or (Index >= GetCount(Items))
  then Exit;

  CurHiddenCount:= 0;
  C:= -1;
  for I:= 0 to GetCount(Items) -1
  do begin
    M:= Items[I];

    // menu item is not visible
    if (not IsVisible(M))
    and not (fsPreview in State)
    then Continue;

    // menu item is hidden
    if  (not (fsShowHidden in State))
    and (M is TMenuItem2000)
    and (TMenuItem2000(M).Hidden)
    then begin
      Inc(CurHiddenCount);
      Continue;
    end;

   // else
    Inc(C);
    if C = Index
    then begin
      Result:= M;
      Exit;
    end;
  end;
end;

function TPopupMenu2000Form.GetMenuItemIndex(const Index: Integer): TMenuItem;
begin
  Result:= GetMenuItemByIndex(Index, MenuItems);
  CurMenuItem:= Result;
end;

function TPopupMenu2000Form.GetIndexByMenuItem(const Item: TMenuItem): Integer;
var
  I, C: Integer;
  M: TMenuItem;
begin
  Result:= -1;
  
  if (Item = nil)
  then Exit;

  CurHiddenCount:= 0;
  C:= -1;
  for I:= 0 to GetCount(MenuItems) -1
  do begin
    M:= MenuItems[I];

    // menu item is not visible
    if (not IsVisible(M))
    and not (fsPreview in State)
    then Continue;

    // menu item is hidden
    if  (not (fsShowHidden in State))
    and (M is TMenuItem2000)
    and (TMenuItem2000(M).Hidden)
    then begin
      Inc(CurHiddenCount);
      Continue;
    end;

   // else
    Inc(C);
    if M = Item
    then begin
      Result:= C;
      Exit;
    end;
  end;
end;



{ Main Routines }

procedure TPopupMenu2000Form.CheckOrigin(const CurAnim: T_AM2000_Animation;
  var NewLeft, NewTop, NewWidth, NewHeight: Integer);
var
  X, OldTop: Integer;
  CurRect: TRect;
{$IFDEF Delphi4OrHigher}
  MonitorInfo: TMonitorInfo;
{$ELSE}
const
  SM_CXVIRTUALSCREEN = 78;
  SM_CYVIRTUALSCREEN = 79;
{$ENDIF}

  function GetAppropriateHeight(AHeight: Integer): Integer;
  var
    I, H, B, L: Integer;
  begin
    H:= AHeight - 1;

    if (BorderStyle = bsNone)
    then
      if (fsCtl3D in State)
      then B:= 2*Options.Margins.Border +4
      else B:= 2*Options.Margins.Border
    else
      B:= 0;

    Dec(H, B);

    I:= ItemRects.Count -1;
    L:= GetItemRect(I).Bottom;
    while (I > 1)
    and (L - GetItemRect(I -1).Top < H)
    do Dec(I);

    Result:= L - GetItemRect(I).Top + B +1;
  end;

begin
  NewLeft:= Left;
  NewTop:= Top;

  // calculate desktop's size without TaskBar
{$IFDEF Delphi4OrHigher}
  MonitorInfo.cbSize:= SizeOf(MonitorInfo);
  GetMonitorInfo(Monitor.Handle, @MonitorInfo);
  CurRect:= MonitorInfo.rcMonitor;
{$ELSE}
  CurRect.Left:= 0;
  CurRect.Top:= 0;

  x:= GetSystemMetrics(sm_CxScreen);
  CurRect.Right:= GetSystemMetrics(sm_CxVirtualScreen);
  if x > CurRect.Right then CurRect.Right:= x;

  x:= GetSystemMetrics(sm_CyScreen);
  CurRect.Bottom:= GetSystemMetrics(sm_CyVirtualScreen);
  if x > CurRect.Bottom then CurRect.Bottom:= x;
{$ENDIF}

  ///////////////////
  // horizontal
  ///////////////////


  if (PopupMenu = nil)
  or ({(PopupMenu.BiDiMode = bdLeftToRight)
  xor }not (fsFromRightToLeft in State))
  then begin
    Exclude(State, fsFromRightToLeft);

    // change the direction for long submenus
    if (ParentMenuForm <> nil)
    and (fsFromRightToLeft in ParentMenuForm.State)
    and (ParentMenuForm.Left - RealWidth +6 > 0)
    then begin
      NewLeft:= ParentMenuForm.Left +6;
      Include(State, fsFromRightToLeft);
    end;

    // out of right side
    if (Left + RealWidth) > CurRect.Right
    then begin
      Include(State, fsFromRightToLeft);

      if ParentMenuForm = nil
      then begin
        // topmenu
        if (PopupMenu.PopupComponent is TCustomMenuBar2000)
        or (PopupMenu.PopupComponent is TButton)
        or (PopupMenu.PopupComponent is TSpeedButton)
        then begin
          NewLeft:= CurRect.Right - RealWidth;
          Exclude(State, fsFromRightToLeft);
        end;

      end
      else begin
        // submenu
        NewLeft:= ParentMenuForm.Left +6;
      end;
    end;
  end
  else begin
    Include(State, fsFromRightToLeft);

    // out of right side
    if (Left - RealWidth) < CurRect.Left
    then begin
      Exclude(State, fsFromRightToLeft);

      if (ParentMenuForm = nil)
      and (PopupMenu <> nil)
      then begin
        // topmenu
        if (PopupMenu.PopupComponent is TCustomMenuBar2000)
        then begin
          if TCustomMenuBar2000(PopupMenu.PopupComponent).mbType = mbVertical
          then begin
            with TCustomMenuBar2000(PopupMenu.PopupComponent).aiRect
            do NewLeft:= Self.Left + (Right - Left) +1;
          end
          else begin
            NewLeft:= CurRect.Left + RealWidth;
            Include(State, fsFromRightToLeft);
          end;
        end;

        if (PopupMenu.PopupComponent is TButton)
        or (PopupMenu.PopupComponent is TSpeedButton)
        then begin
          NewLeft:= CurRect.Left + RealWidth;
          Include(State, fsFromRightToLeft);
        end;
      end
      else begin
        // submenu
        NewLeft:= ParentMenuForm.Left + ParentMenuForm.Width -6;
      end;
    end;
  end;

  // out of left side
  if NewLeft < CurRect.Left
  then NewLeft:= CurRect.Left;


  ///////////////////
  // vertical
  ///////////////////

  Exclude(State, fsFromBottomToTop);

  // out of bottom side
  if (Top + RealHeight) > CurRect.Bottom
  then begin
    if ParentMenuForm = nil
    then begin
      OldTop:= NewTop;

      // menu shouldn't hide a menu button
      if (PopupMenu.PopupComponent is TCustomMenuBar2000)
      then
        with TCustomMenuBar2000(PopupMenu.PopupComponent) do
          if mbType = mbVertical
          then
            NewTop:= CurRect.Bottom
          else
            NewTop:= NewTop - (aiRect.Bottom - aiRect.Top +1);

      // menu shouldn't hide other buttons
      if (PopupMenu.PopupComponent is TButton)
      then
        with TButton(PopupMenu.PopupComponent) do
          NewTop:= NewTop - Height -1;

      if (PopupMenu.PopupComponent is TSpeedButton)
      then
        with TSpeedButton(PopupMenu.PopupComponent) do
          NewTop:= NewTop - Height -1;

      // can we fit the menu into the upper part of the screen?
      if OldTop > RealHeight
      then // yes
        Include(State, fsFromBottomToTop)

      else begin // no
        NewTop:= OldTop;
        Include(State, fsScrollBars);
        
        RealHeight:= GetAppropriateHeight(CurRect.Bottom - NewTop);
        RealWidth:= GetRealWidth;

        if not (CurAnim in [anHorzStretch, anDoubleStretch, anHorzSlide, anDoubleSlide])
        then NewWidth:= RealWidth;

        if not (CurAnim in [anVertStretch, anDoubleStretch, anVertSlide, anDoubleSlide])
        then NewHeight:= RealHeight;
      end;

    end
    else begin
      if RealHeight < CurRect.Bottom
      then
        NewTop:= CurRect.Bottom - RealHeight

      else begin
        Include(State, fsScrollBars);

        RealWidth:= GetRealWidth;

        RealHeight:= GetAppropriateHeight(CurRect.Bottom);
        NewTop:= CurRect.Bottom - RealHeight;

        if not (CurAnim in [anHorzStretch, anDoubleStretch, anHorzSlide, anDoubleSlide])
        then NewWidth:= RealWidth;

        if not (CurAnim in [anVertStretch, anDoubleStretch, anVertSlide, anDoubleSlide])
        then NewHeight:= RealHeight;
      end;
    end;
  end;

  // out of top side
  if NewTop < CurRect.Top
  then NewTop:= CurRect.Top;

end;


function TPopupMenu2000Form.Animate: Boolean;
var
  CurAnim: T_AM2000_Animation;
  X, NewLeft, NewTop, NewWidth, NewHeight: Integer;
  BoolTemp: Bool;
  dbits: PDeltaArray;
  bits0, bits1: PByteArray;

  function GetCurAnimFromMenuBar(const ADefault: T_AM2000_Animation): T_AM2000_Animation;
  begin
    if (PopupMenu <> nil)
    and (PopupMenu.PopupComponent is TCustomMenuBar2000)
    then
      if (TCustomMenuBar2000(PopupMenu.PopupComponent).mbType = mbVertical)
      then begin
        Result:= anHorzSlide;
      end
      else
        Result:= anVertSlide

    else
      Result:= ADefault;
  end;

begin
  LockGlobalRepaint;
  InitializeMenuState;

  DX:= 1;
  DY:= 1;
  Result:= True;
  CurAnim:= anNone;
  CurHiddenCount:= 0;
  FocusItem:= nil;
  Include(State, fsAnimated);
  Exclude(State, fsKillAnimate);
  if nFirstStage < 1 then nFirstStage:= 1;


  // calculate normal height and width.
  // RealWidth and RealWidth -- width and height of the full opened window
  RebuildBounds;
  RealWidth:= GetRealWidth;
  RealHeight:= GetRealHeight;



  // top, left -- real coordinates (click)
  // width, height = 0
  // RealWidth, RealHeight -- real width and height
  // newleft, newtop, newheight, newwidth -- what to show next

  // code for calculation animation steps
  if (fsPreview in State)
  or (fsFraming in State)
  or (fsIgnoreAnimation in State)
  then begin
    NewWidth:= RealWidth;
    NewHeight:= RealHeight;
    Animation:= anNone;
    CurAnim:= anNone;
  end
  else
  if (ParentMenuForm <> nil)
  or (PopupMenu = nil)
  or (not (fsIgnoreAnimation in State))
  then begin
    CurAnim:= Animation;
    if CurAnim = anRandom
    then begin
      if Random(2) = 0
      then CurAnim:= anHorzSlide
      else CurAnim:= anVertSlide;
    end;

    if CurAnim = anSlide
    then begin
      Animation:= anHorzSlide;
      CurAnim:= GetCurAnimFromMenuBar(anVertSlide);
    end;

    if CurAnim = anStretch
    then begin
      Animation:= anHorzStretch;
      CurAnim:= anVertStretch;
    end;

    if CurAnim = anPopup
    then begin
      Animation:= anHorzSlide;
      CurAnim:= anDoubleSlide;
    end;

    if CurAnim = anRoll
    then begin
      Animation:= anHorzRoll;
      CurAnim:= anVertRoll;
    end;


    if CurAnim = anDefault
    then begin
      // animation
      if not SystemParametersInfo(SPI_GetMenuAnimation, 0, @BoolTemp, 0)
      then begin // Win95
        Animation:= anHorzSlide;
        CurAnim:= GetCurAnimFromMenuBar(anUnfold);
      end

      else // Win98/Me/2K/XP - no animation
      if not BoolTemp
      then begin
        CurAnim:= anNone;
        Animation:= anNone;
      end

      else begin // Win98/Me/2K/XP with animation
        if not SystemParametersInfo(SPI_GetMenuFade, 0, @BoolTemp, 0)
        then BoolTemp:= False;

        if BoolTemp
        then begin // win2k/XP with fade animation
          Animation:= anFade;
          CurAnim:= anFade;
        end
        else begin // standard animation
          Animation:= anHorzSlide;
          CurAnim:= GetCurAnimFromMenuBar(anUnfold);
        end;
      end;
    end;

    if (fsSibling in State)
    and not (mfAnimationOnSiblings in Options.Flags)
    then CurAnim:= anNone;

    if CurAnim in anHorizontalAnimations
    then DX:= RealWidth div nSteps;
    if DX < 3 then DX:= 3;

    if CurAnim in anVerticalAnimations
    then DY:= RealHeight div nSteps;
    if DY < 3 then DY:= 3;

    if CurAnim in anHorizontalAnimations
    then NewWidth:= RealWidth div nFirstStage
    else NewWidth:= RealWidth;

    if NewWidth < 1
    then NewWidth:= 1;

    if CurAnim in anVerticalAnimations
    then NewHeight:= RealHeight div nFirstStage - DY
    else NewHeight:= RealHeight;

    if NewHeight < 1
    then NewHeight:= 1;
    
  end
  else begin
    NewWidth:= RealWidth;
    NewHeight:= RealHeight;
    if Animation in [anSlide, anPopup, anRoll]
    then Animation:= anHorzSlide;
    if Animation in [anStretch]
    then Animation:= anHorzStretch;
  end;


  // code to arrange menu form
  FirstVisibleIndex:= 0;
  LastVisibleIndex:= 0;

  // check origin
  CheckOrigin(CurAnim, NewLeft, NewTop, NewWidth, NewHeight);

  ///////////////////
  // final settings
  ///////////////////

  if (fsFromBottomToTop in State)
  then NewTop:= NewTop - NewHeight +1;

  if (fsFromRightToLeft in State)
  then NewLeft:= NewLeft - NewWidth +1;

  SetBounds(NewLeft, NewTop, NewWidth, NewHeight);

  Buffer.Handle:= CreateDibSectionEx(Buffer.Canvas.Handle, RealWidth, RealHeight, @BufferBits);

  // correct VisibleItemsCount
  if fsScrollbars in State
  then begin
    LastVisibleIndex:= GetLastVisibleIndex;
  end
  else
    LastVisibleIndex:= ItemRects.Count -1;


  //////////////////////
  // act!
  //////////////////////

  // check if mouse already moved
  ProcessMouseMoveMessages;
  if (fsKillAnimate in State)
  then begin
    Exclude(State, fsAnimated);
    UnLockGlobalRepaint;
    Result:= False;
    Exit;
  end;


  // reserve desktop
  if GetDropShadow
  and not Assigned(pSetLayeredWindowAttributes)
  then Desktop.GetBitmap(0, NewLeft, NewTop, RealWidth, RealHeight);

  // calculate raised item rect
  if (mfRaiseMenuBarItem in Options.Flags)
  and (ParentMenuForm = nil)
  and (PopupMenu.PopupComponent is TCustomMenuBar2000)
  then
    with TCustomMenuBar2000(PopupMenu.PopupComponent)
    do
      if mbType = mbVertical
      then begin
        BoolTemp:= (fsFromRightToLeft in State);
        RaisedForm.DrawBevel(not BoolTemp, BoolTemp, True, True);
      end
      else begin
        BoolTemp:= (fsFromBottomToTop in State);
        RaisedForm.DrawBevel(True, True, not BoolTemp, BoolTemp);
      end;


  // set layered windows
  if Assigned(pSetLayeredWindowAttributes)
  then begin
    X:= GetWindowLong(Handle, gwl_ExStyle);

    if (Options.Opacity <> 100)
    or (CurAnim = anFade)
    then begin
      if X and ws_ex_Layered = 0
      then SetWindowLong(Handle, gwl_ExStyle, X or ws_ex_Layered)
    end
    else
      if X and ws_ex_Layered <> 0
      then SetWindowLong(Handle, gwl_ExStyle, X and not ws_ex_Layered);
  end;

  // init desktop background
  Include(State, fsPaintMenu);
  if (Options.Opacity <> 100)
  then
    // Windows 2K+
    if Assigned(pSetLayeredWindowAttributes)
    then begin
      X:= Round((255 * Options.Opacity)/100);
      pSetLayeredWindowAttributes(Handle, 0, X, lwa_Alpha);

      if DropShadow <> nil
      then DropShadow.Opacity:= X;
    end

    // older version of Windows
    else begin
      if OpacityBits = nil
      then OpacityBits:= T_AM2000_Bits.Create
      else OpacityBits.Clear;

      if (CurAnim = anFade)
      or (CurAnim in anStretchAnimations)
      then begin // middle buffer is needed
        if TempBuffer = nil
        then TempBuffer:= TBitmap.Create;
        
        TempBuffer.Handle:= CreateDibSectionEx(TempBuffer.Canvas.Handle, RealWidth, RealHeight, @TempBufferBits);

        OpacityBits.SetSourceBitmap(TempBuffer.Handle, TempBufferBits);
      end
      else begin
        OpacityBits.SetSourceBitmap(Buffer.Handle, BufferBits);
      end;


      // reserve desktop bitmap
      Desktop.GetBitmapNoLock(Buffer.Canvas.Handle, NewLeft, NewTop, RealWidth, RealHeight);
      OpacityBits.GetBackgroundBits(Buffer.Handle, BufferBits);

      // create alpha
      if (MenuOpacity <> Options.Opacity)
      then begin
        MenuOpacity:= Options.Opacity;
        BuildOpacityData(Options.Opacity, MenuOpacityData);
      end;

      if (TempBuffer = nil)
      then Paint;
    end
    
  else begin
    TempBuffer.Free;
    TempBuffer:= nil;
    OpacityBits.Free;
    OpacityBits:= nil;
  end;



  // old animation
  if (CurAnim in anStretchAnimations)
  or ((CurAnim = anFade)
  and (not Assigned(pSetLayeredWindowAttributes)))
  then begin
    if AnimationBits = nil
    then AnimationBits:= T_AM2000_Bits.Create
    else AnimationBits.Clear;

    AnimationBits.SetSourceBitmap(Buffer.Handle, BufferBits);

    if (CurAnim = anFade)
    then begin
      Desktop.GetBitmapNoLock(Buffer.Canvas.Handle, NewLeft, NewTop, RealWidth, RealHeight);
      AnimationBits.GetBackgroundBits(Buffer.Handle, BufferBits);
    end;
  end;

  Paint;


  // init fade in animation
  if (CurAnim = anFade)
  then begin
    CurStep:= 1;

    // fade animation using Windows2K features
    if Assigned(pSetLayeredWindowAttributes)
    then begin
      pSetLayeredWindowAttributes(Handle, 0, 0, lwa_Alpha);

      if DropShadow <> nil
      then DropShadow.Opacity:= 0;
    end

    // old Win9x animation
    else begin
      // iterate
      dbits:= AnimationBits.Delta;
      bits1:= AnimationBits.Source;
      bits0:= AnimationBits.Background;

      for X:= 0 to AnimationBits.BitsSize -1
      do begin
        dbits[X]:= Trunc((bits1[X] - bits0[X]) / nSteps);
      end;

      AnimationBits.MoveBackgroundToDestination;

      if (TempBuffer <> nil)
      and (OpacityBits <> nil)
      then begin
        Desktop.GetBitmap(TempBuffer.Canvas.Handle, NewLeft, NewTop, RealWidth, RealHeight);
      end
      else
        Desktop.GetBitmap(Buffer.Canvas.Handle, NewLeft, NewTop, RealWidth, RealHeight);
    end;
  end;
  

  SilentShow;

  if MenuSoundResource
  then PlaySound(PChar(MenuPopupSound), HInstance, snd_Resource + snd_Async + snd_NoDefault + snd_NoStop)
  else sndPlaySound(PChar(MenuPopupSound), snd_Async + snd_NoDefault + snd_NoStop);

  if CurAnim = anNone
  then CurStep:= nSteps;

  SendMessage(Handle, wm_ShowAnimated, GetCurrentTime, nTimeout);
end;

procedure TPopupMenu2000Form.wmKillAnimation(var Msg: TMessage);
  // cancels active animation
var
  CanClose: Boolean;  
begin
  if (Msg.WParam = 0)
  and (PopupMenu <> nil)
  and Assigned(PopupMenu.OnCloseQuery)
  then begin
    Msg.Result:= 0;
    CanClose:= True;

    if PopupMenu.PopupComponent is TCustomMenuBar2000
    then PopupMenu.OnCloseQuery(TCustomMenuBar2000(PopupMenu.PopupComponent).Menu, CanClose)
    else PopupMenu.OnCloseQuery(PopupMenu, CanClose);
    
    if not CanClose
    then Exit; 
  end;


  if fsBecomingDraggable in State then Exit;
  Include(State, fsKillAnimate);
  Exclude(State, fsAnimated);
  Exclude(State, fsIgnoreNextMenuUp);

  // process submenu
  if (SubMenuForm <> nil)
  then SubMenuForm.Perform(wm_KillAnimation, 0, 0);

  Msg.Result:= 1;
end;

procedure TPopupMenu2000Form.wmShowAnimated(var Msg: TMessage);
var
  CT, X, X1, NewLeft, NewTop, NewWidth, NewHeight: Integer;
  dbits: PDeltaArray;
  bits0: PByteArray;
  P: TPoint;
begin
  if (fsKillAnimate in State)
  then Exit;

  // delay
  CT:= Msg.LParam - (GetCurrentTime - Msg.WParam);
  if (CT > 0)
  and (CT < 1000)
  then Sleep(CT)
  else CT:= 1;

  NewLeft:= Left;
  NewTop:= Top;
  NewWidth:= Width;
  NewHeight:= Height;
  Msg.LParam:= 0;

  if Animation = anFadeIn
  then begin
    if (CurStep < (nSteps * Options.Opacity / 100))
    then begin
      TimeStart:= GetCurrentTime;

      if Assigned(pSetLayeredWindowAttributes)
      then begin
        X:= Round((255 * CurStep)/nSteps);

        Sleep(nTimeout);
        pSetLayeredWindowAttributes(Handle, 0, X, lwa_Alpha);

        if DropShadow <> nil
        then DropShadow.Opacity:= X;
      end

      else begin
        dbits:= AnimationBits.Delta;
        bits0:= AnimationBits.Destination;

        for X:= 0 to AnimationBits.BitsSize -1
        do
          if dbits[X] <> 0
          then begin
            X1:= bits0[X] + dbits[X];
            if X1 > 255
            then bits0[X]:= 255
            else
            if X1 < 0
            then bits0[X]:= 0
            else bits0[X]:= X1;
          end;

        AnimationBits.SetDestinationBitsToCanvas(Canvas.Handle, 0, 0, RealWidth, RealHeight, 0, 0);
      end;

      ProcessMouseMoveMessages;
      ProcessPaintMessages;

      if fsKillAnimate in State
      then Exit;

      CT:= GetCurrentTime;
      Inc(CurStep);
      PostMessage(Handle, wm_ShowAnimated, CT, nTimeout - (CT - TimeStart));

      Exit;
    end;

    Include(State, fsPaintMenu);
    Paint;
  end
  else begin
    // Animation!
    while (Width < RealWidth) or (Height < RealHeight)
    do begin
      // calculate the time wasted on drawing
      TimeStart:= GetCurrentTime;

      if NewWidth < RealWidth
      then
        if (NewWidth + DX) >= RealWidth
        then Break
        else begin
          NewWidth:= NewWidth + DX;
          if fsFromRightToLeft in State
          then NewLeft:= NewLeft - DX;
        end;

      if NewHeight < RealHeight
      then
        if (NewHeight + DY) >= RealHeight
        then Break
        else begin
          NewHeight:= NewHeight + DY;
          if fsFromBottomToTop in State
          then NewTop:= NewTop - DY;
        end;

      SetBounds(NewLeft, NewTop, NewWidth, NewHeight);

      if DropShadow <> nil
      then DropShadow.Update;

      ProcessMouseMoveMessages;

      if fsKillAnimate in State
      then Exit;

      // adjust delay
      CT:= GetCurrentTime;
      PostMessage(Handle, wm_ShowAnimated, CT, nTimeout - (CT - TimeStart));

      Exit;
    end;

    // final setting bounds
    NewTop:= GetRealTop;
    NewLeft:= GetRealLeft;
    
    // finish
    if (Width <> RealWidth)
    or (Height <> RealHeight)
    then SetBounds(NewLeft, NewTop, RealWidth, RealHeight)
    else Include(State, fsPaintMenu);

    if DropShadow <> nil
    then DropShadow.Update;
  end;

  if (OpacityBits <> nil)
  and (TempBuffer <> nil)
  then begin
    OpacityBits.SetSourceBitmap(Buffer.Handle, BufferBits);
    TempBuffer.Free;
    TempBuffer:= nil;
  end;

  // finish animation
  if AnimationBits <> nil
  then begin
    AnimationBits.Clear;
    PaintBufferOnCanvas(Canvas.Handle, True);
  end;
  

  if Assigned(pSetLayeredWindowAttributes)
  then begin
    X:= Round(2.55 * Options.Opacity);

    pSetLayeredWindowAttributes(Handle, 0, X, lwa_Alpha);

    if DropShadow <> nil
    then DropShadow.Opacity:= X;
  end;

  LastRealHeight:= 0;

  if fsNewUnhide in State
  then begin
    Exclude(State, fsNewUnhide);
    UnhideBits.Clear;
    Animation:= SaveAnimation;
  end;


  // finalization
  Exclude(State, fsAnimated);
  Exclude(State, fsKillAnimate);
  Include(State, fsAllowFreeMem);
  UnLockGlobalRepaint;

  if Assigned(PopupMenu)
  and (SelectedIndex <> -1)
  then SetTimer(nPopupSubmenuTimeout, OnPopupTimer);

{  // reposition cursor
  GetCursorPos(P);
  X:= P.X;

{  SetSelectedIndex(2);
  with GetItemRect(2)
  do P.Y:= (Top + Bottom) div 2;
  P:= ClientToScreen(P);
  SetCursorPos(X, P.Y);}
end;

{$IFDEF Delphi3}
const
  TB_GETHOTITEM = WM_USER + 71;
type
  T_AM2000_ToolButton = class(TToolButton)
  public
    property Index;
  end;
{$ENDIF}

procedure TPopupMenu2000Form.SilentShow;
var
  TopMostForm: TPopupMenu2000Form;
{$IFDEF Delphi3OrHigher}
  I, TbIndex: Integer;
  T: TToolbar;
  TB: TToolButton;
{$ENDIF}
begin
  // special check for tray-icon menu
  FullHideCaret;
  RebuildToolTipWindow(False);

  Exclude(State, fsDisabled);

  Color:= Options.Colors.Menu;

  // show window
  ShowWindow(Handle, sw_ShowNoActivate);
  SetWindowPos(Handle, hwnd_TopMost, Left, Top, Width, Height, FormFlags);


  // initialize drop shadow
  if GetDropShadow
  then begin
    if (DropShadow = nil)
    then DropShadow:= T_AM2000_DropShadow.Create(Self);

    DropShadow.Color:= Options.Colors.DropShadow;

    if (Animation = anFade)
    then DropShadow.Opacity:= 0
    else
    if Options.Opacity < 100
    then DropShadow.Opacity:= Round((255 * Options.Opacity)/100);

    TopMostForm:= Self;
    while TopMostForm.ParentMenuForm <> nil
    do TopMostForm:= TopMostForm.ParentMenuForm;

    DropShadow.Show(TopMostForm.Handle);


    if (PopupMenu <> nil)
    and (PopupMenu.PopupComponent is TCustomMenuBar2000)
    and (TCustomMenuBar2000(PopupMenu.PopupComponent).RaisedForm <> nil)
    then
      with TCustomMenuBar2000(PopupMenu.PopupComponent).RaisedForm
      do
        SetWindowPos(Handle, hwnd_Top, Left, Top, Width, Height, FormFlags);
  end
  else begin
    if DropShadow <> nil
    then DropShadow.Free;

    DropShadow:= nil;
  end;

  GdiFlush;



  if ActiveDragWindow <> nil
  then
    with ActiveDragWindow
    do begin
      SetWindowPos(Handle, 0, Left, Top, Width, Height, FormFlags);
    end;

  // set mouse capture
  MouseCaptureControl:= GetCaptureControl;
  if (MouseCaptureControl <> nil)
  and (MouseCaptureControl <> ActiveDragWindow)
  then SetCaptureControl(Self)
  else MouseCaptureControl:= nil;

  // set toolbar button state
{$IFDEF Delphi3OrHigher}
  if PopupMenu.PopupComponent is TToolbar
  then begin
    T:= TToolbar(PopupMenu.PopupComponent);
    if T.Perform(tb_GetHotItem, 0, 0) = -1
    then
      for I:= 0 to T.ButtonCount -1
      do begin
        TB:= T.Buttons[I];
{$IFDEF Delphi3}
        TBIndex:= T_AM2000_ToolButton(TB).Index;
{$ELSE}
        TBIndex:= TB.Index;
{$ENDIF}
        if (TB.DropdownMenu = PopupMenu)
        and (T.Perform(tb_IsButtonPressed, TBIndex, 0) = 0)
        then T.Perform(tb_PressButton, TBIndex, 1);
      end;
  end;
{$ENDIF}

  Inc(FormsCount);
  ProcessPaintMessages;
end;

procedure TPopupMenu2000Form.SilentHide;
  // hides the current window
begin
  StopTimer;
  Include(State, fsKillAnimate);

  // destroy submenu forms
  if SubMenuForm <> nil
  then begin
    Include(SubMenuForm.State, fsReleaseAfterHide);
    SubMenuForm.ParentMenuForm:= nil;
    SubMenuForm.SilentHide;
    SubMenuForm:= nil;
  end;

  if DropShadow <> nil
  then begin
    DropShadow.Free;
    DropShadow:= nil;
  end;

  if fsBecomingDraggable in State
  then begin
    // false alarm
    SetTimer(nPopupSubmenuTimeout, OnPopupTimer);
    Exit;
  end;

  if (Width <> 0)
  or (Height <> 0)
  then begin
    ShowWindow(Handle, sw_Hide);
    SetBounds(Left, Top, 0, 0);

    Dec(FormsCount);
  end;

  // OnExit event
  if (not (fsPreview in State))
  and (GetCurMenuItem <> nil)
  and (CurMenuItem is TMenuItem2000)
  and Assigned(TMenuItem2000(CurMenuItem).OnExit)
  then TMenuItem2000(CurMenuItem).OnExit(CurMenuItem);

  FSelectedIndex:= itNothing;

//  ProcessPaintMessages;

  // remove arrays
  if OpacityBits <> nil
  then OpacityBits.Clear;

  // release desktop
  Desktop.Release(Left, Top, RealWidth, RealHeight);

  // play close sound
  if MenuSoundResource
  then PlaySound(PChar(MenuCloseSound), HInstance, snd_Resource + snd_Async + snd_NoDefault + snd_NoStop)
  else sndPlaySound(PChar(MenuCloseSound), snd_Async + snd_NoDefault + snd_NoStop);

  // removing too tips
  if ToolTipWindow <> nil
  then begin
    ToolTipWindow.Free;
    ToolTipWindow:= nil;
  end;

  // emptying background
  Back.Handle:= 0;

  // fire OnMenuClose

  // mouse capture
  if MouseCaptureControl <> nil
  then begin
    SetCaptureControl(MouseCaptureControl);
    MouseCaptureControl:= nil;
  end
  else
  if ActiveDragWindow <> nil
  then SetCaptureControl(ActiveDragWindow);

  // place message
//  PlaceToolMenuMsg(Handle, wm_MenuSelect, $FFFF0000, 0);

  if FormsCount = 0
  then Desktop.Clear;

  if fsReleaseAfterHide in State
  then Release;
end;

procedure TPopupMenu2000Form.AnimatedHide;
  // hides the current window
begin

end;

procedure TPopupMenu2000Form.Repaint;
begin
  if (fsAnimated in State)
  or (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  then Exit;

  Include(State, fsPaintMenu);
  Paint;

  if SubMenuForm <> nil
  then SubMenuForm.Repaint;

  if (ActiveDragWindow <> nil)
  then ActiveDragWindow.Repaint;
end;

procedure TPopupMenu2000Form.WMKillTimer(var Msg: TMessage);
begin
  StopTimer;

  // process submenu
  if (SubMenuForm <> nil)
  then SubMenuForm.Perform(wm_KillTimer, 0, 0);
end;

procedure TPopupMenu2000Form.wmSilentHide(var Msg: TMessage);
begin
  if Msg.WParam = 0
  then SilentHide
  else DestroySubMenuForm;
end;


{ Get Routines }

function TPopupMenu2000Form.GetMenuItemHeight(const M: TMenuItem): Integer;
var
  Lines, ImagesHeight: Integer;
  C: String;
begin
  Result:= 0;
  if M = nil then Exit;

  C:= GetCaption(M);
  if IsSeparatorItem(M)
  then begin
    Result:= Options.Margins.Separator;
    case C[1] of
      sDoubleSeparator: Inc(Result, 2);
      sDottedSeparator: Inc(Result, 1);
      sDoubleDottedSeparator: Inc(Result, 4);
      sEmptySeparator: Inc(Result, 2);
    end;
    Exit;
  end;

  Lines:= GetNumLines(C);
  Inc(Result, (ItemHeight -3) * Lines +3 + 2*Options.Margins.Frame);

  if not (M is TMenuItem2000)
  then Exit;

  with TMenuItem2000(M) do
  begin
    if (Control <> ctlNone)
    then
      Result:= TMenuItem2000(M).GetHeight(Buffer.Canvas, Self.Options)
    else
      if Hidden
      and not (fsHiddenAsRegular in State)
      then Inc(Result, 2);

    if HasBitmap
    and (Result < Bitmap.Height +4)
    then Result:= Bitmap.Height +4;

    if (DefaultIndex >= 0)
    and (Result < 20)
    then Result:= 20;

    if (M.Parent <> nil)
{$IFNDEF Delphi5OrHigher}
    and (M.Parent is TMenuItem2000)
    and (TMenuItem2000(M.Parent).SubMenuImages <> nil)
{$ELSE}
    and (M.Parent.SubMenuImages <> nil)
{$ENDIF}
    then
      ImagesHeight:= TMenuItem2000(M.Parent).SubMenuImages.Height

    else
    if Self.PopupSkin.Images <> nil
    then
      ImagesHeight:= TImageList(Self.PopupSkin.Images).Height
    else
      ImagesHeight:= 0;

    if (ImageIndex >= 0)
    and (Result < ImagesHeight +4)
    then Result:= ImagesHeight +4;
  end;
end;

function TPopupMenu2000Form.GetMenuItemHeightIndex(Index: Integer): Integer;
begin
  with GetItemRect(Index) do Result:= Bottom - Top;
end;


{ Painting }

procedure TPopupMenu2000Form.InitializePaintParams;
const
  BiDiModeToState: array [TBiDiMode] of T_AM2000_its =
    (isLeftToRight, am2000options.isRightToLeft, isRightToLeftNoAlign, isRightToLeftReadingOnly);
var
  BoolTemp: Bool;
begin
  with PaintParams, mir
  do begin
    State:= [];

    Canvas:= Buffer.Canvas;
    Handle:= Self.MenuHandle;
    PaintOptions:= Self.Options;
    MouseState:= Self.MouseState;
    FullRepaint:= fsPaintMenu in Self.State;

    // set ParentFont
    if (PaintOptions.Colors.MenuText = clMenuText)
    then PaintOptions.Colors.MenuText:= Font.Color;

    // show accels
    if (fsShowAccelerators in Self.State)
    or (not SystemParametersInfo(SPI_GetMenuUnderlines, 0, @BoolTemp, 0))
    then BoolTemp:= True;
    SetState(State, isShowAccelerators, BoolTemp);
    SetState(State, isCtl3d, (fsCtl3d in Self.State));

    // bidimode
    Include(State, BiDiModeToState[PopupMenu.BiDiMode]);


    if (MenuItems <> nil)
    and (MenuItems.Parent <> nil)
  {$IFDEF Delphi5OrHigher}
    and (MenuItems.Parent.SubMenuImages <> nil)
  {$ELSE}
    and (MenuItems.Parent is TMenuItem2000)
    and (TMenuItem2000(MenuItems.Parent).SubMenuImages <> nil)
  {$ENDIF}
    then
      Images:= TImageList(TMenuItem2000(MenuItems.Parent).SubMenuImages)
    else
      Images:= PopupSkin.Images;

    DisabledImages:= PopupSkin.DisabledImages;
    HotImages:= PopupSkin.HotImages;

    // calculate bounds
    Width:= Buffer.Width;
    if (fsCtl3D in Self.State)
    and (BorderStyle = bsNone)
    then Ctl3DWidth:= 2
    else Ctl3DWidth:= 0;

    Border:= Ctl3DWidth + Options.Margins.Border + Options.Margins.Bevel + Options.Margins.BevelInner;
    LineLeft:= Border;
    LineRight:= Width - Border;

    if fsScrollBars in Self.State
    then
      if isLeftToRight in State
      then Dec(LineRight, Integer(NonClientMetrics.iScrollWidth) + iScrollBarOffset);

    ItemWidth:= Self.ItemWidth;
    ShortcutWidth:= Self.ShortcutWidth;

    if Options.HasTitle
    and Options.Title.Visible
    then
      with mir, Options.Title do
        case Position of
          atLeft:
            begin
              LeftTitleWidth:= Width;
              TitleWidth:= LeftTitleWidth;
              Inc(LineLeft, LeftTitleWidth);
              if BorderStyle <> bsNone
              then Inc(LineLeft, 1);
            end;
          atRight:
            begin
              LeftTitleWidth:= 0;
              TitleWidth:= Width;
              Dec(LineRight, TitleWidth);
              if BorderStyle <> bsNone
              then Dec(LineRight, 1);
            end;
        end

    else begin
      LeftTitleWidth:= 0;
      TitleWidth:= 0;
    end;

    GraphLeft:= Ctl3dWidth + LeftTitleWidth + Options.Margins.Bevel + Options.Margins.BevelInner;
    GraphWidth:= Width - TitleWidth - 2 * (Ctl3dWidth + Options.Margins.Bevel + Options.Margins.BevelInner);

    if (Options.HasColors)
    and (Options.Colors.Gutter <> clNone)
    and (Options.Margins.Gutter <> 0)
    and (Options.Margins.Left >= Options.Margins.Gutter)
    then begin
      Inc(GraphLeft, Options.Margins.Gutter);//:= GraphLeft + Options.Margins.Gutter;
      Dec(GraphWidth, Options.Margins.Gutter);
    end;

    if PopupMenu.BiDiMode = bdLeftToRight
    then begin
      ItemLeft:= LineLeft + Options.Margins.Left;
      ShortcutLeft:= LineRight - Options.Margins.Right - ShortcutWidth;
      TriangleWidth:= Options.Margins.Right -4;
      TriangleLeft:= LineRight - TriangleWidth -2;

      // bitmap on the gutter
      BitmapLeft:= LineLeft;

    end
    else begin
      ShortcutLeft:= LineLeft + Options.Margins.Left;
      ItemLeft:= LineRight - Options.Margins.Right - ItemWidth;
      TriangleWidth:= Options.Margins.Left -4;
      TriangleLeft:= Border;

      BitmapLeft:= LineRight - Options.Margins.Right +4;
    end;

    if Options.Colors.Gutter <> clNone
    then
      BitmapWidth:= Options.Margins.Gutter
    else
      if isLeftToRight in State
      then BitmapWidth:= Options.Margins.Left -3
      else BitmapWidth:= Options.Margins.Right -3;
  end;
end;

procedure TPopupMenu2000Form.PaintFrame3D;
var
  R: TRect;
begin
  with Buffer, Canvas
  do begin
    R:= ClipRect;

    if (BorderStyle = bsNone)
    and (fsCtl3D in State)
    then DrawEdge(Handle, R, bdr_RaisedInner + bdr_RaisedOuter, bf_Rect);
  end;
end;

procedure TPopupMenu2000Form.PaintBevelAndBorder(const Bounds: TRect);
var
  R, RG: TRect;
  X, XLeft, XRight: Integer;
  M: TMenuItem;
  F: T_AM2000_RaisedItemForm;

  procedure GetSidePoints(Side: T_AM2000_Side; var P1, P2: TPoint);
  begin
    case Side of
      sdTop:
        begin P1:= R.TopLeft; P2:= Point(R.Right, R.Top); end;
      sdBottom:
        begin P1:= Point(R.Left, R.Bottom); P2:= R.BottomRight; end;
      sdLeft:
        begin P1:= R.TopLeft; P2:= Point(R.Left, R.Bottom); end;
      sdRight:
        begin P1:= Point(R.Right, R.Top); P2:= R.BottomRight; end;
    end;
  end;

  procedure EraseOverridenPart(Side1, Side2: T_AM2000_Side);
  var
    P1, P2: TPoint;
  begin
    IntersectRect(R, Rect(0, 0, RealWidth, RealHeight), R);

    with Buffer, Canvas
    do begin
      if Options.Colors.Gutter <> clNone
      then Pen.Color:= Options.Colors.Gutter
      else Pen.Color:= Options.Colors.Menu;

      GetSidePoints(Side1, P1, P2);
      PolyLine([P1, P2]);

      if Back.Empty
      or (Options.HasColors
      and (Options.Colors.Gutter <> clNone)
      and (Options.HasMargins
      or ((Options.Margins.Gutter = 0)
      or (Options.Margins.Left >= Options.Margins.Gutter))))
      then begin
        if Side2 in [sdRight, sdLeft]
        then Pen.Color:= Options.Colors.Gutter
        else Pen.Color:= Options.Colors.Menu;

        GetSidePoints(Side2, P1, P2);
        PolyLine([P1, P2]);
      end;
    end;
  end;

  procedure DrawBevel(const BevelDelta, BevelWidth: Integer; const Color1, Color2: TColor);
    // draws full bevel or part of it
  var
    R: TRect;
  begin
    R:= Bounds;
    InflateRect(R, -BevelDelta, 0);

    if R.Top > 0
    then
      with Buffer.Canvas
      do begin
        Dec(R.Right);
        if (PaintParams.mir.Ctl3dWidth > 0)
        then InflateRect(R, -PaintParams.mir.Ctl3dWidth, 0);

        Pen.Width:= BevelWidth;
        Pen.Color:= Color1;
        Polyline([R.TopLeft, Point(R.Left, R.Bottom)]);
        Pen.Color:= Color2;
        Polyline([Point(R.Right, R.Top), R.BottomRight]);
      end
      
    else begin
      InflateRect(R, 0, -BevelDelta);
      
      if (PaintParams.mir.Ctl3dWidth > 0)
      then InflateRect(R, -PaintParams.mir.Ctl3dWidth,
        -PaintParams.mir.Ctl3dWidth);

      Frame3D(Buffer.Canvas,
        R,
        Color1,
        Color2,
        BevelWidth);
    end;
  end;

begin
  with Buffer, Canvas, PaintParams.mir, Options.Margins
  do begin
    X:= Bevel + BevelInner + Ctl3dWidth;
    XLeft:= Bounds.Left + X + LeftTitleWidth;
    XRight:= Bounds.Right - X - TitleWidth + LeftTitleWidth;

    if Border <> 0
    then
      if Back.Empty
      then begin
        if Brush.Style <> bsSolid
        then Brush.Style:= bsSolid;

        // border
        if Brush.Color <> Options.Colors.Border
        then Brush.Color:= Options.Colors.Border;
        if Pen.Color <> Options.Colors.Border
        then Pen.Color:= Options.Colors.Border;

        FillRect(Rect(XLeft, Bounds.Top + X, XLeft + Border, Bounds.Bottom - X)); // left
        FillRect(Rect(XRight - Border, Bounds.Top + X, XRight, Bounds.Bottom - X)); // right

        // fill top border -- no Bounds
        R:= Rect(XLeft, X, XRight, X + Border);
        M:= GetMenuItemIndex(FirstVisibleIndex);
        if (M is TMenuItem2000)
        and (TMenuItem2000(M).Hidden)
        then begin
          R.Top:= 0;
          if Options.Colors.Sunken <> clNone
          then begin
            Brush.Color:= Options.Colors.Sunken;
            FillRect(R);
          end
          else
            DrawPatternBackground(Canvas, R);
        end
        else
          FillRect(R);

        // fill bottom border
        R:= Rect(XLeft, Buffer.Height - X - Border, XRight, Buffer.Height - X);
        M:= GetMenuItemIndex(LastVisibleIndex);
        if (M is TMenuItem2000)
        and (TMenuItem2000(M).Hidden)
        then begin
          Inc(R.Bottom, Options.Margins.Border);
          if Options.Colors.Sunken <> clNone
          then begin
            Brush.Color:= Options.Colors.Sunken;
            FillRect(R);
          end
          else
            DrawPatternBackground(Canvas, R);
        end
        else begin
          if Brush.Color <> Options.Colors.Border
          then Brush.Color:= Options.Colors.Border;
          FillRect(R);
        end;
      end
      else begin
        // paint top part of the background bitmap
        BitBlt(Handle,
          GraphLeft,
          Ctl3dWidth + Bevel + BevelInner,
          GraphWidth,
          Border,
          Back.Canvas.Handle, 0, 0, SrcCopy);
      end;

      
    // top & down gutter
    if Options.Colors.Gutter <> clNone
    then begin
      R:= Rect(LineLeft, X, LineRight, X + Border);
      DrawGutter(Canvas, PaintParams.State, Options, R, RG);
      OffsetRect(R, 0, Bounds.Bottom - 2*X - Border);
      DrawGutter(Canvas, PaintParams.State, Options, R, RG);
    end;

    // bevel
    if Bevel > 0
    then
      DrawBevel(0, Options.Margins.Bevel,
        Options.Colors.Bevel, Options.Colors.BevelShadow);

    if BevelInner > 0
    then
      DrawBevel(Bevel, Options.Margins.BevelInner,
        Options.Colors.BevelInner, Options.Colors.BevelInnerShadow);

    // paint the rect that overrides by a raised menu bar item
    if (mfRaiseMenuBarItem in Options.Flags)
    and (ParentMenuForm = nil)
    and (PopupMenu.PopupComponent is TCustomMenuBar2000)
    then begin
      F:= TCustomMenuBar2000(PopupMenu.PopupComponent).RaisedForm;

      R:= F.ClientRect;
      OffsetRect(R, F.Left - GetRealLeft, F.Top - GetRealTop);
      InflateRect(R, -Bevel - BevelInner, -Bevel - BevelInner);

      // erase the bevel
      if not F.DrawLeft
      then begin
        OffsetRect(R, - Bevel -BevelInner -1, 0);
        EraseOverridenPart(sdRight, sdLeft);
      end;

      if not F.DrawRight
      then begin
        OffsetRect(R, Bevel + BevelInner +2, 0);
        EraseOverridenPart(sdLeft, sdRight);
      end;

      if not F.DrawTop
      then begin
        OffsetRect(R, 0, -Bevel - BevelInner -1);
        EraseOverridenPart(sdBottom, sdTop);
      end;

      if not F.DrawBottom
      then begin
        OffsetRect(R, 0, Bevel + BevelInner +1);
        EraseOverridenPart(sdTop, sdBottom);
      end;
    end;

    // paint title
    if Options.HasTitle
    and Options.Title.Visible
    then begin
      if fsPaintMenu in State
      then Options.Title.ResetBuffer;

      Buffer.Canvas.Brush.Color:= Options.Colors.Menu;
      Options.Title.Paint(Buffer.Canvas, Ctl3dWidth + Bevel + BevelInner, ClientOrigin.Y - Self.Top);
    end;
  end;
end;

procedure TPopupMenu2000Form.PaintBackground;
begin
  Back.Handle:= CreateCompatibleBitmap(Canvas.Handle, PaintParams.mir.GraphWidth, RealHeight);

  with Options.Skin, Back, Canvas
  do begin
    if ((Background.Width < RealWidth)
    or (Background.Height < RealHeight))
    and (BackgroundLayout <> blTile)
    then begin
      Brush.Color:= Options.Colors.Menu;
      FillRect(ClipRect);
    end;
  end;

  Options.Skin.PaintBackground(Back.Canvas, Back.Canvas.ClipRect);
end;

procedure TPopupMenu2000Form.PaintBackgroundPart(Y: Integer);
var
  R, RG: TRect;
begin
  with Buffer, Canvas, PaintParams.mir
  do begin
    // draw the bottom part of background picture
    if (Y < Buffer.Height)
    then begin
      if Brush.Style <> bsSolid
      then Brush.Style:= bsSolid;

      R:= Rect(PaintParams.mir.LineLeft, Y, PaintParams.mir.LineRight, Buffer.Height - Border);

      // title?
      if Options.HasTitle
      and Options.Title.Visible
      and (Options.Title.Position = atBottom)
      then Dec(R.Bottom, Options.Title.Width);

      DrawGutter(Canvas, PaintParams.State, Options, R, RG);

      if Options.HasSkin
      and Options.Skin.IsBackgroundStored
      then begin
        with PaintParams.mir, Options.Margins
        do
          BitBlt(Handle,
            GraphLeft,
            Y,
            GraphWidth,
            Buffer.Height - Y - Ctl3dWidth - Bevel - BevelInner,
            Back.Canvas.Handle, 0, Y + Ctl3dWidth - Bevel - BevelInner, Buffer.Canvas.CopyMode)
      end
      else begin
        SubtractRect(R, R, RG);

        if Brush.Color <> Options.Colors.Menu
        then Brush.Color:= Options.Colors.Menu;

        FillRect(R);
      end;
    end;
  end;
end;

procedure TPopupMenu2000Form.PaintDragPane;
var
  Y1, C1, C2, R1, G1, B1, I1, I2: Integer;
  DR, DG, DB, DH, F1, F2: Real;
  M: TMenuItem;
  R: TRect;
begin
  with PaintParams.mir, Buffer, Canvas
  do begin
    if not Back.Empty
    then
      with PaintParams.mir do
        BitBlt(Buffer.Canvas.Handle, GraphLeft, Border, GraphWidth, iDraggablePaneHeight +3,
          Back.Canvas.Handle, GraphLeft, Border, SrcCopy);

          
    Brush.Style:= bsSolid;

    if mfXpControls in Options.Flags
    then begin
      R:= Rect(LineLeft, Border, LineRight, Border + iDraggablePaneHeight);
      Y1:= (Width -33) div 2;

      if SelectedIndex = itDragPane
      then begin
        Brush.Color:= Options.Colors.Highlight;
        FillRect(R);

        Brush.Color:= Options.Colors.Frame;
        FrameRect(R);

        Pen.Color:= Options.Colors.Frame;
        PolyLine([Point(Y1, R.Top +2), Point(Y1 +33, R.Top +2)]);
        PolyLine([Point(Y1, R.Top +4), Point(Y1 +33, R.Top +4)]);

      end
      else begin
        Brush.Color:= Options.Colors.Menu;
        FillRect(R);

        Pen.Color:= Options.Colors.DisabledText;
        PolyLine([Point(Y1, R.Top +1), Point(Y1 +33, R.Top +1)]);
        PolyLine([Point(Y1, R.Top +3), Point(Y1 +33, R.Top +3)]);
        PolyLine([Point(Y1, R.Top +5), Point(Y1 +33, R.Top +5)]);

      end;
    end

    else begin
      if SelectedIndex = itDragPane
      then begin C1:= ColorToRGB(clActiveCaption); C2:= ColorToRGB(clGradientActiveCaption); end
      else begin C1:= ColorToRGB(clInactiveCaption); C2:= ColorToRGB(clGradientInactiveCaption); end;

      if IsGradientCaptions
      then begin
        // gradient!
        DH:= (PaintParams.mir.LineRight - PaintParams.mir.LineLeft)/256;
        R1:= GetRValue(C1);
        G1:= GetGValue(C1);
        B1:= GetBValue(C1);
        DR:= (GetRValue(C2) - R1)/255;
        DG:= (GetGValue(C2) - G1)/255;
        DB:= (GetBValue(C2) - B1)/255;

        for Y1:= 0 to 255
        do begin
          Brush.Color:= Rgb(R1 + Round(DR*Y1), G1 + Round(DG*Y1), B1 + Round(DB*Y1));
          F1:= Y1*DH;
          F2:= (Y1 +1)*DH;
          I1:= Round(F1);
          I2:= Round(F2);
          FillRect(Rect(LineLeft + I1, Border, LineLeft + I2, Border + iDraggablePaneHeight));
        end;
      end

      else begin
        Brush.Color:= C1;
        FillRect(Rect(LineLeft, Border, LineRight, Border + iDraggablePaneHeight));
      end;
    end;

    // bottom line
    R:= Rect(LineLeft, Border + iDraggablePaneHeight, LineRight, Border + iDraggablePaneHeight +3);

    M:= GetMenuItemIndex(FirstVisibleIndex);
    if (M is TMenuItem2000)
    and (TMenuItem2000(M).Hidden)
    then Dec(R.Bottom);

    Brush.Color:= Options.Colors.Menu;
    FillRect(R);   
  end;
end;

procedure TPopupMenu2000Form.PaintHiddenArrow;
var
  R, RG: TRect;
  X, Y: Integer;
begin
  with Buffer, Canvas, PaintParams, mir
  do begin
    R:= Rect(LineLeft, Buffer.Height - Border - iHiddenButtonHeight, LineRight, Buffer.Height - Border);

    // gutter
    DrawGutter(Canvas, PaintParams.State, Options, R, RG);
    InflateRect(RG, Options.Margins.Border, 0);
    SubtractRect(R, R, RG);

    Exclude(PaintParams.State, isDisabled);
    SetState(PaintParams.State, isSelected, SelectedIndex = itHiddenArrow);
    SetState(PaintParams.State, isPressed, (SelectedIndex = itHiddenArrow) and
      ((msLeftButton in MouseState) or (msRightButton in MouseState)));

    if isSelected in State
    then begin
      if Options.HasSkin
      and (not Options.Skin.UnhideBackgroundHighlight.Empty)
      then
        Options.Skin.PaintUnhideBackground(Canvas, State, R)

      else
      if Options.HasSkin
      and (not Options.Skin.ItemBackgroundHighlight.Empty)
      then
        Options.Skin.PaintItemBackground(Canvas, State, R)

      else begin
        if mfSoftColors in Options.Flags
        then DrawSolidBackground(Canvas, R, Options.Colors.Highlight)
        else
        if (Options.Colors.Sunken <> clNone)
        then DrawSolidBackground(Canvas, R, Options.Colors.Sunken)
        else DrawPatternBackground(Canvas, R);

        if (msLeftButton in MouseState)
        then Frame3D(Canvas, R, Options.Colors.FrameShadow, Options.Colors.Frame, 1)
        else Frame3D(Canvas, R, Options.Colors.Frame, Options.Colors.FrameShadow, 1);
      end;
    end
    else begin
      Brush.Style:= bsSolid;
      Brush.Color:= Options.Colors.Menu;
      FillRect(R);
    end;

    // draw arrow
    if Options.HasSkin
    and (not Options.Skin.Unhide.Empty)
    then // skin arrow
      with Options.Skin
      do PaintBitmap(Canvas, Unhide, State, R)

    else begin // standard arrow
      X:= (R.Right + R.Left) div 2 -3;
      Y:= (R.Top + R.Bottom) div 2 -4;
      if (SelectedIndex = itHiddenArrow)
      and (msLeftButton in MouseState)
      then begin
        Inc(X); Inc(Y);
      end;

      Pen.Color:= Options.Colors.MenuText;
      PolyLine([Point(X, Y), Point(X +2, Y +2), Point(X +4, Y), Point(X +4, Y +1), Point(X +2, Y +3),
        Point(X -1, Y)]);

      Inc(Y, 4);
      PolyLine([Point(X, Y), Point(X +2, Y +2), Point(X +4, Y), Point(X +4, Y +1), Point(X +2, Y +3),
        Point(X -1, Y)]);
    end;
  end;
end;

procedure TPopupMenu2000Form.PaintScrollBars;
var
  X, Y, DUp, DDown, DX, DX2, CY: Integer;
  D: Double;
  Edge: Cardinal;

  procedure PaintArrow(const X, Y, DY1, DY2: Integer; Color: TColor);
  begin
    if Buffer.Canvas.Pen.Color <> Color
    then Buffer.Canvas.Pen.Color:= Color;

    if Buffer.Canvas.Brush.Color <> Color
    then Buffer.Canvas.Brush.Color:= Color;

    Buffer.Canvas.PolyGon([Point(X - DX, Y + DY1), Point(X + DX, Y + DY1), Point(X, Y + DY2)]);
  end;

begin
  with Buffer, Canvas, PaintParams.mir
  do begin
    ScrollRect:= Rect(LineRight, Border, RealWidth - Border, RealHeight - Border);
    Brush.Style:= bsSolid;
    Brush.Color:= Options.Colors.Menu;
    FillRect(ScrollRect);

    Dec(ScrollRect.Right);
    ScrollRect.Left:= ScrollRect.Right - Integer(NonClientMetrics.iScrollWidth);
    DrawPatternBackground(Buffer.Canvas, ScrollRect);

    Brush.Style:= bsSolid;
    Brush.Color:= Options.Colors.Menu;
    CY:= GetSystemMetrics(SM_CYVSCROLL);

    // up arrow
    DUp:= 0;
    if (SelectedIndex = itScrollUp)
    and (FirstVisibleIndex > 0)
    then
      if msLeftButton in MouseState
      then begin
        Edge:= BDR_SUNKENINNER;
        DUp:= 1;
      end
      else Edge:= EDGE_RAISED
    else Edge:= BDR_RAISEDINNER;

    ScrollUpRect:= Rect(ScrollRect.Left, ScrollRect.Top, ScrollRect.Right, ScrollRect.Top + CY);
    FillRect(ScrollUpRect);
    DrawEdge(Buffer.Canvas.Handle, ScrollUpRect, Edge, BF_SOFT + BF_RECT);

    // bottom arrow
    DDown:= 0;
    if (SelectedIndex = itScrollDown)
    and (LastVisibleIndex < ItemRects.Count -1)
    then
      if msLeftButton in MouseState
      then begin
        Edge:= BDR_SUNKENINNER;
        DDown:= 1;
      end
      else Edge:= EDGE_RAISED
    else Edge:= BDR_RAISEDINNER;

    ScrollDownRect:= Rect(ScrollRect.Left, ScrollRect.Bottom - CY, ScrollRect.Right, ScrollRect.Bottom);
    FillRect(ScrollDownRect);
    DrawEdge(Buffer.Canvas.Handle, ScrollDownRect, Edge, BF_SOFT + BF_RECT);


    // scroll box
    if SelectedIndex = itScrollBox
    then
      if msLeftButton in MouseState
      then begin
        Edge:= BDR_SUNKENINNER;
      end
      else Edge:= EDGE_RAISED
    else Edge:= BDR_RAISEDINNER;

    Y:= ScrollRect.Bottom - ScrollRect.Top - 2*CY;
    D:= (LastVisibleIndex - FirstVisibleIndex +1) / ItemRects.Count;
    ScrollBoxRect:= Rect(ScrollRect.Left, 0, ScrollRect.Right, Round(Y * D));

    ScrollDelta:= Y / ItemRects.Count;
    OffsetRect(ScrollBoxRect, 0, ScrollRect.Top + CY + Round(FirstVisibleIndex * ScrollDelta));
    FillRect(ScrollBoxRect);
    DrawEdge(Buffer.Canvas.Handle, ScrollBoxRect, Edge, BF_SOFT + BF_RECT);


    // up arrow
    DX:= CY - 14; DX2:= DX div 2;
    X:= (ScrollUpRect.Left + ScrollUpRect.Right) div 2 + DUp;
    Y:= (ScrollUpRect.Top + ScrollUpRect.Bottom) div 2 + DUp;

    if FirstVisibleIndex > 0
    then begin
      PaintArrow(X, Y, DX2, DX2 - DX, Options.Colors.MenuText);
    end
    else begin
      PaintArrow(X +1, Y +1, DX2, DX2 - DX, Options.Colors.DisabledShadow);
      PaintArrow(X, Y, DX2, DX2 - DX, Options.Colors.DisabledText);
    end;


    // down arrow
    X:= (ScrollDownRect.Left + ScrollDownRect.Right) div 2 + DDown;
    Y:= (ScrollDownRect.Top + ScrollDownRect.Bottom) div 2 + DDown;

    if LastVisibleIndex < ItemRects.Count -1
    then begin
      PaintArrow(X, Y, DX2 - DX, DX2, Options.Colors.MenuText);
    end
    else begin
      PaintArrow(X +1, Y +1, DX2 - DX, DX2, Options.Colors.DisabledShadow);
      PaintArrow(X, Y, DX2 - DX, DX2, Options.Colors.DisabledText);
    end;


  end;
end;

{$IFNDEF Delphi5OrHigher}
function BytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: Longint): Longint;
begin
  Dec(Alignment);
  Result:= ((PixelsPerScanline * BitsPerPixel) + Alignment) and not Alignment;
  Result:= Result div 8;
end;
{$ENDIF}

procedure TPopupMenu2000Form.PaintBufferOnCanvas(const DC: HDC; const ReGetDiBits: Boolean);
var
  CX, CY, X, Y, Y1: Integer;
  R: TRect;
  Brush: HBrush;

  procedure PaintWithOpacity;
  var
    DT, DB: Integer;
  begin
//    Move(OpacityBits.Source^, OpacityBits.Destination^, OpacityBits.BytesPerLine * CY -1);

    if (MenuOpacityData <> nil)
    then begin
      DT:= 0;
      DB:= OpacityBits.BytesPerLine * Y;
      if X > 0
      then Dec(DB, X * iBytesPerPixel);

      if DB < 0
      then begin
        DT:= OpacityBits.BytesPerLine;
        Inc(DB, OpacityBits.BytesPerLine);
      end;

      ProcessOpacityData(@OpacityBits.Source[DT], @OpacityBits.Background[DB],
        @OpacityBits.Destination[DT], @OpacityBits.Destination[OpacityBits.BytesPerLine * CY - 1],
        MenuOpacityData);

      if (DT > 0)
      and (MenuOpacityData <> nil)
      then
        ProcessOpacityData(OpacityBits.Source, @OpacityBits.Background[DB],
          OpacityBits.Destination, @OpacityBits.Destination[DT - 1],
          MenuOpacityData);
    end;

    OpacityBits.SetDestinationBitsToCanvas(DC, 0, 0, RealWidth, CY, X, 0);
  end;

  procedure PaintUnhideAnimation;
  var
    P1, P2: PByteArray;
    DDY: Double;
    I, DI1, MIC, DY, DY1Y, Y1, Y2: Integer;
    HiddenPrev: Boolean;
    M: TMenuItem;

    procedure StretchMove(const DY1Y, DY2: Integer);
    var
      DDY2: Double;
      J, DY1: Integer;
    begin
      if (DY < 1)
      or (DY2 = 0)
      then Exit;

      DDY2:= DY1Y / DY2;

      for J:= 0 to DY2 -1
      do begin
        DY1:= Trunc(J * DDY2);
        Move(Pointer(Cardinal(P1) + DY1 * UnhideBits.BytesPerLine)^, P2^, UnhideBits.BytesPerLine);
        Inc(Cardinal(P2), UnhideBits.BytesPerLine);
      end;
    end;

  begin
    if (UnhideBits = nil)
    then Exit;

    I:= ItemRects.Count -1;
    MIC:= GetCount(MenuItems);
    DI1:= MIC - ItemRects.Count;
    HiddenPrev:= False;
    P1:= UnhideBits.Source;
    P2:= UnhideBits.Destination;
    DDY:= (CY - LastRealHeight) / (RealHeight - LastRealHeight);

    UnhideBits.BitmapInfo.bmiHeader.biWidth:= CX;
    UnhideBits.BitmapInfo.bmiHeader.biHeight:= CY;

    // copy top lines
    Y1:= RealHeight;
    Y2:= GetItemRect(I).Bottom;
    DY:= UnhideBits.BytesPerLine * (Y1 - Y2);
    Y1:= Y2;

    Move(P1^, P2^, DY);
    Inc(Cardinal(P1), DY);
    Inc(Cardinal(P2), DY);

    // calc all menu items
    while (I + DI1 >= 0)
    do begin
      M:= MenuItems[I + DI1];

      if not IsVisible(M)
      then begin
        Dec(DI1);
        Continue;
      end;

      if (M is TMenuItem2000)
      and (TMenuItem2000(M).Hidden = HiddenPrev)
      then begin
        Dec(I);
        Continue;
      end;

      Y2:= GetItemRect(I).Bottom;
      DY1Y:= (Y1 - Y2);
      DY:= DY1Y * UnhideBits.BytesPerLine;

      if HiddenPrev
      then begin // stretch unhiding items
        StretchMove(DY1Y, Round(DY1Y * DDY));
      end

      else begin // just copy regular items
        Move(P1^, P2^, DY);
        Inc(Cardinal(P2), DY);
      end;

      Inc(Cardinal(P1), DY);

      Y1:= Y2;
      HiddenPrev:= not HiddenPrev;
      Dec(I);
    end;

    // if hiddenprev
    if HiddenPrev
    then begin
      DY1Y:= CY - (Cardinal(P2) - Cardinal(UnhideBits.Destination)) div UnhideBits.BytesPerLine;
      StretchMove(Y1, DY1Y);
    end
    else begin
      Move(P1^, Pointer(Cardinal(UnhideBits.Destination) + (CY - Y1) * UnhideBits.BytesPerLine)^,
        (Y1 * UnhideBits.BytesPerLine));
    end;

    if (TempBuffer <> nil)
    then begin
      UnhideBits.SetDestinationBitsToCanvas(TempBuffer.Canvas.Handle, 0, Y, CX, CY, 0, 0);
      PaintWithOpacity;
    end
    else
      UnhideBits.SetDestinationBitsToCanvas(DC, 0, 0, CX, CY, 0, 0);
  end;

  procedure PaintStretchAnimation;
  var
    X1, DT, DDB, DDB1: Integer;
    DDX, DDY, DX1, DY1: Double;
    P1, P2, bits1: PByteArray;
    Indexes: PWordArray;
  begin
    Indexes:= nil; // index array for horz stretch animation
    bits1:= AnimationBits.Source;
    P2:= AnimationBits.Destination; // pointer to the destination image
    DDX:= Buffer.Width / CX; // step in current horz stretch animation
    DDY:= Buffer.Height / CY; // step in current vert stretch animation
    DY1:= 0; // current vert cursor
    DDB:= BytesPerScanline(Buffer.Width, iBytesPerPixel shl 3, 32); // bytes per scanline
    DDB1:= DDB - CX * iBytesPerPixel;

    while DY1 < Buffer.Height - 0.5
    do begin
      Y1:= Round(DY1); // current vert cursor
      DT:= AnimationBits.BytesPerLine * Y1; // start byte

      if X = 0
      then begin
        Move(bits1[DT], P2^, AnimationBits.BytesPerLine);
        Inc(Integer(P2), DDB);
      end

      else begin
        if Indexes = nil
        then begin  // calculating indexes
          DX1:= 0;  // current hors cursor
          GetMem(Indexes, CX * SizeOf(Word));

          for X1:= 0 to CX -1
          do begin
            Indexes[X1]:= Round(DX1) * iBytesPerPixel;
            DX1:= DX1 + DDX;
          end;
        end;

        for X1:= 0 to CX -1
        do begin
          P1:= @bits1[DT + Indexes[X1]];
          Move(P1^, P2^, iBytesPerPixel);

          Inc(Integer(P2), iBytesPerPixel);
        end;

        Inc(Integer(P2), DDB1);
      end;

      DY1:= DY1 + DDY;
    end;

    FreeMemAndNil(Indexes);

    if (TempBuffer <> nil)
    then begin
      X:= 0;
      AnimationBits.SetDestinationBitsToCanvas(TempBuffer.Canvas.Handle, 0, Y, CX, CY, 0, 0);
      PaintWithOpacity;
    end
    else
      AnimationBits.SetDestinationBitsToCanvas(DC, 0, 0, CX, CY, 0, 0);
  end;

  procedure PaintRollAnimation;
  begin
    X:= 0;
    Y:= 0;
    CY:= RealHeight;
    if (OpacityBits <> nil)
    then
      PaintWithOpacity
    else
      BitBlt(DC, 0, Y1, Buffer.Width, Buffer.Height, Buffer.Canvas.Handle, 0, 0, SrcCopy);
  end;

begin
  if ((Width = 0)
  or (Height = 0))
  and (DC = 0)
  then Exit; // nowhere to paint

  Windows.GetClientRect(Handle, R);
  if (R.Top = R.Bottom)
  or (R.Left = R.Right)
  then begin
    CX:= Buffer.Width;
    CY:= Buffer.Height;
  end
  else begin
    CX:= R.Right;
    CY:= R.Bottom;
  end;

  if (fsFromBottomToTop in State)
  then Y:= 0
  else Y:= Buffer.Height - CY;

  if BorderStyle <> bsNone
  then begin
    Inc(Y, 2);
    Y1:= 2;

    Brush:= CreateSolidBrush(ColorToRGB(Options.Colors.Menu));
    FillRect(DC, Rect(0, 0, Width, 2), Brush);
    DeleteObject(Brush);
  end
  else
    Y1:= 0;

  if fsFromRightToLeft in State
  then X:= 0
  else X:= Buffer.Width - CX;


  if (fsNewUnhide in State) // the new unhide
  then
    PaintUnhideAnimation

  else
  if (Animation in anStretchAnimations)
  and ((X <> 0) or (Y <> 0))
  then begin
    PaintStretchAnimation
  end

  else
  if (Animation in anRollAnimations)
  and ((X <> 0) or (Y <> 0))
  then
    PaintRollAnimation

  else
  if (BorderStyle = bsNone)
  and (not Assigned(pSetLayeredWindowAttributes))
  and ((Options.Opacity <> 100) and (MenuOpacityData <> nil))
  then
    PaintWithOpacity

  else
    BitBlt(DC, 0, Y1, Buffer.Width, Buffer.Height, Buffer.Canvas.Handle, X, Y, SrcCopy);

end;

procedure TPopupMenu2000Form.Paint;
var
  Y, I, Temp: Integer;
  OldPalette: HPalette;
  M, M1, M0, M2: TMenuItem;
begin
  if (fsAnimated in State)
  and (Animation = anFadeIn)
  and (not (fsPaintMenu in State))
  then Exit;

  LockGlobalRepaint;
  
  // init PaintParams record
  InitializePaintParams;

  // select background's palette (if any)
  OldPalette:= 0;
  if Options.HasSkin
  and Options.Skin.IsBackgroundStored
  then begin
    if (Options.Skin.Background.Palette <> 0)
    then begin
      OldPalette:= SelectPalette(Buffer.Canvas.Handle, Options.Skin.Background.Palette, True);
      RealizePalette(Buffer.Canvas.Handle);
    end;

    Include(PaintParams.State, isGraphBack);

    // fit background to menu
    if fsPaintMenu in State
    then PaintBackground;
  end
  else 
    Back.Handle:= 0;

  // draw frames
  if (fsPaintMenu in State)
  then begin
    PaintBevelAndBorder(Bounds(0, 0, Buffer.Width, Buffer.Height));
    PaintFrame3D;
  end;


  // initialize y param
  Y:= PaintParams.mir.Border;
  if (Options.Draggable)
  and (BorderStyle = bsNone)
  then Inc(Y, iDraggablePaneHeight +2);

  if Options.HasTitle
  and Options.Title.Visible
  and (Options.Title.Position = atTop)
  then Inc(Y, Options.Title.Width);

  // mouse position
  GetCursorPos(PaintParams.MousePos);
  PaintParams.MousePos:= ScreenToClient(PaintParams.MousePos);

  // paint CanTearOff plane
  if (Options.Draggable)
  and ((fsPaintMenu in State)
    or ((fsSelectedChanged in State) and ((SelectedIndex = itDragPane)
      or (LastSelectedIndex = itDragPane))))
  and (BorderStyle = bsNone)
  then PaintDragPane;

  M:= nil;
  M1:= GetMenuItemIndex(FirstVisibleIndex);

  // repeat for each menu item
  for I:= FirstVisibleIndex to LastVisibleIndex
  do begin
    M0:= M;
    M:= M1;
    M1:= GetMenuItemIndex(I +1);
    Temp:= GetMenuItemHeightIndex(I);
    PaintParams.mir.Top:= Y;
    PaintParams.mir.Height:= Temp;

    // init state
    if (fsFraming in State)
    or (fsPreview in State)
    then begin
      SetState(PaintParams.State, isSelected, False);
      SetState(PaintParams.State, isFramed, (ActiveMenuItem = M));

      SetState(PaintParams.State, isInsertBefore, (ActiveMenuItem <> M)
        and (InsertBeforeItem = M));
      SetState(PaintParams.State, isInsertAfter, (ActiveMenuItem <> M)
        and (((M1 <> nil) and (InsertBeforeItem = M1))
        or ((M1 = nil) and (InsertBeforeItem = miInsertAtTheEnd) and (InsertBeforeParent = MenuItems))));
    end
    else begin
      SetState(PaintParams.State, isSelected, SelectedIndex = I);
      SetState(PaintParams.State, isPressed, (SelectedIndex = I) and (M <> nil) and (M.Enabled) and
        ((msLeftButton in MouseState) or (msRightButton in MouseState) or (FocusItem = M)));
    end;

    Exclude(PaintParams.State, isNoLeftSunken);
    Exclude(PaintParams.State, isNoRightSunken);
    if fsShowHidden in State
    then begin
      if not (fsHiddenAsRegular in State)
      then begin
        SetState(PaintParams.State, isHidden, (M is TMenuItem2000) and (TMenuItem2000(M).Hidden));
        SetState(PaintParams.State, isHiddenPrev, ((M0 is TMenuItem2000) and (TMenuItem2000(M0).Hidden))
          or ((M0 = nil) and (isHidden in PaintParams.State) and not Options.Draggable));
        SetState(PaintParams.State, isHiddenSucc, ((M1 is TMenuItem2000) and (TMenuItem2000(M1).Hidden))
          or ((M1 = nil) and (isHidden in PaintParams.State)));


        if (isHidden in PaintParams.State)
        then begin
          // TASK A: not-hidden item, hidden separator, hidden item -> unhide the separator
          // A1: remove isHiddenSucc at not-hidden item
          // excessive

          // A2: unhide separator itself
          if (not (isHiddenPrev in PaintParams.State))
          and IsSeparatorItem(M)
          then Exclude(PaintParams.State, isHidden);

          // A3: remove isHiddenPrev at hidden menu item
          if (isHiddenPrev in PaintParams.State)
          and IsSeparatorItem(M0)
          then Exclude(PaintParams.State, isHiddenPrev);

          // TASK B: hidden item, hidden separator, not-hidden item -> unhide the separator
          // B1: remove isHiddenSucc at hidden menu item
          if (isHiddenSucc in PaintParams.State)
          and IsSeparatorItem(M1)
          then begin
            M2:= GetMenuItemIndex(I +2);
            if (M2 is TMenuItem2000)
            and (not TMenuItem2000(M2).Hidden)
            then Exclude(PaintParams.State, isHiddenSucc);
          end;

          // B2: unhide separator itself
          if (isHiddenPrev in PaintParams.State)
          and (not (isHiddenSucc in PaintParams.State))
          and IsSeparatorItem(M0)
          then Exclude(PaintParams.State, isHidden);

          // B3: remove isHiddenPrev at not-hidden menu item
          // excessive


          // TASK C&D: hise separator between two hidden menu items
          // hide next separator
          if (not (isHiddenSucc in PaintParams.State))
          and IsSeparatorItem(M1)
          then begin
            M2:= GetMenuItemIndex(I +2);
            if (M2 is TMenuItem2000)
            and (TMenuItem2000(M2).Hidden)
            then SetState(PaintParams.State, isHiddenSucc, True);
          end;

          // hide prev separator
          if (not (isHiddenPrev in PaintParams.State))
          and IsSeparatorItem(M0)
          then begin
            M2:= GetMenuItemIndex(I -2);
            if (M2 is TMenuItem2000)
            and (TMenuItem2000(M2).Hidden)
            then SetState(PaintParams.State, isHiddenPrev, True);
          end;

          if Options.HasTitle
          and Options.Title.Visible
          then
            if Options.Title.Position = atLeft
            then Include(PaintParams.State, isNoLeftSunken)
            else Include(PaintParams.State, isNoRightSunken);

        end;
      end;
    end

    // ignore separator in Window menu
    else
      if (CurHiddenCount > 0)
      and (CurHiddenCount = GetCount(MenuItems))
      then Inc(CurHiddenCount);

    PaintParams.Item:= M;
    PaintParams.Index:= I;

    // is menu item should be drawn?
    if (fsPaintMenu in State)
    or (fsPreview in State)
    or (I = SelectedIndex)
    or (I = LastSelectedIndex)
    or ((fsFraming in State)
      and ((LastInsertBeforeItem = nil)
        or (M = LastInsertBeforeItem) or (M1 = LastInsertBeforeItem)
        or (M = InsertBeforeItem) or (M1 = InsertBeforeItem)))
    then begin
      // draw background
      if not Back.Empty
      then begin
        with PaintParams.mir do
          BitBlt(Buffer.Canvas.Handle,
            GraphLeft,
            Top,
            GraphWidth,
            Height,
            Back.Canvas.Handle, 0, Y + Ctl3dWidth - Options.Margins.Bevel - Options.Margins.BevelInner, SrcCopy);
      end;

      if (not (fsPaintMenu in State))
      and (mfNoSharpJoints in Options.Flags)
      and (I = LastSelectedIndex)
      then
        PaintBevelAndBorder(Bounds(0, PaintParams.mir.Top,
          Buffer.Width, PaintParams.mir.Height));

      // draw menu item
      // win32 menu item
      if M = nil
      then begin
        Inc(PaintParams.Index, CurHiddenCount);
        PaintMenuItemWin32(@PaintParams);
      end
      else
      // control
      if (M is TMenuItem2000) and (TMenuItem2000(M).Control <> ctlNone)
      then
        TMenuItem2000(M).ControlOptions.Paint(@PaintParams)

      else
      // ordinary menu item
        PaintMenuItem(@PaintParams);

    end;

    // increment Y
    Inc(Y, Temp);

    // fill interitem space
    if (fsPaintMenu in State)
    and (Options.Margins.Space > 0)
    and (I < ItemRects.Count -1)
    then
      if not Back.Empty
      then
        with PaintParams.mir do
          BitBlt(Buffer.Canvas.Handle, LineLeft, Y, LineRight - LineLeft,
            Options.Margins.Space, Back.Canvas.Handle, 0, Y, Buffer.Canvas.CopyMode)
      else
        with Buffer.Canvas, PaintParams.mir
        do begin
          if Brush.Style <> bsSolid
          then Brush.Style:= bsSolid;

          if Brush.Color <> Options.Colors.Menu
          then Brush.Color:= Options.Colors.Menu;

          Buffer.Canvas.FillRect(Rect(LineLeft, Y, LineRight,
            Y + Options.Margins.Space));
        end;

    // increment Y
    Inc(Y, Options.Margins.Space);
  end;

  Dec(Y, Options.Margins.Space);

  // final paintings
  if fsPaintMenu in State
  then PaintBackgroundPart(Y);

  // draw hidden arrow
  if (fsHiddenArrow in State)
  and ((fsPaintMenu in State)
    or (((fsSelectedChanged in State) or (fsMouseChanged in State))
      and ((SelectedIndex = itHiddenArrow) or (LastSelectedIndex = itHiddenArrow))
      and (not (fsFraming in State))))
  then PaintHiddenArrow;

  // draw scroll bars
  if (fsScrollbars in State)
  and ((fsPaintMenu in State) or (fsMouseChanged in State) or (fsSelectedChanged in State))
  then PaintScrollBars;

  // restore palette
  if OldPalette <> 0
  then SelectPalette(Buffer.Canvas.Handle, OldPalette, True);

  // draw buffer on canvas
  if (not (fsAnimated in State))
  and (Width > 0)
  and (Height > 0)
  then PaintBufferOnCanvas(Canvas.Handle, True);

  Exclude(State, fsPaintMenu);
  Exclude(State, fsMouseChanged);
  LastSelectedIndex:= SelectedIndex;
  GlobalRepaintFlag:= False;
  UnLockGlobalRepaint;
end;

procedure TPopupMenu2000Form.RebuildToolTipWindow(Recreate: Boolean);
  // set tooltips
var
  R: TRect;
  M: TMenuItem;
  X, Y, H, I, iI, iJ, Index, BW, BH: Integer;
  S: String;
begin
  // we have to recreate tooltip window if it became
  // floating
  ToolTipWindow.Free;
  ToolTipWindow:= nil;

  if (not PopupMenu.ShowHint)
  or (PopupMenu.StatusBar <> nil)
  then Exit;

  ToolTipWindow:= T_AM2000_ToolTipWindow.Create(Self);

  // init X
  X:= 0;
  if Options.HasTitle
  and Options.Title.Visible
  and (Options.Title.Position = atLeft)
  then Inc(X, Options.Title.Width);

  // init Y
  Y:= Options.Margins.Border;
  if (BorderStyle = bsNone)
  then
    with Options.Margins
    do
      if (fsCtl3D in State)
      then begin Inc(X, Bevel + BevelInner +2); Inc(Y, Bevel + BevelInner +2); end
      else begin Inc(X, Bevel + BevelInner); Inc(Y, Bevel + BevelInner); end;

  // is menu draggable?
  if (Options.Draggable)
  and (BorderStyle = bsNone)
  then begin
    ToolTipWindow.AddTool(Rect(2, Y, RealWidth -2, Y+9), SDraggableMenuInfo);
    Inc(Y, 10);
  end;


  // add tools to the ToolTip control
  for I:= 0 to ItemRects.Count -1 do begin
    M:= GetMenuItemIndex(I);
    H:= GetMenuItemHeightIndex(I);

    if (M <> nil) then
      // is it a button array?
      if (M is TMenuItem2000)
      and (TMenuItem2000(M).Control = ctlButtonArray)
      then
        with TMenuItem2000(M).AsButtonArray do begin
          if Bitmap.Empty then Continue;

          // init loop
          iI:= 0;
          iJ:= 0;
          Index:= 0;
          BW:= Bitmap.Width div Columns;
          BH:= Bitmap.Height div Rows;

          // assign each hint to tooltip control
          while Index < Hints.Count
          do begin
            R:= Rect(iI * BW + X +2, iJ * BH + Y +1, 0, 0);
            R.Right:= R.Left + BW;
            R.Bottom:= R.Top + BH;

            if Hints[Index] <> ''
            then ToolTipWindow.AddTool(R, Hints[Index]);

            // next step
            Inc(Index);
            Inc(iI);
            if iI = Columns
            then begin Inc(iJ); iI:= 0; end;
          end;
        end

      // it's usual item
      else begin
        // is hint present?
        S:= '';
        if (M.Hint <> '') and (M.Hint <> #1)
        then S:= M.Hint;

        if (S = '')
        and (M.Hint = '')
        and (MenuItemCache.IsDefault(GetCaption(M)))
        then S:= MenuItemCache[GetCaption(M)].Hint;

        if S <> ''
        then ToolTipWindow.AddTool(Rect(0, Y, RealWidth, Y+H), S);
      end;

    Inc(Y, H + Options.Margins.Space);
  end;

  // hidden arrow
  if (fsHiddenArrow in State)
  then ToolTipWindow.AddTool(Rect(0, Y, RealWidth, RealHeight), SExpandCaption);

  ToolTipWindow.Activate;
end;


procedure TPopupMenu2000Form.RebuildBounds;
var
  I, DI1, DI2, H, P, TW, TH, W1, W2, MIC, MIC0, W11, P11, SaveFontSize: Integer;
  M: TMenuItem;
  L: LongRec;
  S: String;
  IncludeBold, VisibleFlag: Boolean;

  procedure SetDefault(D: Boolean);
  begin
    with Buffer.Canvas.Font do
      if D then begin
        if not (fsBold in Style) then begin
          IncludeBold:= True;
          Style:= Style + [fsBold];
        end;
      end
      else
        if IncludeBold then begin
          IncludeBold:= False;
          Style:= Style - [fsBold];
        end;
  end;

begin
  // initialize
  P:= 0;
  I:= 0;
  M:= nil;
  DI1:= 0; // for invisible items
  DI2:= 0; // for hidden items
  ItemWidth:= 0;
  ShortcutWidth:= 0;
  IncludeBold:= False;
  FiWidth:= 0;
  Exclude(State, fsHiddenArrow);
  ItemRects.Clear;

  if (MenuHandle = 0) or (Options = nil)
  then Exit;

  MIC:= GetMenuItemCount(MenuHandle);
  MIC0:= GetCount(MenuItems);

  // start
  // calc top margin
  H:= Options.Margins.Border + Options.Margins.Bevel + Options.Margins.BevelInner;
  FiLeft:= H + Options.Margins.Frame;

  if (BorderStyle = bsNone)
  then begin
    if (fsCtl3D in State)
    then begin Inc(H, 2); Inc(FiLeft, 2); end;

    // is menu draggable?
    if (Options.Draggable)
    then Inc(H, iDraggablePaneHeight +2);

  end;

  if Options.HasTitle
  and Options.Title.Visible
  and (Options.Title.Position = atTop)
  then Inc(H, Options.Title.Width);


  // calc all menu items
  while MIC > I + DI2
  do begin
    W1:= 0;
    W2:= 0;
    L.Lo:= H;
    L.Hi:= 0;
    M:= nil;

    // calc item's heigth
    // Delphi menu item
    while (MIC0 > I + DI1 + DI2)
    do begin
      M:= MenuItems[I + DI1 + DI2];

      // invisible item
      VisibleFlag:= IsVisible(M);

      if not VisibleFlag
      then
        if (fsPreview in State)
        then begin
          VisibleFlag:= True;
          Inc(MIC);
        end
        else
          Inc(DI1);

      if VisibleFlag
      then
      // visible item or in preview
      begin
        L.Hi:= GetMenuItemHeight(M);

        // create new font style
        SetDefault(M.Default);
        S:= GetCaption(M);
        Break;
      end;
    end;

    // WinAPI menu item
    if M = nil
    then begin
      if (MenuItems = nil)
      or (MIC > GetCount(MenuItems))
      then begin
        mii.fMask:= $3F or miim_Type or miim_Submenu or miim_State;
        mii.dwTypeData:= Z;
        mii.cch:= SizeOf(Z) -1;
        if GetMenuItemInfo(MenuHandle, I + DI2, True, mii)
        then
          if (I = 0)
          and (DI2 <> 0)
          and (mii.fType and mft_Separator <> 0)
          then begin // ignore first separator in the menu
            Inc(I);
            Continue;
          end
          else begin // not the first separator in menu
            if mii.fType and mft_Separator <> 0
            then L.Hi:= Options.Margins.Separator
            else L.Hi:= ItemHeight + 2*Options.Margins.Frame;

            SetDefault(mii.fState and mfs_Default <> 0);
            S:= StrPas(Z);
          end;
      end

      else
        Break;
    end;
    // end empty M

    // calc item's caption width
    if (M <> nil)
    and (M is TMenuItem2000)
    then begin
      W1:= TMenuItem2000(M).GetWidth(Buffer.Canvas, Options);
      if W1 > 0 then Dec(W1, Options.Margins.Left + Options.Margins.Right);
    end;

    if W1 = 0
    then begin
      P:= Pos(#9, S);

      if bEnableExtendedSymbols
      and (P = 0)
      then P:= Pos(STabulator, S);
      
      if P <> 0 then S:= Copy(S, 1, P -1);

      // calc menu item's width
      repeat
        P11:= Pos(#13, S);

        if bEnableExtendedSymbols
        and (P11 = 0)
        then P11:= Pos(SNewLine, S);
        if P11 = 0 then P11:= Length(S) +1;

        if (S = '') or (P11 = 0) then Break;

        W11:= AmpTextWidth(Buffer.Canvas, Copy(S, 1, P11 -1));
        if W11 > W1 then W1:= W11;

        if (P11 < Length(S))
        and (S[P11] = #13)
        then Delete(S, 1, P11)
        else Delete(S, 1, P11 +1);
      until S = '';
    end;

    // add triangle
//    if ((M <> nil) and HasSubmenu(M))
//    or (mii.hSubmenu <> 0)
//    then begin
//      Inc(W1, iSubmenuTriangleWidth);
//    end;

    if W1 > iMaxItemWidth then W1:= iMaxItemWidth;
    // end caption width

    // calc item's shortcut width
    S:= '';
    if (M <> nil)
    then begin
      if (M is TMenuItem2000)
      then begin
        if TMenuItem2000(M).ShortCut <> ''
        then S:= GetMainShortCut(TMenuItem2000(M).ShortCut);
      end
      else
      if M.ShortCut <> 0
      then
        S:= ShortCutToText(M.ShortCut);

      // custom shortcut
      if (W2 = 0)
      and (P <> 0)
      then begin
        S:= GetCaption(M);
        if S[P] = #9
        then S:= Copy(S, P +1, MaxInt)
        else S:= Copy(S, P +2, MaxInt);
      end;

    end
    else
      if P <> 0
      then W2:= Buffer.Canvas.TextWidth(Copy(Z, P +1, MaxInt));

    if S <> ''
    then begin
      if (mfTinyShortCuts in Options.Flags)
      then begin
        SaveFontSize:= Buffer.Canvas.Font.Size;
        Buffer.Canvas.Font.Size:= SaveFontSize -2;
      end;

      W2:= Buffer.Canvas.TextWidth(S);

      if (mfTinyShortCuts in Options.Flags)
      then Buffer.Canvas.Font.Size:= SaveFontSize;
    end;
    // end shortcut width


    // OnMeasureItem event handler
    // has OnMeasureItem event handler?
    if (M <> nil)
{$IFNDEF Delphi4OrHigher}
    and (M is TMenuItem2000)
{$ENDIF}
    and Assigned(TMenuItem2000(M).OnMeasureItem)
    then begin
      TW:= W1 + W2;
      TH:= L.Hi;
      TMenuItem2000(M).OnMeasureItem(M, Buffer.Canvas, TW, TH);

      if TW <> W1 + W2 then W1:= TW -W2;
      L.Hi:= TH;

    end;

    // add item's top and botton
    if (M is TMenuItem2000)
    and (TMenuItem2000(M).Hidden)
    and (not ((fsShowHidden in State) or (fsPreview in State)))
    then
      Inc(DI2)

    else
    if (L.Hi <> 0)
    then begin
      ItemRects.Add(Pointer(L));
      Inc(H, L.Hi + Options.Margins.Space);
      Inc(I);
    end;


    // max shortcut
    if ShortcutWidth < W2 then ShortcutWidth:= W2;

    // merge max caption width and max shrtcut width
    // office-like align (align shortcuts to the left)
    if not (mfStandardAlign in Options.Flags)
    then begin
      if W2 > 0 then Inc(W2, 10);
      if (FiWidth < W1 + W2) then FiWidth:= W1 + W2;
    end;

    // max width
    if ItemWidth < W1 then ItemWidth:= W1;
  end { loop for each menu item };

  // auto line reduction
  if IsSeparatorItem(M)
  then ItemRects.Delete(ItemRects.Count -1);

  // restore default canvas settings
  SetDefault(False);

  // merge max caption width and max shortcut width
  // standard align (align shortcuts to the right)
  if (mfStandardAlign in Options.Flags)
{$IFDEF Delphi4OrHigher}
  or ((BiDiMode = bdLeftToRight) and (Options.Alignment = taRightJustify))
  or ((BiDiMode <> bdLeftToRight) and (Options.Alignment = taLeftJustify))
{$ENDIF}
  then begin
    FiWidth:= ItemWidth + ShortCutWidth;
    if ShortCutWidth > 0 then Inc(FiWidth, 4);
  end;

  // add margins
  with Options.Margins
  do Inc(FiWidth, Left + Right);

  // add title
  if Options.HasTitle
  and Options.Title.Visible
  and (Options.Title.Position = atLeft)
  then Inc(FiLeft, Options.Title.Width);

  // set flag for hidden menu items
  if DI2 > 0
  then Include(State, fsHiddenArrow);

  // check menu with hidden menu items
  // and without unhidden menu items
  if (I = 0) and (DI2 > 0)
  then begin
    Include(State, fsShowHidden);
    RebuildBounds;
  end;

  if fsScrollbars in State
  then LastVisibleIndex:= GetLastVisibleIndex
  else LastVisibleIndex:= ItemRects.Count -1;

end;

{function TPopupMenu2000Form.GetItemRect(Index: Integer): TRect;
var
  I, Index1: Integer;
begin
  FillChar(Result, SizeOf(TRect), 0);

  if (Index >= 0) and (Index < ItemRects.Count)
  then begin
    Result.Left:=   FiLeft;
    Result.Right:=  Result.Left + FiWidth;

    Index1:= Index;
    while (I < ItemRects.Count)
    and (Index1 > 0)
    do begin
      Inc(I);
      if MenuItems[I].Visible
      then Dec(Index1);
    end;

    if Index1 = 0
    then begin
      Result.Top:=    LongRec(ItemRects[I]).Lo;
      Result.Bottom:= Result.Top + LongRec(ItemRects[I]).Hi;
    end;
  end;
end;
}
function TPopupMenu2000Form.GetItemRect(Index: Integer): TRect;
begin
  if (Index >= 0) and (Index < ItemRects.Count)
  then begin
    Result.Left:=   FiLeft;
    Result.Top:=    LongRec(ItemRects[Index]).Lo;
    Result.Right:=  Result.Left + FiWidth;
    Result.Bottom:= Result.Top + LongRec(ItemRects[Index]).Hi;
  end
  else
    FillChar(Result, SizeOf(TRect), 0);
end;


procedure TPopupMenu2000Form.InitializeMenuState;
var
  OldState: T_AM2000_PMFState;
  BoolTemp: Bool;
begin
  OldState:= State;

  if (PopupMenu = nil) then Exit;

  // init menu items
  if Owner is {$IFDEF Delphi3OrHigher}TCustomForm{$ELSE}TForm{$ENDIF}
  then SendMessage(TForm(Owner).Handle, wm_InitMenuPopup, LongInt(MenuHandle), 0);

  if (Ole2ObjectWindow <> 0)
  and not (fsMenuPopulated in State)
  then SendMessage(Ole2ObjectWindow, wm_InitMenuPopup, LongInt(MenuHandle), 0);

  FormStyle:= fsStayOnTop;
  BorderStyle:= bsNone;

  if (fsShowHidden in OldState)
  then PopupMenu.Options.Flags:= PopupMenu.Options.Flags + [mfHiddenIsVisible];

  // assign options property
  if ParentMenuForm = nil
  then GetOptions(MenuItems, PopupMenu, Options)
  else GetOptions(MenuItems, nil, Options);

  Color:= Options.Colors.Menu;

  // set Ctl3D
  if ParentMenuForm <> nil
  then begin
    if (fsCtl3D in ParentMenuForm.State)
    then State:= [fsCtl3d]
    else State:= [];

    State:= State + ParentMenuForm.State * [fsHotTrack, fsPreview, fsFraming];

    if ParentMenuForm.Options.Margins.Bevel <> 0
    then Options.Margins.Bevel:= ParentMenuForm.Options.Margins.Bevel;

    if ParentMenuForm.Options.Margins.Border <> 1
    then Options.Margins.Border:= ParentMenuForm.Options.Margins.Border;

  end
  else
    if (PopupSkin.SystemCtl3D)
    then begin
      // animation
      if (not SystemParametersInfo(SPI_GetFlatMenu, 0, @BoolTemp, 0))
      or (not BoolTemp)
      then  // older windows or 3d menus
        State:= [fsCtl3d]
      else begin // WinMe/2K/XP - flat menus
        State:= [];

        if Options.Margins.Bevel = 0
        then Options.Margins.Bevel:= 1;

        if Options.Margins.Border = 1
        then Options.Margins.Border:= 2;
      end;
    end
    else
    if (PopupSkin.Ctl3D)
    then State:= [fsCtl3d]
    else State:= [];

  // for submenus these properties
  // already initialized in CreateSubMenuForm
  if ParentMenuForm = nil
  then Animation:= Options.Animation;

  // restore
  if (fsPreview in OldState)
  or ((ParentMenuForm <> nil) and (fsPreview in ParentMenuForm.State))
  then begin
    Include(State, fsPreview);
    Include(State, fsShowHidden);
    Include(State, fsIgnoreAnimation);
    Options.Flags:= Options.Flags - [mfDropShadow];

    if not Assigned(pSetLayeredWindowAttributes)
    then Options.Opacity:= 100;
  end;

  if (mfHiddenIsVisible in Options.Flags)
  then Include(State, fsShowHidden);

  if (mfHiddenAsRegular in Options.Flags)
  then Include(State, fsHiddenAsRegular);

  // persist state
  State:= State + OldState * [fsShowHidden, fsHotTrack, fsMenuPopulated, fsShowAccelerators,
    fsIgnoreAnimation, fsSibling, fsFraming];


  if (fsFromRightToLeft in OldState)
  or ((ParentMenuForm <> nil)
  and (fsFromRightToLeft in ParentMenuForm.State))
  then Include(State, fsFromRightToLeft);


  // reassign font handle
  if PopupSkin.ParentFont
  then begin
    if (PopupMenu.Owner is TControl)
    then Font:= TForm(PopupMenu.Owner).Font
    else
    if (PopupMenu.PopupComponent <> nil)
    and (PopupMenu.PopupComponent is TControl)
    then Font:= TForm(PopupMenu.PopupComponent.Owner).Font
  end
  else
    if PopupSkin.SystemFont
    then Font.Handle:= GetMenuFontHandle
    else Font:= PopupSkin.Font;

  Canvas.Font.Assign(Font);
  Buffer.Canvas.Font.Assign(Font);

  // get menu item height
  if (Options.Margins.Item = 0)
  then ItemHeight:= Canvas.TextHeight('Hj') +7
  else ItemHeight:= Options.Margins.Item;

  // reset Top and left
  if (ParentMenuForm = nil)
  and (PopupMenu <> nil)
  then SetBounds(PopupMenu.PopupX, PopupMenu.PopupY, 0, 0);

  // fsFraming
  if (PopupMenu <> nil)
  and (ActiveDragWindow = nil)
  and (PopupMenu.PopupComponent is TCustomMenuBar2000)
  and (TCustomMenuBar2000(PopupMenu.PopupComponent).aiState = aiFraming)
  then begin
    Include(State, fsFraming);
    SetDragCursor;
  end;
end;

procedure TPopupMenu2000Form.OnHotTrack(Sender: TObject);
begin
  StopTimer;
  if not IsOkControlUnderCursor
  then KillActivePopupMenu2000(True, False);
end;

{$IFDEF Delphi4OrHigher}
procedure TPopupMenu2000Form.DoClose(var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;
{$ENDIF}

procedure TPopupMenu2000Form.Refresh;
var
  NewLeft, NewTop, NewWidth, NewHeight, TopSpace: Integer;
begin
  if (fsAnimated in State)
  then Exit;

  RebuildBounds;
  RebuildToolTipWindow(False);

  RealWidth:= GetRealWidth;
  RealHeight:= GetRealHeight;

  CheckOrigin(anNone, NewLeft, NewTop, NewWidth, NewHeight);

  Buffer.Handle:= CreateDibSectionEx(Buffer.Canvas.Handle, RealWidth, RealHeight, @BufferBits);
  if TempBuffer <> nil
  then TempBuffer.Handle:= CreateDibSectionEx(TempBuffer.Canvas.Handle, RealWidth, RealHeight, @TempBufferBits);

  Back.Handle:= 0;

  if (Options.Opacity <> 100)
  and (OpacityBits <> nil)
  then begin
    OpacityBits.SetSourceBitmap(Buffer.Handle, BufferBits);
    Desktop.GetBitmap(Buffer.Canvas.Handle, NewLeft, NewTop, RealWidth, RealHeight);
    OpacityBits.GetBackgroundBits(Buffer.Handle, BufferBits);
  end;

  if BorderStyle = bsNone
  then TopSpace:= 0
  else TopSpace:= 2;

  with ClientRect
  do
    SetBounds(NewLeft, NewTop,
      Width - Right + RealWidth, Height - Bottom + RealHeight + TopSpace);

  if ParentMenuForm = nil
  then GetOptions(MenuItems, PopupMenu, Options)
  else GetOptions(MenuItems, nil, Options);

  Color:= Options.Colors.Menu;
  Include(State, fsPaintMenu);
  Include(State, fsSelectedChanged);
  Paint;

  if DropShadow <> nil
  then DropShadow.Update;

  if SubMenuForm <> nil
  then begin
    LastSelectedIndex:= FSelectedIndex;
    FSelectedIndex:= GetIndexByMenuItem(SubMenuForm.MenuItems);
    SubMenuForm.ParentMenuIndex:= FSelectedIndex;
    
    if (FSelectedIndex <> -1)
    then
      with ClientToScreen(GetPopupPoint(FSelectedIndex)), SubMenuForm
      do SetBounds(X, Y, Width, Height);

    SubMenuForm.Refresh;
  end;
end;

procedure TPopupMenu2000Form.PostMenuSelectMessage;
var
  hwnd: THAndle;
begin
  if (GetCurMenuItem = nil)
  then Exit;

  hwnd:= GetHighestForm.Handle;

  if GetCount(CurMenuItem) > 0
  then CallMenuMsgFilter(hwnd, wm_MenuSelect, MakeLong(mf_Popup, 0), CurMenuItem.Handle)
  else CallMenuMsgFilter(hwnd, wm_MenuSelect, CurMenuItem.Command, 0);
end;

procedure TPopupMenu2000Form.wmSetState(var Msg: TMessage);

  procedure SetState(AStateFlag: T_AM2000_PMF);
  begin
    if Msg.LParam <> 0
    then Include(State, AStateFlag)
    else Exclude(State, AStateFlag);
  end;

begin
  case Msg.wParam of
    ssAnimation:
      SetState(fsIgnoreAnimation);

    ssSelection:
      begin
        LastSelectedIndex:= FSelectedIndex;
        FSelectedIndex:= Msg.lParam;

        if (Width <> 0)
        and (Height <> 0)
        then Paint;
      end;

    ssHidden:
      if not (fsPreview in State)
      then SetState(fsShowHidden);

    ssPreview:
      SetState(fsPreview);

    ssDesigning:
      SetState(fsDesigning);

    ssEnabled:
      if Msg.lParam <> 0
      then Exclude(State, fsDisabled)
      else Include(State, fsDisabled);

    ssFocusItem:
      FocusItem:= TMenuItem2000(Msg.lParam);

    ssFraming:
      begin
        SetState(fsFraming);
        MouseState:= [];

        if Msg.lParam <> 0
        then SetDragCursor
        else RestoreCursorDefault(crNone);

        if SubMenuForm <> nil
        then SubMenuForm.wmSetState(Msg);
      end;

    ssAccel:
      SetState(fsShowAccelerators);

    ssPopulated:
      SetState(fsMenuPopulated);

    ssHotTrack:
      SetState(fsHotTrack);

    ssOleWindow:
      Ole2ObjectWindow:= Msg.lParam;

    ssSibling:
      SetState(fsSibling);

    ssRightToLeft:
      SetState(fsFromRightToLeft);

    ssIgnoreMouseUp:
      SetState(fsIgnoreNextMouseUp);

    else
      Exit;
  end;

  Msg.Result:= 1;
end;

procedure TPopupMenu2000Form.wmGetState(var Msg: TMessage);
begin
  case Msg.wParam of
    ssPreview:
      Msg.Result:= Integer(fsPreview in State);
  end;
end;

procedure TPopupMenu2000Form.wmPaintOnCanvas(var Msg: TMessage);
var
  PF, PT: TPoint;
begin
  if (RealWidth = 0)
  or (RealHeight = 0)
  or ((Msg.LParam <> 0)
  and (PWmPaintOnCanvas(Msg.LParam).RebuildMenu))
  then begin
    // rebuild menu item
    Include(State, fsShowHidden);
    PopupMenu.AssignMenuItems(MenuItems, MenuHandle);

    InitializeMenuState;
    RebuildBounds;
    RealWidth:= GetRealWidth;
    RealHeight:= GetRealHeight;

    Buffer.Handle:= CreateDibSectionEx(Buffer.Canvas.Handle, RealWidth, RealHeight, @BufferBits);

    if OpacityBits <> nil
    then OpacityBits.SetSourceBitmap(Buffer.Handle, BufferBits);

    Include(State, fsAnimated);
    Include(State, fsPaintMenu);

    // set selected index
    LastSelectedIndex:= FSelectedIndex;
    FSelectedIndex:= GetIndexByMenuItem(PWmPaintOnCanvas(Msg.LParam).Selected);

    Paint;
  end;

  if Msg.LParam <> 0
  then
    with PWmPaintOnCanvas(Msg.LParam)^
    do begin
      PF:= pFrom;
      PT:= pTo;
    end

  else begin
    PF:= Point(0, 0);
    PT:= PF;
  end;

  BitBlt(Msg.WParam, PT.X, PT.Y, Buffer.Width, Buffer.Height, Buffer.Canvas.Handle,
    PF.X, PF.Y, SrcCopy);

  Msg.Result:= 1;
end;

procedure TPopupMenu2000Form.wmSetMenuItem(var Msg: TMessage);
begin
  if MenuItems = nil
  then begin
    PopupMenu.AssignMenuItems(MenuItems, MenuHandle);

    if MenuItems = nil
    then Exit;
  end;

  LastSelectedIndex:= FSelectedIndex;
  FSelectedIndex:= GetIndexByMenuItem(TMenuItem(Msg.wParam));

  Include(State, fsSelectedChanged);

  if Options <> nil
  then Paint;
end;

procedure TPopupMenu2000Form.SetSelected(const AItem: TMenuItem);
var
  M: TMenuItem;
  I: Integer;
begin
  if MenuItems = nil
  then Exit;

  ActiveMenuItem:= AItem;
  M:= AItem;
  while M <> nil
  do begin
    I:= MenuItems.IndexOf(M);
    if I <> -1
    then begin
      SetSelectedIndex(I);
      if HasSubmenu(M)
      then begin
        PopupSubMenuForm(False);

        if SubMenuForm <> nil
        then SubMenuForm.SetSelected(AItem);
      end
      else
        DestroySubMenuForm;

      if Options <> nil
      then Paint;
      
      Exit;
    end;

    M:= M.Parent;
  end;

  FSelectedIndex:= itNothing;
  Paint;
end;


procedure TPopupMenu2000Form.Update;
begin
  Refresh;
end;


{$IFNDEF Delphi3OrHigher}
const WHEEL_DELTA = 120;
{$ENDIF}

procedure TPopupMenu2000Form.wmMouseWheel(var Msg: TWMMouseWheel);
var
  Negative: Boolean;
  KeyDownMsg: TWMKeyDown;
begin
  Inc(FWheelAccumulator, Msg.WheelDelta);

  while Abs(FWheelAccumulator) >= WHEEL_DELTA
  do begin
    Negative:= FWheelAccumulator < 0;
    FWheelAccumulator:= Abs(FWheelAccumulator) - WHEEL_DELTA;
    if Negative
    then begin
      FWheelAccumulator:= -FWheelAccumulator;

      // move down
      if SelectedIndex < ItemRects.Count -1
      then begin
        KeyDownMsg.CharCode:= vk_Down;
        wmKeyDown(KeyDownMsg);
      end;
    end
    else
      // move up
      if SelectedIndex > 0
      then begin
        KeyDownMsg.CharCode:= vk_Up;
        wmKeyDown(KeyDownMsg);
      end;
  end;

  Msg.Result:= 1;
end;

procedure TPopupMenu2000Form.wmUnhide(var Msg: TMessage);
begin
  if (fsAnimated in State)
  or (Height = 0)
  or (Width = 0)
  then begin
    SilentHide;
    Include(State, fsShowHidden);
    Animate;
  end
  else
    OnUnhideTimer(nil);

  Msg.Result:= 1;
end;

function TPopupMenu2000Form.GetDropShadow: Boolean;
var
  BoolTemp: Bool;
begin
  Result:=
    // drop shadow is defined in Options
    (mfDropShadow in Options.Flags)
  or
    // drop shadow is defined in Windows XP
     (PopupSkin.SystemShadow
  and SystemParametersInfo(SPI_GetDropShadow, 0, @BoolTemp, 0)
  and BoolTemp);
end;

procedure TPopupMenu2000Form.wmGetForm(var Msg: TMessage);
begin
  Msg.Result:= 0;

  if (MenuItems <> nil)
  and (MenuItems.IndexOf(TMenuItem(Msg.WParam)) <> -1)
  then Msg.Result:= LongInt(Self)
  else
  if SubMenuForm <> nil
  then SubMenuForm.wmGetForm(Msg);
end;

function TPopupMenu2000Form.GetHighestForm: TPopupMenu2000Form;
begin
  Result:= Self;

  while Result.ParentMenuForm <> nil
  do Result:= Result.ParentMenuForm;
end;

function TPopupMenu2000Form.GetLowestForm: TPopupMenu2000Form;
begin
  Result:= Self;

  while Result.SubMenuForm <> nil
  do Result:= Result.SubMenuForm;
end;




initialization
finalization
  FreeMemAndNil(MenuOpacityData);

end.
