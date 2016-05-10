
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       TMenuBar2000                                    }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit am2000menubar;

{$I am2000.inc}

interface

uses
  {$IFDEF ACTIVEX}AnimatedMenusXP_tlb,{$ENDIF}
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms, Dialogs,
  Menus, ComCtrls, ExtCtrls,
  am2000options, am2000popupmenu, am2000hintwindow, am2000utils,
  am2000dropshadow;

type
  T_AM2000_MenuBarPopupEvent = procedure (Sender: TObject; const AnItems: TMenuItem;
    const AnMenuHandle: HMenu) of object;

  T_AM2000_aiState = (aiFlat, aiRaised, aiSunken, aiFraming, aiDesigning);

  T_AM2000_SystemButton = (sbNone, sbMinimize, sbRestore, sbClose);
  T_AM2000_SystemButtonDrawState = (bsDefault, bsRaised, bsSunken, bsDisabled);

  T_AM2000_NextMenuItemParam = (niBackward, niIgnoreInvisible, niStopOnLimit, niIgnoreAnimation);
  T_AM2000_NextMenuItemParams = set of T_AM2000_NextMenuItemParam;

  T_AM2000_mbType = (mbHorizontal, mbVertical, mbFloating);

  T_AM2000_Side = (sdTop, sdBottom, sdLeft, sdRight);

  // menu bar state
  T_AM2000_mbs = (mbsBuffer, mbsIgnoreOnMouseUp, mbsDisableAltKeyUp, mbsWindowActive,
    mbsKeepSelected, mbsShowAccelerators, mbsIgnorePaint, mbsIgnoreAnimation,
    mbsIgnoreSysKeyUp, mbsIgnoreActivateMenuBar, mbsRepaintOnMouseMove, mbsDisabled,
    mbsPreview, mbsIgnorePreview, mbsSibling);
  T_AM2000_MenuBarState = set of T_AM2000_mbs;

  P_AM2000_MenuBarItemRect = ^T_AM2000_MenuBarItemRect;
  PMenuItemRect = P_AM2000_MenuBarItemRect;
  T_AM2000_MenuBarItemRect = record
    mi: TMenuItem;
    iR: TRect;
  end;



  T_AM2000_RaisedItemForm = class;


  TCustomMenuBar2000 = class(TCustomControl)
  private
    LastChild: TForm;
    FMenu: TMenu;
    Buffer, Back: TBitmap;
    mbState: T_AM2000_MenuBarState;
    FLocalOptions, FDefaultOptions: T_AM2000_MenuOptions;
    FMenuComponent: TCustomPopupMenu2000;
    ToolTipWindow: T_AM2000_ToolTipWindow;

    ai: TMenuItem;
    aiIndex: Integer;
    SystemButtonPressed, MouseOverSystemButton: T_AM2000_SystemButton;
    SystemMenu: TMenuItem;
    FRaisedForm: T_AM2000_RaisedItemForm;

    FSystemFontHandle, FOldFontHandle: HFont;
    FHotTrack        : Boolean;
    FFlat            : T_AM2000_FlatStyle;
    FTransparent     : Boolean;
    FOnPopup         : T_AM2000_MenuBarPopupEvent;

    procedure SetVersion(Value: T_AM2000_Version);
    function GetVersion: T_AM2000_Version;

    procedure SetMenu(Value: TMenu);
    procedure SetTransparent(Value: Boolean);

    procedure SetHotTrack(const Value: Boolean);

    procedure RebuildToolTipWindow;

    procedure wmWindowPosChanged(var Msg: TMessage); message wm_WindowPosChanged;
    procedure wmSetKeepSelected(var Msg: TMessage);  message wm_SetKeepSelected;
    procedure wmUpdateMenuBar(var Msg: TMessage);    message wm_UpdateMenuBar;
    procedure wmActivateMenuBar(var Msg: TMessage);  message wm_ActivateMenuBar;

    procedure cmMouseLeave(var Msg: TMessage);       message cm_MouseLeave;

    procedure wmSysKeyDown(var Msg: TWMKeyDown);     message wm_SysKeyDown;
    procedure wmSysKeyUp(var Msg: TWMKeyUp);         message wm_SysKeyUp;
    procedure wmKeyDown(var Msg: TWMKeyDown);        message wm_KeyDown;
    procedure wmMouseMove(var Msg: TWMMouse);        message wm_MouseMove;
    procedure wmLButtonDown(var Msg: TWMMouse);      message wm_LButtonDown;
{$IFDEF Delphi3OrHigher}
    procedure cmSysFontChanged(var Msg: TMessage);   message cm_SysFontChanged;
{$ENDIF}
    procedure wmSettingChange(var Msg: TMessage);    message wm_SettingChange;
    procedure cmFontChanged(var Msg: TMessage);      message cm_FontChanged;
    procedure cmParentFontChanged(var Msg: TMessage);message cm_ParentFontChanged;
    procedure wmSetState(var Msg: TMessage);         message wm_SetState;
    procedure wmEraseBkgnd(var Msg: TMessage);       message wm_EraseBkgnd;
    procedure wmPaintOnCanvas(var Msg: TMessage);    message wm_PaintOnCanvas;

    procedure cmDesignHitTest(var Msg: TCMDesignHitTest); message cm_DesignHitTest;

    function GetMenuItemCount: Integer;
    function GetMenuItem(Index: Integer): TMenuItem;
    function GetNextMenuItem(var CurIndex: Integer; Params: T_AM2000_NextMenuItemParams): TMenuItem;

    procedure MoveActiveTo(NewItem: TMenuItem);
    procedure MoveActiveToIndex(NewIndex: Integer; NewItem: TMenuItem);
    function GetBitmapSize(Item: TMenuItem): TSize;
    procedure PopupMenuRect(SetHidden, SelectFirst: Boolean);
    function GetSysBtnRect(SysBtn : T_AM2000_SystemButton): TRect;
    function GetSystemIconRect: TRect;
    procedure TimerShow(Sender: TObject);
    function PopupAccelItem(VK: Word): Boolean;
    function SearchForMergedMenus(Msg: TWMKey): Boolean;
    procedure OnHotTrack(Sender: TObject);
    procedure OnDeactivate(Sender: TObject);

    function GetSystemFont: Boolean;
    function GetParentFont: Boolean;
    function GetFont: TFont;
    function GetCtl3D: Boolean;

    function GetAlign: TAlign;
    function IsAlignStored: Boolean;
    procedure SetAlign(const Value: TAlign);

    function GetBiDiMode: TBiDiMode;
    function GetSystemShadow: Boolean;

{$IFDEF ACTIVEX}
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
{$ENDIF}

  protected
    procedure Paint; override;
    procedure Loaded; override;

    function GetMenuItemSize(Item: TMenuItem): TSize;
    procedure PaintItem(const Canvas: TCanvas; const Item: TMenuItem;
      R: TRect; const BitBlt2SelfCanvas, PaintBackground: Boolean);

    procedure PaintActiveItem;
    procedure PaintSystemButton(SystemButton: T_AM2000_SystemButton; Enabled: Boolean);
    procedure PaintSystemButtons(const Flush: Boolean);

    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DblClick; override;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateParams(var Params: TCreateParams); override;

    property Version: T_AM2000_Version
      read GetVersion write SetVersion stored False;

  public
    ComponentLoaded: Boolean;
    OwnerForm: {$IFDEF Delphi3OrHigher}TCustomForm{$ELSE}TForm{$ENDIF};
    aiState: T_AM2000_aiState;
    aiRect: TRect;
    mbType: T_AM2000_mbType;
    miRects: TList;
    miSysBtnRect: TRect;
    ParentClientWidth: Integer;
    IgnoreOnClick: Boolean;

    property MenuComponent   : TCustomPopupMenu2000
      read FMenuComponent;
    property RaisedForm      : T_AM2000_RaisedItemForm
      read FRaisedForm;
    property Menu: TMenu
      read FMenu write SetMenu;
    property HotTrack        : Boolean
      read FHotTrack write SetHotTrack default False;
    property Flat            : T_AM2000_FlatStyle
      read FFlat write FFlat default fsDefault;
    property Transparent     : Boolean
      read FTransparent write SetTransparent default False;

{$IFDEF ACTIVEX}
    procedure DefineProperties(Filer: TFiler); override;
{$ENDIF}

    property Align: TAlign
      read GetAlign write SetAlign stored IsAlignStored;

    property OnPopup : T_AM2000_MenuBarPopupEvent
      read FOnPopup write FOnPopup;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ResetBuffer;
    procedure PopupActiveItem(SelectFirst: Boolean);
    procedure SetActiveItemIndex(Index: Integer);

    function KillActiveItem{(const LostToObjectInspector: Boolean)}: Boolean;
    procedure HideActiveItem;
    procedure UpdateMenuBar(RebuildMenu: Boolean);
    procedure SetDisableAltKeyUp(Value: Boolean);

    procedure Repaint; override;
    procedure Update; override;
    procedure SetMenuItem(AItem: TMenuItem);
    function Options: T_AM2000_Options;

    function GetOffsetX: Integer;
    function GetLastOffsetX: Integer;
    function GetItemAtPoint(const P: TPoint): TMenuItem;

{$IFDEF Delphi4OrHigher}
    procedure InitiateAction; override;
{$ENDIF}

    procedure Refresh;
    function GetMenuRect: TSize;
    procedure DoLoaded;

  end;

  T_AM2000_RaisedItemForm = class(TForm)
  private
    DropShadow: T_AM2000_DropShadow;

    function GetDropShadow: Boolean;

    procedure WndProc(var Message: TMessage); override;

  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure wmEraseBkgnd(var Msg: TWMEraseBkgnd); message wm_EraseBkgnd;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X: Integer; Y: Integer); override;
//    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
//      Y: Integer); override;
    procedure Activate; override;

  public
    DrawLeft, DrawRight, DrawTop, DrawBottom: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Update; override;
    procedure SilentShow;

    procedure SilentHide;
    procedure DrawBevel(const ADrawLeft, ADrawRight, ADrawTop, ADrawBottom: Boolean);

  end;

// several menu bars handle
function GetActiveMenuBar: TCustomMenuBar2000;
function GetMenuBarFromHandle(AHandle: THandle): TCustomMenuBar2000;
function GetMenuBarFromMenu(AMenu: TMenu): TCustomMenuBar2000;

implementation


uses
  am2000menuitem, am2000mainmenu, am2000cache, am2000desktop, am2000dragwindow;

{ T_AM2000_RaisedItemForm }

{ procedures }

procedure AddMiRects(List : TList; MenuItem : TMenuItem; R : TRect);
var
  miRect: P_AM2000_MenuBarItemRect;
begin
     if (List <> nil) then begin
        New(miRect);
        if miRect <> nil then
        with miRect^ do begin
           mi:= MenuItem;
           iR:= R;
           List.Add(miRect);
        end;
     end;
end;

procedure RemoveMiRects(List : TList; MenuItem : TMenuItem);
var miRect: P_AM2000_MenuBarItemRect;
    i: Integer;
begin
     if (List <> nil) then
        for i:= 0 to List.Count-1 do begin
            miRect := P_AM2000_MenuBarItemRect(List.Items[i]);
            if miRect.mi = MenuItem then begin
               Dispose(miRect);
               List.Delete(i);
               Exit;
            end;
        end;
end;

procedure ClearMiRects(List : TList);
var miRect: P_AM2000_MenuBarItemRect;
    i: Integer;
begin
     if (List <> nil) then begin
        for i:= 0 to List.Count-1 do begin
            miRect := P_AM2000_MenuBarItemRect(List.Items[i]);
            Dispose(miRect);
        end;
        List.Clear;
     end;
end;

function GetMiRect(List : TList; mI : Integer; MenuItem : TMenuItem) : TRect;
var i: Integer;
begin
  if (List <> nil)
  then
    with List
    do
      if (mI >= 0)
      and (mI < Count)
      and (P_AM2000_MenuBarItemRect(Items[mI])^.mi = MenuItem)
      then Result:= P_AM2000_MenuBarItemRect(Items[mI])^.iR
      else
      { find the menuitem: }
      for i:= 0 to Count -1
      do
        if P_AM2000_MenuBarItemRect(Items[i])^.mi = MenuItem
        then begin
          Result:= P_AM2000_MenuBarItemRect(Items[i])^.iR;
          Exit;
        end;
end;


function CheckForHidden(const Item: TMenuItem): Boolean;
var
  I: Integer;
begin
  Result:= False;
  if (Item = nil)
  or not (Item is TMenuItem2000)
  then Exit;

  for I:= 0 to TMenuItem2000(Item).Count -1
  do
    if Item[I] is TMenuItem2000
    then
      with TMenuItem2000(Item[I])
      do
        if Hidden
        or ((Count > 0) and CheckForHidden(Item[I]))
        then begin
          Result:= True;
          Exit;
        end;
end;

{ menu bars management }

function GetActiveMenuBar: TCustomMenuBar2000;
var
  I: Integer;
begin
  Result:= nil;
  for I:= ActiveMenuBarList.Count -1 downto 0 do
    if IsActive(TCustomMenuBar2000(ActiveMenuBarList[I]).OwnerForm)
    then begin
      Result:= ActiveMenuBarList[I];
      Exit;
    end;
end;

function GetMenuBarFromHandle(AHandle: THandle): TCustomMenuBar2000;
var
  I: Integer;
begin
  Result:= nil;
  for I:= ActiveMenuBarList.Count -1 downto 0 do
    if IsContained(AHandle, TWinControl(ActiveMenuBarList[I]))
    then begin
      Result:= ActiveMenuBarList[I];
      Exit;
    end;
end;

function GetMenuBarFromMenu(AMenu: TMenu): TCustomMenuBar2000;
var
  I: Integer;
begin
  Result:= nil;
  for I:= 0 to ActiveMenuBarList.Count -1
  do
    if TCustomMenuBar2000(ActiveMenuBarList[I]).Menu = AMenu
    then begin
      Result:= ActiveMenuBarList[I];
      Exit;
    end;
end;


{ TCustomMenuBar2000 }

