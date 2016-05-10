
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       TCustomAnimatedSkin2000 component               }
{                                                       }
{       Copyright (c) 1997-2002 Animated Menus, Inc.    }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000skin;

{$I am2000.inc}

interface

uses
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Controls, Dialogs, Graphics,
  am2000options, am2000utils;

type
  TCustomAnimatedSkin2000 = class(T_AM2000_AnimatedSkin, ISkin)
  private
    FTitle              : T_AM2000_Title;
    FColors             : T_AM2000_Colors;
    FMargins            : T_AM2000_Margins;
    FOpacity            : T_AM2000_Opacity;
    FSkin               : T_AM2000_Skin;
    FCtl3D              : Boolean;
    FMenus              : TList;
    FAnimation          : T_AM2000_Animation;
    FFlags              : T_AM2000_Flags;
    FFont               : TFont;
    FSystemFont         : Boolean;
    FParentFont         : Boolean;
    FSystemCtl3D        : Boolean;
    FSystemShadow       : Boolean;
    FSystemSelectionFade: Boolean;
    FMenuBar            : T_AM2000_MenuBarOptions;
    FImages             : TCustomImageList;
    FDisabledImages     : TCustomImageList;
    FHotImages          : TCustomImageList;

    function ISkin.Title = GetTitle;
    function ISkin.Colors = GetColors;
    function ISkin.Margins = GetMargins;
    function ISkin.Skin = GetSkin;
    function ISkin.Opacity = GetOpacity;
    function ISkin.Ctl3D = GetCtl3D;
    function ISkin.Animation = GetAnimation;
    function ISkin.Flags = GetFlags;
    function ISkin.Font = GetFont;
    function ISkin.SystemFont = GetSystemFont;
    function ISkin.ParentFont = GetParentFont;
    function ISkin.SystemCtl3D = GetSystemCtl3D;
    function ISkin.SystemShadow = GetSystemShadow;
    function ISkin.SystemSelectionFade = GetSystemSelectionFade;
    function ISkin.Images = GetImages;
    function ISkin.DisabledImages = GetDisabledImages;
    function ISkin.HotImages = GetHotImages;


    function GetTitle: T_AM2000_Title;
    function GetColors: T_AM2000_Colors;
    function GetMargins: T_AM2000_Margins;
    function GetSkin: T_AM2000_Skin;
    function GetMenuBar: T_AM2000_MenuBarOptions;
    function GetOpacity: T_AM2000_Opacity;
    function GetCtl3D: Boolean;
    function GetAnimation: T_AM2000_Animation;
    function GetFlags: T_AM2000_Flags;
    function GetSystemFont: Boolean;
    function GetParentFont: Boolean;
    function GetSystemCtl3D: Boolean;
    function GetSystemShadow: Boolean;
    function GetSystemSelectionFade: Boolean;
    function GetImages: TCustomImageList;
    function GetDisabledImages: TCustomImageList;
    function GetHotImages: TCustomImageList;

    procedure SetColors(Value: T_AM2000_Colors);
    procedure SetTitle(Value: T_AM2000_Title);
    procedure SetMargins(Value: T_AM2000_Margins);
    procedure SetSkin(Value: T_AM2000_Skin);
    procedure SetCtl3D(const Value: Boolean);
    procedure SetAnimation(const Value: T_AM2000_Animation);
    procedure SetFlags(const Value: T_AM2000_Flags);

    function GetFont: TFont;
    procedure SetFont(const Value: TFont);
    function IsFontStored: Boolean;

    procedure SetSystemFont(const Value: Boolean);
    procedure SetParentFont(const Value: Boolean);

    function IsCtl3DStored: Boolean;
    procedure SetMenuBar(const Value: T_AM2000_MenuBarOptions);

    function GetVersion: T_AM2000_Version;
    procedure SetVersion(Value: T_AM2000_Version);

    procedure SetOpacity(const Value: T_AM2000_Opacity);

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure Remove(Dest: TPersistent); override;

    procedure UpdateMenus; override;
    procedure LoadFromFile(const Filename: String; const Format: Integer
      {$IFDEF Delphi4OrHigher} = 1{$ENDIF});
    procedure SaveToFile(const Filename: String; const Format: Integer
      {$IFDEF Delphi4OrHigher} = 1{$ENDIF});
    procedure Reset; virtual;

    function IsDefault: Boolean; virtual;
    function GetISkin: ISkin; override;

    function HasColors: Boolean;
    function HasTitle: Boolean;
    function HasMargins: Boolean;
    function HasSkin: Boolean;
    function HasMenuBar: Boolean;

    property Colors          : T_AM2000_Colors
      read GetColors write SetColors stored HasColors;
    property Margins         : T_AM2000_Margins
      read GetMargins write SetMargins stored HasMargins;
    property Opacity         : T_AM2000_Opacity
      read FOpacity write SetOpacity default 100;
    property Title           : T_AM2000_Title
      read GetTitle write SetTitle stored HasTitle;
    property Skin            : T_AM2000_Skin
      read GetSkin write SetSkin stored HasSkin;
    property Ctl3D           : Boolean
      read FCtl3D write SetCtl3D stored IsCtl3DStored;
    property Animation       : T_AM2000_Animation
      read FAnimation write SetAnimation default anDefault;
    property Flags           : T_AM2000_Flags
      read GetFlags write SetFlags;
    property Font            : TFont
      read GetFont write SetFont stored IsFontStored;
    property SystemFont      : Boolean
      read FSystemFont write SetSystemFont default True;
    property ParentFont      : Boolean
      read FParentFont write SetParentFont default False;
    property SystemCtl3D    : Boolean
      read FSystemCtl3D write FSystemCtl3D default False;
    property SystemShadow   : Boolean
      read FSystemShadow write FSystemShadow default False;
    property SystemSelectionFade : Boolean
      read FSystemSelectionFade write FSystemSelectionFade default True;
    property MenuBar        : T_AM2000_MenuBarOptions
      read GetMenuBar write SetMenuBar stored HasMenuBar;
    property Images         : TCustomImageList
      read FImages write FImages;
    property DisabledImages : TCustomImageList
      read FDisabledImages write FDisabledImages;
    property HotImages      : TCustomImageList
      read FHotImages write FHotImages;
    property Version        : T_AM2000_Version
      read GetVersion write SetVersion stored False;

  end;

  TResourceSkin2000 = class(TCustomAnimatedSkin2000)
  private
    Temp: TCustomAnimatedSkin2000;

  protected
    constructor Create(AOwner: TComponent); override;
    function GetResourceName: PAnsiChar; virtual; abstract;

  public
    procedure Reset; override;

  published
    property ParentFont;
    property SystemFont;
    property SystemCtl3D;
    property SystemShadow;
    property SystemSelectionFade;
    property Colors;
    property Margins;
    property Opacity;
    property Title;
    property Skin;
    property Ctl3D;
    property Animation;
    property Flags;
    property Font;
    property MenuBar;
    property Images;
    property DisabledImages;
    property HotImages;
    property Version;

  end;

