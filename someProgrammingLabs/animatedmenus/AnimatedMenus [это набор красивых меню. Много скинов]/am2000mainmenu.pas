
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       TMainMenu2000 Component Unit                    }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit am2000mainmenu;

{$I am2000.inc}

interface

uses
  {$IFDEF ACTIVEX}ActiveX, ComServ, AxCtrls, AnimatedMenusXP_tlb, {$ENDIF}
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls,
  Forms, Dialogs, Menus, Buttons, ComCtrls,
  am2000options, am2000menuitem, am2000utils, am2000menubar;

type

  // mainmenu manager
  TCustomMainMenu2000 = class(TMainMenu, ISkin
    {$IFDEF ACTIVEX}, IMenu, IMainMenu{$ENDIF})
  private
    FEMI2000        : TEditableMenuItem2000; // layer for comptibility with Delphi and your apps
    FMergedMenus    : TList;
    FMergedMenuItems: TList;
    ParentMenu      : TCustomMainMenu2000;
    PopulatedMenus  : TList;

    FSBPanelNo      : Integer;
    FStatusBar      : TStatusBar;
    FOnMenuCommand  : TNotifyEvent;
    FOnMenuClose    : T_AM2000_MenuCloseEvent;
    FFont           : TFont;
{$IFDEF ActiveX}
    FFontAdapter     : T_AM2000_FontAdapter;
{$ENDIF}
    FParentFont     : Boolean;
    FParentShowHint : Boolean;
    FShowHint       : Boolean;
    FSystemFont     : Boolean;
    FOnCloseQuery   : TCloseQueryEvent;
    FOptions        : T_AM2000_MenuOptions;
    FCtl3D          : Boolean;
    FSystemCtl3D    : Boolean;
    FSystemShadow   : Boolean;
    FSystemSelectionFade : Boolean;
    FMenuBar        : TCustomMenuBar2000;
    FDisabledImages : TCustomImageList;
    FHotImages      : TCustomImageList;

{$IFNDEF Delphi4OrHigher}
    FImages         : TCustomImageList;
    FBiDiMode       : TBiDiMode;
{$ENDIF}

    FOle2Menu       : TCustomMainMenu2000;
    FOnContextMenu  : TNotifyEvent;
    FAnimatedSkin   : T_AM2000_AnimatedSkin;
    FBuffer         : String;

{$IFDEF ACTIVEX}
    FFlagsDisp: IFlags;
    FDispTypeInfo: ITypeInfo;
    FDispIntfEntry: PInterfaceEntry;
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

    function GetMenuItem2000: TMenuItem2000;
    function GetMergedMenuItem(const Index: Integer): TMenuItem;
    function GetMergedMenuItemsCount: Integer;
    function GetOptions: T_AM2000_MenuOptions;
    function GetVersion: T_AM2000_Version;
    function IsFontStored: Boolean;
    function IsShowHintStored: Boolean;
    procedure SetFont(Value: TFont);
    procedure SetParentFont(Value: Boolean);
    procedure SetShowHint(Value: Boolean);
    procedure SetParentShowHint(Value: Boolean);
    procedure SetSystemFont(Value: Boolean);
    procedure SetOptions(Value: T_AM2000_MenuOptions);
    procedure SetVersion(Value: T_AM2000_Version);
    procedure SetCtl3D(const Value: Boolean);
    function IsCtl3DStored: Boolean;

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

    procedure cmParentFontChanged(var Msg: TMessage); message cm_ParentFontChanged;
    procedure cmFontChanged(var Msg: TMessage); message cm_FontChanged;

    procedure OnFontChange(Sender: TObject);
    procedure SetAnimatedSkin(const Value: T_AM2000_AnimatedSkin);

    function GetFont: TFont;
    function GetSelected: TMenuItem;
    procedure SetSelected(const Value: TMenuItem);

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
    function Get_ParentFont: WordBool; safecall;
    procedure Set_ParentFont(Value: WordBool); safecall;
    function  Get_SystemShadow: WordBool; safecall;
    procedure Set_SystemShadow(Value: WordBool); safecall;
    function  Get_SystemSelectionFade: WordBool; safecall;
    procedure Set_SystemSelectionFade(Value: WordBool); safecall;

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

    property Version: T_AM2000_Version
      read GetVersion write SetVersion stored False;

    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    ComponentLoaded     : Boolean;
    Ole2ObjectWindow    : HWnd;
    Ole2MenuDescriptor  : HMenu;

    property Items2000 : TMenuItem2000
      read GetMenuItem2000;

    property MergedMenus : TList
      read FMergedMenus;

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
    property SystemCtl3D    : Boolean
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

    property OnMenuCommand   : TNotifyEvent
      read FOnMenuCommand write FOnMenuCommand;
    property OnMenuClose     : T_AM2000_MenuCloseEvent
      read FOnMenuClose write FOnMenuClose;
    property OnCloseQuery    : TCloseQueryEvent
      read FOnCloseQuery write FOnCloseQuery;
    property OnContextMenu   : TNotifyEvent
      read FOnContextMenu write FOnContextMenu;

    property MenuBar: TCustomMenuBar2000
      read FMenuBar;

