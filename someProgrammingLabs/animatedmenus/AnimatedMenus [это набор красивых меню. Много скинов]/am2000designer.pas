
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_MenuDesigner Component Unit            }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000designer;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CommCtrl, ComCtrls, ExtCtrls,
  Buttons, Menus, Registry,
  LibHelp,
  {$IFDEF Delphi6OrHigher} DesignIntf, DesignEditors, {$ELSE} DsgnIntf, {$ENDIF}
  {$IFDEF Delphi3OrHigher} ExtDlgs, {$ENDIF}
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  {$IFDEF Delphi5OrHigher} Contnrs, {$ENDIF}
  am2000menuitem, am2000popupmenu, am2000mainmenu, am2000, am2000options, 
  am2000utils, am2000menubar, ToolWin;

type

  T_AM2000_TreeView4 = class;
  T_AM2000_Panel = class;
  T_AM2000_Preview = class;

{$IFNDEF Delphi4OrHigher}
  TCustomDrawTarget = (dtControl, dtItem, dtSubItem);
  TCustomDrawStage = (cdPrePaint, cdPostPaint, cdPreErase, cdPostErase);
  TCustomDrawState = set of (cdsSelected, cdsGrayed, cdsDisabled, cdsChecked,
    cdsFocused, cdsDefault, cdsHot, cdsMarked, cdsIndeterminate);

  TTVCustomDrawItemEvent = procedure(Sender: TCustomTreeView; Node: TTreeNode;
    State: TCustomDrawState; var DefaultDraw: Boolean) of object;
{$ENDIF}


  // menu designer
  T_AM2000_MenuDesigner = class(TPropertyEditor)
  public
    function GetValue: string; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;

  end;


  // component editor
  T_AM2000_ComponentEditor = class(TComponentEditor)
  public
    constructor Create(AComponent: TComponent;
{$IFDEF Delphi6OrHigher}
      ADesigner: IDesigner
{$ELSE}
{$IFDEF Delphi4OrHigher}
      ADesigner: IFormDesigner
{$ELSE}
      ADesigner: TFormDesigner
{$ENDIF}
{$ENDIF}
      ); override;

    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): String; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure Edit; override;

  end;

  // dialog for menu designer
  T_AM2000_MenuDesignerDlg = class(TForm)
    AutoBitmapsSet11: TMenuItem2000;
    ImageList1: TMenuItem2000;
    LoadBitmapFromFile1: TMenuItem2000;
    SaveBitmapToFile1: TMenuItem2000;
    DefaultBitmaps: TImageList;
    ClearBitmap1: TMenuItem2000;
    ButtonArray1: TMenuItem2000;
    ButtonArray3: TMenuItem2000;
    N4: TMenuItem2000;
    FontDialog1: TFontDialog;
    SubMenuImages1: TMenuItem2000;
    ButtonArray4: TMenuItem2000;
    MainMenu20001: TMainMenu2000;
    MenuItem1: TMenuItem2000;
    FileNewMainMenu1: TMenuItem2000;
    FileOpen1: TMenuItem2000;
    FileSaveAs1: TMenuItem2000;
    MenuItem5: TMenuItem2000;
    MenuItem6: TMenuItem2000;
    MenuItem7: TMenuItem2000;
    MenuItem8: TMenuItem2000;
    MenuItem9: TMenuItem2000;
    MenuItem10: TMenuItem2000;
    FileNewItem1: TMenuItem2000;
    FileNewSubmenu1: TMenuItem2000;
    MenuItem13: TMenuItem2000;
    MenuItem14: TMenuItem2000;
    MenuItem16: TMenuItem2000;
    MenuItem18: TMenuItem2000;
    MenuItem19: TMenuItem2000;
    MenuItem20: TMenuItem2000;
    MenuItem21: TMenuItem2000;
    MenuItem22: TMenuItem2000;
    MenuItem23: TMenuItem2000;
    MenuItem24: TMenuItem2000;
    MenuItem25: TMenuItem2000;
    MenuItem26: TMenuItem2000;
    MenuItem27: TMenuItem2000;
    FileNewPopupMenu1: TMenuItem2000;
    MenuItem15: TMenuItem2000;
    CoolBar1: TCoolBar;
    MenuBar20001: TMenuBar2000;
    ToolBar1: TToolBar;
    ButtonNewMenuItem: TToolButton;
    ButtonNewSubMenu: TToolButton;
    ButtonDelete: TToolButton;
    ToolButton4: TToolButton;
    btnCut: TToolButton;
    btnCopy: TToolButton;
    btnPaste: TToolButton;
    ToolButton8: TToolButton;
    ButtonLevelUp: TToolButton;
    ButtonMoveUp: TToolButton;
    ButtonMoveDown: TToolButton;
    ButtonLevelDown: TToolButton;
    ImageList2: TImageList;
    ToolButton13: TToolButton;
    ButtonStayOnTop: TToolButton;
    btnFont: TToolButton;
    Panel2: T_AM2000_Panel;
    MenuTree: T_AM2000_TreeView4;
    Edit1: TEdit;
    ButtonNewSeparator: TToolButton;
    PopupMenu20001: TPopupMenu2000;
    NormalSeparator1: TMenuItem2000;
    Double1: TMenuItem2000;
    Dotted1: TMenuItem2000;
    DoubleDotted1: TMenuItem2000;
    EmptyLine1: TMenuItem2000;

    procedure MenuTreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure CollapseAll1Click(Sender: TObject);
    procedure ExpandAll1Click(Sender: TObject);
    procedure ButtonNewMenuItemClick(Sender: TObject);
    procedure ButtonNewSubMenuClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonMoveDownClick(Sender: TObject);
    procedure ButtonMoveUpClick(Sender: TObject);
    procedure ButtonLevelUpClick(Sender: TObject);
    procedure ButtonLevelDownClick(Sender: TObject);
    procedure LoadMenuClick(Sender: TObject);
    procedure SaveMenuClick(Sender: TObject);
    procedure LoadSkinClick(Sender: TObject);
    procedure SaveSkinClick(Sender: TObject);
    procedure LoadBitmapFromFileClick(Sender: TObject);
    procedure PopupMenu20001Popup(Sender: TObject);
    procedure SaveBitmapToFileClick(Sender: TObject);
    procedure None1Click(Sender: TObject);
    procedure ButtonArray1Click(Sender: TObject);
    procedure ButtonArray3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AM2000MenuDesigner6Click(Sender: TObject);
    procedure AM2000MenuDesigner7Click(Sender: TObject);
    procedure MenuTreeEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure ButtonStayOnTopClick(Sender: TObject);
    procedure ImageList1Click(Sender: TObject);
    procedure MenuTreeChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure MenuTreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DeselectAll1Click(Sender: TObject);
    procedure btnCutClick(Sender: TObject);
    procedure SelectAll2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ShortCuts1Click(Sender: TObject);
    procedure Hidden1Click(Sender: TObject);
    procedure ClearBitmap1Click(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
{$IFDEF Delphi4OrHigher}
    procedure FontDialog1Apply(Sender: TObject; Wnd: HWND);
{$ELSE}
    procedure FontDialog1Apply(Sender: TObject; Wnd: Integer);
{$ENDIF}
    procedure SubMenuImages1Click(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1DblClick(Sender: TObject);
    procedure MenuTreeEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuItem9Click(Sender: TObject);
    procedure FileNewMainMenu1Click(Sender: TObject);
    procedure FileNewPopupMenu1Click(Sender: TObject);

  private
    Preview: T_AM2000_Preview;
    Updating: Boolean;
    FMenu: TMenu;
    Menus: TList;
    SelStart: TTreeNode;
    SelectedList, // list of selected nodes
    MenuItemList, // list of menu items in the node
    TreeNodeList  // list of tree nodes from MenuItemList
                : TList;

{$IFDEF Delphi3OrHigher}
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
{$ELSE}
    OpenPictureDialog1: TOpenDialog;
    SavePictureDialog1: TSaveDialog;
{$ENDIF}

    procedure CheckConstraints;
    procedure SetMenu(const Value: TMenu);
    procedure InvalidateNode(Node: TTreeNode);
    procedure InvalidateList;

    procedure SelectMenuItem(const AnItem: TMenuItem2000);
    
    procedure wmUpdate(var Msg: TMessage);          message wm_Update;
    procedure wmClose(var Msg: TMessage);           message wm_Close;
    procedure wmGetPopupMenu(var Msg: TMessage);    message wm_GetPopupMenu;
    procedure wmRefreshMenu(var Msg: TMessage);     message wm_RefreshMenu;
    procedure wmKillMenuBar(var Msg: TMessage);     message wm_KillMenuBar;

    procedure UpdateSelections;
    procedure ClearSelections;
    procedure CopySelections;
    procedure ShowMethod(const MI: TMenuItem);
    procedure DisplayEdit(const Node: TTreeNode);
    procedure SelectComponent(const AComponent: TComponent; Modified: Boolean);

  protected

{$IFDEF Delphi6OrHigher}
    Designer: IDesigner;
{$ELSE}
{$IFDEF Delphi4OrHigher}
    Designer: IFormDesigner;
{$ELSE}
    Designer: TFormDesigner;
{$ENDIF}
{$ENDIF}
    procedure Loaded; override;

  public
    property Menu: TMenu read FMenu write SetMenu;

  end;


  T_AM2000_TreeView4 = class(TCustomTreeView)
  private
    FCanvas: TCanvas;
    FCanvasChanged: Boolean;
    FOnCustomDrawItem: TTVCustomDrawItemEvent;

    procedure CanvasChanged(Sender: TObject);
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    function GetNodeFromItem(const Item: TTVItem): TTreeNode;

  protected

    function CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
      Stage: TCustomDrawStage
      {$IFDEF Delphi5OrHigher} ; var PaintImages: Boolean {$ENDIF}
      ): Boolean;
      {$IFDEF Delphi4OrHigher} override; {$ELSE} virtual; {$ENDIF}

    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean;
      {$IFDEF Delphi6OrHigher} override; {$ENDIF}
    procedure CreateParams(var Params: TCreateParams); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Canvas: TCanvas read FCanvas;

  published
    property Items;
    property OnChanging;
    property OnChange;
    property Align;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnEdited;
    property OnEditing;
    property PopupMenu;
    property Font;
    property Color;
    property BorderStyle;
    property OnEnter;

    property OnCustomDrawItem: TTVCustomDrawItemEvent read FOnCustomDrawItem write FOnCustomDrawItem;
  end;

  T_AM2000_Panel = class(TPanel)
  protected
    procedure Paint; override;

  end;

  T_AM2000_Preview = class
  private
    FMenu: TMenu;
    MainMenuForm, PopupMenuForm: TForm;
    MenuBar: TCustomMenuBar2000;
    Left, Top: Integer;
    Owner: TComponent;

    procedure SetMenuItem(AItem: TMenuItem2000);
    procedure SetMenu(AMenu: TMenu);
    procedure MainMenuFormHide(Sender: TObject);
    procedure Hide;
    procedure Refresh;
    procedure PopupMenuFormClose(Sender: TObject; var Action: TCloseAction);
    procedure KillSubForms;

  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

  end;

  T_AM2000_AnimatedSkinEditor = class(TComponentEditor)
  public
    constructor Create(AComponent: TComponent;
{$IFDEF Delphi6OrHigher}
      ADesigner: IDesigner
{$ELSE}
{$IFDEF Delphi4OrHigher}
      ADesigner: IFormDesigner
{$ELSE}
      ADesigner: TFormDesigner
{$ENDIF}
{$ENDIF}
      ); override;

    destructor Destroy; override;

    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): String; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure Edit; override;

  end;


  T_AM2000_VersionProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    function AllEqual: Boolean; override;
    procedure Edit; override;

  end;


  TDesigner = class(T_AM2000_Designer)
  private
    Designer:
{$IFDEF Delphi6OrHigher}
              IDesigner;
{$ELSE}
{$IFDEF Delphi4OrHigher}
              IFormDesigner;
{$ELSE}
              TFormDesigner;
{$ENDIF}
{$ENDIF}
    function InitializeDesigner: Boolean;

  public
    destructor Destroy; override;
    procedure SelectComponent(const AComponent: TComponent); override;
    procedure ShowMethod(const AComponent: TComponent; const EventName: String); override;
    procedure Modified; override;

  end;



function ExecuteOpenAnimatedSkinDialog: Boolean;
function ExecuteSaveAnimatedSkinDialog: Boolean;
function ExecuteOpenMenuDialog: Boolean;
function ExecuteSaveMenuDialog: Boolean;


