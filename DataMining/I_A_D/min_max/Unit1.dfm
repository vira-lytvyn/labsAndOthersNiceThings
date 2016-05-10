object Form1: TForm1
  Left = 252
  Top = 165
  Width = 363
  Height = 417
  Caption = 'Form1'
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
    Left = 152
    Top = 24
    Width = 20
    Height = 13
    Caption = 'n = '
  end
  object Label2: TLabel
    Left = 152
    Top = 48
    Width = 20
    Height = 13
    Caption = 'a = '
  end
  object Label3: TLabel
    Left = 152
    Top = 80
    Width = 20
    Height = 13
    Caption = 'b = '
  end
  object StringGrid1: TStringGrid
    Left = 24
    Top = 8
    Width = 89
    Height = 369
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 179
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '15'
  end
  object Button1: TButton
    Left = 203
    Top = 224
    Width = 70
    Height = 33
    Caption = 'Min'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 203
    Top = 120
    Width = 70
    Height = 33
    Caption = 'Fill '
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit2: TEdit
    Left = 179
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '-2'
  end
  object Edit3: TEdit
    Left = 179
    Top = 75
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '1'
  end
  object Edit4: TEdit
    Left = 184
    Top = 186
    Width = 105
    Height = 21
    TabOrder = 6
  end
end
