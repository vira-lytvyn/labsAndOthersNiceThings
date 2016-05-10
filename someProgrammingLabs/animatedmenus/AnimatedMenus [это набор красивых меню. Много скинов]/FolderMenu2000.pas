
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TFolderMenu2000 Component                       }
{                                                       }
{       Copyright © 1997-2001 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/tfoldermenu2000/
//

unit FolderMenu2000;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShellApi, am2000, am2000menuitem;

type
  TFileClickEvent = procedure(const Filename: String; var Execute: Boolean) of object;
  TBeforeReadFolderEvent = procedure (const Folder: String;
    Files: TStrings; var ProceedToReadFolder: Boolean) of object;
  TReadFoldersEvent = procedure (const Folder: String; Folders: TStrings) of object;
  TReadFilesEvent = procedure (const Folder: String; Files: TStrings) of object;

  TFileSortType = (stName, stExtension, stDate, stSize, stUnsorted);


  T_AM2000_Roots = class(TStringList);

  T_AM2000_Root = type String;

  T_AM2000_FolderMenuOption = (foExtractFileIcon, foFoldersFirst{, foSeparateRoots});
  T_AM2000_FolderMenuOptions = set of T_AM2000_FolderMenuOption;

  TRootFolder = (rfDesktop, rfMyComputer, rfNetwork, rfRecycleBin, rfAppData,
    rfCommonDesktopDirectory, rfCommonPrograms, rfCommonStartMenu, rfCommonStartup,
    rfControlPanel, rfDesktopDirectory, rfFavorites, rfFonts, rfInternet, rfPersonal,
    rfPrinters, rfPrintHood, rfPrograms, rfRecent, rfSendTo, rfStartMenu, rfStartup,
    rfTemplates);

  TFolderMenu2000 = class(TPopupMenu2000)
  private
    FRoot: T_AM2000_Root;
    FOnClick: TFileClickEvent;

    LastFile: Integer;
    LastFolder: Integer;
    FFolderBitmap: TBitmap;
    FSortBy: TFileSortType;
    FMask: String;
    FRoots: T_AM2000_Roots;
    FFolderOptions: T_AM2000_FolderMenuOptions;

    FirstItem: TMenuItem2000;
    TempBitmap: TBitmap;
    FOnBeforeReadFolder: TBeforeReadFolderEvent;
    FOnReadFolders: TReadFoldersEvent;
    FOnReadFiles: TReadFilesEvent;
    FHiddenFilesMask: String;
    FFolderMenuOptions: T_AM2000_FolderMenuOptions;

    procedure OpenFolder1Click(Sender: TObject);
    procedure OpenFile1Click(Sender: TObject);
    procedure ClearMenuItem(Item: TMenuItem2000);
    procedure SetFolderBitmap(const Value: TBitmap);
    function GetLocation(Item: TObject): String;
    procedure DrawFolderItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure DrawFileItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);

    procedure SetRoot(const Value: T_AM2000_Root);
    function GetRoots: T_AM2000_Roots;
    procedure SetRoots(const Value: T_AM2000_Roots);
    function IsFolderMenuOptionsStored: Boolean;

  protected
    procedure Loaded; override;

    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function NewFolderItem(const ACaption, ALocation: String; const AddEmpty: Boolean): TMenuItem2000;
    function NewFileItem(const ACaption, ALocation, AHint: String): TMenuItem2000;

  published
    property Root: T_AM2000_Root
      read FRoot write SetRoot;
    property Roots: T_AM2000_Roots
      read GetRoots write SetRoots;
      
    property OnClick: TFileClickEvent
      read FOnClick write FOnClick;
    property FolderBitmap: TBitmap
      read FFolderBitmap write SetFolderBitmap;

    property SortBy: TFileSortType
      read FSortBy write FSortBy default stName;
    property Mask: String
      read FMask write FMask;

    property HiddenFilesMask: String
      read FHiddenFilesMask write FHiddenFilesMask;

    property FolderMenuOptions: T_AM2000_FolderMenuOptions
      read FFolderMenuOptions write FFolderMenuOptions stored IsFolderMenuOptionsStored;

    property OnBeforeReadFolder: TBeforeReadFolderEvent
      read FOnBeforeReadFolder write FOnBeforeReadFolder;
    property OnReadFolders: TReadFoldersEvent
      read FOnReadFolders write FOnReadFolders;
    property OnReadFiles: TReadFilesEvent
      read FOnReadFiles write FOnReadFiles;

  end;

implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  CommCtrl, TypInfo,
  {$IFDEF Delphi2} Ole2, {$ELSE} ComObj, ShlObj, ActiveX, {$ENDIF}
  am2000options, am2000cache, am2000utils;

{$R FolderMenu2000.res}

type
  TFolderMenuItem = class(TMenuItem2000)
  private
    Location: String;
  end;



function Replace(const S, S1, S2: String): String;
var
  L1, L2, O: Integer;
  P, PS, PF: PChar;
begin
  Result:= S;
  PS:= PChar(Result);
  PF:= PChar(S1);
  L1:= Length(S1);
  L2:= Length(S2);
  P:= StrPos(PS, PF);
  while P <> nil do begin
    O:= Integer(P) - Integer(PChar(Result));
    Delete(Result, O +1, L1);
    Insert(S2, Result, O +1);
    PS:= PChar(Integer(PChar(Result)) + O + L2);

    P:= StrPos(PS, PF);
  end;
end;



{****************************************************************************}
{ We used some routines from Borland Delphi 6 VCL here                       }
{ to provide backward compatibility with previous versions of Delphi and BCB }
{****************************************************************************}

const
{$IFNDEF Delphi4OrHigher}
  CSIDL_INTERNET = $0001;
{$ENDIF}
  nFolder: array[TRootFolder] of Integer =
    (CSIDL_DESKTOP, CSIDL_DRIVES, CSIDL_NETWORK, CSIDL_BITBUCKET, CSIDL_APPDATA,
    CSIDL_COMMON_DESKTOPDIRECTORY, CSIDL_COMMON_PROGRAMS, CSIDL_COMMON_STARTMENU,
    CSIDL_COMMON_STARTUP, CSIDL_CONTROLS, CSIDL_DESKTOPDIRECTORY, CSIDL_FAVORITES,
    CSIDL_FONTS, CSIDL_INTERNET, CSIDL_PERSONAL, CSIDL_PRINTERS, CSIDL_PRINTHOOD,
    CSIDL_PROGRAMS, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_STARTMENU, CSIDL_STARTUP,
    CSIDL_TEMPLATES);


procedure DisposePIDL(PIDL: PItemIDList);
var
  MAlloc: IMAlloc;
begin
  OLECheck(SHGetMAlloc(MAlloc));
  MAlloc.Free(PIDL);
end;


{ TFolderMenu2000 }

constructor TFolderMenu2000.Create(AOwner: TComponent);
begin
  inherited;

  FFolderMenuOptions:= [foExtractFileIcon, foFoldersFirst{, foSeparateRoots}];
  FRoot:= '\';
  FMask:= '*.*';

  FFolderBitmap:= TBitmap.Create;

  TempBitmap:=  TBitmap.Create;
  TempBitmap.Width:= 16;
  TempBitmap.Height:= 16;
  TempBitmap.Canvas.Brush.Style:= bsSolid;
end;

destructor TFolderMenu2000.Destroy;
begin
  FRoots.Free;
  FFolderBitmap.Free;
  TempBitmap.Free;
  
  inherited;
end;

procedure TFolderMenu2000.Loaded;
begin
  inherited;

  if FFolderBitmap.Empty
  and (not (csDesigning in ComponentState))
  then FFolderBitmap.LoadFromResourceName(hInstance, 'BMP_PL2000_FILEFOLDER');
end;

procedure TFolderMenu2000.ClearMenuItem(Item: TMenuItem2000);
begin
  while Item.Count > 0 do
    Item[Item.Count -1].Free;
end;

function TFolderMenu2000.NewFolderItem(const ACaption, ALocation: String;
  const AddEmpty: Boolean): TMenuItem2000;
begin
  Inc(LastFolder);
  Result:= TFolderMenuItem.Create(Owner);
  Result.Caption:= ACaption;
  Result.Default:= True;
  Result.OnClick:= OpenFolder1Click;
  Result.OnDrawItem:= DrawFolderItem;
  TFolderMenuItem(Result).Location:= ALocation;

  if AddEmpty
  then Result.Add(NewItem(SEmptyCaption, 0, False, False, nil, 0, ''));
