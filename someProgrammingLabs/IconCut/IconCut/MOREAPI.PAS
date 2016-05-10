unit moreapi;

interface
uses Windows, shlobj, commdlg, messages;


Function OpenFileName(wndOwner : THandle; szFilter, szCustFilter : PChar; dwFlags : Integer) : String;
procedure Say (wnd : THandle; msg : Pchar);
function SelectFolder(wnd : THandle; Text, Title : PChar; OutPutDir : String; showPath : Bool) : String;
function MakeFullName(dir,name : String) : String;

implementation
var txt, dir : Pchar;
index : Integer;

function SHCallBack(hwnd : THandle; msg : Integer; wParam, lParam : Integer): Integer; stdcall;
var p : Array[0..255] of char;
begin
  case msg of
  BFFM_SELCHANGED :
    Begin

      SHGetPathFromIDList(PITEMIDLIST(wParam),p);
//    SetDlgItemText(hwnd,14147,p);
      SendMessage(hwnd,BFFM_SETSTATUSTEXT,0, Integer(@p[0]));
    End;
  BFFM_INITIALIZED :
    Begin
      SendMessage(hwnd,BFFM_SETSTATUSTEXT,0, Integer(Txt));
      SendMessage(hwnd,BFFM_SETSELECTION,1,Integer(Dir));
    End;
  end;
  result:=0;
end;

function MakeFullName(dir,name : String) : String;
Begin
  if Length(dir)<3 then
   begin
     Result:='';
     Exit;
   end;
  if dir[length(dir)] = '\' then Result:=dir+name
  else Result:=dir+'\'+name;

End;

function SelectFolder(wnd : THandle; Text, Title : PChar; OutPutDir : String; showPath : Bool) : String;
var
  pidlRoot, resPIDL : PITEMIDLIST ;
  tbi : TBrowseInfoA;
  name, path : Array[0..max_path] of char;

begin
 txt:=Text;
 dir:=@OutPutDir[1];

 SHGetSpecialFolderLocation(wnd, CSIDL_DRIVES,PidlRoot);

 tbi.pidlRoot:=PidlRoot;
 tbi.lpszTitle:=title;
if (text<>nil) or showPath then  tbi.ulFlags:=BIF_RETURNONLYFSDIRS or BIF_STATUSTEXT
 else  tbi.ulFlags:=BIF_RETURNONLYFSDIRS;

 tbi.lpfn:=@SHCallBack;
 tbi.hwndOwner:=wnd;
 tbi.pszDisplayName:=name;;

  ResPIDL:=SHBrowseForFolder(tbi);

 if ResPIDL <> nil then begin
   SHGetPathFromIDList(ResPIDL,path);
   Result:=Path;
 end
   else Result:='';

end;



Procedure Say (wnd : THandle; msg : Pchar);
begin
MessageBox(wnd, msg, 'Applicaton', mb_ok)
end;


Function OpenFileName(wndOwner : THandle; szFilter, szCustFilter : PChar; dwFlags : Integer) : String;
var ofn : TOpenFileName;
     szFile, title : Array[0..260] of char;
     
begin

  if szFilter=nil then szFilter:='Все файлы (*.*)'#0'*.*'#0;

  ofn.lStructSize:=sizeOf(TOpenFileName);
  ofn.hWndOwner:=wndOwner;
  ofn.hInstance:=hInstance;

  ofn.lpstrFilter:=szFilter;
  ofn.lpstrCustomFilter:=szCustFilter;
  ofn.nMaxCustFilter:=3;
  ofn.nFilterIndex:=index;

  ofn.lpstrFile:=szFile;
  ofn.nMaxFile:=261;

  ofn.lpstrTitle:=nil;

  ofn.lpstrFileTitle:=title;
  ofn.nMaxFileTitle:=261;

  ofn.lpstrInitialDir:=nil;
  ofn.Flags:=OFN_PATHMUSTEXIST or OFN_FILEMUSTEXIST or OFN_HIDEREADONLY or OFN_LONGNAMES  or dwFlags;
  ofn.nMaxFileTitle:=0;
  

  if GetOpenFileName(ofn) then result:=szFile else result:='';
{case   ofn.nFilterIndex of
 0 : say(wndOwner,'0');
 1 : say(wndOwner,'1');
 2 : say(wndOwner,'2');
end;}
index:=ofn.nFilterIndex;

end;



begin
index:=0;
end.
