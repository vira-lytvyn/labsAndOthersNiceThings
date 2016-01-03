object Form1: TForm1
  Left = 260
  Top = 381
  Width = 389
  Height = 442
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
    Left = 136
    Top = 24
    Width = 20
    Height = 13
    Caption = 'n = '
  end
  object Label2: TLabel
    Left = 136
    Top = 64
    Width = 20
    Height = 13
    Caption = 'a = '
  end
  object Label3: TLabel
    Left = 136
    Top = 88
    Width = 20
    Height = 13
    Caption = 'b = '
  end
  object StringGrid1: TStringGrid
    Left = 24
    Top = 8
    Width = 89
    Height = 377
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 171
    Top = 21
    Width = 54
    Height = 21
    TabOrder = 1
    Text = '15'
  end
  object Button2: TButton
    Left = 152
    Top = 272
    Width = 73
    Height = 33
    Caption = 'Sort_Down'
    TabOrder = 2
    OnClick = Button2Click
  end
  object StringGrid2: TStringGrid
    Left = 264
    Top = 8
    Width = 89
    Height = 377
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 3
  end
  object Button3: TButton
    Left = 152
    Top = 200
    Width = 73
    Height = 33
    Caption = 'Fill'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Edit2: TEdit
    Left = 171
    Top = 56
    Width = 54
    Height = 21
    TabOrder = 5
    Text = '-2'
  end
  object Edit3: TEdit
    Left = 171
    Top = 83
    Width = 54
    Height = 22
    TabOrder = 6
    Text = '1'
  end
end
