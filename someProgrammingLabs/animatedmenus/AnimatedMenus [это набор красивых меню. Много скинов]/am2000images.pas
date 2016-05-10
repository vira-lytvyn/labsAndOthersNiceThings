
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_ImageIndexProperty and                 }
{       T_AM2000_DefaultIndexProperty                   }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit am2000images;

{$I am2000.inc}

interface

uses
  Windows, SysUtils, ComCtrls, StdCtrls, Controls, ExtCtrls, Classes, Forms, Graphics,
  CommCtrl, Menus, TypInfo, am2000options,
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  {$IFDEF Delphi6OrHigher} DesignIntf, DesignEditors, VclEditors {$ELSE} DsgnIntf {$ENDIF}
  ;

type
{$IFDEF Delphi5OrHigher}
  // image index property
  T_AM2000_ImageIndexProperty = class(TPropertyEditor
    {$IFDEF Delphi6OrHigher}, ICustomPropertyListDrawing {$ENDIF})
  private
    FImages: TCustomImageList;

    procedure GetImages;

  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetAttributes: TPropertyAttributes; override;
    function AllEqual: Boolean; override;
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer);
      {$IFNDEF Delphi6OrHigher} override; {$ENDIF}
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer);
      {$IFNDEF Delphi6OrHigher} override; {$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean);
      {$IFNDEF Delphi6OrHigher} override; {$ENDIF}
    function AutoFill: Boolean; override;

  end;

  // default index property
  T_AM2000_DefaultIndexProperty = class(TPropertyEditor
    {$IFDEF Delphi6OrHigher}, ICustomPropertyListDrawing {$ENDIF})
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetAttributes: TPropertyAttributes; override;
    function AllEqual: Boolean; override;
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer);
      {$IFNDEF Delphi6OrHigher} override; {$ENDIF}
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer);
      {$IFNDEF Delphi6OrHigher} override; {$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean);
      {$IFNDEF Delphi6OrHigher} override; {$ENDIF}
    function AutoFill: Boolean; override;

  end;
{$ENDIF}

implementation

uses
  Dialogs,
  am2000menuitem, am2000mainmenu, am2000popupmenu, am2000cache, am2000utils, am2000;


{$IFDEF Delphi5OrHigher}
{ T_AM2000_ImageIndexProperty }

function T_AM2000_ImageIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paValueList, paMultiSelect, paRevertable];
end;

function T_AM2000_ImageIndexProperty.GetValue: string;
begin
  Result:= IntToStr(GetOrdValue);
end;

procedure T_AM2000_ImageIndexProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  if FImages = nil
  then GetImages;

  if FImages <> nil
  then
    for I:= 0 to FImages.Count -1
    do
      Proc(IntToStr(I));
end;

procedure T_AM2000_ImageIndexProperty.SetValue(const Value: string);
begin
  SetOrdValue(StrToInt(Value));
end;

function T_AM2000_ImageIndexProperty.AllEqual: Boolean;
var
  I, X: Integer;
begin
  Result:= False;

  if PropCount > 1
  then begin
    X:= GetOrdValue;
    for I:= 1 to PropCount - 1
    do
      if GetOrdValueAt(I) <> X
      then Exit;
  end;

  Result:= True;
end;

procedure T_AM2000_ImageIndexProperty.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  X, Y: Integer;
  S: TSize;
begin
  if FImages = nil
  then GetImages;

  if FImages <> nil
  then begin
    ACanvas.FillRect(ARect);

    S:= ACanvas.TextExtent(Value);

    Y:= (ARect.Bottom + ARect.Top - FImages.Height) div 2;
    ImageList_Draw(FImages.Handle, StrToInt(Value), ACanvas.Handle, 3, Y, ild_Transparent);

    Y:= (ARect.Bottom + ARect.Top - S.Cy) div 2;
    X:= FImages.Width +6;
    ACanvas.TextOut(X, Y, Value);

  end
  else
    inherited;
end;

procedure T_AM2000_ImageIndexProperty.ListMeasureHeight(
  const Value: string; ACanvas: TCanvas; var AHeight: Integer);
var
  I1, I2: Integer;
begin
  if FImages = nil
  then GetImages;

  I1:= 0;
  if FImages <> nil
  then I1:= FImages.Height;

  I2:= ACanvas.TextHeight(Value);
  if I1 > I2
  then AHeight:= I1 +2
  else AHeight:= I2 +2;
end;

procedure T_AM2000_ImageIndexProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
var
  I1: Integer;
begin
  if FImages = nil
  then GetImages;

  I1:= 0;
  if FImages <> nil
  then I1:= FImages.Width +6;

  AWidth:= I1 + ACanvas.TextWidth(Value);
end;

procedure T_AM2000_ImageIndexProperty.GetImages;
var
  C: TPersistent;
  MI: TMenuItem2000;
  M: TMenu;
