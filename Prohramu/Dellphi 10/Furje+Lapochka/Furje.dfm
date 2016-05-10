object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 573
  ClientWidth = 821
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 600
    Top = -3
    Width = 217
    Height = 572
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 48
      Width = 53
      Height = 13
      Caption = 'Boundaries'
    end
    object Label2: TLabel
      Left = 24
      Top = 122
      Width = 49
      Height = 13
      Caption = 'Garmonics'
    end
    object Label3: TLabel
      Left = 24
      Top = 184
      Width = 80
      Height = 13
      Caption = 'Points of graphic'
    end
    object Label4: TLabel
      Left = 24
      Top = 253
      Width = 94
      Height = 13
      Caption = 'Experimental points'
    end
    object Edit2: TEdit
      Left = 103
      Top = 80
      Width = 50
      Height = 21
      TabOrder = 0
      Text = '10'
    end
    object Edit3: TEdit
      Left = 24
      Top = 141
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '10'
    end
    object ComboBox1: TComboBox
      Left = 24
      Top = 355
      Width = 145
      Height = 21
      TabOrder = 2
      Text = 'Choose the operation '
      Items.Strings = (
        'Grafic'
        'Garmonics'
        'The Specture')
    end
    object BitBtn1: TBitBtn
      Left = 56
      Top = 424
      Width = 75
      Height = 25
      Caption = 'Draw'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      OnClick = BitBtn1Click
    end
    object Edit1: TEdit
      Left = 24
      Top = 80
      Width = 49
      Height = 21
      TabOrder = 4
      Text = '-1'
    end
    object Edit4: TEdit
      Left = 24
      Top = 203
      Width = 121
      Height = 21
      TabOrder = 5
      Text = '450'
    end
    object Edit5: TEdit
      Left = 24
      Top = 272
      Width = 121
      Height = 21
      TabOrder = 6
      Text = '500'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = -1
    Width = 594
    Height = 570
    TabOrder = 1
    object Image1: TPaintBox
      Left = 0
      Top = 1
      Width = 594
      Height = 569
    end
  end
end
