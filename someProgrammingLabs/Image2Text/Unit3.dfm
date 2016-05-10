object Form3: TForm3
  Left = 372
  Top = 316
  BorderStyle = bsDialog
  Caption = 'Screenshot'
  ClientHeight = 183
  ClientWidth = 298
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton2: TSpeedButton
    Left = 88
    Top = 152
    Width = 121
    Height = 22
    Caption = #1057#1076#1077#1083#1072#1090#1100' '#1089#1082#1088#1080#1085#1096#1086#1090
    Enabled = False
    Flat = True
    OnClick = SpeedButton2Click
  end
  object Label1: TLabel
    Left = 40
    Top = 8
    Width = 209
    Height = 26
    Caption = #1044#1072#1085#1085#1099#1081' '#1087#1083#1072#1075#1080#1085' '#1087#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1089#1082#1088#1080#1085#1096#1086#1090#1072' '#1074#1089#1077#1075#1086' '#1101#1082#1088#1072#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 40
    Width = 297
    Height = 97
    Caption = #1055#1091#1090#1100' '#1082' '#1089#1086#1093#1088#1072#1085#1103#1077#1084#1086#1084#1091' '#1089#1082#1088#1080#1085#1096#1086#1090#1091
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 96
      Top = 56
      Width = 105
      Height = 22
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
      Flat = True
      OnClick = SpeedButton1Click
    end
    object Edit1: TEdit
      Left = 8
      Top = 20
      Width = 281
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.bmp'
    Filter = 'bmp|*.bmp'
    Left = 16
    Top = 88
  end
end