begin
  C:= GetComponent(0);

  if C is TMenuItem2000
  then MI:= TMenuItem2000(C)
  else Exit;

  if (MI.Parent <> nil)
  and (MI.Parent.SubMenuImages <> nil)
  then begin
    FImages:= MI.Parent.SubMenuImages;
    Exit;
  end;

  M:= MI.GetMenu;

  if M is TCustomMainMenu2000
  then FImages:= TCustomMainMenu2000(M).Images;

  if M is TCustomPopupMenu2000
  then FImages:= TCustomImageList(TCustomPopupMenu2000(M).Images);

end;

function T_AM2000_ImageIndexProperty.AutoFill: Boolean;
begin
  Result:= True;
end;


{ T_AM2000_DefaultIndexProperty }

function T_AM2000_DefaultIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paValueList, paMultiSelect, paRevertable];
end;

function T_AM2000_DefaultIndexProperty.GetValue: string;
begin
  Result:= IntToStr(TMenuItem2000(GetComponent(0)).DefaultIndex);
end;

procedure T_AM2000_DefaultIndexProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  Proc('-2');
  Proc('-1');
  for I:= 0 to MenuItemCache.BitmapCount -1
  do
    Proc(IntToStr(I));
end;

procedure T_AM2000_DefaultIndexProperty.SetValue(const Value: string);
begin
  TMenuItem2000(GetComponent(0)).DefaultIndex:= StrToInt(Value);
end;

function T_AM2000_DefaultIndexProperty.AllEqual: Boolean;
var
  I, X: Integer;
begin
  Result:= False;

  if PropCount > 1
  then begin
    X:= GetOrdValue;
    for I:= 1 to PropCount - 1
    do
      if GetOrdValueAt(I) <> X
      then Exit;
  end;

  Result:= True;
end;

procedure T_AM2000_DefaultIndexProperty.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  Y, Index: Integer;
  S: String;
begin
  ACanvas.FillRect(ARect);

  Index:= StrToInt(Value);
  Y:= (ARect.Bottom + ARect.Top - 16) div 2;
  if Value >= '0'
  then MenuItemCache.DrawIndex(ACanvas, 3, Y, Index, clNone, clNone, clNone, True, 0);

  S:= Value;
  if Value = '-2'
  then AppendStr(S, ' (no bitmap)')
  else
  if Value = '-1'
  then AppendStr(S, ' (default bitmap)')
  else AppendStr(S, ' (' + MenuItemCache.GetBitmapCaption(Index) + ')');

  Y:= (ARect.Bottom + ARect.Top - ACanvas.TextHeight(S)) div 2;
  ACanvas.TextOut(22, Y, S);
end;

procedure T_AM2000_DefaultIndexProperty.ListMeasureHeight(
  const Value: string; ACanvas: TCanvas; var AHeight: Integer);
var
  I2: Integer;
begin
  I2:= ACanvas.TextHeight(Value);
  if I2 > 16
  then AHeight:= I2 +2
  else AHeight:= 18;
end;

procedure T_AM2000_DefaultIndexProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  AWidth:= 22 + ACanvas.TextWidth(Value);
end;

function T_AM2000_DefaultIndexProperty.AutoFill: Boolean;
begin
  Result:= True;
end;
{$ENDIF}


{ T_AM2000_ImageListProperty }

{function T_AM2000_ImageListProperty.GetAttributes: TPropertyAttributes;
begin
//  if GetComponent(0) is TAnimatedSkin2000
//  then
  Result:= [paValueList, paMultiSelect, paSortList, paRevertable, paSubProperties]
//  else Result:= inherited GetAttributes;
end;

procedure T_AM2000_ImageListProperty.GetProperties(Proc: TGetPropProc);
var
  I, J, CompCount: Integer;
  CompType: TClass;
  EditorInstance: TBasePropertyEditor;
  Editor: IProperty;
  EdClass: TPropertyEditorClass;
  PropInfo: PPropInfo;
  Component, Obj: TPersistent;
//  Images: IImages;
begin
  Component:= GetComponent(0);
  CompType:= TAnimatedSkin2000;

  PropInfo:= TypInfo.GetPropInfo(TAnimatedSkin2000, 'DisabledImages', [tkClass]);
  EdClass:= TComponentProperty;
  EditorInstance:= EdClass.Create(Designer, 1);
  Editor:= EditorInstance as IProperty;
  T_AM2000_ImageListProperty(EditorInstance).SetPropEntry(0, Component, PropInfo);
  TPropertyEditor(EditorInstance).Initialize;
  Proc(Editor);
end;

//procedure T_AM2000_ImageListProperty.SetPropEntry(Index: Integer;
//  AInstance: TPersistent; APropInfo: PPropInfo);
//begin
//  inherited;
//end;
}

end.
