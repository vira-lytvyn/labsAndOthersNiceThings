
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       TMoney skin component                           }
{                                                       }
{       Copyright (c) 1997-2002 Animated Menus, Inc.    }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000skin_Money;

interface

uses
  am2000skin;

{$R am2000skin_Money.res}

type
  TMoney = class(TResourceSkin2000)
  protected
    function GetResourceName: PAnsiChar; override;

  end;


implementation

uses
{$IFDEF TRIAL}am2000trial,{$ENDIF}
  am2000utils;


{ TMoney }

function TMoney.GetResourceName: PAnsiChar;
begin
  Result:= 'am2000skin_Money';
end;

initialization
{$IFDEF TRIAL}
{$I am2000trial-body.inc}
{$ENDIF}
end.

