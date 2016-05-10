
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Menu options                                    }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000options;

{$I am2000.inc}

interface

uses
  {$IFDEF ActiveX} ActiveX, AnimatedMenusXP_TLB, {$ENDIF}
  Windows, Classes, Graphics, Menus, Controls, Dialogs,
  {$IFDEF Delphi4OrHigher} ImgList, {$ENDIF}
  am2000utils;

type
{$IFNDEF Delphi4OrHigher}
  TBiDiMode = (bdLeftToRight, bdRightToLeft, bdRightToLeftNoAlign, bdRightToLeftReadingOnly);
{$ENDIF}

{$IFNDEF ActiveX}
  T_AM2000_Persistent = TPersistent;
{$ELSE}
  T_AM2000_Persistent = class(TInterfacedPersistent, IDispatch)
  private
    FDispTypeInfo: ITypeInfo;
    FDispIntfEntry: PInterfaceEntry;

    function DispIntfEntry: PInterfaceEntry;
    function DispTypeInfo: ITypeInfo;

  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    function GetGUID: TGUID; virtual; abstract;

  end;

  T_AM2000_FlagsAdapter = class;
  T_AM2000_FontAdapter = class;
{$ENDIF}

  // flags
  T_AM2000_Flag = (
    mfAnimationOnSiblings,
    mfBitmapShadow, mfDropShadow, mfGradientSeparators, mfHiddenAsRegular, mfHiddenIsVisible,
    mfLeftAlignedShortCuts, mfLightenBitmaps, mfLongSeparators, 
    mfNoAutoShowHidden, mfNoBitmapRect, mfNoHighDisabled, mfNoSharpJoints,
    mfRaiseBitmaps, mfRaiseMenuBarItem, mfShowCheckMark, mfSoftColors,
    mfTinyShortCuts, mfXpControls);
  T_AM2000_Flags = set of T_AM2000_Flag;
  P_AM2000_Flags = ^T_AM2000_Flags;


  // animation effect
  T_AM2000_Animation = (anNone, anDefault,
    anVertRoll, anHorzRoll, anRoll, anDoubleRoll,
    anVertSlide, anHorzSlide, anSlide, anDoubleSlide,
    anVertStretch, anHorzStretch, anStretch, anDoubleStretch,
    anPopup, anFade, anRandom);


  // mouse state
  T_AM2000_MouseState = set of (msMouseOver, msLeftButton, msRightButton);

  // item state
  T_AM2000_its = (isChecked, isSelected, isDisabled, isHidden, isDefault,
    isRadio, isSubmenu, isHiddenPrev, isHiddenSucc, isSeparator,
    isGraphBack, isNoLeftSunken, isNoRightSunken, isFramed, isInsertBefore,
    isInsertAfter, isHorizontal, isShowAccelerators, isCtl3d, isPressed,
    isLeftToRight, isRightToLeft, isRightToLeftNoAlign, isRightToLeftReadingOnly,
    isMenuBarItem, isCheckable);
  T_AM2000_ItemState = set of T_AM2000_its;

  // background display
  T_AM2000_BackgroundLayout = (blDefault, blTile, blStretch, blExpandMenu, blSkin,
    blAtTopLeft, blAtTopCenter, blAtTopRight,
    blAtLeftCenter, blAtCenter, blAtRightCenter,
    blAtBottomLeft, blAtBottomCenter, blAtBottomRight);

  T_AM2000_FlatStyle = (bsDefault, bsWin31, bsWin95, bsWinXP);

  // title bar options
  T_AM2000_TextDirection = (tdForward, tdBackward);
  T_AM2000_TitlePosition = (atLeft, atRight, atTop, atBottom);
  T_AM2000_Gradient = (grLinear, grReflected, grDiamond, grBlocks);
  T_AM2000_GradientDirection = (gdHorizontal, gdVertical);



  T_AM2000_Options = class;
  T_AM2000_MenuOptions = class;
  ISkin = interface;


  // menu close event
  T_AM2000_MenuCloseEvent = procedure(Sender: TObject; Cancelled: Boolean) of object;

  // menu margins
  T_AM2000_Margins = class(T_AM2000_Persistent {$IFDEF ActiveX}, IMargins{$ENDIF})
  private
    Owner      : TObject;
    FMargins   : array [1..10] of Integer;

    procedure Changed;

{$IFDEF ActiveX}
    function  Get_Left: Integer; safecall;
    procedure Set_Left(Value: Integer); safecall;
    function  Get_Right: Integer; safecall;
    procedure Set_Right(Value: Integer); safecall;
    function  Get_Space: Integer; safecall;
    procedure Set_Space(Value: Integer); safecall;
    function  Get_Border: Integer; safecall;
    procedure Set_Border(Value: Integer); safecall;
    function  Get_Bevel: Integer; safecall;
    procedure Set_Bevel(Value: Integer); safecall;
    function  Get_Frame: Integer; safecall;
    procedure Set_Frame(Value: Integer); safecall;
    function  Get_Gutter: Integer; safecall;
    procedure Set_Gutter(Value: Integer); safecall;
    function  Get_Item: Integer; safecall;
    procedure Set_Item(Value: Integer); safecall;
    function  Get_Separator: Integer; safecall;
    procedure Set_Separator(Value: Integer); safecall;
{$ENDIF}

{$IFDEF ActiveX}
  protected
    function GetGUID: TGUID; override;
{$ENDIF}

  public
    function GetMargin(const Index: Integer): Integer;
    procedure SetMargin(const Index: Integer; const Value: Integer);

    constructor Create(AOwner: TObject);
    procedure Assign(Source: TPersistent); override;
    function IsDefault: Boolean;

  published
    property Bevel     : Integer index 01 read GetMargin write SetMargin default 0;
    property BevelInner: Integer index 02 read GetMargin write SetMargin default 0;
    property Border    : Integer index 03 read GetMargin write SetMargin default 1;
    property Frame     : Integer index 04 read GetMargin write SetMargin default 0;
    property Gutter    : Integer index 05 read GetMargin write SetMargin default 24;
    property Item      : Integer index 06 read GetMargin write SetMargin default 0;
    property Left      : Integer index 07 read GetMargin write SetMargin default 24;
    property Right     : Integer index 08 read GetMargin write SetMargin default 24;
    property Separator : Integer index 09 read GetMargin write SetMargin default 9;
    property Space     : Integer index 10 read GetMargin write SetMargin default 0;

  end;


  // T_AM2000_MenuItemRect
  T_AM2000_MenuItemRect = class
  public
    LineLeft         : Integer;
    LineRight        : Integer;
    ItemLeft         : Integer;
    ItemWidth        : Integer;
    ShortcutLeft     : Integer;
    ShortcutWidth    : Integer;
    BitmapLeft       : Integer;
    BitmapWidth      : Integer;
    TriangleLeft     : Integer;
    TriangleWidth    : Integer;
    LeftTitleWidth   : Integer;
    TitleWidth       : Integer;
    Top              : Integer;
    Height           : Integer;
    Border           : Integer;
    Ctl3DWidth       : Integer;
    Width            : Integer;
    GraphLeft        : Integer;
    GraphWidth       : Integer;

    function LineRect: TRect;
    function ItemRect: TRect;
    function ShortcutRect: TRect;
    function BitmapRect: TRect;
    function TriangleRect: TRect;

    procedure IncreaseOffset;
    procedure DecreaseOffset;
    procedure Clear;

    procedure Assign(Source: T_AM2000_MenuItemRect);

  end;


  // T_AM2000_PaintInfo
  P_AM2000_PaintMenuItemParams = ^T_AM2000_PaintMenuItemParams;
  T_AM2000_PaintMenuItemParams = record
    Canvas: TCanvas;
    Handle: HMenu;
    Index: Integer;
    Item: TMenuItem;
    PaintOptions: T_AM2000_MenuOptions;
    State: T_AM2000_ItemState;
    MousePos: TPoint;
    MouseState: T_AM2000_MouseState;
    mir: T_AM2000_MenuItemRect;
    FullRepaint: Boolean;
    Images: TCustomImageList;
    DisabledImages: TCustomImageList;
    HotImages: TCustomImageList;

{$IFDEF Delphi4OrHigher}
    Action: TBasicAction;
{$ENDIF}
  end;


  // menu colors
  T_AM2000_Colors = class(T_AM2000_Persistent {$IFDEF ActiveX}, IColors{$ENDIF})
  private
    AllowChanged     : Boolean;
    Owner            : TObject;
    FColors          : array [1..25] of TColor;

    procedure Changed;

{$IFDEF ActiveX}
    function  Get_Border: TxColor; safecall;
    procedure Set_Border(Value: TxColor); safecall;
    function  Get_Bevel: TxColor; safecall;
    procedure Set_Bevel(Value: TxColor); safecall;
    function  Get_BevelShadow: TxColor; safecall;
    procedure Set_BevelShadow(Value: TxColor); safecall;
    function  Get_DisabledShadow: TxColor; safecall;
    procedure Set_DisabledShadow(Value: TxColor); safecall;
    function  Get_DisabledText: TxColor; safecall;
    procedure Set_DisabledText(Value: TxColor); safecall;
    function  Get_Frame: TxColor; safecall;
    procedure Set_Frame(Value: TxColor); safecall;
    function  Get_FrameShadow: TxColor; safecall;
    procedure Set_FrameShadow(Value: TxColor); safecall;
    function  Get_Highlight: TxColor; safecall;
    procedure Set_Highlight(Value: TxColor); safecall;
    function  Get_HighlightText: TxColor; safecall;
    procedure Set_HighlightText(Value: TxColor); safecall;
    function  Get_Gutter: TxColor; safecall;
    procedure Set_Gutter(Value: TxColor); safecall;
    function  Get_Line: TxColor; safecall;
    procedure Set_Line(Value: TxColor); safecall;
    function  Get_LineShadow: TxColor; safecall;
    procedure Set_LineShadow(Value: TxColor); safecall;
    function  Get_Menu: TxColor; safecall;
    procedure Set_Menu(Value: TxColor); safecall;
    function  Get_MenuText: TxColor; safecall;
    procedure Set_MenuText(Value: TxColor); safecall;
    function  Get_Sunken: TxColor; safecall;
    procedure Set_Sunken(Value: TxColor); safecall;
    function  Get_SunkenText: TxColor; safecall;
    procedure Set_SunkenText(Value: TxColor); safecall;
    function  Get_Pressed: TxColor; safecall;
    procedure Set_Pressed(Value: TxColor); safecall;
    function  Get_PressedText: TxColor; safecall;
    procedure Set_PressedText(Value: TxColor); safecall;
{$ENDIF}

  protected
{$IFDEF ActiveX}
    function GetGUID: TGUID; override;
{$ENDIF}

  public
    SoftColors: Boolean;

    procedure SetColor(const Index: Integer; const Value: TColor);
    function GetColor(const Index: Integer): TColor;

    property BitmapShadow : TColor index 22 read GetColor write SetColor default clBlack;
    property CheckMark    : TColor index 23 read GetColor write SetColor default clBlack;
    property CheckMarkHigh: TColor index 24 read GetColor write SetColor default clBlack;
    property HiddenArrow  : TColor index 25 read GetColor write SetColor default clBlack;

    constructor Create(AOwner: TObject); virtual;
    procedure Assign(Source: TPersistent); override;
    function IsDefault: Boolean;


  published
    property Bevel           : TColor index 01 read GetColor write SetColor default clBtnShadow;
    property BevelShadow     : TColor index 02 read GetColor write SetColor default clBtnShadow;
    property BevelInner      : TColor index 03 read GetColor write SetColor default clBtnShadow;
    property BevelInnerShadow: TColor index 04 read GetColor write SetColor default clBtnShadow;
    property Border          : TColor index 05 read GetColor write SetColor default clMenu;
    property DisabledText    : TColor index 06 read GetColor write SetColor default clBtnShadow;
    property DisabledShadow  : TColor index 07 read GetColor write SetColor default clBtnHighlight;
    property DropShadow      : TColor index 08 read GetColor write SetColor default clBlack;
    property Frame           : TColor index 09 read GetColor write SetColor default clBtnHighlight;
    property FrameShadow     : TColor index 10 read GetColor write SetColor default clBtnShadow;
    property Gutter          : TColor index 11 read GetColor write SetColor default clNone;
    property Highlight       : TColor index 12 read GetColor write SetColor default clHighlight;
    property HighlightText   : TColor index 13 read GetColor write SetColor default clHighlightText;
    property Line            : TColor index 14 read GetColor write SetColor default clBtnShadow;
    property LineShadow      : TColor index 15 read GetColor write SetColor default clBtnHighlight;
    property Menu            : TColor index 16 read GetColor write SetColor default clMenu;
    property MenuText        : TColor index 17 read GetColor write SetColor default clMenuText;
    property Pressed         : TColor index 18 read GetColor write SetColor default clHighlight;
    property PressedText     : TColor index 19 read GetColor write SetColor default clHighlightText;
    property Sunken          : TColor index 20 read GetColor write SetColor default clNone;
    property SunkenText      : TColor index 21 read GetColor write SetColor default clMenuText;

  end;


  T_AM2000_Skin = class;
  T_AM2000_PaintBackgroundEvent = procedure (Sender: T_AM2000_Skin;
    const Canvas: TCanvas) of object;
  T_AM2000_PaintItemBackgroundEvent = procedure (Sender: T_AM2000_Skin;
    const Canvas: TCanvas; const State: T_AM2000_ItemState; R: TRect) of object;


  T_AM2000_Skin = class(T_AM2000_Persistent {$IFDEF ActiveX}, ISkin{$ENDIF})
  private
    Owner: TObject;

    FBitmaps: array [0..10] of TBitmap;
    FBackgroundLayout: T_AM2000_BackgroundLayout;
    FCWidth, FCHeight, FICWidth, FICHeight: Integer;
    FOnPaintBackground: T_AM2000_PaintBackgroundEvent;
    FOnPaintItemBackground: T_AM2000_PaintItemBackgroundEvent;
    FOnPaintUnhideBackground: T_AM2000_PaintItemBackgroundEvent;

    function GetBitmap(const Index: Integer): TBitmap;
    function IsBitmapStored(const Index: Integer): Boolean;
    procedure SetBitmap(const Index: Integer; const AValue: TBitmap);
    procedure SetBackgroundLayout(const Value: T_AM2000_BackgroundLayout);
    procedure SetCornerHeight(const Value: Integer);
    procedure SetCornerWidth(const Value: Integer);
    procedure SetItemCornerHeight(const Value: Integer);
    procedure SetItemCornerWidth(const Value: Integer);
    procedure SetOnPaintBackground(
      const Value: T_AM2000_PaintBackgroundEvent);
    procedure SetOnPaintItemBackground(
      const Value: T_AM2000_PaintItemBackgroundEvent);

    procedure Changed;

