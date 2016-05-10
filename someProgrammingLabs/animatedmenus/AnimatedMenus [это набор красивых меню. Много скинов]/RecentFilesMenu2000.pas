
{*******************************************************}
{                                                       }
{       Animated Menus Add-On Menu Component            }
{       TRecentFilesMenu2000 Component                  }
{                                                       }
{       Copyright © 1997-2002 by Animated Menus, Inc.   }
{                                                       }
{*******************************************************}

{

   For additional information and latest version please visit
   http://www.animatedmenus.com/support/trecentfilesmenu2000/

}

unit RecentFilesMenu2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  am2000, am2000menuitem;

type
  T_AM2000_RecentFilesMenuOption = (roShowNumber, roShowLetter, roShowShortcut,
    roShowFullPath, roShowReducedPath, roShowExtension,
    roUseCurrentDir, roIncludeSeparator, roIncludeClear, roIncludeEmpty);
  T_AM2000_RecentFilesMenuOptions = set of T_AM2000_RecentFilesMenuOption;

  T_AM2000_RecentFilesMenuClickEvent = procedure (Sender: TObject;
    const Filename: String; var RemoveFromList: Boolean) of object;

  T_AM2000_RecentFilesMenuCheckEvent = procedure (Sender: TObject;
    const Filename: String; var IncludeFile: Boolean) of object;

  T_AM2000_RecentFilesMenuSaveTo = (stDontSave, stFile, stRegistry);

  TRecentFilesMenu2000 = class(TPopupMenu2000)
  private
    FFiles: TStrings;
    FMax: Word;
    FMaxLength: Word;
    FMaxGroupCount: TStrings;
    FMaxGroupIndex: Integer;
    FFilename: String;
    FRegistry: String;
    FOnClick: T_AM2000_RecentFilesMenuClickEvent;
    FRecentFilesMenuOptions: T_AM2000_RecentFilesMenuOptions;
    FOpenDialog: TOpenDialog;
    FOnCheck: T_AM2000_RecentFilesMenuCheckEvent;
    FSaveTo: T_AM2000_RecentFilesMenuSaveTo;

    procedure SetMaxGroupCount(const Value: TStrings);

  protected
    function DoCheck(const Filename: String): Boolean; virtual;
    procedure DoClick(Sender: TObject); virtual;
    procedure DoClear(Sender: TObject); virtual;

    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;
    procedure UpdateComponentItems(Items: TMenuItem2000); override;
    procedure Loaded; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;
    procedure Add(const Filename: String);
    procedure AddToGroup(const Filename: String; const GroupIndex: Integer);
    function GetFileGroup(const Filename: String): Integer;

    procedure Save;

    property Files: TStrings read FFiles;

    function Count: Integer;

  published
    property OpenDialog: TOpenDialog
      read FOpenDialog write FOpenDialog;
    property RecentFilesMenuOptions: T_AM2000_RecentFilesMenuOptions
      read FRecentFilesMenuOptions write FRecentFilesMenuOptions;
    property SaveToFileName: String
      read FFilename write FFilename;
    property SaveToRegistryKey: String
      read FRegistry write FRegistry;
    property MaxCount: Word
      read FMax write FMax default 9;
    property MaxGroupCount: TSTrings
      read FMaxGroupCount write SetMaxGroupCount;
    property MaxLength: Word
      read FMaxLength write FMaxLength default 40;
    property OnClick: T_AM2000_RecentFilesMenuClickEvent
      read FOnClick write FOnClick;
    property OnCheck: T_AM2000_RecentFilesMenuCheckEvent
      read FOnCheck write FOnCheck;
    property SaveTo: T_AM2000_RecentFilesMenuSaveTo
      read FSaveTo write FSaveTo default stDontSave;

  end;

procedure Register;

implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  Registry, am2000utils, am2000cache;
  

procedure Register;
begin
  RegisterComponents('Animated Menus', [TRecentFilesMenu2000]);
end;



{ TRecentFilesMenu2000 }

constructor TRecentFilesMenu2000.Create(AOwner: TComponent);
begin
  inherited;
  FRecentFilesMenuOptions:= [roShowNumber, roUseCurrentDir,
     roShowReducedPath, roShowExtension];
  FFiles:= TStringList.Create;
  FMaxGroupCount:= TStringList.Create;
  iMaxItemWidth:= Screen.Width;
  bEnableExtendedSymbols:= False;
  FMax:= 9;
  FMaxLength:= 40;
  FFilename:= '$(APPDATA)\$(APPNAME)\$(MENU)';
  FRegistry:= '\Software\$(APPNAME)\$(MENU)';
  FSaveTo:= stDontSave;
end;

destructor TRecentFilesMenu2000.Destroy;
begin
  FFiles.Free;
  FMaxGroupCount.Free;
  inherited;
end;

procedure TRecentFilesMenu2000.Clear;
begin
  FFiles.Clear;
  FMaxGroupIndex:= 0;
end;

procedure TRecentFilesMenu2000.Add(const Filename: String);
begin
  AddToGroup(Filename, 0);
end;

procedure TRecentFilesMenu2000.AddToGroup(const Filename: String;
  const GroupIndex: Integer);
