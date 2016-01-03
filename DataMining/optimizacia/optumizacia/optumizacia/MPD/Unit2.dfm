object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 375
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 51
    Width = 14
    Height = 13
    Caption = 'a='
  end
  object Label2: TLabel
    Left = 24
    Top = 91
    Width = 14
    Height = 13
    Caption = 'b='
  end
  object Label3: TLabel
    Left = 20
    Top = 131
    Width = 46
    Height = 13
    Caption = 'tochnist='
  end
  object Label4: TLabel
    Left = 56
    Top = 232
    Width = 100
    Height = 13
    Caption = #1058#1086#1095#1082#1072' '#1077#1082#1089#1090#1088#1077#1084#1091#1084#1091'='
  end
  object Label5: TLabel
    Left = 192
    Top = 232
    Width = 3
    Height = 13
  end
  object Label6: TLabel
    Left = 56
    Top = 267
    Width = 95
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1085#1103' '#1092#1091#1085#1082#1094#1110#1111'='
  end
  object Label7: TLabel
    Left = 195
    Top = 267
    Width = 3
    Height = 13
  end
  object Label8: TLabel
    Left = 56
    Top = 304
    Width = 78
    Height = 13
    Caption = #1055#1086#1093#1110#1076#1085#1072' '#1074' '#1090#1086#1095#1094#1110
  end
  object Label9: TLabel
    Left = 192
    Top = 304
    Width = 3
    Height = 13
  end
  object Edit1: TEdit
    Left = 72
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 72
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 72
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 72
    Top = 176
    Width = 121
    Height = 25
    Caption = 'start'
    TabOrder = 3
    OnClick = Button1Click
  end
end
