
{*******************************************************}
{                                                       }
{       Animated Menus Add-On Menu Component            }
{       TToolsMenu2000 Tools Editor                     }
{                                                       }
{       Copyright é 1997-2002 by Animated Menus, Inc.   }
{                                                       }
{*******************************************************}

unit ToolsMenu2000_ToolsProperty;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, ToolsMenu2000,
  {$IFDEF Delphi6OrHigher} DesignIntf, DesignEditors {$ELSE} DsgnIntf {$ENDIF};

type
  T_AM2000_ToolsProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;


implementation

uses
  ToolsMenu2000_ToolsEditor;


{ T_AM2000_ToolsProperty }

procedure T_AM2000_ToolsProperty.Edit;
begin
  EditTools(TToolsMenu2000(GetComponent(0)).Tools);
  
  if Designer <> nil
  then Designer.Modified;
end;

function T_AM2000_ToolsProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paReadOnly, paDialog];
end;

function T_AM2000_ToolsProperty.GetValue: string;
begin
  Result:= '(T_AM2000_Tools)';
end;


end.
