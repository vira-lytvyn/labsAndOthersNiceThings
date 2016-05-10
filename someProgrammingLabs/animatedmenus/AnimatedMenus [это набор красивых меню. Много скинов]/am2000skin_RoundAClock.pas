
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       RoundAClock skin component                      }
{                                                       }
{       Copyright (c) 1997-2002 Animated Menus, Inc.    }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000skin_RoundAClock;

interface

uses
  am2000skin;

{$R am2000skin_RoundAClock.res}

type
  TRoundAClock = class(TResourceSkin2000)
  protected
    function GetResourceName: PAnsiChar; override;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{ TRoundAClock }

function TRoundAClock.GetResourceName: PAnsiChar;
begin
  Result:= 'am2000skin_RoundAClock';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.