var
  S: String;
  I, GroupCount, MaxGroupCount: Integer;
begin
  if GroupIndex < 0
  then raise Exception.CreateFmt('Invalid group index (%i).', [GroupIndex]);
  
  if FMaxGroupCount.Count > GroupIndex
  then MaxGroupCount:= StrToInt(FMaxGroupCount[GroupIndex])
  else MaxGroupCount:= FMax;

  GroupCount:= 0;
  S:= LowerCase(ExpandFileName(Filename));
  for I:= 0 to FFiles.Count -1
  do
    if (FFiles.Objects[I] = TObject(GroupIndex))
    then
      if (S = LowerCase(FFiles[I]))
      then Exit
      else Inc(GroupCount);

  while GroupCount >= MaxGroupCount
  do begin
    for I:= FFiles.Count -1 downto 0 
    do
      if (FFiles.Objects[I] = TObject(GroupIndex))
      then begin
        FFiles.Delete(I);
        Dec(GroupCount);
        Break;
      end;
  end;

  FFiles.InsertObject(0, Filename, TObject(GroupIndex));
  
  if FMaxGroupIndex < GroupIndex
  then FMaxGroupIndex:= GroupIndex;

  Save;
end;          

function TRecentFilesMenu2000.DoCheck(const Filename: String): Boolean;
begin
  if Assigned(FOnCheck)
  then begin
    Result:= True;
    FOnCheck(Self, Filename, Result);
  end
  else
    Result:= FileExists(Filename);
end;

procedure TRecentFilesMenu2000.DoClick;
var
  RemoveFromList: Boolean;
begin
  if Assigned(FOnClick)
  then begin
    RemoveFromList:= True;
    FOnClick(Self, FFiles[TMenuItem2000(Sender).Tag], RemoveFromList);

    if RemoveFromList
    then begin
      FFiles.Delete(TMenuItem2000(Sender).Tag);
      Save;
    end;
  end;
end;

procedure TRecentFilesMenu2000.CreateComponentItems(Items: TMenuItem2000;
  AddEmpty: Boolean);
var
  S, S1, S2, SC, CurrentDir: String;
  I, J, L1, L2, P, Index: Integer;
  M: TMenuItem2000;
