
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Utilities                                       }
{                                                       }
{       Copyright (c) 1997-2002 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000utils;

{$I am2000.inc}

interface

uses
  {$IFDEF ActiveX} AnimatedMenusXP_TLB, ActiveX, ComServ, AxCtrls, {$ENDIF}
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls,
  Forms, Dialogs, Menus, Buttons, CommCtrl, ComCtrls, Registry;

const
  // messages
  wm_ShowAnimated     = wm_User + $102;
  wm_ShowSilent       = wm_User + $103;
  wm_HideAnimated     = wm_User + $104;
  wm_AnimatedHide     = wm_HideAnimated;
  wm_HideSilent       = wm_User + $105;
  wm_SilentHide       = wm_HideSilent; // wParam = 1, hide only submenuforms
  wm_GetForm          = wm_User + $109; // wParam = menu item

  // messages for popup menu form
  wm_KillAnimation    = wm_User + $101;
  wm_KillTimer        = wm_User + $106;
  wm_SetKeepSelected  = wm_User + $112; // wParam -> enable/disable keepselected
  wm_UpdateMenuBar    = wm_User + $107; // wParam <> 0 -> rebound menu bar
  wm_ActivateMenuBar  = wm_User + $108; // wParam <> 0 -> window is active
  wm_SetState         = wm_User + $114;
  wm_GetState         = wm_User + $118;
  wm_PaintOnCanvas    = wm_User + $115; // wParam - DC handle; lParam - pointer to the TWmPaintOnCanvas struct
  wm_SetMenuItem      = wm_User + $116;
  wm_UnHide           = wm_User + $117;

  // messages for menu designer
  wm_Update           = wm_User + $121; // lparam --> menu item to update
  wm_GetPopupMenu     = wm_User + $123;
  wm_RefreshMenu      = wm_User + $126;
  wm_KillMenuBar      = wm_User + $127;
  wm_GetMenuExtent    = wm_User + $129; // future: get form's sizes

{$IFNDEF Delphi3OrHigher}
  WM_MOUSEWHEEL       = $020A;
{$ENDIF}

  // state
  ssAnimation         = 1;
  ssSelection         = 2;
  ssHidden            = 3;
  ssPreview           = 4;
  ssPopulated         = 5;
  ssHotTrack          = 6;
  ssAccel             = 7;
  ssEnabled           = 8;
  ssDesigning         = 9;
  ssFocusItem         = 10;
  ssFraming           = 11;
  ssOleWindow         = 12;
  ssSibling           = 13;
  ssRightToLeft       = 14;
  ssIgnoreMouseUp     = 15;


  // GetItemAt(X,Y)
  itNothing           = -1;
  itDragPane          = -2;
  itHiddenArrow       = -3;

  itScrollFirst       = -10;
  itScrollLast        = -4;
  itScrollUp          = itScrollFirst;
  itScrollDown        = itScrollFirst +1;
  itScrollPageUp      = itScrollFirst +2;
  itScrollPageDown    = itScrollFirst +3;
  itScrollBox         = itScrollFirst +4;
  itTopScroll = itScrollUp;
  itBottomScroll = itScrollDown;

  // transparent bitblt options
  dbSoftColors        = $01;
  dbRaiseBitmap       = $02;
  dbShowCheckMark     = $04;
  dbLightBitmap       = $08;
  dbUseShadowColor    = $10;
  dbNewCheckMarks     = $20;
  dbBitmapShadow      = $40;
  dbEffects = dbRaiseBitmap + dbLightBitmap + dbBitmapShadow;

  // soft color coefficients
  cGutter             = 1.5;
  cMenu               = 15;
  cBorder             = 15;
  cBevel              = 4.5;
  cBevelShadow        = 4.5;
  cLine               = 3.13;
  cLineShadow         = 3.13;
  cHighlight          = 1.4;
  cCheckMark          = 1.8;
  cCheckMarkHigh      = 2;
  cDoubleCheck        = 1.94;
  cBitmapShadow       = 3;
  cSunken             = 1.3;
  cLightBitmap        = 4;

  // sizes
  iHiddenButtonHeight: Integer = 13;
  iDraggablePaneHeight: Integer = 7;
  iSystemIconWidth: Integer = 16;

  // constants for TCustomMenuBar2000.UpdateMenuBar routine
  upDoNothing         = 0;
  upRepaint           = 0;
  upForceRebound      = 1;
  upChildChanged      = 2;
  upForceRebuild      = 3;
  upRebuildToolTips   = 4;

  // vk_Menu key
  AltMask = $20000000;

const
  FormFlags = swp_NoMove or swp_NoSize or swp_NoActivate;
  dt_DrawTextFlags = dt_SingleLine + dt_VCenter;
  nSteps: Integer = 16;  // number of steps in menu animation
  nTimeout: Integer = 10; // cannot be more than 100
  nFirstStage: Integer = 10; // size of first step

  nShowHiddenTimeout: Integer = 2000;
  nPopupSubmenuTimeout: Integer = 250;
  nShortPopupSubmenuTimeout: Integer = 1;
  nScrollingTimeout: Integer = 100;
  nShortScrollingTimeout: Integer = 10;
  nHotTrackTimeout: Integer = 500;
  nDeactivateTimeout: Integer = 500;

  iMaxItemWidth: Integer = 300;
  iSubmenuTriangleWidth: Integer = 20;
  iToolTipWindowWidth: Integer = 300;
  iMaxToolTipShowingTime: Integer = 7000;
  bEnableExtendedSymbols: Boolean = True;
  iScrollBarOffset: Integer = 5;   

  // time out before menu item will be demoted in seconds
  // (6 hours is default)
  iDemotingTimeOut: DWord = 24*60*60;

  iBytesPerPixel = 3;

const  
  miNothingToInsert = Pointer(-1);
  miInsertAtTheEnd = Pointer(-2);

  // windows settings
  SPI_GetMenuAnimation = $1002;
  SPI_GetMenuUnderlines = $100A;
  SPI_GetMenuFade = $1012;
  SPI_GetFlatMenu = $1022;
  SPI_GetDropShadow = $1024;
  SPI_GetSelectionFade = $1014;

  CS_DropShadow = $00020000;
  WS_EX_Layered = $00080000;
  LWA_Alpha = $00000002;

const
  // Custom Sounds - set your favorite
  MenuPopupSound    : String = 'MenuPopup';      // or 'c:\laser.wav'
  MenuCloseSound    : String = '';
  MenuCommandSound  : String = 'MenuCommand';
  // set this param to True to load and play sound from resource
  MenuSoundResource : Boolean = False;

  // current menu that popped up
  ActivePopupMenu   : TPopupMenu = nil;

  // current menu item to move
  ActiveMenuItem    : TMenuItem = nil;
  InsertBeforeItem  : TMenuItem = nil;
  LastInsertBeforeItem: TMenuItem = nil;
  InsertBeforeParent: TMenuItem = nil;

  hUser32: HModule = 0;
  pSetLayeredWindowAttributes: function (Hwnd: THandle; crKey: COLORREF;
    bAlpha: Byte; dwFlags: DWORD): Boolean stdcall = nil;
  pUpdateLayeredWindow: function (Handle: THandle; hdcDest: HDC; pptDst:
    PPoint; _psize: PSize; hdcSrc: HDC; pptSrc: PPoint; crKey: COLORREF;
    pblend: Pointer; dwFlags: DWORD): Boolean stdcall = nil;

type
  T_AM2000_MenuWhereToSave = (msDontSave, msRegistry, msResourceFile, msTextFile, msXmlFile);

  T_AM2000_Opacity = 1..100;

  T_AM2000_OpacityData = array [Byte, Byte] of Byte; // array of bits values of alphaed bits
  P_AM2000_OpacityData = ^T_AM2000_OpacityData;

  PWmPaintOnCanvas = ^TWmPaintOnCanvas;
  TWmPaintOnCanvas = record
    RebuildMenu: Boolean;
    Selected: TMenuItem;
    pFrom, pTo: TPoint;
  end;

  PBlendFunction = ^TBlendFunction;
  TBlendFunction = packed record
    BlendOp: BYTE;
    BlendFlags: BYTE;
    SourceConstantAlpha: BYTE;
    AlphaFormat: BYTE;
  end;

  T_AM2000_Version = type String;

  PRgbTriple = ^TRgbTriple;


{$IFDEF Delphi2}
  TCustomForm = TForm;
{$ENDIF}


const
  mfResource = 1; // menu format
  mfText = 2;
  mfXML = 3;

  sfResource = 1; // skin format
  sfText = 2;
  sfXML = 3;

  // registry key where to keep menu state
  MenuWhereToSave   : T_AM2000_MenuWhereToSave = msDontSave;
  MenuOrderRegistry : String = '\Software\AnimatedMenus.com\AnimatedMenus/2000\MenuOrder\$(APPNAME)';
  MenuDataFile      : String = '$(APPDATA)\$(APPNAME)\$(MENU)';
  iStartingTime     : DWord = 0;
  iElapsedTime      : DWord = 0;

  // global parameters
  EnablePromotion     : Boolean = True;
  EnableDemotion      : Boolean = False;
  EnableCustomization : Boolean = True;

  // list of active menu bars
  ActiveMenuBarList   : TList = nil;

  // save cursor state
  CursorDefault       : TCursor = 0;

  // timer
  TimeoutTimer        : TTimer = nil;

  // repaint lock
  GlobalRepaintLockCount    : Integer = 0;
  GlobalRepaintFlag         : Boolean = False;

const
  // list of menus that float
  FloatingMenusList       : TList            = nil;

  // checkmarks
  bmpCheckMark            : HBitmap          = 0;
  bmpRadioItem            : HBitmap          = 0;
  MenuDesigner            : TControl         = nil;

  // Animated Menus version
  AnimatedMenusVersion = 3.1;
  AnimatedMenusMajorVersion = 3;
  AnimatedMenusMinorVersion = 1;
  AnimatedMenusBuildNumber = 735;
  SVersion = 'Animated Menus 3.1, Build #735';



var
  Z: array [0..256] of Char;
  mii: TMenuItemInfo;
  NonClientMetrics: TNonClientMetrics;



{ other routines }

// menu control routines
procedure HideWindowMenu(Owner: TComponent);
function AssignedActivePopupMenu2000Form: Boolean;
function KillActivePopupMenu2000(KillMenuBar, AnInternalKill: Boolean): Boolean;
procedure SetStatusBarText(HintText: String);

// hooks
procedure InstallWindowsHooks;
procedure RemoveWindowsHooks;
procedure InstallOle2GMHook(hwndActiveObject: HWnd);
procedure RemoveOle2GMHook;
function GetMessageHook(Code, wParam, lParam: Integer): Integer; stdcall;
function GetCBTHook(Code: Integer; wParam: HWND; lParam: LPARAM): LRESULT; stdcall;
function CallWindowHook(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
function GetOle2MessageHook(Code, wParam, lParam: Integer): Integer; stdcall;

// message handling procedures
procedure CheckShowHint(MenuItem: TMenuItem; ShowFloatingHint: Boolean; Form: TForm);
procedure ProcessPaintMessages;
procedure ProcessMouseMoveMessages;
procedure ProcessMessage(const Message1, Message2: UINT);
procedure ProcessMessages;
procedure NewDisabledBlt(const Canvas: TCanvas;
  const X, Y: Integer;
  const Glyph, NumGlyphs: Integer;
  const ABitmap: HBitmap; 
  const clHigh, clShadow: TColor;
  TransparentColor: TColor);
procedure ImgDisabledBlt(const Canvas: TCanvas; const X, Y: Integer; const Images: HImageList;
  const Index, Width, Height: Integer; const clHigh, clShadow: TColor);
procedure ImgTransBlt(const Canvas: TCanvas; const X, Y: Integer; const Images: HImageList;
  const Index, Width, Height: Integer; const clShadow: TColor; const AParams: Integer);
procedure TransBlt(const Canvas: TCanvas;
  X, Y: Integer;
  const Glyph, NumGlyphs: Integer;
  const ABitmap: HBitmap;
  TransparentColor: TColor;
  const clShadow: TColor;
  const AParams: Integer);
procedure PaintMenuIcon(const Owner, AMC: Forms.TForm; const DC: HDC; const X, Y, W: Integer);
procedure FullHideCaret;
procedure FullShowCaret;
function GetMenuFontHandle: HFont;
function GetValidName(Caption: String): String;
//procedure OffsetBitmap(Bitmap: TBitmap; Left, Top, Width, Height: Integer);
function StripAmpersands(S: String): String;
function CreateDibSectionEx(const ADC: HDC; const AWidth, AHeight: Integer; const PBits: Pointer): HBitmap;

// Evaluation Edition routine

// nifty things
function IsAccelEx(VK: Word; const Str: String; UseFirstLetter: Boolean): Boolean;
function IsAccel2(VK: Word; const Str: String): Boolean;
function HasSubmenu(Item: TMenuItem): Boolean;
function HasSubmenuWin32(Handle: HMenu; Index: Integer): Boolean;
function AmpTextWidth(Canvas: TCanvas; S: String): Integer;
function IsShortCutEx(var Msg: TWMKey; Items: TMenuItem; DoAction: Boolean): Boolean;
function GetNumLines(S: String): Integer;  // returns num of lines in the S
procedure ClearBitmap(Bitmap: TBitmap);

procedure CopyToClipboard(S: String);
function PasteFromClipboard: String;

// saves menu state from registry
procedure LoadMenuFromRegistry(const AComponent: TComponent);
procedure SaveMenuToRegistry(const AComponent: TComponent);
procedure LoadMenu(const AComponent: TComponent);
procedure SaveMenu(const AComponent: TComponent);
procedure SaveMenuItem(const Item: TMenuItem);
procedure SaveMenuToFile(const AComponent: TComponent; const Filename: String);
procedure LoadMenuFromFile(const AComponent: TComponent; const Filename: String);
procedure LoadMenuFromFileFormat(const AComponent: TComponent; const Filename: String; const Format: Integer);
procedure SaveMenuToFileFormat(const AComponent: TComponent; const Filename: String; const Format: Integer);
procedure SaveMenuToString(const AComponent: TComponent; var ABuffer: String);
procedure LoadMenuFromString(const AComponent: TComponent; const ABuffer: String);

function IsActive(Control: TWinControl): Boolean;
function IsAvailable(Control: TControl): Boolean;
function IsContained(Handle: THandle; Control: TComponent): Boolean;
function FindItem2000(Form: TForm; Value: Word; FindKing: TFindItemKind): TMenuItem;

procedure SetInsertBeforeItem(const AInsertBeforeItem: TMenuItem);
function IsCustomization(const ACustomizable: Boolean): Boolean;
procedure EndCustomization(AcceptMove: Boolean);
function IsGradientCaptions: Boolean;
function IsOkControl(const C: TControl): Boolean;
function IsOkControlUnderCursor: Boolean;
function IsObjectInspectorUnderCursor: Boolean;
function IsApplicationActive: Boolean;

procedure SetTimer(AInterval: Cardinal; AOnTimer: TNotifyEvent);
procedure StopTimer;
procedure RestartTimer;
function IsTimerSet(AInterval: Cardinal; AOnTimer: TNotifyEvent): Boolean;
procedure FreeMemAndNil(var P);
procedure ReGetMem(var P; const Size: Integer);

procedure BuildOpacityData(const AOpacity: T_AM2000_Opacity;  var AOpacityData: P_AM2000_OpacityData);
procedure ProcessOpacityData(ImageTop, ImageBottom, ImageResult, ImageResultLast: PByteArray;
  const OpacityData: P_AM2000_OpacityData);
function GetSoftColor(C1, C2: TColor; const K: Real): TColor;

procedure LockGlobalRepaint;
procedure UnlockGlobalRepaint;
procedure GlobalRepaint;

function IsSeparatorItem(const Item: TMenuItem): Boolean;
function IsSeparatorCaption(const ACaption: String): Boolean;
function IsEnabled(const Item: TMenuItem): Boolean;
function IsVisible(const Item: TMenuItem): Boolean;
function GetCount(const Item: TMenuItem): Integer;
function GetCaption(const Item: TMenuItem): String;

procedure ObjectBinaryToXml(Input, Output: TStream);
procedure ObjectXmlToBinary(Input, Output: TStream);
procedure InitializePath(var AMenuOrderRegistry, AMenuDataFile: String);

{$IFNDEF Delphi4OrHigher}
type TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);

function StringReplace(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
{$ENDIF}

procedure CopyMenuProperties(const Source, Dest: TMenu);
procedure CopyList(const Source, Dest: TList);

procedure SetCursor(const ACursor: TCursor);
procedure RestoreCursorDefault(const ACursor: TCursor);
function PointInRect(const R: TRect; const P: TPoint): Boolean;

function IsChildMaximizedAndSystemMenu(const F: TCustomForm): Boolean;
function PosShortCut(const SC, SCList: String): Boolean;
procedure ResetUsageData(const Item: TMenuItem; const ABuffer: String);

type
  T_AM2000_PopupMenu = class(TPopupMenu);




implementation

uses
  MmSystem,
  {$IFDEF Delphi3OrHigher}ShlObj,{$ENDIF}
  am2000menubar, am2000popupmenu, am2000mainmenu, am2000hintwindow,
  am2000menuitem, am2000cache, am2000options, am2000dragwindow, am2000desktop;

type
  TRgbTripleArray = array [0..0] of TRgbTriple;
  PRgbTripleArray = ^TRgbTripleArray;

const
  // directions for GetNextToolbarButton2000
  drLeft  = -1;
  drRight = 1;

  vk_0 = Byte('0');
  vk_Z = Byte('Z');

const
  CurCaretIndex : Integer = 0;

  HGetMessageHook         : HHook            = 0;
  HGetOle2MessageHook     : HHook            = 0;
  HGetCBTHook             : HHook            = 0;
  HCallWindowHook     : HHook            = 0;
  WindowsHooksCount       : Integer          = 0;


{ Routines }

function AssignedActivePopupMenu2000Form: Boolean;
begin
  Result:= (ActivePopupMenu <> nil)
    and (ActivePopupMenu is TCustomPopupMenu2000)
    and TCustomPopupMenu2000(ActivePopupMenu).FormOnScreen;
end;


procedure HideWindowMenu(Owner: TComponent);
begin
  // hides only MDIForm's menu
  if (Owner is TCustomForm)
  and (not (Owner.Owner is TCustomForm))
  and (TForm(Owner).Menu <> nil)
  then TForm(Owner).Menu:= nil;
end;


procedure SetStatusBarText(HintText: String);
var
  I: Integer;
  S: String;
begin
  S:= Trim(GetLongHint(HintText));

  // remove '&#13;' symbols from status bar text
  repeat
    I:= Pos('&#', S);
    if I = 0 then System.Break;
    System.Delete(S, I, 5);
    System.Insert(' ', S, I);
  until False;

  if Assigned(ActivePopupMenu)
  and Assigned(TCustomPopupMenu2000(ActivePopupMenu).StatusBar)
  then
    with TCustomPopupMenu2000(ActivePopupMenu), StatusBar do begin
      if SimplePanel
      then SimpleText:= S
      else
        if StatusBarIndex < Panels.Count
        then Panels[StatusBarIndex].Text:= S;

      Exit;
    end;
end;

// processing mousemove and paint messages --
// a bit faster than Application.ProcessMessages
// thanks to Jordan Russell & Borland
procedure ProcessMessage(const Message1, Message2: UINT);
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, Message1, Message2, pm_NoRemove)
  do begin
    case Integer(GetMessage(Msg, 0, Message1, Message2)) of
      -1: Exit;
      0: begin PostQuitMessage(Msg.WParam); Exit; end;
    end;
    DispatchMessage(Msg);
  end;
end;

procedure ProcessPaintMessages;
begin
  ProcessMessage(wm_Paint, wm_Paint);
end;

procedure ProcessMouseMoveMessages;
begin
  ProcessMessage(wm_MouseFirst, wm_MouseLast);
end;

procedure ProcessMessages;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, 0, 0, pm_Remove)
  do begin
    if not AssignedActivePopupMenu2000Form
    then begin
      PostMessage(Msg.hwnd, Msg.Message, Msg.wParam, Msg.lParam);
      Exit;
    end;

    if Msg.Message <> wm_Quit
    then begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end
    else begin
      PostQuitMessage(Msg.WParam);
      Exit;
    end;
  end;
