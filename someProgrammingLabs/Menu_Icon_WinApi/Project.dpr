{
**** Создание пунктов меню со значками ****
** Реализовано на WinApi. Версия 1.0.0.0 **
********* Автор примера: Maks1509 *********
******** Дата создания: 25.05.2008 ********
********* Mail: maks1509@inbox.ru *********
}

program Project;

{$R Project.res}

uses
  Windows, Messages;

const
  RC_DIALOG = 101;

type
  TMenuItem = record
    text : String;
    icon : hIcon;
  end;

resourcestring
  StrMNum1 = 'Меню № 1';
  StrMNum2 = 'Меню № 2';
  StrMenu1 = 'Пункт меню № 1';
  StrMenu2 = 'Пункт меню № 2';
  StrMenu3 = 'Пункт меню № 3';

var
  MenuItems : array [1..3] of TMenuItem;
  hApp : Integer;

function MainDlgFunc(hWnd : hWnd; uMsg : DWORD; wParam, lParam : Integer) : Bool; stdcall;
var
  i : Integer;
  size : TSize;
  DC : hDC;
  hMainMenu, hSubMenu : hMenu;
  lpmis : ^TMeasureItemStruct;
  lpdis : ^TDrawItemStruct;
  item : ^TMenuItem;
begin
  Result := TRUE;
  case uMsg of

    WM_INITDIALOG:
      begin
        hApp := hWnd;
        MenuItems[1].icon := LoadImage(hInstance, MAKEINTRESOURCE(101), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        MenuItems[2].icon := LoadImage(hInstance, MAKEINTRESOURCE(102), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        MenuItems[3].icon := LoadImage(hInstance, MAKEINTRESOURCE(103), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        MenuItems[1].text := PChar(StrMenu1);
        MenuItems[2].text := PChar(StrMenu2);
        MenuItems[3].text := PChar(StrMenu3);
        hMainMenu := CreateMenu;
        hSubMenu := CreatePopupMenu;
        AppendMenu(hMainMenu, MF_STRING or MF_POPUP, hSubMenu, PChar(StrMNum1));
        AppendMenu(hSubMenu, MF_OWNERDRAW, 101, @MenuItems[1]);
        AppendMenu(hSubMenu, MF_OWNERDRAW, 102, @MenuItems[2]);
        AppendMenu(hSubMenu, MF_SEPARATOR, 0, nil);
        AppendMenu(hSubMenu, MF_OWNERDRAW, 103, @MenuItems[3]);
        hSubMenu := CreatePopupMenu;
        AppendMenu(hMainMenu, MF_STRING or MF_POPUP, hSubMenu, PChar(StrMNum2));
        AppendMenu(hSubMenu, MF_OWNERDRAW, 101, @MenuItems[1]);
        AppendMenu(hSubMenu, MF_OWNERDRAW, 102, @MenuItems[2]);
        SetMenu(hApp, hMainMenu);
      end;

    WM_CLOSE, WM_DESTROY:
      begin
        for i := 1 to 3 do if MenuItems[i].icon <> 0 then DeleteObject(MenuItems[i].icon);
        PostQuitMessage(0);
      end;

    WM_COMMAND :
      case LoWord(wParam) of
        101..103 : SendMessage(hApp, WM_CLOSE, Integer(TRUE), 0);
      end;

    WM_MEASUREITEM :
      case PDRAWITEMSTRUCT(lParam).CtlType of
        ODT_MENU :
          begin
            DC := GetDC(hApp);
            lpmis := Pointer(lParam);
            item := Pointer(lpmis.ItemData);
            GetTextExtentPoint32(DC, PChar(item.text), Length(item.text), size);
            lpmis.itemWidth := size.cx;
            lpmis.itemHeight := 20;
            ReleaseDC(hApp, DC);
          end;
      end;

    WM_DRAWITEM: 
      begin
        case PDRAWITEMSTRUCT(lParam).CtlType of
          ODT_MENU :
            begin
              lpdis := Pointer(LParam);
              item := Pointer(lpdis.ItemData);
              if (lpdis.itemState and ODS_SELECTED = ODS_SELECTED) then
              begin
                FillRect(lpdis.hDC, lpdis.rcItem, GetSysColorBrush(COLOR_HIGHLIGHT));
                SetBkMode(lpdis.hDC, TRANSPARENT);
                SetBkColor(lpdis.hDC, GetSysColor(COLOR_HIGHLIGHT));
                SetTextColor(lpdis.hDC, GetSysColor(COLOR_HIGHLIGHTTEXT));
                DrawIconEx(lpdis.hDC, lpdis.rcItem.Left + 3, (lpdis.rcItem.Top + lpdis.rcItem.Bottom - 16) div 2, item.icon, 0, 0, 0, 0, DI_NORMAL);
              end
              else
              begin
                FillRect(lpdis.hDC, lpdis.rcItem, GetSysColorBrush(COLOR_MENU));
                SetTextColor(lpdis.hDC, GetSysColor(COLOR_MENUTEXT));
              end;
              if (lpdis.itemState and ODS_GRAYED) <> 0 then
                begin
                  SetBkMode(lpdis.hDC, TRANSPARENT);
                  SetTextColor(lpdis.hDC, GetSysColor(COLOR_GRAYTEXT));
                end;
              DrawIconEx(lpdis.hDC, lpdis.rcItem.Left + 3, (lpdis.rcItem.Top + lpdis.rcItem.Bottom - 16) div 2, item.icon, 0, 0, 0, 0, DI_NORMAL);
              lpdis.rcItem.left := lpdis.rcItem.left + 25;
              SetBkMode(lpdis.hDC, TRANSPARENT);
              DrawText(lpdis.hDC, @item.text[1], - 1, lpdis.rcItem, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
            end;
        end;
      end;

  else
    Result := FALSE;
  end;
end;

begin
  DialogBox(hInstance, MAKEINTRESOURCE(RC_DIALOG), 0, @MainDlgFunc);
end.
