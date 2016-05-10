{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1995,2001 Inprise Corporation     }
{                                                       }
{*******************************************************}
unit FolderMenu2000_RootsEdit;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF Delphi6OrHigher} DesignIntf, DesignEditors, {$ELSE} DsgnIntf, {$ENDIF}
  StdCtrls, FolderMenu2000, Buttons, ExtCtrls;

type
  TBitBtn = class(Buttons.TBitBtn)
  private
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  end;

  TRootsEditDlg = class(TForm)
    Button1: TBitBtn;
    Button2: TBitBtn;
    listRoots: TListBox;
    Button3: TBitBtn;
    Button4: TBitBtn;
    buttonEdit: TBitBtn;
    buttonRemove: TBitBtn;
    buttonMoveUp: TBitBtn;
    Bevel1: TBevel;
    buttonMoveDown: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure listRootsClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure buttonEditClick(Sender: TObject);
    procedure buttonRemoveClick(Sender: TObject);
    procedure buttonMoveUpClick(Sender: TObject);
    procedure buttonMoveDownClick(Sender: TObject);

  end;

  T_AM2000_RootsProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  
implementation

{$R *.dfm}

uses TypInfo, FileCtrl, FolderMenu2000_RootEdit;

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

procedure RootsEditor(const Value: TStrings);
begin
  with TRootsEditDlg.Create(Application) do
  try
    listRoots.Items.Assign(Value);

    ShowModal;

    if ModalResult = mrOK
    then Value.Assign(listRoots.Items);

  finally
    Free;
  end;
end;


                         
{ T_AM2000_RootProperty }

procedure T_AM2000_RootsProperty.Edit;
begin
  with TFolderMenu2000(GetComponent(0))
  do begin
    RootsEditor(Roots);

    if Roots.Count >0
    then Root:= Roots[0];
  end;



  Designer.Modified;
end;

function T_AM2000_RootsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;


{ TRootPathEditDlg }

procedure TRootsEditDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;



{ TBitBtn }

procedure TBitBtn.CMMouseEnter(var Message: TMessage);
begin
  Font.Color:= clNavy;
end;

procedure TBitBtn.CMMouseLeave(var Message: TMessage);
begin
  Font.Color:= clWindowText;
end;

procedure TRootsEditDlg.listRootsClick(Sender: TObject);
begin
  buttonMoveUp.Enabled:= listRoots.ItemIndex >0;
  buttonMoveDown.Enabled:= listRoots.ItemIndex < listRoots.Items.Count -1;
  buttonEdit.Enabled:= listRoots.ItemIndex >= 0;
  buttonRemove.Enabled:= buttonEdit.Enabled;
end;

procedure TRootsEditDlg.Button3Click(Sender: TObject);
var
  S: String;
begin
  S:= '';
  if RootPathEditor(S, 1)
  then listRoots.Items.Add(S);

  listRootsClick(nil);
end;

procedure TRootsEditDlg.Button4Click(Sender: TObject);
var
  S: String;
begin
  S:= '';
  if RootPathEditor(S, 2)
  then listRoots.Items.Add(S);

  listRootsClick(nil);
end;

procedure TRootsEditDlg.buttonEditClick(Sender: TObject);
var
  S: String;
begin
  S:= listRoots.Items[listRoots.ItemIndex];
  if RootPathEditor(S, 3)
  then listRoots.Items[listRoots.ItemIndex]:= S;

  listRootsclick(nil);
end;

procedure TRootsEditDlg.buttonRemoveClick(Sender: TObject);
var
  I: Integer;
begin
  I:= listRoots.ItemIndex;
  listRoots.Items.Delete(listRoots.ItemIndex);

  if listRoots.Items.Count > I
  then listRoots.ItemIndex:= I
  else
  if listRoots.Items.Count > 0
  then listRoots.ItemIndex:= listRoots.Items.Count -1;

  listRootsclick(nil);
end;

procedure TRootsEditDlg.buttonMoveUpClick(Sender: TObject);
var
  S: String;
  I: Integer;
begin
  with listRoots, Items
  do begin
    BeginUpdate;

    I:= ItemIndex;
    S:= Strings[I];
    Delete(I);
    Insert(I -1, S);
    ItemIndex:= I -1;

    EndUpdate;
  end;

  listRootsclick(nil);
end;

procedure TRootsEditDlg.buttonMoveDownClick(Sender: TObject);
var
  S: String;
  I: Integer;
begin
  with listRoots, Items
  do begin
    BeginUpdate;

    I:= ItemIndex;
    S:= Strings[I];
    Delete(I);
    Insert(I +1, S);
    ItemIndex:= I +1;

    EndUpdate;
  end;

  listRootsclick(nil);
end;

end.