end;


function KillActivePopupMenu2000;
var
  I: Integer;
begin
  Result:= True;
  try
    if AssignedActivePopupMenu2000Form
    then
      with ActivePopupMenu, TCustomPopupMenu2000(ActivePopupMenu).Form
      do begin
        SetStatusBarText('');

        if Perform(wm_KillAnimation, Integer(AnInternalKill), 0) = 0
        then begin
          Result:= False;
          Exit;
        end;

        Perform(wm_KillTimer, 0, 0);
        Perform(wm_SilentHide, 0, 0);
      end;

    if KillMenuBar
    and (ActiveMenubarList <> nil)
    then begin
      for I:= 0 to ActiveMenuBarList.Count -1
      do
        with TCustomMenuBar2000(ActiveMenuBarList[I])
        do
          KillActiveItem;

      if MenuDesigner <> nil
      then MenuDesigner.Perform(wm_KillMenuBar, 0, 0);
    end;
  except
  end;

  StopTimer;
  ActivePopupMenu:= nil;
//  ActiveMenuItem:= nil;
  ProcessPaintMessages;
  UnLockGlobalRepaint;
end;


{ Hooks }

function IsOkControl(const C: TControl): Boolean;
begin
  Result:=
    (C is TCustomPopupMenu2000Form)
    or (C is T_AM2000_DragWindow)
    or (C is T_AM2000_RaisedItemForm)
    or ((C <> nil) and IsOkControl(C.Parent));
end;

function IsOkControlUnderCursor: Boolean;
var
  P: TPoint;
  C: TControl;
begin
  GetCursorPos(P);
  C:= FindDragTarget(P, True);
  Result:= (C <> nil)
    and (((C is TCustomMenuBar2000)
      and (TCustomMenuBar2000(C).GetItemAtPoint(C.ScreenToClient(P)) <> nil))
    or IsOkControl(C));
end;

function IsObjectInspectorUnderCursor: Boolean;
var
  P: TPoint;
  C: TControl;
begin
  GetCursorPos(P);
  C:= FindDragTarget(P, True);

  while (C <> nil)
  and (C.Parent <> nil)
  do C:= C.Parent;

  Result:= (C <> nil)
    and (C.ClassName = 'TPropertyInspector');
end;

function IsApplicationActive: Boolean;
var
  P: TPoint;
  C: TControl;
begin
  GetCursorPos(P);
  C:= FindDragTarget(P, True);
  Result:= (C = nil);
end;

function GetMessageHook(Code, wParam, lParam: Integer): Integer; stdcall;
const
  LastForm: TCustomPopupMenu2000Form = nil;
var
  M: TMsg;
  Msg: Integer;
  I: Integer;
  MB: TCustomMenuBar2000;

  procedure ClearMessage;
  begin
    FillChar(PMsg(lParam)^, SizeOf(TMsg), 0);
  end;

{  function IsFloating: Boolean;
  var
    I, R: Integer;
    P: TPoint;
  begin
    Result:= False;
    GetCursorPos(P);
    if FloatingMenusList <> nil
    then
      for I:= 0 to FloatingMenusList.Count -1
      do begin
        R:= SendMessage(TForm(FloatingMenusList[I]).Handle, wm_NCHitTest, 0,
          MakeLong(P.X, P.Y));
        if R <> htError
        then begin
          Result:= True;
          Exit;
        end;
      end;
  end;
}

begin
  Result:= 0;

  if (Code >= 0)
  and Assigned(Application)
  and Application.Active
  and (not IsIconic(GetActiveWindow))
  then begin
    M:= PMsg(lParam)^;
    Msg:= PMsg(lParam)^.Message;

    // check for mouse messages
    if ((Msg >= wm_LButtonDblClk) and (Msg <= wm_MButtonDblClk))
    or ((Msg >= wm_NCRButtonDblClk) and (Msg <= wm_NCMButtonDblClk))
    or (Msg = wm_LButtonDown)
    or (Msg = wm_NCLButtonDown)
    or (Msg = wm_NCRButtonDown)
    then begin
      // is it a mouse click on form's client area?
      if IsOkControlUnderCursor
      then Exit;

      // if not -- kill active menu
      if AssignedActivePopupMenu2000Form
      then
        with TCustomPopupMenu2000(ActivePopupMenu), Form
        do
          if ((Perform(wm_GetState, ssPreview, 0) <> 0)
            and IsObjectInspectorUnderCursor)
          or (BorderStyle <> bsNone)
          or (not KillActivePopupMenu2000(True, False))
          then Exit;

      for I:= 0 to ActiveMenuBarList.Count -1
      do
        if not TCustomMenuBar2000(ActiveMenuBarList[I]).KillActiveItem
        then Exit;

      FullShowCaret;
    end;

    if (Msg = wm_MouseWheel)
    and AssignedActivePopupMenu2000Form
    then begin
      TCustomPopupMenu2000(ActivePopupMenu).Form.Perform(wm_MouseWheel, M.wParam, M.lParam);
      ClearMessage;
      Exit;
    end;

    if (Msg = wm_MouseMove)
    then begin
      if AssignedActivePopupMenu2000Form
      and (not IsOkControlUnderCursor)
      then TCustomPopupMenu2000(ActivePopupMenu).Form.Perform(cm_MouseLeave, 0, 0);

      Exit;
    end;

    // cancel drag
{    if (Msg = wm_LButtonUp)
    and (AssignedActivePopupMenu2000Form)
    then begin
      GetCursorPos(P);
      C:= FindDragTarget(P, True);
      if not (Assigned(C) and IsOkControl(C))
      then TCustomPopupMenu2000(ActivePopupMenu).Form.Perform(Msg, M.wParam, M.lParam);
    end;
}
    // another key?
    if ((Msg = wm_KeyDown) or (Msg = wm_KeyUp) or (Msg = wm_SysKeyDown) or (Msg = wm_SysKeyUp) or (Msg = wm_Char))
    then begin
      if (ActivePopupMenu <> nil)
      and (TCustomPopupMenu2000(ActivePopupMenu).Form.Perform(wm_GetState, ssPreview, 0) <> 0)
      then Exit;

      // is ActivePopupMenu contains the destination of the message?
      if (ActivePopupMenu <> nil)
      and (TCustomPopupMenu2000(ActivePopupMenu).GetTopMostForm.Perform(Msg, M.wParam, M.lParam) <> 0)
      then begin
        ClearMessage;
        Exit;
      end;

      // is ActiveMenuBarList contains the destination of the message?
      if ActiveMenubarList <> nil
      then
        for I:= ActiveMenuBarList.Count -1 downto 0
        do begin
          MB:= TCustomMenuBar2000(ActiveMenuBarList[I]);

          if (csDesigning in MB.ComponentState)
          then Exit;

          if MB.Visible
          and IsAvailable(MB.OwnerForm)
          then
            if (MB.Perform(Msg, M.wParam, M.lParam) <> 0)
            then begin
              ClearMessage;
              Exit;
            end
            else
            if IsActive(MB.OwnerForm)
            then Break;
        end;
    end; { keyboard message }
  end; { main form is active }

  Result:= CallNextHookEx(HGetMessageHook, Code, wParam, lParam);