const
  FSkinFilename: String = 'untitled';
  FSkinFormat: Integer = sfResource;

  FMenuFilename: String = 'untitled';
  FMenuFormat: Integer = mfResource;

implementation

uses
  Consts, TypInfo, ShellApi,
  {$IFDEF Delphi4OrHigher}{$IFNDEF CBuilder4}ToolsApi,{$ENDIF}{$ENDIF}
  {$IFDEF Delphi2} Ole2, {$ELSE} ShlObj, ActiveX, {$ENDIF}
  {$IFDEF Delphi3orHigher} am2000shortcut, {$ENDIF}
  am2000cache, am2000buttonarray, am2000welcome,
  am2000skin;

{$R *.DFM}

const
  MENU_REGISTRY_KEY : String = '\Software\AnimatedMenus.com\AnimatedMenus/2000\';

const
  SOkToDeleteThese = 'Ok to delete these ';
  SSelectedItems = ' selected items?';

var
  MenuDesignerDlg : T_AM2000_MenuDesignerDlg;


procedure DrawImageList(Item: TMenuItem2000; ImageList: TImageList);
var
  DX, DY, X, Y: Integer;
begin
  DX:= ImageList.Width +4;
  DY:= ImageList.Height +4;

  with Item.AsButtonArray do begin
    Count:= ImageList.Count;
    Columns:= 14;
    Rows:= Count div Columns;
    if (Count mod Columns) <> 0 then Rows:= Rows +1;

    Bitmap.Width:= Columns * DX;
    Bitmap.Height:= Rows * DY;

    with Bitmap.Canvas do begin
      Brush.Color:= clFuchsia;
      Brush.Style:= bsSolid;
      FillRect(ClipRect);
    end;

    for X:= 0 to Columns do
      for Y:= 0 to Rows do
        ImageList_Draw(ImageList.Handle, X + Y * Columns, Bitmap.Canvas.Handle,
          X * DX +2, Y * DY +2, ild_Transparent);
  end;
end;

procedure RebuildMenuBar(MyMenu: TMenu);
var
  I: Integer;
begin
  for I:= 0 to ActiveMenuBarList.Count -1 do
    with TCustomMenuBar2000(ActiveMenuBarList[I]) do
      if Menu = MyMenu
      then PostMessage(Handle, wm_UpdateMenuBar, upForceRebuild, 0);
end;


const
  SSkinFilter = 'Skin files (*.skin)|*.skin|Text files (*.txt)|*.txt|XML files (*.xml)|*.xml';
  SMenuFilter = 'Menu files (*.menu)|*.menu|Text files (*.txt)|*.txt|XML files (*.xml)|*.xml';
  SSkinDefaultExt = 'skin';
  SMenuDefaultExt = 'menu';

{ Routines }

function ExecuteFileDialog(var Filename: String; var Format: Integer;
  const ATitle, AFilter, ADefaultExt: String): Boolean;
var
  F: TOpenDialog;
begin
  if Pos('Save', ATitle) <> 0
  then
    F:= TSaveDialog.Create(Application)
  else begin
    F:= TOpenDialog.Create(Application);
    F.Options:= [ofFileMustExist];
  end;

  F.DefaultExt:= ADefaultExt;
  F.Filter:= AFilter;
  F.Title:= ATitle;
  F.Options:= F.Options + [ofHideReadOnly, ofOverwritePrompt {$IFDEF Delphi4OrHigher}, ofEnableSizing{$ENDIF}];
  F.InitialDir:= ExtractFilePath(Filename);
  F.Filename:= Filename;
  F.FilterIndex:= Format;

  Result:= F.Execute;
  if Result
  then begin
    Filename:= F.Filename;
    Format:= F.FilterIndex;
  end;

  F.Free;
end;

function ExecuteOpenAnimatedSkinDialog: Boolean;
begin
  Result:= ExecuteFileDialog(FSkinFilename, FSkinFormat, 'Open AnimatedSkin™', SSkinFilter, SSkinDefaultExt);
end;

function ExecuteSaveAnimatedSkinDialog: Boolean;
begin
  Result:= ExecuteFileDialog(FSkinFilename, FSkinFormat, 'Save AnimatedSkin™', SSkinFilter, SSkinDefaultExt);
end;

function ExecuteOpenMenuDialog: Boolean;
begin
  Result:= ExecuteFileDialog(FMenuFilename, FMenuFormat, 'Open Menu', SMenuFilter, SMenuDefaultExt);
end;

function ExecuteSaveMenuDialog: Boolean;
begin
  Result:= ExecuteFileDialog(FMenuFilename, FMenuFormat, 'Save Menu As', SMenuFilter, SMenuDefaultExt);
end;




{ T_AM2000_MenuDesigner }

procedure T_AM2000_MenuDesigner.Edit;
begin
  if not Assigned(MenuDesignerDlg) then
    MenuDesignerDlg:= T_AM2000_MenuDesignerDlg.Create(Application);

  MenuDesignerDlg.Designer:= Designer;
  MenuDesignerDlg.Menu:= TMenu(GetComponent(0));
  MenuDesignerDlg.Show;
end;

function T_AM2000_MenuDesigner.GetValue: string;
begin
  Result:= '(Menu2000)';
end;

function T_AM2000_MenuDesigner.GetAttributes: TPropertyAttributes;
begin
  Result:= [paDialog, paReadOnly];
end;



{ T_AM2000_ComponentEditor }

constructor T_AM2000_ComponentEditor.Create(AComponent: TComponent;
{$IFDEF Delphi6OrHigher}
      ADesigner: IDesigner
{$ELSE}
{$IFDEF Delphi4OrHigher}
      ADesigner: IFormDesigner
{$ELSE}
      ADesigner: TFormDesigner
{$ENDIF}
{$ENDIF}
  );
begin
  inherited;

  if ((AComponent is TCustomMainMenu2000)
  and (not TCustomMainMenu2000(AComponent).ComponentLoaded))
  or ((AComponent is TCustomPopupMenu2000)
  and (not TCustomPopupMenu2000(AComponent).ComponentLoaded))
  or ((AComponent is TCustomMenuBar2000)
  and (not TCustomMenuBar2000(AComponent).ComponentLoaded))
  then begin
    ShowWelcome(AComponent, ADesigner);

    if (AComponent is TCustomMainMenu2000)
    then TCustomMainMenu2000(AComponent).ComponentLoaded:= True;

    if (AComponent is TCustomPopupMenu2000)
    then TCustomPopupMenu2000(AComponent).ComponentLoaded:= True;

    if (AComponent is TCustomMenuBar2000)
    then TCustomMenuBar2000(AComponent).ComponentLoaded:= True;
  end;
end;

procedure T_AM2000_ComponentEditor.Edit;
begin
  if MenuDesignerDlg = nil
  then MenuDesignerDlg:= T_AM2000_MenuDesignerDlg.Create(Application);

  MenuDesignerDlg.Designer:= Designer;
  MenuDesignerDlg.Menu:= TMenu(Component);
  MenuDesignerDlg.Show;
end;

function T_AM2000_ComponentEditor.GetVerbCount: Integer;
begin
{$IFDEF Delphi7OrHigher}
  Result:= inherited GetVerbCount +10;
{$ELSE}
  Result:= inherited GetVerbCount +11;
{$ENDIF}
end;

function T_AM2000_ComponentEditor.GetVerb(Index: Integer): String;
begin
  case Index of
    0: Result:= 'Edit Menu';
    1: Result:= '-';
    2: Result:= '&Open Menu From File...';
    3: Result:= '&Save Menu To File ...';
    4: Result:= '-';
    5: Result:= '&Load and Apply AnimatedSkin™...';
    6: Result:= 'S&ave Menu As AnimatedSkin™...';
    7: Result:= '&Reset Skin';
    8: Result:= '-';
    9: Result:= '&Show Animated Menus Welcome Wizard...';
{$IFDEF Delphi7OrHigher}
    else Result:= inherited GetVerb(Index -9);
{$ELSE}
    10: Result:= '-';
    else Result:= inherited GetVerb(Index -10);
{$ENDIF}
  end;
end;

procedure T_AM2000_ComponentEditor.ExecuteVerb(Index: Integer);
var
  S: TCustomAnimatedSkin2000;
  O: T_AM2000_Options;
begin
  case Index of
    0: Edit;

    2: //open menu
      if ExecuteOpenMenuDialog
      then begin
        LoadMenuFromFileFormat(Component, FMenuFilename, FMenuFormat);
        Designer.Modified;
      end;

    3: // save menu
      if ExecuteSaveMenuDialog
      then SaveMenuToFileFormat(Component, FMenuFilename, FMenuFormat);

    5: // load skin
      if ExecuteOpenAnimatedSkinDialog
      then begin
        LoadSkinFromFileFormat(Component, FSkinFilename, FSkinFormat);
        Designer.Modified;
      end;

    6: // save as skin
      if ExecuteSaveAnimatedSkinDialog
      then SaveSkinToFileFormat(Component, FSkinFilename, FSkinFormat);

    7: // reset
      begin
        S:= TCustomAnimatedSkin2000.Create(nil);
        S.AssignTo(Component);
        S.Free;

        if Component is TCustomMainMenu2000
        then O:= TCustomMainMenu2000(Component).Options
        else
        if Component is TCustomPopupMenu2000
        then O:= TCustomPopupMenu2000(Component).Options
        else O:= nil;

        if O <> nil
        then begin
          with O.Colors do;
          with O.Margins do;
          with O.Skin do;
          with O.Title do;
        end;

        Designer.Modified;
      end;

    9: ShowWelcome(Component, Designer);

    else
{$IFDEF Delphi7OrHigher}
      inherited ExecuteVerb(Index -10);
{$ELSE}
      inherited ExecuteVerb(Index -11);
{$ENDIF}
  end;
end;


{ TMenuDesignerDlg }

procedure T_AM2000_MenuDesignerDlg.CheckConstraints;
var
  P: Boolean;
  S: TTreeNode;
  M: TMenuItem2000;

  function IsClipboardObject: Boolean;
    // checks is object in lcipboard
  begin
    Result:= LowerCase(Copy(Trim(PasteFromClipboard), 1, 6)) = 'object';
  end;

begin
  S:= MenuTree.Selected;
  P:= (S <> nil) and (S.Parent <> nil);

  if S <> nil
  then M:= TMenuItem2000(S.Data)
  else M:= nil;

  ButtonDelete.Enabled:= P and (SelectedList.Count > 0) and (Copy(TTreeNode(SelectedList[0]).Text, 1, 4) <> '::::');
  ButtonLevelUp.Enabled:= P and (S.Parent.Parent <> nil);
  ButtonMoveUp.Enabled:= P and (S.GetPrevSibling <> nil);
  ButtonMoveDown.Enabled:=  P and (S.GetNextSibling <> nil);
  ButtonLevelDown.Enabled:= P;
  AutoBitmapsSet11.Enabled:= P;
{$IFDEF Delphi4OrHigher}
  ImageList1.Enabled:= P and (Menu.Images <> nil);
{$ELSE}
  ImageList1.Enabled:= P and
    (((Menu is TCustomPopupMenu2000) and (TCustomPopupMenu2000(Menu).Images <> nil))
    or
    ((Menu is TCustomMainMenu2000) and (TCustomMainMenu2000(Menu).Images <> nil)));
{$ENDIF}

{$IFDEF Delphi5OrHigher}
  SubMenuImages1.Enabled:= P and (M <> nil)
    and (M.Parent <> nil)
    and (M.Parent.SubMenuImages <> nil);
{$ELSE}
  SubMenuImages1.Enabled:= P and (M <> nil)
    and (M.Parent <> nil)
    and (M.Parent is TMenuItem2000)
    and (TMenuItem2000(M.Parent).SubMenuImages <> nil);
{$ENDIF}

  LoadBitmapFromFile1.Enabled:= P;
  SaveBitmapToFile1.Enabled:= P;
  FileNewItem1.Enabled:= P;
  MenuItem16.Enabled:= P;
  LoadBitmapFromFile1.Enabled:= P;
  SaveBitmapToFile1.Enabled:= P;
  ClearBitmap1.Enabled:= P;

  ButtonNewMenuItem.Enabled:= P;
  ButtonNewSeparator.Enabled:= P;

  // cut/copy/paste
  btnPaste.Enabled:= P and IsClipboardFormatAvailable(cf_Text) and IsClipboardObject;
  MenuItem26.Enabled:= btnPaste.Enabled;
  btnCut.Enabled:= ButtonDelete.Enabled;
  MenuItem24.Enabled:= btnCut.Enabled;
  btnCopy.Enabled:= (SelectedList.Count > 0);
  MenuItem25.Enabled:= btnCopy.Enabled;