{$IFDEF ActiveX}
    function  Get_CornerWidth: Integer; safecall;
    procedure Set_CornerWidth(Value: Integer); safecall;
    function  Get_CornerHeight: Integer; safecall;
    procedure Set_CornerHeight(Value: Integer); safecall;
    function  Get_ItemCornerWidth: Integer; safecall;
    procedure Set_ItemCornerWidth(Value: Integer); safecall;
    function  Get_ItemCornerHeight: Integer; safecall;
    procedure Set_ItemCornerHeight(Value: Integer); safecall;
    function  Get_BackgroundLayout: TxBackgroundLayout; safecall;
    procedure Set_BackgroundLayout(Value: TxBackgroundLayout); safecall;
{$ENDIF}

{$IFDEF ActiveX}
  protected
    function GetGUID: TGUID; override;
{$ENDIF}

  public
    function IsBackgroundStored: Boolean;

    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function IsDefault: Boolean;

    constructor Create(AOwner: TObject);

    procedure PaintItemBackground(const Canvas: TCanvas; const State: T_AM2000_ItemState; R: TRect);
    procedure PaintUnhideBackground(const Canvas: TCanvas; const State: T_AM2000_ItemState; R: TRect);
    procedure PaintBackground(const Canvas: TCanvas; const Rect: TRect);
    procedure PaintBitmap(const Canvas: TCanvas; const ABitmap: TBitmap; const State: T_AM2000_ItemState; R: TRect);

  published
    property Unhide: TBitmap
      index 0 read GetBitmap write SetBitmap stored IsBitmapStored;
    property Triangle: TBitmap
      index 1 read GetBitmap write SetBitmap stored IsBitmapStored;
    property CheckMark: TBitmap
      index 2 read GetBitmap write SetBitmap stored IsBitmapStored;
    property Radio: TBitmap
      index 3 read GetBitmap write SetBitmap stored IsBitmapStored;
    property Background: TBitmap
      index 4 read GetBitmap write SetBitmap stored IsBitmapStored;
    property ItemBackgroundHighlight: TBitmap
      index 5 read GetBitmap write SetBitmap stored IsBitmapStored;
    property ItemBackgroundPressed: TBitmap
      index 6 read GetBitmap write SetBitmap stored IsBitmapStored;
    property ItemBackgroundSunken: TBitmap
      index 7 read GetBitmap write SetBitmap stored IsBitmapStored;
    property RaisedItemBackground: TBitmap
      index 8 read GetBitmap write SetBitmap stored IsBitmapStored;
    property UnhideBackgroundHighlight: TBitmap
      index 9 read GetBitmap write SetBitmap stored IsBitmapStored;
    property UnhideBackgroundPressed: TBitmap
      index 10 read GetBitmap write SetBitmap stored IsBitmapStored;

    property CornerWidth: Integer
      read FCWidth write SetCornerWidth default 0;
    property CornerHeight: Integer
      read FCHeight write SetCornerHeight default 0;
    property ItemCornerWidth: Integer
      read FICWidth write SetItemCornerWidth default 0;
    property ItemCornerHeight: Integer
      read FICHeight write SetItemCornerHeight default 0;
    property BackgroundLayout: T_AM2000_BackgroundLayout
      read FBackgroundLayout write SetBackgroundLayout default blDefault;

    property OnPaintBackground: T_AM2000_PaintBackgroundEvent
      read FOnPaintBackground write FOnPaintBackground;
    property OnPaintItemBackground: T_AM2000_PaintItemBackgroundEvent
      read FOnPaintItemBackground write FOnPaintItemBackground;
    property OnPaintUnhideBackground: T_AM2000_PaintItemBackgroundEvent
      read FOnPaintUnhideBackground write FOnPaintUnhideBackground;


  end;

  // menu title
  T_AM2000_Title = class(T_AM2000_Persistent {$IFDEF ActiveX}, ITitle{$ENDIF})
  private
    Owner            : TObject;
    
    R                : TRect;
    FPosition        : T_AM2000_TitlePosition;
    FAlignment       : TAlignment;
    FText            : String;
    FFont            : TFont;
{$IFDEF ActiveX}
    FFontAdapter     : T_AM2000_FontAdapter;
{$ENDIF}
    FColorBegin      : TColor;
    FColorEnd        : TColor;
    FWidth           : Integer;
    FDirection       : T_AM2000_TextDirection;
    FVisible         : Boolean;
    FBitmap          : TBitmap;
    FGradient        : T_AM2000_Gradient;
    FBuffer          : TBitmap;
    FGradientDirection: T_AM2000_GradientDirection;

    procedure Changed;
    function IsBitmapStored: Boolean;
    function IsFontStored: Boolean;
    function GetBitmap: TBitmap;
    function GetFont: TFont;
    procedure SetPosition(const Value: T_AM2000_TitlePosition);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetBitmap(Value: TBitmap);
    procedure SetColorBegin(const Value: TColor);
    procedure SetColorEnd(const Value: TColor);
    procedure SetDirection(const Value: T_AM2000_TextDirection);
    procedure SetFont(Value: TFont);
    procedure SetGradient(const Value: T_AM2000_Gradient);
    procedure SetText(const Value: String);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
    procedure SetGradientDirection(const Value: T_AM2000_GradientDirection);

{$IFDEF ActiveX}
    function  Get_Position: TxTitlePosition; safecall;
    procedure Set_Position(Value: TxTitlePosition); safecall;
    function  Get_Alignment: TxAlignment; safecall;
    procedure Set_Alignment(Value: TxAlignment); safecall;
    function  Get_Text: WideString; safecall;
    procedure Set_Text(const Value: WideString); safecall;
    function  Get_Font: IFont; safecall;
    function  Get_ColorBegin: TxColor; safecall;
    procedure Set_ColorBegin(Value: TxColor); safecall;
    function  Get_ColorEnd: TxColor; safecall;
    procedure Set_ColorEnd(Value: TxColor); safecall;
    function  Get_Width: Integer; safecall;
    procedure Set_Width(Value: Integer); safecall;
    function  Get_TextDirection: TxTextDirection; safecall;
    procedure Set_TextDirection(Value: TxTextDirection); safecall;
    function  Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function  Get_Gradient: TxGradient; safecall;
    procedure Set_Gradient(Value: TxGradient); safecall;
    function Get_GradientDirection: TxGradientDirection;
    procedure Set_GradientDirection(Value: TxGradientDirection);
{$ENDIF}

{$IFDEF ActiveX}
  protected
    function GetGUID: TGUID; override;
{$ENDIF}

  public
    constructor Create(AOwner: TObject);
    
    destructor Destroy; override;
    procedure Paint(ACanvas: TCanvas; Offset, OffsetTitle: Integer);
    procedure PaintRect(Canvas: TCanvas; Rect: TRect);
    function TextAlign(Width, TextWidth: Integer): Integer;
    procedure Assign(Source: TPersistent); override;
    function IsDefault: Boolean;
    procedure ResetBuffer;

  published
    property Position   : T_AM2000_TitlePosition
      read FPosition write SetPosition default atLeft;
    property Alignment  : TAlignment
      read FAlignment write SetAlignment default taLeftJustify;
    property Text       : String
      read FText write SetText;
    property Font       : TFont
      read GetFont write SetFont stored IsFontStored;
    property ColorBegin : TColor
      read FColorBegin write SetColorBegin default clBlue;
    property ColorEnd   : TColor
      read FColorEnd write SetColorEnd default clBlack;
    property Width      : Integer
      read FWidth write SetWidth default 50;
    property TextDirection : T_AM2000_TextDirection
      read FDirection write SetDirection default tdForward;
    property Visible       : Boolean
      read FVisible write SetVisible default False;
    property Bitmap        : TBitmap
      read GetBitmap write SetBitmap stored IsBitmapStored;
    property Gradient      : T_AM2000_Gradient
      read FGradient write SetGradient default grLinear;
    property GradientDirection: T_AM2000_GradientDirection
      read FGradientDirection write SetGradientDirection default gdVertical;

  end;


{  T_AM2000_Bitmaps = class;

  // background
  T_AM2000_Background = class(T_AM2000_Persistent)
  private
    FOwner: T_AM2000_Bitmaps;
    FBackground: TBitmap;
    FBackgroundLayout: T_AM2000_BackgroundLayout;
    FFixedHeight: Integer;
    FFixedWidth: Integer;

    procedure SetBackground(const Value: TBitmap);
    function GetBackground: TBitmap;
    procedure SetBackgroundLayout(const Value: T_AM2000_BackgroundLayout);
    function IsBackgroundStored: Boolean;

  protected
    procedure Changed; virtual;

  public
    constructor Create(AOwner: T_AM2000_Bitmaps);
    destructor Destroy; override;

  published
    property Bitmap: TBitmap
      read GetBackground write SetBackground stored IsBackgroundStored;
    property Layout: T_AM2000_BackgroundLayout
      read FBackgroundLayout write SetBackgroundLayout default blDefault;
    property FixedHeight: Integer
      read FFixedHeight write FFixedHeight default 0;
    property FixedWidth: Integer
      read FFixedWidth write FFixedWidth default 0;

  end;

  T_AM2000_Marks = class(T_AM2000_Persistent)
  private
    FOwner: T_AM2000_Bitmaps;
    FBitmap: TBitmap;

  public
    constructor Create(AOwner: T_AM2000_Bitmaps);
    destructor Destroy; override;

  published
    property Check: TBitmap read FBitmap write FBitmap stored False;
    property Radio: TBitmap read FBitmap write FBitmap stored False;
    property Submenu: TBitmap read FBitmap write FBitmap stored False;
    property Dropdown: TBitmap read FBitmap write FBitmap stored False;
    property Unhide: TBitmap read FBitmap write FBitmap stored False;
    property Drag: TBitmap read FBitmap write FBitmap stored False;

  end;  


  T_AM2000_Bitmaps = class(T_AM2000_Persistent)
  private
    FOwner: T_AM2000_Options;
    FToolbar: T_AM2000_Background;
    FItem: T_AM2000_Background;
    FMenu: T_AM2000_Background;
    FMarks: T_AM2000_Marks;
    FSeparator: TBitmap;
    procedure SetItem(const Value: T_AM2000_Background);
    procedure SetMarks(const Value: T_AM2000_Marks);
    procedure SetMenu(const Value: T_AM2000_Background);
    procedure SetSeparator(const Value: TBitmap);
    procedure SetToolbar(const Value: T_AM2000_Background);

  public
    constructor Create(AOwner: T_AM2000_Options); virtual;
    destructor Destroy; override;
    function IsDefault: Boolean;

  published
    property Menu: T_AM2000_Background read FMenu write SetMenu stored False;
    property Item: T_AM2000_Background read FItem write SetItem stored False;
    property Toolbar: T_AM2000_Background read FToolbar write SetToolbar stored False;
//    property Marks: T_AM2000_Marks read FMarks write SetMarks stored False;
//    property Separator: TBitmap read FSeparator write SetSeparator stored False;

  end;}


  T_AM2000_AnimatedSkin = class(TComponent)
  public
    procedure AssignTo(Dest: TPersistent); override;
    procedure Remove(Dest: TPersistent); virtual;
    procedure UpdateMenus; virtual;
    function GetISkin: ISkin; virtual;
  end;


  // menu options
  T_AM2000_Options = class(T_AM2000_Persistent {$IFDEF ActiveX}, IOptions{$ENDIF})
  private
    FTitle             : T_AM2000_Title;
    FColors            : T_AM2000_Colors;
    FMargins           : T_AM2000_Margins;
    FTextAlignment     : TAlignment;
    FFlags             : T_AM2000_Flags;
    FDraggable         : Boolean;
    FCustomizable      : Boolean;
    FOpacity           : T_AM2000_Opacity;
    FCaption           : String;
    FSkin              : T_AM2000_Skin;
    FParentColors      : Boolean;
    FParentTitle       : Boolean;
    FParentSkin        : Boolean;
    FParentMargins     : Boolean;
//    FBitmaps           : T_AM2000_Bitmaps;
//    FParentBitmaps     : Boolean;

    function GetTitle: T_AM2000_Title;
    function GetColors: T_AM2000_Colors;
    function GetMargins: T_AM2000_Margins;
    function GetSkin: T_AM2000_Skin;
//    function GetBitmaps: T_AM2000_Bitmaps;
    function GetCtl3D: Boolean;

    procedure SetColors(Value: T_AM2000_Colors);
    procedure SetTitle(Value: T_AM2000_Title);
    procedure SetMargins(Value: T_AM2000_Margins);
    procedure SetSkin(Value: T_AM2000_Skin);
//    procedure SetBitmaps(Value: T_AM2000_Bitmaps);
    procedure SetCtl3D(const Value: Boolean);
    procedure SetParentColors(const Value: Boolean);
    procedure SetParentMargins(const Value: Boolean);
    procedure SetParentSkin(const Value: Boolean);
    procedure SetParentTitle(const Value: Boolean);
//    procedure SetParentBitmaps(const Value: Boolean);

    function IsColorsStored: Boolean;
    function IsMarginsStored: Boolean;
    function IsSkinStored: Boolean;
    function IsTitleStored: Boolean;
//    function IsBitmapsStored: Boolean;
    function OwnerHasNoSkin: Boolean;

    procedure Changed;

{$IFDEF ActiveX}
    function  Get_Alignment: TxAlignment; safecall;
    procedure Set_Alignment(Value: TxAlignment); safecall;
    function  Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function  Get_Draggable: WordBool; safecall;
    procedure Set_Draggable(Value: WordBool); safecall;
    function  Get_Customizable: WordBool; safecall;
    procedure Set_Customizable(Value: WordBool); safecall;
    function  Get_Margins: IMargins; safecall;
    function  Get_Colors: IColors; safecall;
    function  Get_Title: ITitle; safecall;
    function  Get_Skin: ISkin; safecall;
{$ENDIF}

  protected
    Owner: TPersistent;

    property Flags           : T_AM2000_Flags
      read FFlags write FFlags default [];
    property ParentColors: Boolean
      read FParentColors write SetParentColors default False;
    property ParentMargins: Boolean
      read FParentMargins write SetParentMargins default False;
    property ParentTitle: Boolean
      read FParentTitle write SetParentTitle default False;
    property ParentSkin: Boolean
      read FParentSkin write SetParentSkin default False;
    property Opacity         : T_AM2000_Opacity
      read FOpacity write FOpacity default 100;

  public
    constructor Create(AOwner: TPersistent); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignPropertiesOnly(Source: TPersistent; const AllProperties: Boolean); virtual;

    function IsDefault: Boolean; virtual;

    function HasColors: Boolean;
    function HasTitle: Boolean;
    function HasMargins: Boolean;
    function HasSkin: Boolean;

  published
    property Alignment       : TAlignment
      read FTextAlignment write FTextAlignment default taLeftJustify;
    property Caption         : String
      read FCaption write FCaption;
    property Colors          : T_AM2000_Colors
      read GetColors write SetColors stored IsColorsStored;
    property Draggable       : Boolean
      read FDraggable write FDraggable default False;
    property Customizable    : Boolean
      read FCustomizable write FCustomizable default False;
    property Margins         : T_AM2000_Margins
      read GetMargins write SetMargins stored IsMarginsStored;
    property Title           : T_AM2000_Title
      read GetTitle write SetTitle stored IsTitleStored;
    property Skin            : T_AM2000_Skin
      read GetSkin write SetSkin stored IsSkinStored;

  end;

  T_AM2000_ItemOptions = class(T_AM2000_Options {$IFDEF ActiveX}, IItemOptions{$ENDIF})
{$IFDEF ActiveX}
  private
    function  Get_ParentColors: WordBool; safecall;
    procedure Set_ParentColors(Value: WordBool); safecall;
    function  Get_ParentMargins: WordBool; safecall;
    procedure Set_ParentMargins(Value: WordBool); safecall;
    function  Get_ParentTitle: WordBool; safecall;
    procedure Set_ParentTitle(Value: WordBool); safecall;
    function  Get_ParentSkin: WordBool; safecall;
    procedure Set_ParentSkin(Value: WordBool); safecall;
  
  protected
    function GetGUID: TGUID; override;
{$ENDIF}

  public
    constructor Create(AOwner: TPersistent); override;
    function IsDefault: Boolean; override;

  published
    property ParentColors default True;
    property ParentMargins default True;
    property ParentTitle default True;
    property ParentSkin default True;
  end;

  T_AM2000_MenuOptions = class(T_AM2000_Options {$IFDEF ActiveX}, IMenuOptions{$ENDIF})
  private
    FAnimation   : T_AM2000_Animation;