end;

function GetOle2MessageHook(Code, wParam, lParam: Integer): Integer; stdcall;
var
  M: TMsg;
  Msg: Integer;
  I: Integer;
begin
  Result:= 0;

  if (Code >= 0)
  and Assigned(Application)
  and Application.Active
  and (not IsIconic(GetActiveWindow))
  then begin
    M:= PMsg(lParam)^;
    Msg:= PMsg(lParam)^.Message;

    // check for mouse messages
    if ((Msg >= wm_LButtonDblClk) and (Msg <= wm_MButtonDblClk))
    or ((Msg >= wm_NCRButtonDblClk) and (Msg <= wm_NCMButtonDblClk))
    or (Msg = wm_LButtonDown)
    or (Msg = wm_NCLButtonDown)
    or (Msg = wm_NCRButtonDown)
    then begin
      // is it a mouse click on form's client area?
      if (Msg > wm_MouseFirst)
      and (IsOkControlUnderCursor)
      then Exit;

      // if not -- kil active menu
      if AssignedActivePopupMenu2000Form
      then begin
        KillActivePopupMenu2000(True, False);
      end;

      if ActiveMenuBarList <> nil
      then
        for I:= 0 to ActiveMenuBarList.Count -1
        do
          with TCustomMenuBar2000(ActiveMenuBarList[I])
          do
            KillActiveItem;

      FullShowCaret;
    end;
  end;

  Result:= CallNextHookEx(HGetOle2MessageHook, Code, wParam, lParam);
end;

function GetCBTHook(Code: Integer; wParam: HWND; lParam: LPARAM): LRESULT; stdcall;
  // updates menu bar on new mdi form
var
  I: Integer;
begin
  if ((Code = HCBT_MINMAX)
  or (Code = HCBT_SETFOCUS))
  and (ActiveMenuBarList <> nil)
  and (ActiveMenuBarList.Count > 0)
  then
    for I:= 0 to ActiveMenuBarList.Count -1 do
      with TCustomMenuBar2000(ActiveMenuBarList[I]) do
        if (OwnerForm <> nil)
        and (TForm(OwnerForm).FormStyle = fsMdiForm)
        then PostMessage(Handle, wm_UpdateMenuBar, upChildChanged, 0);

  Result:= CallNextHookEx(HGetCBTHook, Code, wParam, lParam);
end;

