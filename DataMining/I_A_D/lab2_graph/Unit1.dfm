object Form1: TForm1
  Left = 188
  Top = 140
  Width = 985
  Height = 812
  Caption = 
    #1043#1088#1072#1092#1110#1082' '#1079#1072#1083#1077#1078#1085#1086#1089#1090#1110' '#1082#1110#1083#1100#1082#1086#1089#1090#1110' '#1077#1087#1086#1093' '#1085#1072#1074#1095#1072#1085#1085#1103' '#1074#1110#1076' '#1079#1085#1072#1095#1077#1085#1085#1103' '#1082#1086#1077#1092#1110#1094#1110#1108#1085 +
    #1090#1072' '#1082#1088#1091#1090#1080#1079#1085#1080' '#1092#1091#1085#1082#1094#1110#1111' '#1072#1082#1090#1080#1074#1072#1094#1110#1111
  Color = clLime
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
    Top = 100
    Width = 977
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 977
    Height = 100
    Align = alTop
    Color = clMoneyGreen
    TabOrder = 0
    object Label1: TLabel
      Left = 576
      Top = 24
      Width = 14
      Height = 13
      Caption = 'w1'
    end
    object Label3: TLabel
      Left = 680
      Top = 24
      Width = 14
      Height = 13
      Caption = 'w2'
    end
    object Label5: TLabel
      Left = 784
      Top = 24
      Width = 14
      Height = 13
      Caption = 'w3'
    end
    object Label2: TLabel
      Left = 24
      Top = 24
      Width = 56
      Height = 13
      Caption = 'Zadajte eps'
    end
    object Label4: TLabel
      Left = 128
      Top = 24
      Width = 65
      Height = 13
      Caption = 'Zadajte alpha'
    end
    object Label6: TLabel
      Left = 240
      Top = 24
      Width = 54
      Height = 13
      Caption = 'Zadajte eta'
    end
    object Label7: TLabel
      Left = 336
      Top = 24
      Width = 90
      Height = 13
      Caption = 'Zadajte n (parne!!!)'
    end
    object Label8: TLabel
      Left = 864
      Top = 24
      Width = 103
      Height = 13
      Caption = #1050'-'#1089#1090#1100' '#1077#1087#1086#1093' '#1085#1072#1074#1095#1072#1085#1085#1103
    end
    object Button1: TButton
      Left = 448
      Top = 64
      Width = 75
      Height = 25
      Caption = 'REZULT'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit4: TEdit
      Left = 544
      Top = 48
      Width = 81
      Height = 21
      TabOrder = 1
    end
    object Edit5: TEdit
      Left = 648
      Top = 48
      Width = 81
      Height = 21
      TabOrder = 2
    end
    object Edit6: TEdit
      Left = 760
      Top = 48
      Width = 81
      Height = 21
      TabOrder = 3
    end
    object Edit1: TEdit
      Left = 128
      Top = 48
      Width = 65
      Height = 21
      TabOrder = 4
      Text = '1'
    end
    object Edit2: TEdit
      Left = 24
      Top = 48
      Width = 57
      Height = 21
      TabOrder = 5
      Text = '0.05'
    end
    object Edit3: TEdit
      Left = 240
      Top = 48
      Width = 65
      Height = 21
      TabOrder = 6
      Text = '0.7'
    end
    object Edit7: TEdit
      Left = 344
      Top = 48
      Width = 65
      Height = 21
      TabOrder = 7
      Text = '200'
    end
    object Edit8: TEdit
      Left = 888
      Top = 48
      Width = 65
      Height = 21
      TabOrder = 8
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 103
    Width = 977
    Height = 675
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 1
    object Chart1: TChart
      Left = 1
      Top = 1
      Width = 975
      Height = 673
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Text.Strings = (
        'TChart')
      Legend.Visible = False
      View3D = False
      Align = alClient
      Color = clWhite
      TabOrder = 0
      object Series1: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Dark3D = False
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series2: TPointSeries
        Marks.ArrowLength = 0
        Marks.Visible = False
        SeriesColor = clGreen
        Pointer.HorizSize = 3
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.VertSize = 3
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series3: TPointSeries
        Marks.ArrowLength = 0
        Marks.Visible = False
        SeriesColor = clYellow
        Pointer.HorizSize = 3
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.VertSize = 3
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
    end
  end
end
