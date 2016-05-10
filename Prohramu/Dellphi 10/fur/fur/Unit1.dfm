object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1056#1086#1079#1082#1083#1072#1076' '#1087#1077#1088#1110#1086#1076#1080#1095#1085#1080#1093' '#1092#1091#1085#1082#1094#1110#1081' '#1091' '#1088#1103#1076'  '#1060#1091#1088#39' '#1108
  ClientHeight = 602
  ClientWidth = 895
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = 20
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 899
    Height = 500
  end
  object Panel1: TPanel
    Left = -8
    Top = 494
    Width = 913
    Height = 110
    Color = clHighlight
    ParentBackground = False
    TabOrder = 0
    object Label3: TLabel
      Left = 424
      Top = 60
      Width = 41
      Height = 25
      Caption = 'Ng='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 25
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 75
      Width = 28
      Height = 25
      Caption = 'B='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 25
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 16
      Top = 44
      Width = 28
      Height = 25
      Caption = 'A='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 25
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 4
      Width = 65
      Height = 30
      Caption = #1052#1077#1078#1110':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 30
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 424
      Top = 12
      Width = 219
      Height = 30
      Caption = #1050#1110#1083#1100#1082#1110#1089#1090#1100' '#1075#1072#1088#1084#1086#1085#1110#1082':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 30
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 50
      Top = 40
      Width = 65
      Height = 28
      TabOrder = 0
      Text = '-10'
    end
    object Edit3: TEdit
      Left = 471
      Top = 64
      Width = 65
      Height = 28
      TabOrder = 1
      Text = '10'
    end
    object Edit2: TEdit
      Left = 50
      Top = 74
      Width = 65
      Height = 28
      TabOrder = 2
      Text = '20'
    end
    object Button2: TButton
      Left = 728
      Top = 68
      Width = 161
      Height = 35
      Caption = #1042#1080#1093#1110#1076
      Font.Charset = GREEK_CHARSET
      Font.Color = clInfoText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 728
      Top = 12
      Width = 161
      Height = 37
      Caption = #1056#1086#1079#1082#1083#1072#1089#1090#1080' '#1092#1091#1085#1082#1094#1110#1102
      Font.Charset = GREEK_CHARSET
      Font.Color = clDefault
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = Button1Click
    end
    object RadioGroup1: TRadioGroup
      Left = 159
      Top = 12
      Width = 228
      Height = 86
      Caption = #1042#1080#1073#1077#1088#1110#1090#1100' '#1089#1087#1086#1089#1110#1073' '#1087#1086#1073#1091#1076#1086#1074#1080':'
      Color = clMoneyGreen
      Ctl3D = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMoneyGreen
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      Items.Strings = (
        #1056#1103#1076' '#1060#1091#1088#1108
        #1047#1072#1083#1077#1078#1085#1110#1089#1090#1100' C '#1074#1110#1076'  W')
      ParentBackground = False
      ParentColor = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
    end
  end
end
