
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       OfficeXP skin component                         }
{                                                       }
{       Copyright (c) 1997-2002 Animated Menus, Inc.    }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000skin_OfficeXP;

interface

uses
  am2000skin;

{$R am2000skin_OfficeXP.res}

type
  TOfficeXP = class(TResourceSkin2000)
  protected
    function GetResourceName: PAnsiChar; override;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{ TOfficeXP }

function TOfficeXP.GetResourceName: PAnsiChar;
begin
  Result:= 'am2000skin_OfficeXP';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.