{$IFNDEF Delphi4OrHigher}
    property Images : TCustomImageList
      read FImages write FImages;

    property BiDiMode: TBiDiMode
      read FBiDiMode write FBiDiMode;
{$ENDIF}

    property DisabledImages : TCustomImageList
      read FDisabledImages write FDisabledImages;
    property HotImages : TCustomImageList
      read FHotImages write FHotImages;

    property MergedMenuItems [const Index: Integer] : TMenuItem
      read GetMergedMenuItem;
    property MergedMenuItemsCount: Integer
      read GetMergedMenuItemsCount;

    property Selected: TMenuItem
      read GetSelected write SetSelected;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Merge2000(Menu: TMenu);
    procedure Unmerge2000(Menu: TMenu);
    procedure Merge2(Menu: TMenu);
    procedure Unmerge2(Menu: TMenu); // backward-compatibility function
    procedure RebuildMergedMenuItems; // backward-compatibility function
    procedure Refresh;
    procedure UpdateFromOptions;

    procedure Assign(Source: TPersistent); override;
    procedure Reset;
    procedure ResetUsageData;

    function IsShortCut(var Msg: TWMKey): Boolean;
{$IFDEF Delphi4OrHigher}
    override;
{$ENDIF}

    function FindItem(Value: Word; Kind: TFindItemKind): TMenuItem2000;

    // Ole2 menu support
    procedure PopulateOle2Menu2000(hSharedMenu: HMenu; Groups: array of Integer;
      var Widths: array of Longint);
    procedure SetOle2MenuHandle2000(hMenuShared, hOleMenu: HMenu; hwndActiveObject: HWND);
//    function GetHandle: HMENU; override;
    function IsMenuPopulated(hMenu: HMenu): Boolean;
    procedure DoLoaded;
    procedure ResetSkin;
    function GetISkin: ISkin;

  published
{$IFDEF DesignTime}
    property Items       : TEditableMenuItem2000
      read FEMI2000;
{$ELSE}
    property Items       : TMenuItem2000
      read GetMenuItem2000;
{$ENDIF}

  end;


{$IFDEF Delphi3OrHigher }
  function GetMainMenu2000(Form: TCustomForm): TCustomMainMenu2000;
{$ELSE}
  function GetMainMenu2000(Form: TForm): TCustomMainMenu2000;
{$ENDIF}


implementation

uses
  Consts,
  am2000popupmenu, am2000cache, am2000skin;

type

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


{ GetMainMenu2000 }

{$IFDEF Delphi3OrHigher }
  function GetMainMenu2000(Form: TCustomForm): TCustomMainMenu2000;
{$ELSE}
  function GetMainMenu2000(Form: TForm): TCustomMainMenu2000;
{$ENDIF}
var
  MenuBar: TCustomMenuBar2000;
begin
  MenuBar:= GetActiveMenuBar;
  if (MenuBar <> nil)
  then
    if MenuBar.Menu is TCustomMainMenu2000
    then Result:= TCustomMainMenu2000(MenuBar.Menu)
    else raise EMenuError.Create(SOnlyMainMenuCanBeMerged)
  else
    Result:= nil;
end;


{ TCustomMainMenu2000 }

constructor TCustomMainMenu2000.Create(AOwner: TComponent);
begin
  inherited;

  FParentFont:= False;
  FParentShowHint:= True;
  FSystemFont:= True;
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

  FMergedMenus:= TList.Create;
  FMergedMenus.Add(Self);

  FMergedMenuItems:= TList.Create;

  if not (csDesigning in ComponentState)
  then InstallWindowsHooks;