begin
  // use current dir
  if (roUseCurrentDir in FRecentFilesMenuOptions)
  then begin
    if (FOpenDialog <> nil)
    and (FOpenDialog.FileName <> '')
    then
      CurrentDir:= FOpenDialog.FileName
    else
      CurrentDir:= ExpandFileName('a.txt');

    CurrentDir:= LowerCase(ExtractFilePath(CurrentDir));
  end;

  // start from separator
  if (roIncludeSeparator in FRecentFilesMenuOptions)
  and ((FFiles.Count > 0)
  or (roIncludeEmpty in FRecentFilesMenuOptions))
  then Items.Add(NewLine);

  Index:= 0;
  for I:= 0 to FMaxGroupIndex
  do begin
    for J:= 0 to FFiles.Count -1
    do
      if (FFiles.Objects[J] = TObject(I))
      and DoCheck(FFiles[J])
      then begin
        Inc(Index);
        S:= '';

        // show numbering
        if (roShowNumber in FRecentFilesMenuOptions)
        then
          if (Index < 10)
          then
            S:= '&' + IntToStr(Index) + ' '

          else
          if not (roShowLetter in FRecentFilesMenuOptions)
          then
            S:= IntToStr(Index) + ' '

          else begin
            if Index < Byte('Z') + 10
            then S:= '&' + Char(Index + Byte('A') -10) + ' ';
          end

        else
          if (roShowLetter in FRecentFilesMenuOptions)
          and (Index < Byte('Z'))
          then S:= '&' + Char(Index + Byte('A') -1) + ' ';

          
        // show shortcut
        if (roShowShortcut in FRecentFilesMenuOptions)
        and (S <> '')
        and (Index < 10)
        then SC:= 'Alt+' + S[2]
        else SC:= '';

        // show filename
        S1:= FFiles[J];

        if not (roShowExtension in FRecentFilesMenuOptions)
        then S1:= ChangeFileExt(S1, '');

        S2:= ExtractFilePath(S1);

        if (roUseCurrentDir in FRecentFilesMenuOptions)
        and (LowerCase(S2) = CurrentDir)
        then S1:= ExtractFileName(S1)

        else
        if (roShowReducedPath in FRecentFilesMenuOptions)
        then begin
          L2:= Length(S2);
          L1:= Length(S1) - L2;

          while (L2 > 7)
          and (L1 + L2 > MaxLength)
          do begin
            P:= Pos('...', S2) -1;
            if P < 1 then P:= Length(S2);
            if S2[P] = '\' then Dec(P);

            while (P > 0)
            and (S2[P] <> '\')
            do Dec(P);

            Delete(S2, P +1, MaxInt);
            S2:= S2 + '...\';

            L2:= Length(S2);
          end;

          S1:= S2 + ExtractFileName(S1);

          if Length(S1) > MaxLength
          then S1:= Copy(S1, 1, MaxLength -3) + '...';
        end
        else
        if not (roShowFullPath in FRecentFilesMenuOptions)
        then S1:= ExtractFilename(S1);

        // create item
        M:= NewItem(S + S1, 0, False, True, DoClick, 0, '');
        M.ShortCut:= SC;
        M.Tag:= J;
        Items.Add(M);
      end;

    if (Items.Count > 0)
    and (Items[Items.Count -1].Caption <> '-')
    then
      Items.Add(NewLine)

    else
    if (roIncludeEmpty in FRecentFilesMenuOptions)
    then begin
      Items.Add(NewItem(SEmptyCaption, 0, False, False, nil, 0, ''));
      Items.Add(NewLine);
    end;
  end;

  if (Items.Count > 0)
  and (Items[Items.Count -1].Caption = '-')
  then Items.Delete(Items.Count -1);

  if (roIncludeClear in FRecentFilesMenuOptions)
  and (FFiles.Count > 0)
  then begin
    Items.Add(NewLine);
    Items.Add(NewItem('Clear This List', 0, False, True, DoClear, 0, ''));
  end;
end;

function TRecentFilesMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Recent Files Items';
end;

procedure TRecentFilesMenu2000.UpdateComponentItems(Items: TMenuItem2000);
begin
  Items.Clear;
  CreateComponentItems(Items, True);
end;

function TRecentFilesMenu2000.Count: Integer;
begin
  Result:= FFiles.Count;
end;

procedure TRecentFilesMenu2000.DoClear(Sender: TObject);
begin
  Clear;
end;

function TRecentFilesMenu2000.GetFileGroup(
  const Filename: String): Integer;
var
  S: String;
  I: Integer;
begin
  Result:= -1;

  S:= LowerCase(ExpandFileName(Filename));
  for I:= 0 to FFiles.Count -1
  do
    if (S = LowerCase(FFiles[I]))
    then begin
      Result:= Integer(FFiles.Objects[I]);
      Exit;
    end;
end;

procedure TRecentFilesMenu2000.SetMaxGroupCount(const Value: TStrings);
begin
  FMaxGroupCount.Assign(Value);
end;

procedure TRecentFilesMenu2000.Loaded;
var
  F: TextFile;
  I, P: Integer;
  Filename, S: String;
  Reg: TRegistry;
begin
  inherited;

  if FSaveTo = stDontSave
  then Exit;

  InitializePath(FRegistry, FFilename);

  if FSaveTo = stFile
  then begin
    Filename:= StringReplace(FFilename, '$(MENU)', Name + '.recentfiles', []);
    if not FileExists(Filename)
    then Exit;

    AssignFile(F, Filename);
    Reset(F);

    while not Eof(F)
    do begin
      ReadLn(F, S);
      I:= Pos(':', S);
      P:= StrToInt(Copy(S, 1, I -1));

      FFiles.InsertObject(0, Copy(S, I +2, MaxInt), TObject(P));

      if FMaxGroupIndex < P
      then FMaxGroupIndex:= P;
    end;

    CloseFile(F);
  end
  else begin
    Reg:= TRegistry.Create;
    if Reg.OpenKey(StringReplace(FRegistry, '$(MENU)', Name, []), False)
    then begin
      for I:= 0 to Reg.ReadInteger('Count') -1
      do begin
        P:= Reg.ReadInteger(IntToStr(I) + '-Group');

        FFiles.InsertObject(0,
          Reg.ReadString(IntToStr(I) + '-FileName'),
          TObject(P));

        if FMaxGroupIndex < P
        then FMaxGroupIndex:= P;
      end;
    end;

    Reg.Free;
  end;
end;

procedure TRecentFilesMenu2000.Save;
var
  F: TextFile;
  I, Code: Integer;
  Filename, S: String;
  Reg: TRegistry;
begin
  if FSaveTo = stDontSave
  then Exit;

  InitializePath(FRegistry, FFilename);

  if FSaveTo = stFile
  then begin
    Filename:= StringReplace(FFilename, '$(MENU)', Name + '.recentfiles', []);
    S:= ExtractFilePath(Filename);
    Code:= GetFileAttributes(PChar(S));
    if ((Code = -1)
    or (FILE_ATTRIBUTE_DIRECTORY and Code = 0))
    and not CreateDirectory(PChar(S), nil)
    then Exit;

    AssignFile(F, Filename);
    Rewrite(F);

    for I:= FFiles.Count -1 downto 0
    do begin
      WriteLn(F, Integer(FFiles.Objects[I]), ': ', FFiles[I]);
    end;

    CloseFile(F);
  end
  else begin
    Reg:= TRegistry.Create;
    Reg.OpenKey(StringReplace(FRegistry, '$(MENU)', Name, []), True);

    Reg.WriteInteger('Count', FFiles.Count);
    for I:= FFiles.Count -1 downto 0
    do begin
      S:= IntToStr(FFiles.Count - I -1);
      Reg.WriteString(S + '-FileName', FFiles[I]);
      Reg.WriteInteger(S + '-Group', Integer(FFiles.Objects[I]));
    end;

    Reg.Free;
  end;
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
