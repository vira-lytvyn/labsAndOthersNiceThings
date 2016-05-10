
{*******************************************************}
{                                                       }
{       Animated Menus Add-On Menu Component            }
{       TToolsMenu2000 Tools Editor                     }
{                                                       }
{       Copyright é 1997-2002 by Animated Menus, Inc.   }
{                                                       }
{*******************************************************}

unit ToolsMenu2000_ToolsEditor;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, ToolsMenu2000,
{$IFDEF Delphi4OrHigher}  ImgList, {$ENDIF}
  ComCtrls, ToolWin;

type
  TToolsMenu2000_ToolsEditor = class(TForm)
    Label1: TLabel;
    ItemList: TListBox;
    CloseButton: TButton;
    ToolBar1: TToolBar;
    buttonNew: TToolButton;
    ImageList1: TImageList;
    buttonEdit: TToolButton;
    buttonDelete: TToolButton;
    ToolButton4: TToolButton;
    buttonMoveDown: TToolButton;
    buttonMoveUp: TToolButton;
    procedure AddButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure ItemListClick(Sender: TObject);
    procedure UpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DnBtnClick(Sender: TObject);
    procedure ItemListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    FTools: T_AM2000_Tools;

    procedure UpdateItemList;
    procedure UpdateButtons;
    
  public

  end;


procedure EditTools(const ATools: T_AM2000_Tools);

implementation

uses
  ToolsMenu2000_ToolProperties;

{$R *.DFM}



{ EditTools }

procedure EditTools(const ATools: T_AM2000_Tools);
var
  F: TToolsMenu2000_ToolsEditor;
begin
  F:= TToolsMenu2000_ToolsEditor.Create(Application);
  F.FTools:= ATools;
  F.ShowModal;
  F.Free;
  ATools.Save;
end;


{ TToolsMenu2000_ToolsEditor }

procedure TToolsMenu2000_ToolsEditor.AddButtonClick(Sender: TObject);
var
  F: TToolsMenu2000_ToolProperties;
  O: T_AM2000_ToolOptions;
begin
  F:= TToolsMenu2000_ToolProperties.Create(Self);
  if F.ShowModal = mrOk
  then begin
    O:= [];
    if F.cbPrompt.Checked then Include(O, toPromptForArguments);
//    if F.cbRunInMod.Checked then Include(O, toRunInModalWindow);
//    if F.cbMinOnRun.Checked then Include(O, toMinimizeOnRun);

    FTools.Add(F.edTitle.Text, F.edProgram.Text, F.edParameters.Text, F.edWorkingDir.Text,
      F.Image1.Picture.Bitmap, O);
    ItemList.Items.Add(F.edTitle.Text);
    ItemList.ItemIndex:= ItemList.Items.Count -1;

    ItemListClick(nil);
  end;
  F.Free;
end;

procedure TToolsMenu2000_ToolsEditor.DelButtonClick(Sender: TObject);
var
  I: Integer;
  L: TList;
begin
  ItemList.Items.BeginUpdate;
  
  L:= TList.Create;
  for I:= 0 to ItemList.Items.Count -1
  do begin
    if ItemList.Selected[I]
    then L.Add(FTools[I]);
  end;

  for I:= 0 to L.Count -1
  do T_AM2000_Tool(L[I]).Free;

  L.Free;

  UpdateItemList;
  ItemList.Items.EndUpdate;
  ItemListClick(nil);
end;

procedure TToolsMenu2000_ToolsEditor.EditButtonClick(Sender: TObject);
var
  O: T_AM2000_ToolOptions;
  T: T_AM2000_Tool;
begin
  T:= FTools[ItemList.ItemIndex];
  with TToolsMenu2000_ToolProperties.Create(Self)
  do begin
    Caption:= T.Title + ' Properties';
    edTitle.Text:= T.Title;
    edProgram.Text:= T.Command;
    edParameters.Text:= T.Arguments;
    edWorkingDir.Text:= T.InitialDir;
    cbPrompt.Checked:= toPromptForArguments in T.Options;
//    cbRunInMod.Checked:= toRunInModalWindow in T.Options;
//    cbMinOnRun.Checked:= toMinimizeOnRun in T.Options;


    Image1.Picture.Assign(T.Bitmap);

    if ShowModal = mrOk
    then begin
      T.Options:= [];
      if cbPrompt.Checked then Include(T.Options, toPromptForArguments);
//      if cbRunInMod.Checked then Include(T.Options, toRunInModalWindow);
//      if cbMinOnRun.Checked then Include(T.Options, toMinimizeOnRun);

      T.Title:= edTitle.Text;
      T.Command:= edProgram.Text;
      T.Arguments:= edParameters.Text;
      T.InitialDir:= edWorkingDir.Text;
      T.Bitmap:= Image1.Picture.Bitmap;

      ItemList.Items[ItemList.ItemIndex]:= edTitle.Text;
    end;

    Free;
  end;
end;

procedure TToolsMenu2000_ToolsEditor.ItemListClick(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TToolsMenu2000_ToolsEditor.UpClick(Sender: TObject);
var
  I: Integer;
  T: T_AM2000_Tool;
begin
  I:= ItemList.ItemIndex;
  if (I < 1)
  or (I >= FTools.Count)
  then Exit;

  T:= FTools[I];
  FTools.Remove(T);
  FTools.Insert(I -1, T);

  UpdateItemList;
  ItemList.ItemIndex:= I -1;
  UpdateButtons;
end;

procedure TToolsMenu2000_ToolsEditor.DnBtnClick(Sender: TObject);
var
  I: Integer;
  T: T_AM2000_Tool;
begin
  I:= ItemList.ItemIndex;
  if (I < 0)
  or (I >= FTools.Count -1)
  then Exit;

  T:= FTools[I];
  FTools.Remove(T);
  FTools.Insert(I +1, T);

  UpdateItemList;
  ItemList.ItemIndex:= I +1;
  UpdateButtons;
end;

procedure TToolsMenu2000_ToolsEditor.FormShow(Sender: TObject);
begin
  UpdateItemList;
end;

procedure TToolsMenu2000_ToolsEditor.UpdateItemList;
var
  I: Integer;
begin
  ItemList.Items.BeginUpdate;
  ItemList.Items.Clear;

  for I:= 0 to FTools.Count -1
  do ItemList.Items.Add(FTools[I].Title);

  ItemList.Items.EndUpdate;
end;

procedure TToolsMenu2000_ToolsEditor.ItemListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Insert
  then AddButtonClick(nil)
  else
  if Key = vk_Return
  then EditButtonClick(nil)
  else
  if Key = vk_Delete
  then DelButtonClick(nil);
end;

procedure TToolsMenu2000_ToolsEditor.UpdateButtons;
begin
  buttonEdit.Enabled:= ItemList.ItemIndex <> -1;
  buttonDelete.Enabled:= ItemList.ItemIndex <> -1;
  buttonMoveUp.Enabled:= ItemList.ItemIndex > 0;
  buttonMoveDown.Enabled:= (ItemList.ItemIndex >= 0)
    and (ItemList.ItemIndex < ItemList.Items.Count -1);
end;

end.
