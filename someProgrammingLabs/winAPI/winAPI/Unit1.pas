unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi, Menus, ComCtrls, ExtCtrls, ImgList;

  const
  WM_ICONTRAY = WM_USER + 1;

type
  TForm1 = class(TForm)
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    WMP1: TMenuItem;
    MO1: TMenuItem;
    Explorer1: TMenuItem;
    Paint1: TMenuItem;
    CommandPrompt1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    timer1: TTimer;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    tmr1: TTimer;
    ImageList1: TImageList;
    procedure OnCreate(Sender: TObject);
    procedure OnDestroy(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure CommandPrompt1Click(Sender: TObject);
    procedure Paint1Click(Sender: TObject);
    procedure WMP1Click(Sender: TObject);
    procedure MO1Click(Sender: TObject);
    procedure Explorer1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
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

{procedure TForm1.TrayMessage(var Msg: TMessage);
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
end;                   }

procedure TForm1.TrayMessage(var Msg: TMessage);
var
  p : TPoint;
begin
  case Msg.lParam of
    WM_LBUTTONDOWN:
    begin
      ShowMessage('This icon responds to RIGHT BUTTON click!');
      Form1.Show;
    end;
    WM_RBUTTONDOWN:
    begin
       SetForegroundWindow(Handle);
       GetCursorPos(p);
       pm1.Popup(p.x, p.y);
       PostMessage(Handle, WM_NULL, 0, 0);
    end;
  end;
end;
procedure TForm1.OnCreate(Sender: TObject);
begin
 with TrayIconData do
  begin
    cbSize := SizeOf(0);
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

procedure TForm1.N1Click(Sender: TObject);
begin
 Close;
end;


procedure TForm1.N6Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'Notepad.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.CommandPrompt1Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'cmd.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.Paint1Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'msPaint.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.WMP1Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'wmplayer.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.MO1Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'WINWORD.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.Explorer1Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'iexplore.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'zemletrus.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.N7Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'mshearts.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.N10Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'sol.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.N8Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'spider.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.N9Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'winmine.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.N5Click(Sender: TObject);
begin
 ExitWindows(EW_RESTARTWINDOWS, 0 );
end;


procedure TForm1.N12Click(Sender: TObject);
    var
               Rgn : hRgn;
begin
 Rgn := CreateRectRgn(0, 0, 0, 0); 
               SetWindowRgn(FindWindowEx(FindWindow('Shell_TrayWnd', nil), 
                                                    0, 
                                                   'Button', 
                                                    nil), 
                                                    Rgn, 
                                                    true);
end;

procedure TForm1.N13Click(Sender: TObject);
begin
 SetWindowRgn(FindWindowEx(FindWindow('Shell_TrayWnd', nil), 
                                                    0, 
                                                   'Button', 
                                                    nil), 
                                                    0, 
                                                    true);

end;

procedure TForm1.N14Click(Sender: TObject);
begin
  EnableWindow(FindWindowEx(FindWindow('Shell_TrayWnd', nil), 
                                                    0, 
                                                    'Button', 
                                                    nil), 
                                                    false);
 
end;

procedure TForm1.N15Click(Sender: TObject);
begin
  EnableWindow(FindWindowEx(FindWindow('Shell_TrayWnd', nil), 
                                                    0, 
                                                    'Button', 
                                                    nil),
                                                    true); 
end;

procedure TForm1.tmr1Timer(Sender: TObject);
{$J+}
const
  Index : Integer = 0;
{$J-}
var
  Icon: TIcon;
begin
  Inc(Index);
  if Index = 2 then Index:=0;

  Icon:=TIcon.Create;
  try
    ImageList1.GetIcon(Index,Icon);
    TrayIconData.hIcon := Icon.Handle;
    Shell_NotifyIcon(NIM_Modify, @TrayIconData);
  finally
    Icon.Free;
  end;
end;


end.
