
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       JavaMetal skin component                        }
{                                                       }
{       Copyright (c) 1997-2003 Animated Menus, Inc.    }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000skin_JavaMetal;

interface

uses
  am2000skin;

{$R am2000skin_JavaMetal.res}

type
  TJavaMetal = class(TResourceSkin2000)
  protected
    function GetResourceName: PAnsiChar; override;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{ TJavaMetal }

function TJavaMetal.GetResourceName: PAnsiChar;
begin
  Result:= 'am2000skin_JavaMetal';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