constructor TCustomMenuBar2000.Create;
begin
  mbState:= [];
  
  inherited;

  // control style
  ControlStyle := [csClickEvents, csDoubleClicks, csSetCaption, csOpaque,
    csReplicatable {$IFDEF Delphi4OrHigher}, csActionClient{$ENDIF}];

  // create the buffer
  Buffer:= TBitmap.Create;

  Include(mbState, mbsWindowActive);
  inherited ParentFont:= False;
  SystemMenu:= TMenuItem2000.Create(Self);

  // init menu item options
  FLocalOptions:= T_AM2000_MenuOptions.Create(nil);

  Width:= 50;
  Height:= 21;
  Align:= alTop;
  Flat:= fsDefault;

  if (csDesigning in ComponentState)
  or ((Parent <> nil)
  and (csDesigning in Parent.ComponentState))
  then
    Include(mbState, mbsPreview);

  ActiveMenuBarList.Add(Self);

  mbType:= mbHorizontal;
  miRects:= TList.Create;
end;

destructor TCustomMenuBar2000.Destroy;
  // thanks to Jan Hjørdie for correction of this code
begin
  if ActiveMenuBarList <> nil
  then ActiveMenuBarList.Remove(Self);
  FRaisedForm.Free;

  // if the menu component cannot be destroyed by the Owner...
  FMenuComponent.Free;

  Buffer.Free;
  Back.Free;
  FLocalOptions.Free;
  FDefaultOptions.Free;
  ToolTipWindow.Free;

  ClearMiRects(miRects);
  miRects.Free;

  inherited;
end;

procedure TCustomMenuBar2000.Loaded;
var
  P: TComponent;
begin
  inherited;

  if ComponentLoaded
  then Exit;
  
  OwnerForm:= nil;

  if Owner is {$IFDEF Delphi3OrHigher}TCustomForm{$ELSE}TForm{$ENDIF}
  then
    OwnerForm:= {$IFDEF Delphi3OrHigher}TCustomForm{$ELSE}TForm{$ENDIF}(Owner)

  else begin
    P:= Parent;
    while (P <> nil)
    and not (P.Owner is {$IFDEF Delphi3OrHigher}TCustomForm{$ELSE}TForm{$ENDIF})
    and (P is TControl)
    do P:= TControl(P).Parent;

    if P <> nil
    then OwnerForm:= {$IFDEF Delphi3OrHigher}TCustomForm{$ELSE}TForm{$ENDIF}(P.Owner);
  end;

  // grab OwnerForm's menu
  if (OwnerForm <> nil)
  then begin
    if FMenu = nil
    then FMenu:= TForm(OwnerForm).Menu;

    if (FMenu = TForm(OwnerForm).Menu)
    then TForm(OwnerForm).Menu:= nil;
  end;

  // initialize other properties
  if not (csDesigning in ComponentState)
  then begin
    RebuildToolTipWindow;
  end;

  FLocalOptions.Assign(Options);
  with FLocalOptions, Margins
  do begin
    Alignment:= taCenter;
    Left:= 0;
    Right:= 0;
    Gutter:= 0;
  end;

  if (Buffer.Empty)
  then SetBounds(Left, Top, 0, 0);

  ComponentLoaded:= True;
  
  FMenuComponent:= TCustomPopupMenu2000.Create(nil);
end;

procedure TCustomMenuBar2000.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.style:= WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;


{ Windows Messages Handlers }

procedure TCustomMenuBar2000.wmWindowPosChanged(var Msg: TMessage);
begin
  Invalidate;
  inherited;
end;

procedure TCustomMenuBar2000.wmUpdateMenuBar(var Msg: TMessage);
  // updates menu bar
const
  RebuildFlag: Boolean = False;
var
  M: TMsg;
begin
  // skip no update
  if ((Msg.wParam = upChildChanged)
  and ((OwnerForm = nil) or (TForm(OwnerForm).FormStyle <> fsMdiForm)))
  or not Visible
  then Exit;

  // force menu merge rebuild
  if (Menu is TCustomMainMenu2000)
  and ((Msg.wParam = upForceRebuild)
  or ((Msg.wParam = upChildChanged)
  and (OwnerForm <> nil)
  and (TForm(OwnerForm).ActiveMdiChild <> LastChild)))
  then begin
    TCustomMainMenu2000(Menu).RebuildMergedMenuItems;
    RebuildFlag:= True;
  end;

  // force rebuild tooltips
  if (Msg.wParam = upRebuildToolTips)
  then RebuildToolTipWindow;

  // child changed
  if (Msg.wParam = upChildChanged) // is child changed?
  and (OwnerForm <> nil)
  then
    if (TForm(OwnerForm).ActiveMdiChild = LastChild)
    then begin
      if LastChild = nil
      then
         Msg.wParam:= 0
      else
         Msg.wParam:= WPARAM(LastChild.WindowState =
           TForm(OwnerForm).ActiveMdiChild.WindowState);
    end
    else
      LastChild:= TForm(OwnerForm).ActiveMdiChild;

  // skip update on other messages
  if PeekMessage(M, Handle, wm_UpdateMenuBar, wm_UpdateMenuBar, pm_NoRemove)
  then begin
    RebuildFlag:= RebuildFlag or (M.wParam <> 0);
    Msg.Result:= 1;
    Exit;
  end;

  RebuildFlag:= RebuildFlag or (Msg.wParam <> 0);
  if RebuildFlag
  then begin
    UpdateMenuBar(True);
    RebuildFlag:= False;
  end
  else begin
    ResetBuffer;
    Paint;
  end;
end;

procedure TCustomMenuBar2000.PopupMenuRect(SetHidden, SelectFirst: Boolean);
  // thanks to Frédéric Schneider for improvements in this routine
var
  X, Y: Integer;
  P: TPoint;
begin
  // if active item is not active
  if (not IsEnabled(ai))
  or (FMenuComponent = nil)
  then Exit;

  if mbType = mbVertical
  then begin
    X:= aiRect.Left -1;
    Y:= aiRect.Top;
  end
  else begin
    if GetBiDiMode <> bdLeftToRight
    then X:= aiRect.Right -1
    else X:= aiRect.Left;
    
    Y:= aiRect.Bottom;
  end;

  // raise parent menu item
  if (mfRaiseMenuBarItem in FLocalOptions.Flags)
  then begin
    if FRaisedForm = nil
    then FRaisedForm:= T_AM2000_RaisedItemForm.Create(Self);

    FRaisedForm.Update;
    T_AM2000_RaisedItemForm(FRaisedForm).SilentShow;
  end;

  // popup menu 98
  MenuComponent.MenuItems:= nil;
  P:= ClientToScreen(Point(X, Y));

  // switch between different cases of activeitem
  if (ai <> nil)
  then begin
    // OnClick event
    ai.Click;

    // main system menu
    if (ai = SystemMenu)
    and (OwnerForm <> nil)
    then begin
      MenuComponent.MenuItems:= nil;
      MenuComponent.MenuHandle:= GetSystemMenu(TForm(OwnerForm).ActiveMdiChild.Handle, False);
    end
    else
    // attached menu
    if (ai is TMenuItem2000)
    and (TMenuItem2000(ai).AttachMenu <> nil)
    then
      with TCustomPopupMenu2000(TMenuItem2000(ai).AttachMenu)
      do begin
        PrepareForPopup(True);
        MenuComponent.MenuItems:= Items2000; // ordinal item
        MenuComponent.MenuHandle:= Items2000.MenuHandle;
        MenuComponent.Images:= Images;
        MenuComponent.DisabledImages:= DisabledImages;
        MenuComponent.HotImages:= HotImages;
        MenuComponent.Options.Assign(Options);
      end
    else
    // normal submenu
    if HasSubmenu(ai)
    then begin
      MenuComponent.MenuItems:= ai; // ordinal item
      
      if ai is TMenuItem2000
      then MenuComponent.MenuHandle:= TMenuItem2000(ai).MenuHandle
      else MenuComponent.MenuHandle:= ai.Handle;
    end

    // ordinary item
    else begin
      Exclude(mbState, mbsIgnoreOnMouseUp);
      if mbsKeepSelected in mbState
      then HideActiveItem;
      Exit;
    end;
      
  end
  else
    // child's system menu
    if (OwnerForm <> nil)
    and (TForm(OwnerForm).FormStyle = fsMdiForm)
    and (TForm(OwnerForm).ActiveMdiChild <> nil)
    then MenuComponent.MenuHandle:= GetSystemMenu(TForm(OwnerForm).ActiveMdiChild.Handle, False);

  if Assigned(FOnPopup)
  then FOnPopup(Self, MenuComponent.MenuItems, MenuComponent.MenuHandle);

  if OwnerForm <> nil
  then SendMessage(OwnerForm.Handle, wm_InitMenu, LongInt(MenuComponent.MenuHandle), 0);


  with MenuComponent.Form
  do begin
    Perform(wm_SetState, ssOleWindow, 0);
    Perform(wm_SetState, ssPopulated, 0);
    Perform(wm_SetState, ssAnimation, Integer((mbsIgnoreAnimation in mbState) or (mbsPreview in mbState)));
    Perform(wm_SetState, ssPreview, Integer(mbsPreview in mbState));
    Perform(wm_SetState, ssAccel, Integer(mbsShowAccelerators in mbState));
    Perform(wm_SetState, ssHotTrack, Integer(HotTrack));
    Perform(wm_SetState, ssSibling, Integer(mbsSibling in mbState));
    Perform(wm_SetState, ssRightToLeft, Integer((mbType = mbVertical)
      or (GetBiDiMode <> bdLeftToRight)));
    Perform(wm_SetState, ssFraming, Integer(aiState = aiFraming));
  end;

  if (Menu is TCustomMainMenu2000)
  then
    with TCustomMainMenu2000(Menu)
    do begin
      MenuComponent.ParentSkin:= GetISkin;

      MenuComponent.Options.AssignPropertiesOnly(Options, True);
      MenuComponent.StatusBar:= StatusBar;
      MenuComponent.StatusBarIndex:= StatusBarIndex;
      MenuComponent.OnMenuCommand:= OnMenuCommand;
      MenuComponent.OnMenuClose:= OnMenuClose;
      MenuComponent.OnCloseQuery:= OnCloseQuery;
      MenuComponent.OnContextMenu:= OnContextMenu;
      MenuComponent.BiDiMode:= GetBiDiMode;

      with MenuComponent.Form
      do begin
        Perform(wm_SetState, ssOleWindow, Ole2ObjectWindow);
        Perform(wm_SetState, ssPopulated, Integer(IsMenuPopulated(MenuComponent.MenuHandle)));
      end;
    end

  else
  if (Menu is TCustomPopupMenu2000)
  then
    with TCustomPopupMenu2000(Menu)
    do begin
      MenuComponent.ParentSkin:= GetISkin;

      MenuComponent.Options.AssignPropertiesOnly(Options, True);
      MenuComponent.StatusBar:= StatusBar;
      MenuComponent.StatusBarIndex:= StatusBarIndex;
      MenuComponent.OnMenuCommand:= OnMenuCommand;
      MenuComponent.OnMenuClose:= OnMenuClose;
      MenuComponent.OnCloseQuery:= OnCloseQuery;
      MenuComponent.OnContextMenu:= OnContextMenu;
      MenuComponent.BiDiMode:= GetBiDiMode;
    end

  else begin
    MenuComponent.Images:= nil;
    MenuComponent.DisabledImages:= nil;
    MenuComponent.HotImages:= nil;
    MenuComponent.StatusBar:= nil;
    MenuComponent.StatusBarIndex:= 0;
    MenuComponent.ShowHint:= False;
    MenuComponent.OnMenuCommand:= nil;
    MenuComponent.OnMenuClose:= nil;
    MenuComponent.OnCloseQuery:= nil;
    MenuComponent.SystemFont:= True;
    MenuComponent.Ctl3D:= True;
  end;

  MenuComponent.PopupComponent:= Self;

  // set selected first
  if (mbsKeepSelected in mbState)
  or SelectFirst
  then MenuComponent.Form.Perform(wm_SetState, ssSelection, 0);


  StopTimer;

  Exclude(mbState, mbsKeepSelected);
  Exclude(mbState, mbsIgnoreAnimation);
  Exclude(mbState, mbsSibling);

  if SetHidden
  then
    MenuComponent.Options.Flags:= MenuComponent.Options.Flags + [mfHiddenIsVisible];


  with MenuComponent
  do begin
    if (ai <> nil)
{$IFDEF Delphi5OrHigher}
    and (ai.SubMenuImages <> nil)
{$ELSE}
    and (ai is TMenuItem2000) and (TMenuItem2000(ai).SubMenuImages <> nil)
{$ENDIF}
    then
      Images:= TMenuItem2000(ai).SubMenuImages;

{$IFDEF Delphi5OrHigher}
    if (Images = nil)
    and (MenuItems <> nil)
    then begin
      Images:= MenuItems.GetImageList;

      if MenuItems.SubMenuImages <> nil
      then Images:= MenuItems.SubMenuImages;
    end;

    if Images = nil
    then Images:= Menu.Images;

{$ELSE}
    if (Menu is TCustomMainMenu2000)
    then Images:= TCustomMainMenu2000(Menu).Images;

    if (Menu is TCustomPopupMenu2000)
    then Images:= TCustomPopupMenu2000(Menu).Images;

{$ENDIF}
  end;

  // popup
  MenuComponent.PopupAsync(P.X, P.Y);

{$IFDEF ActiveX}
  ActiveMenuItem:= ai;
{$ENDIF}

  // is hidden properties present then enable timer
  if (not SetHidden)
  and (not (mfNoAutoShowHidden in FLocalOptions.Flags))
  and CheckForHidden(ai)
  then SetTimer(nShowHiddenTimeout, TimerShow);
end;


function TCustomMenuBar2000.GetSysBtnRect(SysBtn : T_AM2000_SystemButton): TRect;
  // get rect for system button