function CallWindowHook(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
  // activate and deactivate application and main form
var
  F, OI: DWord;
  I: Integer;
  C: TWinControl;
  Z: array [0..255] of Char;

begin
  if (Code = HC_ACTION) then
    with PCWPStruct(lParam)^ do
      if ((Message = WM_ACTIVATE)
      or (Message = WM_ACTIVATEAPP))
      and (ActiveMenuBarList <> nil)
      then begin
        if (Message = WM_ACTIVATE)
        then F:= wParam
        else F:= LongRec(wParam).Lo;

        GetWindowText(LParam, Z, SizeOf(Z) -1);
        OI:= StrIComp(Z, 'Object Inspector');

        for I:= 0 to ActiveMenuBarList.Count -1
        do begin
          C:= TWinControl(ActiveMenuBarList[I]);

          if (TCustomMenuBar2000(C).RaisedForm <> nil)
          and ((TCustomMenuBar2000(C).RaisedForm.Handle = hwnd)
          or (TCustomMenuBar2000(C).RaisedForm.Handle = lParam))
          or ((ActiveDragWindow <> nil)
          and (ActiveDragWindow.Handle = hwnd))
          then begin
            Result:= 0;
            Exit;
          end;

          if IsContained(hwnd, C)
          then begin
            C.Perform(wm_ActivateMenuBar, F, 0);
            if (F = 0)
            and (OI <> 0)
            then KillActivePopupMenu2000(True, False);
          end;
        end;

        if (F = 0)
        and (OI <> 0)
        and (ActivePopupMenu <> nil)
        then KillActivePopupMenu2000(True, False);
      end;

  Result:= CallNextHookEx(HCallWindowHook, Code, wParam, lParam);
end;


{ Other Routines }

procedure CheckShowHint(MenuItem: TMenuItem; ShowFloatingHint: Boolean; Form: TForm);
var
  S: String;
begin
  if not Assigned(MenuItem) then Exit;

  S:= '';
  if (MenuItem is TMenuItem2000)
  then
    if (TMenuItem2000(MenuItem).Control = ctlButtonArray)
    then
      with TMenuItem2000(MenuItem), AsButtonArray do begin
        if (LastItemIndex >= 0)
        and (LastItemIndex < Hints.Count)
        then S:= Hints[LastItemIndex]
      end
    else
      S:= TMenuItem2000(MenuItem).Hint
  else
    S:= MenuItem.Hint;

  // fire Application.OnHint
  Application.Hint:= S;
  Form.Hint:= S;

  if (ActivePopupMenu <> nil)
  and (TCustomPopupMenu2000(ActivePopupMenu).StatusBar <> nil)
  then SetStatusBarText(S);
end;

// thanks to Brad Stowers for this routine
procedure PaintMenuIcon(const Owner, AMC: Forms.TForm; const DC: HDC; const X, Y, W: Integer);
 // thanks to Mikl•s Kov‚cs for the fix to this routine
var
  IconHandle, NewIcon: HIcon;
begin
  if Assigned(AMC) and (AMC.Icon.Handle <> 0)
  then IconHandle := AMC.Icon.Handle
  else
  if Assigned(AMC) and (Owner.Icon.Handle <> 0)
  then IconHandle:= Owner.Icon.Handle
  else
  if Application.Icon.Handle <> 0
  then IconHandle:= Application.Icon.Handle
  else IconHandle:= LoadIcon(0, IDI_APPLICATION);

  NewIcon:= CopyImage(IconHandle, IMAGE_ICON, W, W, $4000);
  DrawIconEx(DC, X, Y, NewIcon, 0, 0, 0, 0, DI_NORMAL);
  DestroyIcon(NewIcon);
end;

function CreateDibSectionEx(const ADC: HDC; const AWidth, AHeight: Integer; const PBits: Pointer): HBitmap;
var
  bi: TBitmapInfo;
  P: Pointer;
begin
  FillChar(bi, SizeOf(bi), 0);
  with bi.bmiHeader
  do begin
    biSize:= SizeOf(TBitmapInfoHeader);
    biWidth:= AWidth;
    biHeight:= AHeight;
    biPlanes:= 1;
    biBitCount:= 24;
    biCompression:= BI_RGB;
  end;

  P:= nil;
//  Result:= CreateCompatibleBitmap(Desktop.Handle, AWidth, AHeight);
{$IFDEF Delphi2}
  Result:= CreateDibSection(ADC, bi, DIB_RGB_COLORS, P, nil, 0);
{$ELSE}
  Result:= CreateDibSection(ADC, bi, DIB_RGB_COLORS, P, 0, 0);
{$ENDIF}

  if PBits <> nil
  then Pointer(PBits^):= P;
end;

procedure GetDiBitsEx(
  var Bits: PByteArray;
  var BytesPerLine: Cardinal;
  var BytesPerPixel: Cardinal;
  var BitsInfo;
  const ASampleDC: HDC;
  const ABitmap: HBitmap;
  var ATransparentColor: TColor);
var
  Bitmap: HBitmap;
  NewSize, InfoHeaderSize: DWord;
  DC, SourceDC: HDC;
  old1, old2: HGdiObj;
  BitmapInfo: Windows.TBitmap;
  P: PRgbTriple;
begin
  old1:= 0;
  DC:= 0;
  BitmapInfo.bmBitsPixel:= 0;
  GetObject(ABitmap, SizeOf(BitmapInfo), @BitmapInfo);

  if BitmapInfo.bmBitsPixel >= (SizeOf(TRgbTriple) shl 3)
  then begin
    Bitmap:= ABitmap;
  end

  else begin
    DC:= CreateCompatibleDC(ASampleDC);

    Bitmap:= CreateDibSectionEx(DC, BitmapInfo.bmWidth, BitmapInfo.bmHeight, @Bits);
    Old1:= SelectObject(DC, Bitmap);

    SourceDC:= CreateCompatibleDC(ASampleDC);
    Old2:= SelectObject(SourceDC, ABitmap);

    BitBlt(DC, 0, 0, BitmapInfo.bmWidth, BitmapInfo.bmHeight, SourceDC, 0, 0, SrcCopy);

    SelectObject(SourceDC, old2);
    DeleteDC(SourceDC);

    SelectObject(DC, Old1);
  end;

  GetDibSizes(Bitmap, InfoHeaderSize, NewSize);
  GetMem(Bits, NewSize);

  if GetDib(Bitmap, 0, BitsInfo, Bits^)
  then begin
    if TBitmapInfoHeader(BitsInfo).biBitCount < 24
    then raise Exception.Create('Insufficient bit count in the bitmap!');

    BytesPerPixel:= TBitmapInfoHeader(BitsInfo).biBitCount shr 3;
    BytesPerLine:= NewSize div TBitmapInfoHeader(BitsInfo).biHeight;

    if ATransparentColor = clNone
    then begin
      P:= PRgbTriple(Cardinal(Bits) +
        (TBitmapInfoHeader(BitsInfo).biHeight - BitmapInfo.bmHeight) * BytesPerLine);
      ATransparentColor:= RGB(P.rgbtRed, P.rgbtGreen, P.rgbtBlue);
    end;
  end
  else begin
    FreeMem(Bits);
    Bits:= nil;
  end;

  if DC <> 0
  then begin
    SelectObject(DC, Old1);
    DeleteDC(DC);
    DeleteObject(Bitmap);
  end;
end;

procedure BlurBitmap(const ADC: HDC; const ABitmap: HBITMAP;
  const AX, AY, Glyph, NumGlyphs: Integer; const ABackgroundColor, ATransparentColor: TColor);

type
  TRgbTripleArray = array [0..0] of TRgbTriple;
  PRgbTripleArray = ^TRgbTripleArray;

const
  bmpSize = sizeof(Windows.TBITMAP);
  kernel: array [0..2, 0..2] of Integer = (
    (0, 1, 0),
    (1, 1, 1),
    (0, 1, 0));

var
  bi: TBitmapInfo;
  bmp: Windows.TBitmap;
  pBits: PByteArray;
  bytes_per_scanline, y, x, row, col,
    sumR, sumG, sumB, x_pos: Cardinal;
  pBuffer, pSourceLine, pDestLine: PRgbTripleArray;
  Bitmap1: TBitmap;
  hold: HGdiObj;
  BitsSize: Cardinal;
  divider: Integer;
  C: TColor;
begin
  GetObject(ABitmap, SizeOf(Windows.TBitmap), @bmp);
  bmp.bmWidth:= bmp.bmWidth div NumGlyphs;

  Bitmap1:= TBitmap.Create;
  Bitmap1.Width:= bmp.bmWidth +2;
  Bitmap1.Height:= bmp.bmHeight +2;
{$IFDEF Delphi3OrHigher}
  Bitmap1.PixelFormat:= pf24bit;
{$ENDIF}
  with Bitmap1.Canvas
  do begin
    if ABackgroundColor <> clNone
    then begin
      Brush.Color:= ABackgroundColor;
      FillRect(ClipRect);
    end
    else begin
      DrawPatternBackground(Bitmap1.Canvas, ClipRect);
    end;
  end;

  NewDisabledBlt(Bitmap1.Canvas, 1, 1, Glyph, NumGlyphs, ABitmap, clBlack, clNone, ATransparentColor);

  GetDiBitsEx(pBits, Bytes_Per_Scanline, y, bi.bmiHeader, ADC, Bitmap1.Handle, C);

  Inc(bmp.bmWidth);
  Inc(bmp.bmHeight);

  GetMem(pBuffer, bi.bmiHeader.biSizeImage);
  try
    for y:= 0 to bmp.bmHeight
    do begin
      pDestLine:= Pointer(Cardinal(pBuffer) + y * bytes_per_scanline);
      for x:= 0 to bmp.bmWidth
      do begin
        // keep a running sum for the convolution
        sumR:= 0;
        sumG:= 0;
        sumB:= 0;
        divider:= 0;

        // for each tap in the filter
        for row:= 0 to 2
        do
          if ((y <> 0) or (row <> 0))
          and ((y <> bmp.bmHeight) or (row <> 2))
          then begin
            pSourceLine:= Pointer(Cardinal(pBits) + (y + row - 1) * bytes_per_scanline);
            for col:= 0 to 2
            do
              if ((x <> 0) or (col <> 0))
              and ((x <> bmp.bmWidth) or (col <> 2))
              then begin
                x_pos:= x + col - 1;
                // perform the convolution...
                Inc(SumR, pSourceLine[x_pos].rgbtRed shl kernel[row, col]);
                Inc(SumG, pSourceLine[x_pos].rgbtGreen shl kernel[row, col]);
                Inc(SumB, pSourceLine[x_pos].rgbtBlue shl kernel[row, col]);

                divider:= divider + 1 shl kernel[row, col];
              end;
          end;

        if (divider <> 0)
        then
          with pDestLine[x]
          do begin
            // assign the filtered pixel to the destination
            rgbtRed:= Round(sumR / divider);
            rgbtGreen:= Round(sumG / divider);
            rgbtBlue:= Round(sumB / divider);
          end
        else begin
          pSourceLine:= Pointer(Cardinal(pBits) + y * bytes_per_scanline);
          pDestLine[x]:= pSourceLine[x];
        end;
      end;
    end;

    SetDiBitsToDevice(ADC, AX, AY, Bitmap1.Width, Bitmap1.Height -1, 0, 1, 0, Bitmap1.Height, pBuffer, bi, DIB_RGB_COLORS);

  finally
    FreeMem(pBuffer);
    FreeMem(pBits);
    Bitmap1.Free;

  end;

end;

procedure TransBlt(const Canvas: TCanvas;
  X, Y: Integer;
  const Glyph, NumGlyphs: Integer;
  const ABitmap: HBitmap;
  TransparentColor: TColor;
  const clShadow: TColor;
  const AParams: Integer);
var
  X1, Y1, DX, XE, Cur: Integer;
  P: PRgbTriple;
  Bits: PByteArray;
  BytesPerLine: Cardinal;
  BytesPerPixel: Cardinal;
  BitsInfo: TBitmapInfoHeader;
begin
  GetDiBitsEx(Bits, BytesPerLine, BytesPerPixel, BitsInfo, Canvas.Handle, ABitmap, TransparentColor);

  if NumGlyphs > 1
  then begin
    XE:= BitsInfo.biWidth div NumGlyphs;
    DX:= Glyph * XE;
  end
  else begin
    DX:= 0;
    XE:= BitsInfo.biWidth;
  end;

  if AParams and dbRaiseBitmap <> 0
  then begin
    // draw disabled bitmap
    NewDisabledBlt(Canvas, X +1, Y +1, Glyph, NumGlyphs, ABitmap, clNone, clShadow, TransparentColor);
    Dec(X); Dec(Y);
  end;

  if AParams and dbBitmapShadow <> 0
  then begin
    // draw blurred bitmap
    Cur:= GetPixel(Canvas.Handle, X, Y);
    if Cur <> GetPixel(Canvas.Handle, X +1, Y)
    then Cur:= clNone;

    BlurBitmap(Canvas.Handle, ABitmap, X, Y, Glyph, NumGlyphs, Cur, TransparentColor);  
  end;

  if Bits = nil then Exit;

  for Y1:= 0 to BitsInfo.biHeight -1
  do begin
    P:= PRgbTriple(Cardinal(Bits) + (BitsInfo.biHeight - Y1 -1) * BytesPerLine + DX * BytesPerPixel);

    for X1:= 0 to XE -1
    do begin
      Cur:= RGB(P.rgbtRed, P.rgbtGreen, P.rgbtBlue);

      if (Cur <> TransparentColor)
      then begin
        // lighten color
        if AParams and dbLightBitmap <> 0
        then begin
          if Cur = clWhite then
          else
          if Cur = clBlack then Cur:= $303030
          else
          if Cur = clMaroon then Cur:= $303090
          else
          if Cur = clGreen then Cur:= $309030
          else
          if Cur = clOlive then Cur:= $309090
          else
          if Cur = clNavy then Cur:= $903030
          else
          if Cur = clPurple then Cur:= $903090
          else
          if Cur = clTeal then Cur:= $909030
          else
          if Cur = clGray then Cur:= $909090
          else
          if Cur = clSilver then Cur:= $d0d0d0
          else
          if Cur = clRed then Cur:= $3030FF
          else
          if Cur = clLime then Cur:= $30FF30
          else
          if Cur = clYellow then Cur:= $30FFFF
          else
          if Cur = clBlue then Cur:= $FF3030
          else
          if Cur = clFuchsia then Cur:= $FF30FF
          else
          if Cur = clAqua then Cur:= $FFFF30
          else
            Cur:= GetSoftColor(Cur, $FFFFFF, cLightBitmap);
        end;

        SetPixel(Canvas.Handle, X + X1, Y + Y1, Cur);
      end;

      Inc(Cardinal(P), BytesPerPixel);
    end;
  end;

  FreeMem(Bits);
end;

procedure NewDisabledBlt(const Canvas: TCanvas;
  const X, Y: Integer;
  const Glyph, NumGlyphs: Integer;
  const ABitmap: HBitmap; 
  const clHigh, clShadow: TColor;
  TransparentColor: TColor);
var
  Bits: PByteArray;
  BytesPerLine, BytesPerPixel: Cardinal;
  BitsInfo: TBitmapInfoHeader;
  XE, DX: Integer;

  procedure PaintColor(Color: TColor; Offset: Integer);
  var
    X1, Y1, Cur: Integer;
    P: PRgbTriple;
  begin
    for Y1:= 0 to BitsInfo.biHeight -1
    do begin
      P:= PRgbTriple(Cardinal(Bits) + (BitsInfo.biHeight - Y1 -1) * BytesPerLine + DX * BytesPerPixel);
      for X1:= 0 to XE -1
      do begin
        Cur:= RGB(P.rgbtRed, P.rgbtGreen, P.rgbtBlue);

        if (Cur <> TransparentColor)
        and (P.rgbtRed + P.rgbtGreen + P.rgbtBlue <= 700)
        then SetPixel(Canvas.Handle, X + X1 + Offset, Y + Y1 + Offset, Color);

        Inc(Cardinal(P), BytesPerPixel);
      end;
    end;
  end;

begin
  if ABitmap = 0
  then Exit;

  GetDiBitsEx(Bits, BytesPerLine, BytesPerPixel, BitsInfo, Canvas.Handle, ABitmap, TransparentColor);
  if Bits = nil then Exit;

  if NumGlyphs > 1
  then begin
    XE:= BitsInfo.biWidth div NumGlyphs;
    DX:= Glyph * XE;
  end
  else begin
    DX:= 0;
    XE:= BitsInfo.biWidth;
  end;

  if clShadow <> clNone
  then PaintColor(ColorToRgb(clShadow), 1);

  if clHigh <> clNone
  then PaintColor(ColorToRgb(clHigh), 0);

  FreeMem(Bits);
end;

procedure ImgTransBlt(const Canvas: TCanvas; const X, Y: Integer; const Images: HImageList;
  const Index, Width, Height: Integer; const clShadow: TColor; const AParams: Integer);
var
  C: TColor;
  DC: HDC;
  OldBitmap, Bitmap: HBitmap;
  Brush: HBrush;
begin
  if AParams and dbEffects = 0
  then begin
    ImageList_Draw(Images, Index, Canvas.Handle, X, Y, ild_Transparent);
    Exit;
  end;

  Bitmap:= CreateCompatibleBitmap(Canvas.Handle, Width, Height);
  DC:= CreateCompatibleDC(Canvas.Handle);
  OldBitmap:= SelectObject(DC, Bitmap);

  C:= TColor(ImageList_GetBkColor(Images));
  if C = -1
  then begin
    C:= clFuchsia;
    Brush:= CreateSolidBrush(C);
    FillRect(DC, Rect(0, 0, Width, Height), Brush);
    DeleteObject(Brush);
  end;

  ImageList_Draw(Images, Index, DC, 0, 0, ild_Normal);
  SelectObject(DC, OldBitmap);

  if AParams and dbRaiseBitmap <> 0
  then begin
    NewDisabledBlt(Canvas, X +1, Y +1, 1, 1, Bitmap, clNone, clShadow, C);
    ImageList_Draw(Images, Index, Canvas.Handle, X -1, Y -1, ild_Transparent);
  end
  else begin // dbLightBitmap
    TransBlt(Canvas, X, Y, 1, 1, Bitmap, C, clShadow, AParams);
  end;

  DeleteDC(DC);
  DeleteObject(Bitmap);
end;

procedure ImgDisabledBlt(const Canvas: TCanvas; const X, Y: Integer; const Images: HImageList;
  const Index, Width, Height: Integer; const clHigh, clShadow: TColor);
var
  DC: HDC;
  OldBitmap, Bitmap: HBitmap;
  Brush: HBrush;
  C: TColor;
begin
  Bitmap:= CreateCompatibleBitmap(Canvas.Handle, Width, Height);
  DC:= CreateCompatibleDC(Canvas.Handle);
  OldBitmap:= SelectObject(DC, Bitmap);

  C:= TColor(ImageList_GetBkColor(Images));
  if C = -1
  then begin
    C:= clFuchsia;
    Brush:= CreateSolidBrush(C);
    FillRect(DC, Rect(0, 0, Width, Height), Brush);
    DeleteObject(Brush);
  end;

  ImageList_Draw(Images, Index, DC, 0, 0, ild_Normal);
  SelectObject(DC, OldBitmap);

  NewDisabledBlt(Canvas, X, Y, 1, 1, Bitmap, clHigh, clShadow, C);

  DeleteDC(DC);
  DeleteObject(Bitmap);
end;


procedure FullHideCaret;
  // hides the caret
begin
  HideCaret(0);
  Inc(CurCaretIndex);
end;

procedure FullShowCaret;
  // shows the caret
var
  I: Integer;
begin
  for I:= CurCaretIndex downto 1 do
    ShowCaret(0);

  CurCaretIndex:= 0;
end;

function GetMenuFontHandle: HFont;
  // retrives default menu font
begin
  SystemParametersInfo(spi_GetNonClientMetrics, 0, @NonClientMetrics, 0);
  
  if NonClientMetrics.lfMenuFont.lfHeight <> 0
  then Result:= CreateFontIndirect(NonClientMetrics.lfMenuFont)
  else Result:= GetStockObject(SYSTEM_FONT);
end;

function GetValidName(Caption: String): String;
  // creates valid menu item name from the given caption
var
  I: Integer;
begin
  Result:= '';
  for I:= 1 to Length(Caption) do
    if Caption[I] in ['0'..'9', 'A'..'Z', '_', 'a'..'z']
    then Result:= Result + Caption[I];

  if Result = '' then Result:= 'N';
  if Result[1] in ['0'..'9'] then Result:= 'N' + Result;

end;

procedure InstallOle2GMHook(hwndActiveObject: HWnd);
var
  lpdwProcessId: LongInt;
  lpdwThreadId: LongInt;
begin
  if HGetOle2MessageHook <> 0
  then begin
    UnhookWindowsHookEx(HGetOle2MessageHook);
    HGetOle2MessageHook:= 0;
  end;

  lpdwThreadId:= GetWindowThreadProcessId(hwndActiveObject, @lpdwProcessId);

  if lpdwThreadId <> 0
  then
//    HGetOle2MessageHook:= SetWindowsHookEx(wh_GetMessage, @GetOle2MessageHook, lpdwProcessId, GetCurrentThreadID);
end;

procedure RemoveOle2GMHook;
begin
  if HGetOle2MessageHook <> 0
  then
    UnhookWindowsHookEx(HGetOle2MessageHook);

  HGetOle2MessageHook:= 0;
end;

procedure InstallWindowsHooks;
begin
//  Exit;

  Inc(WindowsHooksCount);
  if WindowsHooksCount <> 1 then Exit;

  // install the computer-based training hook for mdi child form
  if (HGetCBTHook = 0)
  then HGetCBTHook:= SetWindowsHookEx(WH_CBT, @GetCBTHook, 0, GetCurrentThreadID);

  // install the call window procedure hook - for gray activated
  if (HCallWindowHook = 0)
  then HCallWindowHook:= SetWindowsHookEx(WH_CallWndProc, @CallWindowHook, 0, GetCurrentThreadID);

  // setting the hook - many thanks to Victor Santos
  // for help in solving the problems with hook
  if HGetMessageHook = 0
  then HGetMessageHook:= SetWindowsHookEx(wh_GetMessage, @GetMessageHook, 0, GetCurrentThreadID);
end;

procedure RemoveWindowsHooks;
begin
  if WindowsHooksCount = 0 then Exit;
  Dec(WindowsHooksCount);
  if WindowsHooksCount > 0 then Exit;

  // remove the 'computer-based training' hook
  if HGetCBTHook <> 0
  then UnhookWindowsHookEx(HGetCBTHook);

  // remove the 'call window procedure' hook
  if HCallWindowHook <> 0
  then UnhookWindowsHookEx(HCallWindowHook);

  // remove the 'get message' hook
  if HGetMessageHook <> 0
  then UnhookWindowsHookEx(HGetMessageHook);

  HGetCBTHook:= 0;
  HCallWindowHook:= 0;

  HGetMessageHook:= 0;
end;



function StripAmpersands(S: String): String;
var
  P: Integer;
begin
  Result:= '';
  P:= Pos('&', S);
  while P > 0 do begin
    if P > 1
    then Result:= Result + Copy(S, 1, P -1);
    Delete(S, 1, P);

    if (S <> '') and (S[1] = '&')
    then begin
      Result:= Result + '&';
      Delete(S, 1, 1);
    end;

    P:= Pos('&', S);
  end;

  Result:= Result + S;
end;

function IsAccelEx(VK: Word; const Str: String; UseFirstLetter: Boolean): Boolean;
var
  S: String;
begin
  Result:= (VK in [$30..$39,$41..$5a])
    and Forms.IsAccel(VK, Str);

  if (not Result)
  and UseFirstLetter
  and (Str <> '')
  then begin
    S:= StripAmpersands(Str);
    Result:= (S <> '') and (VK = Byte(UpCase(S[1])));
  end;
end;

function IsAccel2(VK: Word; const Str: String): Boolean;
begin
  Result:= IsAccelEx(VK, Str, Pos('&', Str) = 0);
end;

function HasSubmenu(Item: TMenuItem): Boolean;
begin
  if Item is TMenuItem2000
  then
    with TMenuItem2000(Item)
    do
      Result:= (GetMenuItemCount(MenuHandle) > 0) // Win32 menu
        or (Count > 0)   // Delphi menu
        or (AttachMenu <> nil) // Attached menu
  else
    Result:= (Item <> nil)
      and ((GetMenuItemCount(Item.Handle) > 0) // Win32 menu
      or (Item.Count > 0));   // Delphi menu
end;

function HasSubmenuWin32(Handle: HMenu; Index: Integer): Boolean;
begin
  if Index < 0
  then begin
    Result:= False;
    Exit;
  end;

  mii.fMask:= miim_State + miim_SubMenu;
  GetMenuItemInfo(Handle, Index, True, mii);
  Result:= mii.hSubMenu <> 0;
end;

function AmpTextWidth(Canvas: TCanvas; S: String): Integer;
  // returns text width without ampersands
begin
  Result:= Canvas.TextWidth(StripAmpersands(S));
end;


procedure CopyToClipboard(S: String);
var
  L: Integer;
  hglbCopy: HGLOBAL;
  lptstrCopy: PChar;
begin
  L:= (Length(S) +1) * SizeOf(Char);
  OpenClipboard(0);
  EmptyClipboard;

  hglbCopy:= GlobalAlloc(GMEM_DDESHARE, L);

  lptstrCopy:= GlobalLock(hglbCopy);
  Move(PChar(S)^, lptstrCopy^, L);
//    lptstrCopy[cch] = (TCHAR) 0;    // null character

  GlobalUnlock(hglbCopy);

  // Place the handle on the clipboard.
  SetClipboardData(cf_Text, hglbCopy);

  CloseClipboard;
end;

function PasteFromClipboard: String;
var
  hglb: HGLOBAL;
  lptstr: PChar;
begin
  Result:= '';
  OpenClipboard(0);
  hglb:= GetClipboardData(cf_Text);
  lptstr:= GlobalLock(hglb);

  if lptstr <> nil then Result:= StrPas(lptstr);

  GlobalUnlock(hglb);
  CloseClipboard;
end;

{$IFNDEF Delphi4OrHigher}
function StringReplace(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
var
  I: Integer;
begin
  I:= Pos(OldPattern, MenuDataFile);
  If I > 0
  then begin
    Delete(MenuDataFile, I, Length(OldPattern));
    Insert(NewPattern, MenuDataFile, I);
  end;
end;
{$ENDIF}

function PosShortCut(const SC, SCList: String): Boolean;
  // is shortcut delimited with semi-colons or string limits?
var
  P, E: Integer;
begin
  P:= Pos(SC, SCList);
  E:= P + Length(SC);
  Result:= (P <> 0)
    and ((P = 1) or (SCList[P -1] = ';'))
    and ((E > Length(SCList)) or (SCList[E] = ';'));
end;

function IsShortCutEx(var Msg: TWMKey; Items: TMenuItem; DoAction: Boolean): Boolean;
  // many thanks to Frédéric Schneider for the improvements to this routine
type
  TClickResult = (crDisabled, crClicked, crShortCutMoved);
var
  ShortCut: TShortCut;
  ShortCutStr: String;
  ShortCutItem: TMenuItem;

  function DoClick(Item: TMenuItem): TClickResult;
    // thanks to Borland (Inprise) for this code
  begin
    try
      Result:= crClicked;
      if Item.Parent <> nil then Result:= DoClick(Item.Parent);
      if Result = crClicked then
        if Item.Enabled
        then begin
{$IFDEF Delphi4OrHigher}
          if DoAction then Item.InitiateAction;
{$ENDIF}
          Item.Click;
        end
        else Result:= crDisabled;
    except
      Result:= crDisabled;
    end;
  end;

  function FindItemByShortCut(Items: TMenuItem): TMenuItem;
  var
    I: Integer;
    MI: TMenuItem;
  begin
    I:= 0;
    Result:= nil;
    while (I < Items.Count) and (Result = nil)
    do begin
      MI:= Items[I];
      if (MI.ShortCut = ShortCut)
      or ((MI is TMenuItem2000)
      and (PosShortCut(ShortCutStr, TMenuItem2000(Items[I]).ShortCut)))
      then begin
        Result:= Items[I];
        Exit;
      end;

      if MI.Count > 0
      then
        Result:= FindItemByShortCut(MI);

      if (MI is TMenuItem2000)
      and (TMenuItem2000(MI).AttachMenu <> nil)
      then
        Result:= FindItemByShortCut(TMenuItem2000(MI).AttachMenu.Items);

      Inc(I);
    end;
  end;

  procedure SearchForItems(Items: TMenuItem);
  var
    ClickResult: TClickResult;
  begin
    if Items = nil then Exit;

    repeat
      ClickResult:= crDisabled;
      ShortCutItem:= FindItemByShortCut(Items);

      if ShortCutItem <> nil
      then begin
        KillActivePopupMenu2000(True, False);
        ClickResult:= DoClick(ShortCutItem);
      end;

    until ClickResult <> crShortCutMoved;

    if ShortCutItem <> nil
    then begin
      Msg.Result:= 1;
      Result:= True;
    end;
  end;

begin
  Result:= False;

  // get short cut
  ShortCut:= Msg.CharCode;
  if GetKeyState(vk_Shift) < 0 then Inc(ShortCut, scShift);
  if GetKeyState(vk_Control) < 0 then Inc(ShortCut, scCtrl);
  if Msg.KeyData and AltMask <> 0 then Inc(ShortCut, scAlt);

  // get text short cut
  ShortCutStr:= ShortCutToText(ShortCut);

  // search
  if ShortCutStr <> ''
  then SearchForItems(Items);
end;

function GetNumLines(S: String): Integer;
var
  P, PS: PChar;
begin
  Result:= 1;
  PS:= PChar(S);
  repeat
    P:= StrPos(PS, #13);

    if (bEnableExtendedSymbols)
    and (P = nil)
    then P:= StrPos(PS, PChar(SNewLine));
    
    if P = nil then Break;
    Inc(Result);
    PS:= @P[1];
  until PS[0] = #0;
end;

function IsAvailable(Control: TControl): Boolean;
var
  C: TControl;
begin
  C:= Control;
  while (C <> nil)
  do begin
    if (not C.Visible)
    or (csLoading in C.ComponentState)
    or (csDestroying in C.ComponentState)
    or ((C is TWinControl)
      and not IsWindowEnabled(TWinControl(C).Handle))
    then Break;

    C:= C.Parent;
  end;

  Result:= C = nil;
end;

function IsOwner(Owner, Child: TComponent): Boolean;
begin
  Result:= (Owner = Child)
    or ((Child <> nil) and IsOwner(Owner, Child.Owner));
end;

function IsActive(Control: TWinControl): Boolean;
var
  F: TWinControl;
begin
  Result:= False;
  if (Control = nil)
  or (csLoading in Control.ComponentState)
  or (csDestroying in Control.ComponentState)
  or not (IsWindowEnabled(Control.Handle))
  then Exit;

  if Screen.ActiveForm = nil
  then
    Result:= Control.Handle = GetForegroundWindow
  else begin
    F:= Screen.ActiveForm;
    while (F <> nil)
    do begin
      if F = Control
      then begin
        Result:= True;
        Exit;
      end;

      F:= TWinControl(F.Owner);
    end;

    Result:= (Control is TForm)
      and (Screen.ActiveForm = TForm(Control).ActiveMdiChild);
  end;
end;

function IsContained(Handle: THandle; Control: TComponent): Boolean;
var
  C: TComponent;
begin
  Result:= False;
  C:= Control;
  while (C <> nil)
  do begin
    if (C is TWinControl)
    and (TWinControl(C).Handle = Handle)
    then begin
      Result:= True;
      Exit;
    end;
    C:= C.Owner;
  end;
end;

function FindItem2000(Form: TForm; Value: Word; FindKing: TFindItemKind): TMenuItem;
var
  I: Integer;
begin
  Result:= nil;
  for I:= 0 to Form.ComponentCount -1 do
    if (Form.Components[I] is TMenuItem)
    and (TMenuItem(Form.Components[I]).Command = Value)
    then begin
      Result:= TMenuItem(Form.Components[I]);
      Exit;
    end;
end;

procedure ShowCustomizeDialog;
begin
end;

// initialize registry
procedure OpenRegistry;
var
  R: TRegistry;
  cbData: DWord;
begin
  cbData:= SizeOf(iElapsedTime);
  R:= TRegistry.Create;
  MenuOrderRegistry:= StringReplace(MenuOrderRegistry, '\$(MENU)', '', []);

  if R.OpenKey(MenuOrderRegistry, False)
  and (R.GetDataSize('ElapsedTime') > 0)
  then RegQueryValueEx(R.CurrentKey, 'ElapsedTime', nil, nil, @iElapsedTime, @cbData);

  iStartingTime:= GetTickCount;

  R.Free;
end;

// store information about usability
// for menu item demoting
procedure CloseRegistry;
var
  R: TRegistry;
begin
  // don't store menu state
  if (MenuWhereToSave <> msRegistry)
  then Exit;

  R:= TRegistry.Create;
  R.OpenKey(MenuOrderRegistry, True);

  Inc(iElapsedTime, (GetTickCount - iStartingTime) div 1000);
  RegSetValueEx(R.CurrentKey, 'ElapsedTime', 0, REG_DWORD, @iElapsedTime, SizeOf(iElapsedTime));
  R.Free;
end;

procedure InitializePath(var AMenuOrderRegistry, AMenuDataFile: String);
const
  CSIDL_APPDATA = $001a;

{$IFDEF Delphi2}
type
  TSHItemID = record
    cb: Word;
    abID: array[0..0] of Byte;
  end;

  PItemIDList = ^TItemIDList;
  TItemIDList = record
     mkid: TSHItemID;
   end;

  function SHGetSpecialFolderLocation(hwndOwner: HWND; nFolder: Integer;
    var ppidl: PItemIDList): HResult; stdcall;
    external 'shell32.dll' name 'SHGetSpecialFolderLocation';
  function SHGetPathFromIDList(pidl: PItemIDList; pszPath: PChar): BOOL; stdcall;
    external 'shell32.dll' name 'SHGetPathFromIDListA';
{$ENDIF}

var
  Filename: String;
  z: array [0..256] of Char;
  ppidl: PItemIDList;
begin
  Filename:= ExtractFilename(ParamStr(0));

  AMenuOrderRegistry:= StringReplace(AMenuOrderRegistry,
    '$(APPNAME)', Filename, []);

  SHGetSpecialFolderLocation(0, CSIDL_APPDATA, ppidl);
  SHGetPathFromIDList(ppidl, z);
  AMenuDataFile:= StringReplace(StringReplace(AMenuDataFile,
    '$(APPNAME)', Filename, []),
    '$(APPDATA)', StrPas(z), []);
end;


const
  MenuFileFormat: array[T_AM2000_MenuWhereToSave] of Integer = (0, 0, 1, 2, 3);
  MenuFileExtension: array[T_AM2000_MenuWhereToSave] of String = ('', '', '.menu', '.txt', '.xml');

procedure ClearItems(const Items: TMenuItem);
begin
  while Items.Count > 0
  do Items[Items.Count -1].Free;
end;

procedure LoadMenu(const AComponent: TComponent);
var
  Filename: String;
begin
  LockGlobalRepaint;

  case MenuWhereToSave of
    msDontSave:;

    msRegistry:
      LoadMenuFromRegistry(AComponent);

    else begin
      Filename:= StringReplace(MenuDataFile, '$(MENU)',
        AComponent.Name + MenuFileExtension[MenuWhereToSave], []);

      if FileExists(Filename)
      then LoadMenuFromFileFormat(AComponent, Filename, MenuFileFormat[MenuWhereToSave]);
    end;
  end;

  UnlockGlobalRepaint;
end;

procedure SaveMenu(const AComponent: TComponent);
var
  Filename, Directory: String;
  Code: Integer;
begin
{$IFNDEF DesignTime}
  if AComponent = nil
  then Exit;

  case MenuWhereToSave of
    msDontSave:;

    msRegistry:
      SaveMenuToRegistry(AComponent);

    else begin
      Filename:= StringReplace(MenuDataFile, '$(MENU)',
        AComponent.Name + MenuFileExtension[MenuWhereToSave], []);
      Directory:= ExtractFilePath(Filename);
      Code:= GetFileAttributes(PChar(Directory));
      if ((Code <> -1)
      and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0))
      or CreateDirectory(PChar(Directory), nil)
      then SaveMenuToFileFormat(AComponent, Filename, MenuFileFormat[MenuWhereToSave]);
    end;
  end;
{$ENDIF}  
end;

procedure SaveComponentToStream(const AComponent: TComponent; const AStream: TStream; const Format: Integer);
var
  B: TMemoryStream;
begin
  try
    B:= TMemoryStream.Create;

    with TWriter.Create(B, 4096)
    do try
      Root:= AComponent.Owner;
      WriteSignature;
      WriteComponent(AComponent);
    finally
      Free;
    end;

    B.Seek(0, soFromBeginning);

    if Format = mfText
    then ObjectBinaryToText(B, AStream)
    else ObjectBinaryToXml(B, AStream);

  finally
    B.Free;
  end;
end;

procedure ReadComponentFromStream(const AComponent: TComponent; const AStream: TStream; const Format: Integer);
var
  B: TMemoryStream;
begin
  try
    B:= TMemoryStream.Create;

    if Format = mfText
    then ObjectTextToBinary(AStream, B)
    else ObjectXmlToBinary(AStream, B);

    B.Seek(0, soFromBeginning);

    with TReader.Create(B, 4096)
    do try
      Root:= AComponent.Owner;
      Owner:= AComponent.Owner;
      Parent:= AComponent.Owner;
      BeginReferences;
      try
        ReadSignature;
        ReadComponent(AComponent);
        FixupReferences;
      finally
        EndReferences;
      end;
    finally
      Free;
    end;

  finally
    B.Free;
  end;
end;

procedure LoadMenuFromFileFormat(const AComponent: TComponent; const Filename: String; const Format: Integer);
var
  F: TFileStream;
begin
  // clear menu component
  if AComponent is TMenu
  then ClearItems(TMenu(AComponent).Items);

  try
    F:= TFileStream.Create(Filename, fmOpenRead);
    case Format of
      mfResource:
        F.ReadComponentRes(AComponent);

      mfText, mfXml:
        ReadComponentFromStream(AComponent, F, Format);
    end;

  finally
    F.Free;
  end;
end;

procedure SaveMenuToFileFormat(const AComponent: TComponent; const Filename: String; const Format: Integer);
var
  F: TFileStream;
  B: TMemoryStream;
begin
  F:= nil;
  B:= nil;
  try
    F:= TFileStream.Create(Filename, fmCreate);
    case Format of
      mfResource:
        F.WriteComponentRes(AComponent.Name, AComponent);

      mfText, mfXml:
        SaveComponentToStream(AComponent, F, Format);
    end;

  finally
    F.Free;
  end;
end;

procedure SaveMenuToFile(const AComponent: TComponent; const Filename: String);
var
  E: String;
  F: Integer;
begin
  F:= mfResource;
  E:= LowerCase(ExtractFileExt(Filename));
  if E = 'txt' then F:= mfText;
  if E = 'xml' then F:= mfXML;
  SaveMenuToFileFormat(AComponent, Filename, F);
end;

procedure LoadMenuFromFile(const AComponent: TComponent; const Filename: String);
var
  E: String;
  F: Integer;
begin
  F:= mfResource;
  E:= LowerCase(ExtractFileExt(Filename));
  if E = 'txt' then F:= mfText;
  if E = 'xml' then F:= mfXML;
  LoadMenuFromFileFormat(AComponent, Filename, F);
end;


procedure LoadMenuFromRegistry(const AComponent: TComponent);
var
  R: TRegistry;
  S: TStringStream;
begin
  // doesn't work with dynamically-created menus
  if (AComponent = nil)
  or (AComponent.Name = '')
  then Exit;

  if AComponent is TMenu
  then ClearItems(TMenu(AComponent).Items);
  
  // init registry
  R:= TRegistry.Create;
  R.OpenKey(MenuOrderRegistry, True);

  try
    S:= TStringStream.Create(R.ReadString(AComponent.Name));

    if S.Size > 0
    then ReadComponentFromStream(AComponent, S, mfXml);

  finally
    S.Free;
  end;

  R.Free;
end;

procedure SaveMenuToRegistry(const AComponent: TComponent);
var
  R: TRegistry;
  S: TStringStream;
begin
  if (AComponent = nil)
  or (AComponent.Name = '')
  then Exit;

  R:= TRegistry.Create;
  R.OpenKey(MenuOrderRegistry, True);

  // store menu
  try
    S:= TStringStream.Create('');
    SaveComponentToStream(AComponent, S, mfXml);
    R.WriteString(AComponent.Name, S.DataString);
  finally
    S.Free;
  end;

  R.Free;
end;

procedure SaveMenuToString(const AComponent: TComponent; var ABuffer: String);
var
  S: TStringStream;
begin
  if (AComponent = nil)
  then Exit;

  // store menu
  try
    S:= TStringStream.Create('');
    SaveComponentToStream(AComponent, S, mfXml);
    ABuffer:= S.DataString;
  finally
    S.Free;
  end;
end;

procedure LoadMenuFromString(const AComponent: TComponent; const ABuffer: String);
var
  S: TStringStream;
begin
  if (AComponent = nil)
  then Exit;

  if AComponent is TMenu
  then ClearItems(TMenu(AComponent).Items);
  
  // load menu
  try
    S:= TStringStream.Create(ABuffer);
    
    if S.Size > 0
    then ReadComponentFromStream(AComponent, S, mfXml);
  finally
    S.Free;
  end;
end;


procedure SaveMenuItem(const Item: TMenuItem);
begin
  if not (Item is TMenuItem2000)
  then raise Exception.Create(SOnlyTMenuItem2000CanBeStored);

  if MenuWhereToSave <> msDontSave
  then SaveMenu(TMenuItem2000(Item).GetMenu);
end;



procedure SetInsertBeforeItem(const AInsertBeforeItem: TMenuItem);
var
  F: TForm;
begin
  if InsertBeforeItem <> nil
  then LastInsertBeforeItem:= InsertBeforeItem;

  InsertBeforeItem:= AInsertBeforeItem;

{  // force cm_MouseLeave
  if (ActivePopupMenu <> nil)
  and ((LastInsertBeforeItem <> nil)
  and (LastInsertBeforeItem <> miInsertAtTheEnd)
  and (LastInsertBeforeItem <> miNothingToInsert)
  and ((InsertBeforeItem = nil)
  or (InsertBeforeItem = miInsertAtTheEnd)
  or (InsertBeforeItem = miNothingToInsert)
  or (InsertBeforeItem.Parent <> LastInsertBeforeItem.Parent)))
  then begin
    F:= TForm(TCustomPopupMenu2000(ActivePopupMenu).Form.Perform(wm_GetForm,
      Integer(LastInsertBeforeItem), 0));

    if F <> nil
    then F.Perform(cm_MouseLeave, 0, 0);
  end;}
end;

function IsCustomization(const ACustomizable: Boolean): Boolean;
begin
  Result:=
    EnableCustomization
    and ACustomizable
    and (GetAsyncKeyState(vk_LButton) and $FFFF0000 <> 0)
    and (ActiveMenuItem <> nil);
end;

procedure EndCustomization(AcceptMove: Boolean);
var
  MI: TMenuItem;
  I: Integer;
begin
  if (ActiveMenuItem is TMenuItem2000)
  and Assigned(TMenuItem2000(ActiveMenuItem).OnEndDrag)
  then TMenuItem2000(ActiveMenuItem).OnEndDrag(ActiveMenuItem, AcceptMove);

  try
    // clear drag window
    if ActiveDragWindow <> nil
    then ActiveDragWindow.Release;

    if AcceptMove
    and (ActiveMenuItem <> nil)
    and (InsertBeforeItem <> miNothingToInsert)
    then begin
      // check for inheretance
      if InsertBeforeItem <> miInsertAtTheEnd
      then begin
        MI:= InsertBeforeItem;
        while (MI <> nil)
        do begin
          if MI.Parent = ActiveMenuItem
          then raise EMenuError.Create(SCannotMoveItem);

          MI:= MI.Parent;
        end;
      end;

      // check for moving into different submenu
      if (InsertBeforeItem <> miNothingToInsert)
      and (InsertBeforeParent <> nil)
      and (ActiveMenuItem.Parent <> InsertBeforeParent)
      then begin
        if ActiveMenuItem.Parent <> nil
        then ActiveMenuItem.Parent.Remove(ActiveMenuItem);
        if InsertBeforeParent <> nil
        then InsertBeforeParent.Add(ActiveMenuItem);
      end;

      if (InsertBeforeItem <> miInsertAtTheEnd)
      and (InsertBeforeItem <> nil)
      then
        if ActiveMenuItem.MenuIndex < InsertBeforeItem.MenuIndex
        then
          ActiveMenuItem.MenuIndex:= InsertBeforeItem.MenuIndex -1
        else
          ActiveMenuItem.MenuIndex:= InsertBeforeItem.MenuIndex
      else
        ActiveMenuItem.MenuIndex:= MaxInt;

      if not (csDesigning in ActiveMenuItem.ComponentState)
      then SaveMenuItem(ActiveMenuItem);

      if MenuDesigner <> nil
      then MenuDesigner.Perform(wm_RefreshMenu, 0, Integer(ActiveMenuItem));
    end;

  finally
    ActiveMenuItem:= nil;
    InsertBeforeItem:= miNothingToInsert;
    LastInsertBeforeItem:= nil;
    InsertBeforeParent:= nil;

    RestoreCursorDefault(crNone);

    if ActiveMenuBarList <> nil
    then
      for I:= 0 to ActiveMenuBarList.Count -1
      do
        with TCustomMenuBar2000(ActiveMenuBarList[I])
        do begin
          Perform(wm_SetState, ssFraming, 0);
          Refresh;
        end;

    if ActivePopupMenu is TCustomPopupMenu2000
    then
      with TCustomPopupMenu2000(ActivePopupMenu), Form
      do begin
        Perform(wm_SetState, ssFraming, 0);

        if not AcceptMove
        then Perform(wm_SetState, ssIgnoreMouseUp, 1);
        
        Refresh;
      end;

    if FormDesigner <> nil
    then FormDesigner.Modified;
  end;
end;


function IsGradientCaptions: Boolean;
const
  spi_GetGradientCaptions = $1008;
var
  S: Bool;
begin  
  if SystemParametersInfo(spi_GetGradientCaptions, 0, @S, 0)
  then Result:= S
  else Result:= False;
end;

procedure ClearBitmap(Bitmap: TBitmap);
begin
  if Bitmap <> nil
  then Bitmap.Handle:= 0;
end;

procedure SetTimer(AInterval: Cardinal; AOnTimer: TNotifyEvent);
begin
  if TimeoutTimer = nil
  then TimeoutTimer:= TTimer.Create(nil)
  else TimeoutTimer.Enabled:= False;

  TimeoutTimer.Interval:= AInterval;
  TimeoutTimer.OnTimer:= AOnTimer;
  TimeoutTimer.Enabled:= True;
end;

procedure StopTimer;
begin
  if TimeoutTimer <> nil
  then TimeoutTimer.Enabled:= False;
end;

procedure RestartTimer;
begin
  if TimeoutTimer <> nil
  then begin
    TimeoutTimer.Enabled:= False;
    TimeoutTimer.Enabled:= True;
  end;
end;

function IsTimerSet(AInterval: Cardinal; AOnTimer: TNotifyEvent): Boolean;
begin
  Result:= (TimeoutTimer <> nil)
    and (TimeoutTimer.Enabled)
    and (TimeoutTimer.Interval = AInterval)
    and (@TimeoutTimer.OnTimer = @AOnTimer);
end;

procedure FreeFloatingMenusList;
begin
  while FloatingMenusList.Count > 0
  do TForm(FloatingMenusList[0]).Free;

  FloatingMenusList.Free;
  FloatingMenusList:= nil;
end;

procedure FreeMemAndNil(var P);
begin
  try
    if Pointer(P) <> nil
    then FreeMem(Pointer(P));
  except
  end;
  Pointer(P):= nil;
end;

procedure ReGetMem(var P; const Size: Integer);
begin
  if Pointer(P) <> nil then FreeMem(Pointer(P));
  GetMem(Pointer(P), Size);
end;

procedure BuildOpacityData(const AOpacity: T_AM2000_Opacity; var AOpacityData: P_AM2000_OpacityData);
var
  X, Y: Integer;
begin
  if AOpacity = 100
  then begin
    FreeMemAndNil(AOpacityData);
    Exit;
  end;

  if AOpacityData = nil
  then GetMem(AOpacityData, SizeOf(T_AM2000_OpacityData));

  for X:= 0 to 255 do
    for Y:= 0 to 255 do
      AOpacityData[X, Y]:= Round((Y * 100 + (X - Y) * AOpacity) / 100);
end;

procedure ProcessOpacityData(ImageTop, ImageBottom, ImageResult, ImageResultLast: PByteArray;
  const OpacityData: P_AM2000_OpacityData);
// thanks to ... for this routine
asm
	push esi
	push edi
	mov esi,[ImageResultLast] // IndexLimit
	mov edi,ecx  // ImageResult
	push ebx
	sub edi,esi  // ecx = i
	jz @E1
	sub eax,edi  // ImageTop
	sub edx,edi  // ImageBottom

@L1:
	xor ecx,ecx
	xor ebx,ebx
	mov cl,byte ptr [eax+edi]
	mov bl,byte ptr [edx+edi]
	shl ecx,8
  add ebx,[OpacityData]
	mov bl,byte ptr [ecx+ebx]
	mov [esi+edi],bl
	inc edi
	jnz @L1
@E1:
	pop ebx
	pop edi
	pop esi
end;

function GetSoftColor(C1, C2: TColor; const K: Real): TColor;
var
  R, G, B: Byte;
begin
  C1:= ColorToRgb(C1);
  C2:= ColorToRgb(C2);

  R:= GetRValue(C1);
  G:= GetGValue(C1);
  B:= GetBValue(C1);

  try
    Result:= Rgb(
      R + Round((GetRValue(C2) - R) / K),
      G + Round((GetGValue(C2) - G) / K),
      B + Round((GetBValue(C2) - B) / K));
  except
    Result:= C1;
  end;
end;

procedure LockGlobalRepaint;
begin
  Inc(GlobalRepaintLockCount);
end;

procedure UnlockGlobalRepaint;
begin
  if GlobalRepaintLockCount > 0
  then begin
    Dec(GlobalRepaintLockCount);

  if (GlobalRepaintLockCount = 0)
  and (GlobalRepaintFlag)
  then GlobalRepaint;
  end;
end;

procedure GlobalRepaint;
var
  I: Integer;
begin
  GlobalRepaintFlag:= True;

  if (GlobalRepaintLockCount > 0)
  then Exit;

  if ActivePopupMenu <> nil
  then TCustomPopupMenu2000(ActivePopupMenu).Refresh;

  for I:= 0 to ActiveMenuBarList.Count -1
  do TCustomMenuBar2000(ActiveMenuBarList[I]).Refresh;

  for I:= 0 to FloatingMenusList.Count -1
  do TForm(FloatingMenusList[I]).Repaint;

  GlobalRepaintFlag:= False;
end;

function IsSeparatorItem(const Item: TMenuItem): Boolean;
var
  S: String;
begin
  if Item = nil
  then begin
    Result:= False;
    Exit;
  end;

  if Item is TMenuItem2000
  then S:= TMenuItem2000(Item).Caption
  else S:= Item.Caption;

  Result:= IsSeparatorCaption(S);
end;

function IsSeparatorCaption(const ACaption: String): Boolean;
begin
  Result:= (ACaption <> '')
    and ((ACaption[1] = sSeparator)
    or (ACaption[1] = sDoubleSeparator)
    or (ACaption[1] = sDottedSeparator)
    or (ACaption[1] = sDoubleDottedSeparator)
    or (ACaption[1] = sEmptySeparator));
end;

function IsEnabled(const Item: TMenuItem): Boolean;
begin
  if Item <> nil
  then
    if Item is TMenuItem2000
    then Result:= TMenuItem2000(Item).Enabled
    else Result:= Item.Enabled
  else
    Result:= False;
end;

function IsVisible(const Item: TMenuItem): Boolean;
begin
  if Item <> nil
  then
    if Item is TMenuItem2000
    then Result:= TMenuItem2000(Item).Visible
    else Result:= Item.Visible
  else
    Result:= False;
end;

{function IsChecked(const Item: TMenuItem): Boolean;
begin
  if Item <> nil
  then
    if Item is TMenuItem2000
    then Result:= TMenuItem2000(Item).Checked
    else Result:= Item.Checked
  else
    Result:= False;
end;}

function GetCount(const Item: TMenuItem): Integer;
begin
  if (Item <> nil)
  and not (csDestroying in Item.ComponentState)
  then
    if Item is TMenuItem2000
    then
      if TMenuItem2000(Item).AttachMenu <> nil
      then Result:= GetCount(TMenuItem2000(Item).AttachMenu.Items)
      else Result:= TMenuItem2000(Item).Count

    else Result:= Item.Count
  else
    Result:= 0;
end;

function GetCaption(const Item: TMenuItem): String;
begin
  if Item <> nil
  then
    if Item is TMenuItem2000
    then Result:= TMenuItem2000(Item).Caption
    else Result:= Item.Caption
  else
    Result:= '';
end;

{ Adapted versions of Delphi's ObjectBinaryToText and ObjectTextToBinary }

procedure ObjectBinaryToXml(Input, Output: TStream);
{$IFNDEF Delphi4OrHigher}
begin
end;
{$ELSE}
var
  NestingLevel: Integer;
  SaveSeparator: Char;
  Reader: TReader;
  Writer: TWriter;
  ObjectName, PropName, TagName: string;

  procedure WriteIndent;
  const
    Blanks: array[0..1] of Char = '  ';
  var
    I: Integer;
  begin
    for I:= 1 to NestingLevel do Writer.Write(Blanks, SizeOf(Blanks));
  end;

  procedure WriteStr(const S: string);
  begin
    Writer.Write(S[1], Length(S));
  end;

  procedure NewLine;
  begin
    WriteStr(#13#10);
    WriteIndent;
  end;

  procedure ConvertValue; forward;

  procedure ConvertHeader;
  var
    ClassName: string;
    Flags: TFilerFlags;
    Position: Integer;
  begin
    Reader.ReadPrefix(Flags, Position);
    ClassName:= Reader.ReadStr;
    ObjectName:= Reader.ReadStr;
    WriteIndent;
    if ffInherited in Flags
    then TagName:= 'inherited'
{$IFDEF Delphi5OrHigher}
    else
    if ffInline in Flags
    then TagName:= 'inline'
{$ENDIF}    
    else TagName:= 'object';

    WriteStr('<' + TagName);

    if ObjectName <> ''
    then WriteStr(' name="' + ObjectName + '"');

    WriteStr(' type="' + ClassName + '"');

    if ffChildPos in Flags
    then WriteStr(' position="' + IntToStr(Position) + '"');

    WriteStr('>');

    if ObjectName = ''
    then ObjectName:= ClassName;

    WriteStr(#13#10);
  end;

  procedure ConvertBinary;
  const
    BytesPerLine = 32;
  var
    MultiLine: Boolean;
    I: Integer;
    Count: Longint;
    Buffer: array[0..BytesPerLine - 1] of Char;
    Text: array[0..BytesPerLine * 2 - 1] of Char;
  begin
    Reader.ReadValue;

    Inc(NestingLevel);
    Reader.Read(Count, SizeOf(Count));
    MultiLine:= Count >= BytesPerLine;
    while Count > 0
    do begin
      if MultiLine then NewLine;
      if Count >= 32 then I:= 32 else I:= Count;
      Reader.Read(Buffer, I);
      BinToHex(Buffer, Text, I);
      Writer.Write(Text, I * 2);
      Dec(Count, I);
    end;
    Dec(NestingLevel);
    if MultiLine then NewLine;
  end;

  procedure ConvertProperty; forward;

  procedure ConvertValue;
  const
    LineLength = 64;
  var
    I, K, L: Integer;
    S: string;
  begin
    case Reader.NextValue of
      vaInt8, vaInt16, vaInt32:
        WriteStr('integer">' + IntToStr(Reader.ReadInteger));

{$IFDEF Delphi5OrHigher}
      vaInt64:
        WriteStr('integer">' + IntToStr(Reader.ReadInt64));
{$ENDIF}

      vaDate:
        WriteStr('date">' + FloatToStr(Reader.ReadDate));

      vaString, vaLString, vaWString
{$IFDEF Delphi6OrHigher}
      , vaUTF8String
{$ENDIF}      
      :
        begin
          WriteStr('string">');
          S:= StringReplace(StringReplace(StringReplace(StringReplace(Reader.ReadString,
            '&', '&amp;', [rfReplaceAll]),
            #1, '&#160;', [rfReplaceAll]),
            '<', '&lt;', [rfReplaceAll]),
            '>', '&gt;', [rfReplaceAll]);

          L:= Length(S);
          if L <= LineLength
          then begin
            WriteStr(S);
          end
          else begin
            Inc(NestingLevel);
            try
              K:= 1;
              while K < L
              do begin
                I:= K + LineLength;

                NewLine;

                if I > L
                then I:= L
                else begin
                  // find space
                  while (I > K) and (S[I] <> ' ')
                  do Dec(I);

                  if I = K
                  then begin
                    I:= K + LineLength;
                    while (I < L) and (S[I] <> ' ')
                    do Inc(I);
                  end;
                end;

                Writer.Write(S[K], I - K);
                K:= I +1;
              end;
            finally
              Dec(NestingLevel);
              NewLine;
            end;
          end;
        end;

      vaIdent, vaFalse, vaTrue, vaNil {$IFDEF Delphi5OrHigher}, vaNull{$ENDIF}:
        WriteStr('identifier">' + Reader.ReadIdent);

      vaBinary:
        begin
          WriteStr('binary">');
          ConvertBinary;
        end;

      vaSet:
        begin
          WriteStr('set">');
          Reader.ReadValue;

          Inc(NestingLevel);

          while True do
          begin
            S:= Reader.ReadStr;
            if S = '' then Break;
            NewLine;
            WriteStr('<value>' + S + '</value>');
          end;

          Dec(NestingLevel);
          NewLine;
        end;

      vaList:
        begin
          WriteStr('list">');
          Reader.ReadValue;

          Inc(NestingLevel);
          while not Reader.EndOfList
          do begin
            NewLine;
            WriteStr('<item type="');
            ConvertValue;
            WriteStr('</item>');
          end;
          Reader.ReadListEnd;
          Dec(NestingLevel);
          NewLine;
        end;

    else
      raise EReadError.CreateFmt(sPropertyException,
        [ObjectName, '.', PropName, Ord(Reader.NextValue)]);
    end;
  end;

  procedure ConvertProperty;
  var
    P: String;
  begin
    WriteIndent;
    PropName:= Reader.ReadStr;  // save for error reporting
    P:= LowerCase(StringReplace(PropName, '.', '-', [rfReplaceAll]));
    WriteStr('<' + P + ' type="');
    ConvertValue;
    WriteStr('</' + P + '>'#13#10);
  end;

  procedure ConvertObject;
  begin
    ConvertHeader;
    Inc(NestingLevel);
    while not Reader.EndOfList do ConvertProperty;
    Reader.ReadListEnd;
    while not Reader.EndOfList do ConvertObject;
    Reader.ReadListEnd;
    Dec(NestingLevel);
    WriteIndent;
    WriteStr('</object>'#13#10);
  end;

begin
  NestingLevel:= 0;
  Reader:= TReader.Create(Input, 4096);
  SaveSeparator:= DecimalSeparator;
  DecimalSeparator:= '.';
  try
    Writer:= TWriter.Create(Output, 4096);
    try
      Reader.ReadSignature;

      WriteStr('<?xml version="1.0" encoding="UTF-8"?>'#13#10);
      WriteStr('<!-- Created with Animated Menus XP (http://www.animatedmenus.com/) -->'#13#10);
      ConvertObject;
    finally
      Writer.Free;
    end;
  finally
    DecimalSeparator:= SaveSeparator;
    Reader.Free;
  end;
end;

type
  TMyWriter = class(TWriter);

  TMyParser = class(TParser)
  public
    function ReadTokenString: String;
    function NextToken: Char;
    procedure HexToBinary(Stream: TStream);

  end;

  TFalseParser = class(TObject)
  private
    FStream: TStream;
    FOrigin: Longint;
    FBuffer: PChar;
    FBufPtr: PChar;
    FBufEnd: PChar;
    FSourcePtr: PChar;
    FSourceEnd: PChar;
    FTokenPtr: PChar;
    FStringPtr: PChar;
    FSourceLine: Integer;
    FSaveChar: Char;
    FToken: Char;
    FFloatType: Char;
    FWideStr: WideString;
  end;

function TMyParser.ReadTokenString: String;
var
  P: PChar;
begin
  with TFalseParser(Self)
  do begin
    P:= FSourcePtr;
    while not (P^ in [#0, #10, #13, '<', '>'])
    do Inc(P);

    SetString(Result, FTokenPtr, P - FTokenPtr);

    FSourcePtr:= P;
    FToken:= toSymbol;
  end;
end;

function TMyParser.NextToken: Char;
var
  P: PChar;
begin
  P:= TFalseParser(Self).FSourcePtr;
  TFalseParser(Self).FTokenPtr:= P;
  if P^ in ['&', '''', 'A'..'Z', '_', 'a'..'z']
  then begin
    Inc(P);
    while not (P^ in [#0, #10, #13, ' ', '<', '>', '"']) do Inc(P);
    Result:= toSymbol;

    TFalseParser(Self).FSourcePtr:= P;
    TFalseParser(Self).FToken:= Result;
  end
  else
    Result:= inherited NextToken;

end;

procedure TMyParser.HexToBinary(Stream: TStream);
var
  Count: Integer;
  Buffer: array[0..255] of Char;
  P: PChar;
begin
  P:= TFalseParser(Self).FTokenPtr;

  while P[0] <> '<' do
  begin
    Count:= HexToBin(P, Buffer, SizeOf(Buffer));
    if Count = 0
    then Error('Invalid binary value');
    Stream.Write(Buffer, Count);
    Inc(P, Count * 2);
    TFalseParser(Self).FSourcePtr:= P;

    NextToken;
    P:= TFalseParser(Self).FTokenPtr;
  end;
end;
{$ENDIF}


procedure ObjectXmlToBinary(Input, Output: TStream);
{$IFNDEF Delphi4OrHigher}
begin
end;
{$ELSE}
var
  SaveSeparator: Char;
  Parser: TMyParser;
  Writer: TMyWriter;

  function ParserSeekForTokenAfter(const C: Char): Boolean;
  begin
    while Parser.NextToken <> C do;
    Result:= (Parser.Token = C);
    Parser.NextToken;
  end;

  procedure ParserCheckNext(const C: Char);
  begin
    Parser.NextToken;
    Parser.CheckToken(C);
  end;

  procedure ConvertHeader(IsInherited, IsInline: Boolean);
  var
    ClassName, ObjectName: string;
    Flags: TFilerFlags;
  begin
    ObjectName:= '';

    while True
    do
      if Parser.TokenSymbolIs('NAME')
      then begin
        ParserCheckNext('='); // must be '='
        ParserCheckNext('"'); // '"'
        ParserCheckNext(toSymbol); // type name
        ClassName:= Parser.TokenString;
        ParserCheckNext('"'); // '"'
        Parser.NextToken; // next token
      end

      else
      if Parser.TokenSymbolIs('TYPE')
      then begin
        ParserCheckNext('='); // must be '='
        ParserCheckNext('"'); // '"'
        ParserCheckNext(toSymbol); // type name
        ObjectName:= ClassName;
        ClassName:= Parser.TokenString;
        ParserCheckNext('"'); // '"'
        Parser.NextToken; // next token
      end

      else
      if Parser.Token = '>'
      then Break;


    Parser.NextToken;
    Flags:= [];

    if IsInherited
    then Include(Flags, ffInherited);

{$IFDEF Delphi5OrHigher}
    if IsInline
    then Include(Flags, ffInline);
{$ENDIF}

    Writer.WritePrefix(Flags, -1);
    Writer.WriteStr(ClassName);
    Writer.WriteStr(ObjectName);
  end;

  procedure ConvertProperty; forward;

  procedure ConvertValue;
  var
    TokenType: String;

    function CombineString: String;
    begin
      Result:= Parser.ReadTokenString;

      while Parser.NextToken <> '<'
      do Result:= Result + ' ' + Parser.ReadTokenString;

      Result:= StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(
        Result,
          '&#160;', #1, [rfReplaceAll]),
          '&amp;', '&', [rfReplaceAll]),
          '& amp;', '&', [rfReplaceAll]),
          '&lt;', '<', [rfReplaceAll]),
          '&gt;', '>', [rfReplaceAll]);
    end;

  begin
    TokenType:= UpperCase(Parser.TokenString);
    ParserSeekForTokenAfter('>');

    if TokenType = 'STRING'
{$IFDEF Delphi6OrHigher}
    then Writer.WriteWideString(CombineString)
{$ELSE}
    then Writer.WriteString(CombineString)
{$ENDIF}

    else
    if TokenType = 'IDENTIFIER'
    then Writer.WriteIdent(Parser.TokenComponentIdent)

    else
    if TokenType = 'INTEGER'
    then Writer.WriteInteger(Parser.TokenInt)

    else
    if TokenType = 'FLOAT'
    then
      case Parser.FloatType of
        's', 'S': Writer.WriteSingle(Parser.TokenFloat);
        'c', 'C': Writer.WriteCurrency(Parser.TokenFloat / 10000);
        'd', 'D': Writer.WriteDate(Parser.TokenFloat);
      else
        Writer.WriteFloat(Parser.TokenFloat);
      end

    else
    if TokenType = 'SET'
    then begin // set!!!
      Writer.WriteValue(vaSet);
      Parser.CheckToken('<');
      Parser.NextToken;

      while Parser.TokenSymbolIs('VALUE')
      do begin
        ParserCheckNext('>');
        ParserCheckNext(toSymbol); // value
        Writer.WriteStr(Parser.TokenString);
        ParserSeekForTokenAfter('>');
        Parser.CheckToken('<');
        Parser.NextToken;
      end;

      Writer.WriteStr('');
      ParserSeekForTokenAfter('>');
      Exit;
    end

    else
    if TokenType = 'BINARY'
    then Writer.WriteBinary(Parser.HexToBinary)

    else
    if TokenType = 'LIST'
    then begin
      Parser.CheckToken('<');
      Parser.NextToken; // ITEM

      Writer.WriteListBegin;

      while Parser.TokenSymbolIs('ITEM')
      do begin
        ParserCheckNext(toSymbol); // TYPE
        Parser.CheckTokenSymbol('TYPE');
        ParserCheckNext('=');
        ParserCheckNext('"');
        ParserCheckNext(toSymbol); // type

        ConvertValue;

        Parser.CheckToken('<');
        Parser.NextToken; // ITEM or / (end of list)
      end;

      Writer.WriteListEnd;
      ParserSeekForTokenAfter('>');
      Exit;
    end

    else
      Parser.Error('Invalid property value');

    if Parser.Token <> '<'
    then ParserCheckNext('<');

    ParserSeekForTokenAfter('>');
  end;

  procedure ConvertProperty;
  var
    PropName: string;
  begin
    Parser.CheckToken(toSymbol);
    PropName:= StringReplace(Parser.TokenString, '-', '.', [rfReplaceAll]);
    Parser.NextToken;

    Writer.WriteStr(PropName);
    
    Parser.CheckTokenSymbol('TYPE');
    ParserCheckNext('=');
    ParserCheckNext('"');
    Parser.NextToken;
    ConvertValue;
  end;

  procedure ConvertObject;
  var
    InheritedObject: Boolean;
    InlineObject: Boolean;
  begin
    if Parser.Token = toEOF
    then Exit;

    InheritedObject:= False;
    InlineObject:= False;

    if Parser.Token = '<'
    then Parser.NextToken;

    if Parser.TokenSymbolIs('INHERITED')
    then InheritedObject:= True

    else
    if Parser.TokenSymbolIs('INLINE')
    then InlineObject:= True
    else Parser.CheckTokenSymbol('OBJECT');

    Parser.NextToken;
    
    ConvertHeader(InheritedObject, InlineObject);
    
    while not ((Parser.Token = '<')
    and ((Parser.NextToken = '/')
    or Parser.TokenSymbolIs('OBJECT')
    or Parser.TokenSymbolIs('INHERITED')
    or Parser.TokenSymbolIs('INLINE')))
    do ConvertProperty;

    Writer.WriteListEnd;

    while (Parser.Token <> '/')
    do ConvertObject;
    
    Writer.WriteListEnd;

    ParserSeekForTokenAfter('>');

    if Parser.Token = '<'
    then Parser.NextToken;
  end;

begin
  Parser:= TMyParser.Create(Input);

  // xml header and comments
  while True
  do
    if (Parser.Token = '<')
    and ((Parser.NextToken = '?') or (Parser.Token = '!'))
    then ParserSeekForTokenAfter('>')
    else Break;

  SaveSeparator := DecimalSeparator;
  DecimalSeparator := '.';
  try
    Writer:= TMyWriter.Create(Output, 4096);
    try
      Writer.WriteSignature;
      ConvertObject;
    finally
      Writer.Free;
    end;
  finally
    DecimalSeparator := SaveSeparator;
    Parser.Free;
  end;
end;
{$ENDIF}

procedure ResetUsageData(const Item: TMenuItem; const ABuffer: String);
var
  I: Integer;
  P, PHidden, PObject, PObjectEnd: Pchar;
begin
  if Item.Name <> ''
  then begin
    P:= StrPos(PChar(ABuffer), PChar('name="' + Item.Name + '"'));

    if P <> nil
    then begin
      PHidden:= StrPos(P, '<hidden');
      PObject:= StrPos(P, '<object');
      PObjectEnd:= StrPos(P, '</object');

      TMenuItem2000(Item).Hidden:= (PHidden <> nil)
        and ((PObject = nil) or (Integer(PHidden) < Integer(PObject)))
        and ((PObjectEnd = nil) or (Integer(PHidden) < Integer(PObjectEnd)));
    end;
  end;
  
  for I:= 0 to Item.Count -1
  do ResetUsageData(Item[I], ABuffer);
end;

{ CopyMenuProperties }

procedure CopyMenuProperties(const Source, Dest: TMenu);
{$IFNDEF Delphi4OrHigher}
var
  Images: TCustomImageList;
  BiDiMode: TBiDiMode;
{$ENDIF}
begin
{$IFDEF Delphi5OrHigher}
  Dest.AutoHotkeys:= Source.AutoHotkeys;
  Dest.AutoLineReduction:= Source.AutoLineReduction;
{$ENDIF}

{$IFDEF Delphi4OrHigher}
  Dest.Images:= Source.Images;
  Dest.BiDiMode:= Source.BiDiMode;
  Dest.OwnerDraw:= Source.OwnerDraw;
  Dest.ParentBiDiMode:= Source.ParentBiDiMode;
{$ELSE}
  if Source is TCustomMainMenu2000
  then begin
    Images:= TCustomMainMenu2000(Source).Images;
    BiDiMode:= TCustomMainMenu2000(Source).BiDiMode;
  end
  else
  if Source is TCustomPopupMenu2000
  then begin
    Images:= TCustomPopupMenu2000(Source).Images;
    BiDiMode:= TCustomPopupMenu2000(Source).BiDiMode;
  end
  else begin
    Images:= nil;
    BiDiMode:= bdLeftToRight;
  end;


  if Dest is TCustomMainMenu2000
  then begin
    TCustomMainMenu2000(Dest).Images:= Images;
    TCustomMainMenu2000(Dest).BiDiMode:= BiDiMode;
  end
  else
  if Dest is TCustomPopupMenu2000
  then begin
    TCustomPopupMenu2000(Dest).Images:= Images;
    TCustomPopupMenu2000(Dest).BiDiMode:= BiDiMode;
  end;
{$ENDIF}

  Dest.WindowHandle:= Source.WindowHandle;
end;

procedure CopyList(const Source, Dest: TList);
{$IFNDEF Delphi6OrHigher}
var
  I: Integer;
{$ENDIF}
begin
  Dest.Clear;
{$IFDEF Delphi6OrHigher}
  Dest.Assign(Source);
{$ELSE}
  for I:= 0 to Source.Count -1
  do Dest.Add(Source[I]);
{$ENDIF}
end;



procedure RestoreCursorDefault(const ACursor: TCursor);
begin
  if (ACursor = crNone)
  or (Screen.Cursor = ACursor)
  then Screen.Cursor:= CursorDefault;
end;

procedure SetCursor(const ACursor: TCursor);
begin
  if Screen.Cursor <> ACursor
  then begin
    CursorDefault:= Screen.Cursor;
    Screen.Cursor:= ACursor;
  end;
end;

function PointInRect(const R: TRect; const P: TPoint): Boolean;
begin
  Result:= (P.X >= R.Left)
    and (P.X <= R.Right)
    and (P.Y >= R.Top)
    and (P.Y <= R.Bottom);
end;

function IsChildMaximizedAndSystemMenu(const F: TCustomForm): Boolean;
begin
  Result:= (F <> nil)
    and (TForm(F).FormStyle = fsMdiForm)
    and (TForm(F).ActiveMdiChild <> nil)
    and (TForm(F).ActiveMdiChild.WindowState = wsMaximized)
    and (biSystemMenu in TForm(F).ActiveMdiChild.BorderIcons);
end;



initialization
  // active menu2000 list for multiforms
  FloatingMenusList:= TList.Create;

  // list of active menu bars
  ActiveMenuBarList:= TList.Create;

  // structure for quering menus
  mii.cbSize:= 44;
  NonClientMetrics.cbSize:= sizeof(NonClientMetrics);
  SystemParametersInfo(spi_GetNonClientMetrics, 0, @NonClientMetrics, 0);

  // load bitmaps & cursors
  bmpRadioItem:= LoadBitmap(HInstance, 'AM2000_SYSTEMRADIOITEM');
  bmpCheckMark:= LoadBitmap(HInstance, 'AM2000_SYSTEMCHECKMARK');

  // open registry
{$IFNDEF DesignTime}
  InitializePath(MenuOrderRegistry, MenuDataFile);
  OpenRegistry;
{$ENDIF}  

  if MenuSoundResource
  then PlaySound(nil, HInstance, snd_Resource + snd_NoDefault + snd_NoStop)
  else sndPlaySound(nil, snd_NoDefault + snd_NoStop);

  hUser32:= LoadLibrary(user32);

  if hUser32 <> 0
  then begin
    pSetLayeredWindowAttributes:= GetProcAddress(hUser32, 'SetLayeredWindowAttributes');
    pUpdateLayeredWindow:= GetProcAddress(hUser32, 'UpdateLayeredWindow');
  end;
  

finalization

  // free floating list
  if FloatingMenusList <> nil
  then FreeFloatingMenusList;

  ActiveMenuBarList.Free;
  ActiveMenuBarList:= nil;

  DeleteObject(bmpCheckMark);
  DeleteObject(bmpRadioItem);

{$IFNDEF DesignTime}
  CloseRegistry;
{$ENDIF}

  if TimeoutTimer <> nil
  then TimeoutTimer.Free;

  if hUser32 <> 0
  then FreeLibrary(hUser32);

  
end.