end;

procedure T_AM2000_MenuDesignerDlg.InvalidateNode(Node: TTreeNode);
var
  R: TRect;
begin
  if (Node = nil) or Updating then Exit;

  try
    R:= Node.DisplayRect(False);
    InvalidateRect(MenuTree.Handle, @R, False)
  except
  end;
end;

procedure T_AM2000_MenuDesignerDlg.InvalidateList;
var
  I: Integer;
begin
  for I:= 0 to SelectedList.Count -1 do
    InvalidateNode(TTreeNode(SelectedList[I]));
end;

procedure T_AM2000_MenuDesignerDlg.MenuTreeChange(Sender: TObject;
  Node: TTreeNode);
var
  N: TTreeNode;
  Direction: Boolean;
begin
  if (not (Assigned(Node) and Assigned(Node.Data)))
  or (Updating)
  then begin
    Exit;
  end;

  try
    // set item index at ButtonArray1
    if Assigned(Node.Data) then
      with TMenuItem2000(Node.Data) do begin
        LockGlobalRepaint;
        with ButtonArray1.AsButtonArray do ItemIndex:= DefaultIndex;
        with ButtonArray3.AsButtonArray do ItemIndex:= ImageIndex;
        UnLockGlobalRepaint;
      end;

  except
  end;

  // custom draw support
  if Node = nil then Exit;

  // shift
  if GetKeyState(vk_Shift) < 0
  then begin
    InvalidateList;
    SelectedList.Clear;
    N:= Node;
    Direction:= N.AbsoluteIndex < SelStart.AbsoluteIndex;

    while (N <> nil)
    and (N <> SelStart)
    do begin
      SelectedList.Add(N);
      InvalidateNode(N);
      
      if Direction
      then N:= N.GetNextVisible
      else N:= N.GetPrevVisible;
    end;

    if N <> nil
    then begin
      SelectedList.Add(N);
      InvalidateNode(N);
    end;
  end

  else
  // control
  if GetKeyState(vk_Control) < 0
  then begin
    if Node <> nil then begin
      if SelectedList.IndexOf(Node) = -1
      then SelectedList.Add(Node)
      else SelectedList.Remove(Node);

      InvalidateNode(Node);
    end;
  end

  // none
  else begin
    SelStart:= nil;
    InvalidateList;
    SelectedList.Clear;
    SelectedList.Add(Node);
    InvalidateNode(Node);
  end;
                   
  CheckConstraints;
  UpdateSelections;
  DisplayEdit(Node);
end;

procedure T_AM2000_MenuDesignerDlg.MenuTreeChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  Edit1.Visible:= False;

  // check keys
  if (GetKeyState(vk_Shift) < 0)
  and (SelStart = nil)
  then SelStart:= MenuTree.Selected;
end;

procedure T_AM2000_MenuDesignerDlg.MenuTreeCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  txtRect, R: TRect;
  Bitmap, Bitmap2: HBitmap;
  NumGlyphs, BitmapIndex, DefaultIndex, DX: Integer;
  mi: TMenuItem2000;
  img: TImageList;
  S: String;
  NodeSelected: Boolean;