begin
  if SysBtn = sbNone
  then
    Result:= Rect(0, 0, 0, 0)
    
  else begin
    // get close button rect
    if mbType = mbHorizontal
    then
      Result:= Rect(Width - iSystemIconWidth -2,
         Height - iSystemIconWidth -2,
         Width -1,
         Height -1)
    else
      Result:= Rect(miSysBtnRect.Right - iSystemIconWidth,
        miSysBtnRect.Bottom - iSystemIconWidth,
        miSysBtnRect.Right,
        miSysBtnRect.Bottom);

    case SysBtn of
      sbRestore:
        if mbType = mbVertical
        then
          OffsetRect(Result, 0, -iSystemIconWidth)
        else
          OffsetRect(Result, -iSystemIconWidth -2, 0);

      sbMinimize:
        if mbType = mbVertical then
          OffsetRect(Result, 0, -iSystemIconWidth*2 +3)
        else
          OffsetRect(Result, -iSystemIconWidth*2 -4, 0);
            
    end;
  end;
end;

function TCustomMenuBar2000.GetSystemIconRect: TRect;
var
  X, DX, DY: Integer;
begin
  if GetOffsetX = 0
  then
    Result := Rect(0, 0, 0, 0)

  else begin
    if mbType = mbVertical
    then begin
       X:= Width - iSystemIconWidth -1;
       DX:= 1;
       DY:= 4;
    end
    else begin
       if GetBiDiMode <> bdLeftToRight
       then X:= Buffer.Width - iSystemIconWidth - GetLastOffsetX
       else X:= 0;
       DX:= 4;
       DY:= 1;
    end;
    Result:= Rect(X, 0, X + iSystemIconWidth + DX, iSystemIconWidth + DY);
  end;
end;

procedure TCustomMenuBar2000.wmSetKeepSelected(var Msg: TMessage);
begin
  if Msg.wParam <> 0
  then Include(mbState, mbsKeepSelected)
  else Exclude(mbState, mbsKeepSelected);
end;

procedure TCustomMenuBar2000.wmActivateMenuBar(var Msg: TMessage);
begin
  if (mbsPreview in mbState)
  then Exit;

  if (Msg.wParam <> 0)
  or (aiState = aiFraming)
  then
    if mbsWindowActive in mbState
    then Exit
    else Include(mbState, mbsWindowActive)

  else
    if mbsWindowActive in mbState
    then Exclude(mbState, mbsWindowActive)
    else Exit;

  if ActiveMenuBarList.IndexOf(Self) <> -1
  then begin
    ActiveMenuBarList.Remove(Self);
    if not (mbsWindowActive in mbState)
    then begin
      if not (mbsIgnoreActivateMenuBar in mbState)
      then KillActivePopupMenu2000(True, False)
      else Exclude(mbState, mbsIgnoreActivateMenuBar);
      ActiveMenuBarList.Add(Self);
    end
    else begin
      ActiveMenuBarList.Insert(0, Self);
    end;
  end;

  UpdateMenuBar(False);

  with MenuComponent
  do
    if FormOnScreen
    then begin
      if mbsWindowActive in mbState
      then begin
        Form.Perform(wm_SetState, ssEnabled, 1);
        Options.Colors.MenuText:= Self.Options.Colors.MenuText;
      end
      else begin
        Form.Perform(wm_SetState, ssEnabled, 0);
        Options.Colors.MenuText:= Self.Options.Colors.DisabledText;
      end;

      Repaint;
    end;
end;

{ Search for shortcut }

function TCustomMenuBar2000.SearchForMergedMenus(Msg: TWMKey): Boolean;
var
  I: Integer;
begin
  Result:= True;
  
  if IsShortCutEx(Msg, Menu.Items, csDesigning in ComponentState)
  then Exit;

  I:= 1;
  if (Menu is TCustomMainMenu2000) then
    with TCustomMainMenu2000(Menu) do
      while (Msg.Result = 0) and (I < MergedMenus.Count) do begin
        if IsShortCutEx(Msg, TMainMenu(MergedMenus[I]).Items, csDesigning in ComponentState)
        then Exit;
        Inc(I);
      end;

  Result:= False;
end;

function IsShortCut(Msg: TWMKey): Boolean;
  // checks is this is a shortcut
begin
  Result:= (Msg.CharCode <> vk_Control)
    and (Msg.CharCode <> vk_Shift)
    and ((GetKeyState(vk_Control) < 0)
    or (Msg.KeyData and AltMask <> 0)
    or ((Msg.CharCode >= vk_F1) and (Msg.CharCode <= vk_F12))
    or (Msg.CharCode = vk_Escape)
    or (Msg.CharCode = vk_Delete)
    or (Msg.CharCode = vk_Insert)
    or (Msg.CharCode = vk_Back)
    or (Msg.CharCode = vk_Return));
end;

function TCustomMenuBar2000.PopupAccelItem(VK: Word): Boolean;
var
  I: Integer;
  Item: TMenuItem;
begin
  Result:= False;
  for I:= 0 to GetMenuItemCount -1
  do begin
    Item:= GetMenuItem(I);

    // if item is visible
    if ((Item is TMenuItem2000)
    and IsVisible(TMenuItem2000(Item))
    and IsAccel2(VK, TMenuItem2000(Item).Caption))
    or (IsVisible(Item)
    and IsAccel2(VK, Item.Caption))
    then begin
      if not IsActive(OwnerForm)
      then begin
        SetForegroundWindow(OwnerForm.Handle);
        Include(mbState, mbsIgnoreActivateMenuBar);
      end;

      MoveActiveToIndex(I, Item);
      SetDisableAltKeyUp(True);
      PopupActiveItem(True);
      Result:= True;
      Exit;
    end;
  end;
end;

procedure TCustomMenuBar2000.wmSysKeyDown(var Msg: TWMKeyDown);
begin
  if IgnoreOnClick
  then Exit;

  // if menu state is active
  if aiState <> aiFlat
  then begin
    SetDisableAltKeyUp(True);
    KillActiveItem;
    Msg.Result:= 1;
  end
  else

  // show child system menu
  if (Msg.CharCode = VK_SUBTRACT)
  and IsChildMaximizedAndSystemMenu(OwnerForm)
  then begin
    aiRect.Left:= 0;
    ai:= SystemMenu;
    PopupActiveItem(True);
    Msg.Result:= 1;
  end

  // shortcut
  else
  if (Msg.CharCode <> VK_MENU)
  and (FMenu <> nil)
  and ((IsShortCut(Msg) and SearchForMergedMenus(Msg)) // search for shortcut
  or PopupAccelItem(Msg.CharCode)) // popup
  then begin
    Include(mbState, mbsIgnoreSysKeyUp);
    Msg.Result:= 1;
  end

  else begin
    Include(mbState, mbsShowAccelerators);
    PaintActiveItem;
    UpdateMenuBar(False);
  end;
end;

procedure TCustomMenuBar2000.wmSysKeyUp(var Msg: TWMKeyUp);
begin
  if IgnoreOnClick
  then Exit;

  if mbsIgnoreSysKeyUp in mbState
  then begin
    Exclude(mbState, mbsIgnoreSysKeyUp);
    Exit;
  end;

  if (Menu <> nil)
  and (aiState = aiFlat)
  then
    if ((Msg.CharCode = vk_Menu)
    or (Msg.CharCode = vk_F10))
    then begin
      if not (mbsDisableAltKeyUp in mbState)
      then begin
        FullHideCaret;
        Include(mbState, mbsKeepSelected);
        aiState:= aiSunken;
        SetCursor(LoadCursor(0, MakeIntResource(idc_Arrow)));
        if ai = nil
        then begin
          if IsChildMaximizedAndSystemMenu(OwnerForm)
          then begin
            ai:= SystemMenu;
            MoveActiveToIndex(-1, ai);
          end
          else begin
            ai:= GetMenuItem(0);
            MoveActiveToIndex(0, ai);
          end;

        end
        else begin
          PaintActiveItem;
        end;

        Msg.Result:= 1;
      end;
    end;

  SetDisableAltKeyUp(False);
end;

procedure TCustomMenuBar2000.wmKeyDown(var Msg: TWMKeyDown);
  // handles basic cursor movements and menu shortcuts
var
  M: TMsg;
begin
  if IgnoreOnClick
  or (FMenuComponent = nil)
  then Exit;

  if IsActive(OwnerForm)
  and ((aiState = aiRaised)
  or (aiState = aiSunken))
  then
    case Msg.CharCode of
      // open menu
      vk_Return, vk_Space, vk_Down, vk_Up:
        if not MenuComponent.FormOnScreen
        then begin
          PopupMenuRect(False, True);
          Msg.Result:= 1;
        end;

      // move selection left or right
      vk_Tab:
        begin
          Include(mbState, mbsKeepSelected);
          Include(mbState, mbsIgnoreAnimation);

          if GetKeyState(vk_Shift) < 0
          then MoveActiveTo(GetNextMenuItem(aiIndex, [niBackward, niIgnoreInvisible]))
          else MoveActiveTo(GetNextMenuItem(aiIndex, [niIgnoreInvisible]));

          Exclude(mbState, mbsKeepSelected);
          Msg.Result:= 1;
        end;

      // move selection left
      vk_Right:
        begin
          Include(mbState, mbsKeepSelected);
          Include(mbState, mbsIgnoreAnimation);

          MoveActiveTo(GetNextMenuItem(aiIndex, [niIgnoreInvisible]));

          Exclude(mbState, mbsKeepSelected);
          Msg.Result:= 1;
        end;

      // move selection right
      vk_Left:
        begin
          Include(mbState, mbsKeepSelected);
          Include(mbState, mbsIgnoreAnimation);

          MoveActiveTo(GetNextMenuItem(aiIndex, [niBackward, niIgnoreInvisible]));

          Exclude(mbState, mbsKeepSelected);
          Msg.Result:= 1;
        end;

      // escape
      vk_Escape:
        begin
          KillActiveItem;
          Msg.Result:= 1;
        end;

      vk_F1:
        if (Application.HelpFile <> '')
        and (ai <> nil)
        and (ai.HelpContext <> 0)
        then begin
          KillActivePopupMenu2000(True, True);
          
          if (biHelp in TForm(OwnerForm).BorderIcons)
          then Application.HelpCommand(HELP_CONTEXTPOPUP, ai.HelpContext)
          else Application.HelpCommand(HELP_CONTEXT, ai.HelpContext);

          // We have to remove the next message that is in the queue.
          PeekMessage(M, 0, 0, 0, pm_Remove);
          Msg.Result:= 1;
        end;

      // popup menu item
      else
        if (not MenuComponent.FormOnScreen)
        and PopupAccelItem(Msg.CharCode)
        then Msg.Result:= 1;
    end

  else
    if IsShortCut(Msg)
    and SearchForMergedMenus(Msg)
    then Msg.Result:= 1;
end;

procedure TCustomMenuBar2000.wmMouseMove(var Msg: TWMMouse);
begin
  inherited;
  if (ToolTipWindow <> nil)
  then ToolTipWindow.RelayMouseMove(Msg.Pos);
end;


{ Set Bounds Routines }

function TCustomMenuBar2000.GetOffsetX: Integer;
begin
  // is system icon present?
  if IsChildMaximizedAndSystemMenu(OwnerForm)
  then Result:= iSystemIconWidth +4
  else Result:= 0;
end;

function TCustomMenuBar2000.GetLastOffsetX: Integer;
begin
  Result:= 0;

  if OwnerForm = nil then Exit;

  // increase by mdi caption buttons
  with TForm(OwnerForm)
  do
    if (ActiveMdiChild <> nil)
    and (ActiveMdiChild.WindowState = wsMaximized)
    then begin
      if mbType <> mbVertical
      then Inc(Result, 5);

      // if Form is an MDI form, and it's ActiveMdiForm property
      // is not nil and the child form is maximized
      // then add caption buttons' width and space width
      if (biMaximize in ActiveMdiChild.BorderIcons)
      or (biMinimize in ActiveMdiChild.BorderIcons)
      then begin
        Inc(Result, iSystemIconWidth *2 +2);
        if mbType <> mbVertical then Inc(Result, 2);
      end;

      if (biSystemMenu in ActiveMdiChild.BorderIcons)
      then Inc(Result, iSystemIconWidth);
    end;
end;

function TCustomMenuBar2000.GetMenuItemSize(Item: TMenuItem): TSize;
var
  S: String;
begin
  Result.Cx:= 0;
  Result.Cy:= 0;
  if (Item = nil) then Exit;

  if Item is TMenuItem2000
  then S:= TMenuItem2000(Item).Caption
  else S:= Item.Caption;

  S:= StripAmpersands(S);

  if S <> ''
  then begin
    // select font
    if GetSystemFont
    then begin
      if FSystemFontHandle = 0 then FSystemFontHandle:= GetMenuFontHandle;
      if FOldFontHandle = 0 then FOldFontHandle:= SelectObject(Buffer.Canvas.Handle, FSystemFontHandle);
    end
    else
    if GetParentFont
    and (Owner is {$IFDEF Delphi3OrHigher}TCustomForm{$ELSE}TForm{$ENDIF})
    then begin
      Buffer.Canvas.Font.Assign(TForm(Owner).Font);
    end
    else
      Buffer.Canvas.Font.Assign(GetFont);

    GetTextExtentPoint32(Buffer.Canvas.Handle, PChar(S), Length(S), Result);
  end;

  // if bitmap present...
  with GetBitmapSize(Item)
  do begin
    if Cx > 0
    then
      if Result.Cx >0
      then Inc(Result.Cx, Cx +5)
      else Inc(Result.Cx, Cx -6);

    if (Cy -3) > Result.Cy
    then Result.Cy:= Cy -3;
  end;
end;

function TCustomMenuBar2000.GetMenuItemCount: Integer;
begin
  if FMenu = nil
  then Result:= 0
  else
  if FMenu is TCustomMainMenu2000
  then Result:= TCustomMainMenu2000(FMenu).MergedMenuItemsCount
  else Result:= FMenu.Items.Count;
end;

function TCustomMenuBar2000.GetMenuItem(Index: Integer): TMenuItem;
begin
  if FMenu = nil
  then Result:= nil
  else
  if FMenu is TCustomMainMenu2000
  then Result:= TCustomMainMenu2000(FMenu).MergedMenuItems[Index]
  else Result:= FMenu.Items[Index];
end;

function TCustomMenuBar2000.GetNextMenuItem(var CurIndex: Integer; Params: T_AM2000_NextMenuItemParams): TMenuItem;
  // returns nearest menu item
