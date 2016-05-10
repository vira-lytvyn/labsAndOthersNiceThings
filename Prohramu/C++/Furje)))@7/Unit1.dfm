object Form1: TForm1
  Left = 187
  Top = 77
  Width = 1166
  Height = 631
  Caption = 'Metod Furje'
  Color = 16759929
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 0
    Width = 9
    Height = 833
    Cursor = crHSplit
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 873
    Height = 833
    Color = 16763283
    TabOrder = 0
    object Image1: TPaintBox
      Left = 0
      Top = 32
      Width = 873
      Height = 377
    end
    object Image2: TPaintBox
      Left = -8
      Top = 448
      Width = 881
      Height = 385
    end
    object Label6: TLabel
      Left = 0
      Top = 0
      Width = 106
      Height = 25
      Caption = 'Garmoniky'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -22
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 0
      Top = 416
      Width = 141
      Height = 25
      Caption = 'Grafic funcziji '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -22
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 880
    Top = 0
    Width = 209
    Height = 833
    Color = 16763283
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 136
      Width = 144
      Height = 24
      Caption = 'Vyberit funcziju'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 115
      Height = 24
      Caption = 'Vvedit mezi '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 216
      Width = 207
      Height = 24
      Caption = 'Vvedit kilkist harmonik'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 368
      Width = 205
      Height = 20
      Caption = 'Vuberit stul vidobrazenna'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 24
      Top = 400
      Width = 128
      Height = 20
      Caption = ' hrafika  funkzij '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 24
      Top = 168
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 16
      Top = 88
      Width = 81
      Height = 21
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 112
      Top = 88
      Width = 81
      Height = 21
      TabOrder = 2
    end
    object ComboBox2: TComboBox
      Left = 40
      Top = 440
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 3
    end
    object BitBtn1: TBitBtn
      Left = 48
      Top = 552
      Width = 75
      Height = 25
      Caption = 'Do'
      TabOrder = 4
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 48
      Top = 648
      Width = 75
      Height = 25
      Caption = 'Clean'
      TabOrder = 5
      OnClick = BitBtn2Click
    end
    object Edit3: TEdit
      Left = 32
      Top = 264
      Width = 121
      Height = 21
      TabOrder = 6
    end
  end
end
