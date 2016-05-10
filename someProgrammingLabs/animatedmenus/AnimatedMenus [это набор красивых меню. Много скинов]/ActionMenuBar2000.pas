unit ActionMenuBar2000;

interface

{$I am2000.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, am2000, am2000utils, am2000menuitem, ActnMenus, ActnMan,
  am2000options;

type
  TActionMenuBar2000 = class(TCustomActionMainMenuBar)
  private
    FMenu: TMainMenu2000;
    FMenuBar: TMenuBar2000;

    function GetVersion: T_AM2000_Version;
    procedure SetVersion(const Value: T_AM2000_Version);

    function GetFont: TFont;
    procedure SetFont(const Value: TFont);

    function GetParentFont: Boolean;
    procedure SetParentFont(const Value: Boolean);

    function GetParentShowHint: Boolean;
    procedure SetParentShowHint(const Value: Boolean);

    function GetShowHint: Boolean;
    procedure SetShowHint(const Value: Boolean);

    function GetAnimatedSkin: T_AM2000_AnimatedSkin;
    procedure SetAnimatedSkin(const Value: T_AM2000_AnimatedSkin);

    function GetBiDiMode: TBiDiMode;

    function GetParentBiDiMode: Boolean;


  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetupInternalMenuBar;

    procedure SetBiDiMode(Value: TBiDiMode); override;
    procedure SetParentBiDiMode(Value: Boolean); override;

    procedure CreateControls; override;
    function GetControlClass(AnItem: TActionClientItem): TCustomActionControlClass; override;
    function GetBarHeight: Integer; override;

    procedure MenuBarPopup(Sender: TObject; const AnItems: TMenuItem;
      const AnMenuHandle: HMenu);


  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Merge(AMenu: TActionMenuBar2000);
    procedure Unmerge(AMenu: TActionMenuBar2000);

  published
    property Version: T_AM2000_Version
      read GetVersion write SetVersion stored False;

    property ActionManager;
    property Align default alTop;

    property Anchors;
    property BiDiMode: TBiDiMode
      read GetBiDiMode write SetBiDiMode default bdLeftToRight;

    property Caption;
    property Color default clMenu;
    property Constraints;
    property EdgeBorders;
    property EdgeInner;
    property EdgeOuter;
    property Enabled;
    property Font: TFont
      read GetFont write SetFont;

    property HorzMargin;
    property ParentBiDiMode: Boolean
      read GetParentBiDiMode write SetParentBiDiMode;

    property ParentColor;

    property ParentFont: Boolean
      read GetParentFont write SetParentFont;

    property ParentShowHint: Boolean
      read GetParentShowHint write SetParentShowHint;

    property ShowHint: Boolean
      read GetShowHint write SetShowHint;

    property AnimatedSkin : T_AM2000_AnimatedSkin
      read GetAnimatedSkin write SetAnimatedSkin;

    property Spacing;
    property VertMargin;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TMenuItem2000Client = class(TMenuItem2000)
  private
    ActionClient: TActionClientItem;
    ActionControl: TCustomActionControl;

  protected
    procedure SetHidden(Value: Boolean); override;

    function GetCaption: String; override;
    function GetEnabled: Boolean; override;
    function GetVisible: Boolean; override;
    function GetBitmap: TBitmap; override;
    function GetChecked: Boolean; override;
    function GetAction: TBasicAction; override;
    function GetShortCut: T_AM2000_ShortCut; override;
    function GetHint: String; override;
    function GetHidden: Boolean; override;
    function GetImageIndex: T_AM2000_ImageIndex; override;
    function GetCount: Integer; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function HasBitmap: Boolean; override;
    procedure Click; override;

    procedure InitiateAction; override;

  end;

procedure Register;


implementation

uses ActnList, ToolWin;


procedure Register;
begin
  RegisterComponents('Animated Menus', [TActionMenuBar2000]);
end;



{ TActionMenuBar2000 }

constructor TActionMenuBar2000.Create(AOwner: TComponent);
begin
  inherited;
  FMenu:= TMainMenu2000.Create(Parent)
end;

destructor TActionMenuBar2000.Destroy;
begin
  if FMenuBar <> nil
  then FMenuBar.Menu:= nil;
  
  FMenu.Free;
  FMenu:= nil;

  inherited;
end;

function TActionMenuBar2000.GetVersion: T_AM2000_Version;
begin
  Result:= SVersion;
end;

procedure TActionMenuBar2000.SetVersion(const Value: T_AM2000_Version);
begin
end;

procedure TActionMenuBar2000.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FMenuBar)
  and (Operation = opRemove)
  then FMenuBar:= nil;