var
  SaveIndex: Integer; // prevents looping
  CurItem: TMenuItem;
  Maximized: Boolean;
begin
  SaveIndex:= CurIndex;
  Result:= nil;
  Maximized:= IsChildMaximizedAndSystemMenu(OwnerForm);

  repeat
    if niBackward in Params
    then Dec(CurIndex)
    else Inc(CurIndex);

    // check right limit
    if (CurIndex >= GetMenuItemCount)
    then begin
      if (niStopOnLimit in Params) then Exit;

      if Maximized
      then begin
        CurIndex:= -1;
        Result:= SystemMenu;
        Exit;
      end;
      
      CurIndex:= 0;
    end;

    // check left limit
    if (CurIndex < 0)
    then begin
      if (niStopOnLimit in Params) then Exit;
      if Maximized
      and (CurIndex = -1)
      then begin
        Result:= SystemMenu;
        Exit;
      end;
      CurIndex:= GetMenuItemCount -1;
    end;

    // check for looping
    if (CurIndex = SaveIndex)
    then Exit;

    CurItem:= GetMenuItem(CurIndex);
  until IsVisible(CurItem) or (not (niIgnoreInvisible in Params));

  Result:= CurItem;
end;


{ Drawing Rountines }

var
    bi: TBitmapInfo;

procedure TCustomMenuBar2000.PaintItem(const Canvas: TCanvas; const Item: TMenuItem;
  R: TRect; const BitBlt2SelfCanvas, PaintBackground: Boolean);

  procedure PaintHorizontal(Canvas: TCanvas; R: TRect);
  var
    DX, DY: Integer;
    OldClipRect: TRect;
    ClipRgn: HRgn;
  begin
    if GetSystemFont
    then begin
      SelectObject(Canvas.Handle, FOldFontHandle);
      Canvas.Font.Handle:= FSystemFontHandle;
      FOldFontHandle:= SelectObject(Canvas.Handle, FSystemFontHandle);
    end
    else
    if GetParentFont
    and (Parent <> nil)
    then begin
      Canvas.Font.Assign(TForm(Parent).Font);
    end
    else
      Canvas.Font.Assign(GetFont);

    if Canvas.Brush.Style <> bsClear
    then Canvas.Brush.Style:= bsClear;

    if (ai = Item)
    and (not (mbsPreview in mbState))
    and ((aiState = aiSunken) or ((aiState = aiFraming) and (ActiveMenuItem <> Item)))
    and GetCtl3D
    then DX:= 1
    else DX:= 0;

    if mbType = mbVertical
    then DY:= -DX
    else DY:= DX;

    if (Item <> nil)
    then begin
      PaintParams.Item:= Item;

      // is it necessary to re-init Params?
      if PaintParams.Canvas <> Canvas
      then begin
        PaintParams.mir.Clear;
        PaintParams.State:= [];
        PaintParams.Canvas:= Canvas;
        PaintParams.PaintOptions:= FLocalOptions;

        SetState(PaintParams.State, isHorizontal, mbType <> mbVertical);

      end;

{$IFDEF Delphi4OrHigher}
      PaintParams.Images:= TImageList(Menu.Images);
{$ELSE}
      if (Menu is TCustomMainMenu2000)
      then PaintParams.Images:= TCustomMainMenu2000(Menu).Images;
      if (Menu is TCustomPopupMenu2000)
      then PaintParams.Images:= TCustomPopupMenu2000(Menu).Images;
{$ENDIF}

      with PaintParams
      do begin
        // bidimode
        Include(State, BiDiModeToState[GetBiDiMode]);

        // menu text color
        if (FLocalOptions.Colors.MenuText = clMenuText)
        then PaintOptions.Colors.MenuText:= Font.Color;

        mir.BitmapWidth:= GetBitmapSize(Item).Cx;

        mir.LineLeft:= R.Left + DX;
        mir.LineRight:= R.Right + DX;
        mir.ItemLeft:= R.Left + DX;
        mir.ItemWidth:= mir.LineRight - mir.ItemLeft;

        if isLeftToRight in State
        then begin
          mir.BitmapLeft:= R.Left + DX +4;
          if mir.BitmapWidth > 0
          then begin
            Inc(mir.ItemLeft, mir.BitmapWidth +3);
            Dec(mir.ItemWidth, mir.BitmapWidth +3);
          end;
        end
        else begin
          mir.BitmapLeft:= R.Right + DX - mir.BitmapWidth -2;
          if mir.BitmapWidth > 0
          then Dec(mir.ItemWidth, mir.BitmapWidth);
        end;


        mir.Top:= R.Top + DY;
        mir.Height:= R.Bottom - R.Top;

        // is Ctl3d is false then highlight menu item
        SetState(State, isSelected, (ai = Item) and (aiState <> aiFlat)
          and not GetCtl3D);

        // set frame
        SetState(State, isFramed, (ActiveMenuItem = Item)
          and ((aiState = aiFraming) or (aiState = aiFlat) or (mbsPreview in mbState)));

        // hide accelerators
        SetState(State, isShowAccelerators, (mbsShowAccelerators in mbState));

        // Transparent background
        SetState(State, isGraphBack, (not PaintBackground) or (FTransparent
          and not ((isSelected in State)
            and (FLocalOptions.Colors.Highlight <> clNone))));

        SetState(State, isPressed, aiState = aiSunken);
        SetState(State, isMenuBarItem, True);

        // draw item
        OldClipRect.Left:= OldClipRect.Right;

        if isSelected in State
        then begin
          OldClipRect:= Buffer.Canvas.ClipRect;
          with mir.LineRect
          do ClipRgn:= CreateRectRgn(Left, Top, Right, Bottom);
          SelectClipRgn(Buffer.Canvas.Handle, ClipRgn);
          DeleteObject(ClipRgn);
        end;

        PaintMenuItem(@PaintParams);

        if OldClipRect.Left <> OldClipRect.Right
        then begin
          with OldClipRect
          do ClipRgn:= CreateRectRgn(Left, Top, Right, Bottom);
          SelectClipRgn(Buffer.Canvas.Handle, ClipRgn);
          DeleteObject(ClipRgn);
        end;
      end;
    end;
  end;

  procedure PaintVertical(Canvas: TCanvas; R: TRect);
  var
    bmp: TBitmap;
    W, H, X, Y, BytesPerLine0, BytesPerLine1,
    ScanLineStart0, ScanLineStart1, DY, DX, BPP: Cardinal;
    Size0, Size1, InfoHeaderSize: {$IFDEF Delphi4OrHigher}Cardinal{$ELSE}Integer{$ENDIF};
    Data0, Data1: PByteArray;
  begin
    if (Item = nil)
    then Exit;

    Data0:= nil;
    Data1:= nil;
    bmp:= TBitmap.Create;
    try
      W:= R.Bottom - R.Top;
      H:= R.Right - R.Left;

      // destination bitmap
      bmp.Width:= H;
      bmp.Height:= W;
      GetDibSizes(Bmp.Handle, InfoHeaderSize, Size1);
      BytesPerLine1:= Size1 div W;
      GetMem(Data1, Size1);

      // paint
      bmp.Width:= W;
      bmp.Height:= H;
      PaintHorizontal(bmp.Canvas, Rect(0, 0, W, H));

      // load bitmap into the data
      GetDibSizes(Bmp.Handle, InfoHeaderSize, Size0);
      BytesPerLine0:= Size0 div H;
      GetMem(Data0, Size0);

      GetDIB(Bmp.Handle, Bmp.Palette, bi, Data0^);
      BPP:= bi.bmiHeader.biBitCount shr 3;

      // paint rotated bitmap from data to the canvas
      for Y:= 0 to H -1
      do begin
        ScanLineStart0:= BytesPerLine0 * Y;
        DY:= Y * BPP;
        for X:= 0 to W -1
        do begin
          ScanLineStart1:= BytesPerLine1 * X;
          DX:= (W - X -1) * BPP;
          Move(Data0[ScanLineStart0 + DX], Data1[ScanLineStart1 + DY], BPP);
        end;
      end;

      bi.bmiHeader.biWidth:= H;
      bi.bmiHeader.biHeight:= W;
      SetDiBitsToDevice(Canvas.Handle, R.Left, R.Top, H, W, 0, 0, 0, W, Data1, bi, Dib_Rgb_Colors);

    finally
      FreeMem(Data0);
      FreeMem(Data1);
      bmp.Free;
    end;
  end;

begin
  // Transparent background
  if FTransparent
  and (Back <> nil)
  and PaintBackground
  then
    BitBlt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left +1, R.Bottom - R.Top +1,
      Back.Canvas.Handle, R.Left, R.Top, SrcCopy);

  if mbType = mbVertical
  then PaintVertical(Canvas, R)
  else PaintHorizontal(Canvas, R);

  if (ai = Item)
  then
    if GetCtl3D
    then
      case aiState of
        aiRaised:
          if mbsPreview in mbState
          then Canvas.FrameRect(R)
          else DrawEdge(Canvas.Handle, R, bdr_RaisedInner, bf_Rect);

        aiSunken:
          if mbsPreview in mbState
          then Canvas.FrameRect(R)
          else DrawEdge(Canvas.Handle, R, bdr_SunkenOuter, bf_Rect);

        aiFlat:
          Canvas.FrameRect(R);

        aiFraming, aiDesigning:
          begin
            if ActiveMenuItem <> Item
            then DrawEdge(Canvas.Handle, R, bdr_SunkenOuter, bf_Rect);
          end;
      end

    else
      Canvas.FrameRect(R);

  if BitBlt2SelfCanvas
  then
    with R
    do begin
      // paint background
      // bitblt with a mask
      BitBlt(Self.Canvas.Handle, Left -2, Top, Right - Left +2, Bottom - Top,
        Canvas.Handle, Left -2, Top, SrcCopy);

      if (aiState = aiFraming)
      and (ActiveMenuItem <> Item)
      then begin
        // insert before bevel
        with Self.Canvas.Pen
        do begin
          if Color <> clBlack then Color:= clBlack;
          if Style <> psSolid then Style:= psSolid;
        end;

        if mbType <> mbVertical
        then begin
          Self.Canvas.PolyGon([Point(R.Left +1, R.Top), Point(R.Left +3, R.Top),
            Point(R.Left +1, R.Top +2), Point(R.Left +1, R.Bottom -3), Point(R.Left +3, R.Bottom -1),
            Point(R.Left +1, R.Bottom -1)]);
          Self.Canvas.PolyGon([Point(R.Left, R.Top), Point(R.Left -2, R.Top), Point(R.Left, R.Top +2),
            Point(R.Left, R.Bottom -3), Point(R.Left -2, R.Bottom -1), Point(R.Left, R.Bottom -1)]);
        end
        else begin
        end;
      end;
    end;
end;


procedure TCustomMenuBar2000.PaintActiveItem;
begin
  if (ai <> SystemMenu)
  then PaintItem({$IFNDEF Debug}Buffer.{$ENDIF}Canvas, ai, aiRect, True, True);
end;

procedure TCustomMenuBar2000.ResetBuffer;
begin
  Canvas.Brush.Style:= bsClear;
  Exclude(mbState, mbsBuffer);
  Buffer.FreeImage;
end;

procedure TCustomMenuBar2000.PaintSystemButton(SystemButton: T_AM2000_SystemButton; Enabled: Boolean);
  // draw system button
const
  dt_Flags = dt_Center + dt_VCenter + dt_SingleLine;

  EdgeRaised: array [T_AM2000_FlatStyle] of UINT = (bdr_RaisedInner, Edge_Raised, bdr_RaisedInner, bdr_RaisedInner);
  EdgeSunken: array [T_AM2000_FlatStyle] of UINT = (bdr_SunkenOuter, Edge_Sunken, bdr_SunkenOuter, bdr_SunkenOuter);
  ButtonColors: array [Boolean] of TColor = (clBtnText, clGrayText);

  Index: array [T_AM2000_SystemButton] of Integer = (-1, 170, 172, 168);
var
  R: TRect;
  C1, C2: TColor;
  State: T_AM2000_ItemState;
  D: Integer;
begin
  R:= GetSysBtnRect(SystemButton);
  State:= [];

  if ((FFlat = fsDefault)
  and Enabled
  and ((MouseOverSystemButton = SystemButton) or (SystemButtonPressed = SystemButton)))
  or (FFlat <> fsDefault)
  then State:= [isSelected];

  if (SystemButtonPressed = SystemButton)
  then Include(State, isPressed);

  if not Enabled
  then Include(State, isDisabled);

  
  with {$IFNDEF Debug}Buffer, {$ENDIF}Canvas
  do begin
    Brush.Style:= bsSolid;

    if (FFlat = fsDefault)
    and not GetCtl3D
    then begin
      DrawBackground(Canvas, State, FLocalOptions, R);
      DrawFrame(Canvas, State, FLocalOptions, R);

    end
    else begin
      Brush.Color:= FLocalOptions.Colors.Menu;
      FillRect(R);

      if isSelected in State
      then DrawEdge(Handle, R, EdgeRaised[Flat], bf_Rect);

      if isPressed in State
      then begin
        DrawEdge(Handle, R, EdgeSunken[Flat], bf_Rect);
        OffsetRect(R, 1, 1);
      end;

      InflateRect(R, -1, -1);
    end;

    
    Brush.Style:= bsClear;

    if isDisabled in State
    then begin
      C1:= clBtnHighlight;
      C2:= clGrayText;
    end
    else begin
      C1:= clBtnText;
      C2:= clBtnText;
    end;

    D:= (R.Bottom - R.Top - 16) div 2; 
    MenuItemCache.DrawIndex(Canvas, R.Left +D, R.Top +D, Index[SystemButton],
      C1, C2, clNone, Enabled, 0);
  end;
end;

procedure TCustomMenuBar2000.PaintSystemButtons(const Flush: Boolean);
var
  F: TForm;
  R: TRect;