{$IFDEF ActiveX}
    FFlagsAdapter: T_AM2000_FlagsAdapter;


    function  Get_Animation: TxAnimation; safecall;
    procedure Set_Animation(Value: TxAnimation); safecall;
    function  Get_Opacity: TxOpacity; safecall;
    procedure Set_Opacity(Value: TxOpacity); safecall;
    function  Get_Flags: IFlags; safecall;

  protected
    function GetGUID: TGUID; override;
{$ENDIF}

  public
    constructor Create(AOwner: TPersistent); override;
{$IFDEF ActiveX}
    destructor Destroy; override;
{$ENDIF}

    procedure AssignPropertiesOnly(Source: TPersistent; const AllProperties: Boolean); override;
    function IsDefault: Boolean; override;

  published
    property Flags;
    property Opacity;
    property Animation   : T_AM2000_Animation
      read FAnimation write FAnimation default anDefault;

  end;


  // Basic Control Options class
  T_AM2000_MenuControl = class(TPersistent)
  protected
    Parent: TMenuItem;
    FreeOnRelease, ReleaseBlock: Boolean;

    procedure Repaint;
    procedure BlockRelease(Block: Boolean);

  public
    constructor Create(AParent: TMenuItem); virtual;

    procedure Assign(Source: TPersistent); override;

    // drawing routine
    procedure Paint(Params: P_AM2000_PaintMenuItemParams); virtual;

    // bounds routines
    function GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer; virtual;
    function GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer; virtual;

    // key management routines
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPress(var Key: Char); virtual;

    procedure Click; virtual;

    procedure Release;

  end;

  
  T_AM2000_MenuBarOptions = class(TPersistent)
  private
    FSkin: T_AM2000_AnimatedSkin;
    FHotTrack: Boolean;
    FTransparent: Boolean;
    FBorderIconsStyle: T_AM2000_FlatStyle;

  public
    constructor Create(ASkin: T_AM2000_AnimatedSkin);

    procedure UpdateMenus;
    function IsDefault: Boolean;

  published
    property HotTrack: Boolean
      read FHotTrack write FHotTrack default False;
    property Transparent: Boolean
      read FTransparent write FTransparent default False;
    property BorderIconsStyle: T_AM2000_FlatStyle
      read FBorderIconsStyle write FBorderIconsStyle default bsDefault;

  end;

  ISkin = interface
    function HasColors: Boolean;
    function HasTitle: Boolean;
    function HasMargins: Boolean;
    function HasSkin: Boolean;
    function Colors: T_AM2000_Colors;
    function Margins: T_AM2000_Margins;
    function Opacity: T_AM2000_Opacity;
    function Title: T_AM2000_Title;
    function Skin: T_AM2000_Skin;
    function Ctl3D: Boolean;
    function Animation: T_AM2000_Animation;
    function Flags: T_AM2000_Flags;
    function Font: TFont;
    function SystemFont: Boolean;
    function ParentFont: Boolean;
    function SystemCtl3D: Boolean;
    function SystemShadow: Boolean;
    function SystemSelectionFade: Boolean;
    function Images: TCustomImageList;
    function DisabledImages: TCustomImageList;
    function HotImages: TCustomImageList;

  end;

  T_AM2000_Designer = class
  public
    procedure Modified; virtual; abstract; 
    procedure SelectComponent(const AComponent: TComponent); virtual; abstract;
    procedure ShowMethod(const AComponent: TComponent; const EventName: String); virtual; abstract;
  end;



{$IFDEF ActiveX}
  T_AM2000_FlagsAdapter = class(T_AM2000_Persistent, IFlags)
  private
    FFlagsPtr: P_AM2000_Flags;

    function  Get_mfBitmapShadow: WordBool; safecall;
    procedure Set_mfBitmapShadow(Value: WordBool); safecall;
    function  Get_mfDropShadow: WordBool; safecall;
    procedure Set_mfDropShadow(Value: WordBool); safecall;
    function  Get_mfHiddenAsRegular: WordBool; safecall;
    procedure Set_mfHiddenAsRegular(Value: WordBool); safecall;
    function  Get_mfHiddenIsVisible: WordBool; safecall;
    procedure Set_mfHiddenIsVisible(Value: WordBool); safecall;
    function  Get_mfLightenBitmaps: WordBool; safecall;
    procedure Set_mfLightenBitmaps(Value: WordBool); safecall;
    function  Get_mfNoAutoShowHidden: WordBool; safecall;
    procedure Set_mfNoAutoShowHidden(Value: WordBool); safecall;
    function  Get_mfNoBitmapRect: WordBool; safecall;
    procedure Set_mfNoBitmapRect(Value: WordBool); safecall;
    function  Get_mfNoHighDisabled: WordBool; safecall;
    procedure Set_mfNoHighDisabled(Value: WordBool); safecall;
    function  Get_mfNoShortDividers: WordBool; safecall;
    procedure Set_mfNoShortDividers(Value: WordBool); safecall;
    function  Get_mfRaiseBitmaps: WordBool; safecall;
    procedure Set_mfRaiseBitmaps(Value: WordBool); safecall;
    function  Get_mfRaiseMenuBarItem: WordBool; safecall;
    procedure Set_mfRaiseMenuBarItem(Value: WordBool); safecall;
    function  Get_mfShowCheckMark: WordBool; safecall;
    procedure Set_mfShowCheckMark(Value: WordBool); safecall;
    function  Get_mfSoftColors: WordBool; safecall;
    procedure Set_mfSoftColors(Value: WordBool); safecall;
    function  Get_mfStandardAlign: WordBool; safecall;
    procedure Set_mfStandardAlign(Value: WordBool); safecall;
    function  Get_mfXpControls: WordBool; safecall;
    procedure Set_mfXpControls(Value: WordBool); safecall;

  protected
    function GetGUID: TGUID; override;

  public
    constructor Create(AFlagsPtr: P_AM2000_Flags);

  end;

  T_AM2000_FontAdapter = class(T_AM2000_Persistent, IFont)
  private
    FFont: TFont;

  protected
    function  Get_Name: WideString; safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function  Get_Size: SmallInt; safecall;
    procedure Set_Size(Value: SmallInt); safecall;
    function  Get_Bold: WordBool; safecall;
    procedure Set_Bold(Value: WordBool); safecall;
    function  Get_Italic: WordBool; safecall;
    procedure Set_Italic(Value: WordBool); safecall;
    function  Get_Underline: WordBool; safecall;
    procedure Set_Underline(Value: WordBool); safecall;
    function  Get_StrikeThrough: WordBool; safecall;
    procedure Set_StrikeThrough(Value: WordBool); safecall;
    function  Get_Charset: Smallint; safecall;
    procedure Set_Charset(Value: Smallint); safecall;

  protected
    function GetGUID: TGUID; override;

  public
    constructor Create(AFont: TFont);

  end;
{$ENDIF}



const
  anFadeIn = anFade;
  anHSlide = anHorzSlide;
  anVSlide = anVertSlide;
  anSmart = anSlide;
  anUnfold = anDoubleSlide;
  fsDefault = bsDefault;
  fsWin31 = bsWin31;
  fsWin95 = bsWin95;
  fsWinXP = bsWinXP;
  mfNoShortDividers = mfLongSeparators;
  mfNewCheckMarks = mfXpControls;
  mfStandardAlign = mfLeftAlignedShortCuts;


  anStretchAnimations = [anStretch, anVertStretch, anHorzStretch, anDoubleStretch];
  anRollAnimations = [anRoll, anVertRoll, anHorzRoll, anDoubleRoll];
  anVerticalAnimations = [anVertSlide, anVertStretch, anVertRoll, anDoubleSlide, anDoubleStretch, anDoubleRoll];
  anHorizontalAnimations = [anHorzSlide, anHorzStretch, anHorzRoll, anDoubleSlide, anDoubleStretch, anDoubleRoll];

  AnimationToStr: array [T_AM2000_Animation] of String =
    ('anNone', 'anDefault',
     'anVertRoll', 'anHorzRoll', 'anRoll', 'anDoubleRoll',
     'anVertSlide', 'anHorzSlide', 'anSlide', 'anDoubleSlide',
     'anVertStretch', 'anHorzStretch', 'anStretch', 'anDoubleStretch',
     'anPopup', 'anFade', 'anRandom');
  FlagToStr: array [T_AM2000_Flag] of String =
    ('mfAnimationOnSiblings', 'mfBitmapShadow', 'mfDropShadow', 'mfGradientSeparators',
     'mfHiddenAsRegular', 'mfHiddenIsVisible', 'mfLeftAlignedShortCuts', 
     'mfLightenBitmaps', 'mfLongSeparators',
     'mfNoAutoShowHidden', 'mfNoBitmapRect', 'mfNoHighDisabled', 'mfNoSharpJoints',
     'mfRaiseBitmaps', 'mfRaiseMenuBarItem', 'mfShowCheckMark', 'mfSoftColors', 
     'mfTinyShortCuts', 'mfXpControls');

  IID_ISkin: TGUID = '{B80C575C-90DD-46f5-91DE-526650E7884F}';
  IID_IImages: TGUID = '{DB402871-5F54-4fb3-AB1C-8FDA72836DC5}';

  FormDesigner: T_AM2000_Designer = nil;

const
  BiDiModeToState: array [TBiDiMode] of T_AM2000_its =
    (isLeftToRight, am2000options.isRightToLeft, isRightToLeftNoAlign, isRightToLeftReadingOnly);


var
  PaintParams: T_AM2000_PaintMenuItemParams;


function StrToAnimation(const S: String): T_AM2000_Animation;
function StrToFlag(const S: String): T_AM2000_Flag;
procedure SoftenColors(const AColors: T_AM2000_Colors; const SoftType: Boolean);

implementation

uses
  SysUtils, Forms,
  am2000menubar, am2000mainmenu, am2000popupmenu, am2000menuitem
  {$IFDEF ActiveX}, ComServ{$ENDIF};


{ StrToAnimation }

function StrToAnimation(const S: String): T_AM2000_Animation;
var
  C: T_AM2000_Animation;
begin
  for C:= Low(T_AM2000_Animation) to High(T_AM2000_Animation)
  do
    if AnimationToStr[C] = S
    then begin
      Result:= C;
      Exit;
    end;

  Result:= Low(T_AM2000_Animation);
end;


{ StrToFlag }

function StrToFlag(const S: String): T_AM2000_Flag;
var
  C: T_AM2000_Flag;
begin
  for C:= Low(T_AM2000_Flag) to High(T_AM2000_Flag)
  do
    if FlagToStr[C] = S
    then begin
      Result:= C;
      Exit;
    end;

  Result:= Low(T_AM2000_Flag);
end;



{ T_AM2000_Margins }

const
  DefaultMargins: array [1..10] of Integer = (0, 0, 1, 0, 24, 0, 24, 24, 9, 0);


constructor T_AM2000_Margins.Create(AOwner: TObject);
var
  I: Integer;
begin
  inherited Create;

  Owner:= AOwner;

  for I:= 1 to High(FMargins)
  do FMargins[I]:= DefaultMargins[I];
end;

procedure T_AM2000_Margins.Changed;
begin
  if Owner is T_AM2000_AnimatedSkin
  then
    T_AM2000_AnimatedSkin(Owner).UpdateMenus
  else
  if Owner is T_AM2000_Options
  then
    with T_AM2000_Options(Owner)
    do begin
      Changed;
      ParentMargins:= False;
    end;
end;

procedure T_AM2000_Margins.Assign(Source: TPersistent);
var
  Src: T_AM2000_Margins;
  I: Integer;
begin
  if Source is T_AM2000_Margins
  then begin
    Src:= T_AM2000_Margins(Source);

    for I:= 1 to High(FMargins)
    do FMargins[I]:= Src.FMargins[I];
  end
  else
    inherited;
end;

function T_AM2000_Margins.IsDefault: Boolean;
var
  I: Integer;
begin
  Result:= True;
  
  for I:= 1 to High(FMargins)
  do Result:= Result and (FMargins[I] = DefaultMargins[I]);
end;

function T_AM2000_Margins.GetMargin(const Index: Integer): Integer;
begin
  Result:= FMargins[Index];
end;

procedure T_AM2000_Margins.SetMargin(const Index: Integer; const Value: Integer);
begin
  if FMargins[Index] <> Value
  then begin
    FMargins[Index]:= Value;
    Changed;
  end;
end;


{$IFDEF ActiveX}
function T_AM2000_Margins.Get_Bevel: Integer;
begin
  Result:= Bevel;
end;

function T_AM2000_Margins.Get_Border: Integer;
begin
  Result:= Border;
end;

function T_AM2000_Margins.Get_Frame: Integer;
begin
  Result:= Frame;
end;

function T_AM2000_Margins.Get_Gutter: Integer;
begin
  Result:= Gutter;
end;

function T_AM2000_Margins.Get_Item: Integer;
begin
  Result:= Item;
end;

function T_AM2000_Margins.Get_Left: Integer;
begin
  Result:= Left;
end;

function T_AM2000_Margins.Get_Right: Integer;
begin
  Result:= Right;
end;

function T_AM2000_Margins.Get_Separator: Integer;
begin
  Result:= Separator;
end;

function T_AM2000_Margins.Get_Space: Integer;
begin
  Result:= Space;
