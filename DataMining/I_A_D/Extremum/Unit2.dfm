object Form2: TForm2
  Left = 217
  Top = 248
  Width = 502
  Height = 361
  Caption = 'Extremum'
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
    Left = 8
    Top = 35
    Width = 14
    Height = 13
    Caption = 'a='
  end
  object Label2: TLabel
    Left = 8
    Top = 75
    Width = 14
    Height = 13
    Caption = 'b='
  end
  object Label3: TLabel
    Left = 12
    Top = 115
    Width = 31
    Height = 13
    Caption = 'eps = '
  end
  object Label4: TLabel
    Left = 75
    Top = 216
    Width = 38
    Height = 13
    Caption = 'Point = '
  end
  object Label5: TLabel
    Left = 230
    Top = 240
    Width = 3
    Height = 13
  end
  object Label6: TLabel
    Left = 75
    Top = 251
    Width = 40
    Height = 13
    Caption = 'Value = '
  end
  object Label7: TLabel
    Left = 230
    Top = 259
    Width = 3
    Height = 13
  end
  object Label8: TLabel
    Left = 75
    Top = 286
    Width = 63
    Height = 13
    Caption = 'Derivative = '
  end
  object Label9: TLabel
    Left = 230
    Top = 278
    Width = 3
    Height = 13
  end
  object Label10: TLabel
    Left = 288
    Top = 40
    Width = 20
    Height = 13
    Caption = 'h = '
  end
  object Label11: TLabel
    Left = 288
    Top = 72
    Width = 20
    Height = 13
    Caption = 'e = '
  end
  object Label12: TLabel
    Left = 288
    Top = 104
    Width = 26
    Height = 13
    Caption = 'x0 = '
  end
  object Label13: TLabel
    Left = 288
    Top = 136
    Width = 31
    Height = 13
    Caption = 'eps = '
  end
  object Label14: TLabel
    Left = 8
    Top = 160
    Width = 20
    Height = 13
    Caption = 'n = '
  end
  object Edit1: TEdit
    Left = 48
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object Edit2: TEdit
    Left = 48
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object Edit3: TEdit
    Left = 48
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0,0001'
  end
  object Button1: TButton
    Left = 192
    Top = 48
    Width = 73
    Height = 25
    Caption = 'Gold'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 192
    Top = 88
    Width = 73
    Height = 25
    Caption = 'Div2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 192
    Top = 128
    Width = 73
    Height = 25
    Caption = 'Random'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Edit4: TEdit
    Left = 48
    Top = 152
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '200'
  end
  object Button4: TButton
    Left = 352
    Top = 168
    Width = 73
    Height = 25
    Caption = 'Grad'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Edit5: TEdit
    Left = 328
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 8
    Text = '0,0001'
  end
  object Edit6: TEdit
    Left = 328
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '0,01'
  end
  object Edit7: TEdit
    Left = 328
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 10
    Text = '0,003'
  end
  object Edit8: TEdit
    Left = 328
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 11
    Text = '0,001'
  end
  object Edit9: TEdit
    Left = 208
    Top = 216
    Width = 121
    Height = 21
    TabOrder = 12
  end
  object Edit10: TEdit
    Left = 208
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 13
  end
  object Edit11: TEdit
    Left = 208
    Top = 280
    Width = 121
    Height = 21
    TabOrder = 14
  end
end