begin
  // fill the background
  R:= miSysBtnRect;
  if IsRectEmpty(R) Then Exit;
  
  InflateRect(R, 0, 1);

  with {$IFNDEF Debug}Buffer, {$ENDIF}Canvas
  do
    if FTransparent
    then
      BitBlt(Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top +1,
        Back.Canvas.Handle, R.Left, R.Top, SrcCopy)

    else begin
      if FFlat = fsWinXP
      then DrawPatternBackground(Canvas, R)
      else FillRect(R);
    end;


  // draw
  F:= TForm(OwnerForm);
  if (F <> nil)
  and (F.ActiveMdiChild <> nil)
  and (F.ActiveMdiChild.WindowState = wsMaximized)
  then
    with F.ActiveMdiChild
    do begin
      if (biSystemMenu in BorderIcons)
      then
        PaintSystemButton(sbClose, True);

      if (biMaximize in BorderIcons)
      or (biMinimize in BorderIcons)
      then begin
        PaintSystemButton(sbRestore, biMaximize in BorderIcons);
        PaintSystemButton(sbMinimize, biMinimize in BorderIcons);
      end;
    end;

  MouseOverSystemButton:= sbNone;

{$IFNDEF Debug}
  if Flush
  then
    BitBlt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
      Buffer.Canvas.Handle, R.Left, R.Top, SrcCopy);
{$ENDIF}      
end;

procedure TCustomMenuBar2000.Paint;
var
  F: TForm;
  R: TRect;
  I, DX: Integer;
  CurItem: TMenuItem;
  BoolTemp: Bool;
begin
  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  or (not Visible)
  or (Height = 0)
  or (mbsIgnorePaint in mbState)
  or ((Parent <> nil)
  and ((csLoading in Parent.ComponentState)
  or (csDestroying in Parent.ComponentState)))
  then Exit;

  // accelerator
  if (not SystemParametersInfo(SPI_GetMenuUnderlines, 0, @BoolTemp, 0))
  then BoolTemp:= True;

  if BoolTemp
  then Include(mbState, mbsShowAccelerators);

  if (Menu = nil)
  or (Menu.Items.Count = 0)
  then
    with Canvas
    do begin
      Brush.Color:= clMenu;
      FillRect(ClipRect);
      Exit;
    end;

  R:= Rect(0, 0, 0, 0);
  LockGlobalRepaint;

  if mbsWindowActive in mbState
  then FLocalOptions.Colors.MenuText:= Options.Colors.MenuText
  else FLocalOptions.Colors.MenuText:= Options.Colors.DisabledText;

  // if the buffer is empty...
  if (not (mbsBuffer in mbState))
  and (GetMenuItemCount > 0)
  then
    with {$IFNDEF Debug} Buffer, {$ENDIF}Canvas
    do begin
      if FTransparent
      then begin
        BitBlt(Handle, 0, 0, Self.Width +2, Self.Height +2, Back.Canvas.Handle, 0, 0, SrcCopy);
      end
      else begin
        Brush.Style:= bsSolid;
        Brush.Color:= FLocalOptions.Colors.Menu;
        FillRect(ClipRect);
      end;

      // if Form is MDI and ChildForm is assigned man maximized
      F:= TForm(OwnerForm);
      if IsChildMaximizedAndSystemMenu(F)
      then begin
        R:= GetSystemIconRect;
        PaintMenuIcon(F, F.ActiveMdiChild,
          {$IFDEF Debug}Canvas.Handle{$ELSE}Buffer.Canvas.Handle{$ENDIF},
          R.Left +1, R.Top +2, iSystemIconWidth);
      end;


      // draw menu items
      if ai = SystemMenu
      then aiRect:= R;

      if (FMenu <> nil)
      then
        for I:= 0 to GetMenuItemCount -1
        do begin
          CurItem:= GetMenuItem(I);
          if not IsVisible(CurItem)
          then Continue;

          R:= GetMiRect(miRects, I, CurItem);

          PaintItem(Canvas, CurItem, R, {$IFDEF Debug}True{$ELSE}False{$ENDIF}, True);
          if CurItem = ai
          then aiRect:= R;
        end;

      if aiRect.Bottom = aiRect.Top
      then aiRect.Bottom:= R.Bottom;
    end;

  Include(mbState, mbsBuffer);


  // draw caption buttons
  PaintSystemButtons(False);

{$IFNDEF Debug}
  BitBlt(Canvas.Handle, 0, 0, Buffer.Width, Buffer.Height, Buffer.Canvas.Handle, 0, 0, SrcCopy);
{$ENDIF}

  // calculate the rest
  R.Left:= R.Right;
  if mbType = mbVertical
  then begin
    if Buffer.Height < Height
    then R:= Rect(0, Buffer.Height, Width +1, Height +1);
  end
  else
  if Buffer.Width < Width
  then
    if GetBiDiMode <> bdLeftToRight
    then R:= Rect(0, 0, DX, Height +1)
    else R:= Rect(Buffer.Width, 0, Width +1, Height +1);

  // fill the rest
  if FTransparent
  then
    if mbType = mbVertical
    then
      BitBlt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left +1, R.Bottom - R.Top +1,
         Back.Canvas.Handle, 0, Buffer.Height, SrcCopy)
    else
      BitBlt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left +1, R.Bottom - R.Top +1,
         Back.Canvas.Handle, Buffer.Width -1, 0, SrcCopy)

  else
  if R.Left <> R.Right
  then begin
    Canvas.Brush.Style:= bsSolid;
    Canvas.Brush.Color:= FLocalOptions.Colors.Menu;

    Canvas.FillRect(R);
  end;

  // draw insert before pane
  if (aiState = aiFraming)
  and (ActiveMenuItem <> nil)
  and (InsertBeforeItem <> miNothingToInsert)
  then begin
    if (InsertBeforeItem <> miInsertAtTheEnd)
    then begin
      R:= GetMiRect(miRects, aiIndex, InsertBeforeItem);
      Inc(R.Bottom, 2);
    end;

    with Canvas.Pen
    do begin
      if Color <> clBlack then Color:= clBlack;
      if Style <> psSolid then Style:= psSolid;
    end;

    if mbType <> mbVertical
    then begin
      Canvas.PolyGon([Point(R.Left +1, R.Top), Point(R.Left +3, R.Top),
        Point(R.Left +1, R.Top +2), Point(R.Left +1, R.Bottom -5), Point(R.Left +3, R.Bottom -3),
        Point(R.Left +1, R.Bottom -3)]);
      Canvas.PolyGon([Point(R.Left, R.Top), Point(R.Left -2, R.Top), Point(R.Left, R.Top +2),
        Point(R.Left, R.Bottom -5), Point(R.Left -2, R.Bottom -3), Point(R.Left, R.Bottom -3)]);
    end
    else begin
    end;
  end;

  GlobalRepaintFlag:= False;
  UnLockGlobalRepaint;
end;

procedure TCustomMenuBar2000.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
  // thanks to Frédéric Schneider for improvements in this routine

  procedure OrderMenuItems(var bWidth, bHeight: Integer);
  var
    iW,iH, i, rSize, bX, bY: Integer;
  begin
    rSize:= 0;
    if (Parent <> nil)
    then
      case mbType
      of
        mbVertical:   rSize:= Parent.ClientHeight;
        mbHorizontal: rSize:= Parent.ClientWidth;
        mbFloating:   rSize:= ParentClientWidth;
      end
    else
      rSize:= MaxInt;

    if rSize < 0 then Exit;

    for i:=0 to miRects.Count -1
    do begin
      with P_AM2000_MenuBarItemRect(miRects.Items[i])^
      do
        iW:= iR.Right-iR.Left;
      if rSize < iW then rSize:= iW;
    end;

    // offsets
    if rSize < GetOffsetX
    then rSize:= GetOffsetX;

    // start
    bX:= GetOffsetX;
    bY:= 0;
    iH:= 0;
    bWidth:= 0;
    bHeight:= 0;

    for I:= 0 to miRects.Count -1
    do
       with P_AM2000_MenuBarItemRect(miRects.Items[i])^
       do begin
         iW:= iR.Right-iR.Left;
         iH:= iR.Bottom-iR.Top;

         if i=0
         then bHeight:= iH +1;

         if (bX + iW) > rSize
         then begin
           Inc(bY, iH +1);
           Inc(bHeight, iH +1);
           bX:= 0;
         end;

         iR:= Rect(bX, bY, bX + iW, bY + iH);
         Inc(bX, iW);

         if bX > bWidth
         then bWidth:= bX;
       end;

    // sys buttons
    iW:= GetLastOffsetX;

    if iW > 0
    then begin
      if (bX + iW) > rSize
      then begin
        Inc(bY, iH +2);
        Inc(bHeight, iH +1);
        bX:= 0;
      end;

      Inc(bX, iW);
      if bX > bWidth
      then bWidth:= bX;

      if mbType = mbVertical
      then
        miSysBtnRect:= Rect(-iH, -iW, 0, 0)
      else
        miSysBtnRect:= Rect(-iW, -iH, 0, 0);
    end
    else
      FillChar(miSysBtnRect, SizeOf(miSysBtnRect), 0);

    // right-to-left reading
    if (Width > 0)
    and (GetBiDiMode <> bdLeftToRight)
    then begin
      if AWidth > 0
      then iW:= AWidth
      else iW:= Width;
      
      bX:= GetLastOffsetX;// + Buffer.Width - Width;

      for I:= 0 to miRects.Count -1
      do
        with P_AM2000_MenuBarItemRect(miRects.Items[i])^
        do
          iR:= Rect(iW - iR.Right - bX, iR.Top, iW - iR.Left -bX, iR.Bottom);
    end;
  end;

var
  I, W, H: Integer;
  CurItem: TMenuItem;
  miX1, miY1, SaveIndex: Integer;
  DC: HDC;
  R: TRect;
begin
  W:= 0;
  H:= 0;
  iSystemIconWidth:= GetSystemMetrics(SM_CYMENUSIZE) -2;

  // calculating interior's width and height
  if (FMenu <> nil)
  and not (csLoading in ComponentState)
  then begin
    ClearMiRects(miRects);
    if mbType = mbVertical
    then begin
       miX1:= 0;
       miY1:= GetOffsetX;
    end
    else begin
       miX1:= GetOffsetX;
       miY1:= 0;
    end;

    // calculate menu items' width
    for I:= 0 to GetMenuItemCount -1
    do begin
      CurItem:= GetMenuItem(I);
      if IsVisible(CurItem)
      then
        with GetMenuItemSize(CurItem)
        do begin
          R:= Rect(miX1, miY1, miX1 +(Cx +12), miY1 +(Cy +5));
          AddMiRects(miRects, CurItem, Rect(miX1, miY1, miX1 +(Cx +12), miY1 +(Cy +5)));
          Inc(miX1, Cx +12);
        end;
    end;

    OrderMenuItems(W, H);

    if mbType = mbVertical
    then
       for i:= 0 to miRects.Count -1
       do
           with P_AM2000_MenuBarItemRect(miRects.Items[i])^
           do
             iR:= Rect(H - iR.Bottom -1, iR.Left, H - iR.Top -1, iR.Right);

    // set minimal bounds
    if W = 0 then W:= 50;
    if H = 0 then H:= 10;

    if mbType = mbVertical
    then begin
      I:= W;
      W:= H;
      H:= I;
    end;

    case mbType of
      mbFloating: begin
                    AWidth:= W;
                    AHeight:= H;
                  end;

      mbHorizontal: if (Parent <> nil)
                    then begin
                       if Parent.ClientWidth < W
                       then
                         AWidth:= W
                       else
                       if Align in [alTop, alBottom, alClient]
                       then
                         AWidth:= Parent.ClientWidth
                       else
                       if AWidth = 0
                       then
                         AWidth:= W;

                       AHeight:= H;
                    end;

      mbVertical:   if (Parent <> nil)
                    then begin
                       if Parent.ClientHeight < H
                       then
                          AHeight:= H
                       else
                       if Align in [alLeft, alRight, alClient]
                       then
                         AHeight:= Parent.ClientHeight
                       else
                       if AHeight = 0
                       then
                         AHeight:= H;

                       AWidth:= W;
                    end;

    end;

    // system buttons
    OffsetRect(miSysBtnRect, AWidth, AHeight);

    // arranging buffer
    if (Buffer.Width <> AWidth)
    or (Buffer.Height <> AHeight)
    then begin
      Buffer.Handle:= CreateDibSectionEx(Buffer.Canvas.Handle, AWidth, AHeight, nil);
      ResetBuffer;
    end;


    // draw back
    if FTransparent
    and (Parent <> nil)
    then begin
      Back.Width:= AWidth;
      Back.Height:= AHeight;
      Include(mbState, mbsIgnorePaint);
{$IFDEF Delphi3OrHigher}
      Back.Canvas.Lock;
{$ENDIF}
      DC:= Back.Canvas.Handle;

      with Parent
      do begin
        ControlState:= ControlState + [csPaintCopy];
        SaveIndex:= SaveDC(DC);
        MoveWindowOrg(DC, -Self.Left, -Self.Top);
//        IntersectClipRect(DC, 0, 0, AWidth +1, AHeight +1);
        Perform(WM_ERASEBKGND, LongInt(DC), 0);
        Perform(WM_PAINT, LongInt(DC), 0);

        RestoreDC(DC, SaveIndex);
        ControlState:= ControlState - [csPaintCopy];
      end;

{$IFDEF Delphi3OrHigher}
      Back.Canvas.UnLock;
{$ENDIF}

      Exclude(mbState, mbsIgnorePaint);
    end;
  end;

  // inheriteance
  inherited;
end;

procedure TCustomMenuBar2000.cmMouseLeave(var Msg: TMessage);
begin
  if aiState = aiSunken
  then Exit;

  if (aiState = aiRaised)
  and not (mbsKeepSelected in mbState)
  then HideActiveItem;

  if IsTimerSet(nShowHiddenTimeout, TimerShow)
  then StopTimer;

  SetInsertBeforeItem(miNothingToInsert);
  Paint;
  MouseOverSystemButton:= sbNone;
end;

{$IFDEF Delphi3OrHigher}
procedure TCustomMenuBar2000.cmSysFontChanged(var Msg: TMessage);
begin
  inherited;
  if FOldFontHandle <> 0
  then begin
    SelectObject(Canvas.Handle, FOldFontHandle);
    DeleteObject(FSystemFontHandle);
    FSystemFontHandle:= 0;
    FOldFontHandle:= 0;
  end;
  UpdateMenuBar(True);
