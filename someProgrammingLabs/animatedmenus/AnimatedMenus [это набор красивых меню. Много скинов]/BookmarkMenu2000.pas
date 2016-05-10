
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TBookmarkMenu2000 Component                     }
{                                                       }
{       Copyright © 1997-2001 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/tbookmarkmenu2000/
//

unit BookmarkMenu2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, ShellApi, am2000, am2000menuitem;

type
  TBrowserEvent = procedure(var Url: String; var OpenInBrowser: Boolean) of object;

  TBookmarkMenu2000 = class(TPopupMenu2000)
  private
    FOnClick: TBrowserEvent;

  protected
    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;

    procedure Click(Sender: TObject); virtual;

  published
    property OnClick: TBrowserEvent
      read FOnClick write FOnClick;

  end;



implementation

uses 
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;

{$R BookmarkMenu2000.res}



{ TBookmarkMenu2000 }

procedure TBookmarkMenu2000.CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean);
var
  BookmarkFile, S, S1: String;
  F: TextFile;
  CurItems, MI: TMenuItem2000;
  P: Integer;
  bmpFolder, bmpItem: HBitmap;
  Reg: TRegistry;

  function GetNetscapeDate(const Date: String): String;
  var
    I, Y, M, D, H, Mn, S, SC: Integer;
  begin
    Result:= '';

    try
      I:= StrToInt(Date);

      // get year
      Y:= 1970;
      repeat
        SC:= 365*24*60*60;
        if Y mod 4 = 0 then Inc(SC, 24*60*60);

        if I > SC
        then Dec(I, SC)
        else Break;

        Inc(Y);
      until False;

      // get month
      M:= 1;
      repeat
        case M of
          1, 3, 5, 7, 8, 10, 12: SC:= 31*24*60*60;
          2: if Y mod 4 = 0
             then SC:= 29*24*60*60
             else SC:= 28*24*60*60;
          4, 6, 9, 11: SC:= 30*24*60*60;
        end;

        if I > SC
        then Dec(I, SC)
        else Break;

        Inc(M);
      until False;

      // get day
      D:= 1;
      repeat
        SC:= 24*60*60;

        if I > SC
        then Dec(I, SC)
        else Break;

        Inc(D);
      until False;

      // get hour
      H:= 0;
      repeat
        SC:= 60*60;

        if I > SC
        then Dec(I, SC)
        else Break;

        Inc(H);
      until False;

      // get minute
      Mn:= 0;
      repeat
        SC:= 60;

        if I > SC
        then Dec(I, SC)
        else Break;

        Inc(Mn);
      until False;

      // get seconds
      S:= I;
      
      Result:= FormatDateTime('mmmm dd, yyyy, hh:nn:ss', EncodeDate(Y, M, D) + EncodeTime(H, Mn, S, 0));

    except
      Exit;
    end;
  end;

  function GetTextBetweenStrings(const SStart, SEnd: String): String;
  var
    P: Integer;
    STemp: String;
  begin
    Result:= '';
    P:= Pos(SStart, S);
    if P = 0 then Exit;

    STemp:= Copy(S, P + Length(SStart), MaxInt);
    P:= Pos(SEnd, STemp);
    Result:= Copy(STemp, 1, P -1);
  end;

begin
  // load bitmap resources
  bmpFolder:= LoadBitmap(hInstance, 'BMP_BM2000_FOLDER');
  bmpItem:= LoadBitmap(hInstance, 'BMP_BM2000_ITEM');

  // get bookmark filename
  Reg:= TRegistry.Create;
  if not Reg.OpenKey('\Software\Netscape\Netscape Navigator\Main', False)
  then begin
    Reg.Free;
    inherited;
    Exit;
  end;

  BookmarkFile:= Reg.ReadString('Install Directory') + '\Users\';

  if not Reg.OpenKey('\Software\Netscape\Netscape Navigator\biff', False)
  then begin
    Reg.Free;
    inherited;
    Exit;
  end;

  AppendStr(BookmarkFile, Reg.ReadString('CurrentUser') + '\bookmark.htm');
  Reg.Free;

  if not FileExists(BookmarkFile)
  then begin
    inherited;
    Exit;
  end;


  // load bookmarks
  AssignFile(F, BookmarkFile);
  Reset(F);

  // skip file header
  repeat
    ReadLn(F, S);
  until UpperCase(S) = '<DL><P>';

  // start scan
  MI:= nil;
  CurItems:= Items;
  while not EoF(F)
  do begin
    ReadLn(F, S);
    S1:= Trim(UpperCase(S));
    if (S1 = '') then Continue;

    // increase indent
    if S1 = '<DL><P>'
    then begin
      MI.Bitmap.Handle:= bmpFolder;
      CurItems:= MI;
      Continue;
    end;

    // decrease indent
    if S1 = '</DL><P>'
    then begin
      CurItems:= CurItems.Parent;
      Continue;
    end;

    // add item
    if Copy(S1, 1, 4) = '<DT>'
    then begin
      // create item
      MI:= TMenuItem2000.Create(Owner);

      // set bitmap
      if Pos('<H3', S1) <> 0
      then begin
        MI.Bitmap.Handle:= bmpFolder;
        MI.NumGlyphs:= 4;
      end;

      if Pos('<A', S1) <> 0
      then MI.Bitmap.Handle:= bmpItem;

      // remove <dt>
      P:= Pos('>', S);
      Delete(S, 1, P);

      // get caption
      MI.Caption:= GetTextBetweenStrings('>', '</');

      // get hint
      MI.Hint:= '';

      S1:= GetTextBetweenStrings('HREF="', '"');
      if S1 <> ''
      then begin
        MI.Hint:= S1 + #13;
        MI.OnClick:= Click;
      end;

      S1:= GetTextBetweenStrings('ADD_DATE="', '"');
      if (S1 <> '')
      and (S1 <> '0')
      then MI.Hint:= MI.Hint + 'Add date: ' + GetNetscapeDate(S1) + #13;

      S1:= GetTextBetweenStrings('LAST_VISIT="', '"');
      if (S1 <> '')
      and (S1 <> '0')
      then MI.Hint:= MI.Hint + 'Last visit: ' + GetNetscapeDate(S1) + #13;

      S1:= GetTextBetweenStrings('LAST_MODIFIED="', '"');
      if (S1 <> '')
      and (S1 <> '0')
      then MI.Hint:= MI.Hint + 'Last modified: ' + GetNetscapeDate(S1) + #13;

      MI.Hint:= Trim(MI.Hint);

      CurItems.Add(MI);
    end;

    // add separator
    if S1 = '<HR>'
    then begin
      MI:= am2000menuitem.NewLine;
      CurItems.Add(MI);
      Continue;
    end;
  end;

  CloseFile(F);
end;

function TBookmarkMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Netscape Bookmark Menu Items';
end;

procedure TBookmarkMenu2000.Click(Sender: TObject);
var
  Url: String;
  OpenInBrowser: Boolean;
begin
  with TMenuItem2000(Sender)
  do begin
    Url:= Copy(Hint, 1, Pos(#13, Hint) -1);
    OpenInBrowser:= True;

    if Assigned(FOnClick)
    then FOnClick(Url, OpenInBrowser);

    if OpenInBrowser
    then ShellExecute(0, 'open', PChar(Url), nil, nil, sw_ShowMaximized);
  end;
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