end;

destructor TCustomMainMenu2000.Destroy;
begin
  RemoveWindowsHooks;

  if (ParentMenu <> nil)
  then ParentMenu.Unmerge2(Self);

  FFont.Free;
  FOptions.Free;
  PopulatedMenus.Free;
  FMergedMenus.Free;
  FMergedMenuItems.Free;
{$IFDEF ActiveX}
  FFontAdapter.Free;
{$ENDIF}  
{$IFDEF DesignTime}
  FEMI2000.Free;
{$ENDIF}

  if MenuDesigner <> nil
  then MenuDesigner.Perform(wm_Close, 0, 0);

  if (FMenuBar <> nil)
  and (FMenuBar.Menu = Self)
  then begin
    FMenuBar.Menu:= nil;
    FMenuBar:= nil;
  end;

  if FAnimatedSkin <> nil
  then begin
    FAnimatedSkin.Remove(Self);
    FAnimatedSkin:= nil;
  end;

  inherited;
end;

procedure TCustomMainMenu2000.Loaded;
var
  F: TForm;
  I: Integer;
  M: TCustomMenuBar2000;
begin
  if ComponentLoaded
  then Exit;

  ComponentLoaded:= True;
  inherited;

  if csDesigning in ComponentState
  then Exit;

  if (Owner is TCustomForm)
  then begin
    F:= TForm(Owner);

    // if no menu bars specified, create one for me
    if (F.Menu = Self)
    and (F.FormStyle <> fsMdiChild)
    and (GetMenuBarFromMenu(Self) = nil)
    then begin
      F.Menu:= nil;
      FMenuBar:= TCustomMenuBar2000.Create(Owner);
      FMenuBar.Align:= alTop;
      FMenuBar.Parent:= F;
      FMenuBar.Menu:= Self;
    end;

    // if this menu is the main menu for a mdi child form
    // then scan the parent mdi form and merge with
    // it's main menu
    if (F.Menu = Self)
    and (F.FormStyle = fsMdiChild)
    and (ActiveMenuBarList.Count > 0)
    then
      for I:= 0 to ActiveMenuBarList.Count -1
      do begin
        M:= TCustomMenuBar2000(ActiveMenuBarList[I]);
        if (M.OwnerForm <> nil)
        and (TForm(M.OwnerForm).FormStyle = fsMdiForm)
        and (M.Menu is TCustomMainMenu2000)
        then begin
          FMenuBar:= M;
          ParentMenu:= TCustomMainMenu2000(M.Menu);
          ParentMenu.Merge2000(Self);
          Exit;
        end;
      end;
  end;

  Font.OnChange:= OnFontChange;

  // save backup
  FBuffer:= '';
  SaveMenuToString(Self, FBuffer);

  // load from menu
  LoadMenu(Self);
  RebuildMergedMenuItems;

  // save backup
  Refresh;
end;

function TCustomMainMenu2000.GetMenuItem2000: TMenuItem2000;
begin
  Result:= TMenuItem2000(inherited Items);
end;

procedure TCustomMainMenu2000.Merge2(Menu: TMenu);
begin
  Merge2000(Menu);
end;

procedure TCustomMainMenu2000.Merge2000(Menu: TMenu);
begin
  if FMergedMenus.IndexOf(Menu) = -1
  then FMergedMenus.Add(Menu);

  RebuildMergedMenuItems;

  if FMenuBar <> nil
  then FMenuBar.UpdateMenuBar(True);
end;

procedure TCustomMainMenu2000.Unmerge2(Menu: TMenu);
begin
  Unmerge2000(Menu);
end;

procedure TCustomMainMenu2000.Unmerge2000(Menu: TMenu);
begin
  FMergedMenus.Remove(Menu);
  RebuildMergedMenuItems;

  if FMenuBar <> nil
  then FMenuBar.UpdateMenuBar(True);
end;

procedure TCustomMainMenu2000.RebuildMergedMenuItems;
var
  GroupIndex, MenuIndex, ItemIndex: Integer;
  BreakGroupIndex: Boolean;
  Menu: TMenu;
  OwnerForm: TComponent;