end;
{$ENDIF}

procedure TCustomMenuBar2000.wmSettingChange(var Msg: TMessage);
begin
  inherited;
  
  if FOldFontHandle <> 0
  then begin
    SelectObject(Canvas.Handle, FOldFontHandle);
    DeleteObject(FSystemFontHandle);
    FSystemFontHandle:= 0;
    FOldFontHandle:= 0;
  end;
  UpdateMenuBar(True);
end;

procedure TCustomMenuBar2000.cmFontChanged(var Msg: TMessage);
begin
  inherited;
  UpdateMenuBar(True);
end;

procedure TCustomMenuBar2000.cmParentFontChanged(var Msg: TMessage);
begin
  inherited;
  if FMenu <> nil
  then UpdateMenuBar(True);
end;


{ Mouse movements } 

procedure TCustomMenuBar2000.MouseMove(Shift: TShiftState; X, Y: Integer);
const
  LastX: Integer = 0;
  LastY: Integer = 0;
var
  I: Integer;
  R: TRect;
  CurItem: TMenuItem;
  P: TPoint;
  CanMove: Boolean;
begin
  inherited;

  // ignore little movements
  if (FMenu = nil)
  or (FMenuComponent = nil)
  or ((mbsPreview in mbState) and not (mbsIgnorePreview in mbState))
  or not (mbsWindowActive in mbState)
  then Exit;

  // disabled
  if (mbsDisabled in mbState)
  then begin
    RejectDragTarget;
    Exit;
  end;

  LastX:= X;
  LastY:= Y;
  P:= Point(X, Y);

  // activate tooltip window
  if (aiState = aiRaised)
  and (ToolTipWindow <> nil)
  then ToolTipWindow.Activate;

  // system menu?
  if GetOffsetX > 0
  then begin
     I:= -1;
     CurItem:= SystemMenu;
     R:= GetSystemIconRect;
     if PtInRect(R, Point(X,Y))
     then begin
       // don't redraw on duplicating
       if (ai = CurItem)
       and (aiState <> aiFlat)
       then Exit;

       MoveActiveToIndex(I, CurItem);
       Exit;
     end;
  end;

  if (ai <> nil)
  and (ai <> SystemMenu)
  then InsertBeforeParent:= ai.Parent;

  if ((Abs(X - LastX) > 2)
  or (Abs(Y - LastY) > 2))
  and (not FLocalOptions.Customizable)
  and IsCustomization(True)
  then begin
    RejectDragTarget;
    Include(mbState, mbsDisabled);
    Exit;
  end;

  // loop for each of menu items
  for I:= 0 to GetMenuItemCount -1
  do begin
    CurItem:= GetMenuItem(I);
    if not IsVisible(CurItem)
    then Continue;

    R:= GetMiRect(miRects, I, CurItem);

    if PtInRect(R, P)
    then begin
      // don't redraw on duplicating
      if (ai = CurItem)
      and (aiState <> aiFlat)
      then begin
        if (InsertBeforeItem <> ai)
        then begin
          SetInsertBeforeItem(ai);
          Paint;
        end;

        // ai.OnMouseMove
        if (ai <> nil)
        and (ai is TMenuItem2000)
        and Assigned(TMenuItem2000(ai).OnMouseMove)
        then TMenuItem2000(ai).OnMouseMove(ai, Shift, X - R.Left, Y - R.Top);

        if (aiState = aiRaised)
        and not (IsTimerSet(nHotTrackTimeout, OnHotTrack))
        then SetTimer(nDeactivateTimeout, OnDeactivate);

        Exit;
      end;

      // move active item
      MoveActiveToIndex(I, CurItem);

      // ai.OnMouseMove
      if (ai <> nil)
      and (ai is TMenuItem2000)
      and Assigned(TMenuItem2000(ai).OnMouseMove)
      then TMenuItem2000(ai).OnMouseMove(ai, Shift, X - R.Left, Y - R.Top);

      // start moving
      if IsCustomization(FLocalOptions.Customizable)
      then begin
        // ai.OnStartDrag
        CanMove:= True;

        if (ai <> nil)
        and (ai is TMenuItem2000)
        and Assigned(TMenuItem2000(ai).OnStartDrag)
        then TMenuItem2000(ai).OnStartDrag(ai, CanMove);

        if not CanMove
        then Exit;

        SetInsertBeforeItem(ai);
        if aiState <> aiFraming
        then begin
          aiState:= aiFraming;
          MenuComponent.Form.Perform(wm_SetState, ssFraming, 1);
        end;

        InsertBeforeParent:= ai.Parent;

        // drag window
        if ActiveDragWindow = nil
        then begin
          with ClientToScreen(Point(0, 0))
          do OffsetRect(R, X, Y - (R.Top + R.Bottom) div 2);

          InflateRect(R, FLocalOptions.Margins.Frame, FLocalOptions.Margins.Frame);
          ActiveDragWindow:= T_AM2000_DragWindow.CreateRect(Buffer.Canvas.Font, R, FLocalOptions, GetCtl3D);
          T_AM2000_DragWindow(ActiveDragWindow).SilentShow;
        end;

        PaintActiveItem;
      end;

      Exit;
    end;
  end;

{  // start moving
  if IsCustomization(FLocalOptions.Customizable)
  then begin
    SetInsertBeforeItem(miInsertAtTheEnd);
    aiState:= aiFraming;
    Paint;
    SetDragCursor;
  end;}

  { paint System Buttons: }
  MouseOverSystemButton:= sbNone;
  if PtInRect(GetSysBtnRect(sbClose), P)
  then MouseOverSystemButton:= sbClose;

  if PtInRect(GetSysBtnRect(sbRestore), P)
  then MouseOverSystemButton:= sbRestore;

  if PtInRect(GetSysBtnRect(sbMinimize), P)
  then MouseOverSystemButton:= sbMinimize;

  if (SystemButtonPressed <> MouseOverSystemButton)
  then SystemButtonPressed:= sbNone;

  PaintSystemButtons(True);

  if aiState = aiRaised
  then KillActiveItem;
end;

procedure TCustomMenuBar2000.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  R: TRect;
  F: TForm;
  SaveAI: TMenuItem;
begin
  inherited;

  if (FMenuComponent = nil)
  then Exit;

  // onMouseDown
  if (ai <> nil)
  and (ai is TMenuItem2000)
  and Assigned(TMenuItem2000(ai).OnMouseDown)
  then
    with GetMiRect(miRects, aiIndex, ai)
    do TMenuItem2000(ai).OnMouseDown(ai, Button, Shift, X - Left, Y - Top);


  // exit when other key
  if Button <> mbLeft
  then begin
    KillActivePopupMenu2000(True, True);
    Exit;
  end;

  // disable tooltip window
  if (ToolTipWindow <> nil)
  then ToolTipWindow.Deactivate;

  if mbsPreview in mbState
  then begin
    SaveAI:= ai;
    Include(mbState, mbsIgnorePreview);
    MouseMove(Shift, X, Y);
    Exclude(mbState, mbsIgnorePreview);

    if SaveAI <> ai
    then Include(mbState, mbsIgnoreOnMouseUp);

    ActiveMenuItem:= ai;
    Repaint;

    if MenuComponent.FormOnScreen
    then MenuComponent.Form.Repaint;

    if FormDesigner <> nil
    then FormDesigner.SelectComponent(ai);
  end;

  // disable menu item
  if (aiState in [aiRaised, aiFlat])
  and IsEnabled(ai)
  then Include(mbState, mbsIgnoreOnMouseUp);

  if not (mbsWindowActive in mbState)
  then begin
    Include(mbState, mbsWindowActive);
    aiState:= aiRaised;
    UpdateMenubar(False);
  end;

  if (EnableCustomization)
  and (FLocalOptions.Customizable)
  and ((aiState = aiSunken) or (FLocalOptions.Customizable and not HasSubMenu(ai)))
  then ActiveMenuItem:= ai;

  if (aiState = aiRaised)
  then begin
    if (ai is TMenuItem2000)
    and (TMenuItem2000(ai).AttachMenu <> nil)
    then TCustomPopupMenu2000(TMenuItem2000(ai).AttachMenu).PrepareForPopup(True);

    if (ai = SystemMenu)
    or (GetCount(ai) > 0)
    then
      PopupActiveItem(False)

    else begin
      aiState:= aiSunken;
      PaintActiveItem;
      Exclude(mbState, mbsIgnoreOnMouseUp);
    end;

    Exit;
  end;

  // check for menu items
  F:= TForm(OwnerForm);
  if (F <> nil)
  and (F.ActiveMdiChild <> nil)
  and (F.ActiveMdiChild.WindowState = wsMaximized)
  then
    with F.ActiveMdiChild do begin
      P:= Point(X, Y);

      R:= GetSysBtnRect(sbClose);
      SystemButtonPressed:= sbNone;

      if PtInRect(R, P)
      and (biSystemMenu in BorderIcons)
      then SystemButtonPressed:= sbClose;

      R:= GetSysBtnRect(sbRestore);
      if PtInRect(R, P)
      and (biMaximize in BorderIcons)
      then SystemButtonPressed:= sbRestore;

      R:= GetSysBtnRect(sbMinimize);
      if PtInRect(R, P)
      and (biMinimize in BorderIcons)
      then SystemButtonPressed:= sbMinimize;

      // if system button is pressed then kill opened
      // menu and repaint menu bar
      if SystemButtonPressed <> sbNone
      then begin
        KillActiveItem;
        Paint;
      end;
    end;
end;

procedure TCustomMenuBar2000.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SysCmd: array [T_AM2000_SystemButton] of UINT =
    (0, sc_Minimize, sc_Restore, sc_Close);
var
  F: TForm;
begin
  inherited;

  if (FMenuComponent = nil)
  then Exit;

  // enable menu bar
  if mbsDisabled in mbState
  then begin
    Exclude(mbState, mbsDisabled);
    RestoreCursorDefault(crNone);
  end;

  // onMouseUp
  if (ai <> nil)
  and (ai is TMenuItem2000)
  and Assigned(TMenuItem2000(ai).OnMouseUp)
  then
    with GetMiRect(miRects, aiIndex, ai)
    do TMenuItem2000(ai).OnMouseUp(ai, Button, Shift, X - Left, Y - Top);


  if Button <> mbLeft then Exit;

  // check for system buttons
  if (SystemButtonPressed <> sbNone)
  and (OwnerForm <> nil)
  then begin
    F:= TForm(OwnerForm).ActiveMdiChild;
    if (F <> nil)
    then F.Perform(wm_SysCommand, SysCmd[SystemButtonPressed], 0);

    SystemButtonPressed:= sbNone;
    UpdateMenuBar(False);
    Exit;
  end;

  // cancel menu item move
  if (aiState = aiFraming)
  then begin
    EndCustomization(True);
    MenuComponent.Form.Perform(wm_SetState, ssFraming, 0);

    Exclude(mbState, mbsIgnoreOnMouseUp);
    KillActivePopupMenu2000(True, True);
    Exit;
  end;

  // ignore this mouse up event
  if mbsIgnoreOnMouseUp in mbState
  then begin
//    ActiveMenuItem:= nil;
    Exclude(mbState, mbsIgnoreOnMouseUp);
    Exit;
  end;

  // cancel move
  ActiveMenuItem:= nil;
  
  // menu item pressed
  if (aiState = aiSunken)
  then
    if (ai <> nil)
    then begin
      KillActivePopupMenu2000(True, True);

      if (FMenuComponent <> nil)
      and (FMenuComponent.FormOnScreen)
      then FMenuComponent.Form.Perform(wm_HideSilent, 0, 0);

      FullShowCaret;

      aiState:= aiRaised;
      PaintActiveItem;
      if Assigned(ai.OnClick)
      then ai.OnClick(ai);

      if FormDesigner <> nil
      then FormDesigner.SelectComponent(Self);
    end
    else
    if (OwnerForm <> nil)
    then
      TForm(OwnerForm).ActiveMdiChild.Close;
end;

procedure TCustomMenuBar2000.HideActiveItem;
begin
  StopTimer;

  // hide raised item
  if FRaisedForm <> nil
  then T_AM2000_RaisedItemForm(FRaisedForm).SilentHide;

  // remove hidden flag
  if (MenuComponent <> nil)
  then MenuComponent.Form.Perform(wm_SetState, ssHidden, 0);

  // draw
  if aiState <> aiFlat
  then begin
    aiState:= aiFlat;
    PaintActiveItem;

    // ai.OnExit
    if (ai <> nil)
    and (ai is TMenuItem2000)
    and Assigned(TMenuItem2000(ai).OnExit)
    then TMenuItem2000(ai).OnExit(ai);

    aiState:= aiFlat;
    mbState:= mbState - [mbsIgnoreOnMouseUp, mbsKeepSelected, mbsIgnoreAnimation, mbsShowAccelerators];
    UpdateMenuBar(False);
  end;
end;

procedure TCustomMenuBar2000.MoveActiveTo(NewItem: TMenuItem);
  // set new ActiveItem
var
  IsMenuOpened: Boolean;
  SaveAiState: T_AM2000_aiState;
