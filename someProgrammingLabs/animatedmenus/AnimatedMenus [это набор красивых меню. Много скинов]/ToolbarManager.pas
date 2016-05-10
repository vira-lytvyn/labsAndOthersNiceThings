
{*******************************************************}
{                                                       }
{       Toolbar Manager                                 }
{       Version 1.0                                     }
{                                                       }
{       Copyright (c) 2000 AnimatedMenus.com            }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit ToolbarManager;

interface

uses
  Windows, Classes, Graphics, Menus, Dialogs;

type
  TCustomToolbar = class;

  // This class represent a toolbar button
  TCustomToolbarButtons = class(TPersistent)
  private
    FBitmap: TBitmap;
    FToolbar: TCustomToolbar;
    FButtonIndex: Integer;
    FRealIndexes: TList;

    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);

    function GetCaption: String;
    procedure SetCaption(const Value: String);

    function GetShortCut: String;
    procedure SetShortCut(const Value: String);

    function GetBitmap: TBitmap;
    procedure SetBitmap(const Value: TBitmap);

    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;

    procedure CreateRealIndexes;

  public
    constructor Create;
    destructor Destroy; override;

    property Visible: Boolean
      read GetVisible write SetVisible;
    property Caption: String
      read GetCaption write SetCaption;
    property ShortCut: String
      read GetShortCut write SetShortCut;
    property Bitmap: TBitmap
      read GetBitmap write SetBitmap;
    property Width: Integer
      read GetWidth;
    property Height: Integer
      read GetHeight;
    property Left: Integer
      read GetLeft;
    property Top: Integer
      read GetTop;

    function IsSeparator: Boolean;

  end;

  // This class represent a toolbar template
  TCustomToolbar = class(TPersistent)
  private
    FButtons: TCustomToolbarButtons;
    
    function GetButtons(Index: Integer): TCustomToolbarButtons;

  protected
    FToolbar: TComponent;

    function GetVisible: Boolean; virtual; abstract;
    procedure SetVisible(const Value: Boolean); virtual; abstract;

    function GetCaption: String; virtual; abstract;
    procedure SetCaption(const Value: String); virtual; abstract;

    function GetHint: String; virtual; abstract;

    function GetPopupMenu: TPopupMenu; virtual; abstract;
    procedure SetPopupMenu(const Value: TPopupMenu); virtual; abstract;

    // buttons
    function GetButtonBitmap(Index: Integer; Bitmap: TBitmap): TBitmap; virtual; abstract;
    function GetButtonCaption(Index: Integer): String; virtual; abstract;
    function GetButtonCount: Integer; virtual; abstract;
    function GetButtonHeight(Index: Integer): Integer; virtual; abstract;
    function GetButtonLeft(Index: Integer): Integer; virtual; abstract;
    function GetButtonSeparator(Index: Integer): Boolean; virtual; abstract;
    function GetButtonShortCut(Index: Integer): String; virtual; abstract;
    function GetButtonTop(Index: Integer): Integer; virtual; abstract;
    function GetButtonVisible(Index: Integer): Boolean; virtual; abstract;
    function GetButtonWidth(Index: Integer): Integer; virtual; abstract;

    procedure SetButtonVisible(Index: Integer; const Value: Boolean); virtual; abstract;
    procedure SetButtonCaption(Index: Integer; const Value: String); virtual; abstract;
    procedure SetButtonShortCut(Index: Integer; const Value: String); virtual; abstract;
    procedure SetButtonBitmap(Index: Integer; Bitmap: TBitmap); virtual; abstract;

  public
    property Visible: Boolean
      read GetVisible write SetVisible;
    property Caption: String
      read GetCaption write SetCaption;
    property Hint: String
      read GetHint;
    property PopupMenu: TPopupMenu
      read GetPopupMenu write SetPopupMenu;
    property ButtonCount: Integer
      read GetButtonCount;
    property Toolbar: TComponent
      read FToolbar;
                        
    property Buttons[Index: Integer]: TCustomToolbarButtons
      read GetButtons;

    constructor Create(AComponent: TComponent); virtual;
    destructor Destroy; override;

  end;

  // This class represent a toolbar manager
  TCustomToolbarManager = class(TComponent)
  private
    FToolbars: TList;

    function GetToolbar(Index: Integer): TCustomToolbar;
    function GetToolbarCount: Integer;

    procedure RebuildToolbarList;

  protected
