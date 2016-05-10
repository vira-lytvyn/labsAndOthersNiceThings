unit ic_unit;

interface
uses windows, graphics, messages, sysutils, moreapi;

function intToStr(n : LongInt) : shortstring;
function saveIcon(icn : THandle; name : string):Bool;
function copyToClipboard(wnd,icon : THandle) : Bool;
function AddFiles (lb: THandle; dir : String): Bool;

const time_pause = 1000;
implementation
const
  shell32 = 'shell32.dll';
  cctrl = 'comctl32.dll';

function AddFiles(lb : THandle; dir : String): Bool;
var ffd : TWin32FindDataA;
    hFile : THandle;
    s : String;
Begin
  s:=dir+'\*.*'#0;
  hFile:=FindFirstFile(@s[1],FFD);
  if hFile<>Invalid_Handle_Value then begin
  SendMessage(lb,lb_resetContent,0,0);
  repeat
    s:=FFD.cFileName;
    s:=lowerCase(s);
    s:=s+#0;
    if (FFD.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) =0 then  SendMessage(lb,lb_addString,0,Integer(@s[1]));
  until not(FindNextFile(hFile, FFD));
  Result:=true;
  end
  else   Result:=false;


End;


function saveIcon(icn : THandle; name : string):Bool;
var icon : TIcon;
begin
  icon:=TIcon.Create;
  icon.Handle:=icn;

  try
   icon.SaveToFile(name);
  except
    MessageBox(0,'Невозможно сохранить файл', 'Ошибка!', mb_ok or mb_iconExclamation);
  end;
  icon.free;
Result:=true;

end;



function intToStr(n : LongInt) : shortstring;
var s : shortString;
begin
  str(n,s);
  s:=s+#0;
  result:=s;
end;


function copyToClipboard(wnd,icon : THandle) : Bool;
var dc, hbm, oldBm, bmDC : THandle;
Begin
  dc:=GetDC(wnd);
   bmDC:=CreateCompatibleDC(dc);
  ReleaseDC(wnd,dc);

  hbm:=CreateBitmap(32,32,1,16,nil);
  oldBm:=SelectObject(bmDC,hbm);

  PatBlt(bmDC,0,0,32,32,blackness);
  DrawIcon(bmDC,0,0,icon);
//Ellipse(bmDC,0,0,10,10);
  SelectObject(bmDC,oldBM);

  OpenClipboard(wnd);
  EmptyClipboard;
  SetClipboardData(CF_BITMAP,hbm);

  CloseClipboard;

  DeleteDC(bmDC);
//  DeleteObject(hbm);
Result:=true;
End;


end.
