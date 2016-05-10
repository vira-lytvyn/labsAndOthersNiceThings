unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi, Menus, StdCtrls, mmsystem, ComCtrls, ExtCtrls, ImgList;

  const
  WM_ICONTRAY = WM_USER + 1;

type
  TForm1 = class(TForm)
    pm1: TPopupMenu;
    N1: TMenuItem;
    Games: TMenuItem;
    N4: TMenuItem;
    WMP1: TMenuItem;
    MO1: TMenuItem;
    Explorer1: TMenuItem;
    Paint1: TMenuItem;
    N5: TMenuItem;
    AkelPad: TMenuItem;
    Cher: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    SHFormatD1: TMenuItem;
    ShutDown1: TMenuItem;
    ChengeUser1: TMenuItem;
    HotBtn1: TMenuItem;
    OpenDVD1: TMenuItem;
    CloseDVD1: TMenuItem;
    ControlPanel1: TMenuItem;
    OpenAs1: TMenuItem;
    LocalTime1: TMenuItem;
    AboutComputer1: TMenuItem;
    AboutWindows1: TMenuItem;
    OSVersion1: TMenuItem;
    DisplayOptions1: TMenuItem;
    UserName1: TMenuItem;
    WindowsDirectory1: TMenuItem;
    SystemTime1: TMenuItem;
    CurrentDirectory1: TMenuItem;
    ApplicationExeName1: TMenuItem;
    procedure OnCreate(Sender: TObject);
    procedure OnDestroy(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure AkelPadClick(Sender: TObject);
    procedure Paint1Click(Sender: TObject);
    procedure WMP1Click(Sender: TObject);
    procedure MO1Click(Sender: TObject);
    procedure Explorer1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure CherClick(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure OpenDVD1Click(Sender: TObject);
    procedure CloseDVD1Click(Sender: TObject);
    procedure ControlPanel1Click(Sender: TObject);
    procedure OpenAs1Click(Sender: TObject);
    procedure LocalTime1Click(Sender: TObject);
    procedure SystemTime1Click(Sender: TObject);
    procedure AboutWindows1Click(Sender: TObject);
    procedure OSVersion1Click(Sender: TObject);
    procedure DisplayOptions1Click(Sender: TObject);
    procedure UserName1Click(Sender: TObject);
    procedure WindowsDirectory1Click(Sender: TObject);
    procedure CurrentDirectory1Click(Sender: TObject);
    procedure ApplicationExeName1Click(Sender: TObject);
    procedure ShutDown1Click(Sender: TObject);
    procedure ChengeUser1Click(Sender: TObject);
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
var
  p : TPoint;
begin
  case Msg.lParam of
    WM_RBUTTONDOWN:
    begin
      ShowMessage('Dear User, I create this program to make your using of computer easier and more efectivly! Have mach joy! With the best wishes Vira Lutvyn :)');
      Halt;
    end;
    WM_LBUTTONDOWN:
    begin
       SetForegroundWindow(Handle);
       GetCursorPos(p);
       pm1.Popup(p.x, p.y);
       PostMessage(Handle, WM_NULL, 0, 0);
    end;
  end;
end;

function myGetUserName : String;
var
   pcUser   : PChar;
   dwUSize : DWORD;
begin
   dwUSize := 21; // user name can be up to 20 characters
   GetMem( pcUser, dwUSize ); // allocate memory for the string
   try
      if Windows.GetUserName( pcUser, dwUSize ) then
         Result := pcUser
   finally
      FreeMem( pcUser ); // now free the memory allocated for the string
   end;
end;

procedure TForm1.UserName1Click(Sender: TObject);
begin
	 showmessage(myGetUserName);
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

procedure TForm1.OpenAs1Click(Sender: TObject);
begin
	 winexec('rundll32 shell32,OpenAs_RunDLL',1);
end;

procedure TForm1.OpenDVD1Click(Sender: TObject);
begin
	mciSendString('Set cdaudio door open wait', nil, 0, form1.Handle);
end;

function myGetVersion: String;
var
   VersionInfo : TOSVersionInfo;
   OSName      : String;
begin
   // set the size of the record
   VersionInfo.dwOSVersionInfoSize := SizeOf( TOSVersionInfo );

   if Windows.GetVersionEx( VersionInfo ) then
      begin
         with VersionInfo do
         begin
            case dwPlatformId of
               VER_PLATFORM_WIN32s	  : OSName := 'Win32s';
               VER_PLATFORM_WIN32_WINDOWS : OSName := 'Windows 95';
               VER_PLATFORM_WIN32_NT      : OSName := 'Windows NT';
            end; // case dwPlatformId
            Result := OSName + ' Version ' + IntToStr( dwMajorVersion ) + '.' + IntToStr( dwMinorVersion ) +
                      #13#10' (Build ' + IntToStr( dwBuildNumber ) + ': ' + szCSDVersion + ')';
         end; // with VersionInfo
      end // if GetVersionEx
   else
      Result := '';
end;

procedure TForm1.OSVersion1Click(Sender: TObject);
begin
	 showmessage(myGetVersion);
end;

procedure TForm1.N1Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.AboutWindows1Click(Sender: TObject);
begin
	 winexec('rundll32 shell32,ShellAboutA Info-Box',1);
end;

procedure TForm1.AkelPadClick(Sender: TObject);
begin
	ShellExecute(Handle,nil,'Notepad.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.ApplicationExeName1Click(Sender: TObject);
begin
     showmessage(application.exename);
end;

procedure TForm1.Paint1Click(Sender: TObject);
begin
	ShellExecute(Handle,nil,'msPaint.exe',nil,nil,SW_SHOWNORMAL);
end;

function myGetSystemTime : String;
var
   stSystemTime : TSystemTime;
begin
   Windows.GetSystemTime( stSystemTime );
   Result := DateTimeToStr( SystemTimeToDateTime( stSystemTime ) );
end;

procedure TForm1.ShutDown1Click(Sender: TObject);
begin
	ExitWindows(EWX_SHUTDOWN, 0 );
end;

procedure TForm1.SystemTime1Click(Sender: TObject);
begin
     ShowMessage(myGetSystemTime);
end;

function myGetWindowsDirectory : String;
var
   pcWindowsDirectory : PChar;
   dwWDSize           : DWORD;
begin
   dwWDSize := MAX_PATH + 1;
   GetMem( pcWindowsDirectory, dwWDSize ); // allocate memory for the string
   try
      if Windows.GetWindowsDirectory( pcWindowsDirectory, dwWDSize ) <> 0 then
         Result := pcWindowsDirectory;
   finally
      FreeMem( pcWindowsDirectory ); // now free the memory allocated for the string
   end;
end;

procedure TForm1.WindowsDirectory1Click(Sender: TObject);
begin
     ShowMessage(myGetWindowsDirectory);
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

function myGetLocalTime : String;
var
   stSystemTime : TSystemTime;
begin
   Windows.GetLocalTime( stSystemTime );
   Result := DateTimeToStr( SystemTimeToDateTime( stSystemTime ) );
end;

procedure TForm1.LocalTime1Click(Sender: TObject);
begin
     showmessage(myGetLocalTime);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
ShellExecute(Handle,nil,'zemletrus.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.ChengeUser1Click(Sender: TObject);
begin
	ExitWindows(EWX_LOGOFF, 0 );
end;

procedure TForm1.CherClick(Sender: TObject);
begin
ShellExecute(Handle,nil,'mshearts.exe',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.CloseDVD1Click(Sender: TObject);
begin
	mciSendString('Set cdaudio door closed wait', nil, 0, form1.handle);
end;

procedure TForm1.ControlPanel1Click(Sender: TObject);
begin
	 winexec('rundll32 shell32,Control_RunDLL',1);
end;

function myGetCurrentDirectory: String;
var
   nBufferLength : DWORD; // size, in characters, of directory buffer
   lpBuffer 	 : PChar; // address of buffer for current directory
begin
   nBufferLength := MAX_PATH + 1;
   GetMem( lpBuffer, nBufferLength );
   try
      if Windows.GetCurrentDirectory( nBufferLength, lpBuffer ) > 0 then
         Result := lpBuffer;
   finally
      FreeMem( lpBuffer );
   end;
end;

procedure TForm1.CurrentDirectory1Click(Sender: TObject);
begin
    ShowMessage(myGetCurrentDirectory);
end;

procedure TForm1.DisplayOptions1Click(Sender: TObject);
begin
	 winexec('rundll32 shell32,Control_RunDLL desk.cpl',1);
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
 	ExitWindows(EWX_REBOOT, 0 );
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

end.