//    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;

    function CreateToolbar(AToolbar: TComponent): TCustomToolbar; virtual; abstract;

  public
    property Toolbars[Index: Integer]: TCustomToolbar read GetToolbar; default;
    property ToolbarCount: Integer read GetToolbarCount;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsToolbar(AComponent: TComponent): Boolean; virtual; abstract;
    function IndexOf(AComponent: TComponent): Integer;

    procedure RemoveToolbar(AToolbar: TCustomToolbar); virtual;
    function AddToolbar(Name: String): TCustomToolbar; virtual;
    
  end;

function FindToolbarManager(AOwner: TComponent): TCustomToolbarManager;
procedure ClearBitmap(Bitmap: TBitmap);

const
  SNoDescriptionAvailable = '(No description available)';

implementation

uses
  SysUtils, Consts;

function FindToolbarManager(AOwner: TComponent): TCustomToolbarManager;
  // returns the current toolbar manager
begin
  Result:= nil;
end;

procedure ClearBitmap(Bitmap: TBitmap);
var
  h: HBitmap;
begin
  h:= Bitmap.Handle;
  Bitmap.ReleaseHandle;
  DeleteObject(h);
  Bitmap.Width:= 0;
  Bitmap.Height:= 0;
end;


{ TCustomToolbarButtons }

constructor TCustomToolbarButtons.Create;
begin
  inherited;
  FBitmap:= TBitmap.Create;
  FRealIndexes:= TList.Create;
end;

destructor TCustomToolbarButtons.Destroy;
begin
  FBitmap.Free;
  FRealIndexes.Free;
  inherited;
end;

procedure TCustomToolbarButtons.CreateRealIndexes;
var
  I: Integer;
  L: TList;

  function Compare(const Index1, Index2: Integer): Integer;
    // -1: Index1 < Index2
    // 0: Index1 = Index2
    // 1: Index1 > Index2
  var
    I1, I2: Integer;
  begin
    I1:= Integer(L[Index1]);
    I2:= Integer(L[Index2]);

    if (LongRec(I1).Hi < LongRec(I2).Hi)
    then
      Result:= -1

    else
    if (LongRec(I1).Hi > LongRec(I2).Hi)
    then
      Result:= 1

    else
    if (LongRec(I1).Lo < LongRec(I2).Lo)
    then
      Result:= -1

    else
    if (LongRec(I1).Lo > LongRec(I2).Lo)
    then
      Result:= 1

    else
      Result:= 0;
  end;

  procedure Swap(const Index1, Index2: Integer);
  var
    P1, P2: Pointer;
  begin
    P1:= L[Index1];
    P2:= FRealIndexes[Index1];
    L[Index1]:= L[Index2];
    FRealIndexes[Index1]:= FRealIndexes[Index2];
    L[Index2]:= P1;
    FRealIndexes[Index2]:= P2;
  end;


begin
  // this list will contain origins of the buttons
  // LongRec(L[I]).Lo = X, LongRec(L[I])..Hi = Y
  L:= TList.Create;

  for I:= 0 to FToolbar.ButtonCount -1 do
    begin
      FRealIndexes.Add(Pointer(I));
      L.Add(Pointer(MakeLong(FToolbar.GetButtonLeft(I), FToolbar.GetButtonTop(I))));
    end;

  // sorting
  I:= 0;
  while I < FToolbar.ButtonCount -1
  do
    if Compare(I, I+1) > 0
    then begin
      Swap(I, I+1);
      if I > 0 then I:= I -1;
    end
    else
      Inc(I);

  L.Free;
end;

function TCustomToolbarButtons.GetBitmap: TBitmap;
begin
  FToolbar.GetButtonBitmap(Integer(FRealIndexes[FButtonIndex]), FBitmap);
  Result:= FBitmap;
end;

function TCustomToolbarButtons.GetCaption: String;
begin
  Result:= FToolbar.GetButtonCaption(Integer(FRealIndexes[FButtonIndex]));
end;

function TCustomToolbarButtons.GetHeight: Integer;
begin
  Result:= FToolbar.GetButtonHeight(Integer(FRealIndexes[FButtonIndex]));
end;

function TCustomToolbarButtons.GetLeft: Integer;
begin
  Result:= FToolbar.GetButtonLeft(Integer(FRealIndexes[FButtonIndex]));
end;

function TCustomToolbarButtons.GetShortCut: String;
begin
  Result:= FToolbar.GetButtonShortCut(Integer(FRealIndexes[FButtonIndex]));
end;

function TCustomToolbarButtons.GetTop: Integer;
begin
  Result:= FToolbar.GetButtonTop(Integer(FRealIndexes[FButtonIndex]));
end;

function TCustomToolbarButtons.GetVisible: Boolean;
begin
  Result:= FToolbar.GetButtonVisible(Integer(FRealIndexes[FButtonIndex]));
end;

