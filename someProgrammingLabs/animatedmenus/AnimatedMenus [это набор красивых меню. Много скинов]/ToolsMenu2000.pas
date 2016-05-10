
{*******************************************************}
{                                                       }
{       Animated Menus Add-On Menu Component            }
{       TToolsMenu2000 Component                        }
{                                                       }
{       Copyright © 1997-2002 by Animated Menus, Inc.   }
{                                                       }
{*******************************************************}

{

   For additional information and latest version please visit
   http://www.animatedmenus.com/support/ttoolsmenu2000/

}

unit ToolsMenu2000;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  am2000, am2000menuitem;

type
  T_AM2000_ToolOption = (toPromptForArguments, toRunInModalWindow, toMinimizeOnRun);
  T_AM2000_ToolOptions = set of T_AM2000_ToolOption;

  TToolsMenu2000 = class;

  T_AM2000_Tool = class
  private
    FTools: TList;
    FBitmap: TBitmap;

    procedure SetBitmap(const Value: TBitmap);

  public
    Title, Command, Arguments, InitialDir: String;
    Options: T_AM2000_ToolOptions;

    property Bitmap: TBitmap
      read FBitmap write SetBitmap;

    procedure Delete;
    constructor Create(ATools: TList);
    destructor Destroy; override;
  end;


  T_AM2000_Tools = class(TPersistent)
  private
    FTools: TList;
    FMenu: TToolsMenu2000;
    
    function GetTool(const Index: Integer): T_AM2000_Tool;
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);

  protected
    procedure DefineProperties(Filer: TFiler); override;
    
  public
    constructor Create(const AMenu: TToolsMenu2000);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(const ATitle, ACommand, AArguments, AInitialDir: String;
      const ABitmap: TBitmap;
      const AOptions: T_AM2000_ToolOptions);
    procedure Remove(const Item: Pointer);
    procedure Delete(const Index: Integer);
    procedure Insert(const Index: Integer; const Item: T_AM2000_Tool);

    procedure Assign(Source: T_AM2000_Tools); virtual;

    function Count: Integer;
    procedure Save;

  public
    property Tool [const Index: Integer]: T_AM2000_Tool
      read GetTool; default;

  end;


  T_AM2000_ToolsMenuOption = (toIncludeSeparator, toIncludeEmpty);
  T_AM2000_ToolsMenuOptions = set of T_AM2000_ToolsMenuOption;

  T_AM2000_BeforeExecuteEvent = procedure (Sender: TObject;
    const Tool: T_AM2000_Tool; var Execute: Boolean) of object;
  T_AM2000_AfterExecuteEvent = procedure (Sender: TObject;
    const Tool: T_AM2000_Tool) of object;

  T_AM2000_ToolsMenuSaveTo = (stDontSave, stFile, stRegistry);


  TToolsMenu2000 = class(TPopupMenu2000)
  private
    FTools: T_AM2000_Tools;
    FFilename: String;
    FRegistry: String;
    FToolsMenuOptions: T_AM2000_ToolsMenuOptions;
    FSaveTo: T_AM2000_ToolsMenuSaveTo;
    FOnBeforeExecute: T_AM2000_BeforeExecuteEvent;
    FOnAfterExecute: T_AM2000_AfterExecuteEvent;

    procedure SetTools(const Value: T_AM2000_Tools);
    function IsToolsMenuOptionsStored: Boolean;

  protected
    procedure DoClick(Sender: TObject); virtual;
    procedure DoClear(Sender: TObject); virtual;

    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;
    procedure UpdateComponentItems(Items: TMenuItem2000); override;
    procedure Loaded; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Save;

  published
    property Tools: T_AM2000_Tools
      read FTools write SetTools;

    property ToolsMenuOptions: T_AM2000_ToolsMenuOptions
      read FToolsMenuOptions write FToolsMenuOptions stored IsToolsMenuOptionsStored;
    property SaveToFileName: String
      read FFilename write FFilename;
    property SaveToRegistryKey: String
      read FRegistry write FRegistry;
    property SaveTo: T_AM2000_ToolsMenuSaveTo
      read FSaveTo write FSaveTo default stDontSave;
    property OnBeforeExecute: T_AM2000_BeforeExecuteEvent
      read FOnBeforeExecute write FOnBeforeExecute;
    property OnAfterExecute: T_AM2000_AfterExecuteEvent
      read FOnAfterExecute write FOnAfterExecute;

  end;

procedure Register;

implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  Registry, ShellApi, am2000utils, am2000cache;
  

procedure Register;
begin
  RegisterComponents('Animated Menus', [TToolsMenu2000]);
end;

