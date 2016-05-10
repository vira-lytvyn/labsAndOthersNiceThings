
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       TMenuItem2000                                   }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit am2000menuitem;

{$I am2000.inc}

interface

uses
  {$IFDEF ACTIVEX}AnimatedMenusXP_tlb, ActiveX, {$ENDIF}
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  Windows, SysUtils, Classes, Controls, Graphics, Menus, Registry, StdCtrls,
  am2000options, am2000bitmap, am2000button, am2000buttonarray,
  am2000editbox, am2000text, am2000utils;

type

  // shortcut type
  T_AM2000_ShortCut = Type String;
  T_AM2000_DefaultIndex = type Integer;
  T_AM2000_ImageIndex = type Integer; 

  // options for menu item
  T_AM2000_MenuControlType = (ctlNone, ctlButton, ctlButtonArray, ctlEditbox,
    ctlBitmap, ctlText);

  // menu item
  TMenuItem2000 = class;

  T_AM2000_MenuBeforeDrawItemEvent = procedure (Sender: TObject; var DefaultDraw: Boolean)
    of object;

{$IFNDEF Delphi4OrHigher}
  T_AM2000_MenuDrawItemEvent = procedure (Sender: TObject; ACanvas: TCanvas;
    ARect: TRect; Selected: Boolean) of object;
  T_AM2000_MenuMeasureItemEvent = procedure (Sender: TObject; ACanvas: TCanvas;
    var Width, Height: Integer) of object;
  T_AM2000_OwnerDrawState = set of (odSelected, odGrayed, odDisabled, odChecked,
    odFocused, odDefault, odComboBoxEdit);
{$ENDIF}

{$IFNDEF Delphi4OrHigher}
  T_AM2000_AdvancedMenuDrawItemEvent = procedure (Sender: TObject; ACanvas: TCanvas;
    ARect: TRect; State: T_AM2000_OwnerDrawState) of object;
{$ENDIF}

{$IFDEF Delphi4}
  T_AM2000_AdvancedMenuDrawItemEvent = procedure (Sender: TObject; ACanvas: TCanvas;
    ARect: TRect; State: TOwnerDrawState) of object;
{$ENDIF}

  T_AM2000_StartDragEvent = procedure (Sender: TObject; var CanMove: Boolean) of object;
  T_AM2000_EndDragEvent = procedure (Sender: TObject; var AcceptMove: Boolean) of object;

{$IFDEF Delphi4OrHigher}
  T_AM2000_MenuActionLink = class(TMenuActionLink)
  protected
//    procedure SetAutoCheck
//    procedure SetGroupIndex
//    procedure SetShortCut
//    procedure SetSecondaryShortCuts
    procedure SetCaption(const Value: string); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetVisible(Value: Boolean); override;
  end;

  T_AM2000_MenuActionLinkClass = class of T_AM2000_MenuActionLink;
{$ENDIF}

  // TMenuItem2000
  TMenuItem2000 = class(TMenuItem{$IFDEF ACTIVEX}, IMenuItem{$ENDIF})
  private
    // improvements
    FPopupMenu      : T_AM2000_PopupMenu;
    FControl        : T_AM2000_MenuControlType;
    FControlOptions : T_AM2000_MenuControl;
    FHidden         : Boolean;
    FAttachMenu     : T_AM2000_PopupMenu;
    FOptions        : T_AM2000_ItemOptions;
    FShortCut       : T_AM2000_ShortCut;
    FDefaultBitmapIndex : T_AM2000_DefaultIndex;
    FNumGlyphs      : Integer;
    FDemotable      : Boolean;
    FUpdateCount    : Integer;
    FAnimatedSkin    : T_AM2000_AnimatedSkin;

{$IFNDEF Delphi6OrHigher}
    FAutoCheck      : Boolean;
{$ENDIF}

{$IFNDEF Delphi4OrHigher}
    FBitmap         : TBitmap;
    FImageIndex     : Integer;

    FOnDrawItem     : T_AM2000_MenuDrawItemEvent;
    FOnMeasureItem  : T_AM2000_MenuMeasureItemEvent;
{$ENDIF}

{$IFNDEF Delphi5OrHigher}
    FSubMenuImages  : TImageList;

    FOnAdvancedDrawItem : T_AM2000_AdvancedMenuDrawItemEvent;
{$ENDIF}

    FOnMouseDown    : TMouseEvent;
    FOnMouseUp      : TMouseEvent;
    FOnMouseMove    : TMouseMoveEvent;
    FOnEnter        : TNotifyEvent;
    FOnExit         : TNotifyEvent;
    FOnStartDrag    : T_AM2000_StartDragEvent;
    FOnEndDrag      : T_AM2000_EndDragEvent;

{$IFNDEF DESIGNTIME}
    FLastTimeUsed   : DWord;
{$ENDIF}    

    OriginalItem    : TMenuItem2000;

    FOnBeforeDrawItem   : T_AM2000_MenuBeforeDrawItemEvent;
    FMenuHandle: HMenu;

{$IFDEF ACTIVEX}
    FDispTypeInfo: ITypeInfo;
    FDispIntfEntry: PInterfaceEntry;
{$ENDIF}

    function GetParent: TMenuItem2000;
    function GetMenuHandle: HMenu;

    function GetControlOptions: T_AM2000_MenuControl;
    procedure SetControlOptions(Value: T_AM2000_MenuControl);

    procedure SetCaption(const Value: String);
    procedure SetEnabled(Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure SetControl(Value: T_AM2000_MenuControlType);
    procedure SetBitmap(Value: TBitmap);
{$IFDEF Delphi4OrHigher}
    procedure SetAction(Value: TBasicAction);
{$ENDIF}


    function IsOptionsStored:  Boolean;
    function GetOptions: T_AM2000_ItemOptions;
    procedure SetOptions(Value: T_AM2000_ItemOptions);
    function IsHintStored:     Boolean;
    function IsShortCutStored: Boolean;
    procedure SetShortCut(Value: T_AM2000_ShortCut);
    procedure SetHint(Value: String);
    procedure SetDefaultIndex(Value: T_AM2000_DefaultIndex);
    procedure SetChecked(Value: Boolean);
    procedure SetMenuHandle(const Value: HMenu);
    procedure SetImageIndex(Value: T_AM2000_ImageIndex);
    procedure SetAnimatedSkin(const Value: T_AM2000_AnimatedSkin);
    procedure SetAttachMenu(const Value: T_AM2000_PopupMenu);

    procedure Update(UpdateMenuBar: Integer);
    function IsInUpdate: Boolean;

{$IFDEF ACTIVEX}
    procedure IMenuItem.Remove = IMenuItem_Remove;

    // activex support
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function Get_Items(Index: Integer): IMenuItem; safecall;
    function Get_Checked: WordBool; safecall;
    procedure Set_Checked(Value: WordBool); safecall;
    function Get_Demotable: WordBool; safecall;
    procedure Set_Demotable(Value: WordBool); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_Hidden: WordBool; safecall;
    procedure Set_Hidden(Value: WordBool); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_Hint: WideString; safecall;
    procedure Set_Hint(const Value: WideString); safecall;
    function Get_ShortCut: WideString; safecall;
    procedure Set_ShortCut(const Value: WideString); safecall;
    function Get_NumGlyphs: Integer; safecall;
    procedure Set_NumGlyphs(Value: Integer); safecall;
    function Get_ImageIndex: Integer; safecall;
    procedure Set_ImageIndex(Value: Integer); safecall;
    function Get_DefaultIndex: Integer; safecall;
    procedure Set_DefaultIndex(Value: Integer); safecall;
    function Get_Count: Integer; safecall;
    function AddNew: IMenuItem; safecall;
    function AddNewChild: IMenuItem; safecall;
    function Get_Options: IItemOptions; safecall;
    procedure IMenuItem_Remove; safecall;

    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo,
      ArgErr: Pointer): HResult; stdcall;
    function DispTypeInfo: ITypeInfo;
    function DispIntfEntry: PInterfaceEntry;
{$ENDIF}

  protected
    procedure SetHidden(Value: Boolean); virtual;

    function GetItem(Index: Integer): TMenuItem2000; virtual;
    function GetCaption: String; virtual;
    function GetEnabled: Boolean; virtual;
    function GetVisible: Boolean; virtual;
    function GetBitmap: TBitmap; virtual;
    function GetChecked: Boolean; virtual;
{$IFDEF Delphi4OrHigher}
    function GetAction: TBasicAction; virtual;
{$ENDIF}
    function GetShortCut: T_AM2000_ShortCut; virtual;
    function GetHint: String; virtual;
    function GetImageIndex: T_AM2000_ImageIndex; virtual;
    function GetCount: Integer; virtual;
    function GetHidden: Boolean; virtual;