procedure SaveSkinToFileFormat(const AComponent: TComponent; const Filename: String; const Format: Integer);
procedure LoadSkinFromFileFormat(const AComponent: TComponent; const Filename: String; const Format: Integer);
procedure SaveSkinToFile(const AComponent: TComponent; const Filename: String);
procedure LoadSkinFromFile(const AComponent: TComponent; const Filename: String);

implementation

uses
  Menus, 
  am2000, am2000mainmenu, am2000popupmenu, am2000menubar, am2000menuitem;

{ Routines }

procedure SaveSkinToFile;
var
  E: String;
  F: Integer;
begin
  F:= sfResource;
  E:= LowerCase(ExtractFileExt(Filename));
  if E = 'txt' then F:= sfText;
  if E = 'xml' then F:= sfXML;
  SaveSkinToFileFormat(AComponent, Filename, F);
end;

procedure LoadSkinFromFile;
var
  E: String;
  F: Integer;
begin
  F:= sfResource;
  E:= LowerCase(ExtractFileExt(Filename));
  if E = 'txt' then F:= sfText;
  if E = 'xml' then F:= sfXML;
  LoadSkinFromFileFormat(AComponent, Filename, F);
end;

procedure SaveSkinToFileFormat;
var
  S: TCustomAnimatedSkin2000;