begin
  mi:= TMenuItem2000(Node.Data);
  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  or (mi = nil)
  then Exit;

  DX:= -20;
  DefaultDraw:= False;
  with T_AM2000_TreeView4(Sender), Canvas, Node
  do begin
    txtRect:= DisplayRect(True);
    S:= Text;
    NodeSelected:= (SelectedList.Count > 1)
      and (SelectedList.IndexOf(Node) <> -1);

    if NodeSelected
    then Font.Color:= clHighlightText
    else Font.Color:= clWindowText;

    if (Copy(S, 1, 4) = '::::')
    then begin
      Font.Color:= clBtnShadow;
      S:= '<' + Copy(S, 5, MaxInt) + '>';
    end;

    // selection
    if NodeSelected
    then Brush.Color:= clHighlight
    else Brush.Color:= Color;

    FillRect(DisplayRect(False));

    // caption
    R:= txtRect;
    R.Right:= Width;

    if IsSeparatorCaption(S)
    then begin
      DrawSeparator(Canvas, S, [isGraphBack], nil, R); 

    end
    else begin
      DrawText(Canvas.Handle, PChar(S), Length(S), R, dt_SingleLine + dt_VCenter + dt_NoPrefix);

      // draw shortcut
      if (mi.ShortCut <> '')
      and (mi.ShortCut <> #1)
      then begin
        R:= DisplayRect(False);
        SubtractRect(R, R, Rect(0, TxtRect.Top, TxtRect.Right, TxtRect.Bottom));
        R.Right:= TreeView.Width -20;

        DrawText(Canvas.Handle, PChar(mi.ShortCut), Length(mi.ShortCut), R,
          dt_SingleLine + dt_VCenter + dt_Right);
      end;


      // draw bitmap
{$IFDEF Delphi4OrHigher}
      img:= TImageList(TMainMenu(FMenu).Images);
{$ELSE}
      if FMenu is TMainMenu2000
      then
        img:= TImageList(TMainMenu2000(FMenu).Images)
      else
      if FMenu is TPopupMenu2000
      then
        img:= TImageList(TPopupMenu2000(FMenu).Images)
      else
        img:= nil;
{$ENDIF}


      if (mi is TMenuItem2000)
      and (TMenuItem2000(mi).HasBitmap)
      then begin
        Bitmap:= TMenuItem2000(mi).Bitmap.Handle;
        NumGlyphs:= TMenuItem2000(mi).NumGlyphs;
      end
      else begin
        Bitmap:= 0;
        NumGlyphs:= 0;
      end;

      // bitmap index
      BitmapIndex:= -1;

      if Images <> nil then
  {$IFDEF Delphi4OrHigher}
      BitmapIndex:= mi.ImageIndex;
  {$ELSE}
      if mi is TMenuItem2000
      then BitmapIndex:= TMenuItem2000(mi).ImageIndex;
  {$ENDIF}

      // default index
      if mi is TMenuItem2000
      then DefaultIndex:= TMenuItem2000(mi).DefaultIndex
      else DefaultIndex:= -1;

      // second bitmap
      if mi.RadioItem
      then Bitmap2:= bmpRadioItem
      else Bitmap2:= bmpCheckMark;

      // draw bitmap
      R:= Rect(0, TxtRect.Top, TxtRect.Left, TxtRect.Bottom);
      FillRect(R);

      R:= Rect(0, 0, 16, 16);
      if HasChildren
      then Dec(DX, 13);
      OffsetRect(R, txtRect.Left + DX, (txtRect.Bottom + txtRect.Top) div 2 -9);
      if BitmapIndex > -1
      then
        DrawBitmapImageList(Canvas, BitmapIndex, img, Bitmap2, [], nil, R)

      else
      if DefaultIndex > -1
      then
        DrawBitmapIndex(Canvas, DefaultIndex, Bitmap2, [], nil, R)

      else
      if (DefaultIndex = -1)
      and (Bitmap = 0)
      and MenuItemCache.IsDefault(mi.Caption)
      and MenuItemCache[mi.Caption].HasBitmap
      then
        DrawBitmapCache(Canvas, mi.Caption, Bitmap2, [], nil, R)

      else
        DrawBitmapHandle(Canvas, Bitmap, NumGlyphs, Bitmap2, [], nil, R);
    end;

    // draw button
    if HasChildren
    then begin
      R:= Rect(0, 0, 9, 9);
      OffsetRect(R, txtRect.Left -14, (txtRect.Bottom + txtRect.Top) div 2 -5);
      Brush.Color:= clWindow;
      FillRect(R);

      Brush.Color:= clBtnShadow;
      FrameRect(R);

      Pen.Color:= T_AM2000_TreeView4(Sender).Font.Color;
      Pen.Style:= psSolid;
      if Expanded then begin
        PolyLine([Point(R.Left +2, R.Top +4), Point(R.Right -2, R.Top +4)]);
      end
      else begin
        PolyLine([Point(R.Left +4, R.Top +2), Point(R.Left +4, R.Bottom -2)]);
        PolyLine([Point(R.Left +2, R.Top +4), Point(R.Right -2, R.Top +4)]);
      end;
    end;
  end;
end;

procedure T_AM2000_MenuDesignerDlg.MenuTreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  N: TTreeNode;
  P: TPoint;
  I: Integer;
begin
  N:= nil;
  with MenuTree
  do begin
    if (htOnButton in GetHitTestInfoAt(X, Y))
    then begin
      Edit1.Visible:= False;
    end
    else begin
      P:= Point(X, Y);
      for I:= 0 to Items.Count -1
      do 
        if PtInRect(Items[I].DisplayRect(False), P)
        then begin
          N:= Items[I];
          Break;
        end;
    end;

    if (N <> nil)
    then
      if (Selected = N)
      then DisplayEdit(N)
      else Selected:= N;
  end;
end;

procedure T_AM2000_MenuDesignerDlg.Loaded;
const
  DX = 21;
  DY = 20;
var
  Reg: TRegistry;
  Res: Integer;

  procedure InitButtonArray(BA: T_AM2000_ButtonArrayControl; iCount: Integer);
  begin
    with BA do begin
      Columns:= 11;
      Count:= iCount;
      Rows:= iCount div Columns;
      if iCount mod Columns <> 0 then Rows:= Rows +1;
      Bitmap.Width:= Columns * DX;
      Bitmap.Height:= Rows * DY;
      Bitmap.Canvas.Brush.Color:= clFuchsia;
      Bitmap.Canvas.FillRect(Bitmap.Canvas.ClipRect);
    end;
  end;

  procedure DrawBitmapArray(BA1: T_AM2000_ButtonArrayControl; iCount: Integer);
  var
    mici: T_AM2000_MenuItemCacheItem;
    I, X, Y: Integer;
    S: String;
    BA: T_AM2000_ButtonArrayControl;
  begin
    X:= 0;
    Y:= 0;
    BA:= BA1;
    InitButtonArray(BA1, iCount);

    for I:= 0 to MenuItemCache.Count -1 do begin
      mici:= T_AM2000_MenuItemCacheItem(TStringList(MenuItemCache).Objects[I]);

      // change button array
      if mici.DefaultIndex = iCount
      then Exit;

      // draw
      if (mici.HasBitmap)
      then begin
        ImageList_Draw(MenuItemCache.Images, I, BA.Bitmap.Canvas.Handle,
          X * DX +2, Y * DY + 2, ild_Transparent);

        S:= TStringList(MenuItemCache)[I];
        if mici.Hint <> '' then AppendStr(S, ':'#13 + mici.Hint);
        BA.Hints.Add(S);

        Inc(X);
        if X >= BA.Columns then begin
          Inc(Y);
          X:= 0;
        end;
      end;
    end;
  end;

begin
  inherited;


  // load autobitmaps & autohints
  Res:= MenuItemCache.BitmapCount;
  DrawBitmapArray(ButtonArray1.AsButtonArray, Res);

{$IFDEF Delphi3OrHigher}
  // set flat property
  Toolbar1.Flat:= True;
{$ENDIF}

  // load menu templates
  Reg:= TRegistry.Create;

  // load Menu Designer parameters
  if Reg.OpenKey(MENU_REGISTRY_KEY + 'DesignerOptions', False)
  then
    try
      Left:= Reg.ReadInteger('Left');
      Top:= Reg.ReadInteger('Top');
      Width:= Reg.ReadInteger('Width');
      Height:= Reg.ReadInteger('Height');
      Font.Name:= Reg.ReadString('FontName');
      Font.Size:= Reg.ReadInteger('FontSize');
{$IFDEF Delphi3OrHigher}
      Font.Charset:= Reg.ReadInteger('FontCharset');
{$ENDIF}
    except
    end;

  Reg.Free;

  Edit1.Height:= Canvas.TextHeight('Hj');
  if Edit1.Font.Name <> Font.Name
  then begin
    Edit1.Font.Name:= Font.Name;
    Edit1.Font.Size:= Font.Size;
  end;
  
end;

procedure T_AM2000_MenuDesignerDlg.FormShow(Sender: TObject);
begin
  // create and initialize dialogs
{$IFDEF Delphi3OrHigher}
  OpenPictureDialog1:= TOpenPictureDialog.Create(Self);
  SavePictureDialog1:= TSavePictureDialog.Create(Self);
{$ELSE}
  OpenPictureDialog1:= TOpenDialog.Create(Self);
  SavePictureDialog1:= TSaveDialog.Create(Self);
{$ENDIF}

  with OpenPictureDialog1
  do begin
    DefaultExt:= 'bmp';
    Filter:= SBitmapDialogFilter;
    Options:= [ofHideReadOnly, ofPathMustExist, ofFileMustExist];
    Title:= SOpenBitmapDialogTitle;
  end;

  with SavePictureDialog1
  do begin
    DefaultExt:= 'bmp';
    FileName:= 'Untitled-1.bmp';
    Filter:= SBitmapDialogFilter;
    Options:= [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist];
    Title:= SSaveBitmapDialogTitle;
  end;

  // build preview form
  if Preview = nil
  then begin
    Preview:= T_AM2000_Preview.Create(Self);
    Preview.Left:= Left + Width +10;
    Preview.Top:= Top;
    Preview.SetMenu(FMenu);
  end;

  if (Menu = nil)
  or (csDesigning in Menu.ComponentState)
  then
//    ActiveMenuBarList.Clear
  else begin
    FileNewMainMenu1.Enabled:= False;
    FileNewPopupMenu1.Enabled:= False;
  end;


  MenuDesigner:= Self;
end;

procedure T_AM2000_MenuDesignerDlg.FormHide(Sender: TObject);
begin
  MenuDesigner:= nil;
  Designer:= nil;
  Preview.Hide;
end;

procedure T_AM2000_MenuDesignerDlg.FormCreate(Sender: TObject);
begin
  Updating:= False;
  SelectedList:= TList.Create;
  MenuItemList:= TList.Create;
  TreeNodeList:= TList.Create;
  Menus:= TList.Create;
end;

procedure T_AM2000_MenuDesignerDlg.FormDestroy(Sender: TObject);
begin
  Updating:= True;
  SelectedList.Free;
  MenuItemList.Free;
  TreeNodeList.Free;
  Menus.Free;
  MenuDesignerDlg:= nil;
  Preview.Free;
end;

procedure T_AM2000_MenuDesignerDlg.CollapseAll1Click(Sender: TObject);
begin
  MenuTree.FullCollapse;
end;

procedure T_AM2000_MenuDesignerDlg.ExpandAll1Click(Sender: TObject);
begin
  MenuTree.FullExpand;
end;

procedure T_AM2000_MenuDesignerDlg.ButtonNewMenuItemClick(Sender: TObject);
var
  N, N1: TTreeNode;
  M, M1: TMenuItem2000;
begin
  N:= MenuTree.Selected;
  if (not Assigned(N))
  or (not Assigned(N.Parent)) then Exit;

  // clear selection
  InvalidateList;
  SelectedList.Clear;
  SelectedList.Add(N);
  InvalidateNode(N);

  M:= TMenuItem2000(N.Data);
  M1:= TMenuItem2000.Create(Menu.Owner);

  if (Sender = nil)
  or (TComponent(Sender).Tag = 0)
  then begin
    M1.Caption:= SDefaultMenuItemCaption;
    if Designer <> nil
    then M1.Name:= Designer.UniqueName(SDefaultMenuItemName);
  end
  else begin
    case TComponent(Sender).Tag
    of
      1: // new separator
        M1.Caption:= SSeparator;
      2: // new double separator
        M1.Caption:= SDoubleSeparator;
      3: // new dotted separator
        M1.Caption:= SDottedSeparator;
      4: // new double dotted separator
        M1.Caption:= SDoubleDottedSeparator;
      5: // new empty separator
        M1.Caption:= SEmptySeparator;
    end;

    if Designer <> nil
    then M1.Name:= Designer.UniqueName('N');
  end;

  if (N.GetNextSibling <> nil)
  then begin
    N1:= MenuTree.Items.Insert(N.GetNextSibling, M1.Caption);
    M.Parent.Insert(M.MenuIndex +1, M1);
  end
  else begin
    N1:= MenuTree.Items.Add(N, M1.Caption);
    M.Parent.Add(M1);
  end;

  N1.Selected:= True;
  N1.Data:= M1;
  TreeNodeList.Add(N1);
  MenuItemList.Add(N1.Data);

  // customdraw
  InvalidateList;
  SelectedList.Clear;
  SelectedList.Add(N1);
  InvalidateNode(N1);

  SelectComponent(M1, True);

  RebuildMenuBar(Menu);

  DisplayEdit(N1);

  if Preview <> nil
  then Preview.Refresh;

  CheckConstraints;
end;

procedure T_AM2000_MenuDesignerDlg.ButtonNewSubMenuClick(Sender: TObject);
var
  N: TTreeNode;
  M: TMenuItem2000;
begin
  if not Assigned(MenuTree.Selected) then Exit;
  N:= MenuTree.Items.AddChild(MenuTree.Selected, SDefaultMenuItemCaption);

  // clear selection
  InvalidateList;
  SelectedList.Clear;
  SelectedList.Add(N);
  InvalidateNode(N);

  M:= TMenuItem2000.Create(Menu.Owner);
  M.Caption:= SDefaultMenuItemCaption;
  
  if Designer <> nil
  then M.Name:= Designer.UniqueName(SDefaultMenuItemName);

  TMenuItem2000(MenuTree.Selected.Data).Add(M);
  MenuTree.Selected.Expand(False);

  N.Selected:= True;
  N.Data:= M;
  TreeNodeList.Add(N);
  MenuItemList.Add(N.Data);

  // customdraw
  InvalidateList;
  SelectedList.Clear;
  SelectedList.Add(N);
  InvalidateNode(N);

  SelectComponent(M, True);

  RebuildMenuBar(Menu);

  DisplayEdit(N);

  if Preview <> nil
  then Preview.Refresh;

  CheckConstraints;
end;

procedure T_AM2000_MenuDesignerDlg.ButtonDeleteClick(Sender: TObject);
begin
  if not ButtonDelete.Enabled then Exit;

  if (SelectedList.Count > 1)
  and (MessageDlg(SOkToDeleteThese + IntToStr(SelectedList.Count) + SSelectedItems, mtConfirmation,
    mbOkCancel, 0) <> mrOk)
  then Exit;

  ClearSelections;

  if Preview <> nil
  then begin
    Preview.KillSubForms;
    Preview.Refresh;
  end;
end;

procedure T_AM2000_MenuDesignerDlg.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if MenuTree.IsEditing
  then
    case Key of
      vk_Return:
        ButtonNewMenuItemClick(nil);
      vk_Escape:
        if MenuTree.Selected.Text = SDefaultMenuItemCaption
        then ButtonDeleteClick(nil);
    end
  else
    case Key of
      vk_Insert:
        ButtonNewMenuItemClick(nil);
    end;
  CheckConstraints;
end;

procedure T_AM2000_MenuDesignerDlg.ButtonMoveDownClick(Sender: TObject);
var
  N, N1: TTreeNode;
  M, M1: TMenuItem2000;
begin
  N:= MenuTree.Selected;
  if (not Assigned(N))
  or (not Assigned(N.Parent)) then Exit;

  // clear selection
  InvalidateList;
  SelectedList.Clear;
  SelectedList.Add(N);
  InvalidateNode(N);

  N1:= N.GetNextSibling;

  // updating
  Updating:= True;
  MenuTree.Items.BeginUpdate;

  if Assigned(N1)
  then begin
    N1:= N1.GetNextSibling;

    if Assigned(N1)
    then N.MoveTo(N1, naInsert)
    else N.MoveTo(N.Parent, naAddChild);

    with TMenuItem2000(N.Data) do MenuIndex:= MenuIndex +1;

  end
  else begin
    N1:= N.Parent.GetNextSibling;
    if Assigned(N1) then begin
      N.MoveTo(N1, naAddChildFirst);

      M:= TMenuItem2000(N.Data);
      M1:= M.Parent.Parent.Items[M.Parent.MenuIndex +1];
      M.Parent.Remove(M);
      M1.Insert(0, M);
    end
  end;

  MenuTree.Items.EndUpdate;
  Updating:= False;

  CheckConstraints;

  RebuildMenuBar(Menu);

  if Edit1.Visible
  then DisplayEdit(N);
  
end;

procedure T_AM2000_MenuDesignerDlg.ButtonMoveUpClick(Sender: TObject);
var
  N, N1: TTreeNode;
  M, M1: TMenuItem2000;
begin
  N:= MenuTree.Selected;
  if (not Assigned(N))
  or (not Assigned(N.Parent)) then Exit;

  // clear selection
  InvalidateList;
  SelectedList.Clear;
  SelectedList.Add(N);
  InvalidateNode(N);

  N1:= N.GetPrevSibling;
  if N1 = N.Parent then Exit;

  // updating
  Updating:= True;
  MenuTree.Items.BeginUpdate;

  if Assigned(N1)
  then begin
    N.MoveTo(N1, naInsert);
    with TMenuItem2000(N.Data)
    do MenuIndex:= MenuIndex -1;
  end
  else begin
    N1:= N.Parent.GetPrevSibling;
    if Assigned(N1)
    then begin
      N.MoveTo(N1, naAddChild);

      M:= TMenuItem2000(N.Data);
      M1:= M.Parent.Parent.Items[M.Parent.MenuIndex -1];
      M.Parent.Remove(M);
      M1.Add(M);

    end;
  end;

  MenuTree.Items.EndUpdate;
  Updating:= False;
  CheckConstraints;

  RebuildMenuBar(Menu);

  if Edit1.Visible
  then DisplayEdit(N);

end;

procedure T_AM2000_MenuDesignerDlg.ButtonLevelUpClick(Sender: TObject);
var
  N, N1: TTreeNode;
  M, M1: TMenuItem2000;
  I: Integer;
begin
  N:= MenuTree.Selected;
  if (not Assigned(N))
  or (not Assigned(N.Parent))
  or (not Assigned(N.Parent.Parent)) then Exit;

  // clear selection
  InvalidateList;
  SelectedList.Clear;
  SelectedList.Add(N);
  InvalidateNode(N);

  N1:= N.Parent.GetNextSibling;

  // updating
  Updating:= True;
  MenuTree.Perform(wm_SetRedraw, 0, 0);
  MenuTree.Items.BeginUpdate;

  M:= TMenuItem2000(N.Data);
  M1:= M.Parent.Parent;
  I:= M.Parent.MenuIndex;
  M.Parent.Remove(M);

  if Assigned(N1) then begin
    N.MoveTo(N1, naInsert);
    M1.Insert(I +1, M);

  end
  else begin
    N.MoveTo(N.Parent.Parent, naAddChild);
    M1.Add(M);

  end;

  MenuTree.Items.EndUpdate;
  Updating:= False;
  CheckConstraints;

  RebuildMenuBar(Menu);

  if Edit1.Visible
  then DisplayEdit(N);

end;

procedure T_AM2000_MenuDesignerDlg.ButtonLevelDownClick(Sender: TObject);
var
  N, N1: TTreeNode;
  M, M1, M2: TMenuItem2000;
  I: Integer;
begin
  N:= MenuTree.Selected;
  if (not Assigned(N))
  or (not Assigned(N.Parent)) then Exit;

  // clear selection
  InvalidateList;
  SelectedList.Clear;
  SelectedList.Add(N);
  InvalidateNode(N);

  // treeview...
  N1:= N.GetPrevSibling;

  // updating
  Updating:= True;
  MenuTree.Items.BeginUpdate;

  // menu...
  M:= TMenuItem2000(N.Data);
  M1:= M.Parent;
  I:= M.MenuIndex;
  M.Parent.Remove(M);

  if Assigned(N1)
  then begin
    N.MoveTo(N1, naAddChild);
    M1[I -1].Add(M);
  end
  else begin
    N1:= MenuTree.Items.AddChildFirst(N.Parent, SDefaultMenuItemCaption);
    N.MoveTo(N1, naAddChild);

    M2:= TMenuItem2000.Create(Menu.Owner);
    M2.Caption:= SDefaultMenuItemCaption;

    if Designer <> nil
    then M2.Name:= Designer.UniqueName(SDefaultMenuItemName);

    M2.Add(M);
    M1.Insert(0, M2);

    N1.Data:= M2;
    TreeNodeList.Add(N1);
    MenuItemList.Add(N1.Data);

  end;

  MenuTree.Items.EndUpdate;
  Updating:= False;
  CheckConstraints;

  RebuildMenuBar(Menu);

  if Edit1.Visible
  then DisplayEdit(N);
  
end;

procedure T_AM2000_MenuDesignerDlg.wmUpdate(var Msg: TMessage);
var
  I: Integer;
  Node: TTreeNode;
begin
  // get menu item index
  I:= MenuItemList.IndexOf(Pointer(Msg.LParam));

  // get tree node
  if I <> -1
  then begin
    Node:= TTreeNode(TreeNodeList[I]);
    if Node.Parent <> nil
    then Node.Text:= TMenuItem2000(Pointer(Msg.LParam)).Caption;

    InvalidateNode(Node);

    if Edit1.Visible
    then begin
      Edit1.Text:= Node.Text;
      Edit1.SelectAll;
    end;

    if Preview <> nil
    then Preview.Refresh;
  end;
end;

procedure T_AM2000_MenuDesignerDlg.LoadMenuClick(Sender: TObject);
  // loads menu from file
begin
  if not ExecuteOpenMenuDialog
  then Exit;

  LoadMenuFromFileFormat(Menu, FMenuFilename, FMenuFormat);

  if Designer <> nil
  then Designer.Modified;

  RebuildMenuBar(Menu);
end;


procedure T_AM2000_MenuDesignerDlg.SaveMenuClick(Sender: TObject);
  // saves menu to a file
begin
  if ExecuteSaveMenuDialog
  then SaveMenuToFileFormat(Menu, FMenuFilename, FMenuFormat);
end;

procedure T_AM2000_MenuDesignerDlg.LoadSkinClick(Sender: TObject);
begin
  if not ExecuteOpenAnimatedSkinDialog
  then Exit;

  LoadSkinFromFileFormat(Menu, FSkinFilename, FSkinFormat);

  if Designer <> nil
  then Designer.Modified;

  RebuildMenuBar(Menu);
end;

procedure T_AM2000_MenuDesignerDlg.SaveSkinClick(Sender: TObject);
begin
  if ExecuteSaveAnimatedSkinDialog
  then SaveSkinToFileFormat(Menu, FSkinFilename, FSkinFormat);
end;

procedure T_AM2000_MenuDesignerDlg.LoadBitmapFromFileClick(Sender: TObject);
begin
  if not OpenPictureDialog1.Execute
  then Exit;

  with TMenuItem2000(MenuTree.Selected.Data) do
    Bitmap.LoadFromFile(OpenPictureDialog1.Filename);

  if Designer <> nil
  then Designer.Modified;

  RebuildMenuBar(Menu);
end;

procedure T_AM2000_MenuDesignerDlg.SaveBitmapToFileClick(Sender: TObject);
begin
  if not SavePictureDialog1.Execute
  then Exit;

  with TMenuItem2000(MenuTree.Selected.Data) do
    Bitmap.SaveToFile(SavePictureDialog1.Filename);
end;

procedure T_AM2000_MenuDesignerDlg.PopupMenu20001Popup(Sender: TObject);
  // restore bitmap indexes
var
  il: TImageList;
begin
  if Assigned(MenuTree.Selected) then
    with TMenuItem2000(MenuTree.Selected.Data) do begin
      LockGlobalRepaint;
      ButtonArray1.AsButtonArray.ItemIndex:= DefaultIndex;
      UnLockGlobalRepaint;
    end;

  // load bitmaps from menu's imagelist
  il:= nil;
  if Menu is TMainMenu2000 then il:= TImageList(TCustomMainMenu2000(Menu).Images);
  if Menu is TPopupMenu2000 then il:= TImageList(TCustomPopupMenu2000(Menu).Images);
  ImageList1.Enabled:= (MenuTree.Selected <> nil)
    and (MenuTree.Selected.Parent <> nil)
    and (il <> nil)
    and (il.Count > 0);
end;

procedure T_AM2000_MenuDesignerDlg.None1Click(Sender: TObject);
  // remove the bitmap
begin
  with MenuTree.Selected, TMenuItem2000(Data)
  do begin
    DefaultIndex:= -1;
    ImageIndex:= -1;
    if HasBitmap then begin
      Bitmap.Handle:= 0;
    end;

    SelectComponent(TMenuItem2000(Data), True);

    RebuildMenuBar(Menu);
  end;
end;

procedure T_AM2000_MenuDesignerDlg.ButtonArray1Click(Sender: TObject);
  // assigns default bitmaps
begin
  with ButtonArray1.AsButtonArray, MenuTree.Selected, TMenuItem2000(Data)
  do begin
    DefaultIndex:= ItemIndex;
    ImageIndex:= -1;
    ButtonArray3.AsButtonArray.ItemIndex:= -1;

    SelectComponent(TMenuItem2000(Data), True);

    RebuildMenuBar(Menu);
  end;
end;

procedure T_AM2000_MenuDesignerDlg.ButtonArray3Click(Sender: TObject);
  // assigns imagelist's bitmap
begin
  with ButtonArray3.AsButtonArray, MenuTree.Selected, TMenuItem2000(Data)
  do begin
    DefaultIndex:= -2;
    ImageIndex:= ItemIndex;
    ButtonArray1.AsButtonArray.ItemIndex:= -1;

    SelectComponent(TMenuItem2000(Data), True);

    RebuildMenuBar(Menu);
  end;
end;

procedure T_AM2000_MenuDesignerDlg.ClearBitmap1Click(Sender: TObject);
begin
  with MenuTree.Selected, TMenuItem2000(Data)
  do begin
    ClearBitmap(Bitmap);
    DefaultIndex:= -2;
    ImageIndex:= -1;
    ButtonArray1.AsButtonArray.ItemIndex:= -1;
    ButtonArray3.AsButtonArray.ItemIndex:= -1;

    SelectComponent(TMenuItem2000(Data), True);

    InvalidateNode(MenuTree.Selected);
    RebuildMenuBar(Menu);
  end;
end;

procedure T_AM2000_MenuDesignerDlg.SetMenu(const Value: TMenu);
var
  I: Integer;
  C, C1: TComponent;
  N: TTreeNode;

  procedure AddMenuItem(M: TMenuItem2000; T: TTreeNodes; N: TTreeNode);
  var
    I: Integer;
    N1: TTreeNode;
  begin
    for I:= 0 to M.Count -1
    do begin
      N1:= T.AddChild(N, M[I].Caption);
      N1.Data:= M[I];
      TreeNodeList.Add(N1);
      MenuItemList.Add(N1.Data);
      if M[I].Count > 0 
      then AddMenuItem(M[I], T, N1);
    end;
  end;

  function AddMenu(Menu: TMenu): TTreeNode;
  var
    MI: TMenuItem2000;
  begin
    Result:= nil;
    try
      MI:= nil;

      if Menu is TCustomMainMenu2000 then MI:= TCustomMainMenu2000(Menu).Items2000;
      if Menu is TCustomPopupMenu2000 then MI:= TCustomPopupMenu2000(Menu).Items2000;

      if Menu.Name = ''
      then Result:= MenuTree.Items.Add(nil, '<no name>')
      else Result:= MenuTree.Items.Add(nil, Menu.Name);
      Result.Data:= MI;
      TreeNodeList.Add(Result);
      MenuItemList.Add(Result.Data);

      AddMenuItem(MI, MenuTree.Items, Result);

    except
    end;
  end;

begin
  // updating
  Updating:= True;
  MenuTree.Items.BeginUpdate;

  // init menu tree items
  MenuTree.Items.Clear;
  SelectedList.Clear;
  MenuItemList.Clear;
  TreeNodeList.Clear;
  Menus.Clear;

  FMenu:= Value;
  if FMenu = nil
  then begin
    MenuTree.Items.EndUpdate;
    Exit;
  end;

  C:= FMenu.Owner;
  for I:= 0 to C.ComponentCount -1
  do begin
    C1:= C.Components[I];
    if (C1 is TCustomMainMenu2000)
    or (C1 is TCustomPopupMenu2000)
    then begin
      N:= AddMenu(TMenu(C1));
      if C1 = FMenu
      then begin
        N.Expand(False);
        MenuTree.Selected:= N;
      end;
    end;
  end;

  MenuTree.Items.EndUpdate;
  Updating:= False;

  // build preview form
  if Preview <> nil
  then begin
    Preview.Left:= Left + Width +10;
    Preview.Top:= Top;
    Preview.SetMenu(FMenu);
  end;
end;

procedure T_AM2000_MenuDesignerDlg.AM2000MenuDesigner6Click(
  Sender: TObject);
begin
  // updating
  Updating:= True;
  MenuTree.Items.BeginUpdate;
  MenuTree.FullExpand;
  MenuTree.Items.EndUpdate;
  Updating:= False;
end;

procedure T_AM2000_MenuDesignerDlg.AM2000MenuDesigner7Click(
  Sender: TObject);
begin
  // updating
  Updating:= True;
  MenuTree.Items.BeginUpdate;
  MenuTree.FullCollapse;
  MenuTree.Items.EndUpdate;
  Updating:= False;
end;

procedure T_AM2000_MenuDesignerDlg.MenuTreeEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
  AllowEdit:= Node.Parent <> nil;
end;

procedure T_AM2000_MenuDesignerDlg.ButtonStayOnTopClick(Sender: TObject);
begin
  SelectedList.Clear;

  if ButtonStayOnTop.Down
  then FormStyle:= fsStayOnTop
  else FormStyle:= fsNormal;

  if MenuTree.Items.Count > 0 then
    MenuTree.Items[0].Expand(False);
end;

procedure T_AM2000_MenuDesignerDlg.ImageList1Click(Sender: TObject);
var
  il: TImageList;
begin
  // load bitmaps from menu's imagelist
  il:= nil;
  if Menu is TMainMenu2000 then il:= TImageList(TCustomMainMenu2000(Menu).Images);
  if Menu is TPopupMenu2000 then il:= TImageList(TCustomPopupMenu2000(Menu).Images);

  if (il = nil) or (il.Count = 0)
  then begin
    ImageList1.Enabled:= False;
    ClearBitmap(ButtonArray3.AsButtonArray.Bitmap);
  end
  else begin
    DrawImageList(ButtonArray3, il);
    ImageList1.Enabled:= True;
  end;
end;

procedure T_AM2000_MenuDesignerDlg.SubMenuImages1Click(Sender: TObject);
var
  il: TImageList;
  M: TMenuItem;
begin
  // load bitmaps from SubMenuImages
  il:= nil;
  M:= TMenuItem(MenuTree.Selected.Data);

{$IFDEF Delphi5OrHigher}
  if (M <> nil)
  and (M.Parent <> nil)
  then il:= TImageList(M.Parent.SubMenuImages);
{$ELSE}
  if (M <> nil)
  and (M.Parent <> nil)
  and (M.Parent is TMenuItem2000)
  then il:= TMenuItem2000(M.Parent).SubMenuImages;
{$ENDIF}

  if (il = nil) or (il.Count = 0)
  then begin
    SubMenuImages1.Enabled:= False;
    ClearBitmap(ButtonArray4.AsButtonArray.Bitmap);
  end
  else begin
    DrawImageList(ButtonArray4, il);
    SubMenuImages1.Enabled:= True;
  end;
end;

procedure T_AM2000_MenuDesignerDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Reg: TRegistry;
begin
  Action:= caFree;

  // store menu designer params
  Reg:= TRegistry.Create;
  Reg.OpenKey(MENU_REGISTRY_KEY + 'DesignerOptions', True);
  Reg.WriteInteger('Left', Left);
  Reg.WriteInteger('Top', Top);
  Reg.WriteInteger('Width', Width);
  Reg.WriteInteger('Height', Height);
  Reg.WriteString('FontName', MenuTree.Font.Name);
  Reg.WriteInteger('FontSize', MenuTree.Font.Size);
{$IFDEF Delphi3OrHigher}
  Reg.WriteInteger('FontCharset', MenuTree.Font.Charset);
{$ENDIF}
  Reg.Free;
end;

procedure T_AM2000_MenuDesignerDlg.SelectMenuItem(const AnItem: TMenuItem2000);
var
  I: Integer;
  N: TTreeNode;
begin
  SelectComponent(AnItem, True);

  // get the menu item
  I:= MenuItemList.IndexOf(AnItem);
  N:= TTreeNode(TreeNodeList[I]);
  if (N = nil)
  or (N.Data <> AnItem)
  then Exit;

  if not N.Parent.Expanded
  then begin
    MenuTree.Items.BeginUpdate;

    MenuTree.FullCollapse;
    N.Expand(False);
    
    MenuTree.Items.EndUpdate;
  end;

  MenuTree.Selected:= N;

  SelectedList.Clear;
  SelectedList.Add(N);
  DisplayEdit(N);

  if Preview <> nil
  then Preview.Refresh;
end;


procedure T_AM2000_MenuDesignerDlg.DeselectAll1Click(Sender: TObject);
begin
  InvalidateList;
  SelectedList.Clear;
  UpdateSelections;
end;

procedure T_AM2000_MenuDesignerDlg.UpdateSelections;
var
  I: Integer;
{$IFDEF Delphi6OrHigher}
  S: IDesignerSelections;
{$ELSE}
{$IFDEF Delphi5OrHigher}
  S: TDesignerSelectionList;
{$ELSE}
  S: TComponentList;
{$ENDIF}
{$ENDIF}
begin
  if Designer = nil then Exit;

  Screen.Cursor:= crHourglass;

  if SelectedList.Count > 1
  then begin
{$IFDEF Delphi6OrHigher}
    S:= TDesignerSelections.Create as IDesignerSelections;
{$ELSE}
{$IFDEF Delphi5OrHigher}
    S:= TDesignerSelectionList.Create;
{$ELSE}
    S:= TComponentList.Create;
{$ENDIF}
{$ENDIF}

    for I:= 0 to SelectedList.Count -1 do
      S.Add(TMenuItem2000(TTreeNode(SelectedList[I]).Data));

    Designer.SetSelections(S);
{$IFNDEF Delphi6OrHigher}
    S.Free;
{$ENDIF}
  end
  else
    if (SelectedList.Count = 1)
    and (TTreeNode(SelectedList[0]).Parent <> nil)
    and (Copy(TTreeNode(SelectedList[0]).Text, 1, 2) <> '::')
    then SelectComponent(TMenuItem2000(TTreeNode(SelectedList[0]).Data), False)
    else SelectComponent(Menu, False);

  Screen.Cursor:= crDefault;
end;

procedure T_AM2000_MenuDesignerDlg.ClearSelections;
  // removes selections
var
  N: TTreeNode;
  SL1: TList;
  I: Integer;

  function RemoveFromSelList(Node: TTreeNode): Integer;
    // remove node and its children
  var
    I, C: Integer;
  begin
    Result:= 0;
    if (Node = nil) then Exit;
    C:= SL1.Count;
    SL1.Remove(Node);

    I:= 0;
    while I < SL1.Count -1 do begin
      if Node.IndexOf(TTreeNode(SL1[I])) <> -1
      then Dec(I, RemoveFromSelList(TTreeNode(SL1[I])));
      Inc(I);
    end;

    Result:= C - SL1.Count;
  end;

begin
  // updating
  Updating:= True;
  MenuTree.Items.BeginUpdate;

  SL1:= TList.Create;
  for I:= 0 to SelectedList.Count -1 do
    SL1.Add(SelectedList[I]);

  SelectedList.Clear;

  while SL1.Count > 0 do begin
    N:= TTreeNode(SL1[0]);
    RemoveFromSelList(N);
    TMenuItem2000(N.Data).Free;
    N.Free;
  end;

  SL1.Free;

  MenuTree.Items.EndUpdate;
  Updating:= False;
  CheckConstraints;

  if Designer <> nil
  then Designer.Modified;

  RebuildMenuBar(Menu);
end;

procedure T_AM2000_MenuDesignerDlg.CopySelections;
var
  S, S2: String;
  M1, M2: TMemoryStream;
  I: Integer;
begin
  if SelectedList.Count = 0 then Exit;

  S:= '';
  M1:= TMemoryStream.Create;
  M2:= TMemoryStream.Create;

  for I:= 0 to SelectedList.Count -1 do begin
    // write menu item into m1
    M1.WriteComponent(TMenuItem2000(TTreeNode(SelectedList[I]).Data));
    M1.Seek(0, 0);

    // ObjectResourceToText
    ObjectBinaryToText(M1, M2);
    M2.Seek(0, 0);

    // convert M2 to S2
    SetLength(S2, M2.Size);
    M2.ReadBuffer(PChar(S2)^, M2.Size);

    // add S2 to S
    AppendStr(S, S2);
  end;

  M1.Free;
  M2.Free;

  if S <> '' then CopyToClipboard(S);
  
end;

procedure T_AM2000_MenuDesignerDlg.btnCutClick(Sender: TObject);
begin
  CopySelections;
  ClearSelections;
  CheckConstraints;
end;

procedure T_AM2000_MenuDesignerDlg.btnCopyClick(Sender: TObject);
begin
  CopySelections;
  CheckConstraints;
end;

procedure T_AM2000_MenuDesignerDlg.btnPasteClick(Sender: TObject);
var
  S: String;
  M1, M2: TMemoryStream;
  N, N1: TTreeNode;
  M, MI1: TMenuItem2000;

  procedure InsertChildNodes(Node: TTreeNode; Item: TMenuItem);
  var
    I: Integer;
    N: TTreeNode;
  begin
    for I:= 0 to Item.Count -1 do begin
      N:= MenuTree.Items.AddChild(Node, Item[I].Caption);
      N.Data:= Item[I];
      TreeNodeList.Add(N);
      MenuItemList.Add(N.Data);
      InsertChildNodes(N, Item[I]);
    end;
  end;

begin
  // selection
  N:= MenuTree.Selected;
  if (not Assigned(N))
  or (not Assigned(N.Parent)) then Exit;

  // clear selection
  // updating
  Updating:= True;
  MenuTree.Items.BeginUpdate;
  InvalidateList;
  SelectedList.Clear;

  MI1:= nil;
  M1:= TMemoryStream.Create;
  M2:= TMemoryStream.Create;

  try
    // load component
    S:= PasteFromClipboard;

    // store to stream
    M1.WriteBuffer(PChar(S)^, Length(S));
    M1.Seek(0, 0);

    while M1.Position < M1.Size do begin
      MI1:= TMenuItem2000.Create(Menu.Owner);

      // convert into component
      ObjectTextToBinary(M1, M2);
      M2.Seek(0, 0);

      // readcomponent
      M2.ReadComponent(MI1);

      // insert into menu and tree
      M:= TMenuItem2000(N.Data);

      if (N.GetNextSibling <> nil) then begin
        N1:= MenuTree.Items.Insert(N.GetNextSibling, MI1.Caption);
        M.Parent.Insert(M.MenuIndex +1, MI1);
      end
      else begin
        N1:= MenuTree.Items.Add(N, MI1.Caption);
        M.Parent.Add(MI1);
      end;

      N1.Data:= MI1;
      TreeNodeList.Add(N1);
      MenuItemList.Add(N1.Data);
      InsertChildNodes(N1, MI1);

      // select
      SelectedList.Add(N1);

      // remove reference
      MI1:= nil;
    end;

  except
    M1.Free;
    M2.Free;
    MI1.Free;
    MenuTree.Items.EndUpdate;
    Updating:= False;

    raise;
  end;

  M1.Free;
  M2.Free;
  MenuTree.Items.EndUpdate;
  Updating:= False;
end;

procedure T_AM2000_MenuDesignerDlg.SelectAll2Click(Sender: TObject);
var
  I: Integer;
begin
  Screen.Cursor:= crHourglass;
  SelectedList.Clear;

  with MenuTree.Items
  do begin
    BeginUpdate;

    for I:= 0 to Count -1 do
      SelectedList.Add(Item[I]);

    EndUpdate;
  end;

  UpdateSelections;
  Screen.Cursor:= crDefault;
end;

procedure T_AM2000_MenuDesignerDlg.FormActivate(Sender: TObject);
begin
  CheckConstraints;
end;

procedure T_AM2000_MenuDesignerDlg.Panel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//  Panel1.ShowHint:= True;
end;


{ T_AM2000_TreeView4 }

{$IFNDEF Delphi4OrHigher}

const
{ =============== GENERIC WM_NOTIFY EVENTS FOR TREEVIEWS ==================== }

  NM_CUSTOMDRAW            = NM_FIRST-12;
  NM_HOVER                 = NM_FIRST-13;
  NM_NCHITTEST             = NM_FIRST-14;   // uses NMMOUSE struct
  NM_KEYDOWN               = NM_FIRST-15;   // uses NMKEY struct
  NM_RELEASEDCAPTURE       = NM_FIRST-16;
  NM_SETCURSOR             = NM_FIRST-17;   // uses NMMOUSE struct
  NM_CHAR                  = NM_FIRST-18;   // uses NMCHAR struct

{ ==================== CUSTOM DRAW ========================================== }

const
  // custom draw return flags
  // values under 0x00010000 are reserved for global custom draw values.
  // above that are for specific controls
  CDRF_DODEFAULT          = $00000000;
  CDRF_NEWFONT            = $00000002;
  CDRF_SKIPDEFAULT        = $00000004;

  CDRF_NOTIFYPOSTPAINT    = $00000010;
  CDRF_NOTIFYITEMDRAW     = $00000020;
  CDRF_NOTIFYSUBITEMDRAW  = $00000020;  // flags are the same, we can distinguish by context
  CDRF_NOTIFYPOSTERASE    = $00000040;

  // drawstage flags
  // values under = $00010000 are reserved for global custom draw values.
  // above that are for specific controls
  CDDS_PREPAINT           = $00000001;
  CDDS_POSTPAINT          = $00000002;
  CDDS_PREERASE           = $00000003;
  CDDS_POSTERASE          = $00000004;
  // the = $000010000 bit means it's individual item specific
  CDDS_ITEM               = $00010000;
  CDDS_ITEMPREPAINT       = CDDS_ITEM or CDDS_PREPAINT;
  CDDS_ITEMPOSTPAINT      = CDDS_ITEM or CDDS_POSTPAINT;
  CDDS_ITEMPREERASE       = CDDS_ITEM or CDDS_PREERASE;
  CDDS_ITEMPOSTERASE      = CDDS_ITEM or CDDS_POSTERASE;
  CDDS_SUBITEM            = $00020000;

  // itemState flags
  CDIS_SELECTED       = $0001;
  CDIS_GRAYED         = $0002;
  CDIS_DISABLED       = $0004;
  CDIS_CHECKED        = $0008;
  CDIS_FOCUS          = $0010;
  CDIS_DEFAULT        = $0020;
  CDIS_HOT            = $0040;
  CDIS_MARKED         = $0080;
  CDIS_INDETERMINATE  = $0100;


type
  tagNMCUSTOMDRAWINFO = packed record
    hdr: TNMHdr;
    dwDrawStage: DWORD;
    hdc: HDC;
    rc: TRect;
    dwItemSpec: DWORD;  // this is control specific, but it's how to specify an item.  valid only with CDDS_ITEM bit set
    uItemState: UINT;
    lItemlParam: LPARAM;
  end;
  PNMCustomDraw = ^TNMCustomDraw;
  TNMCustomDraw = tagNMCUSTOMDRAWINFO;

  tagNMTTCUSTOMDRAW = packed record
    nmcd: TNMCustomDraw;
    uDrawFlags: UINT;
  end;
  PNMTTCustomDraw = ^TNMTTCustomDraw;
  TNMTTCustomDraw = tagNMTTCUSTOMDRAW;

  tagNMTVCUSTOMDRAW = packed record
    nmcd: TNMCustomDraw;
    clrText: COLORREF;
    clrTextBk: COLORREF;
    iLevel: Integer;
  end;
  PNMTVCustomDraw = ^TNMTVCustomDraw;
  TNMTVCustomDraw = tagNMTVCUSTOMDRAW;

{$ENDIF}


constructor T_AM2000_TreeView4.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas:= TControlCanvas.Create;
  TControlCanvas(FCanvas).Control:= Self;
  ReadOnly:= True;
end;

destructor T_AM2000_TreeView4.Destroy;
begin
  FCanvas.Free;
  inherited Destroy;
end;

procedure T_AM2000_TreeView4.CreateParams(var Params: TCreateParams);
const
  TVS_NOTOOLTIPS  = $0080;
begin
  inherited;
  with Params do Style:= Style or TVS_NOTOOLTIPS;
end;

function T_AM2000_TreeView4.GetNodeFromItem(const Item: TTVItem): TTreeNode;
begin
  with Item do
    if (state and TVIF_PARAM) <> 0 then Result:= Pointer(lParam)
    else Result:= Items.GetNode(hItem);
end;

procedure T_AM2000_TreeView4.CNNotify(var Message: TWMNotify);
var
  Node: TTreeNode;
  TmpItem: TTVItem;
{$IFDEF Delphi5OrHigher}
  PaintImages: Boolean;
{$ENDIF}
begin
  with Message do
    case NMHdr^.code of
      NM_CUSTOMDRAW:
        with PNMCustomDraw(NMHdr)^ do
        begin
          Result:= CDRF_DODEFAULT;
          if dwDrawStage = CDDS_PREPAINT then
          begin
            Result:= Result or CDRF_NOTIFYITEMDRAW
          end
          else if dwDrawStage = CDDS_ITEMPREPAINT then
          begin
            FillChar(TmpItem, SizeOf(TmpItem), 0);
            TmpItem.hItem:= HTREEITEM(dwItemSpec);
            Node:= GetNodeFromItem(TmpItem);
            if Node <> nil then
            begin
              FCanvas.Handle:= hdc;
              FCanvas.Font:= Font;
              FCanvas.Brush:= Brush;
              FCanvas.Font.OnChange:= CanvasChanged;
              FCanvas.Brush.OnChange:= CanvasChanged;
              CustomDrawItem(Node,
                TCustomDrawState(Word(uItemState)), cdPrePaint
{$IFDEF Delphi5OrHigher}
,               PaintImages
{$ENDIF}
                );
              Result:= Result or CDRF_SKIPDEFAULT;
              FCanvas.Handle:= 0;
              if IsCustomDrawn(dtItem, cdPostPaint) then
                Result:= Result or CDRF_NOTIFYPOSTPAINT;
            end;
          end;
        end;
      else
        inherited;
    end;
end;

procedure T_AM2000_TreeView4.CanvasChanged;
begin
  FCanvasChanged:= True;
end;

function T_AM2000_TreeView4.IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean;
begin
  if Stage = cdPrePaint
  then
    if Target = dtItem
    then Result:= Assigned(FOnCustomDrawItem)
    else Result:= False

  else
    Result:= False;
end;

function T_AM2000_TreeView4.CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage
{$IFDEF Delphi5OrHigher}
;  var PaintImages: Boolean
{$ENDIF}
  ): Boolean;
begin
  Result:= True;
  if Assigned(FOnCustomDrawItem) then FOnCustomDrawItem(Self, Node, State, Result);
{$IFDEF Delphi5OrHigher}
  PaintImages:= False;
{$ENDIF}
end;


procedure T_AM2000_MenuDesignerDlg.ShortCuts1Click(Sender: TObject);
{$IFDEF Delphi3OrHigher}
var
  ShortCutEditor: T_AM2000_ShortCutEditor;
  S: String;
  mi: TMenuItem2000;
{$ENDIF}
begin
{$IFDEF Delphi3OrHigher}
  if (MenuTree.Selected = nil)
  and (SelectedList.Count = 0)
  then Exit;

  if (MenuTree.Selected <> nil)
  then mi:= TMenuItem2000(MenuTree.Selected.Data)
  else mi:= TMenuItem2000(SelectedList[0]);

  ShortCutEditor:= T_AM2000_ShortCutEditor.Create(Self);

  S:= mi.ShortCut;
  if ShortCutEditor.EditShortCuts(S) then begin
    mi.ShortCut:= S;
    SelectComponent(mi, True);
  end;

  ShortCutEditor.Free;
{$ENDIF}
end;

procedure T_AM2000_MenuDesignerDlg.Hidden1Click(Sender: TObject);
var
  MB: TWinControl;
begin
  if MenuTree.Selected <> nil then
    with TMenuItem2000(MenuTree.Selected.Data) do begin
      MB:= GetMenuBar;
      if (MB <> nil)
      and (TCustomMenuBar2000(MB).Menu = Menu)
      then MessageDlg(SHiddenDoesntAffectToplevel, mtError, [mbOk], 0)
      else Hidden:= not Hidden;
    end;
end;

procedure T_AM2000_MenuDesignerDlg.btnFontClick(Sender: TObject);
begin
  FontDialog1.Font.Assign(MenuTree.Font);
  if FontDialog1.Execute
  then Font.Assign(FontDialog1.Font);
end;

procedure T_AM2000_MenuDesignerDlg.FontDialog1Apply(Sender: TObject;
{$IFDEF Delphi4OrHigher}
  Wnd: HWND);
{$ELSE}
  Wnd: Integer);
{$ENDIF}
begin
  Font.Assign(FontDialog1.Font);
