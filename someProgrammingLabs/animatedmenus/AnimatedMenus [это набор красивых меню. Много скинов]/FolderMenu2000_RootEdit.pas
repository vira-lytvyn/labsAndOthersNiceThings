{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1995,2001 Inprise Corporation     }
{                                                       }
{*******************************************************}
unit FolderMenu2000_RootEdit;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF Delphi6OrHigher} DesignIntf, DesignEditors, {$ELSE} DsgnIntf, {$ENDIF}
  StdCtrls, FolderMenu2000, ComCtrls;

type
  TRootPathEditDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    editPath: TEdit;
    Button3: TButton;
    Label1: TLabel;
    listSpecialFolders: TListBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure listSpecialFoldersDblClick(Sender: TObject);

  end;

  T_AM2000_RootProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;


  
function RootPathEditor(var Value: String; const ActivePage: Integer): Boolean;

implementation

{$R *.dfm}

uses TypInfo, FileCtrl;

resourcestring
  SPickRootPath = 'Please select a root path';
  SEditRoot = 'E&dit Root';

const
  NTFolders = [rfCommonDesktopDirectory, rfCommonPrograms, rfCommonStartMenu,
               rfCommonStartup];

function PathIsCSIDL(Value: string): Boolean;
begin
  Result := GetEnumValue(TypeInfo(TRootFolder), Value) >= 0;
end;

function RootPathEditor(var Value: String; const ActivePage: Integer): Boolean;
begin
  with TRootPathEditDlg.Create(Application) do
  try
    if PathIsCSIDL(Value)
    or (ActivePage = 1)
    then begin
      listSpecialFolders.ItemIndex:= listSpecialFolders.Items.IndexOf(Value);
      PageControl1.ActivePage:= TabSheet1;
    end
    else begin
      editPath.Text:= Value;
      PageControl1.ActivePage:= TabSheet2;
    end;

    Result:= ShowModal = mrOk;

    if Result
    then begin
      if PageControl1.ActivePage = TabSheet1
      then Value:= editPath.Text
      else Value:= listSpecialFolders.Items[listSpecialFolders.ItemIndex];
    end;

  finally
    Free;
  end;
end;


                         
{ T_AM2000_RootProperty }

procedure T_AM2000_RootProperty.Edit;
var
  S: String;
begin
  S:= GetStrValue;
  if RootPathEditor(S, 0)
  then SetStrValue(S);

  Designer.Modified;
end;

function T_AM2000_RootProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paDialog];
end;


{ TRootPathEditDlg }

procedure TRootPathEditDlg.FormCreate(Sender: TObject);
var
  FT: TRootFolder;
begin
  for FT := Low(TRootFolder) to High(TRootFolder) do
    if not ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (FT in NTFolders)) then
      listSpecialFolders.Items.Add(GetEnumName(TypeInfo(TRootFolder), Ord(FT)));
  listSpecialFolders.ItemIndex:= 0;
end;

procedure TRootPathEditDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TRootPathEditDlg.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TRootPathEditDlg.Button1Click(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TRootPathEditDlg.btnBrowseClick(Sender: TObject);
var
  Path : widestring;
  Dir : string;
begin
  Path:= editPath.Text;
  Dir:= editPath.Text;
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], 0)
  then editPath.Text:= Dir;
end;

procedure TRootPathEditDlg.listSpecialFoldersDblClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

end.