end;

function TFolderMenu2000.NewFileItem(const ACaption, ALocation, AHint: String): TMenuItem2000;
begin
  Result:= TFolderMenuItem.Create(Owner);
  Result.Caption:= ACaption;
  Result.OnClick:= OpenFile1Click;
  Result.Hint:= AHint;
  Result.OnDrawItem:= DrawFileItem;
  TFolderMenuItem(Result).Location:= ALocation;
end;

procedure TFolderMenu2000.CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean);
begin
  LastFile:= 0;
  LastFolder:= 0;
  OpenFolder1Click(Items);
  FirstItem:= Items[0];

  inherited;
end;

procedure TFolderMenu2000.OpenFolder1Click(Sender: TObject);
type
  TProcessItems = (prFoldersOnly, prNonFoldersOnly, prAll);

var
  Fetched, uAttr: {$IFDEF Delphi3}{$IFNDEF CBuilder3}Integer{$ELSE}Cardinal{$ENDIF}{$ELSE}Cardinal{$ENDIF};
  L: TStringList;
  faNA, I, LastCount: Integer;
  ReadFolder: Boolean;

  function ArrangeFilename(S: String; Folder: Boolean): String;
  begin
    if S = UpperCase(S)
    then begin
      Result:= LowerCase(S);
      if Folder then Result[1]:= S[1];
    end
    else
      Result:= S;
  end;

  function SortBy(SI: TSearchRec): String;
  begin
    case FSortBy of
      stName: Result:= UpperCase(SI.Name);
      stExtension: Result:= UpperCase(ExtractFileExt(SI.Name));
      stDate: Result:= DateTimeToStr(FileDateToDateTime(SI.Time));
      stSize:
        begin
          Result:= IntToStr(SI.Size);
          while Length(Result) < 10 do Result:= '0' + Result;
        end;
      else
        Result:= '';
    end;
  end;

  function StrRetToString(PIDL: PItemIDList; StrRet: TStrRet): string;
  var
    P: PChar;
  begin
    case StrRet.uType of
      STRRET_CSTR:
        SetString(Result, StrRet.cStr, lStrLen(StrRet.cStr));
      STRRET_OFFSET:
        begin
          P:= @PIDL.mkid.abID[StrRet.uOffset - SizeOf(PIDL.mkid.cb)];
          SetString(Result, P, PIDL.mkid.cb - StrRet.uOffset);
        end;
      STRRET_WSTR:
        Result := StrRet.pOleStr;
    end;
  end;

  procedure ProcessEnumList(const Folder: IShellFolder; EnumList: IEnumIDList;
    const Process: TProcessItems);
  var
    E, S: String;
    Icon: IExtractIcon;
    IconLarge, IconSmall: HIcon;
    strDispName: TStrRet;
    ItemIDL: PItemIDList;
    MI: TMenuItem2000;
    sfi: TShFileInfo;
    il: HImageList;
    I: Integer;
  begin
    if EnumList = nil then Exit;

    while (EnumList.Next(1, ItemIDL, Fetched) = S_OK)
    and (Fetched = 1)
    do begin
      Folder.GetDisplayNameOf(ItemIDL, SHGDN_INFOLDER, strDispName);
      E:= StrRetToString(ItemIDL, strDispName);

      Folder.GetDisplayNameOf(ItemIDL, SHGDN_FORPARSING, strDispName);
      S:= StrRetToString(ItemIDL, strDispName);

      uAttr:= SFGAO_FOLDER;
      Folder.GetAttributesOf(1, ItemIDL, {$IFDEF CBuilder3}Integer(uAttr){$ELSE}uAttr{$ENDIF});

      if ((Process = prFoldersOnly)
      and (uAttr and SFGAO_FOLDER <> 0))
      or ((Process = prNonFoldersOnly)
      and (uAttr and SFGAO_FOLDER = 0))
      or (Process = prAll)
      then begin
        if (uAttr and SFGAO_FOLDER <> 0)
        then
          MI:= NewFolderItem(E, S, True)

        else begin
          MI:= NewFileItem(E, S, '');

          with MI.Bitmap
          do begin
            Width:= 16;
            Height:= 16;
            Canvas.Brush.Color:= Options.Colors.Menu;
            Canvas.FillRect(Rect(0, 0, 16, 16));
          end;

          il:= ShGetFileInfo(PChar(ItemIDL), 0, sfi, SizeOf(sfi), SHGFI_SYSICONINDEX or SHGFI_SMALLICON or SHGFI_PIDL);
          if (il <> 0)
          and (sfi.iIcon <> 3)
          then
            ImageList_Draw(il, sfi.iIcon, MI.Bitmap.Canvas.Handle, 0, 0, ild_Transparent)

          else begin
            IconSmall:= 0;
            Folder.GetUIObjectOf(0, 1, ItemIDL, IID_IExtractIconA, nil, Pointer(Icon));
            if Icon <> nil
            then begin
              SetLength(S, 255);
              if Icon.GetIconLocation(GIL_OPENICON, PChar(S), Length(S), I,
                {$IFDEF CBuilder3}Integer(uAttr){$ELSE}uAttr{$ENDIF}) = S_OK
              then Icon.Extract(PChar(S), I, IconSmall, IconLarge, 16);

              if IconLarge <> 0
              then DestroyIcon(IconLarge);

              if IconSmall = 0
              then IconSmall:= ExtractIcon(HInstance, PChar(S), I);

              if IconSmall <> 0
              then begin
                DrawIconEx(MI.Bitmap.Canvas.Handle, 0, 0, IconSmall, 16, 16,
                  0, MI.Bitmap.Canvas.Brush.Handle, di_Normal);
                DestroyIcon(IconSmall);
              end;
            end;

            if (IconSmall = 0)
            and (il <> 0)
            then
              ImageList_Draw(il, sfi.iIcon, MI.Bitmap.Canvas.Handle, 0, 0, ild_Transparent);
          end;
        end;
        
        L.AddObject(E, MI);
      end;

      DisposePIDL(ItemIDL);
    end;
  end;

  procedure CopyListToMenu(const FoldersOrFiles: Boolean);
  var
    I: Integer;
  begin
    if FoldersOrFiles
    then begin
      if Assigned(FOnReadFolders)
      then FOnReadFolders(Root, L);
    end
    else
      if Assigned(FOnReadFiles)
      then FOnReadFiles(Root, L);

    for I:= 0 to L.Count -1
    do TMenuItem2000(Sender).Add(TMenuItem2000(L.Objects[I]));

    L.Clear;
  end;

  procedure ProcessRoot(ARoot: String);
  var
    SI: TSearchRec;
    R, I: Integer;
    S, S1, E: String;
    FolderIDL: PItemIDList;
    Folder, DesktopFolder: IShellFolder;
    EnumList: IEnumIDList;
    MI: TMenuItem2000;
  begin
    if Assigned(FOnBeforeReadFolder)
    then FOnBeforeReadFolder(ARoot, L, ReadFolder);

    // special folder
    if ReadFolder
    then begin
      I:= GetEnumValue(TypeInfo(TRootFolder), ARoot);
      with TMenuItem2000(Sender)
      do try
        if (I >= 0)
        or ((Sender is TFolderMenuItem)
        and (TFolderMenuItem(Sender).Location <> ''))
        then begin
          if (Sender is TFolderMenuItem)
          and (TFolderMenuItem(Sender).Location <> '')
          then begin
            ShGetDesktopFolder(DesktopFolder);
            DesktopFolder.ParseDisplayName(0, nil, StringToOleStr(TFolderMenuItem(Sender).Location),
              Fetched, FolderIDL, uAttr);
            DesktopFolder.BindToObject(FolderIDL, nil, IID_IShellFolder, Pointer(Folder));

            if Folder = nil
            then DesktopFolder.GetUIObjectOf(0, 1, FolderIDL, IID_IShellFolder, nil, Pointer(Folder));
            if Folder = nil
            then DesktopFolder.CreateViewObject(0, IID_IShellFolder, Pointer(Folder));

            DisposePIDL(FolderIDL);
          end

          else
          if I = 0
          then
            ShGetDesktopFolder(Folder)

          else begin
            SHGetSpecialFolderLocation(0, nFolder[TRootFolder(I)], FolderIDL);
            ShGetDesktopFolder(DesktopFolder);
            DesktopFolder.BindToObject(FolderIDL, nil, IID_IShellFolder, Pointer(Folder));
            DisposePIDL(FolderIDL);
          end;

          // enum folder content
          if Folder <> nil
          then begin
            if foFoldersFirst in FFolderMenuOptions
            then begin
              Folder.EnumObjects(0, SHCONTF_FOLDERS, EnumList);
              ProcessEnumList(Folder, EnumList, prFoldersOnly);
              CopyListToMenu(True);
              Folder.EnumObjects(0, SHCONTF_NONFOLDERS, EnumList);
              ProcessEnumList(Folder, EnumList, prNonFoldersOnly);
            end
            else begin
              Folder.EnumObjects(0, SHCONTF_FOLDERS + SHCONTF_NONFOLDERS, EnumList);
              ProcessEnumList(Folder, EnumList, prAll);
            end;
          end;
        end { special folder }
        else
        if Length(ARoot) > 0
        then begin
          if ARoot[Length(ARoot)] <> '\' then ARoot:= ARoot + '\';

          if foFoldersFirst in FFolderMenuOptions
          then begin
            // folders
            R:= FindFirst(ARoot + '*.*', faDirectory, SI);
            while R = 0
            do begin
              if (SI.Attr and faDirectory <> 0)
              and (SI.Name[1] <> '.')
              then begin
                E:= ArrangeFilename(SI.Name, True);
                L.AddObject(E, NewFolderItem(E, '', True));
              end;

              R:= FindNext(SI);
            end;
            FindClose(SI);

            // clear
            CopyListToMenu(True);
          end;

          // add sorting
          L.Sorted:= FSortBy <> stUnsorted;

          // add files
          S:= FMask;
          repeat
            I:= Pos('|', S);
            if I = 0 then I:= Length(S) +1;
            S1:= Copy(S, 1, I -1);
            System.Delete(S, 1, I);

            R:= FindFirst(ARoot + S1, faAnyFile, SI);
            while (R = 0)
            do begin
              if (SI.Attr and faNA = 0)
              then begin
                E:= ArrangeFilename(SI.Name, False);

                if SI.Attr and faDirectory <> 0
                then
                  MI:= NewFolderItem(E, '', True)
                else begin
                  MI:= NewFileItem(E, '', E + #13 + IntToStr(SI.Size) + ' bytes');
                end;

                L.AddObject(SortBy(SI), MI);
              end;

              R:= FindNext(SI);
            end;
            FindClose(SI);

          until S = '';
        end; { folder }
      except
      end;
    end;


  end;

begin
//  TMenuItem2000(Sender).ReleaseHandle;
  ClearMenuItem(TMenuItem2000(Sender));

  ReadFolder:= True;
  L:= TStringList.Create;

  L.Sorted:= True;
  L.Duplicates:= dupIgnore;
  faNA:= faVolumeID or faHidden or faSysFile;
  if foFoldersFirst in FFolderMenuOptions
  then faNa:= faNa or faDirectory;

  // get first item
  if TMenuItem2000(Sender).Parent = nil
  then begin
    LastCount:= TMenuItem2000(Sender).Count;

    for I:= 0 to Roots.Count -1
    do begin
      ProcessRoot(Roots[I]);
      CopyListToMenu(False);

      if TMenuItem2000(Sender).Count > LastCount
      then TMenuItem2000(Sender).Add(NewLine2000);

      LastCount:= TMenuItem2000(Sender).Count;
    end
  end
  else begin
    ProcessRoot(GetLocation(Sender));
    CopyListToMenu(False);
  end;

  if TMenuItem2000(Sender).Count = 0
  then TMenuItem2000(Sender).Add(NewItem('( Empty )', 0, False, False, nil, 0, ''));

  L.Free;
end;

procedure TFolderMenu2000.OpenFile1Click(Sender: TObject);
var
  zFileName: array[0..255] of Char;
  Execute: Boolean;
  S: String;
begin
  Execute:= True;

  S:= TFolderMenuItem(Sender).Location;
  if S = ''
  then S:= GetLocation(Sender);

  if Assigned(FOnClick)
  then FOnClick(S, Execute);

  if Execute
  then
    ShellExecute(Application.MainForm.Handle, nil,
      StrPCopy(zFileName, S), nil, nil, sw_ShowNormal);
end;

procedure TFolderMenu2000.SetFolderBitmap(const Value: TBitmap);
begin
  FFolderBitmap.Assign(Value);
end;

function TFolderMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Folder Menu Items';
end;

function TFolderMenu2000.GetLocation(Item: TObject): String;
var
  MI: TMenuItem2000;
  C: array[0..255] of Char;
begin
  if Item = nil
  then begin
    Result:= FRoot;
    Exit;
  end;

  MI:= TMenuItem2000(Item);
  Result:= MI.Caption;
  MI:= MI.Parent;

  while (MI <> nil)
  and (MI <> FirstItem.Parent)
  do begin
    Result:= MI.Caption + '\' + Result;
    MI:= MI.Parent;
  end;

  if (Result <> '')
  and (FRoot <> '')
  and (FRoot[Length(FRoot)] <> '\')
  then Result:= '\' + Result;

  Result:= FRoot + Result;
  if Result[1] = '\'
  then begin
    GetCurrentDirectory(SizeOf(C), C);
    Result:= C[0] + ':' + Result;
  end;
end;

procedure TFolderMenu2000.DrawFileItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  sfi: TShFileInfo;
  il: HImageList;
begin
  if TMenuItem2000(Sender).Bitmap.Empty
  then
    if foExtractFileIcon in FFolderMenuOptions
    then begin
      // extract icon
      il:= ShGetFileInfo(PChar(GetLocation(Sender)), 0, sfi, SizeOf(sfi), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
      if il <> 0
      then
        with TMenuItem2000(Sender).Bitmap
        do begin
          Width:= 16;
          Height:= 16;
          Canvas.Brush.Color:= Options.Colors.Menu;
          Canvas.FillRect(Rect(0, 0, 16, 16));
          ImageList_Draw(il, sfi.iIcon, Canvas.Handle, 0, 0, ild_Transparent);
        end;
    end;

  with TMenuItem2000(Sender), PaintParams
  do
    DrawTextItem(ACanvas, T_AM2000_MenuOptions(PaintOptions),
      Replace(Caption, '&', '&&'), '', TMenuItem2000(Sender).Bitmap.Handle,
      -1, nil, -1, 1, State, MouseState, @PaintParams);
end;

procedure TFolderMenu2000.DrawFolderItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  ItemState: T_AM2000_ItemState;
  Bmp: HBitmap;
  NG: Integer;
begin
  ItemState:= [isDefault, isSubmenu];
  if Selected
  then Include(ItemState, isSelected);
  Include(ItemState, BiDiModeToState[BiDiMode]);

  ItemState:= ItemState + PaintParams.State * [isCtl3d, isGraphBack];


  with TMenuItem2000(Sender), PaintParams
  do begin
    if Bitmap.Handle <> 0
    then begin
      Bmp:= Bitmap.Handle;
      NG:= 1;
    end
    else begin
      Bmp:= FFolderBitmap.Handle;
      NG:= 4;
    end;
    
    DrawTextItem(ACanvas, T_AM2000_MenuOptions(PaintOptions),
      Replace(Caption, '&', '&&'), '', Bmp, -1, nil,
      -1, NG, ItemState, MouseState, @PaintParams);
  end;
end;

function TFolderMenu2000.GetRoots: T_AM2000_Roots;
begin
  if FRoots = nil
  then begin
    FRoots:= T_AM2000_Roots.Create;
    FRoots.Add(FRoot);
  end;
  
  Result:= FRoots;
end;

procedure TFolderMenu2000.SetRoot(const Value: T_AM2000_Root);
begin
  if FRoots <> nil
  then
    if FRoots.Count = 0
    then FRoots.Add(Value)
    else FRoots[0]:= Value;

  FRoot:= Value;
end;

procedure TFolderMenu2000.SetRoots(const Value: T_AM2000_Roots);
begin
  Roots.Assign(Value);

  if FRoots.Count > 0
  then FRoot:= FRoots[0];
end;


function TFolderMenu2000.IsFolderMenuOptionsStored: Boolean;
begin
  Result:= FFolderMenuOptions <> [foExtractFileIcon, foFoldersFirst{, foSeparateRoots}];
end;


initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
