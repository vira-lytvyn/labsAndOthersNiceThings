
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TSubMenu2000 Component                          }
{                                                       }
{       Copyright © 1997-2002 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/tsubmenu2000/
//

unit SubMenu2000reg;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus,
  am2000, am2000menuitem,
  {$IFDEF Delphi6OrHigher} DesignIntf, DesignEditors, VclEditors, {$ELSE} DsgnIntf, {$ENDIF}
  TypInfo, SubMenu2000;
                
type
  TPhantomMenuItemProperty = class(TComponentProperty)
  private
    OldProc: TGetStrProc;
    procedure MyGetStrProc(const S: string);
    
  public
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;


implementation

uses
  {$IFDEF Delphi6OrHigher} RtlConsts, {$ELSE} Consts, {$ENDIF}
  am2000cache, am2000options, am2000utils;


{ TPhantomMenuItemProperty }

procedure TPhantomMenuItemProperty.GetValues(Proc: TGetStrProc);
begin
  OldProc:= Proc;
  Designer.GetComponentNames(GetTypeData(TypeInfo(TMenuItem)), MyGetStrProc);
end;

procedure TPhantomMenuItemProperty.MyGetStrProc(const S: string);
var
  C: TComponent;
begin
  C:= Designer.GetComponent(S);
  if (C <> nil)
  and (((C is TMenuItem2000) and (TMenuItem2000(C).Count > 0))
  or ((C is TMenuItem) and (TMenuItem(C).Count > 0)))
  then OldProc(S);
end;

procedure TPhantomMenuItemProperty.SetValue(const Value: string);
var
  Component: TComponent;
begin
  if Value = '' then Component := nil else
  begin
    Component:= Designer.GetComponent(Value);
    if not (Component is TMenuItem)
    then raise EPropertyError.{$IFDEF Delphi5OrHigher}CreateRes(@{$ELSE}Create({$ENDIF}{$IFDEF Delphi2}'Invalid property value'{$ELSE}SInvalidPropertyValue{$ENDIF});
  end;
  SetOrdValue(Longint(Component));
end;


end.

