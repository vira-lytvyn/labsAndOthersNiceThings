
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TFontMenu2000 Component                         }
{                                                       }
{       Copyright © 1997-2000 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/tfontmenu2000/
//

unit FontMenu2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, am2000menuitem, am2000popupmenu, am2000;

const
  FontStyleToName: array [TFontStyle] of String = ('Bold', 'Italic', 'Underline', 'Strikeout'); 

type
  T_AM2000_FontFamily = (fmDontcare, fmDecorative, fmFixed, fmRoman, fmScript, fmSwiss);
  T_AM2000_FontFamilies = set of T_AM2000_FontFamily;

  T_AM2000_FontType = (ftTrueType, ftRaster, ftVector);
  T_AM2000_FontTypes = set of T_AM2000_FontType;

  T_AM2000_FontChangeEvent = procedure (OldFont, NewFont: TFont; var AcceptChanges: Boolean) of object;

  TFontMenu2000 = class(TPopupMenu2000)
  private
    FActiveFont: TFont;
    FFontStyles: TFontStyles;
    FFontFamilies: T_AM2000_FontFamilies;
    FFontTypes: T_AM2000_FontTypes;
    FShowActiveFont: Boolean;
    FShowFontStyles: Boolean;
    FShowFontSizes: Boolean;
    FOnFontChange: T_AM2000_FontChangeEvent;

    procedure SetActiveFont(const Value: TFont);

  protected
    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;
    procedure UpdateComponentItems(Items: TMenuItem2000); override;
    procedure Click(Sender: TObject);


  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property ActiveFont: TFont
      read FActiveFont write SetActiveFont;
    property FontStyles: TFontStyles
      read FFontStyles write FFontStyles default [];
    property FontFamilies: T_AM2000_FontFamilies
      read FFontFamilies write FFontFamilies;
    property FontTypes: T_AM2000_FontTypes
      read FFontTypes write FFontTypes;
    property ShowActiveFont: Boolean
      read FShowActiveFont write FShowActiveFont default True;
    property ShowFontStyles: Boolean
      read FShowFontStyles write FShowFontStyles default True;
    property ShowFontSizes: Boolean
      read FShowFontSizes write FShowFontSizes default True;
    property OnFontChange: T_AM2000_FontChangeEvent
      read FOnFontChange write FOnFontChange;

  end;


implementation


{ TFontMenu2000 }

constructor TFontMenu2000.Create(AOwner: TComponent);
begin
  inherited;
  FActiveFont:= TFont.Create;
  FFontFamilies:= [fmDontcare, fmDecorative, fmFixed, fmRoman, fmScript, fmSwiss];
  FFontTypes:= [ftTrueType, ftRaster, ftVector];
  FShowActiveFont:= True;
  FShowFontStyles:= True;
  FShowFontSizes:= True;
end;

destructor TFontMenu2000.Destroy;
begin
  FActiveFont.Free;
  inherited;
end;

var
  FT: T_AM2000_FontTypes;
  FF: T_AM2000_FontFamilies;

procedure TFontMenu2000.CreateComponentItems(Items: TMenuItem2000;
  AddEmpty: Boolean);
var
  DC: HDC;
  L: TStringList;
  MI: TMenuItem2000;
  I: Integer;

  procedure EnumFamCallBack(lplf: PLogFont; lpntm: PNewTextMetric;
    FontType: DWORD; L: TStringList); stdcall;
  var
    FTOK, FFOK: Boolean;
  begin
    // check font type
    FTOK:=  (ftRaster in FT) and (FontType and RASTER_FONTTYPE <> 0)
      or (ftTrueType in FT) and (FontType and TRUETYPE_FONTTYPE <> 0)
      or (ftVector in FT);

    // check font family
    FFOK:= (fmDontcare in FF) and (lplf.lfPitchAndFamily and FF_DONTCARE = FF_DONTCARE)
      or (fmFixed in FF) and (lplf.lfPitchAndFamily and FF_MODERN = FF_MODERN)
      or (fmRoman in FF) and (lplf.lfPitchAndFamily and FF_ROMAN = FF_ROMAN)
      or (fmScript in FF) and (lplf.lfPitchAndFamily and FF_SCRIPT = FF_SCRIPT)
      or (fmSwiss in FF) and (lplf.lfPitchAndFamily and FF_SWISS = FF_SWISS);

    if FTOK and FFOK
    then L.Add(lplf.lfFaceName);
  end;

  procedure AddFontSizes(MI1: TMenuItem2000);
  var
    B: Boolean;
  begin
    B:= FShowActiveFont and MI.Checked and MI1.Checked;
    MI1.Add(NewItem('8', 0,  B and (FActiveFont.Size =  8), True, Click, 0, ''));
    MI1.Add(NewItem('9', 0,  B and (FActiveFont.Size =  9), True, Click, 0, ''));
    MI1.Add(NewItem('10', 0, B and (FActiveFont.Size = 10), True, Click, 0, ''));
    MI1.Add(NewItem('11', 0, B and (FActiveFont.Size = 11), True, Click, 0, ''));
    MI1.Add(NewItem('12', 0, B and (FActiveFont.Size = 12), True, Click, 0, ''));
    MI1.Add(NewItem('14', 0, B and (FActiveFont.Size = 14), True, Click, 0, ''));
    MI1.Add(NewItem('16', 0, B and (FActiveFont.Size = 16), True, Click, 0, ''));
    MI1.Add(NewItem('18', 0, B and (FActiveFont.Size = 18), True, Click, 0, ''));
    MI1.Add(NewItem('20', 0, B and (FActiveFont.Size = 20), True, Click, 0, ''));
    MI1.Add(NewItem('22', 0, B and (FActiveFont.Size = 22), True, Click, 0, ''));
    MI1.Add(NewItem('24', 0, B and (FActiveFont.Size = 24), True, Click, 0, ''));
    MI1.Add(NewItem('26', 0, B and (FActiveFont.Size = 26), True, Click, 0, ''));
    MI1.Add(NewItem('28', 0, B and (FActiveFont.Size = 28), True, Click, 0, ''));
    MI1.Add(NewItem('36', 0, B and (FActiveFont.Size = 36), True, Click, 0, ''));
    MI1.Add(NewItem('48', 0, B and (FActiveFont.Size = 48), True, Click, 0, ''));
    MI1.Add(NewItem('72', 0, B and (FActiveFont.Size = 72), True, Click, 0, ''));
  end;

  procedure AddFontStyle(StyleName: String; FontStyle: TFontStyles);
  var
    MI1: TMenuItem2000;
  begin
    MI1:= TMenuItem2000.Create(Owner);
    MI1.Caption:= L[I] + ' ' + StyleName;
    MI1.Hint:= MI1.Caption;
    MI1.Control:= ctlText;
    MI1.OnClick:= Click;
    MI1.Checked:= FShowActiveFont
      and (MI.Checked and (FActiveFont.Style = FontStyle));

    with MI1.AsText
    do begin
      ParentFontName:= False;
      Font.Name:= L[I];
      Font.Color:= Options.Colors.MenuText;
      Font.Style:= FontStyle;
      HighlightFont.Name:= L[I];
      HighlightFont.Color:= Options.Colors.HighlightText;
      HighlightFont.Style:= FontStyle;
    end;

    if FShowFontSizes
    then AddFontSizes(MI1);
    MI.Add(MI1);
  end;

begin
  L:= TStringList.Create;
  L.Sorted:= True;
  FT:= FFontTypes;
  FF:= FFontFamilies;

  // enumerate fonts
  DC:= CreateDC('DISPLAY', nil, nil, nil);
  EnumFontFamilies(DC, nil, @EnumFamCallBack, Integer(L));
  DeleteDC(DC);

  // create menu items
  for I:= 0 to L.Count -1
  do begin
    MI:= TMenuItem2000.Create(Owner);
    MI.Caption:= L[I];
    MI.Hint:= MI.Caption;
    MI.Control:= ctlText;
    MI.OnClick:= Click;
    MI.Checked:= FShowActiveFont
      and (L[I] = FActiveFont.Name);

    with MI.AsText
    do begin
      ParentFontName:= False;
      Font.Name:= MI.Caption;
      Font.Color:= Options.Colors.MenuText;
      HighlightFont.Name:= MI.Caption;
      HighlightFont.Color:= Options.Colors.HighlightText;
    end;

    if FShowFontStyles
    then begin
      AddFontStyle('Regular', []);

      if (fsBold in FFontStyles)
      then AddFontStyle('Bold', [fsBold]);

      if (fsItalic in FFontStyles)
      then AddFontStyle('Italic', [fsItalic]);

      if (fsBold in FFontStyles)
      and (fsItalic in FFontStyles)
      then AddFontStyle('Bold Italic', [fsBold, fsItalic]);

      if (fsUnderline in FFontStyles)
      then AddFontStyle('Underline', [fsUnderline]);

      if (fsUnderline in FFontStyles)
      and (fsBold in FFontStyles)
      then AddFontStyle('Underline Bold', [fsBold, fsUnderline]);

      if (fsUnderline in FFontStyles)
      and (fsItalic in FFontStyles)
      then AddFontStyle('Underline Italic', [fsItalic, fsUnderline]);

      if (fsUnderline in FFontStyles)
      and (fsBold in FFontStyles)
      and (fsItalic in FFontStyles)
      then AddFontStyle('Underline Bold Italic', [fsBold, fsItalic, fsUnderline]);

      if (fsStrikeout in FFontStyles)
      then AddFontStyle('Strikeout', [fsStrikeout]);

      if (fsStrikeout in FFontStyles)
      and (fsBold in FFontStyles)
      then AddFontStyle('Strikeout Bold', [fsBold, fsStrikeout]);

      if (fsStrikeout in FFontStyles)
      and (fsItalic in FFontStyles)
      then AddFontStyle('Strikeout Italic', [fsItalic, fsStrikeout]);

      if (fsStrikeout in FFontStyles)
      and (fsBold in FFontStyles)
      and (fsItalic in FFontStyles)
      then AddFontStyle('Strikeout Bold Italic', [fsBold, fsItalic, fsStrikeout]);

      if (fsStrikeout in FFontStyles)
      and (fsUnderline in FFontStyles)
      then AddFontStyle('Strikeout Underline', [fsUnderline, fsStrikeout]);

      if (fsStrikeout in FFontStyles)
      and (fsUnderline in FFontStyles)
      and (fsBold in FFontStyles)
      then AddFontStyle('Strikeout Underline Bold', [fsBold, fsUnderline, fsStrikeout]);

      if (fsStrikeout in FFontStyles)
      and (fsUnderline in FFontStyles)
      and (fsItalic in FFontStyles)
      then AddFontStyle('Strikeout Underline Italic', [fsItalic, fsUnderline, fsStrikeout]);

      if (fsStrikeout in FFontStyles)
      and (fsUnderline in FFontStyles)
      and (fsBold in FFontStyles)
      and (fsItalic in FFontStyles)
      then AddFontStyle('Strikeout Underline Bold Italic', [fsBold, fsItalic, fsUnderline, fsStrikeout]);
    end;

    Items.Add(MI);
  end;

  L.Free;
end;

function TFontMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Font Menu Items';
end;

procedure TFontMenu2000.SetActiveFont(const Value: TFont);
begin
  FActiveFont.Assign(Value);
end;

procedure TFontMenu2000.Click(Sender: TObject);
var
  NewFont: TFont;
  AcceptChanges: Boolean;
begin
  if (not (Sender is TMenuItem2000))
  or (TMenuItem2000(Sender).Count <> 0)
  then Exit;

  with TMenuItem2000(Sender)
  do begin
    NewFont:= TFont.Create;
    NewFont.Assign(FActiveFont);

    if Control = ctlNone
    then begin
      with TMenuItem2000(Parent).AsText.Font
      do begin
        NewFont.Name:= Name;
        NewFont.Style:= Style;
      end;
      
      NewFont.Size:= StrToInt(Caption);
    end
    else
      with AsText.Font
      do begin
        NewFont.Name:= Name;
        NewFont.Style:= Style;
      end;

    AcceptChanges:= True;
    if Assigned(OnFontChange)
    then OnFontChange(FActiveFont, NewFont, AcceptChanges);

    if AcceptChanges
    then FActiveFont.Assign(NewFont);

    NewFont.Free;
  end;
end;

procedure TFontMenu2000.UpdateComponentItems(Items: TMenuItem2000);
var
  I: Integer;

  procedure UpdateSizes(MI: TMenuItem2000);
  var
    I: Integer;
    FS: String;
  begin
    FS:= IntToStr(FActiveFont.Size);
    for I:= 0 to MI.Count -1
    do begin
      MI[I].Checked:= (MI[I].Caption = FS);
    end;
  end;

  procedure UpdateStyles(MI: TMenuItem2000);
  var
    I: Integer;
    FS: TFontStyles;
  begin
    FS:= FActiveFont.Style;
    for I:= 0 to MI.Count -1
    do begin
      MI[I].Checked:= (MI[I].AsText.Font.Style = FS);
      if MI[I].Checked
      then UpdateSizes(MI[I]);
    end;
  end;

begin
  if not FShowActiveFont
  then Exit;

  for I:= 0 to Items.Count -1
  do begin
    Items[I].Checked:= (Items[I].Caption = FActiveFont.Name);
    if Items[I].Checked
    then UpdateStyles(Items[I]);
  end;
end;

end.