end;

procedure TActionMenuBar2000.SetupInternalMenuBar;
begin
  // create menubar
  FMenuBar:= TMenuBar2000.Create(Self);
{$IFDEF Delphi6OrHigher}
  FMenuBar.SetSubComponent(True);
{$ENDIF}

  // insert menubar
  FMenuBar.OnPopup:= MenuBarPopup;
  FMenuBar.Parent:= Self;
  FMenuBar.FreeNotification(Self);
  FMenuBar.Menu:= FMenu;
end;


procedure TActionMenuBar2000.CreateControls;
var
  I: Integer;
  Items: TActionClients;
  Item: TMenuItem2000Client;
begin
  if (csDesigning in ComponentState)
  then begin
    inherited;
    Exit;
  end;

  if (ActionClient = nil)
  then Exit;

  DisableAlign;

  if ContextBar
  then Items:= ActionClient.ContextItems
  else Items:= ActionClient.Items;

  if Items.Count = 0
  then Exit;

  FMenu.Items2000.Clear;
  FMenu.Images:= Items.ActionManager.Images;

  // add items
  for I := 0 to Items.Count - 1 do
  begin
    Item:= TMenuItem2000Client.Create(Owner);
    Item.ActionClient:= Items.ActionClients[I];
    Items[I].Control:= Item.ActionControl;
    FMenu.Items.Add(Item);
  end;

  // setup menu bar
  if (FMenuBar = nil)
  then SetupInternalMenuBar
  else FMenuBar.Menu:= FMenu;

  EnableAlign;
end;

function TActionMenuBar2000.GetControlClass(
  AnItem: TActionClientItem): TCustomActionControlClass;
begin
  if (csDesigning in ComponentState)
  then Result:= inherited GetControlClass(AnItem)
  else Result:= nil;
end;

function TActionMenuBar2000.GetBarHeight: Integer;
begin
  if (csDesigning in ComponentState)
  then begin
    Result:= inherited GetBarHeight;
    Exit;
  end;

  Result:= 0;

  if FMenuBar <> nil
  then Inc(Result, FMenuBar.Height);

  if ebTop in EdgeBorders
  then begin
    if EdgeInner in [esRaised, esLowered]
    then Inc(Result);
    if EdgeOuter in [esRaised, esLowered]
    then Inc(Result);
  end;

  if ebBottom in EdgeBorders
  then begin
    if EdgeInner in [esRaised, esLowered]
    then Inc(Result);
    if EdgeOuter in [esRaised, esLowered]
    then Inc(Result);
  end;
end;

procedure TActionMenuBar2000.MenuBarPopup;
// expand submenu item
var
  I: Integer;
  Item: TMenuItem2000Client;
begin
  if (AnItems = nil)
  or not (AnItems is TMenuItem2000Client)
  then Exit;

  AnItems.Clear;

  with TMenuItem2000Client(AnItems).ActionClient
  do
    for I:= 0 to Items.Count -1
    do begin
      Item:= TMenuItem2000Client.Create(Owner);
      Item.ActionClient:= Items.ActionClients[I];
      AnItems.Add(Item);
    end;
end;


function TActionMenuBar2000.GetFont: TFont;
begin
  Result:= FMenu.Font;
end;

function TActionMenuBar2000.GetParentFont: Boolean;
begin
  Result:= FMenu.ParentFont;
end;

function TActionMenuBar2000.GetParentShowHint: Boolean;
begin
  Result:= FMenu.ParentShowHint;
end;

function TActionMenuBar2000.GetShowHint: Boolean;
begin
  Result:= FMenu.ShowHint;
end;

procedure TActionMenuBar2000.SetFont(const Value: TFont);
begin
  FMenu.Font:= Value;
end;

procedure TActionMenuBar2000.SetParentFont(const Value: Boolean);
begin
  FMenu.ParentFont:= Value;
end;

procedure TActionMenuBar2000.SetParentShowHint(const Value: Boolean);
begin
  FMenu.ParentShowHint:= Value;
end;

procedure TActionMenuBar2000.SetShowHint(const Value: Boolean);
begin
  FMenu.ShowHint:= Value;
end;

function TActionMenuBar2000.GetBiDiMode: TBiDiMode;
begin
  Result:= FMenu.BiDiMode;
end;

