
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       WindowsXPSilver skin component                  }
{                                                       }
{       Copyright (c) 1997-2002 Animated Menus, Inc.    }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000skin_WindowsXPSilver;

interface

uses
  am2000skin;

{$R am2000skin_WindowsXPSilver.res}

type
  TWindowsXPSilver = class(TResourceSkin2000)
  protected
    function GetResourceName: PAnsiChar; override;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{ TWindowsXPSilver }

function TWindowsXPSilver.GetResourceName: PAnsiChar;
begin
  Result:= 'am2000skin_WindowsXPSilver';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
