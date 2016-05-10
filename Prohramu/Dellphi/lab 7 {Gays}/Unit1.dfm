object Form1: TForm1
  Left = 236
  Top = 150
  Width = 776
  Height = 485
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 360
    Top = 72
    Width = 195
    Height = 20
    Caption = #1057#1090#1086#1074#1073#1077#1094#1100' '#1074#1110#1083#1100#1085#1080#1093' '#1095#1083#1077#1085#1110#1074'  '
    Color = clGradientActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 568
    Top = 72
    Width = 93
    Height = 20
    Caption = '  '#1056#1086#1079#1074#39#1103#1079#1086#1082'   '
    Color = clGradientActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 72
    Width = 329
    Height = 20
    Caption = #1042#1074#1077#1076#1110#1090#1100' '#1088#1086#1079#1084#1110#1088#1085#1110#1089#1090#1090#1100' '#1090#1072' '#1077#1083#1077#1084#1077#1085#1090#1080' '#1084#1072#1090#1088#1080#1094#1110' '
    Color = clGradientActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object StringGrid2: TStringGrid
    Left = 368
    Top = 152
    Width = 97
    Height = 137
    ColCount = 1
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    ParentColor = True
    TabOrder = 1
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24)
  end
  object StringGrid3: TStringGrid
    Left = 568
    Top = 152
    Width = 97
    Height = 137
    ColCount = 1
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInactiveCaption
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    RowHeights = (
      24
      20
      24
      24
      24
      24
      24)
  end
  object Button1: TButton
    Left = 120
    Top = 352
    Width = 100
    Height = 25
    Caption = ' '#1056#1086#1079#1074#39#1103#1079#1072#1090#1080' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 44
    Top = 152
    Width = 229
    Height = 137
    ColCount = 7
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    ParentColor = True
    TabOrder = 0
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24)
  end
  object Edit1: TEdit
    Left = 72
    Top = 104
    Width = 65
    Height = 21
    ImeName = 'Ukrainian'
    TabOrder = 4
    OnChange = Edit1Change
  end
  object BitBtn1: TBitBtn
    Left = 480
    Top = 352
    Width = 75
    Height = 25
    Caption = '& '#1042#1080#1081#1090#1080
    TabOrder = 5
    Kind = bkClose
  end
  object Button2: TButton
    Left = 296
    Top = 352
    Width = 90
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = Button2Click
  end
end
