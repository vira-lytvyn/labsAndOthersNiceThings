
{*******************************************************}
{                                                       }
{       Toolbar Manager for Windows toolbars            }
{       Version 1.0                                     }
{                                                       }
{       Copyright (c) 2000 AnimatedMenus.com            }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit ToolbarManager_Windows;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  ToolbarManager;

type
  // This class represents a toolbar
  TToolbar_Windows = class(TCustomToolbar)
  protected
    function GetVisible: Boolean; override;
    procedure SetVisible(const Value: Boolean); override;

    function GetCaption: String; override;
    procedure SetCaption(const Value: String); override;

    function GetHint: String; override;

    function GetPopupMenu: TPopupMenu; override;
    procedure SetPopupMenu(const Value: TPopupMenu); override;
    
    // buttons
    function GetButtonBitmap(Index: Integer; Bitmap: TBitmap): TBitmap; override;
    function GetButtonCaption(Index: Integer): String; override;
    function GetButtonCount: Integer; override;
    function GetButtonHeight(Index: Integer): Integer; override;
    function GetButtonLeft(Index: Integer): Integer; override;
    function GetButtonSeparator(Index: Integer): Boolean; override;
    function GetButtonShortCut(Index: Integer): String; override;
    function GetButtonTop(Index: Integer): Integer; override;
    function GetButtonVisible(Index: Integer): Boolean; override;
    function GetButtonWidth(Index: Integer): Integer; override;
    procedure SetButtonBitmap(Index: Integer; Bitmap: TBitmap); override;
    procedure SetButtonCaption(Index: Integer; const Value: String); override;
    procedure SetButtonShortCut(Index: Integer; const Value: String); override;
    procedure SetButtonVisible(Index: Integer; const Value: Boolean); override;

  end;

  // This class represent a toolbar manager
  TToolbarManager_Windows = class(TCustomToolbarManager)
  protected
    function CreateToolbar(AToolbar: TComponent): TCustomToolbar; override;

  public
    function IsToolbar(AComponent: TComponent): Boolean; override;

  end;

procedure Register;

implementation

uses
  ComCtrls, CommCtrl;

procedure Register;
begin
  RegisterComponents('Animated Menus', [TToolbarManager_Windows]);
end;


{ TToolbar_Windows }

function TToolbar_Windows.GetButtonBitmap(Index: Integer;
  Bitmap: TBitmap): TBitmap;
var
  C: TComponent;
begin
  ClearBitmap(Bitmap);
  Result:= Bitmap;
  C:= TToolbar(FToolbar).Buttons[Index];
  if (C is TToolButton)
  and (TToolButton(C).ImageIndex <> -1)
  and (TToolbar(FToolbar).Images <> nil)
  then
    with TToolbar(FToolbar), TToolButton(C)
    do begin
      Bitmap.Width:= Images.Width;
      Bitmap.Height:= Images.Height;
      Bitmap.Canvas.Brush.Style:= bsSolid;
      Bitmap.Canvas.Brush.Color:= clFuchsia;
      Bitmap.Canvas.FillRect(Rect(0, 0, Images.Width, Images.Height));
      ImageList_Draw(Images.Handle, ImageIndex, Bitmap.Canvas.Handle, 0, 0, ild_Transparent);
    end;
end;

function TToolbar_Windows.GetButtonCaption(Index: Integer): String;
var
  C: TComponent;
begin
  C:= TToolbar(FToolbar).Buttons[Index];
  if C is TControl
  then
    Result:= TToolButton(C).Caption
  else
    Result:= C.Name;
end;

function TToolbar_Windows.GetButtonCount: Integer;
begin
  Result:= TToolbar(FToolbar).ButtonCount;
end;

function TToolbar_Windows.GetButtonHeight(Index: Integer): Integer;
var
  C: TComponent;
begin
  C:= TToolbar(FToolbar).Buttons[Index];
  if C is TControl
  then Result:= TControl(C).Height
  else Result:= 0;
end;