end;

procedure T_AM2000_MenuDesignerDlg.wmClose(var Msg: TMessage);
begin
  Menu:= nil;
  inherited;
end;

procedure T_AM2000_MenuDesignerDlg.btnMenuClick(Sender: TObject);
begin
end;


{ T_AM2000_Panel }

procedure T_AM2000_Panel.Paint;
var
  R: TRect;
begin
  inherited;

  R:= GetClientRect;
  R.Left:= R.Right - GetSystemMetrics(sm_CxHScroll);
  R.Top:= R.Bottom - GetSystemMetrics(sm_CyVScroll);
  DrawFrameControl(Canvas.Handle, R, dfc_Scroll, dfcs_ScrollSizeGrip);
end;

procedure T_AM2000_MenuDesignerDlg.wmGetPopupMenu(var Msg: TMessage);
begin
end;

procedure T_AM2000_MenuDesignerDlg.ShowMethod(const MI: TMenuItem);
begin
  if (FormDesigner <> nil)
  then FormDesigner.ShowMethod(MI, 'Click');
end;

procedure T_AM2000_MenuDesignerDlg.wmRefreshMenu(var Msg: TMessage);
begin
  MenuTree.Items.BeginUpdate;
  Edit1.Visible:= False;
  SetMenu(FMenu);
  SelectMenuItem(TMenuItem2000(Msg.LParam));
  MenuTree.Items.EndUpdate;