end;

procedure T_AM2000_Margins.Set_Bevel(Value: Integer);
begin
  Bevel:= Value;
end;

procedure T_AM2000_Margins.Set_Border(Value: Integer);
begin
  Border:= Value;
end;

procedure T_AM2000_Margins.Set_Frame(Value: Integer);
begin
  Frame:= Value;
end;

procedure T_AM2000_Margins.Set_Gutter(Value: Integer);
begin
  Gutter:= Value;
end;

procedure T_AM2000_Margins.Set_Item(Value: Integer);
begin
  Item:= Value;
end;

procedure T_AM2000_Margins.Set_Left(Value: Integer);
begin
  Left:= Value;
end;

procedure T_AM2000_Margins.Set_Right(Value: Integer);
begin
  Right:= Value;
end;

procedure T_AM2000_Margins.Set_Separator(Value: Integer);
begin
  Separator:= Value;
end;

procedure T_AM2000_Margins.Set_Space(Value: Integer);
begin
  Space:= Value;
end;

function T_AM2000_Margins.GetGUID: TGUID;
begin
  Result:= IID_IMargins;
end;
{$ENDIF}


{ T_AM2000_MenuItemRect }

function T_AM2000_MenuItemRect.LineRect: TRect;
begin
  Result:= Rect(LineLeft, Top, LineRight, Top + Height);
end;

function T_AM2000_MenuItemRect.ItemRect: TRect;
begin
  Result:= Rect(ItemLeft, Top, ItemLeft + ItemWidth, Top + Height);
end;

function T_AM2000_MenuItemRect.ShortcutRect: TRect;
begin
  Result:= Rect(ShortcutLeft, Top, ShortcutLeft + ShortcutWidth, Top + Height);
end;

function T_AM2000_MenuItemRect.BitmapRect: TRect;
begin
  Result:= Rect(BitmapLeft, Top, BitmapLeft + BitmapWidth, Top + Height);
end;

function T_AM2000_MenuItemRect.TriangleRect: TRect;
begin
  Result:= Rect(TriangleLeft, Top, TriangleLeft + TriangleWidth, Top + Height);
end;

procedure T_AM2000_MenuItemRect.IncreaseOffset;
begin
  Inc(LineLeft);
  Inc(LineRight);
  Inc(ItemLeft);
  Inc(ShortcutLeft);
  Inc(BitmapLeft);
  Inc(TriangleLeft);
  Inc(Top);
end;

procedure T_AM2000_MenuItemRect.DecreaseOffset;
begin
  Dec(LineLeft);
  Dec(LineRight);
  Dec(ItemLeft);
  Dec(ShortcutLeft);
  Dec(BitmapLeft);
  Dec(TriangleLeft);
  Dec(Top);
end;


{ TColors }

const
  DefaultColors : array [1..25] of TColor = (
    clBtnShadow, clBtnShadow, clBtnShadow, clBtnShadow, clMenu, clBtnShadow,
    clBtnHighlight, clBlack, clBtnHighlight, clBtnShadow, clNone, clHighlight, clHighlightText,
    clBtnShadow, clBtnHighlight, clMenu, clMenuText, clHighlight, clHighlightText,
    clNone, clMenuText, clBlack, clBlack, clBlack, clBlack);


constructor T_AM2000_Colors.Create;
var
  I: Integer;
begin
  inherited Create;

  Owner:= AOwner;
  AllowChanged:= True;

  for I:= 1 to High(FColors)
  do FColors[I]:= DefaultColors[I];
end;

function T_AM2000_Colors.IsDefault: Boolean;
var
  I: Integer;
begin
  Result:= True;

  for I:= 1 to High(FColors)
  do Result:= Result and (FColors[I] = DefaultColors[I]);
end;

procedure T_AM2000_Colors.Assign(Source: TPersistent);
var
  Src: T_AM2000_Colors;
  I: Integer;
begin
  if Source is T_AM2000_Colors
  then begin
    Src:= T_AM2000_Colors(Source);

    for I:= 1 to High(FColors)
    do FColors[I]:= Src.FColors[I];

    SoftColors:= Src.SoftColors;
  end
  else
    inherited;
end;

procedure T_AM2000_Colors.Changed;
begin
  if (not AllowChanged)
  then Exit;

  if Owner is T_AM2000_AnimatedSkin
  then
    T_AM2000_AnimatedSkin(Owner).UpdateMenus
  else
  if Owner is T_AM2000_MenuBarOptions
  then
    T_AM2000_MenuBarOptions(Owner).UpdateMenus
  else
  if Owner is T_AM2000_Options
  then
    with T_AM2000_Options(Owner)
    do begin
      Changed;
      ParentColors:= False;
    end;
end;

procedure T_AM2000_Colors.SetColor(const Index: Integer; const Value: TColor);
begin
  if FColors[Index] <> Value
  then begin
    FColors[Index]:= Value;
    Changed;
  end;
end;

function T_AM2000_Colors.GetColor(const Index: Integer): TColor;
begin
  Result:= FColors[Index];
end;


{$IFDEF ActiveX}
function T_AM2000_Colors.Get_Bevel: TxColor;
begin
  Result:= Bevel;
end;

function T_AM2000_Colors.Get_BevelShadow: TxColor;
begin
  Result:= BevelShadow;
end;

function T_AM2000_Colors.Get_Border: TxColor;
begin
  Result:= Border;
end;

function T_AM2000_Colors.Get_DisabledShadow: TxColor;
begin
  Result:= DisabledShadow;
end;

function T_AM2000_Colors.Get_DisabledText: TxColor;
begin
  Result:= DisabledText;
end;

function T_AM2000_Colors.Get_Frame: TxColor;
begin
  Result:= Frame;
end;

function T_AM2000_Colors.Get_FrameShadow: TxColor;
begin
  Result:= FrameShadow;
end;

function T_AM2000_Colors.Get_Gutter: TxColor;
begin
  Result:= Gutter;
end;

function T_AM2000_Colors.Get_Highlight: TxColor;
begin
  Result:= Highlight;
end;

function T_AM2000_Colors.Get_HighlightText: TxColor;
begin
  Result:= HighlightText;
end;

function T_AM2000_Colors.Get_Line: TxColor;
begin
  Result:= Line;
end;

function T_AM2000_Colors.Get_LineShadow: TxColor;
begin
  Result:= LineShadow;
end;

function T_AM2000_Colors.Get_Menu: TxColor;
begin
  Result:= Menu;
end;

function T_AM2000_Colors.Get_MenuText: TxColor;
begin
  Result:= MenuText;
end;

function T_AM2000_Colors.Get_Sunken: TxColor;
begin
  Result:= Sunken;
end;

function T_AM2000_Colors.Get_SunkenText: TxColor;
begin
  Result:= SunkenText;
end;

function T_AM2000_Colors.Get_Pressed: TxColor;
begin
  Result:= Pressed;
end;

function T_AM2000_Colors.Get_PressedText: TxColor;
begin
  Result:= PressedText;
end;

procedure T_AM2000_Colors.Set_Bevel(Value: TxColor);
begin
  Bevel:= Value;
end;

procedure T_AM2000_Colors.Set_BevelShadow(Value: TxColor);
begin
  BevelShadow:= Value;
end;

procedure T_AM2000_Colors.Set_Border(Value: TxColor);
begin
  Border:= Value;
end;

procedure T_AM2000_Colors.Set_DisabledShadow(Value: TxColor);
begin
  DisabledShadow:= Value;
end;

procedure T_AM2000_Colors.Set_DisabledText(Value: TxColor);
begin
  DisabledText:= Value;
end;

procedure T_AM2000_Colors.Set_Frame(Value: TxColor);
begin
  Frame:= Value;
end;

procedure T_AM2000_Colors.Set_FrameShadow(Value: TxColor);
begin
  FrameShadow:= Value;
end;

procedure T_AM2000_Colors.Set_Gutter(Value: TxColor);
begin
  Gutter:= Value;
end;

procedure T_AM2000_Colors.Set_Highlight(Value: TxColor);
begin
  Highlight:= Value;
end;

procedure T_AM2000_Colors.Set_HighlightText(Value: TxColor);
begin
  HighlightText:= Value;
end;

procedure T_AM2000_Colors.Set_Line(Value: TxColor);
begin
  Line:= Value;
end;

procedure T_AM2000_Colors.Set_LineShadow(Value: TxColor);
begin
  LineShadow:= Value;
end;

procedure T_AM2000_Colors.Set_Menu(Value: TxColor);
begin
  Menu:= Value;
end;

procedure T_AM2000_Colors.Set_MenuText(Value: TxColor);
begin
  MenuText:= Value;
end;

procedure T_AM2000_Colors.Set_Sunken(Value: TxColor);
begin
  Sunken:= Value;
end;

procedure T_AM2000_Colors.Set_SunkenText(Value: TxColor);
begin
  SunkenText:= Value;
end;

procedure T_AM2000_Colors.Set_Pressed(Value: TxColor);
begin
  Pressed:= Value;
end;

procedure T_AM2000_Colors.Set_PressedText(Value: TxColor);
begin
  PressedText:= Value;
end;

function T_AM2000_Colors.GetGUID: TGUID;
begin
  Result:= IID_IColors;
end;
{$ENDIF}



{ T_AM2000_MenuItemRect }

procedure T_AM2000_MenuItemRect.Clear;
begin
  LineLeft:= 0;
  LineRight:= 0;
  ItemLeft:= 0;
  ItemWidth:= 0;
  ShortcutLeft:= 0;
  ShortcutWidth:= 0;
  BitmapLeft:= 0;
  BitmapWidth:= 0;
  TriangleLeft:= 0;
  TriangleWidth:= 0;
  Top:= 0;
  Height:= 0;
  Border:= 0;
end;

procedure T_AM2000_MenuItemRect.Assign(Source: T_AM2000_MenuItemRect);
begin
  LineLeft:= Source.LineLeft;
  LineRight:= Source.LineRight;
  ItemLeft:= Source.ItemLeft;
  ItemWidth:= Source.ItemWidth;
  ShortcutLeft:= Source.ShortcutLeft;
  ShortcutWidth:= Source.ShortcutWidth;
  BitmapLeft:= Source.BitmapLeft;
  BitmapWidth:= Source.BitmapWidth;
  TriangleLeft:= Source.TriangleLeft;
  TriangleWidth:= Source.TriangleWidth;
  Top:= Source.Top;
  Height:= Source.Height;
  Border:= Source.Border;
  Ctl3DWidth:= Source.Ctl3DWidth;
  Width:= Source.Width;
end;


{ T_AM2000_Options }

constructor T_AM2000_Options.Create;
begin
  inherited Create;

  Owner:= AOwner;
  FOpacity:= 100;
end;

destructor T_AM2000_Options.Destroy;
begin
  FColors.Free;
  FTitle.Free;
  FMargins.Free;
  FSkin.Free;

  inherited;
end;

procedure T_AM2000_Options.Assign(Source: TPersistent);
var
  S: T_AM2000_Options;
begin
  if Source is T_AM2000_Options
  then begin
    S:= T_AM2000_Options(Source);

    AssignPropertiesOnly(Source, True);

    FParentColors:= S.FParentColors;
    FParentMargins:= S.FParentMargins;
    FParentSkin:= S.FParentSkin;
    FParentTitle:= S.FParentTitle;

    Colors:= S.FColors;
    Margins:= S.FMargins;
    Skin:= S.FSkin;
    Title:= S.FTitle;

  end
  else
    inherited;
end;

procedure T_AM2000_Options.AssignPropertiesOnly(Source: TPersistent; const AllProperties: Boolean);
var
  S: T_AM2000_Options;
begin
  if Source is T_AM2000_Options
  then begin
    S:= T_AM2000_Options(Source);

    FTextAlignment:= S.FTextAlignment;
    FDraggable:= S.Draggable;
    FCustomizable:= S.Customizable;
    FCaption:= S.Caption;

    if AllProperties
    then FFlags:= S.Flags;

  end
  else
    inherited;
end;


function T_AM2000_Options.IsDefault: Boolean;
begin
  Result:=
    (Alignment = taLeftJustify) and
    (Draggable = False) and
    (Customizable = False) and
    (not HasColors) and
    (not HasMargins) and
    (not HasTitle) and
    (not HasSkin);
end;

function T_AM2000_Options.GetColors: T_AM2000_Colors;
begin
  if (FColors = nil)
  then FColors:= T_AM2000_Colors.Create(Self);
  Result:= FColors;
end;

function T_AM2000_Options.GetMargins: T_AM2000_Margins;
begin
  if (FMargins = nil)
  then FMargins:= T_AM2000_Margins.Create(Self);
  Result:= FMargins;
end;

function T_AM2000_Options.GetTitle: T_AM2000_Title;
begin
  if (FTitle = nil)
  then FTitle:= T_AM2000_Title.Create(Self);
  Result:= FTitle;
end;

procedure T_AM2000_Options.SetTitle(Value: T_AM2000_Title);
begin
  if Value <> nil
  then begin
    Title.Assign(Value);
    ParentTitle:= FTitle.IsDefault;
  end
  else begin
    FTitle.Free;
    FTitle:= nil;
    ParentTitle:= True;
  end;
end;

procedure T_AM2000_Options.SetColors(Value: T_AM2000_Colors);
begin
  if Value <> nil
  then begin
    Colors.Assign(Value);
    ParentColors:= FColors.IsDefault;
  end
  else begin
    FColors.Free;
    FColors:= nil;
    ParentColors:= True;
  end;
end;

procedure T_AM2000_Options.SetMargins(Value: T_AM2000_Margins);
begin
  if Value <> nil
  then begin
    Margins.Assign(Value);
    ParentMargins:= FMargins.IsDefault;
  end
  else begin
    FMargins.Free;
    FMargins:= nil;
    ParentMargins:= True;
  end;
end;

function T_AM2000_Options.HasColors: Boolean;
begin
  Result:= (not FParentColors) and (FColors <> nil) and (not FColors.IsDefault);
end;

function T_AM2000_Options.HasMargins: Boolean;
begin
  Result:= (not FParentMargins) and (FMargins <> nil) and (not FMargins.IsDefault);
end;

function T_AM2000_Options.HasTitle: Boolean;
begin
  Result:= (not FParentTitle) and (FTitle <> nil) and (not FTitle.IsDefault);
end;

{function T_AM2000_Options.HasBitmaps: Boolean;
begin
  Result:= (not FParentBitmaps) and (FBitmaps <> nil) and (not FBitmaps.IsDefault);
end;}

function T_AM2000_Options.GetSkin: T_AM2000_Skin;
begin
  if (FSkin = nil)
  then FSkin:= T_AM2000_Skin.Create(Self);
  Result:= FSkin;
end;

function T_AM2000_Options.HasSkin: Boolean;
begin
  Result:= (not FParentSkin) and (FSkin <> nil) and (not FSkin.IsDefault);
end;

