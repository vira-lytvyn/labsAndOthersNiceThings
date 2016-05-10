
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       WindowsXPOliveGreen skin component              }
{                                                       }
{       Copyright (c) 1997-2002 Animated Menus, Inc.    }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000skin_WindowsXPOliveGreen;

interface

uses
  am2000skin;

{$R am2000skin_WindowsXPOliveGreen.res}

type
  TWindowsXPOliveGreen = class(TResourceSkin2000)
  protected
    function GetResourceName: PAnsiChar; override;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{ TWindowsXPOliveGreen }

function TWindowsXPOliveGreen.GetResourceName: PAnsiChar;
begin
  Result:= 'am2000skin_WindowsXPOliveGreen';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.
