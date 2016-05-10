unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, mmsystem, shellapi;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button30: TButton;
    Button29: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button37: TButton;
    Button38: TButton;
    Button39: TButton;
    Button40: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
    procedure Button39Click(Sender: TObject);
    procedure Button40Click(Sender: TObject);
  private
    function myGetVersion : String;
    { Private declarations }
  public
    property OSVersion : String read myGetVersion;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
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

function myGetComputerName : String;
var
   pcComputer : PChar;
   dwCSize    : DWORD;
begin
   dwCSize := MAX_COMPUTERNAME_LENGTH + 1;
   GetMem( pcComputer, dwCSize ); // allocate memory for the string
   try
      if Windows.GetComputerName( pcComputer, dwCSize ) then
         Result := pcComputer;
   finally
      FreeMem( pcComputer ); // now free the memory allocated for the string
   end;
end;

function TFORM1.myGetVersion: String;
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

procedure TForm1.Button1Click(Sender: TObject);   // Панель управління (виклик вікна)
begin
winexec('rundll32 shell32,Control_RunDLL',1);
end;

procedure TForm1.Button2Click(Sender: TObject); // Вікно " Відкрити як "
begin
winexec('rundll32 shell32,OpenAs_RunDLL',1);
end;

procedure TForm1.Button3Click(Sender: TObject); // Характеристики Віндовс
begin
winexec('rundll32 shell32,ShellAboutA Info-Box',1);
end;

procedure TForm1.Button4Click(Sender: TObject);  // Властивості робочого столу
begin
winexec('rundll32 shell32,Control_RunDLL desk.cpl',1);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
winexec('rundll32 user,cascadechildwindows',1);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
winexec('rundll32 user,tilechildwindows',1);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
winexec('rundll32 user,repaintscreen',1);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
winexec('rundll32 shell,shellexecute Explorer',1);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
winexec('rundll32 keyboard,disable',1);
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
winexec('rundll32 mouse,disable',1);
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
winexec('rundll32 user,swapmousebutton',1);
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
winexec('rundll32 user,setcursorpos',1);
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
winexec('rundll32 user,wnetconnectdialog',1);
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
winexec('rundll32 user,wnetdisconnectdialog',1);
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
winexec('rundll32 user,disableoemlayer',1);
end;

procedure TForm1.Button16Click(Sender: TObject);// Копіювати з дискети на дискету(при зміні параметрів на диск)
begin
winexec('rundll32 diskcopy,DiskCopyRunDll',1);
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
winexec('rundll32 rnaui.dll,RnaWizard',1);
end;

procedure TForm1.Button18Click(Sender: TObject); // Форматування комп'ютера
begin
winexec('rundll32 shell32,SHFormatDrive',1);
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
winexec('rundll32 shell32,SHExitWindowsEx -1',1);
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
winexec('rundll32 user,setcaretblinktime',1);
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
winexec('rundll32 user,setdoubleclicktime',1);
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
winexec('rundll32 sysdm.cpl,InstallDevice_Rundll',1);
end;

procedure TForm1.Button23Click(Sender: TObject); // Вимкнути
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';   // Borland forgot this declaration
var
  hToken       : THandle;
  tkp          : TTokenPrivileges;
  tkpo         : TTokenPrivileges;
  zero         : DWORD;
begin
  if Pos( 'Windows NT', OSVersion ) = 1  then // we've got to do a whole buch of things
     begin
        zero := 0;
        if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
           begin
             MessageBox( 0, 'Exit Error', 'OpenProcessToken() Failed', MB_OK );
             Exit;
           end; // if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)
        if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
           begin
             MessageBox( 0, 'Exit Error', 'OpenProcessToken() Failed', MB_OK );
             Exit;
           end; // if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)


        // SE_SHUTDOWN_NAME
        if not LookupPrivilegeValue( nil, 'SeShutdownPrivilege' , tkp.Privileges[ 0 ].Luid ) then
           begin
              MessageBox( 0, 'Exit Error', 'LookupPrivilegeValue() Failed', MB_OK );
              Exit;
           end; // if not LookupPrivilegeValue( nil, 'SeShutdownPrivilege' , tkp.Privileges[0].Luid )
        tkp.PrivilegeCount := 1;
        tkp.Privileges[ 0 ].Attributes := SE_PRIVILEGE_ENABLED;

        AdjustTokenPrivileges( hToken, False, tkp, SizeOf( TTokenPrivileges ), tkpo, zero );
        if Boolean( GetLastError() ) then
           begin
              MessageBox( 0, 'Exit Error', 'AdjustTokenPrivileges() Failed', MB_OK );
              Exit;
           end // if Boolean( GetLastError() )
        else
           ExitWindowsEx( EWX_FORCE or EWX_SHUTDOWN, 0 );
      end // if OSVersion = 'Windows NT'
   else
      begin // just shut the machine down
        ExitWindowsEx( EWX_FORCE or EWX_SHUTDOWN, 0 );
      end; // else