procedure T_AM2000_Options.SetSkin(Value: T_AM2000_Skin);
begin
  if Value <> nil
  then begin
    Skin.Assign(Value);
    ParentSkin:= FSkin.IsDefault;
  end
  else begin
    FSkin.Free;
    FSkin:= nil;
    ParentSkin:= True;
  end;
end;

procedure T_AM2000_Options.Changed;
begin
  if GlobalRepaintLockCount > 0
  then Exit;

  if Owner is TCustomMainMenu2000
  then TCustomMainMenu2000(Owner).UpdateFromOptions
  else
  if Owner is TCustomPopupMenu2000
  then TCustomPopupMenu2000(Owner).UpdateFromOptions
  else
  if Owner is TMenuItem2000
  then TMenuItem2000(Owner).UpdateFromOptions;
end;

function T_AM2000_Options.GetCtl3D: Boolean;
begin
  if Owner is TCustomMainMenu2000
  then Result:= TCustomMainMenu2000(Owner).Ctl3D
  else
  if Owner is TCustomPopupMenu2000
  then Result:= TCustomPopupMenu2000(Owner).Ctl3D
  else Result:= True;
end;

procedure T_AM2000_Options.SetCtl3D(const Value: Boolean);
begin
  if Owner is TCustomMainMenu2000
  then TCustomMainMenu2000(Owner).Ctl3D:= Value
  else
  if Owner is TCustomPopupMenu2000
  then TCustomPopupMenu2000(Owner).Ctl3D:= Value;
end;

procedure T_AM2000_Options.SetParentColors(const Value: Boolean);
begin
  if FParentColors = Value
  then Exit;

  FParentColors:= Value;
  Changed;
end;

procedure T_AM2000_Options.SetParentMargins(const Value: Boolean);
begin
  if FParentMargins = Value
  then Exit;

  FParentMargins:= Value;
  Changed;
end;

procedure T_AM2000_Options.SetParentSkin(const Value: Boolean);
begin
  if FParentSkin = Value
  then Exit;

  FParentSkin:= Value;
  Changed;
end;

procedure T_AM2000_Options.SetParentTitle(const Value: Boolean);
begin
  if FParentTitle = Value
  then Exit;

  FParentTitle:= Value;
  Changed;
end;

{procedure T_AM2000_Options.SetParentBitmaps(const Value: Boolean);
begin
  if FParentBitmaps = Value
  then Exit;

  FParentBitmaps:= Value;
  Changed;
end;}


function T_AM2000_Options.OwnerHasNoSkin: Boolean;
begin
  if Owner is TCustomMainMenu2000
  then Result:= (TCustomMainMenu2000(Owner).AnimatedSkin = nil)
  else
  if Owner is TCustomPopupMenu2000
  then Result:= (TCustomPopupMenu2000(Owner).AnimatedSkin = nil)
  else Result:= True;
end;

function T_AM2000_Options.IsColorsStored: Boolean;
begin
  Result:= OwnerHasNoSkin and HasColors;
end;

function T_AM2000_Options.IsMarginsStored: Boolean;
begin
  Result:= OwnerHasNoSkin and HasMargins;
end;

function T_AM2000_Options.IsSkinStored: Boolean;
begin
  Result:= OwnerHasNoSkin and HasSkin;
end;

function T_AM2000_Options.IsTitleStored: Boolean;
begin
  Result:= OwnerHasNoSkin and HasTitle;
end;

{function T_AM2000_Options.GetBitmaps: T_AM2000_Bitmaps;
begin
  if FBitmaps = nil
  then FBitmaps:= T_AM2000_Bitmaps.Create(Self);
  Result:= FBitmaps;
end;

function T_AM2000_Options.IsBitmapsStored: Boolean;
begin
  Result:= OwnerHasNoSkin and HasBitmaps;
end;

procedure T_AM2000_Options.SetBitmaps(Value: T_AM2000_Bitmaps);
begin
  Backgrounds.Assign(Value);
  Changed;
end;}


{$IFDEF ActiveX}
function T_AM2000_Options.Get_Alignment: TxAlignment;
begin
  Result:= Integer(FTextAlignment);
end;

function T_AM2000_Options.Get_Caption: WideString;
begin
  Result:= FCaption;
end;

function T_AM2000_Options.Get_Customizable: WordBool;
begin
  Result:= FCustomizable;
end;

function T_AM2000_Options.Get_Draggable: WordBool;
begin
  Result:= FDraggable;
end;

function T_AM2000_Options.Get_Margins: IMargins;
begin
  Result:= Margins;
end;

function T_AM2000_Options.Get_Colors: IColors;
begin
  Result:= Colors;
end;

function T_AM2000_Options.Get_Skin: ISkin;
begin
  Result:= Skin;
end;

function T_AM2000_Options.Get_Title: ITitle;
begin
  Result:= Title;
end;

procedure T_AM2000_Options.Set_Alignment(Value: TxAlignment);
begin
  FTextAlignment:= TAlignment(Value);
end;

procedure T_AM2000_Options.Set_Caption(const Value: WideString);
begin
  FCaption:= Value;
end;

procedure T_AM2000_Options.Set_Customizable(Value: WordBool);
begin
  FCustomizable:= Value;
end;

procedure T_AM2000_Options.Set_Draggable(Value: WordBool);
begin
  FDraggable:= Value;
end;
{$ENDIF}


{ T_AM2000_ItemOptions }

constructor T_AM2000_ItemOptions.Create(AOwner: TPersistent);
begin
  inherited;

  FParentColors:= True;
  FParentTitle:= True;
  FParentMargins:= True;
  FParentSkin:= True;
end;

function T_AM2000_ItemOptions.IsDefault: Boolean;
begin
  Result:=
    (inherited IsDefault) and
    FParentColors and
    FParentTitle and
    FParentMargins and
    FParentSkin;
end;

{$IFDEF ActiveX}
function T_AM2000_ItemOptions.Get_ParentColors: WordBool;
begin
  Result:= FParentColors;
end;

function T_AM2000_ItemOptions.Get_ParentMargins: WordBool;
begin
  Result:= FParentMargins;
end;

function T_AM2000_ItemOptions.Get_ParentSkin: WordBool;
begin
  Result:= FParentSkin;
end;

function T_AM2000_ItemOptions.Get_ParentTitle: WordBool;
begin
  Result:= FParentTitle;
end;

procedure T_AM2000_ItemOptions.Set_ParentColors(Value: WordBool);
begin
  FParentColors:= Value;
end;

procedure T_AM2000_ItemOptions.Set_ParentMargins(Value: WordBool);
begin
  FParentMargins:= Value;
end;

procedure T_AM2000_ItemOptions.Set_ParentSkin(Value: WordBool);
begin
  FParentSkin:= Value;
end;

procedure T_AM2000_ItemOptions.Set_ParentTitle(Value: WordBool);
begin
  FParentTitle:= Value;
end;

function T_AM2000_ItemOptions.GetGUID: TGUID;
begin
  Result:= IID_IItemOptions;
end;
{$ENDIF}


{ T_AM2000_MenuOptions }

constructor T_AM2000_MenuOptions.Create;
begin
  inherited;
  FAnimation:=  anDefault;
end;

{$IFDEF ActiveX}
destructor T_AM2000_MenuOptions.Destroy;
begin
  FFlagsAdapter.Free;
  inherited;
end;
{$ENDIF}

function T_AM2000_MenuOptions.IsDefault: Boolean;
begin
  Result:=
    (inherited IsDefault) and
    (Animation = anDefault) and
    (Opacity = 100) and
    (FFlags = []);
end;


procedure T_AM2000_MenuOptions.AssignPropertiesOnly(Source: TPersistent; const AllProperties: Boolean);
var
  S: T_AM2000_MenuOptions;
begin
  inherited;

  if Source is T_AM2000_MenuOptions
  then begin
    S:= T_AM2000_MenuOptions(Source);
    FAnimation:= S.FAnimation;
    FOpacity:= S.FOpacity;
  end
end;

{$IFDEF ActiveX}
function T_AM2000_MenuOptions.Get_Animation: TxAnimation;
begin
  Result:= TxAnimation(FAnimation);
end;

function T_AM2000_MenuOptions.Get_Flags: IFlags;
begin
  if FFlagsAdapter = nil
  then FFlagsAdapter:= T_AM2000_FlagsAdapter.Create(@FFlags);
  
  Result:= (FFlagsAdapter as IFlags);
end;

function T_AM2000_MenuOptions.Get_Opacity: TxOpacity;
begin
  Result:= FOpacity;
end;

procedure T_AM2000_MenuOptions.Set_Animation(Value: TxAnimation);
begin
  FAnimation:= T_AM2000_Animation(Value);
end;

procedure T_AM2000_MenuOptions.Set_Opacity(Value: TxOpacity);
begin
  FOpacity:= Value;
end;

function T_AM2000_MenuOptions.GetGUID: TGUID;
begin
  Result:= IID_IMenuOptions;
end;
{$ENDIF}


{ T_AM2000_MenuControl }

constructor T_AM2000_MenuControl.Create(AParent: TMenuItem);
begin
  inherited Create;
  Parent:= AParent;
end;

procedure T_AM2000_MenuControl.Paint(Params: P_AM2000_PaintMenuItemParams);
begin
end;


function T_AM2000_MenuControl.GetHeight(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  Result:= 0;
end;

function T_AM2000_MenuControl.GetWidth(Canvas: TCanvas; Options: T_AM2000_Options): Integer;
begin
  Result:= 0;
end;

procedure T_AM2000_MenuControl.KeyDown(var Key: Word;
  Shift: TShiftState);
begin
end;

procedure T_AM2000_MenuControl.KeyPress(var Key: Char);
begin
end;

procedure T_AM2000_MenuControl.Repaint;
var
  F: TForm;
begin
  F:= GetPopupMenuForm(Parent);
  if F <> nil
  then F.Repaint;
end;

procedure T_AM2000_MenuControl.Assign(Source: TPersistent);
begin
  if Source is T_AM2000_MenuControl
  then begin
    Parent:= T_AM2000_MenuControl(Source).Parent;
  end
  else
    inherited;
end;

procedure T_AM2000_MenuControl.Release;
begin
  if ReleaseBlock
  then FreeOnRelease:= True
  else Free;
end;

procedure T_AM2000_MenuControl.BlockRelease(Block: Boolean);
begin
  ReleaseBlock:= Block;

  if (not ReleaseBlock)
  and FreeOnRelease
  then Free;
end;



procedure SoftenColors(const AColors: T_AM2000_Colors; const SoftType: Boolean);
begin
  if AColors.SoftColors
  then Exit;

  with AColors
  do begin
    AllowChanged:= False;

    if SoftType
    then begin
      Frame:= Highlight;
      FrameShadow:= Highlight;

      Menu:= GetSoftColor(Menu, DisabledText, cMenu);
      Border:= GetSoftColor(Border, DisabledText, cBorder);
      Highlight:= GetSoftColor(Highlight, Menu, cHighlight);
      Line:= GetSoftColor(Line, Menu, cLine);
      Bevel:= GetSoftColor(Bevel, MenuText, cBevel);
      BevelShadow:= GetSoftColor(BevelShadow, MenuText, cBevel);

      if LineShadow <> clNone
      then LineShadow:= GetSoftColor(LineShadow, Menu, cLineShadow);

      if Gutter <> clNone
      then Gutter:= GetSoftColor(DisabledText, Menu, cGutter);

      if Sunken <> clNone
      then Sunken:= GetSoftColor(Sunken, Menu, cSunken);
    end;

    BitmapShadow:= GetSoftColor(BitmapShadow, Highlight, cBitmapShadow);
    HiddenArrow:= HighlightText;

    CheckMark:= GetSoftColor(Highlight, Menu, cCheckMark);
    CheckMarkHigh:= GetSoftColor(Highlight, Frame, cCheckMarkHigh);

    SoftColors:= True;
    AllowChanged:= True;
  end;
end;

procedure T_AM2000_MenuControl.Click;
begin
end;


{ T_AM2000_Skin }

constructor T_AM2000_Skin.Create;
begin
  inherited Create;
  Owner:= AOwner;
end;

destructor T_AM2000_Skin.Destroy;
var
  I: Integer;
begin
  for I:= Low(FBitmaps) to High(FBitmaps)
  do FBitmaps[I].Free;

  inherited;
end;

procedure T_AM2000_Skin.Changed;
begin
  if Owner is T_AM2000_AnimatedSkin
  then
    T_AM2000_AnimatedSkin(Owner).UpdateMenus
  else
  if Owner is T_AM2000_Options
  then
    with T_AM2000_Options(Owner)
    do begin
      Changed;
      ParentSkin:= False;
    end;
end;

procedure T_AM2000_Skin.Assign(Source: TPersistent);
var
  S: T_AM2000_Skin;
begin
  if Source is T_AM2000_Skin
  then begin
    S:= T_AM2000_Skin(Source);
    SetBitmap(0, S.GetBitmap(0));
    SetBitmap(1, S.GetBitmap(1));
    SetBitmap(2, S.GetBitmap(2));
    SetBitmap(3, S.GetBitmap(3));
    SetBitmap(4, S.GetBitmap(4));
    SetBitmap(5, S.GetBitmap(5));
    SetBitmap(6, S.GetBitmap(6));
    SetBitmap(7, S.GetBitmap(7));
    SetBitmap(8, S.GetBitmap(8));
    SetBitmap(9, S.GetBitmap(9));
    SetBitmap(10, S.GetBitmap(10));

    FCWidth:= S.FCWidth;
    FCHeight:= S.FCHeight;
    FICWidth:= S.FICWidth;
    FICHeight:= S.FICHeight;
    FBackgroundLayout:= S.FBackgroundLayout;
    FOnPaintBackground:= S.FOnPaintBackground;
    FOnPaintItemBackground:= S.FOnPaintItemBackground;
  end
  else
    inherited;
end;

function T_AM2000_Skin.IsDefault: Boolean;
begin
  Result:=
        (not IsBitmapStored(0))
    and (not IsBitmapStored(1))
    and (not IsBitmapStored(2))
    and (not IsBitmapStored(3))
    and (not IsBitmapStored(4))
    and (not IsBitmapStored(5))
    and (not IsBitmapStored(6))
    and (not IsBitmapStored(7))
    and (not IsBitmapStored(8))
    and (not IsBitmapStored(9))
    and (not IsBitmapStored(10))
    and (FCWidth = 0)
    and (FCHeight = 0)
    and (FICWidth = 0)
    and (FICHeight = 0);
end;


procedure T_AM2000_Skin.PaintBackground(const Canvas: TCanvas; const Rect: TRect);
var
  R: TRect;
  DC: HDC;
  FBWidth, FBHeight, X1, X2, Y1, Y2: Integer;
begin
  if Assigned(FOnPaintItemBackground)
  then begin
    FOnPaintBackground(Self, Canvas);
    Exit;
  end;

  R:= Rect;
  OffsetRect(R, -R.Left, -R.Top);
  DC:= Background.Canvas.Handle;
  FBWidth:= Background.Width;
  FBHeight:= Background.Height;

  case FBackgroundLayout of
    blDefault, blExpandMenu:
      begin
        BitBlt(Canvas.Handle, Rect.Left, Rect.Top, R.Right, R.Top, DC, 0, 0, SrcCopy);
      end;

    blTile:
      with Canvas
      do begin
        Brush.Bitmap:= Background;
        FillRect(Rect);
      end;

    blStretch:
      begin
        SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
        StretchBlt(Canvas.Handle, 0, 0, R.Right, R.Bottom, DC, 0, 0, FBWidth, FBHeight, SrcCopy);
      end;

    blSkin:
      begin
        SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);

        // top left
        BitBlt(Canvas.Handle, 0, 0, FCWidth, FCHeight, DC, 0, 0, SrcCopy);
        // top right
        BitBlt(Canvas.Handle, R.Right - FCWidth, 0, FCWidth, FCHeight, DC, FBWidth - FCWidth, 0, SrcCopy);
        // bottom left
        BitBlt(Canvas.Handle, 0, R.Bottom - FCHeight, FCWidth, FCHeight, DC, 0, FBHeight - FCHeight, SrcCopy);
        // bottom right
        BitBlt(Canvas.Handle, R.Right - FCWidth, R.Bottom - FCHeight, FCWidth, FCHeight, DC, FBWidth - FCWidth, FBHeight - FCHeight, SrcCopy);

        // top & bottom
        X1:= R.Right - 2*FCWidth;
        X2:= FBWidth - 2*FCWidth;
        if X1 > X2
        then begin
          StretchBlt(Canvas.Handle, FCWidth, 0, X1, FCHeight, DC, FCWidth, 0, X2, FCHeight, SrcCopy);
          StretchBlt(Canvas.Handle, FCWidth, R.Bottom - FCHeight, X1, FCHeight, DC, FCWidth, FBHeight - FCHeight, X2, FCHeight, SrcCopy);
        end
        else begin
          BitBlt(Canvas.Handle, FCWidth, 0, X1, FCHeight, DC, FCWidth, 0, SrcCopy);
          BitBlt(Canvas.Handle, FCWidth, R.Bottom - FCHeight, X1, FCHeight, DC, FCWidth, FBHeight - FCHeight, SrcCopy);
        end;

        // left & right
        Y1:= R.Bottom - 2*FCHeight;
        Y2:= FBHeight - 2*FCHeight;
        if Y1 > Y2
        then begin
          StretchBlt(Canvas.Handle, 0, FCHeight, FCWidth, Y1, DC, 0, FCHeight, FCWidth, Y2, SrcCopy);
          StretchBlt(Canvas.Handle, R.Right - FCWidth, FCHeight, FCWidth, Y1, DC, FBWidth - FCWidth, FCHeight, FCWidth, Y2, SrcCopy);
        end
        else begin
          BitBlt(Canvas.Handle, 0, FCHeight, FCWidth, Y1, DC, 0, FCHeight, SrcCopy);
          BitBlt(Canvas.Handle, R.Right - FCWidth, FCHeight, FCWidth, Y1, DC, FBWidth - FCWidth, FCHeight, SrcCopy);
        end;

        // center
        if (X1 > X2)
        or (Y1 > Y2)
        then StretchBlt(Canvas.Handle, FCWidth, FCHeight, X1, Y1, DC, FCWidth, FCHeight, X2, Y2, SrcCopy)
        else BitBlt(Canvas.Handle, FCWidth, FCHeight, X1, Y1, DC, FCWidth, FCHeight, SrcCopy);
      end;

    blAtTopLeft:
      BitBlt(Canvas.Handle, 0, 0, FBWidth, FBHeight,
        DC, 0, 0, SrcCopy);

    blAtTopCenter:
      BitBlt(Canvas.Handle, (R.Right - FBWidth) div 2, 0, FBWidth, FBHeight,
        DC, 0, 0, SrcCopy);

    blAtTopRight:
      BitBlt(Canvas.Handle, (R.Right - FBWidth), 0, FBWidth, FBHeight,
        DC, 0, 0, SrcCopy);

    blAtLeftCenter:
      BitBlt(Canvas.Handle, 0, (R.Bottom - FBHeight) div 2, FBWidth, FBHeight,
        DC, 0, 0, SrcCopy);

    blAtCenter:
      BitBlt(Canvas.Handle, (R.Right - FBWidth) div 2, (R.Bottom - FBHeight) div 2, FBWidth, FBHeight,
        DC, 0, 0, SrcCopy);

    blAtRightCenter:
      BitBlt(Canvas.Handle, (R.Right - FBWidth), (R.Bottom - FBHeight) div 2, FBWidth, FBHeight,
        DC, 0, 0, SrcCopy);

    blAtBottomLeft:
      BitBlt(Canvas.Handle, 0, (R.Bottom - FBHeight), FBWidth, FBHeight,
        DC, 0, 0, SrcCopy);

    blAtBottomCenter:
      BitBlt(Canvas.Handle, (R.Right - FBWidth) div 2, (R.Bottom - FBHeight), FBWidth, FBHeight,
        DC, 0, 0, SrcCopy);

    blAtBottomRight:
      BitBlt(Canvas.Handle, (R.Right - FBWidth), (R.Bottom - FBHeight), FBWidth, FBHeight,
        DC, 0, 0, SrcCopy);

  end;
