{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_Desktop class                          }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000desktop;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls,
  Forms, Dialogs;


type
  T_AM2000_Desktop = class
  private
    FHandle: HDC;
    FScreenshots: TList;
    procedure GetBitmap1(const ADC: HDC; const ALeft, ATop, AWidth,
      AHeight: Integer; const LockBitmap: Boolean);

  public
    IgnoreClear: Boolean;
    property Handle: HDC
      read FHandle;

    constructor Create; virtual;
    destructor Destroy; override;

    procedure GetBitmap(const ADC: HDC; const ALeft, ATop, AWidth, AHeight: Integer);
    procedure GetBitmapNoLock(const ADC: HDC; const ALeft, ATop, AWidth, AHeight: Integer);

    procedure Release(const ALeft, ATop, AWidth, AHeight: Integer);
    procedure Clear;

  end;

  T_AM2000_Screenshot = class
  private
    FR: TRect;
    FBitmap: HBitmap;
    FDC: HDC;
    FOld: HGdiObj;
    Released: Boolean;

  public
    constructor Create(const ADC: HDC; const ALeft, ATop, AWidth, AHeight: Integer);
    destructor Destroy; override;

  end;



var
  Desktop: T_AM2000_Desktop;

implementation

uses
  am2000utils;

const
  DD = 20;

{ T_AM2000_Desktop }

constructor T_AM2000_Desktop.Create;
begin
  inherited;
  FHandle:= GetDC(0);
  FScreenshots:= TList.Create;
end;

destructor T_AM2000_Desktop.Destroy;
begin
  while FScreenshots.Count > 0
  do T_AM2000_Screenshot(FScreenshots[FScreenshots.Count -1]).Free;

  FScreenshots.Free;
  ReleaseDC(0, FHandle);

  inherited Destroy;
end;

procedure T_AM2000_Desktop.GetBitmap1(const ADC: HDC; const ALeft, ATop,
  AWidth, AHeight: Integer; const LockBitmap: Boolean);
var
  S: T_AM2000_Screenshot;
  R: TRect;
  I: Integer;
begin
  R:= Rect(ALeft, ATop, ALeft + AWidth, ATop + AHeight);

  // already containted
  for I:= FScreenshots.Count -1 downto 0
  do
    with T_AM2000_Screenshot(FScreenshots[I])
    do begin
      // is contained
      if (R.Left >= FR.Left)
      and (R.Top >= FR.Top)
      and (R.Right <= FR.Right)
      and (R.Bottom <= FR.Bottom)
      then begin
        BitBlt(ADC, 0, 0, AWidth, AHeight, FDC, ALeft - FR.Left, ATop - FR.Top, SrcCopy);
        Exit;
      end;
    end;

  S:= T_AM2000_Screenshot.Create(FHandle, ALeft, ATop, AWidth, AHeight);
  FScreenshots.Add(S);
  if not LockBitmap then S.Released:= True;

  // add all previous
  for I:= 0 to FScreenshots.Count -2
  do
    with T_AM2000_Screenshot(FScreenshots[I])
    do begin
      BitBlt(S.FDC, FR.Left - S.FR.Left, FR.Top - S.FR.Top, FR.Right - FR.Left, FR.Bottom - FR.Top, FDC, 0, 0, SrcCopy);
    end;

  if ADC <> 0
  then BitBlt(ADC, 0, 0, AWidth, AHeight, S.FDC, ALeft - S.FR.Left, ATop - S.FR.Top, SrcCopy);
end;

procedure T_AM2000_Desktop.GetBitmap(const ADC: HDC; const ALeft, ATop,
  AWidth, AHeight: Integer);
begin
  GetBitmap1(ADC, ALeft, ATop, AWidth, AHeight, True);
end;

procedure T_AM2000_Desktop.GetBitmapNoLock(const ADC: HDC; const ALeft,
  ATop, AWidth, AHeight: Integer);
begin
  GetBitmap1(ADC, ALeft, ATop, AWidth, AHeight, False);
end;


procedure T_AM2000_Desktop.Release(const ALeft, ATop, AWidth, AHeight: Integer);
var
  R: TRect;
  I: Integer;
begin
  R:= Rect(ALeft - DD, ATop - DD, ALeft + AWidth + DD, ATop + AHeight + DD);

  // already containted
  for I:= 0 to FScreenshots.Count -1
  do
    with T_AM2000_Screenshot(FScreenshots[I])
    do begin
      // is contained
      if (R.Left = FR.Left)
      and (R.Top = FR.Top)
      and (R.Right = FR.Right)
      and (R.Bottom = FR.Bottom)
      then Released:= True;
    end;
end;

procedure T_AM2000_Desktop.Clear;
begin
  if IgnoreClear
  then
    IgnoreClear:= False
    
  else
    while FScreenshots.Count > 0
    do T_AM2000_Screenshot(FScreenshots[FScreenshots.Count -1]).Free;
end;


{ T_AM2000_Screenshot }

constructor T_AM2000_Screenshot.Create(const ADC: HDC; const ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited Create;

  FR:= Rect(ALeft - DD, ATop - DD, ALeft + AWidth + DD, ATop + AHeight + DD);

  FDC:= CreateCompatibleDC(ADC);
  FBitmap:= CreateCompatibleBitmap(ADC, AWidth + 2*DD, AHeight + 2*DD);
  FOld:= SelectObject(FDC, FBitmap);

  BitBlt(FDC, 0, 0, AWidth + 2*DD, AHeight + 2*DD, ADC, FR.Left, FR.Top, SrcCopy);
end;

destructor T_AM2000_Screenshot.Destroy;
begin
  SelectObject(FDC, FOld);
  DeleteDC(FDC);
  DeleteObject(FBitmap);

  Desktop.FScreenshots.Remove(Self);
  inherited;
end;

initialization
  Desktop:= T_AM2000_Desktop.Create;

finalization
  Desktop.Free;

end.