end;

procedure TForm1.Button24Click(Sender: TObject); // Перезавантаження
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';   // Borland forgot this declaration
var
  hToken       : THandle;
  tkp          : TTokenPrivileges;
  tkpo         : TTokenPrivileges;
  zero         : DWORD;
begin
  if Pos( 'Windows NT', OSVersion ) = 1  then // we've got to do a whole buch of things
     begin
        zero := 0;
        if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
           begin
             MessageBox( 0, 'Exit Error', 'OpenProcessToken() Failed', MB_OK );
             Exit;
           end; // if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)
        if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
           begin
             MessageBox( 0, 'Exit Error', 'OpenProcessToken() Failed', MB_OK );
             Exit;
           end; // if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)


        // SE_SHUTDOWN_NAME
        if not LookupPrivilegeValue( nil, 'SeShutdownPrivilege' , tkp.Privileges[ 0 ].Luid ) then
           begin
              MessageBox( 0, 'Exit Error', 'LookupPrivilegeValue() Failed', MB_OK );
              Exit;
           end; // if not LookupPrivilegeValue( nil, 'SeShutdownPrivilege' , tkp.Privileges[0].Luid )
        tkp.PrivilegeCount := 1;
        tkp.Privileges[ 0 ].Attributes := SE_PRIVILEGE_ENABLED;

        AdjustTokenPrivileges( hToken, False, tkp, SizeOf( TTokenPrivileges ), tkpo, zero );
        if Boolean( GetLastError() ) then
           begin
              MessageBox( 0, 'Exit Error', 'AdjustTokenPrivileges() Failed', MB_OK );
              Exit;
           end // if Boolean( GetLastError() )
        else
           ExitWindowsEx( EWX_FORCE or EWX_REBOOT, 0 );
      end // if OSVersion = 'Windows NT'
   else
      begin // just shut the machine down
        ExitWindowsEx( EWX_FORCE or EWX_REBOOT, 0 );
      end; // else
end;

procedure TForm1.Button25Click(Sender: TObject);    // Вихід із системи (Зміна користувача)
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';   // Borland forgot this declaration
var
  hToken       : THandle;
  tkp          : TTokenPrivileges;
  tkpo         : TTokenPrivileges;
  zero         : DWORD;
begin
  if Pos( 'Windows NT', OSVersion ) = 1  then // we've got to do a whole buch of things
     begin
        zero := 0;
        if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
           begin
             MessageBox( 0, 'Exit Error', 'OpenProcessToken() Failed', MB_OK );
             Exit;
           end; // if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)
        if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
           begin
             MessageBox( 0, 'Exit Error', 'OpenProcessToken() Failed', MB_OK );
             Exit;
           end; // if not OpenProcessToken( GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)


        // SE_SHUTDOWN_NAME
        if not LookupPrivilegeValue( nil, 'SeShutdownPrivilege' , tkp.Privileges[ 0 ].Luid ) then
           begin
              MessageBox( 0, 'Exit Error', 'LookupPrivilegeValue() Failed', MB_OK );
              Exit;
           end; // if not LookupPrivilegeValue( nil, 'SeShutdownPrivilege' , tkp.Privileges[0].Luid )
        tkp.PrivilegeCount := 1;
        tkp.Privileges[ 0 ].Attributes := SE_PRIVILEGE_ENABLED;

        AdjustTokenPrivileges( hToken, False, tkp, SizeOf( TTokenPrivileges ), tkpo, zero );
        if Boolean( GetLastError() ) then
           begin
              MessageBox( 0, 'Exit Error', 'AdjustTokenPrivileges() Failed', MB_OK );
              Exit;
           end // if Boolean( GetLastError() )
        else
           ExitWindowsEx( EWX_FORCE or EWX_LOGOFF, 0 );
      end // if OSVersion = 'Windows NT'
   else
      begin // just shut the machine down
        ExitWindowsEx( EWX_FORCE or EWX_LOGOFF, 0 );
      end; // else