function OptionsToStr(const AOptions: T_AM2000_ToolOptions): String;
begin
  Result:= '';
  if toPromptForArguments in AOptions then Result:= Result + 'P';
  if toRunInModalWindow in AOptions then Result:= Result + 'R';
  if toMinimizeOnRun in AOptions then Result:= Result + 'M';
end;

function StrToOptions(const AOptions: String): T_AM2000_ToolOptions;
begin
  Result:= [];
  if Pos('P', AOptions) > 0 then Include(Result, toPromptForArguments);
  if Pos('R', AOptions) > 0 then Include(Result, toRunInModalWindow);
  if Pos('M', AOptions) > 0 then Include(Result, toMinimizeOnRun);
end;

function BitmapToStr(const ABitmap: TBitmap): String;
{$IFDEF Delphi4OrHigher}
var
  SS: TStringStream;
begin
  if ABitmap.Empty
  then
    Result:= ''

  else begin
    SS:= TStringStream.Create('');

    ABitmap.SaveToStream(SS);
    SS.Seek(0, 0);
    SetLength(Result, 2* SS.Size);
    BinToHex(PChar(SS.DataString), PChar(Result), SS.Size);

    SS.Free;
  end;
{$ELSE}
begin
  Result:= ''
{$ENDIF}
end;

procedure StrToBitmap(const Source: String; const ABitmap: TBitmap);
{$IFDEF Delphi4OrHigher}
var
  SS: TStringStream;
  S1: String;
begin
  if Source = ''
  then
    ABitmap.Width:= 0

  else begin
    SetLength(S1, Length(Source) div 2);
    HexToBin(PChar(Source), PChar(S1), Length(S1));

    SS:= TStringStream.Create('');
    SS.WriteString(S1);
    SS.Seek(0, 0);
    ABitmap.LoadFromStream(SS);

    SS.Free;
  end;
{$ELSE}
begin
  ABitmap.Width:= 0
{$ENDIF}
end;


{ T_AM2000_Tool }

constructor T_AM2000_Tool.Create(ATools: TList);
begin
  inherited Create;
  FTools:= ATools;
  FBitmap:= TBitmap.Create;
end;

procedure T_AM2000_Tool.Delete;
begin
  FTools.Remove(Self);
end;

destructor T_AM2000_Tool.Destroy;
begin
  FBitmap.Free;
  FTools.Remove(Self);
  inherited;
end;

procedure T_AM2000_Tool.SetBitmap(const Value: TBitmap);
begin
  if Value <> nil
  then FBitmap.Assign(Value)
  else FBitmap.Width:= 0;
end;


{ T_AM2000_Tools }

constructor T_AM2000_Tools.Create;
begin
  inherited Create;
  FTools:= TList.Create;
  FMenu:= AMenu;
end;

destructor T_AM2000_Tools.Destroy;
begin
  Clear;
  FTools.Free;
  inherited;
end;

function T_AM2000_Tools.GetTool(const Index: Integer): T_AM2000_Tool;
begin
  Result:= T_AM2000_Tool(FTools[Index]);
end;

procedure T_AM2000_Tools.Clear;
begin
  while FTools.Count > 0
  do T_AM2000_Tool(FTools[0]).Free;
  FTools.Clear;
end;

procedure T_AM2000_Tools.Remove(const Item: Pointer);
begin
  FTools.Remove(Item);
end;

{procedure T_AM2000_Tools.Remove(const ATitle: String);
var
  I: Integer;
  T: T_AM2000_Tool;
begin
  for I:= 0 to FTools.Count -1
  do
    if T_AM2000_Tool(FTools[I]).Title = ATitle
    then begin
      T_AM2000_Tool(FTools[I]).Free;
      Exit;
    end;
end;}

procedure T_AM2000_Tools.Add(const ATitle, ACommand, AArguments, AInitialDir: String;
  const ABitmap: TBitmap;
  const AOptions: T_AM2000_ToolOptions);
var
  T: T_AM2000_Tool;
begin
  T:= T_AM2000_Tool.Create(FTools);
  T.Title:= ATitle;
  T.Command:= ACommand;
  T.Arguments:= AArguments;
  T.InitialDir:= AInitialDir;
  T.Options:= AOptions;
  T.Bitmap:= ABitmap;
  FTools.Add(T);
  FMenu.Save;
end;

procedure T_AM2000_Tools.Assign(Source: T_AM2000_Tools);
var
  I: Integer;
  T: T_AM2000_Tool;
begin
  Clear;

  for I:= 0 to Source.Count -1
  do begin
    T:= Source[I];
    Add(T.Title, T.Command, T.Arguments, T.InitialDir, T.Bitmap, T.Options);
  end;

  FMenu.Save;