end;

procedure T_AM2000_MenuDesignerDlg.Edit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  N, N1: TTreeNode;

  procedure SetMenuItemCaption(const M: TMenuItem; const S: String);
  var
    S1, S2: String;
    M1: TMenuItem;
  begin
    M.Caption:= S;
    M1:= M;

    if S = '-' then
      S1:= 'N'
    else begin
      S1:= S;

      while (M1.Parent <> nil)
      do begin
        M1:= M1.Parent;
        S1:= M1.Caption + S1;
      end;
    end;

    if Designer <> nil
    then begin
      // set menu item name
      S1:= GetValidName(S1);
      if S1 = '' then S1:= 'N';

      S2:= Designer.UniqueName(S1);
      if (S1[1] = 'T') and (S2[1] <> 'T')
      then S2:= 'T' + S2;

      M.Name:= S2;
    end;

    if Preview <> nil
    then Preview.Refresh;
  end;

begin
  case Key of
    vk_Return:
      if (MenuTree.Selected <> nil)
      then begin
        if ssCtrl in Shift
        then
          ShowMethod(TMenuItem2000(MenuTree.Selected.Data))

        else
        if (MenuTree.Selected.Text <> Edit1.Text)
        then begin
          MenuTree.Selected.Text:= Edit1.Text;
          SetMenuItemCaption(TMenuItem2000(MenuTree.Selected.Data), Edit1.Text);
          Edit1.SelectAll;
        end;

        Key:= 0;
      end;

    vk_Escape:
      begin
        if MenuTree.Selected <> nil
        then begin
          Edit1.Text:= MenuTree.Selected.Text;
          Edit1.SelectAll;
        end;

        Key:= 0;
      end;

    vk_Up:
      begin
        N:= MenuTree.Selected;
        if N = nil then Exit;

        if (MenuTree.Selected.Text <> Edit1.Text)
        then begin
          N.Text:= Edit1.Text;
          SetMenuItemCaption(TMenuItem2000(N.Data), Edit1.Text);
        end;

        SelectedList.Clear;

        N:= N.GetPrevVisible;

        if (N <> nil)
        and (N.Parent <> nil)
        then begin
          SelectedList.Add(N);
          MenuTree.Selected:= N;

          CheckConstraints;

          DisplayEdit(N);
        end;

        Key:= 0;
      end;

    vk_Down:
      begin
        N:= MenuTree.Selected;
        if N = nil then Exit;

        if (MenuTree.Selected.Text <> Edit1.Text)
        then begin
          N.Text:= Edit1.Text;
          SetMenuItemCaption(TMenuItem2000(N.Data), Edit1.Text);
        end;

        SelectedList.Clear;

        N:= N.GetNextVisible;
        if (N <> nil)
        and (N.Parent <> nil)
        then begin
          SelectedList.Add(N);
          MenuTree.Selected:= N;

          CheckConstraints;

          DisplayEdit(N);
        end;

        Key:= 0;
      end;

    vk_Home:
      if ssCtrl in Shift
      then begin
        N:= MenuTree.Selected;
        if N = nil then Exit;

        if (MenuTree.Selected.Text <> Edit1.Text)
        then begin
          N.Text:= Edit1.Text;
          SetMenuItemCaption(TMenuItem2000(N.Data), Edit1.Text);
        end;

        SelectedList.Clear;

        N1:= N.GetPrevVisible;
        while (N1 <> nil)
        and (N1.Parent <> nil)
        do begin
          N:= N1;
          N1:= N.GetPrevVisible;
        end;

        if N <> nil
        then begin
          SelectedList.Add(N);
          MenuTree.Selected:= N;

          CheckConstraints;

          DisplayEdit(N);
        end;
        Key:= 0;
      end;

    vk_End:
      if ssCtrl in Shift
      then begin
        N:= MenuTree.Selected;
        if N = nil then Exit;

        if (MenuTree.Selected.Text <> Edit1.Text)
        then begin
          N.Text:= Edit1.Text;
          SetMenuItemCaption(TMenuItem2000(N.Data), Edit1.Text);
        end;

        SelectedList.Clear;

        N1:= N.GetNextVisible;
        while N1 <> nil
        do begin
          N:= N1;
          N1:= N.GetNextVisible;
        end;

        if N <> nil
        then begin
          SelectedList.Add(N);
          MenuTree.Selected:= N;

          CheckConstraints;

          DisplayEdit(N);
        end;

        Key:= 0;
      end;
  end;

  if Key = 0
  then UpdateSelections;
