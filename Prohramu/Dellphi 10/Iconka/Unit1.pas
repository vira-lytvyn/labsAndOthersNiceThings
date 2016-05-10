unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi;
const
WM_ICONTRAY = WM_USER + 1;
type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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

procedure TForm1.FormCreate(Sender: TObject);
begin
    with TrayIconData do
	begin
		cbSize := SIZE_OF_80387_REGISTERS;
		Wnd := Handle;
		uID := 0;
		uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
		uCallbackMessage := WM_ICONTRAY;
		hIcon := Application.Icon.Handle;
		StrPCopy(szTip, Application.Title);
	end;
	Shell_NotifyIcon(NIM_ADD, @TrayIconData);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
	Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

procedure TForm1.TrayMessage(var Msg: TMessage);
begin
	case Msg.lParam of
		WM_LBUTTONDOWN:
	begin
		ShowMessage('��������� ��� ������ � �������� �����!');
		Form1.Show;
	end;
    WM_RBUTTONDOWN:
	begin
		ShowMessage('��������� ����� ������ � ������� ������!');
		Form1.Hide;
	end;
end;
end;


end.