function TToolbar_Windows.GetButtonLeft(Index: Integer): Integer;
var
  C: TComponent;
begin
  C:= TToolbar(FToolbar).Buttons[Index];
  if C is TControl
  then Result:= TControl(C).Left
  else Result:= 0;
end;

function TToolbar_Windows.GetButtonSeparator(Index: Integer): Boolean;
var
  C: TComponent;
begin
  C:= TToolbar(FToolbar).Buttons[Index];
  Result:= (C is TToolButton) and (TToolButton(C).Style in [tbsSeparator, tbsDivider]);
end;

function TToolbar_Windows.GetButtonShortCut(Index: Integer): String;
begin
  Result:= '';
end;

function TToolbar_Windows.GetButtonTop(Index: Integer): Integer;
var
  C: TComponent;
begin
  C:= TToolbar(FToolbar).Buttons[Index];
  if C is TControl
  then Result:= TControl(C).Top
  else Result:= 0;
end;

function TToolbar_Windows.GetButtonVisible(Index: Integer): Boolean;
begin
  Result:= TToolbar(FToolbar).Buttons[Index].Visible;
end;

function TToolbar_Windows.GetButtonWidth(Index: Integer): Integer;
var
  C: TComponent;
begin
  C:= TToolbar(FToolbar).Buttons[Index];
  if C is TControl
  then Result:= TControl(C).Width
  else Result:= 0;
end;

function TToolbar_Windows.GetCaption: String;
begin
{$IFDEF Delphi4OrHigher}
  Result:= TToolbar(FToolbar).Caption;
{$ELSE}
  Result:= TToolbar(FToolbar).Name;
{$ENDIF}
end;

function TToolbar_Windows.GetHint: String;
begin
  Result:= TToolbar(FToolbar).Hint;
  if Result = '' then Result:= SNoDescriptionAvailable;
end;

function TToolbar_Windows.GetPopupMenu: TPopupMenu;
begin
  Result:= TToolbar(FToolbar).PopupMenu;
end;

function TToolbar_Windows.GetVisible: Boolean;
begin
  Result:= TToolbar(FToolbar).Visible;
end;

procedure TToolbar_Windows.SetButtonBitmap(Index: Integer;
  Bitmap: TBitmap);
begin
  inherited;

end;

procedure TToolbar_Windows.SetButtonCaption(Index: Integer;
  const Value: String);
var
  C: TComponent;
begin
  C:= TToolbar(FToolbar).Buttons[Index];
  if C is TControl
  then
    TToolButton(C).Caption:= Value
  else
    C.Name:= Value;
end;

procedure TToolbar_Windows.SetButtonShortCut(Index: Integer;
  const Value: String);
begin
end;

procedure TToolbar_Windows.SetButtonVisible(Index: Integer;
  const Value: Boolean);
begin
  TToolbar(FToolbar).Buttons[Index].Visible:= Value;
end;

procedure TToolbar_Windows.SetCaption(const Value: String);
begin
{$IFDEF Delphi4OrHigher}
  TToolbar(FToolbar).Caption:= Value;
{$ELSE}
  TToolbar(FToolbar).Name:= Value;
{$ENDIF}
end;

procedure TToolbar_Windows.SetPopupMenu(const Value: TPopupMenu);
begin
  TToolbar(FToolbar).PopupMenu:= Value;
end;

procedure TToolbar_Windows.SetVisible(const Value: Boolean);
begin
  TToolbar(FToolbar).Visible:= Value;
end;


{ TToolbarManager_Windows }

function TToolbarManager_Windows.IsToolbar(AComponent: TComponent): Boolean;
begin
  Result:= AComponent is TToolbar;
end;

function TToolbarManager_Windows.CreateToolbar(AToolbar: TComponent): TCustomToolbar;
var
  C: TComponent;
begin
  if AToolbar = nil
  then C:= TToolbar.Create(Owner)
  else C:= AToolbar;
    
  Result:= TToolbar_Windows.Create(C);
end;

end.