end;

procedure T_AM2000_MenuDesignerDlg.DisplayEdit(const Node: TTreeNode);
var
  R: TRect;
begin
  if (Node = nil)
  or (Node.Parent = nil)
  or (SelectedList.Count <> 1)
  or (Copy(Node.Text, 1, 4) = '::::')
  then begin
    Edit1.Visible:= False;
    Exit;
  end;
  
  R:= Node.DisplayRect(True);
  Edit1.Left:= R.Left + MenuTree.Left +2;
  Edit1.Top:= R.Top + Panel2.BorderWidth +3;
  Edit1.Width:= MenuTree.Width - R.Left - 10;
  Edit1.Text:= Node.Text;
  Edit1.Visible:= True;
  Edit1.SetFocus;
  Edit1.SelectAll;
  Windows.SetFocus(Edit1.Handle);

  ActiveMenuItem:= Node.Data;

  if Preview <> nil
  then Preview.SetMenuItem(TMenuItem2000(Node.Data));
end;

procedure T_AM2000_MenuDesignerDlg.Edit1DblClick(Sender: TObject);
begin
  if (MenuTree.Selected <> nil)
  and (TObject(MenuTree.Selected.Data) is TMenuItem2000)
  then ShowMethod(TMenuItem2000(MenuTree.Selected.Data));
end;

procedure T_AM2000_MenuDesignerDlg.SelectComponent(const AComponent: TComponent; Modified: Boolean);
begin
  if Designer = nil then Exit;

  Designer.SelectComponent(AComponent);
  
  if AComponent is TMenuItem2000
  then ActiveMenuItem:= TMenuItem2000(AComponent);

  if Modified
  then Designer.Modified;
end;




{ T_AM2000_Preview }

constructor T_AM2000_Preview.Create(AOwner: TComponent);
begin
  inherited Create;

  Owner:= AOwner;
end;

destructor T_AM2000_Preview.Destroy;
begin
  MainMenuForm.Free;
  PopupMenuForm.Free;
  inherited;
end;