begin
  if AComponent is TCustomAnimatedSkin2000
  then
    TCustomAnimatedSkin2000(AComponent).SaveToFile(Filename, Format)

  else
  if (AComponent is TCustomMainMenu2000)
  or (AComponent is TCustomPopupMenu2000)
  then begin
    S:= TAnimatedSkin2000.Create(nil);
    S.Assign(AComponent);
    S.SaveToFile(Filename, Format);
    S.Free;
  end;
end;

procedure LoadSkinFromFileFormat;
var
  S: TCustomAnimatedSkin2000;
begin
  if AComponent is TCustomAnimatedSkin2000
  then
    TCustomAnimatedSkin2000(AComponent).LoadFromFile(Filename, Format)

  else
  if (AComponent is TCustomMainMenu2000)
  or (AComponent is TCustomPopupMenu2000)
  then begin
    S:= TAnimatedSkin2000.Create(nil);
    S.LoadFromFile(Filename, Format);
    S.AssignTo(AComponent);
    S.Free;
  end;
end;


{ TCustomAnimatedSkin2000 }

constructor TCustomAnimatedSkin2000.Create;
begin
  inherited Create(AOwner);

  FAnimation:= anDefault;
  FSystemFont:= True;
  FOpacity:= 100;
  FCtl3D:= True;
  FSystemSelectionFade:= True;
end;

destructor TCustomAnimatedSkin2000.Destroy;
var
  P: TComponent;
begin
  FColors.Free;
  FTitle.Free;
  FMargins.Free;
  FSkin.Free;
  FSkin:= nil;

  if FMenus <> nil
  then
    while FMenus.Count > 0
    do begin
      P:= TComponent(FMenus[0]);
      TCustomAnimatedSkin2000(P).Notification(Self, opRemove);
      FMenus.Remove(P);
    end;

  FMenus.Free;
  FMenus:= nil;

  FMenuBar.Free;
  FMenubar:= nil;

  inherited;
end;

procedure TCustomAnimatedSkin2000.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove)
  and (FMenus <> nil)
  then FMenus.Remove(AComponent);
end;

procedure TCustomAnimatedSkin2000.Assign(Source: TPersistent);
var
  O: T_AM2000_Options;
begin
  if Source is TCustomAnimatedSkin2000
  then
    with TCustomAnimatedSkin2000(Source)
    do begin
      Self.FOpacity:= Opacity;
      Self.FCtl3D:=   Ctl3D;
      Self.FAnimation:= Animation;
      Self.FFlags:=     Flags;
      Self.FSystemCtl3D:=  SystemCtl3D;
      Self.FSystemShadow:= SystemShadow;
      Self.FSystemSelectionFade:= SystemSelectionFade;
      Self.FParentFont:= ParentFont;
      Self.FSystemFont:= SystemFont;
      Self.FImages:= Images;
      Self.FDisabledImages:= DisabledImages;
      Self.FHotImages:= HotImages;
      Self.Font:= Font;
      Self.Margins:= Margins;
      Self.Title:= Title;
      Self.Colors:= Colors;
      Self.Skin:= Skin;
    end

  else
  if Source is T_AM2000_Options
  then begin
    O:= T_AM2000_Options(Source);

    FOpacity:= T_AM2000_MenuOptions(O).Opacity;
    FFlags:= T_AM2000_MenuOptions(O).Flags;

    Margins:= O.Margins;
    Title:= O.Title;
    Colors:= O.Colors;
    Skin:= O.Skin;

    if Source is T_AM2000_MenuOptions
    then FAnimation:= T_AM2000_MenuOptions(Source).Animation;
  end

  else
  if Source is TCustomMainMenu2000
  then
    with TCustomMainMenu2000(Source)
    do begin
      Self.FCtl3D:= Ctl3D;
      Self.FSystemCtl3D:= SystemCtl3D;
      Self.FSystemShadow:= SystemShadow;
      Self.FSystemSelectionFade:= SystemSelectionFade;
      Self.FParentFont:= ParentFont;
      Self.FSystemFont:= SystemFont;
      Self.Font:= Font;
      Self.Assign(Options);
      Self.FImages:= Images;
      Self.FDisabledImages:= DisabledImages;
      Self.FHotImages:= HotImages;

      if MenuBar <> nil
      then begin
        Self.MenuBar.HotTrack:= MenuBar.HotTrack;
        Self.MenuBar.Transparent:= MenuBar.Transparent;
        Self.MenuBar.BorderIconsStyle:= MenuBar.Flat;
      end;
    end

  else
  if Source is TCustomPopupMenu2000
  then
    with TCustomPopupMenu2000(Source)
    do begin
      Self.FCtl3D:= Ctl3D;
      Self.FSystemCtl3D:= SystemCtl3D;
      Self.FSystemShadow:= SystemShadow;
      Self.FSystemSelectionFade:= SystemSelectionFade;
      Self.FParentFont:= ParentFont;
      Self.FSystemFont:= SystemFont;
      Self.Font:= Font;
      Self.FImages:= Images;
      Self.FDisabledImages:= DisabledImages;
      Self.FHotImages:= HotImages;
      Self.Assign(Options);
    end

  else
    inherited;

  UpdateMenus;
  GlobalRepaint;
  
