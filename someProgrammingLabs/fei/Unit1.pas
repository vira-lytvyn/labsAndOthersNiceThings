unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi;

  const
  WM_ICONTRAY = WM_USER + 1;

type
  TForm1 = class(TForm)
    procedure OnCreate(Sender: TObject);
    procedure OnDestroy(Sender: TObject);
  private
  TrayIconData: TNotifyIconData;
    { Private declarations }
  public
  procedure TrayMessage(var Msg: TMessage);
   message WM_ICONTRAY;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.TrayMessage(var Msg: TMessage);
begin
  case Msg.lParam of
    WM_LBUTTONDOWN:
    begin
      ShowMessage('Натиснута ліва кнопка — ПОКАЗАТИ форму!');
      Form1.Show;
    end;
    WM_RBUTTONDOWN:
    begin
      ShowMessage('Натиснута права кнопка — СХОВАТИ форму!');
      Form1.Hide;
    end;
  end;
end;

procedure TForm1.OnCreate(Sender: TObject);
begin
 with TrayIconData do
  begin
    cbSize := SizeOf();
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage := WM_ICONTRAY;
    hIcon := Application.Icon.Handle;
    StrPCopy(szTip, Application.Title);
  end;
  Shell_NotifyIcon(NIM_ADD, @TrayIconData);

end;

procedure TForm1.OnDestroy(Sender: TObject);
begin
      Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

end.