procedure T_AM2000_Preview.SetMenu(AMenu: TMenu);
begin
  FMenu:= AMenu;

  // hide popup menu form
  PopupMenuForm.Free;
  PopupMenuForm:= nil;

  if AMenu is TPopupMenu
  then begin
    // hide main menu form
    if MainMenuForm <> nil
    then MainMenuForm.Hide;

    if MenuBar <> nil
    then MenuBar.Menu:= nil;

    // create popup menu form
    PopupMenuForm:= CreateFloatingMenuForm(Owner, AMenu.Items,
      TCustomPopupMenu2000(AMenu).Options, TCustomPopupMenu2000(AMenu), Left, Top);
    PopupMenuForm.Perform(wm_SetState, ssPreview, 1);
    PopupMenuForm.OnClose:= PopupMenuFormClose;
    PopupMenuForm.Show;
  end
  else begin
    // create main menu form
    if MainMenuForm = nil
    then begin
      MainMenuForm:= TForm.CreateNew(Owner);
      MainMenuForm.Caption:= AMenu.Name;
      MainMenuForm.BorderStyle:= bsSizeToolWin;
      MainMenuForm.FormStyle:= fsStayOnTop;
      MainMenuForm.OnHide:= MainMenuFormHide;

      MenuBar:= TMenuBar2000.Create(MainMenuForm);
      MenuBar.Name:= SPreviewMenuBar;
      MenuBar.Perform(wm_SetState, ssPreview, 1);
      ActiveMenuBarList.Remove(MenuBar);

      MainMenuForm.InsertControl(MenuBar);
    end;

    MainMenuForm.Left:= Left;
    MainMenuForm.Top:= Top;
    MenuBar.Menu:= AMenu;

    with MenuBar.GetMenuRect
    do begin
      MainMenuForm.ClientWidth:= Cx;
      MainMenuForm.ClientHeight:= Cy +1;
    end;

    MainMenuForm.Show;
  end;
end;

procedure T_AM2000_Preview.SetMenuItem(AItem: TMenuItem2000);
var
  M: TMenu;
begin
  M:= AItem.GetMenu;
  if M <> FMenu
  then begin
    SetMenu(M);
    
    if PopupMenuForm <> nil
    then PopupMenuForm.Caption:= M.Name
    else 
    if MainMenuForm <> nil
    then MainMenuForm.Caption:= M.Name;
  end;

  if PopupMenuForm <> nil
  then  // popup menu
    PopupMenuForm.Perform(wm_SetMenuItem, LongInt(AItem), 0)
  else
  if MenuBar <> nil
  then // main menu
    MenuBar.SetMenuItem(AItem);
end;

procedure T_AM2000_Preview.MainMenuFormHide(Sender: TObject);
begin
  if MenuBar <> nil
  then MenuBar.MenuComponent.Form.Perform(wm_HideSilent, 0, 0);
end;

procedure T_AM2000_Preview.Hide;
begin
  if MainMenuForm <> nil
  then MainMenuForm.Hide;

  if MenuBar <> nil
  then MenuBar.MenuComponent.Form.Perform(wm_HideSilent, 0, 0);

  if PopupMenuForm <> nil
  then PopupMenuForm.Perform(wm_HideSilent, 0, 0);
end;

procedure T_AM2000_Preview.Refresh;
var
  MI: TMenuItem;
  I: Integer;
begin
  if (MenuBar <> nil)
  and (MenuBar.Menu <> nil)
  then begin
    MenuBar.Refresh;

    with MenuBar.GetMenuRect
    do begin
      MainMenuForm.ClientWidth:= Cx;
      MainMenuForm.ClientHeight:= Cy +1;
    end;

    if MenuBar.MenuComponent.FormOnScreen
    then begin
      MI:= Self.MenuBar.MenuComponent.MenuItems;

      with TCustomMainMenu2000(MenuBar.Menu)
      do
        for I:= 0 to MergedMenuItemsCount -1
        do
          if MergedMenuItems[I] = MI
          then begin
            Self.MenuBar.MenuComponent.Refresh;
            Exit;
          end;

      Self.MenuBar.MenuComponent.Form.Perform(wm_SilentHide, 0, 0);
    end;
  end

  else
  if (PopupMenuForm <> nil)
  then PopupMenuForm.Update;
end;

procedure T_AM2000_Preview.KillSubForms;
begin
  if (MenuBar <> nil)
  and (MenuBar.MenuComponent <> nil)
  then
    MenuBar.MenuComponent.Form.Perform(wm_SilentHide, 1, 0)

  else
  if (PopupMenuForm <> nil)
  then PopupMenuForm.Perform(wm_SilentHide, 1, 0);
end;

procedure T_AM2000_Preview.PopupMenuFormClose(Sender: TObject; var Action: TCloseAction);
begin
  PopupMenuForm:= nil;
  Action:= caFree;
end;



{ T_AM2000_AnimatedSkinEditor }

constructor T_AM2000_AnimatedSkinEditor.Create(AComponent: TComponent;
{$IFDEF Delphi6OrHigher}
      ADesigner: IDesigner
{$ELSE}
{$IFDEF Delphi4OrHigher}
      ADesigner: IFormDesigner
{$ELSE}
      ADesigner: TFormDesigner
{$ENDIF}
{$ENDIF}
  );
begin
  inherited;
end;

destructor T_AM2000_AnimatedSkinEditor.Destroy;
begin
  inherited;
end;

procedure T_AM2000_AnimatedSkinEditor.Edit;
begin
  Application.MessageBox('You can edit skin from Object Inpector.'#13#13 +
    'Also we recommend to visit our website at http://www.animatedmenus.com/downloads/utilities.asp ' +
    'and download Animated Menus Skin Designer to edit skins.', 'AnimatedSkin', mb_IconInformation);
end;

function T_AM2000_AnimatedSkinEditor.GetVerbCount: Integer;
begin
{$IFDEF Delphi7OrHigher}
  Result:= inherited GetVerbCount +3;
{$ELSE}
  Result:= inherited GetVerbCount +4;
{$ENDIF}
end;

function T_AM2000_AnimatedSkinEditor.GetVerb(Index: Integer): String;
begin
  case Index of
    0: Result:= '&Load AnimatedSkin™ From File...';
    1: Result:= '&Save AnimatedSkin™ To File...';
    2: Result:= '&Reset Skin';
{$IFDEF Delphi7OrHigher}
    else Result:= inherited GetVerb(Index -3);
{$ELSE}
    3: Result:= '-';
    else Result:= inherited GetVerb(Index -4);
{$ENDIF}
  end;
end;

procedure T_AM2000_AnimatedSkinEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: // open
      if ExecuteOpenAnimatedSkinDialog
      then begin
        TCustomAnimatedSkin2000(Component).LoadFromFile(FSkinFilename, FSkinFormat);
        Designer.Modified;
      end;

    1: // save
      if ExecuteSaveAnimatedSkinDialog
      then TCustomAnimatedSkin2000(Component).SaveToFile(FSkinFilename, FSkinFormat);

    2: // reset
      TCustomAnimatedSkin2000(Component).Reset;

    else
{$IFDEF Delphi7OrHigher}
      inherited ExecuteVerb(Index -2);
{$ELSE}
      inherited ExecuteVerb(Index -3);
{$ENDIF}
  end;
end;


procedure T_AM2000_MenuDesignerDlg.MenuTreeEnter(Sender: TObject);
begin
  if Edit1.Visible
  then begin
    Edit1.SetFocus;
    Windows.SetFocus(Edit1.Handle);
    ShowCaret(Edit1.Handle);
  end;
end;

procedure T_AM2000_MenuDesignerDlg.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Edit1.Visible
  then begin
    Edit1.SetFocus;
    Windows.SetFocus(Edit1.Handle);
    ShowCaret(Edit1.Handle);
  end;

  inherited;
end;

procedure T_AM2000_MenuDesignerDlg.MenuItem9Click(Sender: TObject);
begin
  Close;
end;

procedure T_AM2000_MenuDesignerDlg.FileNewMainMenu1Click(Sender: TObject);
var
  M: TMainMenu2000;
  S: String;
begin
  if (Designer = nil)
  then begin
    Application.MessageBox(SDesignerNotFound, 'Error', mb_IconError);
    Exit;
  end;

  M:= nil; 
  S:= Designer.UniqueName(SDefaultMainMenuName);
  if not InputQuery(SNewMainMenuCaption, SNewMainMenuPrompt, S)
  then Exit;
  
  try
    M:= TMainMenu2000.Create(Menu.Owner);
    M.Name:= S;
    SetMenu(M);

    SelectComponent(M, True);

  except
    if M <> nil
    then M.Free;
  end;
end;

procedure T_AM2000_MenuDesignerDlg.FileNewPopupMenu1Click(Sender: TObject);
var
  M: TPopupMenu2000;
  S: String;
begin
  if (Designer = nil)
  then Exit;

  M:= nil;
  S:= Designer.UniqueName(SDefaultPopupMenuName);
  if not InputQuery(SNewPopupMenuCaption, SNewPopupMenuPrompt, S)
  then Exit;

  try
    M:= TPopupMenu2000.Create(Menu.Owner);
    M.Name:= S;
    SetMenu(M);

    SelectComponent(M, True);

  except
    if M <> nil
    then M.Free;
  end;
end;

procedure T_AM2000_MenuDesignerDlg.wmKillMenuBar(var Msg: TMessage);
var
  I: Integer;
begin
  for I:= 0 to ControlCount -1
  do
    if Controls[I] is TCustomMenuBar2000
    then TCustomMenuBar2000(Controls[I]).HideActiveItem;
end;



{ T_AM2000_VersionProperty }

function T_AM2000_VersionProperty.AllEqual: Boolean;
begin
  Result:= True;
end;

procedure T_AM2000_VersionProperty.Edit;
begin
  if MessageBox(Application.Handle, 'Would you like to visit Animated Menus homepage and check for the newest version?', 'Animated Menus',
    mb_IconInformation + mb_YesNo) = idYes
  then ShellExecute(0, 'open', 'http://www.animatedmenus.com/', nil, nil, sw_ShowNormal);
end;

function T_AM2000_VersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paReadOnly, paDialog];
end;

function T_AM2000_VersionProperty.GetValue: string;
begin
  Result:= SVersion;
end;



{ TDesigner }

destructor TDesigner.Destroy;
begin
  Designer:= nil;
  inherited;
end;

function TDesigner.InitializeDesigner: Boolean;
{$IFDEF Delphi4OrHigher}
{$IFNDEF CBuilder4}
var
  FormEditor: IOTAFormEditor;
  Module: IOTAModule;
  Editor: IOTAEditor;
  I: Integer;
{$ENDIF}
{$ENDIF}
begin
{$IFDEF Delphi4OrHigher}
{$IFNDEF CBuilder4}
  Module:= (BorlandIDEServices as IOTAModuleServices).CurrentModule;
  if Module <> nil
  then begin
    for i := 0 to Module.GetModuleFileCount - 1
    do begin
      Editor:= Module.GetModuleFileEditor(i);
      Editor.QueryInterface(IOTAFormEditor, FormEditor);
      if FormEditor <> nil
      then Break;
    end;
  end;

  if FormEditor <> nil
  then begin
    Designer:= (FormEditor as INTAFormEditor).GetFormDesigner;
    Designer._AddRef;
  end;

  Result:= Designer <> nil;
  Module:= nil;
  Editor:= nil;
  FormEditor:= nil;
{$ENDIF}
{$ENDIF}  
end;

procedure TDesigner.SelectComponent(const AComponent: TComponent);
begin
  if not InitializeDesigner
  then Exit;

  Designer.SelectComponent(AComponent);

  if (AComponent is TMenuItem2000)
  and (MenuDesignerDlg <> nil)
  then MenuDesignerDlg.SelectMenuItem(TMenuItem2000(AComponent));

  Designer:= nil;
end;

procedure TDesigner.ShowMethod(const AComponent: TComponent; const EventName: String);
var
  PropInfo: PPropInfo;
  TypeData: PTypeData;
  Method: TMethod;
  MethodName: String;
begin
  if not InitializeDesigner
  then Exit;

  MethodName:= AComponent.Name + EventName;

  // create method
  PropInfo:= GetPropInfo(AComponent.ClassInfo, 'On' + EventName);
  TypeData:= GetTypeData(PropInfo.PropType^);
  Method:= Designer.CreateMethod(MethodName, TypeData);
  SetMethodProp(AComponent, PropInfo, Method);
  Designer.Modified;

  // show it
  Designer.ShowMethod(MethodName);
  Designer:= nil;
end;

procedure TDesigner.Modified;
var
  PropInfo: PPropInfo;
  TypeData: PTypeData;
  Method: TMethod;
  MethodName: String;
begin
  if not InitializeDesigner
  then Exit;

  Designer.Modified;
  Designer:= nil;
end;


initialization
  EnableCustomization:= True;

  FormDesigner:= TDesigner.Create;

finalization
  FormDesigner.Free;
  FormDesigner:= nil;
  
end.