end;

function TCustomAnimatedSkin2000.IsDefault: Boolean;
begin
  Result:=
    (FAnimation = anDefault) and
    (FOpacity = 100) and
    (FCtl3D) and
    (not FSystemCtl3D) and
    (not FSystemShadow) and
    (not FSystemSelectionFade) and
    (not HasColors) and
    (not HasMargins) and
    (not HasTitle) and
    (not HasSkin) and
    (not HasMenuBar);
end;

function TCustomAnimatedSkin2000.GetColors: T_AM2000_Colors;
begin
  if (FColors = nil)
  then FColors:= T_AM2000_Colors.Create(Self);

  if ComponentState * [csLoading, csReading, csDesigning] = []
  then SoftenColors(FColors, mfSoftColors in FFlags);

  Result:= FColors;
end;

function TCustomAnimatedSkin2000.GetMargins: T_AM2000_Margins;
begin
  if (FMargins = nil)
  then FMargins:= T_AM2000_Margins.Create(Self);
  Result:= FMargins;
end;

function TCustomAnimatedSkin2000.GetTitle: T_AM2000_Title;
begin
  if (FTitle = nil)
  then FTitle:= T_AM2000_Title.Create(Self);
  Result:= FTitle;
end;

procedure TCustomAnimatedSkin2000.SetTitle(Value: T_AM2000_Title);
begin
  if Value <> nil
  then
    Title.Assign(Value)
  else begin
    FTitle.Free;
    FTitle:= nil;
  end;
  UpdateMenus;
end;

procedure TCustomAnimatedSkin2000.SetColors(Value: T_AM2000_Colors);
begin
  if Value <> nil
  then Colors.Assign(Value)
  else begin
    FColors.Free;
    FColors:= nil;
  end;

  UpdateMenus;
end;

procedure TCustomAnimatedSkin2000.SetMargins(Value: T_AM2000_Margins);
begin
  if Value <> nil
  then Margins.Assign(Value)
  else begin
    FMargins.Free;
    FMargins:= nil;
  end;

  UpdateMenus;
end;

function TCustomAnimatedSkin2000.HasColors: Boolean;
begin
  Result:= (FColors <> nil) and (not FColors.IsDefault);
end;

function TCustomAnimatedSkin2000.HasMargins: Boolean;
begin
  Result:= (FMargins <> nil) and (not FMargins.IsDefault);
end;

function TCustomAnimatedSkin2000.HasTitle: Boolean;
begin
  Result:= (FTitle <> nil) and (not FTitle.IsDefault);
end;

function TCustomAnimatedSkin2000.GetSkin: T_AM2000_Skin;
begin
  if (FSkin = nil)
  then FSkin:= T_AM2000_Skin.Create(Self);
  Result:= FSkin;
end;

function TCustomAnimatedSkin2000.HasSkin: Boolean;
begin
  Result:= (FSkin <> nil) and (not FSkin.IsDefault);
end;

procedure TCustomAnimatedSkin2000.SetSkin(Value: T_AM2000_Skin);
begin
  if Value <> nil
  then
    Skin.Assign(Value)
  else begin
    FSkin.Free;
    FSkin:= nil;
  end;
  UpdateMenus;
