
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Component registraton unit                      }
{                                                       }
{       Copyright (c) 1997-2002 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit am2000reg;

{$I am2000.inc}
{$IFDEF Delphi2}
  {$DEFINE DesignTime}
{$ENDIF}

interface

procedure Register;

implementation

uses
  {$IFDEF Delphi3OrHigher} am2000shortcut, {$ENDIF}
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  {$IFDEF Delphi6OrHigher} DesignIntf, {$ELSE} DsgnIntf, {$ENDIF}
  am2000designer, am2000, am2000menuitem, am2000utils,
  {$IFDEF Delphi5OrHigher} am2000images,{$ENDIF}
  Classes, Controls,
  ColorBox2000,
  ColorMenu2000,
  EditboxMenu2000,
  FontMenu2000,
  SubMenu2000,
  SubMenu2000reg,
  BookmarkMenu2000,
  FavoritesMenu2000,
  FolderMenu2000,
  FolderMenu2000_RootEdit,
  FolderMenu2000_RootsEdit,
  ToolbarMenu2000,
  SystemMenu2000,
  ToolbarManager_Windows,
  CustomizeMenu2000,
  RecentFilesMenu2000,
  ToolsMenu2000,
  ToolsMenu2000_ToolsProperty,
{$IFDEF Delphi6OrHigher}
  ActionMenuBar2000,
{$ENDIF}
  am2000skin_OfficeAqua,
  am2000skin_OfficeOliveGreen,
  am2000skin_JavaMetal,
  am2000skin_CDEMotif,
  am2000skin_BlueMountain,
  am2000skin_Money,
  am2000skin_OfficeXP,
  am2000skin_RoundAClock,
  am2000skin_WindowsXPLuna,
  am2000skin_WindowsXPOliveGreen,
  am2000skin_WindowsXPSilver;


procedure Register;
begin
  RegisterComponents('Animated Menus', [TMenuBar2000, TMainMenu2000, TPopupMenu2000, TAnimatedSkin2000,
    TColorBox2000,
    TColorMenu2000,
    TSubMenu2000,
    TFontMenu2000,
    TEditboxMenu2000,
    TBookmarkMenu2000,
    TFavoritesMenu2000,
    TFolderMenu2000,
    TToolbarMenu2000,
    TSystemMenu2000,
    TToolbarManager_Windows,
    TCustomizeMenu2000,
    TRecentFilesMenu2000,
    TToolsMenu2000,
    TOfficeAqua,
    TOfficeOliveGreen,
    TJavaMetal,
    TCDEMotif,
    TBlueMountain,
    TOfficeXP,
    TMoney,
    TRoundAClock,
    TWindowsXPLuna,
    TWindowsXPOliveGreen,
    TWindowsXPSilver]);

  RegisterComponentEditor(TMainMenu2000, T_AM2000_ComponentEditor);
  RegisterComponentEditor(TPopupMenu2000, T_AM2000_ComponentEditor);
  RegisterComponentEditor(TAnimatedSkin2000, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TOfficeAqua, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TOfficeOliveGreen, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TJavaMetal, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TCDEMotif, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TBlueMountain, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TMoney, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TOfficeXP, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TRoundAClock, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TWindowsXPLuna, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TWindowsXPOliveGreen, T_AM2000_AnimatedSkinEditor);
  RegisterComponentEditor(TWindowsXPSilver, T_AM2000_AnimatedSkinEditor);

  RegisterPropertyEditor(TypeInfo(TEditableMenuItem2000), nil, '', T_AM2000_MenuDesigner);
{$IFDEF Delphi3OrHigher}
  RegisterPropertyEditor(TypeInfo(T_AM2000_ShortCut), nil, '', T_AM2000_ShortCutProperty);
{$ENDIF}
{$IFDEF Delphi5OrHigher}
  RegisterPropertyEditor(TypeInfo(T_AM2000_ImageIndex), nil, '', T_AM2000_ImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(T_AM2000_DefaultIndex), nil, '', T_AM2000_DefaultIndexProperty);
{$ENDIF}
  RegisterPropertyEditor(TypeInfo(T_AM2000_Version), nil, '', T_AM2000_VersionProperty);
  RegisterPropertyEditor(TypeInfo(T_AM2000_Root), nil, '', T_AM2000_RootProperty);
  RegisterPropertyEditor(TypeInfo(T_AM2000_Roots), nil, '', T_AM2000_RootsProperty);
  RegisterPropertyEditor(TypeInfo(T_AM2000_Tools), nil, '', T_AM2000_ToolsProperty);
end;

end.