function TCustomToolbarButtons.GetWidth: Integer;
begin
  Result:= FToolbar.GetButtonWidth(Integer(FRealIndexes[FButtonIndex]));
end;

function TCustomToolbarButtons.IsSeparator: Boolean;
begin
  Result:= FToolbar.GetButtonSeparator(Integer(FRealIndexes[FButtonIndex]));
end;

procedure TCustomToolbarButtons.SetBitmap(const Value: TBitmap);
begin
  FToolbar.SetButtonBitmap(Integer(FRealIndexes[FButtonIndex]), Value);
end;

procedure TCustomToolbarButtons.SetCaption(const Value: String);
begin
  FToolbar.SetButtonCaption(Integer(FRealIndexes[FButtonIndex]), Value);
end;

procedure TCustomToolbarButtons.SetShortCut(const Value: String);
begin
  FToolbar.SetButtonShortCut(Integer(FRealIndexes[FButtonIndex]), Value);
end;

procedure TCustomToolbarButtons.SetVisible(const Value: Boolean);
begin
  FToolbar.SetButtonVisible(Integer(FRealIndexes[FButtonIndex]), Value);
end;


{ TCustomToolbar }

constructor TCustomToolbar.Create(AComponent: TComponent);
begin
  inherited Create;
  FToolbar:= AComponent;
  FButtons:= TCustomToolbarButtons.Create;
  FButtons.FToolbar:= Self;
end;


destructor TCustomToolbar.Destroy;
begin
  FButtons.Free;
  inherited;
end;

function TCustomToolbar.GetButtons(Index: Integer): TCustomToolbarButtons;
begin
  FButtons.FButtonIndex:= Index;
  if FButtons.FRealIndexes.Count = 0
  then FButtons.CreateRealIndexes;
  Result:= FButtons;
end;


{ TCustomToolbarManager }

constructor TCustomToolbarManager.Create(AOwner: TComponent);
begin
  inherited;

  if not (csDesigning in ComponentState)
  then FToolbars:= TList.Create;
end;

destructor TCustomToolbarManager.Destroy;
var
  I: Integer;
begin
  if FToolbars <> nil
  then begin
    // destroy toolbars
    for I:= 0 to FToolbars.Count -1
    do TCustomToolbar(FToolbars[I]).Free;

    FToolbars.Free;
    FToolbars:= nil;
  end;

  inherited;
end;

function TCustomToolbarManager.GetToolbar(Index: Integer): TCustomToolbar;
begin
  Result:= nil;
  if FToolbars = nil then Exit;

  if Index < FToolbars.Count
  then Result:= TCustomToolbar(FToolbars[Index]);
end;

function TCustomToolbarManager.GetToolbarCount: Integer;
begin
  if FToolbars <> nil
  then Result:= FToolbars.Count
  else Result:= 0;
end;

procedure TCustomToolbarManager.Loaded;
begin
  inherited;
  RebuildToolbarList;
end;

//procedure TCustomToolbarManager.Notification(AComponent: TComponent;
//  Operation: TOperation);
//begin
//  inherited;

  // rebuild Toolbar list
//  if not ((csLoading in ComponentState)
//  or (csDestroying in ComponentState))
//  and IsToolbar(AComponent)
//  then RebuildToolbarList;
//end;

procedure TCustomToolbarManager.RebuildToolbarList;
var
  I: Integer;
begin
  if FToolbars = nil then Exit;

  // destroy toolbars
  for I:= 0 to FToolbars.Count -1
  do TCustomToolbar(FToolbars[I]).Free;

  FToolbars.Clear;
  
  // exit if owner is not a TWinControl
  if Owner = nil then Exit;

  // scan the owner for toolbars
  with Owner do
    for I:= 0 to ComponentCount -1 do
      if IsToolbar(Components[I])
      then FToolbars.Add(CreateToolbar(Components[I]));
end;

function TCustomToolbarManager.IndexOf(AComponent: TComponent): Integer;
var
  I: Integer;
begin
  Result:= -1;
  if FToolbars = nil then Exit;

  for I:= 0 to FToolbars.Count -1 do
    if TCustomToolbar(FToolbars[I]).FToolbar = AComponent
    then begin
      Result:= I;
      Exit;
    end;
end;

function TCustomToolbarManager.AddToolbar(Name: String): TCustomToolbar;
begin
  Result:= CreateToolbar(nil);
  Result.Caption:= Name;
  FToolbars.Add(Result);
end;

procedure TCustomToolbarManager.RemoveToolbar(AToolbar: TCustomToolbar);
begin
  FToolbars.Remove(AToolbar);
  AToolbar.Toolbar.Free;
  AToolbar.Free;
end;

end.

