
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TSystemMenu2000 Component                       }
{                                                       }
{       Copyright © 1997-2001 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/tsystemmenu2000/
//

unit SystemMenu2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  am2000, am2000menuitem;

type
  TSystemMenu2000 = class(TPopupMenu2000)
  protected
    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;

    procedure Loaded; override;

    procedure SystemMenuItemClick(Sender: TObject); 

  public
    destructor Destroy; override;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000cache, am2000options, am2000utils;


{ SystemMessageHook }

var
  SystemMessageHookCount: Integer = 0;
  HSystemMessageHook: HHook = 0;

function GetSystemMenu2000(hWnd: HWND): TSystemMenu2000;
var
  I: Integer;
  F: TForm;
begin
  F:= nil;
  Result:= nil;

  for I:= 0 to Screen.FormCount -1
  do
    if Screen.Forms[I].Handle = hWnd
    then begin
      F:= Screen.Forms[I];
      Break;
    end;

  if F = nil then Exit;

  for I:= 0 to F.ComponentCount -1
  do
    if F.Components[I] is TSystemMenu2000
    then begin
      Result:= TSystemMenu2000(F.Components[I]);
      Exit;
    end;
end;

function SystemMessageHook(Code, wParam, lParam: Integer): Integer; stdcall;
var
  M: TMsg;
  Msg: Integer;
  SystemMenu: TSystemMenu2000;
  P: TPoint;

  procedure ClearMessage;
  begin
    FillChar(PMsg(lParam)^, SizeOf(TMsg), 0);
  end;

begin
  Result:= 0;

  if (Code >= 0)
  then begin
    M:= PMsg(lParam)^;
    Msg:= M.Message;

    // popup systemmenu
    if ((Msg = wm_NCLButtonDown) and (M.wParam = htSysMenu))
    or ((Msg = wm_NCRButtonUp) and ((M.wParam = htCaption) or (M.wParam = htSysMenu)))
    then begin
      SystemMenu:= GetSystemMenu2000(M.hwnd);
      if (SystemMenu <> nil)
//      and (SystemMenu.Owner is TWinControl)
//      and (TWinControl(SystemMenu.Owner).Handle = M.hwnd)
      then begin
        if (Msg = wm_NCLButtonDown)
        and (SystemMenu.FormOnScreen)
        and (SystemMenu.Options.Animation = anSmart)
        then begin
          KillActivePopupMenu2000(True, True);
          ClearMessage;
          Exit;
        end;

        if (Msg = wm_NCLButtonDown)
        and (SystemMenu.Owner is TForm)
        then
          with TForm(SystemMenu.Owner).ClientOrigin
          do
            P:= Point(X -1, Y -1)
        else
          P:= Point(LongRec(M.lParam).Lo, LongRec(M.lParam).Hi);

        if (Msg = wm_NCLButtonDown)
        then SystemMenu.Options.Animation:= anSmart
        else SystemMenu.Options.Animation:= anPopup;

        SystemMenu.PopupAsync(P.X, P.Y);
        ClearMessage;
        Exit;
      end;
    end;

    // cancel wm_NCRButtonDown message
    if (Msg = wm_NCRButtonDown)
    and ((M.wParam = htCaption) or (M.wParam = htSysMenu))
    then begin
      ClearMessage;
      Exit;
    end;
  end;

  Result:= CallNextHookEx(HSystemMessageHook, Code, wParam, lParam);
end;


{ TSystemMenu2000 }

destructor TSystemMenu2000.Destroy;
begin
  Dec(SystemMessageHookCount);
  if SystemMessageHookCount = 0
  then UnhookWindowsHookEx(HSystemMessageHook);

  inherited;
end;

procedure TSystemMenu2000.Loaded;
begin
  inherited;

  if HSystemMessageHook = 0
  then HSystemMessageHook:= SetWindowsHookEx(wh_GetMessage, @SystemMessageHook, 0, GetCurrentThreadID);
  Inc(SystemMessageHookCount);
end;

procedure TSystemMenu2000.CreateComponentItems(Items: TMenuItem2000;
  AddEmpty: Boolean);
var
  F: TForm;
  Enabled: Boolean;

  procedure AddItem(ACaption, AShortCut, ABitmap: String; AEnabled, ADefault: Boolean;
    ACommand: Integer);
  var
    MI: TMenuItem2000;
  begin
    MI:= NewItem2000(ACaption, AShortCut, False, AEnabled, SystemMenuItemClick, 0, '');
    MI.Default:= ADefault;
    MI.Tag:= ACommand;
    if ABitmap <> ''
    then begin
      MI.Bitmap.Width:= 16;
      MI.Bitmap.Height:= 16;
      MenuItemCache.Draw(MI.Bitmap.Canvas, 0, 0, ABitmap, clBtnShadow, clBtnHighlight, clBtnHighlight, True, 0);
    end;
    Items.Add(MI);
  end;

begin
  if not (Owner is TForm) then Exit;
  F:= TForm(Owner);        

  if F.BorderStyle in [bsSingle, bsSizeable]
  then begin
    Enabled:= (F.WindowState <> wsNormal) and (biMaximize in F.BorderIcons);
    AddItem('&Restore', '', SSystemRestore, Enabled, False, sc_Restore);
  end;

  Enabled:= (F.WindowState = wsNormal);
  AddItem('&Move', '', SSystemMove, Enabled, False, sc_Move);

  if F.BorderStyle in [bsSingle, bsSizeable, bsSizeToolwin]
  then begin
    Enabled:= (F.BorderStyle in [bsSizeable, bsSizeToolWin])
      and (F.WindowState = wsNormal);
    AddItem('&Size', '', SSystemSize, Enabled, False, sc_Size);
  end;

  if F.BorderStyle in [bsSingle, bsSizeable]
  then begin
    Enabled:= (F.WindowState <> wsMinimized) and (biMinimize in F.BorderIcons);
    AddItem('Mi&nimize', '', SSystemMinimize, Enabled, False, sc_Minimize);

    Enabled:= (F.WindowState <> wsMaximized) and (biMaximize in F.BorderIcons);
    AddItem('Ma&ximize', '', SSystemMaximize, Enabled, False, sc_Maximize);
    
    Items.Add(NewLine);
  end;

  if (Owner is TCustomForm)
  and (TForm(Owner).FormStyle = fsMdiChild)
  then begin
    AddItem('&Close', 'Ctrl+F4', SSystemClose, True, True, sc_Close);
    AddItem('-', '', '', True, True, sc_Separator);
    AddItem('&Next', 'Ctrl+F6', '', True, False, sc_NextWindow);
  end
  else
    AddItem('&Close', 'Alt+F4', SSystemClose, True, True, sc_Close);
end;

function TSystemMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'System Menu Items';
end;

procedure TSystemMenu2000.SystemMenuItemClick(Sender: TObject);
begin
  if Owner is TForm
  then PostMessage(TForm(Owner).Handle, wm_SysCommand, TComponent(Sender).Tag, 0);
end;


initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