begin
  if (NewItem = nil)
  or ((ai = NewItem) and (aiState <> aiFlat))
  or (csDestroying in ComponentState)
  or (FMenuComponent = nil)
  then Exit;

  IsMenuOpened:=
    TCustomPopupMenu2000(MenuComponent).FormOnScreen
    or ((aiState = aiSunken) and (not (mbsKeepSelected in mbState)))
    or (aiState = aiFraming);

  if Desktop <> nil
  then Desktop.IgnoreClear:= IsMenuOpened;

  if IsMenuOpened
  then MenuComponent.Form.Perform(wm_HideSilent, 0, 0);

  ProcessPaintMessages;

  // draw old activeitem
  if (ai <> NewItem)
  and (ai <> nil)
  and (ai <> SystemMenu)
  and (aiState <> aiFlat)
  then begin
    SaveAiState:= aiState;
    aiState:= aiFlat;
    PaintItem(Buffer.Canvas, ai, aiRect, True, True);
    aiState:= SaveAiState;

    // ai.OnExit
    if (ai <> nil)
    and (ai is TMenuItem2000)
    and Assigned(TMenuItem2000(ai).OnExit)
    then TMenuItem2000(ai).OnExit(ai);
  end;


  // draw new activeitem
  ai:= NewItem;

  if (aiState = aiFlat)
  and IsEnabled(ai)
  then
    if IsMenuOpened
    then aiState:= aiSunken
    else aiState:= aiRaised;

  if ai = SystemMenu
  then
    aiRect:= GetSystemIconRect
  else
  if ai <> nil
  then begin
    aiRect:= GetMiRect(miRects, aiIndex, ai);
  end;

  // ai.OnEnter
  if (ai <> nil)
  and (ai <> SystemMenu)
  and (ai is TMenuItem2000)
  and (aiState <> aiFlat)
  and Assigned(TMenuItem2000(ai).OnEnter)
  then TMenuItem2000(ai).OnEnter(ai);


  // get the desktop
  if (mfRaiseMenuBarItem in FLocalOptions.Flags)
  then
    with aiRect, ClientToScreen(Point(Left, Top))
    do Desktop.GetBitmapNoLock(0, X, Y, Right - Left, Bottom - Top);

  // paint
  if (ai <> nil)
  and (ai <> SystemMenu)
  and ((not IsMenuOpened) or (not (mfRaiseMenuBarItem in FLocalOptions.Flags)))
  then PaintItem(Buffer.Canvas, ai, aiRect, True, True);

  // if no item or no submenu
  if (ai <> SystemMenu)
  and not HasSubmenu(ai)
  then Exit;

  // open submenu
  if IsMenuOpened
  then begin
    GdiFlush;
    Include(mbState, mbsSibling);

    if (aiState = aiSunken)
    or (aiState = aiFraming)
    then PopupMenuRect(False, (mbsKeepSelected in mbState));
  end
  else begin
    if FHotTrack
    and not (mbsKeepSelected in mbState)
    then SetTimer(nHotTrackTimeout, OnHotTrack)
    else
    if aiState = aiRaised
    then SetTimer(nDeactivateTimeout, OnDeactivate);
  end;
end;

procedure TCustomMenuBar2000.MoveActiveToIndex(NewIndex: Integer; NewItem: TMenuItem);
  // set new ActiveItem(ai) and ActiveItemIndex(aiIndex)
begin
  if NewItem = SystemMenu
  then NewIndex:= -1;

  aiIndex:= NewIndex;

  MoveActiveTo(NewItem);

  // set aiIndex
  if (ai = nil)
  then aiIndex:= -1
  else aiIndex:= NewIndex;
end;

procedure TCustomMenuBar2000.SetActiveItemIndex(Index: Integer);
begin
  if Index < GetMenuItemCount
  then MoveActiveToIndex(Index, GetMenuItem(Index));
end;

procedure TCustomMenuBar2000.PopupActiveItem(SelectFirst: Boolean);
begin
  if IsEnabled(ai)
  then aiState:= aiSunken;

  // repaint
  PaintActiveItem;

  // popup submenu
  PopupMenuRect(False, SelectFirst);
end;