end;

procedure TForm1.Button26Click(Sender: TObject);
begin
mciSendString('Set cdaudio door open wait', nil, 0, form1.Handle);  // Відкриває дисковод
end;

procedure TForm1.Button27Click(Sender: TObject);  // Закриває дисковод
begin
mciSendString('Set cdaudio door closed wait', nil, 0, form1.handle);
end;

procedure TForm1.Button30Click(Sender: TObject);   //  Показує ім'я користувача
begin
showmessage(myGetUserName);
end;

procedure TForm1.Button29Click(Sender: TObject); // Показує ім'я комп'ютера
begin
showmessage(myGetComputerName);
end;

function myGetWindowsDirectory : String;  // Директорія програм ( програмний диск)
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

procedure TForm1.Button31Click(Sender: TObject);  // Системна директорія
begin
showmessage(myGetWindowsDirectory);
end;

function myGetSystemDirectory : String;
var
   pcSystemDirectory : PChar;
   dwSDSize          : DWORD;
begin
   dwSDSize := MAX_PATH + 1;
   GetMem( pcSystemDirectory, dwSDSize ); // allocate memory for the string
   try
      if Windows.GetSystemDirectory( pcSystemDirectory, dwSDSize ) <> 0 then
         Result := pcSystemDirectory;
   finally
      FreeMem( pcSystemDirectory ); // now free the memory allocated for the string
   end;
end;

procedure TForm1.Button32Click(Sender: TObject);   // Показує системний час і дату
begin
showmessage(myGetSystemDirectory);
end;

function myGetSystemTime : String;
var
   stSystemTime : TSystemTime;
begin
   Windows.GetSystemTime( stSystemTime );
   Result := DateTimeToStr( SystemTimeToDateTime( stSystemTime ) );
end;

procedure TForm1.Button33Click(Sender: TObject);    // Показує час і дату комп'ютера
begin
showmessage(myGetSystemTime);
end;

function myGetLocalTime : String;
var
   stSystemTime : TSystemTime;
begin
   Windows.GetLocalTime( stSystemTime );
   Result := DateTimeToStr( SystemTimeToDateTime( stSystemTime ) );
end;

procedure TForm1.Button34Click(Sender: TObject);    // Показує шлях до файлу програми ,без розширення програми .ехе
begin
showmessage(myGetLocalTime);
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
   end; // try
end;

procedure TForm1.Button35Click(Sender: TObject);
begin
showmessage(myGetCurrentDirectory);
end;

function myGetTempPath: String;
var
    nBufferLength : DWORD; // size, in characters, of the buffer
    lpBuffer      : PChar; // address of buffer for temp. path
begin
   nBufferLength := MAX_PATH + 1; // initialize
   GetMem( lpBuffer, nBufferLength );
   try
      if GetTempPath( nBufferLength, lpBuffer ) <> 0 then
         Result := StrPas( lpBuffer )
      else
         Result := '';
   finally
      FreeMem( lpBuffer );
   end;
end;

procedure TForm1.Button36Click(Sender: TObject);
begin
showmessage(myGetTempPath);

end;

function myGetLogicalDrives : String;
var
   drives  : set of 0..25;
   drive   : integer;
begin
   Result := '';
   DWORD( drives ) := Windows.GetLogicalDrives;
   for drive := 0 to 25 do
      if drive in drives then
         Result := Result + Chr( drive + Ord( 'A' ));
end;

procedure TForm1.Button37Click(Sender: TObject);   // Показує версію Операційної Системи
begin
showmessage(myGetLogicalDrives);
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

procedure TForm1.Button38Click(Sender: TObject);
begin
showmessage(myGetVersion);
end;

function GetShortPathName( const Path : String ): String;
var
   lpszShortPath : PChar; // points to a buffer to receive the null-terminated short form of the path
begin
   GetMem( lpszShortPath, MAX_PATH + 1 );
   try
      Windows.GetShortPathName( PChar( Path ), lpszShortPath, MAX_PATH + 1 );
      Result := lpszShortPath;
   finally
      FreeMem( lpszShortPath );
   end;
end;

procedure TForm1.Button39Click(Sender: TObject);
begin
showmessage(GetShortPathName(application.exename));
end;

procedure TForm1.Button40Click(Sender: TObject);
begin
showmessage(application.exename);  //  Показує шлях до файлу програми ,яка запущена(самої себе), з розширенням даної програми .ехе
end;

end.