function TActionMenuBar2000.GetParentBiDiMode: Boolean;
begin
  Result:= FMenu.ParentBiDiMode;
end;

procedure TActionMenuBar2000.SetBiDiMode(Value: TBiDiMode);
begin
  FMenu.BiDiMode:= Value;
end;

procedure TActionMenuBar2000.SetParentBiDiMode(Value: Boolean);
begin
  FMenu.ParentBiDiMode:= Value;
end;

procedure TActionMenuBar2000.Merge(AMenu: TActionMenuBar2000);
begin
  FMenu.Merge2000(AMenu.FMenu);
end;

procedure TActionMenuBar2000.Unmerge(AMenu: TActionMenuBar2000);
begin
  FMenu.UnMerge2000(AMenu.FMenu);
end;

function TActionMenuBar2000.GetAnimatedSkin: T_AM2000_AnimatedSkin;
begin
  Result:= FMenu.AnimatedSkin;
end;

procedure TActionMenuBar2000.SetAnimatedSkin(
  const Value: T_AM2000_AnimatedSkin);
begin
  FMenu.AnimatedSkin:= Value;
end;

{ TMenuItem2000Client }

function TMenuItem2000Client.GetAction: TBasicAction;
begin
  if ActionClient <> nil
  then Result:= ActionClient.Action
  else Result:= nil;
end;

function TMenuItem2000Client.GetBitmap: TBitmap;
begin
  Result:= nil;
end;

function TMenuItem2000Client.GetCaption: String;
begin
  if ActionClient <> nil
  then Result:= ActionClient.Caption
  else Result:= '';
end;

function TMenuItem2000Client.GetChecked: Boolean;
begin
  if (ActionClient <> nil)
  and (ActionClient.Action <> nil)
  and (ActionClient.Action is TCustomAction)
  then Result:= TCustomAction(ActionClient.Action).Checked
  else Result:= False;
end;

function TMenuItem2000Client.GetEnabled: Boolean;
begin
  if (ActionClient <> nil)
  then
    with ActionClient
    do
      if (Action <> nil)
      and (Action is TCustomAction)
      then Result:= TCustomAction(Action).Enabled
      else Result:= HasItems and (Items.VisibleCount > 0)

  else
    Result:= False;
end;

function TMenuItem2000Client.GetHint: String;
begin
  if (ActionClient <> nil)
  and (ActionClient.Action <> nil)
  and (ActionClient.Action is TCustomAction)
  then Result:= TCustomAction(ActionClient.Action).Hint
  else Result:= '';
end;

function TMenuItem2000Client.GetImageIndex: T_AM2000_ImageIndex;
begin
  if ActionClient <> nil
  then Result:= ActionClient.ImageIndex
  else Result:= -1;
end;

function TMenuItem2000Client.GetShortCut: T_AM2000_ShortCut;
begin
  if ActionClient <> nil
  then Result:= ActionClient.ShortCutText
  else Result:= '';
end;

function TMenuItem2000Client.GetVisible: Boolean;
begin
  Result:= (ActionClient <> nil) and ActionClient.Visible;
end;

function TMenuItem2000Client.HasBitmap: Boolean;
// all bitmaps are implemented as TImageList
begin
  Result:= False;
end;

function TMenuItem2000Client.GetCount: Integer;
begin
  if ActionClient <> nil
  then Result:= ActionClient.Items.Count
  else Result:= 0;
end;

procedure TMenuItem2000Client.Click;
var
  Action: TBasicAction;
begin
  if (ActionClient = nil)
  then Exit;

  Action:= ActionClient.Action;
  if (Action <> nil)
  then Action.Execute;
end;

function TMenuItem2000Client.GetHidden: Boolean;
begin
  if ActionClient <> nil
  then Result:= (ActionClient.UsageCount = 0)
  else Result:= False;
end;

procedure TMenuItem2000Client.InitiateAction;
begin
  if ActionClient <> nil
  then ActionClient.InitiateAction;
end;

procedure TMenuItem2000Client.SetHidden(Value: Boolean);
begin
  if ActionClient <> nil
  then
    with ActionClient
    do begin
      UsageCount:= UsageCount +1;
      LastSession:= ActionClients.ActionManager.ActionBars.SessionCount;
    end;
end;

constructor TMenuItem2000Client.Create(AOwner: TComponent);
begin
  inherited;
  ActionControl:= TCustomActionControl.Create(AOwner);
end;

destructor TMenuItem2000Client.Destroy;
begin
  ActionControl.Free;
  inherited;
end;


end.
