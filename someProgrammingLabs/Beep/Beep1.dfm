object fmMain: TfmMain
  Left = 219
  Top = 177
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '['#1053#1086#1074#1072#1103' '#1084#1091#1079#1099#1082#1072']'
  ClientHeight = 370
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object lblSize: TLabel
    Left = 8
    Top = 201
    Width = 42
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1088':'
  end
  object sbPoint: TSpeedButton
    Left = 241
    Top = 248
    Width = 136
    Height = 24
    Cursor = crHandPoint
    AllowAllUp = True
    GroupIndex = 2
    Caption = #1058#1086#1095#1082#1072' (.)'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblTempo: TLabel
    Left = 241
    Top = 200
    Width = 30
    Height = 13
    Caption = #1058#1077#1084#1087':'
  end
  object pnl1_A: TPanel
    Tag = 22
    Left = 264
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 49
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_C: TPanel
    Tag = 13
    Left = 154
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 48
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_D: TPanel
    Tag = 15
    Left = 176
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 47
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_E: TPanel
    Tag = 17
    Left = 198
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 46
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_F: TPanel
    Tag = 18
    Left = 220
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 45
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_G: TPanel
    Tag = 20
    Left = 242
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 44
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_H: TPanel
    Tag = 24
    Left = 286
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 43
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_A: TPanel
    Tag = 34
    Left = 418
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 42
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_C: TPanel
    Tag = 25
    Left = 308
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 41
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_D: TPanel
    Tag = 27
    Left = 330
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 40
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_E: TPanel
    Tag = 29
    Left = 352
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 39
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_F: TPanel
    Tag = 30
    Left = 374
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 38
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_G: TPanel
    Tag = 32
    Left = 396
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 37
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_H: TPanel
    Tag = 36
    Left = 440
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 36
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_A: TPanel
    Tag = 46
    Left = 572
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 35
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_C: TPanel
    Tag = 37
    Left = 462
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 34
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_D: TPanel
    Tag = 39
    Left = 484
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 33
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_E: TPanel
    Tag = 41
    Left = 506
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 32
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_F: TPanel
    Tag = 42
    Left = 528
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 31
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_G: TPanel
    Tag = 44
    Left = 550
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 30
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_H: TPanel
    Tag = 48
    Left = 594
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 29
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_A: TPanel
    Tag = 10
    Left = 110
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 28
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_C: TPanel
    Tag = 1
    Left = 0
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 27
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_D: TPanel
    Tag = 3
    Left = 22
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 26
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_E: TPanel
    Tag = 5
    Left = 44
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 25
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_F: TPanel
    Tag = 6
    Left = 66
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 24
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_G: TPanel
    Tag = 8
    Left = 88
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 23
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_H: TPanel
    Tag = 12
    Left = 132
    Top = 274
    Width = 22
    Height = 97
    Cursor = crHandPoint
    Color = clWhite
    TabOrder = 22
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object sgLine: TStringGrid
    Left = 0
    Top = 0
    Width = 616
    Height = 185
    Align = alTop
    ColCount = 2
    DefaultColWidth = 30
    DefaultRowHeight = 10
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine]
    ScrollBars = ssHorizontal
    TabOrder = 0
    OnDrawCell = sgLineDrawCell
  end
  object cbxSize: TComboBox
    Left = 56
    Top = 193
    Width = 49
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 1
    Text = '4/4'
    OnChange = cbxSizeChange
    Items.Strings = (
      '1/2'
      '4/4'
      '3/4'
      '6/8')
  end
  object pnlS_Cd: TPanel
    Tag = 2
    Left = 13
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 2
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_Dd: TPanel
    Tag = 4
    Left = 35
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 3
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_Fd: TPanel
    Tag = 7
    Left = 79
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 4
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_Gd: TPanel
    Tag = 9
    Left = 101
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 5
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlS_Ad: TPanel
    Tag = 11
    Left = 123
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 6
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_Cd: TPanel
    Tag = 14
    Left = 167
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 7
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_Dd: TPanel
    Tag = 16
    Left = 189
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 8
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_Fd: TPanel
    Tag = 19
    Left = 233
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 9
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_Gd: TPanel
    Tag = 21
    Left = 255
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 10
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl1_Ad: TPanel
    Tag = 23
    Left = 277
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 11
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_Cd: TPanel
    Tag = 26
    Left = 321
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 12
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_Dd: TPanel
    Tag = 28
    Left = 343
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 13
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_Fd: TPanel
    Tag = 31
    Left = 387
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 14
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_Gd: TPanel
    Tag = 33
    Left = 409
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 15
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl2_Ad: TPanel
    Tag = 35
    Left = 431
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 16
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_Cd: TPanel
    Tag = 38
    Left = 475
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 17
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_Dd: TPanel
    Tag = 40
    Left = 497
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 18
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_Fd: TPanel
    Tag = 43
    Left = 541
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 19
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_Gd: TPanel
    Tag = 45
    Left = 563
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 20
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnl3_Ad: TPanel
    Tag = 47
    Left = 585
    Top = 274
    Width = 17
    Height = 57
    Cursor = crHandPoint
    BevelWidth = 2
    Color = clBlack
    TabOrder = 21
    OnMouseDown = pnlS_CMouseDown
    OnMouseUp = pnlS_CMouseUp
  end
  object pnlLength: TPanel
    Left = 0
    Top = 225
    Width = 242
    Height = 48
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    Caption = '  '#1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100': '
    TabOrder = 50
    object sb1: TSpeedButton
      Left = 88
      Top = 1
      Width = 23
      Height = 46
      Cursor = crHandPoint
      GroupIndex = 1
      Down = True
      Caption = 'w'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
    end
    object sb2: TSpeedButton
      Left = 111
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      GroupIndex = 1
      Caption = 'h'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
    end
    object sb4: TSpeedButton
      Left = 137
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      GroupIndex = 1
      Caption = 'q'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
    end
    object sb8: TSpeedButton
      Left = 163
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      GroupIndex = 1
      Caption = 'e'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
    end
    object sb16: TSpeedButton
      Left = 189
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      GroupIndex = 1
      Caption = 'x'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
    end
    object sb32: TSpeedButton
      Left = 215
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      GroupIndex = 1
      Caption = 'r'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlPause: TPanel
    Left = 377
    Top = 225
    Width = 238
    Height = 48
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    Caption = '  '#1044#1086#1073#1072#1074'. '#1087#1072#1091#1079#1091':'
    TabOrder = 51
    object sbP1: TSpeedButton
      Left = 84
      Top = 1
      Width = 23
      Height = 46
      Cursor = crHandPoint
      Caption = #1086
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      Layout = blGlyphBottom
      Margin = 1
      ParentFont = False
      OnClick = sbP1Click
    end
    object sbP2: TSpeedButton
      Left = 107
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      Caption = #1086
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = sbP1Click
    end
    object sbP4: TSpeedButton
      Left = 133
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      Caption = #1054
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
      OnClick = sbP1Click
    end
    object sbP8: TSpeedButton
      Left = 159
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      Caption = #1076
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
      OnClick = sbP1Click
    end
    object sbP16: TSpeedButton
      Left = 185
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      Caption = #1045
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
      OnClick = sbP1Click
    end
    object sbP32: TSpeedButton
      Left = 211
      Top = 1
      Width = 26
      Height = 46
      Cursor = crHandPoint
      Caption = #1025
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MusicalSymbols'
      Font.Style = []
      ParentFont = False
      OnClick = sbP1Click
    end
  end
  object pnlRec: TPanel
    Left = 442
    Top = 192
    Width = 97
    Height = 25
    Cursor = crHandPoint
    BevelWidth = 2
    Caption = #1047#1072#1087#1080#1089#1100
    TabOrder = 52
    OnClick = pnlRecClick
  end
  object btnDelete: TButton
    Left = 241
    Top = 225
    Width = 136
    Height = 25
    Cursor = crHandPoint
    Caption = '<< '#1059#1076#1072#1083#1080#1090#1100' '#1079#1085#1072#1082
    Enabled = False
    TabOrder = 53
    OnClick = btnDeleteClick
  end
  object btnPlay: TButton
    Left = 136
    Top = 193
    Width = 97
    Height = 21
    Cursor = crHandPoint
    Caption = #1042#1086#1089#1087#1088#1086#1080#1079#1074#1077#1089#1090#1080
    TabOrder = 54
    OnClick = btnPlayClick
  end
  object sedTempo: TSpinEdit
    Left = 273
    Top = 192
    Width = 49
    Height = 22
    MaxValue = 400
    MinValue = 20
    TabOrder = 55
    Value = 120
  end
  object bbtnExit: TBitBtn
    Left = 544
    Top = 192
    Width = 68
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 56
    Kind = bkClose
  end
  object btnStop: TButton
    Left = 328
    Top = 193
    Width = 81
    Height = 21
    Cursor = crHandPoint
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Enabled = False
    TabOrder = 57
    OnClick = btnStopClick
  end
  object Menu: TMainMenu
    Left = 152
    Top = 72
    object mmiFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object mmiFileNew: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100
        ShortCut = 16462
        OnClick = mmiFileNewClick
      end
      object mmiFileOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = mmiFileOpenClick
      end
      object mmiFileSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = mmiFileSaveClick
      end
      object mmiFilePrint: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100
        ShortCut = 16464
        OnClick = mmiFilePrintClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mmiFileExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 32856
        OnClick = mmiFileExitClick
      end
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = '*.mus'
    Filter = #1060#1072#1081#1083' '#1089' '#1084#1091#1079#1099#1082#1086#1081'|*.mus'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 248
    Top = 72
  end
  object dlgOpen: TOpenDialog
    Filter = #1060#1072#1081#1083' '#1089' '#1084#1091#1079#1099#1082#1086#1081'|*.mus'
    Left = 288
    Top = 72
  end
  object dlgPrint: TPrintDialog
    Left = 328
    Top = 72
  end
end
