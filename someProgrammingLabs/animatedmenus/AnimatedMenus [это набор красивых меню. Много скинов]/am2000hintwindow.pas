
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_HintWindow Component Unit              }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000hintwindow;

interface

uses
  Windows, Messages, Controls;

type
  // T_AM2000_HintWindow
  T_AM2000_ToolTipWindow = class
  private
    id: UINT;
    Owner: TWinControl;
    hwndOwner: HWND;
    hwndToolTip: HWND;
    FActive: Boolean;

  public
    property Active: Boolean read FActive;

    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;

    procedure AddTool(R: TRect; Hint: String);
    procedure AddWindowTool(C: TWinControl; Hint: String);
    procedure RelayMouseMove(Pos: TSmallPoint);
    procedure RelayWindowMouseMove(Pos: TSmallPoint; hwnd: HWND);
    procedure Clear;
    procedure Activate;
    procedure Deactivate;

  end;


implementation

uses
  Classes, Forms,
  am2000utils;

const
  TOOLTIPS_CLASS = 'tooltips_class32';

type
  TToolInfo = packed record
    cbSize: UINT;
    uFlags: UINT;
    hwnd: HWND;
    uId: UINT;
    Rect: TRect;
    hInst: THandle;
    lpszText: PAnsiChar;
    lParam: LPARAM;
  end;

const
  TTS_ALWAYSTIP           = $01;
  TTS_NOPREFIX            = $02;

  TTM_ACTIVATE            = WM_USER + 1;
  TTM_SETDELAYTIME        = WM_USER + 3;
  TTM_SETTIPBKCOLOR       = WM_USER + 19;
  TTM_SETTIPTEXTCOLOR     = WM_USER + 20;
  TTM_SETMAXTIPWIDTH      = WM_USER + 24;
  TTM_ADDTOOL             = WM_USER + 4;
  TTM_DELTOOL             = WM_USER + 5;
  TTM_RELAYEVENT          = WM_USER + 7;
  TTM_GETTOOLCOUNT        = WM_USER +13;

  TTF_IDISHWND            = $0001;

  TTDT_AUTOMATIC          = 0;
  TTDT_RESHOW             = 1;
  TTDT_AUTOPOP            = 2;
  TTDT_INITIAL            = 3;


{ T_AM2000_ToolTipWindow }

constructor T_AM2000_ToolTipWindow.Create(AOwner: TWinControl);
begin
  inherited Create;

  Owner:= AOwner;

  // set owner's handle
  if Owner is TForm
  then hwndOwner:= Owner.Handle
  else hwndOwner:= 0;

  hwndToolTip:= CreateWindow(TOOLTIPS_CLASS, nil, TTS_ALWAYSTIP, 0, 0, 0, 0,
    hwndOwner, 0, HInstance, nil);

  SendMessage(hwndToolTip, TTM_SETMAXTIPWIDTH, 0, iToolTipWindowWidth);
  SendMessage(hwndToolTip, TTM_SETDELAYTIME, TTDT_AUTOPOP, iMaxToolTipShowingTime);
end;

destructor T_AM2000_ToolTipWindow.Destroy;
begin
  DestroyWindow(hwndToolTip);
  inherited;
end;

procedure T_AM2000_ToolTipWindow.AddTool(R: TRect; Hint: String);
var
  ti: TToolInfo;
begin
  ti.cbSize:= sizeof(TToolInfo);
  ti.uFlags:= 0;
  ti.hwnd:= hwndOwner;
  ti.hinst:= HInstance;
  ti.uId:= id;
  ti.lpszText:= PChar(Hint);
  Inc(id);

  ti.rect:= R;
  SendMessage(hwndToolTip, TTM_ADDTOOL, 0, LongInt(@ti));
end;

procedure T_AM2000_ToolTipWindow.AddWindowTool(C: TWinControl; Hint: String);
var
  ti: TToolInfo;
begin
  ti.cbSize:= sizeof(TToolInfo);
  ti.uFlags:= ttf_IdIsHWND;
  ti.hwnd:= hwndOwner;
  ti.hinst:= 0;
  ti.uId:= C.Handle;
  ti.lpszText:= PChar(Hint);

  SendMessage(hwndToolTip, TTM_ADDTOOL, 0, LongInt(@ti));
end;

procedure T_AM2000_ToolTipWindow.RelayMouseMove(Pos: TSmallPoint);
var
  Msg: TMsg;
begin
  Msg.wParam:= 0;
  Msg.lParam:= LongInt(Pos);
  Msg.message:= wm_MouseMove;
  Msg.hwnd:= hwndOwner;
  SendMessage(hwndToolTip, ttm_RelayEvent, 0, LongInt(@Msg));
end;

procedure T_AM2000_ToolTipWindow.RelayWindowMouseMove(Pos: TSmallPoint; hwnd: HWND);
var
  Msg: TMsg;
begin
  Msg.wParam:= 0;
  Msg.lParam:= LongInt(Pos);
  Msg.message:= wm_MouseMove;
  Msg.hwnd:= hwnd;
  SendMessage(hwndToolTip, ttm_RelayEvent, 0, LongInt(@Msg));
end;

procedure T_AM2000_ToolTipWindow.Clear;
var
  I: Integer;
  ti: TToolInfo;
begin
  ti.cbSize:= SizeOf(ti);
  ti.hwnd:= hwndOwner;
  for I:= 0 to id -1 do begin
    ti.uId:= I;
    SendMessage(hwndToolTip, TTM_DELTOOL, 0, LongInt(@ti));
  end;
  id:= 0;
end;

procedure T_AM2000_ToolTipWindow.Activate;
begin
  if FActive then Exit;
  SendMessage(hwndToolTip, TTM_ACTIVATE, 1, 0);
  FActive:= True;
end;

procedure T_AM2000_ToolTipWindow.Deactivate;
begin
  if not FActive then Exit;
  SendMessage(hwndToolTip, TTM_ACTIVATE, 0, 0);
  FActive:= False;
end;

end.