{$IFDEF Delphi4orHigher}
    function GetActionLinkClass: TMenuActionLinkClass; override;
{$ENDIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

{$IFDEF Delphi3}
    function GetParentComponent: TComponent; override;
{$ENDIF}

  public
    property MenuHandle    : HMenu read GetMenuHandle write SetMenuHandle;
    property Parent        : TMenuItem2000 read GetParent;
    property Items[Index: Integer]: TMenuItem2000 read GetItem; default;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Insert(Index: Integer; Item: TMenuItem2000);
    function IndexOf(Item: TMenuItem2000): Integer;
    procedure Add(Item: TMenuItem2000);
    procedure Remove(Item: TMenuItem2000);
    procedure Delete(Index: Integer);
    procedure TurnSiblingsOff;
    procedure UpdateFromOptions;
    procedure ReleaseHandle;

    procedure Click; override;

    function GetMenuBar       : TWinControl;
    function GetMenu          : TMenu;
    function HasBitmap        : Boolean; virtual;

{$IFDEF Delphi4OrHigher}
    function GetParentMenu: TMenu;
    function GetParentComponent: TComponent; override;
{$ENDIF}

    // control support
    function AsButtonArray    : T_AM2000_ButtonArrayControl;
    function AsButton         : T_AM2000_ButtonControl;
    function AsBitmap         : T_AM2000_BitmapControl;
    function AsEdit           : T_AM2000_EditControl;
    function AsText           : T_AM2000_TextControl;

    // bounds measuring functions
    function GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
    function GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer;

    // assign
    procedure Assign(Source: TPersistent); override;

    procedure BeginUpdate;
    procedure EndUpdate;

{$IFDEF Delphi4OrHigher}
    procedure InitiateAction; override;
{$ENDIF}
{$IFNDEF Delphi5OrHigher}
    procedure Clear;
{$ENDIF}

    function HasOptions: Boolean;
    function HasControl: Boolean;

    property Count: Integer
      read GetCount; 

  published
    property AnimatedSkin    : T_AM2000_AnimatedSkin
      read FAnimatedSkin write SetAnimatedSkin;
    property Bitmap        : TBitmap
      read GetBitmap write SetBitmap stored HasBitmap;
    property Caption       : String
      read GetCaption write SetCaption;
    property Checked       : Boolean
      read GetChecked write SetChecked default False;
    property Control       : T_AM2000_MenuControlType
      read FControl write SetControl default ctlNone;
    property ControlOptions: T_AM2000_MenuControl
      read GetControlOptions write SetControlOptions stored True;
    property Demotable     : Boolean
      read FDemotable write FDemotable default True;
    property Enabled       : Boolean
      read GetEnabled write SetEnabled default True;
    property Hidden        : Boolean
      read GetHidden write SetHidden default False;
    property PopupMenu     : T_AM2000_PopupMenu
      read FPopupMenu write FPopupMenu;
    property Visible       : Boolean
      read GetVisible write SetVisible default True;
    property DefaultIndex  : T_AM2000_DefaultIndex
      read FDefaultBitmapIndex write SetDefaultIndex default -1;
    property AttachMenu    : T_AM2000_PopupMenu
      read FAttachMenu write SetAttachMenu;
    property Options       : T_AM2000_ItemOptions
      read GetOptions write SetOptions stored IsOptionsStored;
    property Hint          : String
      read GetHint write SetHint stored IsHintStored;
    property ShortCut      : T_AM2000_ShortCut
      read GetShortCut write SetShortCut stored IsShortCutStored;
    property NumGlyphs     : Integer
      read FNumGlyphs write FNumGlyphs default 1;
    property ImageIndex    : T_AM2000_ImageIndex
      read GetImageIndex write SetImageIndex default -1;

{$IFNDEF Delphi5OrHigher}
    property SubMenuImages : TImageList
      read FSubMenuImages write FSubMenuImages;
{$ENDIF}

{$IFDEF Delphi4OrHigher}
    property Action        : TBasicAction
      read GetAction write SetAction;
{$ENDIF}

{$IFNDEF Delphi4OrHigher}
    property OnDrawItem    : T_AM2000_MenuDrawItemEvent
      read FOnDrawItem write FOnDrawItem;
    property OnMeasureItem : T_AM2000_MenuMeasureItemEvent
      read FOnMeasureItem write FOnMeasureItem;
{$ENDIF}

{$IFNDEF Delphi5OrHigher}
    property OnAdvancedDrawItem : T_AM2000_AdvancedMenuDrawItemEvent
      read FOnAdvancedDrawItem write FOnAdvancedDrawItem;
{$ENDIF}

{$IFNDEF Delphi6OrHigher}
    property AutoCheck     : Boolean
      read FAutoCheck write FAutoCheck default False;
{$ENDIF}

    property OnBeforeDrawItem   : T_AM2000_MenuBeforeDrawItemEvent
      read FOnBeforeDrawItem write FOnBeforeDrawItem;
    property OnMouseDown        : TMouseEvent
      read FOnMouseDown write FOnMouseDown;
    property OnMouseUp          : TMouseEvent
      read FOnMouseUp write FOnMouseUp;
    property OnMouseMove        : TMouseMoveEvent
      read FOnMouseMove write FOnMouseMove;
    property OnEnter            : TNotifyEvent
      read FOnEnter write FOnEnter;
    property OnExit             : TNotifyEvent
      read FOnExit write FOnExit;
    property OnStartDrag        : T_AM2000_StartDragEvent
      read FOnStartDrag write FOnStartDrag;
    property OnEndDrag          : T_AM2000_EndDragEvent
      read FOnEndDrag write FOnEndDrag;

{$IFNDEF DesignTime}
    property LastTimeUsed : DWord
      read FLastTimeUsed write FLastTimeUsed default 0;
{$ENDIF}

  end;


  // TEditableMenuItem98
  // This class was designed because of error in Delphi:
  // you cannot register another menu designer when you already have default designer
  // This class are incompatible with TMenuItem nor TMenuItem2000 but acts like layer
  // between your application and the TMenuItem2000 components stored in FItems property
  // It has only minimal set of properties and methods so please verify your applications
  // for bugs
  // Also you can use Items2000 property of TMainMenu2000 and TPopupMenu2000 components
  // to direct access real TMenuItem2000 components.
  TEditableMenuItem2000 = class(TComponent)
  private
    function GetHandle: HMenu;
    function GetCount: Integer;
    function GetItem(Index: Integer): TMenuItem2000;

  public                                  
    property Handle        : HMenu        read GetHandle;
    property Count         : Integer      read GetCount;
    property Items[Index: Integer]: TMenuItem2000 read GetItem; default;

    procedure Insert(Index: Integer; Item: TMenuItem2000);
    procedure Delete(Index: Integer);
    function IndexOf(Item: TMenuItem2000): Integer;
    procedure Add(Item: TMenuItem2000);
    procedure Remove(Item: TMenuItem2000);
    procedure Clear;

  end;

// compatibility
function NewMenu(Owner: TComponent; const AName: string; Items: array of TMenuItem): TMainMenu;
function NewPopupMenu(Owner: TComponent; const AName: string;
  Alignment: TPopupAlignment; AutoPopup: Boolean; Items: array of TMenuItem): TPopupMenu;
function NewSubMenu(const ACaption: string; hCtx: Word; const AName: string;
  Items: array of TMenuItem2000): TMenuItem2000;
function NewItem(const ACaption: string; AShortCut: TShortCut;
  AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent; hCtx: Word;
  const AName: string): TMenuItem2000;
function NewLine: TMenuItem2000;

function NewItem2000(const ACaption, AShortCut: string;
  AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent; hCtx: Word;
  const AName: string): TMenuItem2000;
function NewLine2000: TMenuItem2000;

function GetMainShortCut(const S: String): String;
procedure SetState(var its: T_AM2000_ItemState; Value: T_AM2000_its; Condition: Boolean);


// drawing routines - both for TMenuItem and TMenuItem2000

// draws menu item when TMenuItem or TMenuItem2000 component doesn't present
// (like Window menu's menu items in Delphi 2 & 3)
procedure PaintMenuItemWin32(Params: P_AM2000_PaintMenuItemParams);

// draws TMenuItem2000 with ControlStyle = ctlNone and TMenuItem
procedure PaintMenuItem(Params: P_AM2000_PaintMenuItemParams);

// draws TCustomAction as menu item
procedure PaintAction(Params: P_AM2000_PaintMenuItemParams);



{ Drawing routines }

procedure DrawTextItem(
  const Canvas: TCanvas;
  const Options: T_AM2000_MenuOptions;
  Caption: String;
  Shortcut: String;
  const Bitmap: HBitmap;
  const BitmapIndex: Integer;
  const Bitmaps: TCustomImageList;
  const DefaultIndex: Integer;
  const NumGlyphs: Integer;
  State: T_AM2000_ItemState;
  const MouseState: T_AM2000_MouseState;
  const Params: P_AM2000_PaintMenuItemParams);

procedure DrawBitmapCache(
  const Canvas: TCanvas;
  const Caption: String;
  const Bitmap2: HBitmap;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);

procedure DrawBitmapIndex(
  const Canvas: TCanvas;
  const ImageIndex: Integer;
  const Bitmap2: HBitmap;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);

procedure DrawSeparator(
  const Canvas: TCanvas;
  const Caption: String;
  State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  Rect: TRect);

procedure DrawCaption(
  const Canvas: TCanvas;
  const Caption: String;
  const State: T_AM2000_ItemState;
  const Alignment: TAlignment;
  const Rect: TRect;
  const HideAccelerators: Boolean);

procedure DrawFrame(
  Canvas: TCanvas;
  State: T_AM2000_ItemState;
  Options: T_AM2000_MenuOptions;
  Rect: TRect);

procedure DrawBackground(
  const Canvas: TCanvas;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  ARect: TRect);

procedure DrawBitmapHandle(
  const Canvas: TCanvas;
  const Bitmap: HBitmap;
  const NumGlyphs: Integer;
  const Bitmap2: HBitmap;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);

procedure DrawBitmapImageList(
  const Canvas: TCanvas;
  const BitmapIndex: Integer;
  const Images: TCustomImageList;
  const Bitmap2: HBitmap;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);

procedure DrawGutter(
  const Canvas: TCanvas;
  const State: T_Am2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect;
  var RG: TRect);

procedure DrawPatternBackground(
  const Canvas: TCanvas;
  const Rect: TRect);

procedure DrawSolidBackground(
  const Canvas: TCanvas;
  const Rect: TRect;
  const Color: TColor);

procedure DrawSubmenuTriangle(
  const Canvas: TCanvas;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);


implementation

uses
  CommCtrl, ExtCtrls, Forms,
  {$IFDEF Delphi4OrHigher} ActnList, {$ENDIF}
  am2000menubar, am2000mainmenu, am2000popupmenu, am2000cache,
  am2000dragwindow, am2000desktop, am2000skin
  {$IFDEF ActiveX}, ComServ, ComObj {$ENDIF};


type  
  TFalseMenuItem = class(TComponent)
  private
    FCaption: string;
    FHandle: HMENU;
  end;



{ Routines }

function NewMenu(Owner: TComponent; const AName: string; Items: array of TMenuItem): TMainMenu;
begin
  raise EMenuError.Create(SNoNewMenu);
end;

function NewPopupMenu(Owner: TComponent; const AName: string;
  Alignment: TPopupAlignment; AutoPopup: Boolean; Items: array of TMenuItem): TPopupMenu;
begin
  raise EMenuError.Create(SNoNewPopupMenu);
end;

function NewSubMenu(const ACaption: string; hCtx: Word; const AName: string;
  Items: array of TMenuItem2000): TMenuItem2000;
var
  I: Integer;
begin
  Result := TMenuItem2000.Create(nil);
  for I := Low(Items) to High(Items) do
    Result.Add(Items[I]);
  Result.Caption := ACaption;
  Result.HelpContext := hCtx;
  Result.Name := AName;
end;

function NewItem(const ACaption: string; AShortCut: TShortCut;
  AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent; hCtx: Word;
  const AName: string): TMenuItem2000;
begin
  Result:= TMenuItem2000.Create(nil);
  with Result do begin
    Caption:= ACaption;
    ShortCut:= ShortCutToText(AShortCut);
    OnClick:= AOnClick;
    HelpContext:= hCtx;
    Checked:= AChecked;
    Enabled:= AEnabled;
    Name:= AName;
  end;
end;

function NewLine: TMenuItem2000;
begin
  Result:= TMenuItem2000.Create(nil);
  Result.Caption:= SSeparator;
end;

function NewItem2000(const ACaption, AShortCut: string;
  AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent; hCtx: Word;
  const AName: string): TMenuItem2000;
begin
  Result:= TMenuItem2000.Create(nil);
  with Result do begin
    Caption:= ACaption;
    ShortCut:= AShortCut;
    OnClick:= AOnClick;
    HelpContext:= hCtx;
    Checked:= AChecked;
    Enabled:= AEnabled;
    Name:= AName;
  end;
end;

function NewLine2000: TMenuItem2000;
begin
  Result:= NewLine;
end;

function GetMainShortCut(const S: String): String;
var
  I: Integer;
begin
  I:= Pos(SShortcutDivider, S);
  if I < 1 then I:= Length(S) +1;
  Result:= Trim(Copy(S, 1, I -1));
end;


{ SetState }

procedure SetState(var its: T_AM2000_ItemState; Value: T_AM2000_its; Condition: Boolean);
begin
  if Condition
  then Include(its, Value)
  else Exclude(its, Value);
end;



{ Drawing routines }

procedure DrawBackground(
  const Canvas: TCanvas;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  ARect: TRect);
var
  B, T: Integer;
  R, RG: TRect;
begin
  // gutter
  DrawGutter(Canvas, PaintParams.State, Options, ARect, RG);

  // no background on graphic backround
  if Options.HasSkin
  // if we add ItemBackgroundNormal then this condition should gone
  and (((isSelected in State) and not Options.Skin.ItemBackgroundHighlight.Empty)
  or ((isHidden in State) and not Options.Skin.ItemBackgroundSunken.Empty))
  then begin
    Options.Skin.PaintItemBackground(Canvas, State, ARect);
    Exit;
  end;

  if (isGraphBack in State)
  and (((isSelected in State) and (Options.Colors.Highlight = clNone))
  or ((isHidden in State) and (Options.Colors.Sunken = clNone)))
  then Exit;

  // correct rectangle for hidden
  if (isHidden in State)
  then begin
    R:= ARect;
    B:= Options.Margins.Border;
    if isCtl3d in State
    then T:= 1
    else T:= 0;

    if (isNoLeftSunken in State)
    then Dec(R.Left, B)
    else Dec(R.Left, B + T);

    if (isNoRightSunken in State)
    then Inc(R.Right, B)
    else Inc(R.Right, B + T);

    SubtractRect(R, R, RG);

    if Options.Colors.Sunken <> clNone
    then DrawSolidBackground(Canvas, R, Options.Colors.Sunken)
    else DrawPatternBackground(Canvas, R);

    InflateRect(ARect, 0, -1);

    if (isCtl3d in State)
    then begin
      // not highlighted - hidden
      // draw borders
      if not (isHiddenPrev in State)
      then begin
        Canvas.Pen.Style:= psSolid;
        Canvas.Pen.Color:= Options.Colors.Line;
        Canvas.Polyline([Point(R.Left, ARect.Top -1), Point(R.Right, ARect.Top -1)]);
      end;
      if not (isHiddenSucc in State)
      then begin
        Canvas.Pen.Style:= psSolid;
        Canvas.Pen.Color:= Options.Colors.LineShadow;
        Canvas.Polyline([Point(R.Left, ARect.Bottom), Point(R.Right, ARect.Bottom)]);
      end;
    end;
  end;

  if (isSelected in State)
  and ((not (isDisabled in State))
  or (not (mfNoHighDisabled in Options.Flags)))
  then begin
    if (not (isMenuBarItem in State))
    and (mfNoSharpJoints in Options.Flags)
    then InflateRect(ARect, Options.Margins.Border + Options.Margins.BevelInner, 0);

    // highlighted item
    if isPressed in State
    then DrawSolidBackground(Canvas, ARect, Options.Colors.Pressed)
    else DrawSolidBackground(Canvas, ARect, Options.Colors.Highlight);
  end
  else
  if (not (isHidden in State))
  and (not (isGraphBack in State))
  then begin
    // not highlighted - regular
    SubtractRect(R, ARect, RG);
    DrawSolidBackground(Canvas, R, Options.Colors.Menu);
  end;
end;

procedure DrawFrame(
  Canvas: TCanvas;
  State: T_AM2000_ItemState;
  Options: T_AM2000_MenuOptions;
  Rect: TRect);
var
  R: TRect;
begin
  R:= Rect;
  // draw active frame
  if isFramed in State
  then begin
    with Canvas.Brush
    do begin
      if Color <> clBlack then Color:= clBlack;
      if Style <> bsSolid then Style:= bsSolid;
    end;
    Canvas.FrameRect(R);
    InflateRect(R, -1, -1);
    Canvas.FrameRect(R);
    R:= Rect;
  end;

  // line at top
  if (isInsertBefore in State)
  then begin
    with Canvas.Pen
    do begin
      if Color <> clBlack then Color:= clBlack;
      if Style <> psSolid then Style:= psSolid;
    end;

    Canvas.PolyGon([Point(R.Left, R.Top), Point(R.Left, R.Top +2), Point(R.Left +2, R.Top),
      Point(R.Right -3, R.Top), Point(R.Right -1, R.Top +2), Point(R.Right -1, R.Top)])
  end;

  // line at bottom
  if isInsertAfter in State
  then begin
    with Canvas.Pen
    do begin
      if Color <> clBlack then Color:= clBlack;
      if Style <> psSolid then Style:= psSolid;
    end;

    Canvas.PolyGon([Point(R.Left, R.Bottom -1), Point(R.Left, R.Bottom -3), Point(R.Left +2, R.Bottom -1),
      Point(R.Right -3, R.Bottom -1), Point(R.Right -1, R.Bottom -3), Point(R.Right -1, R.Bottom -1)])
  end;

  // draw frame
  if (isSelected in State)
  and (not (isSeparator in State))
  and (Options.Margins.Frame > 0)
  and ((not (mfNoHighDisabled in Options.Flags)) or not (isDisabled in State))
  then
    if (not (isMenuBarItem in State))
    and (mfNoSharpJoints in Options.Flags)
    then
      with Canvas
      do begin
        InflateRect(R, Options.Margins.Border + Options.Margins.BevelInner, 0);

        Pen.Width:= Options.Margins.Bevel;
        
        Pen.Color:= Options.Colors.Frame;
        PolyLine([R.TopLeft, Point(R.Right, R.Top)]);

        Pen.Color:= Options.Colors.FrameShadow;
        PolyLine([Point(R.Left, R.Bottom -1), Point(R.Right, R.Bottom -1)]);
      end
    else
      Frame3D(Canvas,
        R,
        Options.Colors.Frame,
        Options.Colors.FrameShadow,
        Options.Margins.Frame);
end;

procedure DrawCaption(
  const Canvas: TCanvas;
  const Caption: String;
  const State: T_AM2000_ItemState;
  const Alignment: TAlignment;
  const Rect: TRect;
  const HideAccelerators: Boolean);
var
  Flags, Lines, DY, P, W, W1: Integer;
  S, S1: String;
  R: TRect;
begin
  Flags:= dt_DrawTextFlags or dt_WordBreak or dt_VCenter;

  // caption alignment
  if (Alignment = taCenter)
  then Flags:= Flags or dt_Center
  else
  if (Alignment = taRightJustify)
  then Flags:= Flags or dt_Right;

  Lines:= GetNumLines(Caption);

  // draw caption
  DY:= (Rect.Bottom - Rect.Top) div Lines;
  R:= Rect;
  R.Bottom:= R.Top + DY;

  W:= Rect.Right - Rect.Left;
  W1:= Canvas.TextWidth(SOmissionPoints);
  S:= Caption;
  repeat
    P:= Pos(#13, S);
    
    if bEnableExtendedSymbols
    and (P = 0)
    then P:= Pos(SNewLine, S);

    if P = 0 then P:= Length(S) +1;

    S1:= Copy(S, 1, P -1);
    if AmpTextWidth(Canvas, S1) > W
    then begin
      repeat
        Delete(S1, Length(S1), 1);
      until (S1 = '') or (AmpTextWidth(Canvas, S1) < W - W1);

      S1:= S1 + SOmissionPoints;
    end;

    if HideAccelerators
    then begin
      S1:= StripAmpersands(S1);
      Flags:= Flags or dt_NoPrefix;
    end;
      
    DrawText(Canvas.Handle, PChar(S1), -1, R, Flags);
    OffsetRect(R, 0, DY);

    if (P < Length(S))
    and (S[P] = #13)
    then Delete(S, 1, P)
    else Delete(S, 1, P +1);
  until S = '';
end;

procedure DrawSubmenuTriangle(
  const Canvas: TCanvas;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);
var
  DY: Integer;
begin
  if (not (isSubmenu in State))
  or (Rect.Left = Rect.Right)
  then Exit;

  if Options.HasSkin
  and not Options.Skin.Triangle.Empty
  then
    with Options.Skin
    do begin
      if isSelected in State
      then PaintBitmap(Canvas, Triangle, State + [isPressed], Rect)
      else PaintBitmap(Canvas, Triangle, State, Rect);

      Exit;
    end;

  Canvas.Pen.Color:= Canvas.Font.Color;
  Canvas.Brush.Color:= Canvas.Font.Color;
  Canvas.Brush.Style:= bsSolid;

  DY:= (Rect.Top + Rect.Bottom - 5) div 2;
  if not (isLeftToRight in State)
  then
    Canvas.PolyGon([
      Point(Rect.Left  +8, DY),
      Point(Rect.Left  +8, DY +6),
      Point(Rect.Left  +5, DY +3)])
  else
    Canvas.PolyGon([
      Point(Rect.Right -8, DY),
      Point(Rect.Right -8, DY +6),
      Point(Rect.Right -5, DY +3)]);
end;

procedure DrawSeparator(
  const Canvas: TCanvas;
  const Caption: String;
  State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  Rect: TRect);
var
  Y, DLeft, DRight, DR1, R, G, B: Integer;
  OldColor, NewColor: TColor;
  S: String;

  procedure DrawPolyLine(const X1, X2, Y: Integer);
  var
    Color1, Color2: TColor;
    DX, I: Integer;
    R, G, B, DR, DG, DB: Double;
  begin
    with Canvas
    do begin
      PolyLine([Point(X1, Y), Point(X2, Y)]);

      if (Options <> nil)
      and (mfGradientSeparators in Options.Flags)
      then begin
        Color1:= ColorToRGB(Options.Colors.Menu);
        Color2:= ColorToRGB(Pen.Color);
        R:= GetRValue(Color1);
        G:= GetGValue(Color1);
        B:= GetBValue(Color1);

        DX:= (X2 - X1) div 3;
        DR:= (GetRValue(Color2) - R) / DX;
        DG:= (GetGValue(Color2) - G) / DX;
        DB:= (GetBValue(Color2) - B) / DX;

        for I:= 0 to DX -1
        do begin
          if DLeft > 0
          then SetPixel(Handle, X1 + I, Y, RGB(Round(R), Round(G), Round(B)));

          if DRight > 0
          then SetPixel(Handle, X2 - I, Y, RGB(Round(R), Round(G), Round(B)));

          R:= R + DR;
          G:= G + DG;
          B:= B + DB;
        end;
      end;
    end;
  end;

  procedure DrawSeparatorLine(const X1, X2, Y: Integer);
  var
    X: Integer;
  begin
    with Canvas do
      case Caption[1] of
        sSeparator:
          begin
            DrawPolyLine(X1, X2, Y);
          end;
        sDoubleSeparator:
          begin
            DrawPolyLine(X1, X2, Y);
            DrawPolyLine(X1, X2, Y +2);
          end;
        sDottedSeparator:
          begin
            X:= X1;
            while X < X2
            do begin
              Rectangle(X, Y, X +2, Y +2);
              Inc(X, 4);
            end;
          end;
        sDoubleDottedSeparator:
          begin
            X:= X1;
            while X < X2
            do begin
              Rectangle(X, Y, X +2, Y +2);
              Inc(X, 6);
            end;

            X:= X1 +3;
            while X < X2
            do begin
              Rectangle(X, Y +3, X +2, Y +5);
              Inc(X, 6);
            end;
          end;
        sEmptySeparator:;
      end;
  end;

begin
  if Options = nil
  then NewColor:= clBtnShadow
  else NewColor:= Options.Colors.Line;
  
  Exclude(State, isSelected);
  Exclude(State, isPressed);

  // hidden separator
  if (isHiddenPrev in State)
  and (isHiddenSucc in State)
  then Include(State, isHidden);

  if not (isGraphBack in State)
  then DrawBackground(Canvas, State, Options, Rect);

  DR1:= 1;
  Y:= (Rect.Top + Rect.Bottom) div 2;
  case Caption[1]
  of
    sDoubleSeparator: Dec(Y, 2);
    sDottedSeparator: Dec(Y, 1);
    sDoubleDottedSeparator: Dec(Y, 2);
  end;

  if (Options <> nil)
  then begin
    if mfNoSharpJoints in Options.Flags
    then begin
      DLeft:= -Options.Margins.Border - Options.Margins.BevelInner;
      DRight:= -DLeft -2;
      DR1:= 0;
    end
    else
    if (mfLongSeparators in Options.Flags)
    then begin
      DLeft:= 2;
      DRight:= 2;
    end
    else
    if (mfXpControls in Options.Flags)
    then
      if isLeftToRight in State
      then begin
        DLeft:= Options.Margins.Left;
        DRight:= -Options.Margins.Border;
      end
      else begin
        DLeft:= -Options.Margins.Border;
        DRight:= Options.Margins.Right;
      end

    else begin
      DLeft:= 14;
      DRight:= 14;
    end;

    if (Options.Colors.Gutter <> clNone)
    then
      if isLeftToRight in State
      then Inc(DLeft, Options.Margins.Gutter)
      else Inc(DRight, Options.Margins.Gutter);
  end
  else begin
    DLeft:= 0;
    DRight:= 10;
  end;

  if ((Options = nil)
  or (Options.Colors.LineShadow <> clNone))
  and (Caption[1] <> sEmptySeparator)
  then begin
    if Options = nil
    then Canvas.Pen.Color:= clBtnHighlight
    else Canvas.Pen.Color:= Options.Colors.LineShadow;
    
    DrawSeparatorLine(Rect.Left + DLeft +1, Rect.Right - DRight + DR1, Y +1);
  end;

  if ((Options = nil)
  or (Options.Colors.Line <> clNone))
  and (Caption[1] <> sEmptySeparator)
  then begin
    if isHidden in State
    then begin
      // calculate new color for hidden sep
      OldColor:= ColorToRGB(Options.Colors.Line);
      R:= GetRValue(OldColor);
      G:= GetGValue(OldColor);
      B:= GetBValue(OldColor);
      NewColor:= RGB((R + 255) div 2, (G + 255) div 2, (B + 255) div 2);

      Canvas.Pen.Color:= NewColor;
    end
    else
      if Options = nil
      then Canvas.Pen.Color:= clBtnShadow
      else Canvas.Pen.Color:= Options.Colors.Line;

    DrawSeparatorLine(Rect.Left + DLeft, Rect.Right - DRight, Y);
  end;

  if Length(Caption) > 1
  then begin
    Canvas.Font.Size:= Canvas.Font.Size -1;

    S:= Caption;
    for Y:= 2 to Length(S)
    do
      if Caption[Y] <> Caption[1]
      then begin
        S:= Copy(Caption, Y, MaxInt);
        Break;
      end;

    Inc(Rect.Left, DLeft);
    Dec(Rect.Right, DRight);
    Y:= (Rect.Right - Rect.Left - Canvas.TextWidth(S)) div 2;
    InflateRect(Rect, -Y, 0);

    if (Options = nil)
    or (Options.Colors.LineShadow <> clNone)
    then begin
      Canvas.Brush.Style:= bsSolid;

      if Options = nil
      then Canvas.Font.Color:= clBtnHighlight
      else Canvas.Font.Color:= Options.Colors.LineShadow;

      OffsetRect(Rect, 1, 1);
      DrawText(Canvas.Handle, PChar(S), Length(S), Rect, dt_Center or dt_SingleLine or dt_VCenter);
      OffsetRect(Rect, -1, -1);
    end;

    if (Options = nil)
    or (Options.Colors.Line <> clNone)
    then begin
      Canvas.Brush.Style:= bsClear;

      if Options = nil
      then
        Canvas.Font.Color:= clBtnShadow
      else
        if isHidden in State
        then Canvas.Font.Color:= NewColor
        else Canvas.Font.Color:= Options.Colors.Line;

      DrawText(Canvas.Handle, PChar(S), Length(S), Rect, dt_Center or dt_SingleLine or dt_VCenter);
    end;

    Canvas.Font.Size:= Canvas.Font.Size +1;
  end;

  DrawFrame(Canvas, State, Options, Rect);
end;

const
  Pattern: TBitmap = nil;
  PatternBitmap: TBitmap = nil;

procedure DrawPatternBackground(
  const Canvas: TCanvas;
  const Rect: TRect);
var
  C2, D: Integer;
  R: TRect;
  X, Y: Integer;
begin
  if Pattern = nil
  then begin
    // test display's device capabilities
    if GetDeviceCaps(Desktop.Handle, BitsPixel) > 8
    then C2:= clBtnFace
    else C2:= clBtnHighlight;

    // show pattern background if bits per pixel > 8
    Pattern:= TBitmap.Create;
    Pattern.Width:= 8;
    Pattern.Height:= 8;
    for Y:= 0 to 7 do
      for X:= 0 to 7 do
        if (Y mod 2) = (X mod 2)
        then Pattern.Canvas.Pixels[X, Y]:= clBtnHighlight
        else Pattern.Canvas.Pixels[X, Y]:= C2;

    PatternBitmap:= TBitmap.Create;
    PatternBitmap.Canvas.Brush.Bitmap:= Pattern;
  end;

  D:= Rect.Top mod 2;
  R:= Classes.Rect(0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top + D);

  if (PatternBitmap.Width < R.Right)
  or (PatternBitmap.Height < R.Bottom)
  then begin
    if PatternBitmap.Width < R.Right
    then PatternBitmap.Width:= R.Right;

    if PatternBitmap.Height < R.Bottom
    then PatternBitmap.Height:= R.Bottom;

    PatternBitmap.Canvas.FillRect(R);
  end;

  BitBlt(Canvas.Handle, Rect.Left, Rect.Top, R.Right, R.Bottom - D, PatternBitmap.Canvas.Handle, 0, D, SrcCopy);
end;

procedure DrawSolidBackground(
  const Canvas: TCanvas;
  const Rect: TRect;
  const Color: TColor);
begin
  // set brush style
  if Canvas.Brush.Style <> bsSolid
  then Canvas.Brush.Style:= bsSolid;

  // erase bitmap
  if Canvas.Brush.Bitmap <> nil
  then Canvas.Brush.Bitmap:= nil;

  // set canvas color
  if Canvas.Brush.Color <> Color
  then Canvas.Brush.Color:= Color;

  // fill
  Canvas.FillRect(Rect);
end;

procedure DrawGutter(
  const Canvas: TCanvas;
  const State: T_Am2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect;
  var RG: TRect);
begin
  FillChar(RG, SizeOf(TRect), 0);

  if (not Options.HasColors)
  or (Options.Colors.Gutter = clNone)
  or (Options.HasMargins
  and ((Options.Margins.Gutter = 0)
  or (Options.Margins.Left < Options.Margins.Gutter)))
  then Exit;

  RG:= Rect;

  if isLeftToRight in State
  then Dec(RG.Left, Options.Margins.Border)
  else RG.Left:= RG.Right - Options.Margins.Gutter + Options.Margins.Border;

  RG.Right:= RG.Left + Options.Margins.Gutter;

  DrawSolidBackground(Canvas, RG, Options.Colors.Gutter);
end;

procedure DrawBitmapBackground(
  const Canvas: TCanvas;
  const nobmp: Boolean;
  const ARect: TRect;
  var bmprect, markrect: TRect;
  const Options: T_AM2000_MenuOptions;
  const State: T_AM2000_ItemState);
var
  c: TColor;
  disablednohigh: Boolean;
begin
  disablednohigh:= (nobmp and not (isChecked in State))
    or ((isDisabled in State) and (Options <> nil) and (mfNoHighDisabled in Options.Flags));

  // calculate bmprect and markrect
  bmprect:= ARect;   Dec(BmpRect.Right);
  markrect:= BmpRect;

  if (Options <> nil)
  and (mfShowCheckMark in Options.Flags)
  then begin
    markrect.Right:= (markrect.Right + markrect.Left) div 2;
    bmprect.Left:= markrect.Right;
  end;

  if (nobmp and (not (isChecked in State)))
  or (Options = nil)
  or (mfXpControls in Options.Flags)
  or (Options.HasSkin
  and ((isPressed in State) and not Options.Skin.ItemBackgroundPressed.Empty)
  or ((isHidden in State) and not Options.Skin.ItemBackgroundSunken.Empty))
  then Exit;

  if (mfNoBitmapRect in Options.Flags)
  and (isSelected in State)
  then c:= Options.Colors.Highlight
  else
  if Options.Colors.Gutter <> clNone
  then c:= Options.Colors.Gutter
  else c:= Options.Colors.Menu;

  if (Canvas.Brush.Color <> c)
  then Canvas.Brush.Color:= c;

  if Canvas.Brush.Style <> bsSolid
  then Canvas.Brush.Style:= bsSolid;

  // draw solid background
  if (isSelected in State)
  and (not disablednohigh)
  and (not (isGraphBack in State))
  then begin
    if (not nobmp)
    and (isCtl3d in State)
    then
      if (isHidden in State)
      then DrawPatternBackground(Canvas, BmpRect)
      else Canvas.FillRect(BmpRect);

    if (isChecked in State)
    then Canvas.FillRect(markrect);
  end;

  // draw background and rect
  if (isSelected in State)
  and (isCtl3d in State)
  and ((Options = nil) or not (mfNoBitmapRect in Options.Flags))
  then begin
    if not (nobmp or disablednohigh)
    then DrawEdge(Canvas.Handle, bmprect, bdr_RaisedInner, bf_Rect);

    if (isChecked in State)
    then DrawEdge(Canvas.Handle, markrect, bdr_SunkenOuter, bf_Rect);
  end

  else
  if (isChecked in State)
  and not (nobmp and (Options <> nil) and (mfNoBitmapRect in Options.Flags))
  then
    if Options.HasSkin
    and not Options.Skin.ItemBackgroundPressed.Empty
    then
      with Options.Skin
      do PaintItemBackground(Canvas, [isPressed], MarkRect)

    else begin
      if Options.Colors.Sunken <> clNone
      then DrawSolidBackground(Canvas, markrect, Options.Colors.Sunken)
      else DrawPatternBackground(Canvas, markrect);

      DrawEdge(Canvas.Handle, markrect, bdr_SunkenOuter, bf_Rect);
    end;
end;

procedure GetBitmapParams(
  const Options: T_AM2000_MenuOptions;
  const State: T_AM2000_ItemState;
  const bmpRect: TRect;
  const bmpWidth, bmpHeight: Integer;
  var bmpLeft, bmpTop, tbParams: Integer;
  var C1, C2, C3: TColor);
begin
  tbParams:= 0;

  if Options = nil
  then begin
    C1:= clBtnShadow;
    C2:= clBtnHighlight;
    C3:= clBtnShadow;

  end
  else begin
    if (mfShowCheckMark in Options.Flags)
    then tbParams:= tbParams or dbShowCheckMark;

    if (mfSoftColors in Options.Flags)
    or (mfXpControls in Options.Flags)
    then tbParams:= tbParams or dbSoftColors;

    if (mfNewCheckMarks in Options.Flags)
    then tbParams:= tbParams or dbNewCheckMarks;

    if (mfRaiseBitmaps in Options.Flags)
    and (isSelected in State)
    then tbParams:= tbParams or dbRaiseBitmap;

    if (mfLightenBitmaps in Options.Flags)
    and not (isSelected in State)
    then tbParams:= tbParams or dbLightBitmap;

    if (mfBitmapShadow in Options.Flags)
    then tbParams:= tbParams or dbBitmapShadow;

    C1:= Options.Colors.DisabledText;
    C2:= Options.Colors.DisabledShadow;
    C3:= Options.Colors.BitmapShadow;

  end;

  bmpTop:= (bmprect.Top + bmprect.Bottom - bmpHeight) div 2;
  bmpLeft:= (bmprect.Left + bmprect.Right - bmpWidth) div 2 -1;
end;

procedure DrawCheckMark(
  const Canvas: TCanvas;
  const Bitmap2: HBitmap;
  const State: T_AM2000_ItemState;
  const C1, C2: TColor;
  const Options: T_AM2000_Options;
  const BmpTop: Integer;
  const MarkRect: TRect;
  const nobmp: Boolean;
  const DrawParams: Integer);
var
  R: TRect;
  BmpLeft: Integer;

  procedure DrawEmptyCircle;
  begin
    Canvas.Pen.Color:= Options.Colors.DisabledText;
    Canvas.Brush.Color:= Options.Colors.Menu;

    Canvas.PolyGon([Point(BmpLeft +6, BmpTop +2),
      Point(BmpLeft +9, BmpTop +2),
      Point(BmpLeft +10, BmpTop +3),
      Point(BmpLeft +11, BmpTop +3),
      Point(BmpLeft +12, BmpTop +4),
      Point(BmpLeft +12, BmpTop +5),
      Point(BmpLeft +13, BmpTop +6),
      Point(BmpLeft +13, BmpTop +9),
      Point(BmpLeft +12, BmpTop +10),
      Point(BmpLeft +12, BmpTop +11),
      Point(BmpLeft +11, BmpTop +12),
      Point(BmpLeft +10, BmpTop +12),
      Point(BmpLeft +9, BmpTop +13),
      Point(BmpLeft +6, BmpTop +13),
      Point(BmpLeft +5, BmpTop +12),
      Point(BmpLeft +4, BmpTop +12),
      Point(BmpLeft +3, BmpTop +11),
      Point(BmpLeft +3, BmpTop +10),
      Point(BmpLeft +2, BmpTop +9),
      Point(BmpLeft +2, BmpTop +6),
      Point(BmpLeft +3, BmpTop +5),
      Point(BmpLeft +3, BmpTop +4),
      Point(BmpLeft +4, BmpTop +3),
      Point(BmpLeft +5, BmpTop +3)]);
  end;

begin
  if (not ((isChecked in State) or (isRadio in State) or (isCheckable in State)))
  or ((not nobmp)
  and (dbShowCheckMark and DrawParams = 0))
  then Exit;

  with Canvas
  do begin
    BmpLeft:= MarkRect.Left +1;

    if dbSoftColors and DrawParams <> 0
    then begin
      R:= MarkRect;
      Inc(R.Left, Options.Margins.Border);
      Inc(R.Top, 1);
      Dec(R.Bottom, 1);
      R.Right:= R.Left + R.Bottom - R.Top;

      BmpLeft:= (R.Right + R.Left) div 2 - 8;
    end;

    if Options.HasSkin
    and (((isRadio in State) and (not Options.Skin.Radio.Empty))
    or ((not (isRadio in State)) and (not Options.Skin.CheckMark.Empty)))
    then
      with Options.Skin
      do
        if isRadio in State
        then PaintBitmap(Canvas, Radio, State, MarkRect)
        else PaintBitmap(Canvas, CheckMark, State, MarkRect)

    else
    if (isChecked in State)
    then begin
      if dbSoftColors and DrawParams <> 0
      then begin
        if isSelected in State
        then Brush.Color:= Options.Colors.CheckMarkHigh
        else Brush.Color:= Options.Colors.CheckMark;

        FillRect(R);

        Brush.Color:= Options.Colors.Frame;
        FrameRect(R);
      end;

      if (dbNewCheckmarks and DrawParams <> 0)
      then
        if (isRadio in State)
        then begin // draw checked radio button
          DrawEmptyCircle;

          Pen.Color:= Options.Colors.MenuText;
          Brush.Color:= Options.Colors.MenuText;

          Ellipse(BmpLeft +5, BmpTop +5, BmpLeft +11, BmpTop +11);
        end
        else begin // draw check mark
          Pen.Color:= Options.Colors.MenuText;

          PolyGon([Point(BmpLeft +11, BmpTop +6),
            Point(BmpLeft +7, BmpTop +10),
            Point(BmpLeft +5, BmpTop +8),
            Point(BmpLeft +5, BmpTop +9),
            Point(BmpLeft +7, BmpTop +11),
            Point(BmpLeft +11, BmpTop +7)]);
        end

      else
        if (isDisabled in State)
        then NewDisabledBlt(Canvas, BmpLeft, BmpTop, 1, 1, Bitmap2, C1, C2, clNone)
        else TransBlt(Canvas, BmpLeft, BmpTop, 1, 1, Bitmap2, clNone, clNone, 0);

    end
    else
    if (isRadio in State)
    and (dbNewCheckmarks and DrawParams <> 0)
    then
      DrawEmptyCircle;
  end;
end;

procedure DrawBitmapHandle(
  const Canvas: TCanvas;
  const Bitmap: HBitmap;
  const NumGlyphs: Integer;
  const Bitmap2: HBitmap;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);
var
  bmprect, markrect: TRect;
  nobmp: Boolean;
  DrawParams: Integer;
  Glyph, bmpTop, bmpLeft: Integer;
  C1, C2, C3: TColor;
  BmpInfo: Windows.TBitmap;
begin
  nobmp:= (Bitmap = 0);

  // select bitmap icon
  if (NumGlyphs > 1) and (isDisabled in State)
  then
    Glyph:= 1
  else
  if (NumGlyphs > 2)
  and ((isChecked in State) or (isPressed in State))
  then
    Glyph:= 2
  else
  if (NumGlyphs > 3) and (isSelected in State)
  then
    Glyph:= 3
  else
    Glyph:= 0;

  // getting bitmap info
  BmpInfo.bmHeight:= 16;
  BmpInfo.bmWidth:= 16;

  if Bitmap <> 0
  then GetObject(Bitmap, SizeOf(BmpInfo), @BmpInfo);
  
  if NumGlyphs > 1
  then BmpInfo.bmWidth:= BmpInfo.bmWidth div NumGlyphs;

  // draw bitmap background
  DrawBitmapBackground(Canvas, nobmp, Rect, bmprect, markrect, Options, State);

  // initialize
  GetBitmapParams(Options, State,
    bmpRect, BmpInfo.bmWidth, BmpInfo.bmHeight, bmpLeft, bmpTop,
    DrawParams, C1, C2, C3);

  // draw bitmaps
  if (not nobmp)
  and ((not (isDisabled in State)) or (NumGlyphs > 1))
  then TransBlt(Canvas, bmpLeft, bmpTop, Glyph, NumGlyphs, Bitmap, clNone, C3, DrawParams)
  else NewDisabledBlt(Canvas, bmpLeft, bmpTop, Glyph, NumGlyphs, Bitmap, C1, C2, clNone);

  // draw mark
  DrawCheckMark(Canvas, Bitmap2, State, C1, C2, Options, bmpTop, MarkRect, nobmp, DrawParams);
end;

procedure DrawBitmapImageList(
  const Canvas: TCanvas;
  const BitmapIndex: Integer;
  const Images: TCustomImageList;
  const Bitmap2: HBitmap;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);
var
  bmprect, markrect: TRect;
  nobmp: Boolean;
  DrawParams: Integer;
  bmpTop, bmpLeft: Integer;
  C1, C2, C3: TColor;
begin
  nobmp:= (BitmapIndex = -1);

  // draw bitmap background
  DrawBitmapBackground(Canvas, nobmp, rect, bmprect, markrect, Options, State);

  // initialize
  GetBitmapParams(Options, State, bmpRect,
    TImageList(Images).Width, TImageList(Images).Height, bmpLeft, bmpTop, DrawParams, C1, C2, C3);

  if (not nobmp)
  and (not (isDisabled in State))
  then
    ImgTransBlt(Canvas, bmpLeft, bmpTop, Images.Handle, BitmapIndex,
      TImageList(Images).Width, TImageList(Images).Height, C3, DrawParams)
  else
    ImgDisabledBlt(Canvas, bmpLeft, bmpTop, Images.Handle, BitmapIndex,
      TImageList(Images).Width, TImageList(Images).Height, C1, C2);

  // draw mark
  DrawCheckMark(Canvas, Bitmap2, State, C1, C2, Options, bmpTop, MarkRect, nobmp, DrawParams);
end;

procedure DrawBitmapIndex(
  const Canvas: TCanvas;
  const ImageIndex: Integer;
  const Bitmap2: HBitmap;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);
var
  bmprect, markrect: TRect;
  nobmp: Boolean;
  DrawParams: Integer;
  bmpTop, bmpLeft: Integer;
  C1, C2, C3: TColor;
begin
  nobmp:= (ImageIndex < 0) or (ImageIndex >= MenuItemCache.BitmapCount);

  // draw bitmap background
  DrawBitmapBackground(Canvas, nobmp, rect, bmprect, markrect, Options, State);

  // initialize
  GetBitmapParams(Options, State, bmpRect, 16, 16, bmpLeft, bmpTop, DrawParams, C1, C2, C3);

  if (not nobmp)
  then MenuItemCache.DrawIndex(Canvas, bmpLeft, bmpTop, ImageIndex, C1, C2, C3,
    not (isDisabled in State), DrawParams);

  // draw mark
  DrawCheckMark(Canvas, Bitmap2, State, C1, C2, Options, bmpTop, MarkRect, nobmp, DrawParams);
end;

procedure DrawBitmapCache(
  const Canvas: TCanvas;
  const Caption: String;
  const Bitmap2: HBitmap;
  const State: T_AM2000_ItemState;
  const Options: T_AM2000_MenuOptions;
  const Rect: TRect);
var
  bmprect, markrect: TRect;
  DrawParams: Integer;
  bmpTop, bmpLeft: Integer;
  C1, C2, C3: TColor;
begin
  // draw bitmap background
  DrawBitmapBackground(Canvas, False, rect, bmprect, markrect, Options, State);

  // initialize
  GetBitmapParams(Options, State, bmpRect, 16, 16, bmpLeft, bmpTop, DrawParams, C1, C2, C3);

  // draw bitmaps
  MenuItemCache.Draw(Canvas, bmpLeft, bmpTop, Caption, C1, C2, C3,
    not (isDisabled in State), DrawParams);

  // draw mark
  DrawCheckMark(Canvas, Bitmap2, State, C1, C2, Options, bmpTop, MarkRect, false, DrawParams);
end;



function SetTinyCanvasFont(const Canvas: TCanvas; const Options: T_AM2000_Options): TFont;
begin
  Result:= TFont.Create;
  Result.Assign(Canvas.Font);
  Canvas.Font.Style:= [];
  Canvas.Font.Size:= Canvas.Font.Size -2;

  if Canvas.Font.Color <> Options.Colors.DisabledText
  then Canvas.Font.Color:= Options.Colors.Line;
end;

procedure DrawTextItem;
var
  OldFontStyle: TFontStyles;
  CaptionAlignment, ShortCutAlignment: TAlignment;
  P: Integer;
  Bitmap2: HBitmap;
  noaccel: Boolean;
  R: TRect;
  SaveFont: TFont;
begin
  R:= Params.mir.LineRect;

  // right-to-left support
  if (not (isRightToLeft in State))
  and (not (isRightToLeftNoAlign in State))
  and (not (isRightToLeftReadingOnly in State))
  then Include(State, isLeftToRight);

  // draw the rest of background
  if Options.HasSkin
  and ((isSelected in State) and not Options.Skin.ItemBackgroundHighlight.Empty)
  and ((Bitmap <> 0)
  or (BitmapIndex > -1)
  or (DefaultIndex > -1)
  or (isChecked in State)
  or ((DefaultIndex = -1) and MenuItemCache.IsDefault(Caption) and MenuItemCache[Caption].HasBitmap))
  then
    if (isLeftToRight in State)
    then R.Left:= Params.mir.BitmapRect.Right
    else R.Right:= Params.mir.BitmapRect.Left +1;

  if Caption <> ''
  then DrawBackground(Canvas, State, Options, R);


  // hidden state
  R:= Params.mir.BitmapRect;
  if isHidden in State
  then InflateRect(R, 0, -1);

  // draw bitmap
  if isRadio in State
  then Bitmap2:= bmpRadioItem
  else Bitmap2:= bmpCheckMark;

  if BitmapIndex > -1
  then
    if Bitmaps <> nil
    then
      DrawBitmapImageList(Canvas, BitmapIndex, Bitmaps, Bitmap2, State, Options, R)
    else
    if (isDisabled in State)
    and (Params.DisabledImages <> nil)
    then
      DrawBitmapImageList(Canvas, BitmapIndex, Params.DisabledImages, Bitmap2, State - [isDisabled], Options, R)
    else
    if (isSelected in State)
    and (Params.HotImages <> nil)
    then
      DrawBitmapImageList(Canvas, BitmapIndex, Params.HotImages, Bitmap2, State, Options, R)
    else
      DrawBitmapImageList(Canvas, BitmapIndex, Params.Images, Bitmap2, State, Options, R)

  else
  if DefaultIndex > -1
  then
    DrawBitmapIndex(Canvas, DefaultIndex, Bitmap2, State, Options, R)

  else
  if (DefaultIndex = -1)
  and (Bitmap = 0)
  and MenuItemCache.IsDefault(Caption)
  and MenuItemCache[Caption].HasBitmap
  then
    DrawBitmapCache(Canvas, Caption, Bitmap2, State, Options, R)

  else
    DrawBitmapHandle(Canvas, Bitmap, NumGlyphs, Bitmap2, State, Options, R);

  // draw caption
  OldFontStyle:= Canvas.Font.Style;
  
  if Caption <> ''
  then begin
    noaccel:= not (isShowAccelerators in State);

    if (isDefault in State)
    and not (fsBold in OldFontStyle)
    then Canvas.Font.Style:= Canvas.Font.Style + [fsBold];

    // shortcut's alignment
    if (not (isLeftToRight in State))
    or (mfStandardAlign in Options.Flags)
    then ShortCutAlignment:= taLeftJustify
    else ShortCutAlignment:= taRightJustify;

    if (isLeftToRight in State)
    then
      CaptionAlignment:= Options.Alignment

    else
      if Options.Alignment = taLeftJustify
      then CaptionAlignment:= taRightJustify
      else
      if Options.Alignment = taRightJustify
      then CaptionAlignment:= taLeftJustify
      else CaptionAlignment:= taCenter;

    Canvas.Brush.Style:= bsClear;

    // little interesting thing!
    if (ShortCut = '')
    then begin
      P:= Pos(#9, Caption);

      if bEnableExtendedSymbols
      and (P = 0)
      then P:= Pos(STabulator, Caption);

      if (P <> 0)
      then begin
        if (Caption[P] = #9)
        then Shortcut:= Copy(Caption, P +1, MaxInt)
        else Shortcut:= Copy(Caption, P +2, MaxInt);
        Caption:= Copy(Caption, 1, P -1);
      end;
    end;

    // draw the caption
    if not (isDisabled in State)
    then               // enabled
      if isSelected in State
      then
      if isPressed in State
      then Canvas.Font.Color:= Options.Colors.PressedText
      else Canvas.Font.Color:= Options.Colors.HighlightText
      else
      if isHidden in State
      then Canvas.Font.Color:= Options.Colors.SunkenText
      else Canvas.Font.Color:= Options.Colors.MenuText
    
    else begin         // disabled
      // draw the shadow if not selected
      if (Options.Colors.DisabledShadow <> clNone)
      and ((not (isSelected in State))
      or (mfNoHighDisabled in Options.Flags))
      then begin
        Canvas.Font.Color:= Options.Colors.DisabledShadow;
        Params.mir.IncreaseOffset;

        DrawCaption(Canvas, Caption, State, CaptionAlignment, Params.mir.ItemRect, noaccel);
        if Shortcut <> ''
        then begin
          if mfTinyShortCuts in Options.Flags
          then SaveFont:= SetTinyCanvasFont(Canvas, Options)
          else SaveFont:= nil;

          DrawCaption(Canvas, Shortcut, State, ShortCutAlignment, Params.mir.ShortcutRect, noaccel);

          if SaveFont <> nil
          then begin
            Canvas.Font.Assign(SaveFont);
            SaveFont.Free;
          end;
        end;

        DrawSubmenuTriangle(Canvas, State, Options, Params.mir.TriangleRect);
        Params.mir.DecreaseOffset;
        Canvas.Brush.Style:= bsClear;
      end;

      Canvas.Font.Color:= Options.Colors.DisabledText;
    end;

    // caption, shortcut & triangle
    DrawCaption(Canvas, Caption, State, CaptionAlignment, Params.mir.ItemRect, noaccel);
    if Shortcut <> ''
    then begin
      if mfTinyShortCuts in Options.Flags
      then SaveFont:= SetTinyCanvasFont(Canvas, Options)
      else SaveFont:= nil;

      DrawCaption(Canvas, Shortcut, State, ShortCutAlignment, Params.mir.ShortcutRect, noaccel);

      if SaveFont <> nil
      then begin
        Canvas.Font.Assign(SaveFont);
        SaveFont.Free;
      end;
    end;
    DrawSubmenuTriangle(Canvas, State, Options, Params.mir.TriangleRect);
  end
  else begin
    Canvas.Brush.Style:= bsClear;
  end;

  // framing
  DrawFrame(Canvas, State, Options, Params.mir.LineRect);

  // disabled menu items
  if Canvas.Font.Style <> OldFontStyle
  then Canvas.Font.Style:= OldFontStyle;
end;


{ Main drawing functions }

procedure PaintMenuItemWin32;
var
  Caption: String;
  Bitmap: HBitmap;
  DefaultIndex: Integer;
begin
  DefaultIndex:= -1;
  with Params^
  do begin
    mii.fMask:= $3F or miim_State;
    mii.dwTypeData:= PChar(@Z);
    mii.cch:= SizeOf(Z) -1;
    if not GetMenuItemInfo(Handle, Index, True, mii) then Exit;

    Caption:= StrPas(Z);

    // separator
    if mii.fType and mft_Separator <> 0
    then begin
      DrawSeparator(Canvas, SSeparator, State, PaintOptions, mir.LineRect);
      Exit;
    end;

    // set caption
    if mii.fState and mfs_Checked <> 0
    then Bitmap:= mii.hbmpChecked
    else Bitmap:= mii.hbmpUnchecked;

    // draw item
    if Bitmap = 0 then
      case mii.wID of
        sc_Restore:
          DefaultIndex:= MenuItemCache.GetBitmapIndex(SSystemRestore);
        sc_Move:
          DefaultIndex:= MenuItemCache.GetBitmapIndex(SSystemMove);
        sc_Size:
          DefaultIndex:= MenuItemCache.GetBitmapIndex(SSystemSize);
        sc_Minimize:
          DefaultIndex:= MenuItemCache.GetBitmapIndex(SSystemMinimize);
        sc_Maximize:
          DefaultIndex:= MenuItemCache.GetBitmapIndex(SSystemMaximize);
        sc_Close:
          DefaultIndex:= MenuItemCache.GetBitmapIndex(SSystemClose);
        else
          DefaultIndex:= MenuItemCache.GetBitmapIndex(Caption);
      end;

    SetState(State, isChecked, mii.fState and mfs_Checked <> 0);
    SetState(State, isDisabled, mii.fState and mfs_Disabled <> 0);
    SetState(State, isDefault, mii.fState and mfs_Default <> 0);
    SetState(State, isRadio, mii.fType and mft_RadioCheck <> 0);
    SetState(State, isSubmenu, mii.hSubmenu <> 0);

    DrawTextItem(Canvas, PaintOptions, Caption, '', Bitmap, -1, nil, DefaultIndex, 0, State, MouseState, Params);
  end;
end;

procedure PaintAction;
begin
end;

procedure PaintMenuItem;
var
  Caption, Shortcut: String;
  Bitmap: HBitmap;
  Item2000: TMenuItem2000;
  BitmapIndex, DefaultIndex: Integer;
  NumGlyphs: Integer;
  DefaultDraw: Boolean;
  Bitmaps: TCustomImageList;

{$IFNDEF Delphi4OrHigher}
  ODS: T_AM2000_OwnerDrawState;
{$ELSE}
  ODS: TOwnerDrawState;
{$ENDIF}
begin
  Bitmap:= 0;
  Bitmaps:= nil;
  BitmapIndex:= -1;
  DefaultIndex:= -1;
  with Params^
  do begin
    if (isFramed in Params.State)
    and (ActiveDragWindow <> nil)
    then begin
      ActiveDragWindow.PaintFramedItem(Canvas, mir.LineRect, PaintOptions.Colors.Menu);
      Exit;
    end;

    Item2000:= TMenuItem2000(Item);

    // block update
    if Item is TMenuItem2000
    then Item2000.BeginUpdate;

    if Item is TMenuItem2000
    then Caption:= Item2000.Caption
    else Caption:= Item.Caption;

    DefaultDraw:= not(
{$IFNDEF Delphi4OrHigher}
      (Item is TMenuItem2000) and
{$ENDIF}
      (Assigned(Item2000.OnDrawItem) or Assigned(Item2000.OnAdvancedDrawItem)));


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
    and (not DefaultDraw)
    then begin
      Item2000.OnDrawItem(Item, Canvas, mir.LineRect, isSelected in State);
      Exit;
    end;

    // advanced draw item
    if
{$IFNDEF Delphi4OrHigher}
      (Item is TMenuItem2000) and
{$ENDIF}
    Assigned(Item2000.OnAdvancedDrawItem)
    and (not DefaultDraw)
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
      Exit;
    end;


    // separator
    if IsSeparatorItem(Item)
    then begin
      DrawSeparator(Canvas, Caption, State, PaintOptions, mir.LineRect);
      Exit;
    end;

    // get shortcut
    if Item is TMenuItem2000
    then ShortCut:= GetMainShortCut(Item2000.ShortCut)
    else Shortcut:= ShortcutToText(Item.ShortCut);

    // get user bitmap
    if Item is TMenuItem2000
    then NumGlyphs:= Item2000.NumGlyphs
    else NumGlyphs:= 0;

    // advanced bitmap
    if (Item is TMenuItem2000)
    and (Item2000.HasBitmap)
    then Bitmap:= Item2000.Bitmap.Handle

    // action image
{$IFDEF Delphi4OrHigher}
    else
    if (Item.Action <> nil)
    and (TAction(Item.Action).ImageIndex <> -1)
    then begin
      BitmapIndex:= TAction(Item.Action).ImageIndex;
      Bitmaps:= TAction(Item.Action).ActionList.Images;
    end
{$ENDIF}

    // ordinal bitmap's ImageIndex
    else
    if
    (Images <> nil) and
    ((Item is TMenuItem2000) and (Item2000.ImageIndex > -1)
{$IFDEF Delphi4OrHigher}
    or (Item.ImageIndex > -1)
{$ENDIF}
    )
    then BitmapIndex:= Item2000.ImageIndex

    // no advanced bitmap
    else
{$IFDEF Delphi4OrHigher}
      Bitmap:= Item.Bitmap.Handle;
{$ELSE}
      Bitmap:= 0;
{$ENDIF}

    // set default index
    if Item is TMenuItem2000
    then begin
      DefaultIndex:= Item2000.DefaultIndex;
      SetState(State, isChecked, Item2000.Checked);
      SetState(State, isCheckable, Item2000.AutoCheck);
    end
    else begin
      SetState(State, isChecked, Item.Checked);
{$IFDEF Delphi6OrHigher}
      SetState(State, isCheckable, Item.AutoCheck);
{$ENDIF}
    end;


    // initiate action
{$IFDEF Delphi4OrHigher}
    if not (csDesigning in Item.ComponentState)
    then Item.InitiateAction;
{$ENDIF}

    SetState(State, isDisabled, not IsEnabled(Item));
    SetState(State, isDefault, Item.Default);
    SetState(State, isRadio, Item.RadioItem);
    SetState(State, isSubmenu, HasSubmenu(Item));
    DrawTextItem(Canvas, PaintOptions, Caption, Shortcut,
      Bitmap, BitmapIndex, Bitmaps, DefaultIndex,
      NumGlyphs, State, MouseState,
      Params);

    // unlock updates
    if Item is TMenuItem2000
    then Item2000.EndUpdate;
  end;
end;


{ TMenuItem2000 }

constructor TMenuItem2000.Create(AOwner: TComponent);
begin
  inherited;

{$IFNDEF Delphi4OrHigher}
  FImageIndex:= -1;
{$ENDIF}

  FDefaultBitmapIndex:= -1;
  FNumGlyphs:= 1;
  FDemotable:= True;
end;

destructor TMenuItem2000.Destroy;
var
  OldParent: TMenuItem2000;
begin
  if (not (csLoading in ComponentState))
  and (not (csDestroying in ComponentState))
  then OldParent:= Parent
  else OldParent:= nil;

{$IFNDEF Delphi4OrHigher}
  FBitmap.Free;
{$ENDIF}

  FOptions.Free;
  FControlOptions.Free;

  if FAnimatedSkin <> nil
  then begin
    FAnimatedSkin.Remove(Self);
    FAnimatedSkin:= nil;
  end;
  
  inherited;

  // update parent
  if (OldParent <> nil)
  and (OldParent is TMenuItem2000)
  then OldParent.Update(upForceRebuild);
end;

procedure TMenuItem2000.Insert(Index: Integer; Item: TMenuItem2000);
begin
  inherited Insert(Index, Item);
  Update(upForceRebuild);
end;

function TMenuItem2000.IndexOf(Item: TMenuItem2000): Integer;
begin
  Result:= inherited IndexOf(Item);
end;

procedure TMenuItem2000.Add(Item: TMenuItem2000);
begin
  inherited Add(Item);
  Update(upForceRebuild);
end;

procedure TMenuItem2000.Remove(Item: TMenuItem2000);
begin
  inherited Remove(Item);
  Update(upForceRebuild);
end;

procedure TMenuItem2000.Delete(Index: Integer);
begin
  inherited Delete(Index);
  Update(upForceRebuild);
end;

procedure TMenuItem2000.Assign(Source: TPersistent);
var
  S1: TMenuItem;
  S, MI: TMenuItem2000;
  I: Integer;
begin
  if Source is TMenuItem2000
  then begin
    S:= TMenuItem2000(Source);

    Caption:= S.Caption;
    Enabled:= S.Enabled;
    Default:= S.Default;
    Checked:= S.Checked;
    Control:= S.Control;

    if S.HasControl
    then ControlOptions.Assign(S.ControlOptions);

    Demotable:= S.Demotable;
    Hidden:= S.Hidden;
    PopupMenu:= S.PopupMenu;
    Visible:= S.Visible;
    DefaultIndex:= S.DefaultIndex;
    AttachMenu:= S.AttachMenu;
    SubMenuImages:= S.SubMenuImages;

    if S.HasOptions
    then Options:= S.Options;

    Hint:= S.Hint;
    ShortCut:= S.ShortCut;
    NumGlyphs:= S.NumGlyphs;
    ImageIndex:= S.ImageIndex;
    OnBeforeDrawItem:= S.OnBeforeDrawItem;
    OnMouseDown:= S.OnMouseDown;
    OnMouseUp:= S.OnMouseUp;
    OnMouseMove:= S.OnMouseMove;
    OnClick:= S.OnClick;
    OnEnter:= S.OnEnter;
    OnExit:= S.OnExit;
    OnStartDrag:= S.OnStartDrag;
    OnEndDrag:= S.OnEndDrag;

    OnDrawItem:= S.OnDrawItem;
    OnMeasureItem:= S.OnMeasureItem;
    OnAdvancedDrawItem:= S.OnAdvancedDrawItem;
    OnBeforeDrawItem:= S.OnBeforeDrawItem;
    Bitmap.Assign(S.Bitmap);

    OriginalItem:= S.OriginalItem;
    if OriginalItem = nil then OriginalItem:= S;

{$IFDEF Delphi4OrHigher}
    Action:= S.Action;
{$ENDIF}

    for I:= 0 to S.Count -1
    do begin
      MI:= TMenuItem2000.Create(Owner);
      Add(MI);
      MI.Assign(S[I]);
    end;
  end

  else
  if Source is TMenuItem
  then begin
    S1:= TMenuItem(Source);

    Caption:= S1.Caption;
    Enabled:= S1.Enabled;
    Default:= S1.Default;
    Checked:= S1.Checked;
    Visible:= S1.Visible;
    Hint:= S1.Hint;
    ShortCut:= ShortCutToText(S1.ShortCut);
    OnClick:= S1.OnClick;

{$IFDEF Delphi4OrHigher}
    Bitmap.Assign(S1.Bitmap);
    Action:= S1.Action;
    ImageIndex:= S1.ImageIndex;
    OnDrawItem:= S1.OnDrawItem;
    OnMeasureItem:= S1.OnMeasureItem;
{$ENDIF}

{$IFDEF Delphi5OrHigher}
    OnAdvancedDrawItem:= S1.OnAdvancedDrawItem;
    SubMenuImages:= S1.SubMenuImages;
{$ENDIF}

    for I:= 0 to S1.Count -1
    do begin
      MI:= TMenuItem2000.Create(Owner);
      Add(MI);
      MI.Assign(S1[I]);
    end;
  end

  else
    inherited;
end;

function TMenuItem2000.GetMenuBar: TWinControl;
  // is top level menu item from ActiveMenuBar?
var
  M: TMenu;
begin
  M:= GetMenu;
  Result:= GetMenuBarFromMenu(M);
end;

function TMenuItem2000.GetMenu: TMenu;
var
  M: TMenuItem;
begin
  M:= Self;
  while M.Parent <> nil do M:= M.Parent;
  Result:= TMenu(M.Owner);
end;

{$IFDEF Delphi4OrHigher}
function TMenuItem2000.GetParentMenu: TMenu;
begin
  Result:= GetMenu;
end;
{$ENDIF}

{$IFDEF Delphi3OrHigher}
function TMenuItem2000.GetParentComponent: TComponent;
begin
  Result:= GetMenu;
  if Result = nil then Result:= Parent;
end;
{$ENDIF}

function TMenuItem2000.HasBitmap: Boolean;
  // checks if menu item has any bitmap anywhere
begin
  Result:=
{$IFDEF Delphi4OrHigher}
    (not Bitmap.Empty);
{$ELSE}
    (Assigned(FBitmap) and (not FBitmap.Empty));
{$ENDIF}
end;

function TMenuItem2000.GetParent: TMenuItem2000;
begin
  Result:= TMenuItem2000(inherited Parent);
end;

function TMenuItem2000.IsHintStored: Boolean;
begin
  Result:=
    not (MenuItemCache.IsDefault(Caption)
    and (Hint = MenuItemCache[Caption].Hint));
end;

function TMenuItem2000.IsShortCutStored: Boolean;
begin
  Result:=
    not (MenuItemCache.IsDefault(Caption)
    and (FShortCut = MenuItemCache[Caption].ShortCuts));
end;

function TMenuItem2000.GetBitmap: TBitmap;
begin
{$IFDEF Delphi4OrHigher}
  Result:= inherited Bitmap;
{$ELSE}
  if FBitmap = nil then FBitmap:= TBitmap.Create;
  Result:= FBitmap;
{$ENDIF}
end;

function TMenuItem2000.GetShortCut: T_AM2000_ShortCut;
begin
  Result:= '';

  // inherited shortcut
  if inherited ShortCut <> 0
  then
    Result:= ShortCutToText(inherited ShortCut)
    
  else begin
    Result:= FShortCut;

    if not (csWriting in ComponentState) then begin
      if (Result = '')
      and MenuItemCache.IsDefault(Caption)
      then Result:= MenuItemCache[Caption].ShortCuts;
      
      if (Result = #1) then Result:= '';
    end;
  end;
end;

function TMenuItem2000.GetHint: String;
begin
  Result:= inherited Hint;

  if not (csWriting in ComponentState) then begin
    if (Result = '')
    and MenuItemCache.IsDefault(Caption)
    then Result:= MenuItemCache[Caption].Hint;
    
    if (Result = #1) then Result:= '';
  end;
end;

procedure TMenuItem2000.SetBitmap(Value: TBitmap);
begin
{$IFDEF Delphi4OrHigher}
  inherited Bitmap:= Value;
{$ELSE}
  if FBitmap = nil then FBitmap := TBitmap.Create;
  FBitmap.Assign(Value);
{$ENDIF}

  // update
  Update(upRepaint);
end;

procedure TMenuItem2000.TurnSiblingsOff;
var
  I: Integer;
begin
  if Parent = nil then Exit;
  
  LockGlobalRepaint;
  for I:= 0 to Parent.Count -1 do
    if (Parent.Items[I] <> Self)
    and (Parent.Items[I].GroupIndex = GroupIndex)
    then
      with Parent.Items[I]
      do begin
        case Control of
          ctlNone:        Checked:= False;
          ctlButton:      AsButton.Down:= False;
          ctlButtonArray: AsButtonArray.ItemIndex:= -1;
        end;

        Update(upDoNothing);
      end;
  UnLockGlobalRepaint;
end;

procedure TMenuItem2000.SetHint(Value: String);
begin
  if (Value = '')
  and MenuItemCache.IsDefault(Caption)
  then inherited Hint:= #1
  else inherited Hint:= Value;
end;

procedure TMenuItem2000.SetShortCut(Value: T_AM2000_ShortCut);
var
  I: Integer;
  S, S1: String;
  SC: TShortCut;
begin
  inherited ShortCut:= 0;

  // if shortcut is empty
  if (Value = '') or (Value = #1)
  then FShortCut:= #1

  else
  // supress checking when loading
  if csLoading in ComponentState
  then begin
    FShortCut:= Value;
  end

  // shortcut checking
  else begin
    S:= '';
    while Value <> '' do begin
      I:= Pos(SShortcutDivider, Value);
      if I < 1 then I:= Length(Value) +1;
      S1:= Trim(Copy(Value, 1, I -1));
      System.Delete(Value, 1, I);

      if S1 = '' then System.Break;

      SC:= TextToShortCut(S1);
      if SC = 0
      then raise Exception.Create(SInvalidShortCut + S1 +'''');

      if S <> '' then AppendStr(S, SShortcutDivider);
      AppendStr(S, ShortCutToText(SC));
    end;
    FShortCut:= S;
  end;

  Update(upForceRebuild);
end;

function TMenuItem2000.AsButtonArray: T_AM2000_ButtonArrayControl;
begin
  if FControl = ctlButtonArray
  then Result:= FControlOptions as T_AM2000_ButtonArrayControl
  else raise EMenuError.Create(Name + SThisIsNotAButtonArray);
end;

function TMenuItem2000.AsButton: T_AM2000_ButtonControl;
begin
  if FControl = ctlButton
  then Result:= FControlOptions as T_AM2000_ButtonControl
  else raise EMenuError.Create(Name + SThisIsNotAButton);
end;

function TMenuItem2000.AsBitmap: T_AM2000_BitmapControl;
begin
  if FControl = ctlBitmap
  then Result:= FControlOptions as T_AM2000_BitmapControl
  else raise EMenuError.Create(Name + SThisIsNotABitmap);
end;

function TMenuItem2000.AsEdit: T_AM2000_EditControl;
begin
  if FControl = ctlEditbox
  then Result:= FControlOptions as T_AM2000_EditControl
  else raise EMenuError.Create(Name + SThisIsNotAEdit);
end;

function TMenuItem2000.AsText: T_AM2000_TextControl;
begin
  if FControl = ctlText
  then Result:= FControlOptions as T_AM2000_TextControl
  else raise EMenuError.Create(Name + SThisIsNotAText);
end;


function TMenuItem2000.GetItem(Index: Integer): TMenuItem2000;
var
  R: TMenuItem;
begin
  R:= inherited GetItem(Index);

  if Assigned(R)
  then Result:= TMenuItem2000(R)
  else raise EMenuError.Create(SMenuNotFound);
end;

procedure TMenuItem2000.SetCaption(const Value: String);
begin
  inherited Caption:= Value;
  Update(upForceRebuild);
end;

procedure TMenuItem2000.SetEnabled(Value: Boolean);
begin
  inherited Enabled:= Value;
  Update(upForceRebuild);
end;

procedure TMenuItem2000.SetVisible(Value: Boolean);
begin
  inherited Visible:= Value;
  Update(upForceRebuild);
end;

procedure TMenuItem2000.SetControl(Value: T_AM2000_MenuControlType);
begin
  if FControl <> Value
  then begin
    FControl:= Value;

    if FControlOptions <> nil
    then FControlOptions.Release;

    case FControl of
      ctlButton:
        FControlOptions:= T_AM2000_ButtonControl.Create(Self);
      ctlButtonArray:
        FControlOptions:= T_AM2000_ButtonArrayControl.Create(Self);
      ctlBitmap:
        FControlOptions:= T_AM2000_BitmapControl.Create(Self);
      ctlEditbox:
        FControlOptions:= T_AM2000_EditControl.Create(Self);
      ctlText:
        FControlOptions:= T_AM2000_TextControl.Create(Self);
      else
        FControlOptions:= T_AM2000_MenuControl.Create(Self);
    end;

    Update(upForceRebuild);
  end;
end;

function TMenuItem2000.IsOptionsStored: Boolean;
begin
  Result:= HasOptions;
end;

function TMenuItem2000.GetOptions: T_AM2000_ItemOptions;
begin
  if FOptions = nil
  then FOptions:= T_AM2000_ItemOptions.Create(Self);

  Result:= FOptions;
end;

procedure TMenuItem2000.SetOptions(Value: T_AM2000_ItemOptions);
begin
  if Value <> nil
  then Options.Assign(Value)
  else begin
    FOptions.Free;
    FOptions:= nil;
  end;
end;

function TMenuItem2000.GetCaption: String;
begin
  Result:= inherited Caption;
end;

function TMenuItem2000.GetEnabled: Boolean;
begin
  Result:= inherited Enabled;
end;

function TMenuItem2000.GetVisible: Boolean;
begin
  Result:= inherited Visible;
end;

function TMenuItem2000.GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  Result:= ControlOptions.GetWidth(Canvas, Options);
end;

function TMenuItem2000.GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  Result:= ControlOptions.GetHeight(Canvas, Options);
end;

procedure TMenuItem2000.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove
  then begin
    if (AComponent = AttachMenu) then FAttachMenu:= nil;
    if (AComponent = PopupMenu) then FPopupMenu:= nil;
{$IFNDEF Delphi5OrHigher}
    if (AComponent = FSubMenuImages) then FSubMenuImages:= nil;
{$ENDIF}
    if (AComponent = FAnimatedSkin) then SetAnimatedSkin(nil);
  end;
end;

{$IFDEF Delphi4OrHigher}
procedure TMenuItem2000.InitiateAction;
var
  I : Integer;
begin
  inherited;
  for I := 0 to Count - 1
  do
    if IsVisible(Items[I])
    then Items[I].InitiateAction;
end;

function TMenuItem2000.GetAction: TBasicAction;
begin
  Result:= inherited Action;
end;

procedure TMenuItem2000.SetAction(Value: TBasicAction);
  // thanks to Adrienne Wu for the fix to this method
begin
  if (Value <> nil)
  and (Value is TCustomAction)
  and (csDesigning in Value.ComponentState)
  then TCustomAction(Value).DisableIfNoHandler:= False;

  inherited Action:= Value;
  Update(upForceRebuild);
end;
{$ENDIF}

procedure TMenuItem2000.Update(UpdateMenuBar: Integer);
var
  MB: TCustomMenuBar2000;
  M: TMenu;
begin
  if (IsInUpdate)
  or (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  then Exit;

  BeginUpdate;

  if MenuDesigner <> nil
  then MenuDesigner.Perform(wm_Update, 0, LongInt(Self));

  M:= GetMenu;
  MB:= GetMenuBarFromMenu(M);

  // is menu bar item?
  if (MB <> nil)
  and ((Parent = nil)
  or (Parent.Parent = nil))
  then
    SendMessage(MB.Handle, wm_UpdateMenuBar, UpdateMenuBar, 0);

  if UpdateMenuBar = upForceRebuild
  then
    if (MB <> nil)
    and (MB.MenuComponent <> nil)
    then
      MB.MenuComponent.Refresh
    else
      if M is TCustomMainMenu2000
      then TCustomMainMenu2000(M).Refresh
      else
      if M is TCustomPopupMenu2000
      then TCustomPopupMenu2000(M).Refresh;

  EndUpdate;
end;

function TMenuItem2000.GetChecked: Boolean;
begin
  Result:= inherited Checked;
end;

procedure TMenuItem2000.SetChecked(Value: Boolean);
begin
  inherited Checked:= Value;
  Update(upRepaint);
end;

procedure TMenuItem2000.SetDefaultIndex(Value: T_AM2000_DefaultIndex);
begin
  FDefaultBitmapIndex:= Value;
  Update(upRepaint);
end;

procedure TMenuItem2000.SetHidden(Value: Boolean);
begin
  if FHidden = Value then Exit;
  FHidden:= Value;
  Update(upForceRebuild);
end;

function TMenuItem2000.GetImageIndex: T_AM2000_ImageIndex;
begin
{$IFDEF Delphi4OrHigher}
  Result:= inherited ImageIndex;
{$ELSE}
  Result:= FImageIndex;
{$ENDIF}
end;

procedure TMenuItem2000.SetImageIndex(Value: T_AM2000_ImageIndex);
begin
{$IFDEF Delphi4OrHigher}
  inherited ImageIndex:= Value;
{$ELSE}
  FImageIndex:= Value;
{$ENDIF}

  // update
  Update(upRepaint);
end;

function TMenuItem2000.GetMenuHandle: HMenu;
begin
  if FMenuHandle = 0
  then Result:= Handle
  else Result:= FMenuHandle;
end;

procedure TMenuItem2000.SetMenuHandle(const Value: HMenu);
begin
  FMenuHandle:= Value;
end;

{$IFDEF Delphi4orHigher}
function TMenuItem2000.GetActionLinkClass: TMenuActionLinkClass;
begin
  Result:= T_AM2000_MenuActionLink;
end;
{$ENDIF}

procedure TMenuItem2000.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TMenuItem2000.EndUpdate;
begin
  Dec(FUpdateCount);
end;

function TMenuItem2000.GetControlOptions: T_AM2000_MenuControl;
begin
  if FControlOptions = nil
  then FControlOptions:= T_AM2000_MenuControl.Create(Self);

  Result:= FControlOptions;
end;

procedure TMenuItem2000.SetControlOptions(Value: T_AM2000_MenuControl);
begin
  ControlOptions.Assign(Value);
end;

function TMenuItem2000.HasControl: Boolean;
begin
  Result:= FControl <> ctlNone;
end;

function TMenuItem2000.HasOptions: Boolean;
begin
  Result:= (FOptions <> nil) and (not FOptions.IsDefault);
end;

function TMenuItem2000.GetCount: Integer;
begin
  Result:= inherited GetCount;
end;

function TMenuItem2000.GetHidden: Boolean;
begin
  Result:= FHidden;
end;

procedure TMenuItem2000.UpdateFromOptions;
begin
  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  then Exit;
  Update(upForceRebuild);
end;

procedure TMenuItem2000.Click;
begin
  if FControlOptions <> nil
  then FControlOptions.Click;

  inherited;

{$IFNDEF DesignTime}
  FLastTimeUsed:= iElapsedTime + (GetTickCount - iStartingTime) div 1000;
  SaveMenuItem(Self);
{$ENDIF}
end;

{$IFNDEF Delphi5OrHigher}
procedure TMenuItem2000.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0
  do Items[I].Free;
end;
{$ENDIF}

procedure TMenuItem2000.SetAnimatedSkin(
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


{$IFDEF ACTIVEX}
function TMenuItem2000.Get_Caption: WideString;
begin
  Result:= GetCaption;
end;

procedure TMenuItem2000.Set_Caption(const Value: WideString);
begin
  SetCaption(Value);
end;                     

function TMenuItem2000.Get_Items(Index: Integer): IMenuItem;
begin
  Result:= GetItem(Index) as IMenuItem;
end;

function TMenuItem2000.Get_Count: Integer;
begin
  Result:= Count;
end;

function TMenuItem2000.Get_Checked: WordBool;
begin
  Result:= GetChecked;
end;

function TMenuItem2000.Get_DefaultIndex: Integer;
begin
  Result:= FDefaultBitmapIndex;
end;

function TMenuItem2000.Get_Demotable: WordBool;
begin
  Result:= FDemotable;
end;

function TMenuItem2000.Get_Enabled: WordBool;
begin
  Result:= GetEnabled;
end;

function TMenuItem2000.Get_Hidden: WordBool;
begin
  Result:= GetHidden;
end;

function TMenuItem2000.Get_Hint: WideString;
begin
  Result:= GetHint;
end;

function TMenuItem2000.Get_ImageIndex: Integer;
begin
  Result:= GetImageIndex;
end;

function TMenuItem2000.Get_NumGlyphs: Integer;
begin
  Result:= FNumGlyphs;
end;

function TMenuItem2000.Get_ShortCut: WideString;
begin
  Result:= GetShortCut;
end;

function TMenuItem2000.Get_Visible: WordBool;
begin
  Result:= GetVisible;
end;

function TMenuItem2000.Get_Options: IItemOptions;
begin
  Result:= Options as IItemOptions;
end;

procedure TMenuItem2000.Set_Checked(Value: WordBool);
begin
  SetChecked(Value);
end;

procedure TMenuItem2000.Set_DefaultIndex(Value: Integer);
begin
  SetDefaultIndex(Value);
end;

procedure TMenuItem2000.Set_Demotable(Value: WordBool);
begin
  FDemotable:= Value;
end;

procedure TMenuItem2000.Set_Enabled(Value: WordBool);
begin
  SetEnabled(Value);
end;

procedure TMenuItem2000.Set_Hidden(Value: WordBool);
begin
  SetHidden(Value);
end;

procedure TMenuItem2000.Set_Hint(const Value: WideString);
begin
  SetHint(Value);
end;

procedure TMenuItem2000.Set_ImageIndex(Value: Integer);
begin
  SetImageIndex(Value);
end;

procedure TMenuItem2000.Set_NumGlyphs(Value: Integer);
begin
  FNumGlyphs:= Value;
end;

procedure TMenuItem2000.Set_ShortCut(const Value: WideString);
begin
  SetShortCut(Value);
end;

procedure TMenuItem2000.Set_Visible(Value: WordBool);
begin
  SetVisible(Value);
end;

procedure TMenuItem2000.IMenuItem_Remove;
var
  op: TMenuItem;
begin
  op:= Parent;
  if Parent <> nil
  then Parent.Remove(Self);
end;

function TMenuItem2000.AddNew: IMenuItem;
var
  M1: TMenuItem2000;
begin
  M1:= TMenuItem2000.Create(Owner);
  if MenuIndex = Parent.Count -1
  then Parent.Add(M1)
  else Parent.Insert(MenuIndex +1, M1);

  Result:= M1 as IMenuItem;
end;

function TMenuItem2000.AddNewChild: IMenuItem;
var
  M1: TMenuItem2000;
begin
  M1:= TMenuItem2000.Create(Owner);
  Add(M1);
  Result:= M1 as IMenuItem;
end;

function TMenuItem2000.DispTypeInfo: ITypeInfo;
begin
  if FDispTypeInfo = nil
  then ComServer.TypeLib.GetTypeInfoOfGuid(IMenuItemDisp, FDispTypeInfo);

  Result:= FDispTypeInfo;
end;

function TMenuItem2000.DispIntfEntry: PInterfaceEntry;
begin
  if FDispIntfEntry = nil
  then FDispIntfEntry:= GetInterfaceEntry(IMenuItemDisp);

  Result:= FDispIntfEntry;
end;

function TMenuItem2000.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result:= DispGetIDsOfNames(DispTypeInfo, Names, NameCount, DispIDs);
end;

function TMenuItem2000.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  if Index <> 0
  then begin
    Pointer(TypeInfo):= nil;
    Result:= DISP_E_BADINDEX;
  end
  else begin
    ITypeInfo(TypeInfo):= DispTypeInfo;
    Result:= S_OK;
  end;
end;

function TMenuItem2000.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count:= 1;
  Result:= S_OK;
end;

function TMenuItem2000.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
const
  INVOKE_PROPERTYSET = INVOKE_PROPERTYPUT or INVOKE_PROPERTYPUTREF;
begin
  if Flags and INVOKE_PROPERTYSET <> 0
  then Flags:= INVOKE_PROPERTYSET;

  Result:= DispTypeInfo.Invoke(Pointer(Integer(Self) +
    DispIntfEntry.IOffset), DispID, Flags, TDispParams(Params), VarResult,
    ExcepInfo, ArgErr);
end;
{$ENDIF}


procedure TMenuItem2000.ReleaseHandle;

  procedure RemoveMenuRecursive(const Handle: HMenu);
  var
    I: Integer;
    H: HMenu;
  begin
    I:= GetMenuItemCount(Handle);

    while I > 0
    do begin
      H:= GetSubMenu(Handle, I -1);
      if H <> 0
      then RemoveMenuRecursive(H);

      RemoveMenu(Handle, I -1, MF_BYPOSITION);
      Dec(I);
    end;
  end;

begin
  RemoveMenuRecursive(Handle);
  DestroyMenu(Handle);
  TFalseMenuItem(Self).FHandle:= 0;
end;

procedure TMenuItem2000.SetAttachMenu(const Value: T_AM2000_PopupMenu);
begin
  if FAttachMenu <> nil
  then TCustomPopupMenu2000(FAttachMenu).AttachedTo:= nil;

  FAttachMenu:= Value;

  if FAttachMenu <> nil
  then TCustomPopupMenu2000(FAttachMenu).AttachedTo:= Self;
end;

function TMenuItem2000.IsInUpdate: Boolean;
begin
  Result:= FUpdateCount > 0;
end;


{ TEditableMenuItem2000 }

function TEditableMenuItem2000.GetHandle: HMenu;
begin
  Result:= TMenu(Owner).Items.Handle;
end;

function TEditableMenuItem2000.GetCount: Integer;
begin
  Result:= TMenu(Owner).Items.Count;
end;

function TEditableMenuItem2000.GetItem(Index: Integer): TMenuItem2000;
begin
  // it's safe because Animated Menus don't use TMenuItem,
  // only TMenuItem2000
  Result:= TMenuItem2000(TMenu(Owner).Items[Index]);
end;

procedure TEditableMenuItem2000.Insert(Index: Integer; Item: TMenuItem2000);
begin
  TMenu(Owner).Items.Insert(Index, Item);
end;

procedure TEditableMenuItem2000.Delete(Index: Integer);
begin
  TMenu(Owner).Items.Delete(Index);
end;

function TEditableMenuItem2000.IndexOf(Item: TMenuItem2000): Integer;
begin
  Result:= TMenu(Owner).Items.IndexOf(Item);
end;

procedure TEditableMenuItem2000.Add(Item: TMenuItem2000);
begin
  TMenu(Owner).Items.Add(Item);
end;

procedure TEditableMenuItem2000.Remove(Item: TMenuItem2000);
begin
  TMenu(Owner).Items.Remove(Item);
end;

procedure TEditableMenuItem2000.Clear;
begin
{$IFDEF Delphi5OrHigher}
  TMenu(Owner).Items.Clear;
{$ELSE}
  if Owner is TCustomMainMenu2000
  then TCustomMainMenu2000(Owner).Items2000.Clear
  else TCustomPopupMenu2000(Owner).Items2000.Clear;
{$ENDIF}  
end;


{ T_AM2000_MenuActionLink }

{$IFDEF Delphi4OrHigher}
procedure T_AM2000_MenuActionLink.SetCaption(const Value: string);
begin
  inherited;
  TMenuItem2000(FClient).Update(upForceRebuild);
end;

procedure T_AM2000_MenuActionLink.SetChecked(Value: Boolean);
begin
  inherited;
  if FClient is TMenuItem2000
  then TMenuItem2000(FClient).Update(upForceRebuild);
end;

procedure T_AM2000_MenuActionLink.SetEnabled(Value: Boolean);
begin
  inherited;
  if FClient is TMenuItem2000
  then TMenuItem2000(FClient).Update(upRepaint);
end;

procedure T_AM2000_MenuActionLink.SetHint(const Value: string);
begin
  inherited;
  if FClient is TMenuItem2000
  then TMenuItem2000(FClient).Update(upRebuildToolTips);
end;

procedure T_AM2000_MenuActionLink.SetImageIndex(Value: Integer);
begin
  inherited;
  if FClient is TMenuItem2000
  then TMenuItem2000(FClient).Update(upForceRebuild);
end;

procedure T_AM2000_MenuActionLink.SetVisible(Value: Boolean);
begin
  inherited;
  if FClient is TMenuItem2000
  then TMenuItem2000(FClient).Update(upForceRebuild);
end;
{$ENDIF}


initialization
  RegisterClasses([TMenuItem2000, TEditableMenuItem2000]);

finalization
  Pattern.Free;
  PatternBitmap.Free;
    
end.