begin
  FMergedMenuItems.Clear;

  // place menu for active form at the end of the list
  for MenuIndex:= 0 to FMergedMenus.Count -1 do
    if FMergedMenus[MenuIndex] <> Self then begin
      Menu:= TMenu(FMergedMenus[MenuIndex]);
      OwnerForm:= Menu.Owner;
      while (OwnerForm <> nil)
      and (not (OwnerForm is TForm)) do
        OwnerForm:= OwnerForm.Owner;

      if (OwnerForm is TForm)
      and (TForm(OwnerForm).Active)
      and (TForm(OwnerForm).Menu = Menu)
      then begin
        FMergedMenus.Remove(Menu);
        FMergedMenus.Add(Menu);
        Break;
      end;
    end;

  // rebuild menu items
  for GroupIndex:= 0 to 255 do begin
    MenuIndex:= FMergedMenus.Count -1;
    BreakGroupIndex:= False;
    while (MenuIndex >= 0) and (not BreakGroupIndex) do
      with TMenu(FMergedMenus[MenuIndex]) do begin
        for ItemIndex:= 0 to Items.Count -1 do
          if Items[ItemIndex].GroupIndex = GroupIndex then begin
            FMergedMenuItems.Add(Items[ItemIndex]);
            BreakGroupIndex:= True;
          end;

        Dec(MenuIndex);
      end;
  end;
end;

function TCustomMainMenu2000.GetMergedMenuItem(const Index: Integer): TMenuItem;
begin
  Result:= nil;

  if (FMergedMenuItems = nil) or (Index < 0)
  then Exit;

  if FMergedMenuItems.Count = 0
  then RebuildMergedMenuItems;

  if (Index < FMergedMenuItems.Count)
  then Result:= TMenuItem(FMergedMenuItems[Index]);
end;

function TCustomMainMenu2000.GetMergedMenuItemsCount: Integer;
begin
  if FMergedMenuItems = nil
  then
    Result:= 0

  else begin
    if (FMergedMenuItems.Count = 0)
    then RebuildMergedMenuItems;

    Result:= FMergedMenuItems.Count;
  end;
end;

