object fmVariants: TfmVariants
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1074#1072#1088#1080#1072#1085#1090#1086#1074
  ClientHeight = 300
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTopics: TPanel
    Left = 0
    Top = 0
    Width = 220
    Height = 173
    Align = alLeft
    BevelOuter = bvLowered
    Caption = #1058#1077#1084#1072#1090#1080#1082#1080
    Color = clGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    VerticalAlignment = taAlignTop
    object clbTopics: TCheckListBox
      Left = 1
      Top = 14
      Width = 218
      Height = 131
      OnClickCheck = clbTopicsClickCheck
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
    end
    object btnSelectAll: TButton
      Left = 1
      Top = 146
      Width = 91
      Height = 25
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnSelectAllClick
    end
    object btnDeselectAll: TButton
      Left = 92
      Top = 146
      Width = 126
      Height = 25
      Caption = #1057#1085#1103#1090#1100' '#1084#1077#1090#1082#1080' '#1089#1086' '#1074#1089#1077#1093
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnDeselectAllClick
    end
  end
  object pnlVariants: TPanel
    Left = 0
    Top = 173
    Width = 594
    Height = 127
    Align = alBottom
    BevelOuter = bvLowered
    Caption = #1042#1072#1088#1080#1072#1085#1090#1099
    Color = clGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    VerticalAlignment = taAlignTop
    object sgVariants: TStringGrid
      Left = 1
      Top = 16
      Width = 592
      Height = 110
      Align = alBottom
      ColCount = 3
      Ctl3D = False
      DefaultRowHeight = 17
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSelect]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnClick = sgVariantsClick
      OnDblClick = sgVariantsDblClick
      OnKeyUp = sgVariantsKeyUp
      ColWidths = (
        181
        153
        232)
    end
  end
  object pnlControl: TPanel
    Left = 220
    Top = 0
    Width = 374
    Height = 173
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 2
    object btnSelect: TButton
      Left = 12
      Top = 60
      Width = 350
      Height = 25
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1072#1088#1080#1072#1085#1090#1099' '#1089#1083#1086#1074' '#1087#1086' '#1086#1090#1084#1077#1095#1077#1085#1085#1099#1084' '#1090#1077#1084#1072#1090#1080#1082#1072#1084
      TabOrder = 0
      OnClick = btnSelectClick
    end
    object pnlMask: TPanel
      Left = 1
      Top = 1
      Width = 372
      Height = 52
      Align = alTop
      BevelOuter = bvLowered
      Caption = #1052#1072#1089#1082#1072' '#1089#1083#1086#1074#1072
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      VerticalAlignment = taAlignTop
      object lblMask: TLabel
        Left = 1
        Top = 16
        Width = 370
        Height = 35
        Align = alBottom
        Alignment = taCenter
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        ExplicitWidth = 9
      end
    end
    object pnlWord: TPanel
      Left = 1
      Top = 120
      Width = 372
      Height = 52
      Align = alBottom
      BevelOuter = bvLowered
      Caption = #1042#1099#1073#1088#1072#1085#1085#1086#1077' '#1089#1083#1086#1074#1086
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      VerticalAlignment = taAlignTop
      object lblWord: TLabel
        Left = 1
        Top = 16
        Width = 370
        Height = 35
        Align = alBottom
        Alignment = taCenter
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        ExplicitWidth = 9
      end
    end
    object bbtnOK: TBitBtn
      Left = 12
      Top = 90
      Width = 225
      Height = 25
      Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1074#1072#1088#1080#1072#1085#1090
      Enabled = False
      TabOrder = 3
      Kind = bkOK
    end
    object bbtnCancel: TBitBtn
      Left = 244
      Top = 90
      Width = 118
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 4
      Kind = bkCancel
    end
  end
end
