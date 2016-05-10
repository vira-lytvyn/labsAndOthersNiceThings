
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TSubMenu2000 Component                          }
{                                                       }
{       Copyright © 1997-2000 by Andrew Cher            }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/tsubmenu2000/
//

unit SubMenu2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus,
  am2000, am2000menuitem;

type
  TPhantomMenuItem = class(TComponent);

  TSubMenu2000 = class(TPopupMenu2000)
  private
    FMenuItem: TPhantomMenuItem;

  protected
    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  published
    property SubMenuItem: TPhantomMenuItem
      read FMenuItem write FMenuItem;

  end;

implementation

uses
  Consts,
  am2000cache, am2000options, am2000utils;

{ TSubMenu2000 }

procedure TSubMenu2000.CreateComponentItems(Items: TMenuItem2000;
  AddEmpty: Boolean);
begin
  if FMenuItem <> nil
  then Items.Assign(TMenuItem2000(FMenuItem));
end;

function TSubMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Sub Menu Items';
end;

procedure TSubMenu2000.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FMenuItem)
  and (Operation = opRemove)
  then FMenuItem:= nil;
end;

end.
