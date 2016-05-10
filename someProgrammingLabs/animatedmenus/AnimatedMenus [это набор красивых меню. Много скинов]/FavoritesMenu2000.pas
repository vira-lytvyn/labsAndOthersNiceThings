
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TFavoritesMenu2000 Component                    }
{                                                       }
{       Copyright © 1997-2000 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/tfavoritesmenu2000/
//

unit FavoritesMenu2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, IniFiles, ShellApi, am2000, am2000menuitem;

type
  TBrowserEvent = procedure(var Url: String; var OpenInBrowser: Boolean) of object;

  TFavoritesMenu2000 = class(TPopupMenu2000)
  private
    nFolder, nPage: Integer;
    FShowIcons: Boolean;
    FMaxWidth: Integer;
    FOnClick: TBrowserEvent;

    function GetName(S: String): String;

  protected
    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure ReadFromFolder(Items: TMenuItem2000; Folder: String);
    procedure Click(Sender: TObject);

  published
    property ShowIcons : Boolean       read FShowIcons write FShowIcons default True;
    property MaxWidth  : Integer       read FMaxWidth  write FMaxWidth  default 30;

    property OnClick   : TBrowserEvent read FOnClick   write FOnClick;

  end;


implementation

uses 
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{$R FavoritesMenu2000.res}



{ TFavoritesMenu2000 }

constructor TFavoritesMenu2000.Create(AOwner: TComponent);
begin
  inherited;
  FShowIcons:= True;
  FMaxWidth:= 30;
end;

procedure TFavoritesMenu2000.CreateComponentItems;
var
  Reg: TRegistry;
begin
  nFolder:= 0;
  nPage:= 0;

  Reg:= TRegistry.Create;
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False) then
    ReadFromFolder(Items, Reg.ReadString('Favorites'));
  Reg.Free;

  inherited;

end;

function TFavoritesMenu2000.GetName(S: String): String;
begin
  Result:= Copy(S, 1, Length(S) -4);

  if Length(Result) > FMaxWidth then
    Result:= Copy(Result, 1, FMaxWidth) + '...';

  if Result = UpperCase(Result) then
    Result:= Result[1] + LowerCase(Copy(Result, 2, MaxInt));
end;

procedure TFavoritesMenu2000.ReadFromFolder(Items: TMenuItem2000; Folder: String);
var
  I, C, Res: Integer;
  SI: TSearchRec;
  S: TStringList;
  M: TMenuItem2000;
  F: TIniFile;
begin
  if Folder[Length(Folder)] <> '\' then AppendStr(Folder, '\');
  C:= Items.Count;
  S:= TStringList.Create;
  S.Sorted:= True;

  // directories
  Res:= FindFirst(Folder + '*.*', faDirectory, SI);
  while Res = 0 do begin
    if (SI.Attr and faDirectory <> 0)
    and (SI.Name[1] <> '.') then
      S.Add(SI.Name);
    Res:= FindNext(SI);
  end;
  FindClose(SI);

  // add sorted directories
  for I:= 0 to S.Count -1 do begin
    M:= am2000menuitem.NewItem(S[I], 0, False, True, nil, 0, '');
    M.Bitmap.Handle:= LoadBitmap(Hinstance, 'BMP_PL2000_FAVORITESFOLDER');
    Items.Insert(Items.Count - C, M);
    ReadFromFolder(M, Folder + S[I]);
  end;

  S.Clear;
  // files
  Res:= FindFirst(Folder + '*.url', faAnyFile, SI);
  while Res = 0 do begin
    if SI.Attr and (faDirectory + faVolumeID) = 0 then
      S.Add(SI.Name);
    Res:= FindNext(SI);
  end;
  FindClose(SI);

  // add sorted files
  for I:= 0 to S.Count -1 do begin
    F:= TIniFile.Create(Folder + S[I]);
    M:= am2000menuitem.NewItem(GetName(S[I]), 0, False, True, Click, 0, '');
    M.Bitmap.Handle:= LoadBitmap(Hinstance, 'BMP_PL2000_FAVORITESPAGE');
    M.Hint:= Copy(S[I], 1, Length(S[I]) -4) + #13 + F.ReadString('InternetShortcut', 'URL', '');
    Items.Insert(Items.Count - C, M);
    F.Free;
  end;

  if Items.Count = 0
  then Items.Add(am2000menuitem.NewItem('( Empty )', 0, False, False, nil, 0, ''));

  S.Free;
end;

procedure TFavoritesMenu2000.Click(Sender: TObject);
var
  Url: String;
  OpenInBrowser: Boolean;
begin
  with TMenuItem2000(Sender)
  do begin
    Url:= Copy(Hint, Pos(#13, Hint) +1, MaxInt);
    Url:= Copy(Url, 1, Pos(#13, Url) -1);
    OpenInBrowser:= True;

    if Assigned(FOnClick)
    then FOnClick(Url, OpenInBrowser);

    if OpenInBrowser
    then ShellExecute(0, 'open', PChar(Url), nil, nil, sw_ShowMaximized);
  end;
end;

function TFavoritesMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Favorites Menu Items';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