end;

procedure T_AM2000_Skin.PaintItemBackground;
var
  DC: HDC;
  FBWidth, FBHeight, X, Y, DTop, DBottom: Integer;
begin
  if Assigned(FOnPaintItemBackground)
  then begin
    FOnPaintItemBackground(Self, Canvas, State, R);
    Exit;
  end;

  X:= R.Left;
  Y:= R.Top;
  OffsetRect(R, -R.Left, -R.Top);

  if (isPressed in State)
  and (IsBitmapStored(6)) // ItemBackgroundPressed
  then
    with ItemBackgroundPressed
    do begin
      DC:= Canvas.Handle;
      FBWidth:= Width;
      FBHeight:= Height;
      DTop:= FICHeight;
      DBottom:= FICHeight;
    end
  else
  if isSelected in State
  then
    with ItemBackgroundHighlight
    do begin
      DC:= Canvas.Handle;
      FBWidth:= Width;
      FBHeight:= Height;
      DTop:= FICHeight;
      DBottom:= FICHeight;
    end
  else
  if isHidden in State
  then
    with ItemBackgroundSunken
    do begin
      DC:= Canvas.Handle;
      FBWidth:= Width;
      FBHeight:= Height;

      if (isHiddenPrev in State)
      then DTop:= 0
      else DTop:= FICHeight;

      if (isHiddenSucc in State)
      then DBottom:= 0
      else DBottom:= FICHeight;
    end
  else
    Exit;

  SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
  
  if DTop > 0
  then begin
    // top left
    BitBlt(Canvas.Handle, X, Y, FICWidth, DTop, DC, 0, 0, SrcCopy);
    // top right
    BitBlt(Canvas.Handle, X + R.Right - FICWidth, Y, FICWidth, DTop, DC, FBWidth - FICWidth, 0, SrcCopy);
    // top
    StretchBlt(Canvas.Handle, X + FICWidth, Y, R.Right - 2*FICWidth, DTop, DC, FICWidth, 0, FBWidth - 2*FICWidth, FICHeight, SrcCopy);
  end;

  if DBottom > 0
  then begin
    // bottom left
    BitBlt(Canvas.Handle, X, Y + R.Bottom - DBottom, FICWidth, DBottom, DC, 0, FBHeight - FICHeight, SrcCopy);
    // bottom right
    BitBlt(Canvas.Handle, X + R.Right - FICWidth, Y + R.Bottom - DBottom, FICWidth, DBottom, DC, FBWidth - FICWidth, FBHeight - FICHeight, SrcCopy);
    // bottom
    StretchBlt(Canvas.Handle, X + FICWidth, Y + R.Bottom - DBottom, R.Right - 2*FICWidth, DBottom, DC, FICWidth, FBHeight - FICHeight, FBWidth - 2*FICWidth, FICHeight, SrcCopy);
  end;

  // left
  StretchBlt(Canvas.Handle, X, Y + DTop, FICWidth, R.Bottom - DTop - DBottom, DC, 0, FICHeight, FICWidth, FBHeight - 2*FICHeight, SrcCopy);
  // right
  StretchBlt(Canvas.Handle, X + R.Right - FICWidth, Y + DTop, FICWidth, R.Bottom - DTop - DBottom, DC, FBWidth - FICWidth, FICHeight, FICWidth, FBHeight - 2*FICHeight, SrcCopy);
  // center
  StretchBlt(Canvas.Handle, X + FICWidth, Y + DTop, R.Right - 2*FICHeight, R.Bottom - DTop - DBottom, DC, FICWidth, FICHeight, FBWidth - 2*FICWidth, FBHeight - 2*FICHeight, SrcCopy);
end;

procedure T_AM2000_Skin.PaintUnhideBackground;
var
  DC: HDC;
  FBWidth, FBHeight, X, Y: Integer;
begin
  if Assigned(FOnPaintUnhideBackground)
  then begin
    FOnPaintUnhideBackground(Self, Canvas, State, R);
    Exit;
  end;

  X:= R.Left;
  Y:= R.Top;
  OffsetRect(R, -R.Left, -R.Top);

  if (isPressed in State)
  and IsBitmapStored(10) // UnhideBackgroundPressed
  then
    with UnhideBackgroundPressed
    do begin
      DC:= Canvas.Handle;
      FBWidth:= Width;
      FBHeight:= Height;
    end
  else
  if isSelected in State
  then
    with UnhideBackgroundHighlight
    do begin
      DC:= Canvas.Handle;
      FBWidth:= Width;
      FBHeight:= Height;
    end
  else
    Exit;

    
  SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
  
  // left
  BitBlt(Canvas.Handle, X, Y, FICWidth, FBHeight, DC, 0, 0, SrcCopy);
  // right
  BitBlt(Canvas.Handle, X + R.Right - FICWidth, Y, FICWidth, FBHeight, DC, FBWidth - FICWidth, 0, SrcCopy);
  // top
  StretchBlt(Canvas.Handle, X + FICWidth, Y, R.Right - 2*FICWidth, FBHeight, DC, FICWidth, 0, FBWidth - 2*FICWidth, FBHeight, SrcCopy);
end;

procedure T_AM2000_Skin.PaintBitmap(const Canvas: TCanvas;
  const ABitmap: TBitmap; const State: T_AM2000_ItemState; R: TRect);
var
  X, Y, Glyph, NumGlyphs: Integer;
begin
  NumGlyphs:= ABitmap.Width div ABitmap.Height;
  X:= (R.Right + R.Left - ABitmap.Width div NumGlyphs) div 2;
  Y:= (R.Bottom + R.Top - ABitmap.Height) div 2;

  if NumGlyphs = 8
  then begin
    if isSelected in State
    then Glyph:= 4
    else Glyph:= 0;

    if isDisabled in State
    then Inc(Glyph, 2);

    if (isChecked in State)
    then Inc(Glyph);
  end
  else
  if NumGlyphs = 6
  then begin
    if isDisabled in State
    then Glyph:= 2
    else
    if isSelected in State
    then Glyph:= 4
    else Glyph:= 0;

    if (isChecked in State)
    then Inc(Glyph);
  end
  else
    if (isChecked in State)
    then Glyph:= 2
    else
    if isDisabled in State
    then Glyph:= 1
    else
    if (isPressed in State)
    then Glyph:= 2
    else
    if isSelected in State
    then Glyph:= 3
    else Glyph:= 0;

  TransBlt(Canvas, X, Y, Glyph, NumGlyphs, ABitmap.Handle, clNone, clNone, 0);
end;

function T_AM2000_Skin.GetBitmap(const Index: Integer): TBitmap;
begin
  if FBitmaps[Index] = nil
  then FBitmaps[Index]:= TBitmap.Create;
  Result:= FBitmaps[Index];
end;

function T_AM2000_Skin.IsBitmapStored(const Index: Integer): Boolean;
begin
  Result:= (FBitmaps[Index] <> nil)
    and (not FBitmaps[Index].Empty);
end;

procedure T_AM2000_Skin.SetBitmap(const Index: Integer; const AValue: TBitmap);
begin
  if (AValue <> nil) and (not AValue.Empty)
  then
    GetBitmap(Index).Assign(AValue)

  else begin
    FBitmaps[Index].Free;
    FBitmaps[Index]:= nil;
  end;

  Changed;
end;

function T_AM2000_Skin.IsBackgroundStored: Boolean;
begin
  Result:= IsBitmapStored(4);
end;

procedure T_AM2000_Skin.SetBackgroundLayout(
  const Value: T_AM2000_BackgroundLayout);
begin
  FBackgroundLayout:= Value;
  Changed;
end;

procedure T_AM2000_Skin.SetCornerHeight(const Value: Integer);
begin
  FCHeight:= Value;
  Changed;
end;

procedure T_AM2000_Skin.SetCornerWidth(const Value: Integer);
begin
  FCWidth:= Value;
  Changed;
end;

procedure T_AM2000_Skin.SetItemCornerHeight(const Value: Integer);
begin
  FICHeight:= Value;
  Changed;
end;

procedure T_AM2000_Skin.SetItemCornerWidth(const Value: Integer);
begin
  FICWidth:= Value;
  Changed;
end;

procedure T_AM2000_Skin.SetOnPaintBackground(
  const Value: T_AM2000_PaintBackgroundEvent);
begin
  FOnPaintBackground:= Value;
  Changed;
end;

procedure T_AM2000_Skin.SetOnPaintItemBackground(
  const Value: T_AM2000_PaintItemBackgroundEvent);
begin
  FOnPaintItemBackground:= Value;
  Changed;
end;



{$IFDEF ActiveX}
function T_AM2000_Skin.Get_BackgroundLayout: TxBackgroundLayout;
begin
  Result:= TxBackgroundLayout(FBackgroundLayout);
end;

function T_AM2000_Skin.Get_CornerHeight: Integer;
begin
  Result:= FCHeight;
end;

function T_AM2000_Skin.Get_CornerWidth: Integer;
begin
  Result:= FCWidth;
end;

function T_AM2000_Skin.Get_ItemCornerHeight: Integer;
begin
  Result:= FICHeight;
end;

function T_AM2000_Skin.Get_ItemCornerWidth: Integer;
begin
  Result:= FICWidth;
end;

procedure T_AM2000_Skin.Set_BackgroundLayout(Value: TxBackgroundLayout);
begin
  FBackgroundLayout:= T_AM2000_BackgroundLayout(Value);
  Changed;
end;

procedure T_AM2000_Skin.Set_CornerHeight(Value: Integer);
begin
  FCHeight:= Value;
  Changed;
