object Form1: TForm1
  Left = 192
  Top = 114
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Animate1: TAnimate
    Left = 40
    Top = 40
    Width = 281
    Height = 193
    Active = False
  end
  object Button1: TButton
    Left = 64
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Go'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 480
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = Button2Click
  end
  object RadioGroup1: TRadioGroup
    Left = 392
    Top = 72
    Width = 185
    Height = 105
    Caption = 'RadioGroup1'
    Items.Strings = (
      #1082#1086#1087#1110#1102#1074#1072#1085#1085#1103' '#1092#1072#1081#1083#1091
      #1082#1086#1087#1110#1102#1074#1072#1085#1085#1103' '#1092#1072#1081#1083#1110#1074
      #1087#1091#1089#1090#1072' '#1082#1086#1088#1079#1080#1085#1072
      #1074#1080#1076#1072#1083#1077#1085#1085#1103' '#1092#1072#1081#1083#1091
      #1087#1086#1096#1091#1082' '#1092#1072#1081#1083#1091
      #1087#1086#1096#1091#1082' '#1087#1072#1087#1082#1080)
    TabOrder = 3
  end
  object BitBtn1: TBitBtn
    Left = 288
    Top = 384
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkClose
  end
end
