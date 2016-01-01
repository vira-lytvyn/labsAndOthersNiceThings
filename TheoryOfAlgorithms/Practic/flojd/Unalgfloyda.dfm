object Form1: TForm1
  Left = 244
  Top = 197
  BorderStyle = bsDialog
  Caption = #1040#1083#1075#1086#1088#1080#1090#1084' '#1060#1083#1086#1081#1076#1072' '#1076#1083#1103' '#1087#1086#1096#1091#1082#1091' '#1085#1072#1081#1082#1086#1088#1086#1090#1096#1080#1093' '#1096#1083#1103#1093#1110#1074' '#1091' '#1075#1088#1072#1092#1110
  ClientHeight = 421
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 456
    Top = 8
    Width = 121
    Height = 13
    Caption = #1052#1072#1090#1088#1080#1094#1103' '#1076#1086#1074#1078#1080#1085' '#1096#1083#1103#1093#1110#1074
  end
  object Label3: TLabel
    Left = 232
    Top = 8
    Width = 149
    Height = 13
    Caption = #1052#1072#1090#1088#1080#1094#1103' '#1085#1072#1081#1082#1086#1088#1086#1090#1096#1080#1093' '#1096#1083#1103#1093#1110#1074
  end
  object Label1: TLabel
    Left = 232
    Top = 216
    Width = 134
    Height = 13
    Caption = #1052#1072#1090#1088#1080#1094#1103' '#1089#1091#1084#1110#1078#1085#1080#1093' '#1074#1077#1088#1096#1080#1085
  end
  object StringGrid1: TStringGrid
    Left = 458
    Top = 22
    Width = 175
    Height = 179
    DefaultColWidth = 30
    DefaultRowHeight = 30
    FixedColor = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goThumbTracking]
    ParentFont = False
    TabOrder = 0
    ColWidths = (
      30
      30
      30
      30
      30)
  end
  object StringGrid2: TStringGrid
    Left = 232
    Top = 24
    Width = 185
    Height = 177
    DefaultColWidth = 30
    DefaultRowHeight = 30
    FixedColor = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowMoving, goColMoving]
    ParentFont = False
    TabOrder = 1
    ColWidths = (
      30
      30
      30
      30
      30)
  end
  object BitBtn1: TBitBtn
    Left = 512
    Top = 216
    Width = 73
    Height = 25
    Caption = #1047#1085#1072#1081#1090#1080
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object StringGrid3: TStringGrid
    Left = 232
    Top = 232
    Width = 185
    Height = 177
    DefaultColWidth = 30
    DefaultRowHeight = 30
    FixedColor = clWhite
    TabOrder = 3
    ColWidths = (
      30
      30
      30
      30
      30)
  end
  object btn1: TButton
    Left = 504
    Top = 256
    Width = 89
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1080' '#1096#1083#1103#1093
    TabOrder = 4
    OnClick = btn1Click
  end
  object lst1: TListBox
    Left = 8
    Top = 8
    Width = 209
    Height = 401
    ItemHeight = 13
    TabOrder = 5
  end
end
