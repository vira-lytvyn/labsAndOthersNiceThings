
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TToolbarMenu2000 Component                      }
{                                                       }
{       Copyright © 1997-2001 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/ttoolbarmenu2000/
//

unit ToolbarMenu2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  comctrls, extctrls, am2000, am2000menuitem, ToolbarManager;

type
  TToolbarMenu2000 = class(TPopupMenu2000)
  private
    FShowCustomize: Boolean;
    FToolbarManager: TCustomToolbarManager;
    FOnCustomize: TNotifyEvent;

  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;

  public
    constructor Create(AOwner: TComponent); override;

    procedure ShowHideToolbar(Sender: TObject);

  published
    property ShowCustomize: Boolean
      read FShowCustomize write FShowCustomize default True;
    property ToolbarManager: TCustomToolbarManager
      read FToolbarManager write FToolbarManager;
    property OnCustomize: TNotifyEvent
      read FOnCustomize write FOnCustomize;

  end;


implementation

uses 
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{ TToolbarMenu2000 }

constructor TToolbarMenu2000.Create(AOwner: TComponent);
begin
  inherited;
  FShowCustomize:= True;
end;

procedure TToolbarMenu2000.Loaded;
begin
  inherited;

  // set toolbar manager
  if FToolbarManager = nil
  then FToolbarManager:= FindToolbarManager(Owner);
end;

procedure TToolbarMenu2000.Notification(AComponent: TComponent; Operation: TOperation); 
begin
  inherited;

  if (Operation = opRemove)
  and (AComponent = FToolbarManager)
  then FToolbarManager:= nil;
end;

procedure TToolbarMenu2000.CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean);
var
  I: Integer;
  M: TMenuItem2000;
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

  // scan Owner for Toolbars and menus
  for I:= 0 to FToolbarManager.ToolbarCount -1 do
    with FToolbarManager[I] do
      if Caption <> ''
      then begin
        M:= NewItem2000(Caption, '', Visible, True, ShowHideToolbar, 0, '');
        M.Tag:= I;
        Items.Add(M);
      end;
                   
  // add additional items
  if FShowCustomize
  then begin
    Items.Add(NewLine2000);
    Items.Add(NewItem2000('&Customize...', '', False, True, FOnCustomize, 0, ''));
  end;
end;

procedure TToolbarMenu2000.ShowHideToolbar(Sender: TObject);
  // change toolbar's visibility
begin
  with TMenuItem2000(Sender)
  do begin
    Checked:= not Checked;
    FToolbarManager[Tag].Visible:= Checked;
  end;
end;

function TToolbarMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Toolbar Menu Items';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.