procedure TCustomMainMenu2000.Notification(AComponent: TComponent;
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
    if (AComponent = FMenuBar) then FMenuBar:= nil;

    if (AComponent is TMenu)
    and (MergedMenus.IndexOf(AComponent) <> -1)
    then begin
      MergedMenus.Remove(AComponent);
      RebuildMergedMenuItems;
    end;
  end;
end;

function TCustomMainMenu2000.IsShortCut(var Msg: TWMKey): Boolean;
begin
  Result:= IsShortCutEx(Msg, Items2000, csDesigning in ComponentState);
end;

function TCustomMainMenu2000.FindItem(Value: Word; Kind: TFindItemKind): TMenuItem2000;
begin
  Result:= TMenuItem2000(inherited FindItem(Value, Kind));
end;

{ Ole2 support }

procedure TCustomMainMenu2000.PopulateOle2Menu2000(hSharedMenu: HMenu; Groups: array of Integer;
      var Widths: array of Longint);
var
  I: Integer;
begin
  PopulateOle2Menu(hSharedMenu, Groups, Widths);

  if PopulatedMenus = nil
  then
    PopulatedMenus:= TList.Create
  else
    PopulatedMenus.Clear;

  mii.fMask:= miim_Submenu;
  for I:= 0 to GetMenuItemCount(hSharedMenu) -1 do begin
    GetMenuItemInfo(hSharedMenu, I, true, mii);
    if mii.hSubmenu <> 0
    then
      PopulatedMenus.Add(Pointer(mii.hSubmenu));
  end;
end;

procedure TCustomMainMenu2000.SetOle2MenuHandle2000(hMenuShared, hOleMenu: HMenu; hwndActiveObject: HWND);
var
  I: Integer;
  M: TMenuItem2000;
begin
  SetOle2MenuHandle(hMenuShared);

  // init object references
  Ole2ObjectWindow:= hwndActiveObject;
  Ole2MenuDescriptor:= hOleMenu;

  // install hook on the hwndActiveObject
  if hwndActiveObject <> 0
  then
    InstallOle2GMHook(hwndActiveObject)
  else
    RemoveOle2GMHook;

  // init menu for menu bar
  if hMenuShared = 0 then begin
    FMergedMenus.Remove(FOle2Menu);
    Merge2000(Self);
    FOle2Menu.Free;
    FOle2Menu:= nil;
  end
  else begin
    // clear FOle2Menu
    if FOle2Menu = nil
    then FOle2Menu:= TCustomMainMenu2000.Create(nil)
    else
      with FOle2Menu.Items do
        while Count > 0 do Items[Count -1].Free;

    // recreate FOle2Menu
    for I:= 0 to GetMenuItemCount(hMenuShared) -1 do begin
      mii.fMask:= miim_ID + miim_Data + miim_Type + miim_State + miim_Submenu;
      mii.dwTypeData:= Z;
      mii.cch:= SizeOf(Z) -1;
      GetMenuItemInfo(hMenuShared, I, True, mii);
      M:= TMenuItem2000.Create(Owner);
      M.Caption:= mii.dwTypeData;
      M.MenuHandle:= mii.hSubmenu;
      FOle2Menu.Items.Add(M);
    end;

    FMergedMenus.Remove(Self);
    Merge2000(FOle2Menu);
  end;
end;

//function TCustomMainMenu2000.GetHandle: HMENU;
//begin
//  Result:= inherited GetHandle;
//end;

function TCustomMainMenu2000.IsMenuPopulated(hMenu: HMenu): Boolean;
begin
  Result:= (PopulatedMenus <> nil)
    and (PopulatedMenus.IndexOf(Pointer(hMenu)) >= 0);
end;

procedure TCustomMainMenu2000.SetVersion(Value: T_AM2000_Version);
begin
end;

function TCustomMainMenu2000.GetVersion: T_AM2000_Version;
begin
  Result:= SVersion;
end;

function TCustomMainMenu2000.IsFontStored: Boolean;
begin
  Result:= not (FParentFont or FSystemFont);
end;

function TCustomMainMenu2000.IsShowHintStored: Boolean;
begin
  Result:= not FParentShowHint;
end;

procedure TCustomMainMenu2000.SetFont(Value: TFont);
begin
  if Value <> nil
  then
    Font.Assign(Value)
  else begin
    FFont.Free;
    FFont:= nil;
  end;
end;

procedure TCustomMainMenu2000.SetParentFont(Value: Boolean);
begin
  FParentFont:= Value;
  if Value
  then begin
    FSystemFont:= False;
    SetFont(nil);
  end;
end;

procedure TCustomMainMenu2000.SetSystemFont(Value: Boolean);
begin
  FSystemFont:= Value;
  if Value
  then begin
    FParentFont:= False;
    SetFont(nil);
  end;
end;

procedure TCustomMainMenu2000.SetShowHint(Value: Boolean);
begin
  if FShowHint <> Value then begin
    FShowHint:= Value;
    FParentShowHint:= False;
  end;
end;

procedure TCustomMainMenu2000.SetParentShowHint(Value: Boolean);
begin
  if FParentShowHint <> Value then
    FParentShowHint:= Value;

  if FParentShowHint then
    if Owner is TControl
    then FShowHint:= TControl(Owner).ShowHint
    else FShowHint:= False;

end;

procedure TCustomMainMenu2000.SetOptions(Value: T_AM2000_MenuOptions);
begin
  FOptions.Assign(Value);
end;

procedure TCustomMainMenu2000.cmFontChanged(var Msg: TMessage);
begin
  if FMenuBar <> nil
  then FMenuBar.UpdateMenuBar(True);
end;

procedure TCustomMainMenu2000.cmParentFontChanged(var Msg: TMessage);
begin
  if FMenuBar <> nil
  then FMenuBar.UpdateMenuBar(True);
end;

procedure TCustomMainMenu2000.OnFontChange(Sender: TObject);
begin
  if FMenuBar <> nil
  then FMenuBar.UpdateMenuBar(True);
end;

procedure TCustomMainMenu2000.Refresh;
begin
  if FMenuBar <> nil
  then begin
    FMenuBar.Refresh;
    if (FMenuBar.MenuComponent <> nil)
    and (FMenuBar.MenuComponent.FormOnScreen)
    then FMenuBar.MenuComponent.Refresh;
  end;
end;

function TCustomMainMenu2000.GetOptions: T_AM2000_MenuOptions;
begin
  Result:= FOptions;

  if ComponentState * [csLoading, csReading, csDesigning] = []
  then SoftenColors(FOptions.Colors, mfSoftColors in FOptions.Flags);
end;

procedure TCustomMainMenu2000.Assign(Source: TPersistent);
begin
  if Source is TMenu
  then begin
    CopyMenuProperties(TMenu(Source), Self);
    Items.Assign(TMenu(Source).Items);

    if Source is TMainMenu
    then
      with TMainMenu(Source)
      do begin
        Self.AutoMerge:= AutoMerge;
      end;

    if Source is TCustomMainMenu2000
    then
      with TCustomMainMenu2000(Source)
      do begin
        Self.ComponentLoaded:= ComponentLoaded;
        Self.Ole2ObjectWindow:= Ole2ObjectWindow;
        Self.Ole2MenuDescriptor:= Ole2MenuDescriptor;
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

        CopyList(MergedMenus, Self.MergedMenus);
        RebuildMergedMenuItems;
      end;
  end
  else
    inherited;
end;

procedure TCustomMainMenu2000.SetAnimatedSkin(
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

  else begin
    TempSkin:= TCustomAnimatedSkin2000.Create(nil);
    TempSkin.AssignTo(Self);
    TempSkin.Free;
  end;
end;

procedure TCustomMainMenu2000.UpdateFromOptions;
begin
  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  then Exit;

  Refresh;
end;

function TCustomMainMenu2000.GetFont: TFont;
begin
  if FFont = nil
  then FFont:= TFont.Create;

  Result:= FFont;
end;

procedure TCustomMainMenu2000.DoLoaded;
begin
  Loaded;
end;

procedure TCustomMainMenu2000.SetCtl3D(const Value: Boolean);
begin
  FSystemCtl3D:= False;
  FCtl3D:= Value;
end;

function TCustomMainMenu2000.IsCtl3DStored: Boolean;
begin
  Result:= not FSystemCtl3D;
end;


{$IFDEF ACTIVEX}
function TCustomMainMenu2000.Get_Items: IMenuItem;
begin
  Result:= Items2000 as IMenuItem;
end;

function TCustomMainMenu2000.Get_Name: WideString;
begin
  Result:= Name;
end;

function TCustomMainMenu2000.Get_Ctl3D: WordBool;
begin
  Result:= FCtl3D;
end;

function TCustomMainMenu2000.Get_SystemCtl3D: WordBool;
begin
  Result:= FSystemCtl3D;
end;

function TCustomMainMenu2000.Get_Font: IFont;
begin
  if FFontAdapter = nil
  then FFontAdapter:= T_AM2000_FontAdapter.Create(Font);

  Result:= FFontAdapter;
end;

function TCustomMainMenu2000.Get_Options: IMenuOptions;
begin
  Result:= Options;
end;

function TCustomMainMenu2000.Get_ShowHint: WordBool;
begin
  Result:= FShowHint;
end;

function TCustomMainMenu2000.Get_SystemFont: WordBool;
begin
  Result:= FSystemFont;
end;

function TCustomMainMenu2000.Get_ParentFont: WordBool;
begin
  Result:= FParentFont;
end;

function TCustomMainMenu2000.Get_SystemSelectionFade: WordBool;
begin
  Result:= SystemSelectionFade;
end;

function TCustomMainMenu2000.Get_SystemShadow: WordBool;
begin
  Result:= SystemShadow;
end;

procedure TCustomMainMenu2000.Set_Ctl3D(Value: WordBool);
begin
  Ctl3D:= Value;
end;

procedure TCustomMainMenu2000.Set_SystemCtl3D(Value: WordBool);
begin
  SystemCtl3D:= Value;
end;

procedure TCustomMainMenu2000.Set_ShowHint(Value: WordBool);
begin
  ShowHint:= Value;
end;

procedure TCustomMainMenu2000.Set_SystemFont(Value: WordBool);
begin
  SystemFont:= Value;
end;

procedure TCustomMainMenu2000.Set_ParentFont(Value: WordBool);
begin
  ParentFont:= Value;
end;

procedure TCustomMainMenu2000.Set_SystemSelectionFade(Value: WordBool);
begin
  SystemSelectionFade:= Value;
end;

procedure TCustomMainMenu2000.Set_SystemShadow(Value: WordBool);
begin
  SystemShadow:= Value;
end;


function TCustomMainMenu2000.DispTypeInfo: ITypeInfo;
begin
  if FDispTypeInfo = nil
  then ComServer.TypeLib.GetTypeInfoOfGuid(IMainMenuDisp, FDispTypeInfo);

  Result:= FDispTypeInfo;
end;

function TCustomMainMenu2000.DispIntfEntry: PInterfaceEntry;
begin
  if FDispIntfEntry = nil
  then FDispIntfEntry:= GetInterfaceEntry(IMainMenuDisp);

  Result:= FDispIntfEntry;
end;

function TCustomMainMenu2000.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result:= DispGetIDsOfNames(DispTypeInfo, Names, NameCount, DispIDs);
end;

function TCustomMainMenu2000.GetTypeInfo(Index, LocaleID: Integer;
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

function TCustomMainMenu2000.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count:= 1;
  Result:= S_OK;
end;

function TCustomMainMenu2000.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
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

procedure TCustomMainMenu2000.ResetSkin;
begin
  AnimatedSkin:= nil;
end;

procedure TCustomMainMenu2000.Reset;
begin
  LockGlobalRepaint;
  LoadMenuFromString(Self, FBuffer);
  RebuildMergedMenuItems;

  if FMenuBar <> nil
  then FMenuBar.UpdateMenuBar(True);

  UnLockGlobalRepaint;
end;

procedure TCustomMainMenu2000.ResetUsageData;
begin
  LockGlobalRepaint;
  am2000utils.ResetUsageData(Items2000, FBuffer);
  UnLockGlobalRepaint;
end;


function TCustomMainMenu2000.GetSelected: TMenuItem;
begin
  if FMenuBar = nil
  then
    raise EMenuError.CreateFmt(SMainMenuIsNotVisible, [Name])
  else
    Result:= FMenuBar.MenuComponent.Selected;
end;

procedure TCustomMainMenu2000.SetSelected(const Value: TMenuItem);
begin
  if FMenuBar = nil
  then
    raise EMenuError.CreateFmt(SMainMenuIsNotVisible, [Name])
  else
    FMenuBar.SetMenuItem(Value);
end;

function TCustomMainMenu2000.HasColors: Boolean;
begin
  Result:= Options.HasColors;
end;

function TCustomMainMenu2000.HasTitle: Boolean;
begin
  Result:= Options.HasTitle;
end;

function TCustomMainMenu2000.HasMargins: Boolean;
begin
  Result:= Options.HasMargins;
end;

function TCustomMainMenu2000.HasSkin: Boolean;
begin
  Result:= Options.HasSkin;
end;

function TCustomMainMenu2000.GetTitle: T_AM2000_Title;
begin
  Result:= Options.Title;
end;

function TCustomMainMenu2000.GetColors: T_AM2000_Colors;
begin
  Result:= Options.Colors;
end;

function TCustomMainMenu2000.GetMargins: T_AM2000_Margins;
begin
  Result:= Options.Margins;
end;

function TCustomMainMenu2000.GetSkin: T_AM2000_Skin;
begin
  Result:= Options.Skin;
end;

function TCustomMainMenu2000.GetAnimation: T_AM2000_Animation;
begin
  Result:= Options.Animation;
end;

function TCustomMainMenu2000.GetCtl3D: Boolean;
begin
  Result:= FCtl3D;
end;

function TCustomMainMenu2000.GetFlags: T_AM2000_Flags;
begin
  Result:= Options.Flags;
end;

function TCustomMainMenu2000.GetOpacity: T_AM2000_Opacity;
begin
  Result:= Options.Opacity;
end;

function TCustomMainMenu2000.GetParentFont: Boolean;
begin
  Result:= FParentFont;
end;

function TCustomMainMenu2000.GetSystemCtl3D: Boolean;
begin
  Result:= FSystemCtl3D;
end;

function TCustomMainMenu2000.GetSystemFont: Boolean;
begin
  Result:= FSystemFont;
end;

function TCustomMainMenu2000.GetSystemSelectionFade: Boolean;
begin
  Result:= FSystemSelectionFade;
end;

function TCustomMainMenu2000.GetSystemShadow: Boolean;
begin
  Result:= FSystemShadow;
end;

function TCustomMainMenu2000.GetImages: TCustomImageList;
begin
  Result:= Images;
end;

function TCustomMainMenu2000.GetDisabledImages: TCustomImageList;
begin
  Result:= FDisabledImages;
end;

function TCustomMainMenu2000.GetHotImages: TCustomImageList;
begin
  Result:= FHotImages;
end;

function TCustomMainMenu2000.GetISkin: ISkin;
begin
  if AnimatedSkin = nil
  then Result:= ISkin(Self)
  else Result:= AnimatedSkin.GetISkin;
end;


end.