end;

procedure T_AM2000_Skin.Set_CornerWidth(Value: Integer);
begin
  FCWidth:= Value;
  Changed;
end;

procedure T_AM2000_Skin.Set_ItemCornerHeight(Value: Integer);
begin
  FICHeight:= Value;
  Changed;
end;

procedure T_AM2000_Skin.Set_ItemCornerWidth(Value: Integer);
begin
  FICWidth:= Value;
  Changed;
end;

function T_AM2000_Skin.GetGUID: TGUID;
begin
  Result:= IID_ISkin;
end;
{$ENDIF}



{ T_AM2000_Title }

constructor T_AM2000_Title.Create;
begin
  inherited Create;

  Owner:=       AOwner;
  FDirection:=  tdForward;
  FPosition:=   atLeft;
  FColorBegin:= clBlue;
  FColorEnd:=   clBlack;
  FWidth:=      50;
  FGradientDirection:= gdVertical;
  FGradient:=   grLinear;
end;

destructor T_AM2000_Title.Destroy;
begin
  FFont.Free;
  FBitmap.Free;
  FBuffer.Free;
{$IFDEF ActiveX}
  FFontAdapter.Free;
{$ENDIF}  

  inherited;
end;

function T_AM2000_Title.IsBitmapStored: Boolean;
begin
  Result:= (FBitmap <> nil) and (not FBitmap.Empty);
end;

function T_AM2000_Title.IsFontStored: Boolean;
begin
  Result:= (Font.Name <> 'Arial')
    or (Font.Size <> 24)
    or (Font.Style <> [fsBold])
    or (Font.Color <> clWhite)
{$IFDEF Delphi3OrHigher}     
    or (Font.CharSet <> Default_Charset)
{$ENDIF}
    ;
end;

procedure T_AM2000_Title.SetFont(Value: TFont);
begin
  Font.Assign(Value);
  Changed;
end;

procedure T_AM2000_Title.SetBitmap(Value: TBitmap);
begin
  if (Value <> nil) and (not Value.Empty)
  then
    Bitmap.Assign(Value)

  else begin
    FBitmap.Free;
    FBitmap:= nil;
  end;
  Changed;
end;

function T_AM2000_Title.TextAlign(Width, TextWidth: Integer): Integer;
begin
  Result:= 0;
  case FAlignment of
    taLeftJustify:  Result:= Width -10;
    taCenter:       Result:= (Width + TextWidth) shr 1 +10;
    taRightJustify: Result:= TextWidth +10;
  end;
end;

procedure T_AM2000_Title.Paint(ACanvas: TCanvas; Offset, OffsetTitle: Integer);
  // thanks to Reinhard Stanke for improvements in this routine
var
  lf: TLogFont;
  hfnt, holdfnt: HFont;
  I, C, DC, D, X, Y, C1, C2, R1, G1, B1, W, H, Width, Height: Integer;
  DR, DG, DB, DX, DY: Real;
  Rect1: TRect;

  procedure InitRGBValues(C1, C2: Integer);
  var
    D: Integer;
  begin
    if FGradient = grReflected
    then D:= 128
    else D:= 256;

    R1:= GetRValue(C1);
    G1:= GetGValue(C1);
    B1:= GetBValue(C1);
    DR:= (GetRValue(C2) - R1) / D;
    DG:= (GetGValue(C2) - G1) / D;
    DB:= (GetBValue(C2) - B1) / D;
  end;

begin
  if not FVisible then Exit;

  D:= Offset;

  with ACanvas.ClipRect
  do
    case FPosition of
      atLeft:   R:= Rect(D, D, FWidth + D, Bottom - D);
      atRight:  R:= Rect(Right - FWidth - D, D, Right - D, Bottom - D);
      atTop:    R:= Rect(D, D, Right - D, FWidth + D);
      atBottom: R:= Rect(D, Bottom - FWidth - D, Right - D, Bottom - D);
    end;

  Width:= R.Right - R.Left;
  Height:= R.Bottom - R.Top;

  if (FBuffer = nil)
  or (FBuffer.Empty)
  then begin
    if FBuffer = nil
    then FBuffer:= TBitmap.Create;

    FBuffer.Width:= Width;
    FBuffer.Height:= Height;

    with FBuffer.Canvas
    do begin
      // fill bitmap with FColorBegin and FColorEnd
      Brush.Style:= bsSolid;

      if FColorBegin <> FColorEnd
      then begin
        C1:= ColorToRgb(FColorEnd);
        C2:= ColorToRgb(FColorBegin);

        // calculate
        InitRGBValues(C1, C2);

        // draw
        if FGradient = grDiamond
        then begin
          DX:= Width/512;
          DY:= Height/512;
          Y:= 0;
          for X:= 0 to 127
          do begin
            Brush.Color:= Rgb(R1 + Round(DR*Y), G1 + Round(DG*Y), B1 + Round(DB*Y));
            Inc(Y, 2);
            FillRect(Rect(Round(X*DX), Round(X*DY), Round((512 - X)* DX), Round((512 - X)* DY)));
          end;
        end

        else
        if FGradient = grBlocks
        then begin
          Brush.Color:= ACanvas.Brush.Color;
          FillRect(Rect(0, 0, Width, Height));

          if FGradientDirection = gdVertical
          then begin // horizontal blocks
            W:= Width;
            H:= W div 2;
            DX:= 0;
            DY:= (W / 2) * 1.25;   // distance betwen beginning of each block
            D:= Round((Height + H * 0.25) / DY); // count of blocks
          end
          else begin // vertical blocks
            W:= Height div 2;
            H:= Height;
            DX:= (Width / 2) * 1.25;
            DY:= 0;
            D:= Round((Width + W div 2) / DX);
          end;

          DR:= (GetRValue(C2) - R1) / D;
          DG:= (GetGValue(C2) - G1) / D;
          DB:= (GetBValue(C2) - B1) / D;

          X:= 0;
          Y:= 0;
          for C:= 0 to D -1
          do begin
            Rect1:= Rect(Round(C*DX), Round(C*DY), 0, 0);
            Rect1.Right:= Rect1.Left + W;
            Rect1.Bottom:= Rect1.Top + H;

            Brush.Color:= Rgb(R1 + Round(DR*C), G1 + Round(DG*C), B1 + Round(DB*C));
            FillRect(Rect1);
          end;
        end

        else begin // grLinear or grReflected
          C:= 0;
          DC:= 1;

          if FGradientDirection = gdVertical
          then begin
            DX:= 0;
            DY:= Height/256;
          end
          else begin
            DX:= Width/256;
            DY:= 0;
          end;

          for I:= 0 to 255
          do begin
            Brush.Color:= Rgb(R1 + Round(DR*C), G1 + Round(DG*C), B1 + Round(DB*C));
            FillRect(Rect(Round(I*DX), Round(I*DY), Width, Height));

            if (FGradient = grReflected)
            and (I = 128)
            then DC:= -DC;

            C:= C + DC;
          end;

          if (FGradient = grReflected)
          then Brush.Color:= C1
          else Brush.Color:= C2;
          FillRect(Rect(Round(256*DX), Round(256*DY), Width, Height));
        end;
      end
      else
      if FColorBegin <> clNone
      then begin
        // solid color
        Brush.Color:= FColorBegin;
        FillRect(ClipRect);
      end;


      if (FBitmap <> nil)
      and (not FBitmap.Empty)
      then begin
        // draw bitmap
        X:= (Width - FBitmap.Width) shr 1;
        Y:= 0;

        case FAlignment of
          taLeftJustify:  Y:= Height - FBitmap.Height - OffsetTitle;
          taRightJustify: Y:= 0;
          taCenter:       Y:= (Height - FBitmap.Height) shr 1;
        end;

        BitBlt(Handle, X, Y, FBitmap.Width, FBitmap.Height, FBitmap.Canvas.Handle, 0, 0, SrcCopy);
      end;

      if FText <> ''
      then begin
        // calculate text bounds
        Font:= Self.Font;
        W:= TextWidth(FText);
        H:= TextHeight(FText);

        // initialize TLogFont structure
        FillChar(lf, SizeOf(lf), 0);
        StrPCopy(lf.lfFaceName, Font.Name);
  {$IFDEF Delphi3OrHigher}
        lf.lfCharSet:= Font.Charset;
  {$ELSE}
        lf.lfCharSet:= Default_Charset;
  {$ENDIF}
        lf.lfHeight:= Font.Height;

        if fsBold in Font.Style
        then lf.lfWeight:= fw_Bold
        else lf.lfWeight:= fw_Normal;

        lf.lfItalic:=    Integer(fsItalic    in Font.Style);
        lf.lfUnderline:= Integer(fsUnderline in Font.Style);
        lf.lfStrikeOut:= Integer(fsStrikeout in Font.Style);

        if FDirection = tdForward
        then
          if FPosition in [atLeft, atRight]
          then begin
            lf.lfEscapement:=  900;
            lf.lfOrientation:= 900;
            X:= (Width - H) shr 1 -2;
            Y:= TextAlign(Height - OffsetTitle, W);
          end
          else begin
            X:= Width - TextAlign(Width - OffsetTitle, W);
            Y:= (Height - H) shr 1 -2;
          end

        else
          if FPosition in [atLeft, atRight]
          then begin
            lf.lfEscapement:= 2700;
            lf.lfOrientation:= 2700;
            X:= (Width + H) shr 1 +2;
            Y:= Height - TextAlign(Height, W);
          end
          else begin
            lf.lfEscapement:= 1800;
            lf.lfOrientation:= 1800;
            X:= TextAlign(Width - OffsetTitle, W);
            Y:= (Height + H) shr 1 -2;
          end;

        lf.lfOutPrecision:= OUT_TT_ONLY_PRECIS;

        hfnt:= CreateFontIndirect(lf);
        holdfnt:= SelectObject(Handle, hfnt);

        SetTextColor(Handle, ColorToRgb(Self.Font.Color));
        SetBkMode(Handle, Transparent);
        TextOut(X, Y, FText);

        SelectObject(Handle, holdfnt);
        DeleteObject(hfnt);
      end;
    end;
  end;

  BitBlt(ACanvas.Handle, R.Left, R.Top, Width, Height, FBuffer.Canvas.Handle, 0, 0, SrcCopy);
end;

procedure T_AM2000_Title.PaintRect(Canvas: TCanvas; Rect: TRect);
begin
  if FBuffer = nil then Exit;
  BitBlt(Canvas.Handle, Rect.Left, Rect.Top,
    Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
    FBuffer.Canvas.Handle, Rect.Left - R.Left, Rect.Top - R.Top, SrcCopy);
end;

procedure T_AM2000_Title.ResetBuffer;
begin
  if FBuffer <> nil
  then FBuffer.Handle:= 0;
end;

procedure T_AM2000_Title.Changed;
begin
  if Owner is T_AM2000_AnimatedSkin
  then
    T_AM2000_AnimatedSkin(Owner).UpdateMenus
  else
  if Owner is T_AM2000_Options
  then
    with T_AM2000_Options(Owner)
    do begin
      Changed;
      ParentTitle:= False;
    end;
end;

procedure T_AM2000_Title.Assign(Source: TPersistent);
var
  Src: T_AM2000_Title;
begin
  if Source is T_AM2000_Title
  then begin
    Src:= T_AM2000_Title(Source);
    FPosition:=   Src.Position;
    FAlignment:=  Src.Alignment;
    FText:=       Src.Text;
    FColorBegin:= Src.ColorBegin;
    FColorEnd:=   Src.ColorEnd;
    FWidth:=      Src.Width;
    FDirection:= Src.FDirection;
    FGradient:=  Src.FGradient;
    FGradientDirection:=  Src.FGradientDirection;
    FVisible:=    Src.Visible;

    Font.Assign(Src.Font);

    Bitmap:= Src.FBitmap;
  end
  else
    inherited;
end;

function T_AM2000_Title.IsDefault: Boolean;
begin
  Result:=
    (Position = atLeft) and
    (Alignment = taLeftJustify) and
    (Text = '') and
    (ColorBegin = clBlue) and
    (ColorEnd = clBlack) and
    (Width = 50) and
    (TextDirection = tdForward) and
    (not Visible) and
    ((FBitmap = nil) or (FBitmap.Empty)) and
    (Gradient = grLinear) and
    (GradientDirection = gdVertical);
end;

function T_AM2000_Title.GetBitmap: TBitmap;
begin
  if FBitmap = nil
  then FBitmap:= TBitmap.Create;
  Result:= FBitmap;
end;

function T_AM2000_Title.GetFont: TFont;
begin
  if FFont = nil
  then begin
    FFont:= TFont.Create;
    FFont.Name:= 'Arial';
    FFont.Size:=  24;
    FFont.Style:= [fsBold];
    FFont.Color:= clWhite;
  end;
  Result:= FFont;
end;

procedure T_AM2000_Title.SetPosition(const Value: T_AM2000_TitlePosition);
begin
  FPosition:= Value;
  Changed;
end;

procedure T_AM2000_Title.SetAlignment(const Value: TAlignment);
begin
  FAlignment:= Value;
  Changed;
end;

procedure T_AM2000_Title.SetColorBegin(const Value: TColor);
begin
  FColorBegin:= Value;
  Changed;
end;

procedure T_AM2000_Title.SetColorEnd(const Value: TColor);
begin
  FColorEnd:= Value;
  Changed;
end;

procedure T_AM2000_Title.SetDirection(const Value: T_AM2000_TextDirection);
begin
  FDirection:= Value;
  Changed;
end;

procedure T_AM2000_Title.SetGradient(const Value: T_AM2000_Gradient);
begin
  FGradient:= Value;
  Changed;
end;

procedure T_AM2000_Title.SetText(const Value: String);
begin
  FText:= Value;
  Changed;
end;

procedure T_AM2000_Title.SetVisible(const Value: Boolean);
begin
  FVisible:= Value;
  Changed;
end;

procedure T_AM2000_Title.SetWidth(const Value: Integer);
begin
  FWidth:= Value;
  Changed;
end;

procedure T_AM2000_Title.SetGradientDirection(
  const Value: T_AM2000_GradientDirection);
begin
  FGradientDirection:= Value;
  Changed;
end;


{$IFDEF ActiveX}
function T_AM2000_Title.Get_Position: TxTitlePosition;
begin
  Result:= TxTitleAlignment(FPosition);
end;

function T_AM2000_Title.Get_Alignment: TxAlignment;
begin
  Result:= TxAlignment(FAlignment);
end;

function T_AM2000_Title.Get_ColorBegin: TxColor;
begin
  Result:= FColorBegin;
end;

function T_AM2000_Title.Get_ColorEnd: TxColor;
begin
  Result:= FColorEnd;
end;

function T_AM2000_Title.Get_Font: IFont;
begin
  if FFontAdapter = nil
  then FFontAdapter:= T_AM2000_FontAdapter.Create(Font);

  Result:= FFontAdapter;
