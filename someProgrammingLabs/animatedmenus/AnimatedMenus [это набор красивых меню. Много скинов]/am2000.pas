
{*************************************************************}
{                                                             }
{       Animated Menus                                        }
{       Advanced Office XP/Windows XP menu component          }
{       for Borland Delphi and C++Builder                     }
{                                                             }
{       Version 3.1 (build 735)                               }
{       Compiled 30.03.2003 19:59                             }
{                                                             }
{       Copyright (c) 1997-2003 AnimatedMenus.com, Inc.       }
{       All rights reserved.                                  }
{                                                             }
{       Web:     http://www.animatedmenus.com/                }
{       Support: http://www.animatedmenus.com/support/        }
{       Email:   Support@AnimatedMenus.com                    }
{       Info:    Info@AnimatedMenus.com                       }
{                                                             }
{       Visit our website at www.animatedmenus.com and        }
{       evaluate other software from AnimatedMenus.com!       }
{                                                             }
{*************************************************************}


unit am2000;

{$I am2000.inc}

interface

uses
  ComCtrls, ExtCtrls,
  am2000menubar, am2000mainmenu, am2000popupmenu, am2000skin;


type
  TMainMenu2000 = class(TCustomMainMenu2000)
  published
    property SystemCtl3D;
    property SystemShadow;
    property SystemSelectionFade;
    property Items;
    property Options;
    property Font;
    property ParentFont;
    property ShowHint;
    property ParentShowHint;
    property SystemFont;
    property Ctl3D;
    property StatusBar;
    property StatusBarIndex;
    property OnMenuCommand;
    property OnMenuClose;
    property OnCloseQuery;
    property OnContextMenu;

{$IFNDEF Delphi4OrHigher}
    property Images;
    property BiDiMode;
{$ENDIF}
    property DisabledImages;
    property HotImages;
    property Version;
    property AnimatedSkin;

  end;

  TMenuBar2000 = class(TCustomMenuBar2000)
  published
    property Transparent;
    property Version;
    property Visible;
    property Flat;
    property Align stored True;
    property Menu;
    property PopupMenu;
    property HotTrack;
    property OnPopup;

{$IFDEF Delphi4OrHigher}
    property DockSite;
    property DragKind;
    property DragMode;
{$ENDIF}

  end;

  TPopupMenu2000 = class(TCustomPopupMenu2000)
  published
    property SystemCtl3D;
    property SystemShadow;
    property SystemSelectionFade;
    property StatusBar;
    property StatusBarIndex;
    property ShowHint;
    property ParentShowHint;
    property Font;
    property ParentFont;
    property SystemFont;
    property Options;
    property Ctl3D;
{$IFNDEF Delphi4OrHigher}
    property Images;
    property BiDiMode;
{$ENDIF}
    property DisabledImages;
    property HotImages;

    property OnMenuCommand;
    property OnMenuClose;
    property OnCloseQuery;
    property OnContextMenu;

    property Version;
    property AnimatedSkin;
  end;

  TAnimatedSkin2000 = class(TCustomAnimatedSkin2000)
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

implementation

{$R am2000.res}

end.
