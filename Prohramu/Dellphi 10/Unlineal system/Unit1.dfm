object Form1: TForm1
  Left = 189
  Top = 113
  Caption = 'Form1'
  ClientHeight = 451
  ClientWidth = 688
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
  object Label4: TLabel
    Left = 320
    Top = 232
    Width = 3
    Height = 13
  end
  object Label5: TLabel
    Left = 25
    Top = 34
    Width = 41
    Height = 24
    Caption = 'First'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 24
    Top = 58
    Width = 97
    Height = 24
    Caption = 'conditions'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 392
    Top = 34
    Width = 58
    Height = 24
    Caption = 'Resalt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 144
    Top = 109
    Width = 34
    Height = 24
    Caption = 'N ='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 512
    Top = 272
    Width = 44
    Height = 24
    Caption = 'K =  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 144
    Top = 235
    Width = 77
    Height = 24
    Caption = 'Kmax = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 144
    Top = 167
    Width = 55
    Height = 24
    Caption = 'Eps ='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 144
    Top = 382
    Width = 88
    Height = 33
    Caption = 'Do'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 24
    Top = 88
    Width = 96
    Height = 241
    ColCount = 1
    FixedCols = 0
    RowCount = 50
    FixedRows = 0
    GridLineWidth = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 1
  end
  object StringGrid2: TStringGrid
    Left = 392
    Top = 88
    Width = 97
    Height = 241
    Color = clBtnFace
    ColCount = 1
    Enabled = False
    FixedCols = 0
    RowCount = 50
    FixedRows = 0
    GridLineWidth = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 219
    Top = 114
    Width = 62
    Height = 21
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Text = '3'
  end
  object Edit2: TEdit
    Left = 219
    Top = 172
    Width = 62
    Height = 21
    TabOrder = 4
  end
  object Edit3: TEdit
    Left = 219
    Top = 232
    Width = 62
    Height = 21
    TabOrder = 5
  end
  object Edit4: TEdit
    Left = 560
    Top = 269
    Width = 65
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object BitBtn2: TBitBtn
    Left = 449
    Top = 382
    Width = 97
    Height = 33
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Kind = bkClose
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 7
  end
  object BitBtn1: TBitBtn
    Left = 290
    Top = 382
    Width = 103
    Height = 33
    Caption = 'Clear '
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 8
    OnClick = BitBtn1Click
  end
end