end;

procedure TCustomAnimatedSkin2000.AssignTo(Dest: TPersistent);
var
  D: T_AM2000_Options;
  MB: TCustomMenuBar2000;
begin
  MB:= nil;
  if (Dest = nil)
  or (csDesigning in ComponentState)
  or not ((Dest is TCustomAnimatedSkin2000)
    or (Dest is T_AM2000_Options)
    or (Dest is TCustomMainMenu2000)
    or (Dest is TCustomPopupMenu2000)
    or (Dest is TMenuItem2000))
  then Exit;

  LockGlobalRepaint;

  if Dest is TCustomAnimatedSkin2000
  then
    TCustomAnimatedSkin2000(Dest).Assign(Self)
    
  else
  if Dest is T_AM2000_Options
  then begin
    D:= T_AM2000_Options(Dest);
    T_AM2000_MenuOptions(D).Opacity:= FOpacity;
    T_AM2000_MenuOptions(D).Flags:= FFlags;

    if D is T_AM2000_MenuOptions
    then T_AM2000_MenuOptions(D).Animation:= FAnimation;

    if HasSkin
    then D.Skin:= FSkin
    else D.Skin:= nil;

    if HasMargins
    then D.Margins:= FMargins
    else D.Margins:= nil;

    if HasTitle
    then D.Title:= FTitle
    else D.Title:= nil;

    if HasColors
    then D.Colors:= FColors
    else D.Colors:= nil;

  end

  else begin
    if FMenus = nil
    then FMenus:= TList.Create;

    if FMenus.IndexOf(Dest) = -1
    then FMenus.Add(Dest);

    if (Dest is TCustomMainMenu2000)
    then
      with TCustomMainMenu2000(Dest)
      do begin
        Ctl3D:= FCtl3D;
        SystemCtl3D:= FSystemCtl3D;
        SystemShadow:= FSystemShadow;
        SystemSelectionFade:= FSystemSelectionFade;
        ParentFont:= FParentFont;
        SystemFont:= FSystemFont;
        Font:= FFont;
        Images:= FImages;
        DisabledImages:= FDisabledImages;
        HotImages:= FHotImages;

        AssignTo(Options);

        if MenuBar <> nil
        then
          with Self.MenuBar
          do begin
            MenuBar.HotTrack:= HotTrack;
            MenuBar.Transparent:= Transparent;
            MenuBar.Flat:= BorderIconsStyle;
          end;

        UpdateFromOptions;
      end

    else
    if (Dest is TCustomPopupMenu2000)
    then
      with TCustomPopupMenu2000(Dest)
      do begin
        Ctl3D:= FCtl3D;
        SystemCtl3D:= FSystemCtl3D;
        SystemShadow:= FSystemShadow;
        SystemSelectionFade:= FSystemSelectionFade;
        ParentFont:= FParentFont;
        SystemFont:= FSystemFont;
        Font:= FFont;
        Images:= FImages;
        DisabledImages:= FDisabledImages;
        HotImages:= FHotImages;
        AssignTo(Options);
        UpdateFromOptions;
      end

    else
    if (Dest is TMenuItem2000)
    then
      with TMenuItem2000(Dest)
      do begin
        AssignTo(Options);
        UpdateFromOptions;
      end;

    MB:= GetMenuBarFromMenu(TMenu(Dest));
  end;

  UnlockGlobalRepaint;

  if MB <> nil
  then MB.Refresh;
end;

procedure TCustomAnimatedSkin2000.SetCtl3D(const Value: Boolean);
begin
  FSystemCtl3D:= False;
  FCtl3D:= Value;
  UpdateMenus;
end;

procedure TCustomAnimatedSkin2000.SetAnimation(
  const Value: T_AM2000_Animation);
begin
  FAnimation:= Value;
  UpdateMenus;
end;

procedure TCustomAnimatedSkin2000.Loaded;
begin
  inherited;
  UpdateMenus;
end;

procedure TCustomAnimatedSkin2000.UpdateMenus;
var
  I: Integer;
begin
  if (FMenus = nil)
  or (ComponentState * [csLoading, csDestroying, csDesigning] <> [])
  then Exit;

  for I:= 0 to FMenus.Count -1
  do
    AssignTo(TPersistent(FMenus[I]));
