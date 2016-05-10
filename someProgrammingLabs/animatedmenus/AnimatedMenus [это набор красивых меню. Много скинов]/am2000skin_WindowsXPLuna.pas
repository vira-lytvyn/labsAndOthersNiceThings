
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       WindowsXPLuna skin component                    }
{                                                       }
{       Copyright (c) 1997-2002 Animated Menus, Inc.    }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000skin_WindowsXPLuna;

interface

uses
  am2000skin;

{$R am2000skin_WindowsXPLuna.res}

type
  TWindowsXPLuna = class(TResourceSkin2000)
  protected
    function GetResourceName: PAnsiChar; override;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{ TWindowsXPLuna }

function TWindowsXPLuna.GetResourceName: PAnsiChar;
begin
  Result:= 'am2000skin_WindowsXPLuna';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
