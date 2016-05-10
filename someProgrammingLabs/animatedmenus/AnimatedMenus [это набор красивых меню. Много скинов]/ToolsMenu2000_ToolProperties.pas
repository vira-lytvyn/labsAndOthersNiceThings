unit ToolsMenu2000_ToolProperties;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ExtDlgs, ComCtrls;

type
  TToolsMenu2000_ToolProperties=class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    OpenDialog: TOpenDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Button1: TButton;
    cbPrompt: TCheckBox;
    edParameters: TEdit;
    edWorkingDir: TEdit;
    edProgram: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    buttonBrowseFolder: TButton;
    buttonBrowse: TButton;
    Panel1: TPanel;
    Image1: TImage;
    edTitle: TEdit;
    Bevel1: TBevel;
    procedure buttonBrowseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure buttonBrowseFolderClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end ;

  
implementation

uses
  {$IFDEF Delphi2} Ole2 {$ELSE} ShlObj, ActiveX {$ENDIF};

{$R *.DFM}

{$IFDEF Delphi2}

type
  TSHItemID = record
    cb: Word;                         
    abID: array[0..0] of Byte;        
  end;

  PItemIDList = ^TItemIDList;
  TItemIDList = record
     mkid: TSHItemID;
   end;


  TBrowseInfo = record
    hwndOwner: HWND;
    pidlRoot: PItemIDList;
    pszDisplayName: PAnsiChar;
    lpszTitle: PAnsiChar;
    ulFlags: UINT;
    lpfn: Pointer;
    lParam: LPARAM;
    iImage: Integer;
  end;


  function SHBrowseForFolder(var lpbi: TBrowseInfo): PItemIDList;
    stdcall; external 'shell32.dll' name 'SHBrowseForFolderA';
  function SHGetPathFromIDList(pidl: PItemIDList; pszPath: PChar): BOOL;
    stdcall; external 'shell32.dll' name 'SHGetPathFromIDListA';

{$ENDIF}

function BrowseCallbackFunc(hwnd: HWND; uMsg: UINT; lp, pData: LParam): Integer; stdcall;
begin
	if (uMsg = BFFM_INITIALIZED)
	then SendMessage(hwnd, BFFM_SETSELECTION, 1, pData);

  Result:= 0;
end;

procedure TToolsMenu2000_ToolProperties.buttonBrowseClick(Sender: TObject);
begin
  if OpenDialog.Execute
  then begin
    edProgram.Text:= OpenDialog.FileName;
    edWorkingDir.Text:= ExtractFilePath(OpenDialog.FileName);
  end;
end;

procedure TToolsMenu2000_ToolProperties.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute
  then Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TToolsMenu2000_ToolProperties.buttonBrowseFolderClick(
  Sender: TObject);
var
  lpbi: TBrowseInfo;
  pid2: PItemIDList;
  z: array [0..MAX_PATH] of Char;
begin  
  FillChar(lpbi, SizeOf(lpbi), 0);
  lpbi.hwndOwner:= Application.MainForm.Handle;
  lpbi.lpszTitle:= 'Browse for an initial folder';
  lpbi.lParam:= Integer(PChar(edWorkingDir.Text));
  lpbi.lpfn:= BrowseCallbackFunc;

  pid2:= SHBrowseForFolder(lpbi);
  if pid2 <> nil
  then begin
    SHGetPathFromIDList(pid2, z);
    edWorkingDir.Text:= StrPas(z);
    CoTaskMemFree(pid2);
  end;

  SetForegroundWindow(Handle);
end;

procedure TToolsMenu2000_ToolProperties.FormShow(Sender: TObject);
begin
  ActiveControl:= edTitle;
  edTitle.SelectAll;
end;

end.