end;

procedure TCustomAnimatedSkin2000.SetFlags(const Value: T_AM2000_Flags);
begin
  FFlags:= Value;
  UpdateMenus;
end;

procedure TCustomAnimatedSkin2000.LoadFromFile(const Filename: String; const Format: Integer
  {$IFDEF Delphi4OrHigher} = 1{$ENDIF});
var
  F: TFileStream;
  B: TMemoryStream;
  Temp: TCustomAnimatedSkin2000;
begin
  Temp:= TAnimatedSkin2000.Create(nil);

  F:= nil;
  B:= nil;
  try
    F:= TFileStream.Create(Filename, fmOpenRead);
    case Format of
      sfResource:
        F.ReadComponentRes(Temp);

      sfText:
        try
          B:= TMemoryStream.Create;
          ObjectTextToBinary(F, B);

          B.Seek(0, soFromBeginning);
          B.ReadComponent(Temp);

        finally
          B.Free;
        end;

      sfXML:
        try
          B:= TMemoryStream.Create;
          ObjectXmlToBinary(F, B);

          B.Seek(0, soFromBeginning);
          B.ReadComponent(Temp);

        finally
          B.Free;
        end;

    end;

  finally
    F.Free;
  end;

  Assign(Temp);
  Temp.Free;
end;

procedure TCustomAnimatedSkin2000.SaveToFile(const Filename: String; const Format: Integer
  {$IFDEF Delphi4OrHigher} = 1{$ENDIF});
var
  F: TFileStream;
  B: TMemoryStream;
  Temp: TCustomAnimatedSkin2000;
begin
  Temp:= TAnimatedSkin2000.Create(nil);
  Temp.Assign(Self);

  F:= nil;
  B:= nil;
  try
    F:= TFileStream.Create(Filename, fmCreate);
    case Format of
      sfResource:
        F.WriteComponentRes(Name, Temp);

      sfText:
        try
          B:= TMemoryStream.Create;
          B.WriteComponent(Temp);
          B.Seek(0, soFromBeginning);
          ObjectBinaryToText(B, F);

        finally
          B.Free;
        end;

      sfXML:
        try
          B:= TMemoryStream.Create;
          B.WriteComponent(Temp);
          B.Seek(0, soFromBeginning);
          ObjectBinaryToXml(B, F);

        finally
          B.Free;
        end;

    end;

  finally
    F.Free;
  end;

  Temp.Free;
end;

function TCustomAnimatedSkin2000.IsFontStored: Boolean;
begin
  Result:= (FFont <> nil) and not (FSystemFont or FParentFont);
end;

function TCustomAnimatedSkin2000.GetFont: TFont;
begin
  if FFont = nil
  then FFont:= TFont.Create;
  Result:= FFont;
end;

procedure TCustomAnimatedSkin2000.SetFont(const Value: TFont);
begin
  if Value <> nil
  then begin
    FSystemFont:= False;
    FParentFont:= False;
    Font.Assign(Value);
  end
  else begin
    FFont.Free;
    FFont:= nil;
  end;

  UpdateMenus;
end;

procedure TCustomAnimatedSkin2000.SetParentFont(const Value: Boolean);
begin
  FParentFont:= Value;
  if Value
  then begin
    FSystemFont:= False;
    SetFont(nil);
  end;
  UpdateMenus;
end;

procedure TCustomAnimatedSkin2000.SetSystemFont(const Value: Boolean);
begin
  FSystemFont:= Value;
  if Value
  then begin
    FParentFont:= False;
    SetFont(nil);
  end;
  UpdateMenus;
end;

function TCustomAnimatedSkin2000.IsCtl3DStored: Boolean;
begin
  Result:= not FSystemCtl3D;
end;

procedure TCustomAnimatedSkin2000.Remove(Dest: TPersistent);
begin
  if FMenus <> nil
  then FMenus.Remove(Dest);
end;

procedure TCustomAnimatedSkin2000.Reset;
begin
  with TCustomAnimatedSkin2000.Create(nil)
  do begin
    AssignTo(Self);
    Free;
  end;
end;

