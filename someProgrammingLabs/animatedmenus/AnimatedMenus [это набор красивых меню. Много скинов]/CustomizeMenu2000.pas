
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TCustomizeMenu2000 Component                    }
{                                                       }
{       Copyright © 1997-2001 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/tcustomizemenu2000/
//

unit CustomizeMenu2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  comctrls, extctrls, Menus, am2000, am2000menuitem, ToolbarManager;

const
  SCustomize = '&Customize...';
  SResetToolbar = '&Reset Toolbar';

type
  TCustomizeMenu2000 = class(TPopupMenu2000)
  private
    FShowCustomize: Boolean;
    FShowResetToolbar: Boolean;
    FToolbarManager: TCustomToolbarManager;
    FOnCustomize: TNotifyEvent;
    FOnResetToolbar: TNotifyEvent;

  protected
    procedure Loaded; override;
    procedure DoCloseQuery(Sender: TObject; var CanClose: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;
    procedure UpdateComponentItems(Items: TMenuItem2000); override;

    procedure ShowHideButton(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;


  published
    property ShowCustomize: Boolean
      read FShowCustomize write FShowCustomize default True;
    property ShowResetToolbar: Boolean
      read FShowResetToolbar write FShowResetToolbar default True;
    property ToolbarManager: TCustomToolbarManager
      read FToolbarManager write FToolbarManager;
    property OnCustomize: TNotifyEvent
      read FOnCustomize write FOnCustomize;
    property OnResetToolbar: TNotifyEvent
      read FOnResetToolbar write FOnResetToolbar;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000options, am2000utils;



{ TCustomizeMenu2000 }

constructor TCustomizeMenu2000.Create(AOwner: TComponent);
begin
  inherited;

  FShowCustomize:= True;
  FShowResetToolbar:= True;
  Options.Margins.Left:= 44;
  Options.Flags:= Options.Flags + [mfShowCheckMark];
end;

procedure TCustomizeMenu2000.Loaded;
begin
  inherited;

  // set toolbar manager
  if FToolbarManager = nil
  then FToolbarManager:= FindToolbarManager(Owner);
end;

procedure TCustomizeMenu2000.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove)
  and (AComponent = FToolbarManager)
  then FToolbarManager:= nil;
end;

procedure TCustomizeMenu2000.CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean);
var
  I, Index: Integer;
  M: TMenuItem2000;
  C: String;
  Toolbar: TComponent;
begin
  // exit if toolbar manager is not defined
  if (FToolbarManager = nil)
  then begin
    inherited CreateComponentItems(Items, True);
    MessageDlg('Error: Cannot find Toolbar Manager.'#13#13 +
      'Toolbar Manager controls all operations between TToolbarMenu2000 and toolbars. ' +
      'Please install a Toolbar Manager component specifically designed for your toolbars ' +
      'and assign it to the ToolbarManager property of this menu component.'#13#13 +
      'For more information about Toolbar Manager please visit ' +
      'http://www.animatedmenus.com/support/toolbarmanager/', mtError, [mbOk], 0);
    Exit;
  end;

  // find toolbar
  Toolbar:= PopupComponent;
  while (Toolbar <> nil) and (not FToolbarManager.IsToolbar(Toolbar))
  do
    if Toolbar is TControl
    then Toolbar:= TControl(Toolbar).Parent
    else Toolbar:= Toolbar.Owner;

  if Toolbar = nil
  then begin
    inherited CreateComponentItems(Items, True);
    Exit;
  end;

  // search for PopupComponent
  Index:= FToolbarManager.IndexOf(Toolbar);
  if (Index = -1)
  then begin
    inherited CreateComponentItems(Items, True);
    Exit;
  end;

  // scan toolbar for buttons
  with FToolbarManager[Index] do
    for I:= 0 to ButtonCount -1 do
      with Buttons[I]
      do begin
        C:= Caption;
        if (C <> '')
        and not IsSeparator
        then begin
          M:= NewItem2000(C, '', Visible, (C <> TForm(PopupComponent).Caption), ShowHideButton, 0, '');
          M.Bitmap.Assign(Bitmap);
          M.Tag:= I;
          Items.Add(M);
        end;
      end;

  // add additional items
  if FShowResetToolbar
  then begin
    Items.Add(NewLine);
    Items.Add(NewItem(SResetToolbar, 0, False, True, FOnResetToolbar, 0, ''));
  end;

  if FShowCustomize
  then begin
    if not FShowResetToolbar then Items.Add(NewLine);
    Items.Add(NewItem(SCustomize, 0, False, True, FOnCustomize, 0, ''));
  end;
end;

procedure TCustomizeMenu2000.UpdateComponentItems(Items: TMenuItem2000);
begin
  Items.Clear;
  CreateComponentItems(Items, False);
end;



procedure TCustomizeMenu2000.ShowHideButton(Sender: TObject);
var
  Index: Integer;
  Toolbar: TComponent;

  procedure ShowSeparator(Toolbar: TCustomToolbar; Index: Integer);
  var
    I, I1: Integer;
  begin
    I1:= -1;
    I:= Index +1;
    while I < Toolbar.ButtonCount
    do
      with Toolbar.Buttons[I]
      do begin
        if (Caption = TForm(PopupComponent).Caption)
        then Break;

        if Visible
        then begin
          if I1 <> -1
          then Toolbar.Buttons[I1].Visible:= True;

          Break;
        end;

        if IsSeparator
        then
          if I1 = -1
          then I1:= I
          else begin
            if not Visible
            then Toolbar.Buttons[I1].Visible:= True;
          end;

        Inc(I);
      end;

    I:= Index -1;
    while I > 0
    do
      with Toolbar.Buttons[I]
      do begin
        if Visible
        then Exit;

        if IsSeparator
        then begin
          Visible:= True;
          Exit;
        end;

        Dec(I);
      end;
  end;

  procedure HideDuplicateSeparators(Toolbar: TCustomToolbar; Index: Integer);
  var
    I1, I2: Integer;
  begin
    // scan for previous separator
    I1:= Index;
    while I1 >= 0
    do
      with Toolbar.Buttons[I1]
      do begin
        if Visible
        then
          if IsSeparator
          then Break
          else Exit;

        Dec(I1);
      end;

    // scan for next separator
    I2:= Index;
    while I2 < Toolbar.ButtonCount
    do
      with Toolbar.Buttons[I2]
      do begin
        if Visible
        then begin
          if IsSeparator
          then Visible:= False;

          if Caption = TForm(PopupComponent).Caption
          then Toolbar.Buttons[I1].Visible:= False;

          Exit;
        end;

        Inc(I2);
      end;
  end;

begin
  // exit if toolbar manager is not defined
  if (FToolbarManager = nil)
  then Exit;

  // find toolbar
  Toolbar:= PopupComponent;
  while (Toolbar <> nil) and (not FToolbarManager.IsToolbar(Toolbar))
  do
    if Toolbar is TControl
    then Toolbar:= TControl(Toolbar).Parent
    else Toolbar:= Toolbar.Owner;

  if Toolbar = nil
  then Exit;
  
  Index:= FToolbarManager.IndexOf(Toolbar);
  if (Index = -1)
  then Exit;

  // action
  with TMenuItem2000(Sender), FToolbarManager[Index].Buttons[Tag]
  do begin
    Checked:= not Checked;
    Visible:= Checked;
    if Visible
    then ShowSeparator(FToolbarManager[Index], Tag)
    else HideDuplicateSeparators(FToolbarManager[Index], Tag);
  end;
end;

procedure TCustomizeMenu2000.DoCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= (TMenuItem(Sender).Caption = SResetToolbar)
    or (TMenuItem(Sender).Caption = SCustomize);
end;

function TCustomizeMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Customize Menu Items';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
