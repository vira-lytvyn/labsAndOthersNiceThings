object Form1: TForm1
  Left = 231
  Top = 148
  Width = 993
  Height = 750
  Caption = 'Form1'
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
    Width = 17
    Height = 721
    Cursor = crHSplit
  end
  object Panel1: TPanel
    Left = -8
    Top = -8
    Width = 737
    Height = 729
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 8
      Top = 0
      Width = 730
      Height = 730
    end
  end
  object Panel2: TPanel
    Left = 744
    Top = 0
    Width = 241
    Height = 721
    TabOrder = 1
    object Label1: TLabel
      Left = 40
      Top = 40
      Width = 70
      Height = 13
      Caption = 'Vuberit'#39' fractal '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 56
      Top = 176
      Width = 59
      Height = 13
      Caption = 'Vvedit'#39' mezi '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label3: TLabel
      Left = 56
      Top = 176
      Width = 141
      Height = 13
      Caption = 'Vvedit'#39'  parametru "v" ta "r",  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label4: TLabel
      Left = 56
      Top = 192
      Width = 113
      Height = 13
      Caption = 'vidpovidno do instrukzij '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label5: TLabel
      Left = 48
      Top = 368
      Width = 66
      Height = 13
      Caption = 'Vvedit'#39' ctepin'#39
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label6: TLabel
      Left = 24
      Top = 224
      Width = 10
      Height = 24
      Caption = 'x'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label7: TLabel
      Left = 24
      Top = 304
      Width = 14
      Height = 24
      Caption = 'y '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label8: TLabel
      Left = 112
      Top = 304
      Width = 35
      Height = 24
      Caption = '+ i'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Visible = False
    end
    object Label9: TLabel
      Left = 16
      Top = 304
      Width = 29
      Height = 24
      Caption = 'C ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label10: TLabel
      Left = 64
      Top = 272
      Width = 122
      Height = 13
      Caption = 'Vvedit'#39' komplexne chyslo '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object ComboBox1: TComboBox
      Left = 48
      Top = 72
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        #1060#1088#1072#1082#1090#1072#1083'  '#1052#1072#1085#1076#1077#1083#1100#1073#1088#1086#1090#1072
        #1057#1077#1088#1074#1077#1090#1082#1072' '#1057#1077#1088#1087#1110#1085#1089#1100#1082#1086#1075#1086
        #1060#1088#1072#1082#1090#1072#1083'  '#1061#1072#1088#1090#1077#1088#1072' - '#1061#1077#1081#1090#1091#1108#1103
        #1057#1085#1110#1078#1080#1085#1082#1072' '#1050#1086#1093#1072
        #1060#1088#1072#1082#1090#1072#1083' '#1046#1102#1083#1110#1072)
    end
    object BitBtn1: TBitBtn
      Left = 104
      Top = 616
      Width = 75
      Height = 25
      Caption = 'Do'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object Edit1: TEdit
      Left = 56
      Top = 224
      Width = 57
      Height = 21
      TabOrder = 2
      Visible = False
    end
    object Edit2: TEdit
      Left = 144
      Top = 224
      Width = 57
      Height = 21
      TabOrder = 3
      Visible = False
    end
    object LabeledEdit1: TLabeledEdit
      Left = 48
      Top = 440
      Width = 145
      Height = 21
      EditLabel.Width = 97
      EditLabel.Height = 13
      EditLabel.Caption = 'Vvedit'#39' kil'#39'rist'#39' iterazij '
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clBlue
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'MS Sans Serif'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 4
      Visible = False
    end
    object BitBtn2: TBitBtn
      Left = 56
      Top = 568
      Width = 75
      Height = 25
      Caption = 'Prepere'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = BitBtn2Click
    end
    object Edit3: TEdit
      Left = 56
      Top = 304
      Width = 57
      Height = 21
      TabOrder = 6
      Visible = False
    end
    object Edit4: TEdit
      Left = 144
      Top = 304
      Width = 57
      Height = 21
      TabOrder = 7
      Visible = False
    end
    object BitBtn3: TBitBtn
      Left = 152
      Top = 664
      Width = 75
      Height = 25
      Caption = 'Clear'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = BitBtn3Click
    end
    object Edit5: TEdit
      Left = 144
      Top = 360
      Width = 49
      Height = 21
      TabOrder = 9
      Visible = False
    end
  end
end