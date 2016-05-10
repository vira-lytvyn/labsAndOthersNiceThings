object Form1: TForm1
  Left = 256
  Top = 49
  Caption = 'Form1'
  ClientHeight = 617
  ClientWidth = 858
  Color = clBtnFace
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
    Width = 6
    Height = 617
    ExplicitHeight = 635
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 617
    TabOrder = 0
    object Image1: TPaintBox
      Left = 0
      Top = 0
      Width = 633
      Height = 617
    end
  end
  object Panel2: TPanel
    Left = 640
    Top = 0
    Width = 217
    Height = 617
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 27
      Height = 13
      Caption = 'Mezji '
    end
    object Label2: TLabel
      Left = 24
      Top = 192
      Width = 42
      Height = 13
      Caption = 'Funkziya'
    end
    object Label3: TLabel
      Left = 24
      Top = 376
      Width = 57
      Height = 13
      Caption = 'Dvi  funcziji '
    end
    object Label4: TLabel
      Left = 31
      Top = 94
      Width = 23
      Height = 13
      Caption = 'Style'
    end
    object Edit1: TEdit
      Left = 8
      Top = 56
      Width = 89
      Height = 21
      TabOrder = 0
      Text = '-10'
    end
    object Edit2: TEdit
      Left = 112
      Top = 56
      Width = 89
      Height = 21
      TabOrder = 1
      Text = '10'
    end
    object ComboBox1: TComboBox
      Left = 24
      Top = 232
      Width = 145
      Height = 21
      TabOrder = 2
      Items.Strings = (
        'y = sin(x)'
        'y = cos(x)'
        'y = x*sin(x)')
    end
    object BitBtn1: TBitBtn
      Left = 32
      Top = 480
      Width = 121
      Height = 33
      Caption = 'Draw'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      OnClick = BitBtn1Click
    end
    object ComboBox2: TComboBox
      Left = 24
      Top = 424
      Width = 145
      Height = 21
      TabOrder = 4
      Items.Strings = (
        'y = x*sin(x)  '#1090#1072'  y = x*cos(x)'
        'y = sin(x) '#1090#1072' y = cos(x)'
        'y = sin(x) '#1090#1072' y = x*cos(x)')
    end
    object ComboBox3: TComboBox
      Left = 28
      Top = 126
      Width = 145
      Height = 21
      TabOrder = 5
      Items.Strings = (
        'lines'
        '.........'
        '******')
    end
    object BitBtn2: TBitBtn
      Left = 32
      Top = 297
      Width = 121
      Height = 32
      Caption = 'Draw'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 6
      OnClick = BitBtn2Click
    end
  end
  object XPManifest1: TXPManifest
    Left = 816
  end
end