end;

procedure T_AM2000_Tools.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Data', ReadData, WriteData, (FTools.Count > 0));
end;

procedure T_AM2000_Tools.WriteData(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  for I:= 0 to FTools.Count - 1
  do
    with T_AM2000_Tool(FTools[I])
    do begin
      Writer.WriteString(Title);
      Writer.WriteString(Command);
      Writer.WriteString(InitialDir);
      Writer.WriteString(Arguments);
      Writer.WriteString(OptionsToStr(Options));
      Writer.WriteString(BitmapToStr(Bitmap));
    end;
  Writer.WriteListEnd;
end;

procedure T_AM2000_Tools.ReadData(Reader: TReader);
var
  S, S1: String;
  T: T_AM2000_Tool;
  SS: TStringStream;
begin
  SS:= TStringStream.Create('');
  Reader.ReadListBegin;
  try
    Clear;

    while not Reader.EndOfList
    do begin
      T:= T_AM2000_Tool.Create(FTools);
      T.Title:= Reader.ReadString;
      T.Command:= Reader.ReadString;
      T.InitialDir:= Reader.ReadString;
      T.Arguments:= Reader.ReadString;
      T.Options:= StrToOptions(Reader.ReadString);
      StrToBitmap(Reader.ReadString, T.Bitmap);
      TList(FTools).Add(T);
    end;

  except
  end;

  Reader.ReadListEnd;
  SS.Free;
end;

function T_AM2000_Tools.Count: Integer;
begin
  Result:= FTools.Count;
end;

procedure T_AM2000_Tools.Delete(const Index: Integer);
begin
  FTools.Delete(Index);
end;

procedure T_AM2000_Tools.Insert(const Index: Integer;
  const Item: T_AM2000_Tool);
begin
  FTools.Insert(Index, Item);
end;

procedure T_AM2000_Tools.Save;
begin
  FMenu.Save;
end;



{ TToolsMenu2000 }

constructor TToolsMenu2000.Create(AOwner: TComponent);
begin
  inherited;

  FToolsMenuOptions:= [];
  FTools:= T_AM2000_Tools.Create(Self);
  FFilename:= '$(APPDATA)\$(APPNAME)\$(MENU)';
  FRegistry:= '\Software\$(APPNAME)\$(MENU)';
  FSaveTo:= stDontSave;
end;

destructor TToolsMenu2000.Destroy;
begin
  FTools.Free;
  inherited;
end;

procedure TToolsMenu2000.DoClick;
var
  Execute: Boolean;
  T: T_AM2000_Tool;
  S: String;
begin
  T:= FTools[TMenuItem2000(Sender).Tag];
  S:= T.Arguments;
  Execute:= True;

  if Assigned(FOnBeforeExecute)
  then begin
    FOnBeforeExecute(Self, T, Execute);
    if not Execute then Exit;
  end;

  if (toPromptForArguments in T.Options)
  and not InputQuery(T.Title, 'Enter arguments for ' + T.Title, S)
  then Exit;

  try
    ShellExecute(Application.Handle, 'open',
      PChar(T.Command),
      PChar(S),
      PChar(T.InitialDir),
      sw_ShowNormal);

  except
    on E: Exception
    do
      Application.MessageBox(PChar('Error starting application:'#13 +
        T.Title + #13#13 +
        'Error message:'#13 +
        E.Message), 'Error', mb_IconError);
  end;
end;

procedure TToolsMenu2000.CreateComponentItems(Items: TMenuItem2000;
  AddEmpty: Boolean);
var
  M: TMenuItem2000;
  T: T_AM2000_Tool;
  I: Integer;
begin
  // start from separator
  if (toIncludeSeparator in FToolsMenuOptions)
  and ((FTools.Count > 0)
  or (toIncludeEmpty in FToolsMenuOptions))
  then Items.Add(NewLine);

  for I:= 0 to FTools.Count -1
  do begin
    M:= NewItem(FTools[I].Title, 0, False, True, DoClick, 0, '');
    M.Tag:= I;
    M.Bitmap:= FTools[I].Bitmap;
    Items.Add(M);
  end;

  if (Items.Count > 0)
  and (Items[Items.Count -1].Caption <> '-')
  then
    Items.Add(NewLine)

  else
  if (toIncludeEmpty in FToolsMenuOptions)
  then begin
    Items.Add(NewItem(SEmptyCaption, 0, False, False, nil, 0, ''));
    Items.Add(NewLine);
  end;

  if (Items.Count > 0)
  and (Items[Items.Count -1].Caption = '-')
  then Items.Delete(Items.Count -1);
end;

function TToolsMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Tools Menu Items';
end;

procedure TToolsMenu2000.UpdateComponentItems(Items: TMenuItem2000);
begin
  Items.Clear;
  CreateComponentItems(Items, True);
end;

procedure TToolsMenu2000.DoClear(Sender: TObject);
begin
  FTools.Clear;
end;

procedure TToolsMenu2000.Loaded;
var
  F: TextFile;
  I, P: Integer;
  Filename, S: String;
  Reg: TRegistry;
  T: T_AM2000_Tool;
begin
  inherited;

  if (FSaveTo = stDontSave)
  or (csDesigning in ComponentState)
  then Exit;

  InitializePath(FRegistry, FFilename);

  if FSaveTo = stFile
  then begin
    Filename:= StringReplace(FFilename, '$(MENU)', Name + '.tools', []);
    if not FileExists(Filename)
    then Exit;

    FTools.Clear;

    AssignFile(F, Filename);
    Reset(F);

    while not Eof(F)
    do begin
      T:= T_AM2000_Tool.Create(FTools.FTools);
      ReadLn(F, S);
      T.Title:= S;
      ReadLn(F, S);
      T.Command:= S;
      ReadLn(F, S);
      T.Arguments:= S;
      ReadLn(F, S);
      T.InitialDir:= S;
      ReadLn(F, S);
      T.Options:= StrToOptions(S);
      ReadLn(F, S);
      StrToBitmap(S, T.Bitmap);

      FTools.FTools.Add(T);
    end;

    CloseFile(F);
  end
  else begin
    Reg:= TRegistry.Create;
    if Reg.OpenKey(StringReplace(FRegistry, '$(MENU)', Name, []), False)
    then begin
      FTools.Clear;

      for I:= 0 to Reg.ReadInteger('Count') -1
      do begin
        S:= IntToStr(I);
        T:= T_AM2000_Tool.Create(FTools.FTools);
        T.Title:= Reg.ReadString(S + '-Title');
        T.Command:= Reg.ReadString(S + '-Command');
        T.Arguments:= Reg.ReadString(S + '-Arguments');
        T.InitialDir:= Reg.ReadString(S + '-InitialDir');
        T.Options:= StrToOptions(Reg.ReadString(S + '-Options'));
        StrToBitmap(Reg.ReadString(S + '-Bitmap'), T.Bitmap);

        FTools.FTools.Add(T);
      end;
    end;
    
    Reg.Free;
  end;
end;

procedure TToolsMenu2000.Save;
var
  F: TextFile;
  I, Code: Integer;
  Filename, S: String;
  Reg: TRegistry;
  T: T_AM2000_Tool;
begin
  if FSaveTo = stDontSave
  then Exit;

  InitializePath(FRegistry, FFilename);

  if FSaveTo = stFile
  then begin
    Filename:= StringReplace(FFilename, '$(MENU)', Name + '.tools', []);
    S:= ExtractFilePath(Filename);
    Code:= GetFileAttributes(PChar(S));
    if ((Code = -1)
    or (FILE_ATTRIBUTE_DIRECTORY and Code = 0))
    and not CreateDirectory(PChar(S), nil)
    then Exit;

    AssignFile(F, Filename);
    Rewrite(F);

    for I:= FTools.Count -1 downto 0
    do
      with FTools[I]
      do begin
        WriteLn(F, Title);
        WriteLn(F, Command);
        WriteLn(F, Arguments);
        WriteLn(F, InitialDir);
        WriteLn(F, OptionsToStr(Options));
        WriteLn(F, BitmapToStr(Bitmap));
      end;

    CloseFile(F);
  end
  else begin
    Reg:= TRegistry.Create;
    Reg.OpenKey(StringReplace(FRegistry, '$(MENU)', Name, []), True);

    Reg.WriteInteger('Count', FTools.Count);
    for I:= FTools.Count -1 downto 0
    do
      with FTools[I]
      do begin
        S:= IntToStr(FTools.Count - I -1);

        Reg.WriteString(S + '-Title', Title);
        Reg.WriteString(S + '-Command', Command);
        Reg.WriteString(S + '-Arguments', Arguments);
        Reg.WriteString(S + '-InitialDir', InitialDir);
        Reg.WriteString(S + '-Options', OptionsToStr(Options));
        Reg.WriteString(S + '-Bitmap', BitmapToStr(Bitmap));
      end;

    Reg.Free;
  end;
end;

procedure TToolsMenu2000.SetTools(const Value: T_AM2000_Tools);
begin
  FTools.Assign(Value);
end;


function TToolsMenu2000.IsToolsMenuOptionsStored: Boolean;
begin
  Result:= FToolsMenuOptions <> []; 
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
