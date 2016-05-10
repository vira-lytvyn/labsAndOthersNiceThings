object Form1: TForm1
  Left = 253
  Top = 131
  Width = 690
  Height = 624
  Caption = #1056#1086#1079#1074#39#1103#1079#1072#1085#1085#1103' '#1057#1051#1040#1056' '#1084#1077#1090#1086#1076#1086#1084' LU - '#1087#1077#1088#1077#1090#1074#1086#1088#1077#1085#1085#1103
  Color = 12648322
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 160
    Height = 22
    Caption = #1042#1074#1077#1076#1110#1090#1100'  '#1084#1072#1090#1088#1080#1094#1102' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16033024
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 344
    Top = 16
    Width = 164
    Height = 22
    Caption = #1042#1074#1077#1076#1110#1090#1100' '#1089#1086#1090#1086#1074#1073#1077#1094#1100' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16033024
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 320
    Width = 257
    Height = 22
    Caption = #1052#1072#1090#1088#1080#1094#1103'  LU -  '#1087#1077#1077#1090#1074#1086#1088#1077#1085#1085#1103' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16033024
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic, fsUnderline]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 376
    Top = 320
    Width = 82
    Height = 22
    Caption = #1056#1086#1079#1074#39#1103#1079#1086#1082' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16033024
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic, fsUnderline]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 368
    Top = 40
    Width = 134
    Height = 22
    Caption = #1074#1110#1083#1100#1085#1080#1093' '#1095#1083#1077#1085#1110#1074' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16033024
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 16
    Top = 40
    Width = 73
    Height = 32
    Color = 16777117
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16749092
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImeName = 'Ukrainian'
    ParentFont = False
    TabOrder = 0
    OnChange = Edit1Change
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 88
    Width = 297
    Height = 193
    Color = 16777117
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 1
  end
  object StringGrid2: TStringGrid
    Left = 376
    Top = 88
    Width = 121
    Height = 193
    Color = 16777117
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 2
  end
  object StringGrid3: TStringGrid
    Left = 16
    Top = 360
    Width = 297
    Height = 217
    Color = 16777117
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goTabs]
    TabOrder = 3
  end
  object StringGrid4: TStringGrid
    Left = 376
    Top = 360
    Width = 129
    Height = 217
    Color = 16777117
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goTabs]
    TabOrder = 4
  end
  object BitBtn2: TBitBtn
    Left = 560
    Top = 280
    Width = 105
    Height = 33
    Caption = #1054#1095#1080#1089#1090#1080#1090#1080' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16033024
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 560
    Top = 192
    Width = 105
    Height = 33
    Cursor = crHandPoint
    Caption = #1056#1086#1079#1074#39#1103#1079#1072#1090#1080' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16033024
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = BitBtn3Click
  end
  object BitBtn1: TBitBtn
    Left = 560
    Top = 368
    Width = 105
    Height = 33
    Caption = '& '#1042#1080#1081#1090#1080' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16749092
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    Kind = bkClose
  end
  object XPManifest1: TXPManifest
  end
end