function TCustomMenuBar2000.KillActiveItem{(const LostToObjectInspector}: Boolean;
begin
  if (mbsPreview in mbState)
  and ((Name = SPreviewMenuBar)
  or IsObjectInspectorUnderCursor)
  then Exit;

  if not KillActivePopupMenu2000(False, False)
  then
    Result:= False

  else begin
    HideActiveItem;

    if (FMenuComponent <> nil)
    and (FMenuComponent.FormOnScreen)
    then FMenuComponent.Form.Perform(wm_HideSilent, 0, 0);
    FullShowCaret;
    Result:= True;

    if mbsPreview in mbState
    then Repaint;
  end;
end;


{ Properties }

procedure TCustomMenuBar2000.SetMenu(Value: TMenu);
begin
  FMenu:= Value;
  UpdateMenuBar(True);
end;

procedure TCustomMenuBar2000.UpdateMenuBar(RebuildMenu: Boolean);
var
  SaveIdx, Count: Integer;
begin
  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  or not Visible
  then Exit;

  if not ComponentLoaded
  then DoLoaded;

  // reset bounds
  if RebuildMenu
  then begin
    if ai <> nil
    then SaveIdx:= aiIndex
    else SaveIdx:= 0;

    // rebuild main menu
    if (FMenu is TCustomMainMenu2000)
    then TCustomMainMenu2000(FMenu).RebuildMergedMenuItems;

    if (FMenu is TCustomPopupMenu2000)
    then TCustomPopupMenu2000(FMenu).PrepareForPopup(False);

    // clear bounds
    SetBounds(Left, Top, 0, 0);

    Count:= GetMenuItemCount;
    if (Count > 0)
    and (SaveIdx >=0)
    and (SaveIdx < Count)
    then begin
      ai:= GetMenuItem(SaveIdx);
      aiIndex:= SaveIdx;
    end
    else begin
      ai:= nil;
      aiIndex:= -1;
    end;

    RebuildToolTipWindow;
  end;

  MouseOverSystemButton:= sbNone;
  ResetBuffer;
  Paint;
end;

procedure TCustomMenuBar2000.RebuildToolTipWindow;
var
  I: Integer;
  R: TRect;
  CurItem: TMenuItem;
begin
  ToolTipWindow.Free;
  ToolTipWindow:= nil;

  if (Menu = nil)
  or ((Menu is TCustomMainMenu2000)
  and (not TCustomMainMenu2000(Menu).ShowHint)
  or (TCustomMainMenu2000(Menu).StatusBar <> nil))
  or ((Menu is TCustomMainMenu2000)
  and (not TCustomPopupMenu2000(Menu).ShowHint)
  or (TCustomPopupMenu2000(Menu).StatusBar <> nil))
  then Exit;

  // add tooltips
  ToolTipWindow:= T_AM2000_ToolTipWindow.Create(Self);
  R:= Rect(0, 0, 0, 0);
  for I:= 0 to GetMenuItemCount -1
  do begin
    R.Left:= R.Right;
    CurItem:= GetMenuItem(I);
    if IsVisible(CurItem)
    then Continue;

    with GetMenuItemSize(CurItem)
    do begin
      Inc(R.Right, Cx +12);
      R.Bottom:= R.Top + Cy +5;
    end;

    if (CurItem.Hint <> '')
    and (CurItem.Hint <> #1)
    and (ToolTipWindow <> nil)
    then ToolTipWindow.AddTool(R, CurItem.Hint);
  end;
end;

procedure TCustomMenuBar2000.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  // remove reference
  if (Operation = opRemove)
  and (AComponent = FMenu)
  then SetMenu(nil);

  if (Operation = opInsert)
  and (AComponent is TMainMenu)
  and (FMenu = nil)
  then begin
    FMenu:= TMenu(AComponent);
    PostMessage(Handle, wm_UpdateMenuBar, 1, 0);
  end;
end;

procedure TCustomMenuBar2000.SetDisableAltKeyUp(Value: Boolean);
begin
  if Value
  then Include(mbState, mbsDisableAltKeyUp)
  else Exclude(mbState, mbsDisableAltKeyUp);
end;

function TCustomMenuBar2000.GetBitmapSize(Item: TMenuItem): TSize;
begin
  Result.Cx:= 0;
  Result.Cy:= 0;
  if (Item = nil) then Exit;

  // menu item 2000
  if (Item is TMenuItem2000)
  then begin
    if TMenuItem2000(Item).HasBitmap
    then begin
      Result.Cx:= TMenuItem2000(Item).Bitmap.Width;
      Result.Cy:= TMenuItem2000(Item).Bitmap.Height;
    end


    // default index
    else
    if (TMenuItem2000(Item).DefaultIndex > -1)
    then begin
      Result.Cx:= 16;
      Result.Cy:= 16;
    end

    // item index
    else
    if
{$IFNDEF Delphi4OrHigher}
       (Item is TMenuItem2000)
    and (TMenuItem2000(Item).ImageIndex <> -1)
{$ELSE}
       (Item.ImageIndex <> -1)
    and (Menu.Images <> nil)
{$ENDIF}
    then begin
{$IFDEF Delphi4OrHigher}
      Result.Cx:= Menu.Images.Width;
      Result.Cy:= Menu.Images.Height;

{$ELSE}
      if (Menu is TCustomMainMenu2000)
      then
        with TCustomMainMenu2000(Menu) do
          if Images <> nil
          then begin
            Result.Cx:= TImageList(Images).Width;
            Result.Cy:= TImageList(Images).Height;
          end;

      if (Menu is TCustomPopupMenu2000)
      then
        with TCustomPopupMenu2000(Menu) do
          if Images <> nil
          then begin
            Result.Cx:= TImageList(Images).Width;
            Result.Cy:= TImageList(Images).Height;
          end;
{$ENDIF}
    end

    // default bitmap
    else
      if (TMenuItem2000(Item).DefaultIndex = -1)
      and MenuItemCache.HasBitmap(Item.Caption)
      then begin
        Result.Cx:= 16;
        Result.Cy:= 16;
      end

    else
      if TMenuItem2000(Item).HasBitmap
      then begin
        Result.Cx:= TMenuItem2000(Item).Bitmap.Width +4;
        Result.Cy:= TMenuItem2000(Item).Bitmap.Height;
      end

  end

  // original item
  else
    if MenuItemCache.HasBitmap(Item.Caption)
    then begin
      Result.Cx:= 16;
      Result.Cy:= 16;
    end
    
{$IFDEF Delphi4OrHigher}
    else
    if (not Item.Bitmap.Empty)
    then begin
      Result.Cx:= Item.Bitmap.Width;
      Result.Cy:= Item.Bitmap.Height;
    end
{$ENDIF}
end;

procedure TCustomMenuBar2000.DblClick;
begin
  inherited;

  // nothing is selected
  if aiState = aiFlat then Exit;

  if (ai = SystemMenu)
  and (OwnerForm <> nil)
  and (TForm(OwnerForm).ActiveMdiChild <> nil)
  then begin // close current child
    Include(mbState, mbsIgnoreOnMouseUp);
    KillActiveItem;
    TForm(OwnerForm).ActiveMdiChild.Perform(wm_SysCommand, sc_Close, 0);
    Exit;
  end;

  if CheckForHidden(ai)
  and (not (mfNoAutoShowHidden in FLocalOptions.Flags))
  then begin
    Include(mbState, mbsIgnoreOnMouseUp);
    MenuComponent.Form.Perform(wm_Unhide, 0, 0);
  end;
end;

procedure TCustomMenuBar2000.TimerShow(Sender: TObject);
var
  P: TPoint;
begin
  StopTimer;
  Exclude(mbState, mbsIgnoreOnMouseUp);

  if (FMenuComponent = nil)
  or (mfHiddenIsVisible in MenuComponent.Options.Flags)
  then Exit;

  // check is mouse cursor still over menu bar
  GetCursorPos(P);
  if (aiState = aiSunken)
  and PtInRect(ClientRect, ScreenToClient(P))
  then MenuComponent.Form.Perform(wm_Unhide, 0, 0);
end;

{$IFDEF Delphi4OrHigher}
procedure TCustomMenuBar2000.InitiateAction;
var
  I: Integer;
  mi: TMenuItem;
begin
  if Menu <> nil then
    for I := 0 to GetMenuItemCount - 1 do begin
      mi:= GetMenuItem(I);
      if IsVisible(mi)
      then mi.InitiateAction;
    end;
end;
{$ENDIF}

procedure TCustomMenuBar2000.SetHotTrack(const Value: Boolean);
begin
  FHotTrack:= Value;
//  KillActiveItem;
end;

procedure TCustomMenuBar2000.SetTransparent(Value: Boolean);
begin
  if FTransparent = Value then Exit;

  FTransparent:= Value;

  if Value
  then ControlStyle := ControlStyle - [csOpaque]
  else ControlStyle := ControlStyle + [csOpaque];

  // create a bitmap
  if FTransparent
  then
    Back:= TBitmap.Create
  else begin
    Back.Free;
    Back:= nil;
  end;

  KillActiveItem;

  // update
  if csDesigning in ComponentState
  then UpdateMenuBar(False);

end;

procedure TCustomMenuBar2000.DoLoaded;
begin
  Loaded;
end;

procedure TCustomMenuBar2000.Repaint;
begin
  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  then Exit;

  UpdateMenuBar(False);
end;


procedure TCustomMenuBar2000.Refresh;
begin
  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  or (GlobalRepaintLockCount > 0)
  then Exit;

  FLocalOptions.Assign(Options);
  with FLocalOptions, Margins
  do begin
    Alignment:= taCenter;
    Left:= 0;
    Right:= 0;
    Gutter:= 0;
  end;

  UpdateMenuBar(True);

  if (MenuComponent <> nil)
  and MenuComponent.FormOnScreen
  then MenuComponent.Form.Update;
end;

procedure TCustomMenuBar2000.Update;
begin
  Repaint;
end;

procedure TCustomMenuBar2000.SetVersion(Value: T_AM2000_Version);
begin
end;

function TCustomMenuBar2000.Options: T_AM2000_Options;
begin
  if Menu is TCustomMainMenu2000
  then
     Result:= TCustomMainMenu2000(Menu).Options
  else
  if Menu is TCustomPopupMenu2000
  then
     Result:= TCustomPopupMenu2000(Menu).Options
  else begin
    if FDefaultOptions = nil
    then FDefaultOptions:= T_AM2000_MenuOptions.Create(nil);
    Result:= FDefaultOptions;
  end;
end;

function TCustomMenuBar2000.GetSystemFont: Boolean;
begin
  if Menu is TCustomMainMenu2000
  then
    Result:= TCustomMainMenu2000(Menu).SystemFont
  else
  if Menu is TCustomPopupMenu2000
  then
    Result:= TCustomPopupMenu2000(Menu).SystemFont
  else
    Result:= True;
end;

function TCustomMenuBar2000.GetParentFont: Boolean;
begin
  if Menu is TCustomMainMenu2000
  then
    Result:= TCustomMainMenu2000(Menu).ParentFont
  else
  if Menu is TCustomPopupMenu2000
  then
    Result:= TCustomPopupMenu2000(Menu).ParentFont
  else
    Result:= False;
end;

function TCustomMenuBar2000.GetCtl3D: Boolean;
var
  Ctl3D, SystemCtl3D: Boolean;
  BoolTemp: WordBool;
begin
  if Menu is TCustomMainMenu2000
  then begin
    Ctl3D:= TCustomMainMenu2000(Menu).Ctl3D;
    SystemCtl3D:= TCustomMainMenu2000(Menu).SystemCtl3D;
  end
  else
  if Menu is TCustomPopupMenu2000
  then begin
    Ctl3D:= TCustomPopupMenu2000(Menu).Ctl3D;
    SystemCtl3D:= TCustomPopupMenu2000(Menu).SystemCtl3D;
  end
  else begin
    Ctl3D:= True;
    SystemCtl3D:= False;
  end;

  if SystemCtl3D
  then
    Result:= (not SystemParametersInfo(SPI_GetFlatMenu, 0, @BoolTemp, 0))
      or (not BoolTemp)
  else
    Result:= Ctl3D;
end;

function TCustomMenuBar2000.GetBiDiMode: TBiDiMode;
begin
  if Menu is TCustomMainMenu2000
  then
    Result:= TCustomMainMenu2000(Menu).BiDiMode
  else
  if Menu is TCustomPopupMenu2000
  then
    Result:= TCustomPopupMenu2000(Menu).BiDiMode
  else
    Result:= bdLeftToRight;
end;

function TCustomMenuBar2000.GetSystemShadow: Boolean;
begin
  if Menu is TCustomMainMenu2000
  then
    Result:= TCustomMainMenu2000(Menu).SystemShadow
  else
  if Menu is TCustomPopupMenu2000
  then
    Result:= TCustomPopupMenu2000(Menu).SystemShadow
  else
    Result:= False;
end;

function TCustomMenuBar2000.IsAlignStored: Boolean;
begin
  Result:= Align <> alTop;
end;

function TCustomMenuBar2000.GetAlign: TAlign;
begin
  Result:= inherited Align;
end;

procedure TCustomMenuBar2000.SetAlign(const Value: TAlign);
begin
  case Value
  of
    alLeft, alRight: mbType:= mbVertical;
    else mbType:= mbHorizontal;
  end;

  ResetBuffer;

  inherited Align:= Value;
end;

function TCustomMenuBar2000.GetFont: TFont;
begin
  if Menu is TCustomMainMenu2000
  then
    Result:= TCustomMainMenu2000(Menu).Font
  else
  if Menu is TCustomPopupMenu2000
  then
    Result:= TCustomPopupMenu2000(Menu).Font
  else
    Result:= Font;
end;

procedure TCustomMenuBar2000.OnHotTrack(Sender: TObject);
begin
  StopTimer;

  if not IsOkControlUnderCursor
  then begin
    HideActiveItem;
    Exit;
  end;

  aiState:= aiSunken;
  PaintActiveItem;
  PopupMenuRect(False, (mbsKeepSelected in mbState));
end;

function TCustomMenuBar2000.GetVersion: T_AM2000_Version;
begin
  Result:= SVersion;
end;

procedure TCustomMenuBar2000.wmSetState(var Msg: TMessage);
begin
  case Msg.wParam of
    ssFraming:
      begin
        if Msg.lParam = 0
        then begin
          Exclude(mbState, mbsDisabled);

          if aiState = aiFraming
          then aiState:= aiSunken
          else aiState:= aiFlat;
        end

        else
          if FLocalOptions.Customizable
          then begin
            aiState:= aiFraming;
            Include(mbState, mbsRepaintOnMouseMove);
          end;
      end;

    ssEnabled:
      if Msg.lParam <> 0
      then Exclude(mbState, mbsDisabled)
      else Include(mbState, mbsDisabled);

    ssPreview:
      if Msg.lParam <> 0
      then Include(mbState, mbsPreview)
      else Exclude(mbState, mbsPreview);

    else
      Exit;
  end;

  Msg.Result:= 1;
end;

function TCustomMenuBar2000.GetMenuRect: TSize;
var
  I: Integer;
begin
  Result.Cx:= 0;
  Result.Cy:= 0;
  if FMenu = nil then Exit;

  for I:= 0 to miRects.Count -1
  do
    with P_AM2000_MenuBarItemRect(miRects.Items[i])^
    do begin
      Inc(Result.Cx, (iR.Right - iR.Left));
      if Result.Cy < (iR.Bottom - iR.Top)
      then Result.Cy:= iR.Bottom - iR.Top;
    end;
end;

procedure TCustomMenuBar2000.SetMenuItem(AItem: TMenuItem);
var
  M, CurItem: TMenuItem;
  I: Integer;
begin
  if (FMenuComponent = nil)
  then Exit;
  M:= AItem;

  while M.Parent.Parent <> nil
  do M:= M.Parent;

  if ai <> M
  then begin
    if MenuComponent.FormOnScreen
    then MenuComponent.Form.Perform(wm_HideSilent, 0, 0);

    for I:= 0 to GetMenuItemCount -1
    do begin
      CurItem:= GetMenuItem(I);
      if CurItem = M
      then begin
        MoveActiveToIndex(I, M);
        Break;
      end;
    end;
  end;

  if not MenuComponent.FormOnScreen
  then PopupActiveItem(False);

  MenuComponent.Selected:= AItem; 

  UpdateMenubar(False);
end;


{$IFDEF ACTIVEX}
procedure TCustomMenuBar2000.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('InternalMenu', ReadData, WriteData, True);
end;

procedure TCustomMenuBar2000.ReadData(Reader: TReader);
begin
  Reader.ReadComponent(FMenu);
end;

procedure TCustomMenuBar2000.WriteData(Writer: TWriter);
begin
  Writer.WriteComponent(FMenu);
end;
{$ENDIF}

function TCustomMenuBar2000.GetItemAtPoint(const P: TPoint): TMenuItem;
var
  I: Integer;
begin
  if PtInRect(GetSystemIconRect, P)
  then begin
    Result:= SystemMenu;
    Exit;
  end;

  for I:= 0 to miRects.Count -1
  do
    with P_AM2000_MenuBarItemRect(miRects[I])^
    do
      if PtInRect(iR, P)
      then begin
        Result:= mi;
        Exit;
      end;

  Result:= nil;
end;

procedure TCustomMenuBar2000.OnDeactivate(Sender: TObject);
begin
  StopTimer;

  if not IsOkControlUnderCursor
  then HideActiveItem;
end;

procedure TCustomMenuBar2000.wmEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result:= 1;
end;

procedure TCustomMenuBar2000.wmPaintOnCanvas(var Msg: TMessage);
var
  PF, PT: TPoint;
begin
  if (Buffer.Width = 0)
  or (Buffer.Height = 0)
  or ((Msg.LParam <> 0)
  and (PWmPaintOnCanvas(Msg.LParam).RebuildMenu))
  then begin
    // rebuild menu item
    ResetBuffer;

    SetBounds(0, 0, 0, 0);

    // set selected index
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

procedure TCustomMenuBar2000.wmLButtonDown(var Msg: TWMMouse);
begin
  inherited;
end;

procedure TCustomMenuBar2000.cmDesignHitTest(var Msg: TCMDesignHitTest);
begin
  Msg.Result:= 1;
end;

{ T_AM2000_RaisedItemForm }

constructor T_AM2000_RaisedItemForm.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner{$IFDEF CBuilder1}, 0{$ENDIF});

  BorderStyle:= bsNone;
  FormStyle:= fsStayOnTop;
  Position:= poDesigned;
  SetBounds(0, 0, 0, 0);

  if GetDropShadow // have a drop shadow?
  then begin
    DropShadow:= T_AM2000_DropShadow.Create(Self);
    DropShadow.Color:= TCustomMenuBar2000(AOwner).FLocalOptions.Colors.DropShadow;
  end;
end;

procedure T_AM2000_RaisedItemForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.style:= Params.WindowClass.style or CS_SAVEBITS;
end;

destructor T_AM2000_RaisedItemForm.Destroy;
begin
  DropShadow.Free;
  if Owner is TCustomMenuBar2000
  then TCustomMenuBar2000(Owner).FRaisedForm:= nil;
  inherited;
end;

procedure T_AM2000_RaisedItemForm.Paint;
var
  SaveFrame: Integer;
  SavePressed, SavePressedText, SaveHighlight: TColor;
  F: TForm;

  procedure DrawBevelLine(const F1: Boolean; const Side: T_AM2000_Side; AR: TRect);
  begin
    with TCustomMenuBar2000(Owner), FLocalOptions, Self.Canvas
    do begin
      if F1
      then
        if Side in [sdTop, sdLeft]
        then Brush.Color:= Colors.Bevel
        else Brush.Color:= Colors.BevelShadow
      else begin
        if Colors.Gutter = clNone
        then Exit;

        Brush.Color:= Colors.Gutter;

        if Side in [sdTop, sdBottom]
        then InflateRect(AR, -1, 0);
      end;

      FillRect(AR);
    end;
  end;

begin
  if (Width = 0)
  or (Height = 0)
  then Exit;

  // get all infor from the owner
  with TCustomMenuBar2000(Owner), FLocalOptions
  do begin
    SaveFrame:= Margins.Frame;
    SavePressed:= Colors.Pressed;
    SavePressedText:= Colors.PressedText;

    Margins.Frame:= 0;

    if Colors.Gutter <> clNone
    then Colors.Pressed:= Colors.Gutter
    else Colors.Pressed:= Colors.Menu;

    Colors.PressedText:= Colors.MenuText;

    // draw background
    if HasSkin
    and not Skin.RaisedItemBackground.Empty
    then begin
      with Skin.RaisedItemBackground
      do
        StretchBlt(Self.Canvas.Handle, 0, 0, Self.Width, Self.Height,
          Canvas.Handle, 0, 0, Width, Height, SrcCopy);

      SaveHighlight:= Colors.Highlight;
      Colors.Highlight:= clNone;
      PaintItem(Self.Canvas, ai, Self.ClientRect, False, False);
      Colors.Highlight:= SaveHighlight;
    end
    else
      PaintItem(Self.Canvas, ai, Self.ClientRect, False, True);

    if ai = SystemMenu
    then begin
      F:= TForm(OwnerForm);
      PaintMenuIcon(F, F.ActiveMdiChild, Self.Canvas.Handle, 1, 2, iSystemIconWidth);
    end;

    Colors.Pressed:= SavePressed;
    Colors.PressedText:= SavePressedText;

    DrawBevelLine(DrawLeft, sdLeft, Rect(0, 0, Margins.Bevel, Self.Height));
    DrawBevelLine(DrawRight, sdRight, Rect(Self.Width - Margins.Bevel, 0, Self.Width, Self.Height));
    DrawBevelLine(DrawTop, sdTop, Rect(0, 0, Self.Width, Margins.Bevel));
    DrawBevelLine(DrawBottom, sdBottom, Rect(0, Self.Height - Margins.Bevel, Self.Width, Self.Height));

    Margins.Frame:= SaveFrame;
  end;
end;

procedure T_AM2000_RaisedItemForm.DrawBevel(const ADrawLeft, ADrawRight, ADrawTop,
  ADrawBottom: Boolean);
begin
  DrawLeft:= ADrawLeft;
  DrawRight:= ADrawRight;
  DrawTop:= ADrawTop;
  DrawBottom:= ADrawBottom;
  Paint;
end;

procedure T_AM2000_RaisedItemForm.SilentHide;
begin
  if DropShadow <> nil
  then DropShadow.Hide;

  if (Width <> 0)
  or (Height <> 0)
  then begin
    ShowWindow(Handle, sw_Hide);
    SetBounds(Left, Top, 0, 0);
  end;
end;

procedure T_AM2000_RaisedItemForm.SilentShow;
begin
  ShowWindow(Handle, sw_ShowNA);
  SetWindowPos(Handle, hwnd_TopMost, Left, Top, Width, Height, FormFlags);

  if DropShadow <> nil
  then DropShadow.Show(Handle);
end;

procedure T_AM2000_RaisedItemForm.Update;
var
  D: Integer;
begin
  // get info about the current item
  with TCustomMenuBar2000(Owner), FLocalOptions.Margins, aiRect,
    ClientToScreen(Point(aiRect.Left, aiRect.Top))
  do begin
    D:= Bevel - Frame;
    Self.SetBounds(X - D, Y - D, Right - Left + 2*D, Bottom - Top + 2*D);
    Self.Paint;
    ProcessPaintMessages;
  end;

  if DropShadow <> nil
  then DropShadow.Update;
end;

procedure T_AM2000_RaisedItemForm.wmEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  Msg.Result:= 1;
end;

procedure T_AM2000_RaisedItemForm.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KillActivePopupMenu2000(False, True);
  SilentHide;
  TCustomMenuBar2000(Owner).aiState:= aiRaised;
  TCustomMenuBar2000(Owner).PaintActiveItem;
end;

procedure T_AM2000_RaisedItemForm.Activate;
begin
  KillActivePopupMenu2000(False, True);
  SilentHide;
  TCustomMenuBar2000(Owner).aiState:= aiRaised;
  TCustomMenuBar2000(Owner).PaintActiveItem;
end;

function T_AM2000_RaisedItemForm.GetDropShadow: Boolean;
var
  BoolTemp: Bool;
begin
  Result:=
    // drop shadow is defined in Options
    (mfDropShadow in TCustomMenuBar2000(Owner).FLocalOptions.Flags)
  or
    // drop shadow is defined in Windows XP
      ((TCustomMenuBar2000(Owner).GetSystemShadow)
      and (SystemParametersInfo(SPI_GetDropShadow, 0, @BoolTemp, 0))
      and (BoolTemp));
end;

procedure T_AM2000_RaisedItemForm.WndProc(var Message: TMessage);
  // thanks to Frédéric Schneider for this routine
begin
  with Message do
    case Msg of
      WM_MOUSEACTIVATE:
        begin
          Result := MA_NOACTIVATE;
          TControl(Owner).Perform(WM_MOUSEACTIVATE, LongInt(Handle), 0);
          exit;
        end;
    end;
  inherited;
end;


end.