procedure TCustomAnimatedSkin2000.SetMenuBar(
  const Value: T_AM2000_MenuBarOptions);
begin
  with MenuBar
  do begin
    HotTrack:= Value.HotTrack;
    Transparent:= Value.Transparent;
    BorderIconsStyle:= Value.BorderIconsStyle;
  end;
  
  UpdateMenus;
end;

function TCustomAnimatedSkin2000.HasMenuBar: Boolean;
begin
  Result:= (FMenuBar <> nil) and (not FMenuBar.IsDefault);
end;

function TCustomAnimatedSkin2000.GetMenuBar: T_AM2000_MenuBarOptions;
begin
  if FMenuBar = nil
  then FMenuBar:= T_AM2000_MenuBarOptions.Create(Self);

  Result:= FMenuBar;
end;

function TCustomAnimatedSkin2000.GetAnimation: T_AM2000_Animation;
begin
  Result:= FAnimation;
end;

function TCustomAnimatedSkin2000.GetCtl3D: Boolean;
begin
  Result:= FCtl3D;
end;

function TCustomAnimatedSkin2000.GetFlags: T_AM2000_Flags;
begin
  Result:= FFlags;
end;

function TCustomAnimatedSkin2000.GetOpacity: T_AM2000_Opacity;
begin
  Result:= FOpacity;
end;

function TCustomAnimatedSkin2000.GetParentFont: Boolean;
begin
  Result:= FParentFont;
end;

function TCustomAnimatedSkin2000.GetSystemCtl3D: Boolean;
begin
  Result:= FSystemCtl3D;
end;

function TCustomAnimatedSkin2000.GetSystemFont: Boolean;
begin
  Result:= FSystemFont;
end;

function TCustomAnimatedSkin2000.GetSystemSelectionFade: Boolean;
begin
  Result:= FSystemSelectionFade;
end;

function TCustomAnimatedSkin2000.GetSystemShadow: Boolean;
begin
  Result:= FSystemShadow;
end;

function TCustomAnimatedSkin2000.GetVersion: T_AM2000_Version;
begin
  Result:= SVersion;
end;

procedure TCustomAnimatedSkin2000.SetVersion(Value: T_AM2000_Version);
begin
end;

function TCustomAnimatedSkin2000.GetImages: TCustomImageList;
begin
  Result:= FImages;
end;

function TCustomAnimatedSkin2000.GetDisabledImages: TCustomImageList;
begin
  Result:= FDisabledImages;
end;

function TCustomAnimatedSkin2000.GetHotImages: TCustomImageList;
begin
  Result:= FHotImages;
end;

function TCustomAnimatedSkin2000.GetISkin: ISkin;
begin
  Result:= ISkin(Self);
end;

procedure TCustomAnimatedSkin2000.SetOpacity(
  const Value: T_AM2000_Opacity);
begin
  FOpacity:= Value;
  UpdateMenus;
end;


{ TResourceSkin2000 }

constructor TResourceSkin2000.Create;
begin
  inherited;

  if (not (csDesigning in ComponentState))
  or (AOwner = nil)
  or (csLoading in AOwner.ComponentState)
  then Exit;

  Reset;
end;

procedure TResourceSkin2000.Reset;
  // load resource
var
  F: TMemoryStream;
  H: HRSRC;
  P: Pointer;
  Size: Integer;
  G: HGlobal;
begin
  H:= FindResource(HInstance, GetResourceName, RT_RCDATA);
  if H = 0 then Exit;

  Size:= SizeOfResource(HInstance, H);
  G:= LoadResource(HInstance, H);
  P:= LockResource(G);
  F:= TMemoryStream.Create;

  F.WriteBuffer(P^, Size);
  F.Seek(0, 0);

  UnlockResource(H);

  Temp:= TAnimatedSkin2000.Create(nil);

  F.ReadResHeader;

  with TReader.Create(F, 4096)
  do try
    BeginReferences;
    try
      ReadSignature;
      ReadComponent(Temp);
      FixupReferences;
    finally
      EndReferences;
    end;
  finally
    Free;
  end;

//  F.ReadComponentRes(Temp);
  F.Free;

  Assign(Temp);
  Temp.Free;
end;

end.

