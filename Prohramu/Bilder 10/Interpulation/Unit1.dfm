object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 601
  ClientWidth = 730
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 560
    Top = 109
    Width = 16
    Height = 29
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 635
    Top = 109
    Width = 16
    Height = 29
    Caption = 'Y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 538
    Top = 56
    Width = 57
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 634
    Top = 56
    Width = 57
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object StringGrid1: TStringGrid
    Left = 538
    Top = 144
    Width = 153
    Height = 177
    ColCount = 2
    FixedCols = 0
    RowCount = 50
    FixedRows = 0
    TabOrder = 2
  end
  object Edit3: TEdit
    Left = 560
    Top = 352
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit3'
  end
  object BitBtn1: TBitBtn
    Left = 576
    Top = 456
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object Edit4: TEdit
    Left = 560
    Top = 408
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'Edit4'
  end
end
