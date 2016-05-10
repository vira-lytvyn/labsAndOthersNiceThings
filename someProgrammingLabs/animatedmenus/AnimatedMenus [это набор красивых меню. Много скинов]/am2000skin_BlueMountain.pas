
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       TBlueMountain skin component                    }
{                                                       }
{       Copyright (c) 1997-2002 Animated Menus, Inc.    }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000skin_BlueMountain;

interface

uses
  am2000skin;

{$R am2000skin_BlueMountain.res}

type
  TBlueMountain = class(TResourceSkin2000)
  protected
    function GetResourceName: PAnsiChar; override;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{ TBlueMountain }

function TBlueMountain.GetResourceName: PAnsiChar;
begin
  Result:= 'am2000skin_BlueMountain';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.

