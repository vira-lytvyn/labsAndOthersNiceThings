program iconcut;
(******************************************************************************)
(*  Author : Sergey Stolyarov                                                 *)
(*  E-Mail : cancel@ok.ru                                                     *)
(*  Web    : http://www.developer.nm.ru/                                      *)
(*                                                                            *)
(*  Russia,  Novosibirsk  State University                                    *)
(*  Программа для извлечения пиктограмм из выполнимых файлов (exe, dll, ocx)  *)
(******************************************************************************)
{$R lv_.res}


uses windows,
  messages,
  ic_unit,//модуль с функциями, специфичными для данной программы
  commctrl,
  commdlg,
  moreapi,//модуль с дополнительными функциями
  shellApi;
const
  idm_save = 101;
  idm_loadfile = 100;
  idm_chDir = 104;
  idm_quit = 105;
  idm_folder = 106;
  idm_copy = 107;
  idm_help = 108;
  idlb_files = 150;
  dwTBStyles = ws_child or ws_visible or ws_clipsiblings or ccs_top or  ccs_nodivider or tbstyle_tooltips or tbstyle_flat or ws_border;
//  time_pause = 2000;

var

MainWnd, lv, wndTB, himlLarge, lbFiles, wndStatus : THandle;
            imlBtns : THandle;
              wc : TWndClassEx;
            Mesg : TMsg;
title, outputDir, curInputDir : String;
           oldLV : Pointer;//указатель на "старую" оконную функцию списка
            path : Array[0..max_path] of char;
             lvi : TLVItemA;
             tbb : Array[0..7] of TTBButton; //массив кнопок панели инструментов
procedure rebuild(param : PChar);forward;


function DialogFunc(wnd:HWND; Msg : Integer; Wparam:Wparam; Lparam:Lparam):Lresult; stdcall;
Begin
 case msg of
wm_command :
  case loword(wParam) of
   1 : DestroyWindow(wnd);
  End;
 end;
  Result:=1;//DefWindowProc(wnd,msg,wParam,lParam);
End;



function WindowProc(wnd:HWND; Msg : Integer; Wparam:Wparam; Lparam:Lparam):Lresult; stdcall;
var
       p : PChar;
  i, cnt : integer;
    icon : THandle;
       s : string;
     pmm :  PMinMaxInfo;
    pnmh : PNMHdr;
    pttt : PToolTipText;
    r : TRect;

Begin
case msg of
wm_timer :
  Begin
    s:='Текущий каталог : '+curInputDir;
    SendMessage(wndStatus,sb_settext,0,Integer(@s[1]));
    KillTimer(wnd,100);
  End;
wm_notify :
  Begin
    pnmh:=PNMHdr(lParam);

    if pnmh^.code=TTN_NeedText then begin
      pttt:=PToolTipText(Lparam);
      i:=pttt^.hdr.idFrom;
      case i of
        idm_loadFile : p:='Сменить исходный каталог';
        idm_save : p:='Сохранить выбранную пиктограмму';
        idm_folder : p:='Сменить выходной каталог';
        idm_quit : p:='Выход из программы';
        idm_copy : p:='Копировать в буфер';
        idm_help : p:='О программе';
      else p:='';
      end;{case}
      pttt^.lpszText:=p;
    end;
  result:=0;
  End;

wm_command :
    case loword(wParam) of
    idlb_files :
      case hiWord(wParam) of
       lbn_dblclk :
      Begin
        GetMem(p,255);
        i:=SendMessage(lbFiles,lb_getCurSel,0,0);
        SendMessage(lbFiles,lb_gettext,i,Integer(p));
        s:=CurInputDir+'\'+p+#0;
//        SetTimer(wnd,100,5,nil);
        Rebuild(@s[1]);
        FreeMem(p,255);
      End;
      end;
    idm_folder :
      Begin
        s:=SelectFolder(wnd,nil,'Выберите папку, в которую будут помещаться выбранные вами пиктограммы', outputDir,true);
        if s <> '' then outputDir:=s else ;
        result:=0;
      End;
    idm_help :
      Begin
       // DialogBox(hInstance,PChar(500),Wnd,@DialogFunc);
        MessageBox(wnd,'Icon Extractor'#13#10#13#10'Автор : Сергей Столяров'#13#10'E-Mail : cancel@ok.ru'#13#10'Web-site : http://www.developer.nm.ru'#13#10#13#10#13#10'Программа предназначена для извлечения значков '#13#10'(пиктограмм) из исполнимых файлов, также '#13#10'поддерживается копирование значка в буфер обмена','О программе',mb_ok or mb_iconquestion);
      End;

    idm_save :
      Begin
       cnt:=ListView_GetItemCount(lv);
       for i:=0 to cnt do
         if ListView_GetItemState(lv,i,lvis_selected) = lvis_selected then  break;
        SetTimer(wnd,100,time_pause,nil);
       i:=cnt-i-1;
       icon:=ImageList_GetIcon(himlLarge,i,0);
       str(i,s);
       s:=title+'_'+s+'.ico'+#0;
       s:=MakeFullName(OutputDir,s)+#0;
      try
       SaveIcon(icon,s);
       SendMessage(wndStatus,sb_settext,sbt_noborders,Integer(@s[1]));
       SetTimer(wnd,100,time_pause,nil);
      except
       SendMessage(wndStatus,sb_settext,sbt_noborders,Integer(PChar('Ошибка!')));
       SetTimer(wnd,100,time_pause,nil);

//       say(wnd,'Error')
      end;
       setfocus(lv);
       result:=0;
      End;

    idm_quit :   begin  DestroyWindow(wnd); result:=0; end;

    idm_loadfile :
    begin
        s:=SelectFolder(wnd,nil,'Выберите папку, из которой будут выбираться файлы', CurInputDir,true);
        if s <> '' then begin
          CurInputDir:=s;
          SendMessage(wndStatus,sb_settext,sbt_noborders,Integer(@curInputDir[1]));
          AddFiles(lbFiles,CurInputDir);//Добавление файлов в список из каталога curInputDir
         end  else ;
        result:=0;
       result:=0;
    end;

   idm_copy :
    begin
       cnt:=ListView_GetItemCount(lv);
       for i:=0 to cnt do
         if ListView_GetItemState(lv,i,lvis_selected) = lvis_selected then  break;

       i:=cnt-i-1;
       icon:=ImageList_GetIcon(himlLarge,i,0);
       CopyToClipboard(wnd,icon);
    end;


    end;{case wm_command}


wm_getminmaxinfo :
  Begin
    pmm:=PMinMaxInfo(lParam);
    pmm^.ptMinTrackSize.x:=400;
    pmm^.ptMinTrackSize.y:=400;
    result:=0;
  End;



wm_size :
  Begin
    GetWindowRect(wndStatus,r);
    MoveWindow(lbFiles,1,40,150,hiWord(lParam)-40-(r.bottom-r.top),true);
    MoveWindow(lv,150,40,loWord(lParam)-150,hiWord(lParam)-40-(r.bottom-r.top),true);
    SendMessage(wndTB, tb_autosize, 0, 0);
    SendMessage(wndStatus, wm_size, 0, 0);
    result:=0;
  End;
wm_destroy :
  Begin
   postquitmessage(0);
   Result:=0;
   exit;
  End;

else Result:=DefWindowProc(wnd,msg,wparam,lparam);
end;

End;


procedure rebuild(param : PChar);
var
  icon : THandle;
 i,j,k : integer;
ss, s : string;
     p : PChar;

begin
getMem(p,max_path+1);

GetFileTitle(param,p,max_path);
s:=p;
freemem(p,max_path+1);
//say(mainWnd,p);

k:=pos('.',s);
if k=0 then title:=s else title:=copy(s,0,k-1);


i:=0;
icon := ExtractIcon(hInstance,param,0);

if icon=0 then MessageBox(mainWnd,'Файл не содержит пиктограмм','Ошибка',mb_ok or mb_iconexclamation)
else
  Begin
  SendMessage(wndStatus,sb_settext,sbt_noborders,Integer(param));
  SetTimer(mainwnd,100,2000,nil);

  s:='Icon Cut ['+s+']'+#0;
  SetWindowText(Mainwnd,@s[1]);
  imageList_destroy(himlLarge);
  himlLarge := ImageList_Create(GetSystemMetrics(SM_CXICON), GetSystemMetrics(SM_CYICON), 1, 1, 1);

  ListView_DeleteAllItems(lv);

  while icon <> 0 do begin
    inc(i);
    ImageList_AddIcon(himlLarge, icon);
    icon := ExtractIcon(hInstance,param,i);

  end;

ListView_SetImageList(LV, himlLarge, LVSIL_NORMAL);


lvi.mask := LVIF_TEXT or LVIF_IMAGE or LVIF_PARAM or LVIF_STATE;
lvi.state := 0;

if (i<>0) or (icon<>0) then
begin
  for j:=0  to i-2 do
   begin
    lvi.iImage := j;
    str(j,ss);
    s := title+'_'+ss+#0;
    lvi.pszText := @s[1];
    lvi.lParam:=j;
    ListView_InsertItem(LV, lvi);
   end;
    j:=i-1;
    lvi.iImage := j;
    lvi.state:=lvis_selected;
    str(j,ss);
    s := title+'_'+ss+#0;
    lvi.pszText := @s[1];
    lvi.lParam:=j;
    ListView_InsertItem(LV, lvi);

end;

InvalidateRect(lv,nil,true);
end;
end;


function LVProc(wnd:HWND; Msg : Integer; Wparam:Wparam; Lparam:Lparam):Lresult; stdcall;
var pt : TPoint;
Begin
case msg of
 wm_rbuttonDown :
   begin
     Result:=CallWindowProc(oldLV,wnd,wm_lbuttonDown,wParam, lParam);
     setfocus(wnd);
     pt.x:=loword(lParam);
     pt.y:=hiWord(lParam);
     ClientToScreen(wnd,pt);
   end;
else Result:=CallWindowProc(oldLV,wnd,msg,wParam,lParam);
end;

End;

var xPos,yPos,nWidth,nHeight : Integer;
     Font : THandle;
begin


InitCommonControls;
font:=GetStockObject(ansi_var_font);

wc.cbSize:=sizeof(wc);
wc.style:=cs_hredraw or cs_vredraw;
wc.lpfnWndProc:=@WindowProc;
wc.cbClsExtra:=0;
wc.cbWndExtra:=0;
wc.hInstance:=HInstance;
wc.hIcon:=LoadIcon(HInstance,PChar(100));
wc.hCursor:=LoadCursor(0,idc_arrow);
wc.hbrBackground:=COLOR_BTNFACE+1;
wc.lpszMenuName:=nil;
wc.lpszClassName:='listview : demo';

//fsdf
RegisterClassEx(wc);

xPos:=20;
yPos:=20;
nWidth:=600;
nHeight:=300;


MainWnd:=CreateWindowEx(0,'listview : demo',
'List View Demo',
ws_overlappedwindow,
xPos,yPos,nWidth,nHeight,0,0,
Hinstance,nil);

{создание окна списка}
lv:=CreateWindowEx(ws_ex_clientedge
,WC_LISTVIEW,
'',
lvs_singlesel or lvs_icon or ws_child or ws_visible or ws_border or LVS_SHOWSELALWAYS	,
0,0,300,200,mainWnd,110,
Hinstance,nil);


getCurrentDirectory(255,path);
OutputDir:=path;

{Далее заполняем массив кнопок панели инструментов}
tbb[0].iBitmap:=0;
tbb[0].idCommand:=idm_loadfile;
tbb[0].fsState:=tbstate_ellipses;
tbb[0].fsStyle:=tbstyle_sep;


tbb[1].iBitmap:=0;
tbb[1].idCommand:=idm_loadfile;
tbb[1].fsState:=tbstate_enabled;
tbb[1].fsStyle:=tbstyle_button;

tbb[2].iBitmap:=1;
tbb[2].idCommand:=idm_save;
tbb[2].fsState:=tbstate_enabled;
tbb[2].fsStyle:=tbstyle_button;

tbb[3].iBitmap:=2;
tbb[3].idCommand:=idm_folder;
tbb[3].fsState:=tbstate_enabled;
tbb[3].fsStyle:=tbstyle_button;

tbb[4].iBitmap:=3;
tbb[4].idCommand:=idm_copy;
tbb[4].fsState:=tbstate_enabled;
tbb[4].fsStyle:=tbstyle_button;


tbb[5].iBitmap:=0;
tbb[5].idCommand:=0;
tbb[5].fsState:=tbstate_ellipses;
tbb[5].fsStyle:=tbstyle_sep;

tbb[6].iBitmap:=5;
tbb[6].idCommand:=idm_help;
tbb[6].fsState:=tbstate_enabled;
tbb[6].fsStyle:=tbstyle_button;

//tbb[6]:=tbb[5];

tbb[7].iBitmap:=4;
tbb[7].idCommand:=idm_quit;
tbb[7].fsState:=tbstate_enabled;
tbb[7].fsStyle:=tbstyle_button;


{создание панели инструментов}
wndTB:=CreateToolBarEx(mainWnd,dwTBStyles,
1,//идентификатор панели
6,//число картинок кнопок, расположенных подряд в bitmap
hInstance,
200,//LoadBitmap(hInstance,PChar(200)),//идентификатор ресурса картинки с кнопкамиы
@tbb[0],//указатель на первый элемент массива кнопок
8,//число кнопок
24,24,24,24,//размеры кнопок (здесь равны нулю т.к. используем стандартные картинки)
sizeOf(TTBButton));

rebuild('shell32.dll');

imlBtns := ImageList_Create(GetSystemMetrics(SM_CXICON), GetSystemMetrics(SM_CYICON), 1, 1, 1);
ImageList_AddIcon(imlBtns,LoadIcon(hInstance,PChar(110)));
ImageList_AddIcon(imlBtns,LoadIcon(hInstance,PChar(120)));
ImageList_AddIcon(imlBtns,LoadIcon(hInstance,PChar(130)));
ImageList_AddIcon(imlBtns,LoadIcon(hInstance,PChar(140)));
ImageList_AddIcon(imlBtns,LoadIcon(hInstance,PChar(150)));
ImageList_AddIcon(imlBtns,LoadIcon(hInstance,PChar(160)));


SendMessage(wndTB,tb_SetImageList,0,imlBtns);

lbFiles:=CreateWindowEx(ws_ex_clientedge,
'listbox',
'',
lbs_sort or ws_child or ws_visible or ws_border or lbs_nointegralheight or ws_vscroll or lbs_notify,
0,40,150,200,mainWnd,idlb_files,
Hinstance,nil);
SendMessage(lbFiles,wm_setfont,font,0);
GetDir(0,CurInputDir);

AddFiles(lbFiles,CurInputDir);

wndStatus :=CreateStatusWindow(sbars_sizegrip or ws_child or ws_visible,'Готово',mainWnd,2);
(*CreateWindowEx(
        0,                       // no extended styles
        STATUSCLASSNAME,         // name of status window class
        nil,          // no text when first created
        SBARS_SIZEGRIP or         // includes a sizing grip
        WS_CHILD or ws_visible
        ,                // creates a child window
        0, 0, 0, 0,              // ignores size and position
        MainWnd,              // handle to parent window
        1,       // child window identifier
        hinstance,                   // handle to application instance
        nil);                   // no window creation data
  *)


ShowWindow(MainWnd,CmdShow);
setfocus(lv);

{заменяем оконную процедуру списка на свою}
oldLV:=Pointer(SetWindowLong(LV,gwl_wndproc,Integer(@LVProc)));



While GetMessage(Mesg,0,0,0) do
 begin
  TranslateMessage(Mesg);
  DispatchMessage(Mesg);
 end;

end.