end;

function T_AM2000_Title.Get_Gradient: TxGradient;
begin
  Result:= TxGradient(FGradient);
end;

function T_AM2000_Title.Get_Text: WideString;
begin
  Result:= FText;
end;

function T_AM2000_Title.Get_TextDirection: TxTextDirection;
begin
  Result:= TxTextDirection(FDirection);
end;

function T_AM2000_Title.Get_Visible: WordBool;
begin
  Result:= FVisible;
end;

function T_AM2000_Title.Get_Width: Integer;
begin
  Result:= FWidth;
end;

function T_AM2000_Title.Get_GradientDirection: TxGradientDirection;
begin
  Result:= TxGradientDirection(FGradientDirection);
end;

procedure T_AM2000_Title.Set_Position(Value: TxTitlePosition);
begin
  FPosition:= T_AM2000_TitlePosition(Value);
  Changed;
end;

procedure T_AM2000_Title.Set_Alignment(Value: TxAlignment);
begin
  FAlignment:= TAlignment(Value);
  Changed;
end;

procedure T_AM2000_Title.Set_ColorBegin(Value: TxColor);
begin
  FColorBegin:= Value;
  Changed;
end;

procedure T_AM2000_Title.Set_ColorEnd(Value: TxColor);
begin
  FColorEnd:= Value;
  Changed;
end;

procedure T_AM2000_Title.Set_Gradient(Value: TxGradient);
begin
  FGradient:= T_AM2000_Gradient(Value);
  Changed;
end;

procedure T_AM2000_Title.Set_Text(const Value: WideString);
begin
  FText:= Value;
  Changed;
end;

procedure T_AM2000_Title.Set_TextDirection(Value: WordBool);
begin
  FDirection:= Value;
  Changed;
end;

procedure T_AM2000_Title.Set_Visible(Value: WordBool);
begin
  FVisible:= Value;
  Changed;
end;

procedure T_AM2000_Title.Set_Width(Value: Integer);
begin
  FWidth:= Value;
  Changed;
end;

procedure T_AM2000_Title.Set_GradientDirection(Value: TxGradientDirection);
begin
  FGradientDirection:= T_AM2000_GradientDirection(Value);
  Changed;
end;


function T_AM2000_Title.GetGUID: TGUID;
begin
  Result:= IID_ITitle;
end;
{$ENDIF}



{ T_AM2000_AnimatedSkin }

procedure T_AM2000_AnimatedSkin.AssignTo(Dest: TPersistent);
begin
  inherited;
end;

function T_AM2000_AnimatedSkin.GetISkin: ISkin;
begin
  Result:= nil;
end;

procedure T_AM2000_AnimatedSkin.Remove(Dest: TPersistent);
begin
end;

procedure T_AM2000_AnimatedSkin.UpdateMenus;
begin
end;


{ T_AM2000_MenuBarOptions }

constructor T_AM2000_MenuBarOptions.Create(ASkin: T_AM2000_AnimatedSkin);
begin
  inherited Create;
  FSkin:= ASkin;
end;

function T_AM2000_MenuBarOptions.IsDefault: Boolean;
begin
  Result:= (not FHotTrack)
    and (not FTransparent)
    and (FBorderIconsStyle = fsDefault);
end;

procedure T_AM2000_MenuBarOptions.UpdateMenus;
begin
  FSkin.UpdateMenus;
end;



{$IFDEF ActiveX}

{ T_AM2000_Persistent }

function T_AM2000_Persistent.DispTypeInfo: ITypeInfo;
begin
  if FDispTypeInfo = nil
  then ComServer.TypeLib.GetTypeInfoOfGuid(GetGUID, FDispTypeInfo);

  Result:= FDispTypeInfo;
end;

function T_AM2000_Persistent.DispIntfEntry: PInterfaceEntry;
begin
  if FDispIntfEntry = nil
  then FDispIntfEntry:= GetInterfaceEntry(GetGUID);

  Result:= FDispIntfEntry;
end;

function T_AM2000_Persistent.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result:= DispGetIDsOfNames(DispTypeInfo, Names, NameCount, DispIDs);
end;

function T_AM2000_Persistent.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  if Index <> 0
  then begin
    Pointer(TypeInfo):= nil;
    Result:= DISP_E_BADINDEX;
  end
  else begin
    ITypeInfo(TypeInfo):= DispTypeInfo;
    Result:= S_OK;
  end;
end;

function T_AM2000_Persistent.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count:= 1;
  Result:= S_OK;
end;

function T_AM2000_Persistent.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
const
  INVOKE_PROPERTYSET = INVOKE_PROPERTYPUT or INVOKE_PROPERTYPUTREF;
begin
  if Flags and INVOKE_PROPERTYSET <> 0
  then Flags:= INVOKE_PROPERTYSET;

  Result:= DispTypeInfo.Invoke(Pointer(Integer(Self) +
    DispIntfEntry.IOffset), DispID, Flags, TDispParams(Params), VarResult,
    ExcepInfo, ArgErr);
end;



{ T_AM2000_FlagsAdapter }

constructor T_AM2000_FlagsAdapter.Create(AFlagsPtr: P_AM2000_Flags);
begin
  inherited Create;
  FFlagsPtr:= AFlagsPtr;
end;

function T_AM2000_FlagsAdapter.GetGUID: TGUID;
begin
  Result:= IID_IFlags;
end;

function T_AM2000_FlagsAdapter.Get_mfBitmapShadow: WordBool;
begin
  Result:= mfBitmapShadow in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfDropShadow: WordBool;
begin
  Result:= mfDropShadow in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfHiddenAsRegular: WordBool;
begin
  Result:= mfHiddenAsRegular in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfHiddenIsVisible: WordBool;
begin
  Result:= mfHiddenIsVisible in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfLightenBitmaps: WordBool;
begin
  Result:= mfLightenBitmaps in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfNoAutoShowHidden: WordBool;
begin
  Result:= mfNoAutoShowHidden in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfNoBitmapRect: WordBool;
begin
  Result:= mfNoBitmapRect in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfNoHighDisabled: WordBool;
begin
  Result:= mfNoHighDisabled in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfNoShortDividers: WordBool;
begin
  Result:= mfNoShortDividers in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfRaiseBitmaps: WordBool;
begin
  Result:= mfRaiseBitmaps in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfRaiseMenuBarItem: WordBool;
begin
  Result:= mfRaiseMenuBarItem in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfShowCheckMark: WordBool;
begin
  Result:= mfShowCheckMark in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfSoftColors: WordBool;
begin
  Result:= mfSoftColors in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfStandardAlign: WordBool;
begin
  Result:= mfStandardAlign in FFlagsPtr^;
end;

function T_AM2000_FlagsAdapter.Get_mfXpControls: WordBool;
begin
  Result:= mfXpControls in FFlagsPtr^;
end;

procedure T_AM2000_FlagsAdapter.Set_mfBitmapShadow(Value: WordBool);
begin
  Include(FFlagsPtr^, mfBitmapShadow);
end;

procedure T_AM2000_FlagsAdapter.Set_mfDropShadow(Value: WordBool);
begin
  Include(FFlagsPtr^, mfDropShadow);
end;

procedure T_AM2000_FlagsAdapter.Set_mfHiddenAsRegular(Value: WordBool);
begin
  Include(FFlagsPtr^, mfHiddenAsRegular);
end;

procedure T_AM2000_FlagsAdapter.Set_mfHiddenIsVisible(Value: WordBool);
begin
  Include(FFlagsPtr^, mfHiddenIsVisible);
end;

procedure T_AM2000_FlagsAdapter.Set_mfLightenBitmaps(Value: WordBool);
begin
  Include(FFlagsPtr^, mfLightenBitmaps);
end;

procedure T_AM2000_FlagsAdapter.Set_mfNoAutoShowHidden(Value: WordBool);
begin
  Include(FFlagsPtr^, mfNoAutoShowHidden);
end;

procedure T_AM2000_FlagsAdapter.Set_mfNoBitmapRect(Value: WordBool);
begin
  Include(FFlagsPtr^, mfNoBitmapRect);
end;

procedure T_AM2000_FlagsAdapter.Set_mfNoHighDisabled(Value: WordBool);
begin
  Include(FFlagsPtr^, mfNoHighDisabled);
end;

procedure T_AM2000_FlagsAdapter.Set_mfNoShortDividers(Value: WordBool);
begin
  Include(FFlagsPtr^, mfNoShortDividers);
end;

procedure T_AM2000_FlagsAdapter.Set_mfRaiseBitmaps(Value: WordBool);
begin
  Include(FFlagsPtr^, mfRaiseBitmaps);
end;

procedure T_AM2000_FlagsAdapter.Set_mfRaiseMenuBarItem(Value: WordBool);
begin
  Include(FFlagsPtr^, mfRaiseMenuBarItem);
end;

procedure T_AM2000_FlagsAdapter.Set_mfShowCheckMark(Value: WordBool);
begin
  Include(FFlagsPtr^, mfShowCheckMark);
end;

procedure T_AM2000_FlagsAdapter.Set_mfSoftColors(Value: WordBool);
begin
  Include(FFlagsPtr^, mfSoftColors);
end;

procedure T_AM2000_FlagsAdapter.Set_mfStandardAlign(Value: WordBool);
begin
  Include(FFlagsPtr^, mfStandardAlign);
end;

procedure T_AM2000_FlagsAdapter.Set_mfXpControls(Value: WordBool);
begin
  Include(FFlagsPtr^, mfXpControls);
end;



{ T_AM2000_FontAdapter }

constructor T_AM2000_FontAdapter.Create(AFont: TFont);
begin
  inherited Create;
  FFont:= AFont;
end;

function T_AM2000_FontAdapter.GetGUID: TGUID;
begin
  Result:= IID_IFont;
end;

function T_AM2000_FontAdapter.Get_Bold: WordBool;
begin
  Result:= fsBold in FFont.Style;
end;

function T_AM2000_FontAdapter.Get_Charset: Smallint;
begin
  Result:= FFont.Charset;
end;

function T_AM2000_FontAdapter.Get_Italic: WordBool;
begin
  Result:= fsItalic in FFont.Style;
end;

function T_AM2000_FontAdapter.Get_Name: WideString;
begin
  Result:= FFont.Name;
end;

function T_AM2000_FontAdapter.Get_Size: SmallInt;
begin
  Result:= FFont.Size;
end;

function T_AM2000_FontAdapter.Get_StrikeThrough: WordBool;
begin
  Result:= fsStrikeOut in FFont.Style;
end;

function T_AM2000_FontAdapter.Get_Underline: WordBool;
begin
  Result:= fsUnderline in FFont.Style;
end;

procedure T_AM2000_FontAdapter.Set_Bold(Value: WordBool);
begin
  if Value
  then FFont.Style:= FFont.Style + [fsBold]
  else FFont.Style:= FFont.Style - [fsBold];
end;

procedure T_AM2000_FontAdapter.Set_Charset(Value: Smallint);
begin
  FFont.Charset:= Value;
end;

procedure T_AM2000_FontAdapter.Set_Italic(Value: WordBool);
begin
  if Value
  then FFont.Style:= FFont.Style + [fsItalic]
  else FFont.Style:= FFont.Style - [fsItalic];
end;

procedure T_AM2000_FontAdapter.Set_Name(const Value: WideString);
begin
  FFont.Name:= Value;
end;

procedure T_AM2000_FontAdapter.Set_Size(Value: SmallInt);
begin
  FFont.Size:= Value;
end;

procedure T_AM2000_FontAdapter.Set_StrikeThrough(Value: WordBool);
begin
  if Value
  then FFont.Style:= FFont.Style + [fsStrikeOut]
  else FFont.Style:= FFont.Style - [fsStrikeOut];
end;

procedure T_AM2000_FontAdapter.Set_Underline(Value: WordBool);
begin
  if Value
  then FFont.Style:= FFont.Style + [fsUnderline]
  else FFont.Style:= FFont.Style - [fsUnderline];
end;
{$ENDIF}


{ T_AM2000_Background

constructor T_AM2000_Background.Create(AOwner: T_AM2000_Bitmaps);
begin
  inherited Create;
  FOwner:= AOwner;
end;

destructor T_AM2000_Background.Destroy;
begin
  FBackground.Free;
  inherited;
end;

procedure T_AM2000_Background.SetBackground(const Value: TBitmap);
begin
  Bitmap.Assign(Value);
  Changed;
end;

function T_AM2000_Background.GetBackground: TBitmap;
begin
  if FBackground = nil
  then FBackground:= TBitmap.Create;
  
  Result:= FBackground;
end;

procedure T_AM2000_Background.SetBackgroundLayout(
  const Value: T_AM2000_BackgroundLayout);
begin
  FBackgroundLayout:= Value;
  Changed;
end;

procedure T_AM2000_Background.Changed;
begin

end;

function T_AM2000_Background.IsBackgroundStored: Boolean;
begin
  Result:= (FBackground <> nil) and (not FBackground.Empty);
end;


{ T_AM2000_Bitmaps

constructor T_AM2000_Bitmaps.Create(AOwner: T_AM2000_Options);
begin
  inherited Create;
  FOwner:= AOwner;
  FItem:= T_AM2000_Background.Create(Self);
  FMenu:= T_AM2000_Background.Create(Self);
  FToolbar:= T_AM2000_Background.Create(Self);
  FMarks:= T_AM2000_Marks.Create(Self);
  FSeparator:= TBitmap.Create;
end;

destructor T_AM2000_Bitmaps.Destroy;
begin
  FItem.Free;
  FMenu.Free;
  FToolbar.Free;
  FMarks.Free;
  FSeparator.Free;
  inherited;
end;

function T_AM2000_Bitmaps.IsDefault: Boolean;
begin
  Result:= True;
end;

procedure T_AM2000_Bitmaps.SetItem(const Value: T_AM2000_Background);
begin
  FItem:= Value;
end;

procedure T_AM2000_Bitmaps.SetMarks(const Value: T_AM2000_Marks);
begin
  FMarks:= Value;
end;

procedure T_AM2000_Bitmaps.SetMenu(const Value: T_AM2000_Background);
begin
  FMenu:= Value;
end;

procedure T_AM2000_Bitmaps.SetSeparator(const Value: TBitmap);
begin
  FSeparator:= Value;
end;

procedure T_AM2000_Bitmaps.SetToolbar(const Value: T_AM2000_Background);
begin
  FToolbar:= Value;
end;

{ T_AM2000_Marks

constructor T_AM2000_Marks.Create(AOwner: T_AM2000_Bitmaps);
begin
  inherited Create;
  FOwner:= AOwner;
end;

destructor T_AM2000_Marks.Destroy;
begin
  FBitmap.Free;
  inherited;
end;}

initialization
  PaintParams.mir:= T_AM2000_MenuItemRect.Create;

finalization
  PaintParams.mir.Free;
  PaintParams.mir:= nil;

end.
