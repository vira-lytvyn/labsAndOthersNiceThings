object AboutBox: TAboutBox
  Left = 200
  Top = 108
  ActiveControl = Panel1
  BorderStyle = bsNone
  ClientHeight = 129
  ClientWidth = 177
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 177
    Height = 129
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 44
      Top = 3
      Width = 80
      Height = 13
      AutoSize = False
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      EllipsisPosition = epWordEllipsis
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      IsControl = True
    end
    object Label3: TLabel
      Left = 5
      Top = 41
      Width = 166
      Height = 13
      AutoSize = False
      Caption = #1072#1088#1080#1092#1084#1077#1090#1080#1095#1077#1089#1082#1080#1093' '#1091#1088#1072#1074#1085#1077#1085#1080#1081
      EllipsisPosition = epWordEllipsis
      FocusControl = Panel1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
    object Label4: TLabel
      Left = 19
      Top = 68
      Width = 134
      Height = 13
      AutoSize = False
      Caption = #1040#1074#1090#1086#1088': '#1052#1080#1083#1105#1096#1080#1085' '#1042#1072#1083#1077#1085#1090#1080#1085
      EllipsisPosition = epWordEllipsis
      FocusControl = Panel1
      IsControl = True
    end
    object Label5: TLabel
      Left = 69
      Top = 83
      Width = 32
      Height = 13
      AutoSize = False
      Caption = '2011'#1075'.'
      EllipsisPosition = epWordEllipsis
      FocusControl = Panel1
      WordWrap = True
      IsControl = True
    end
    object Label2: TLabel
      Left = 48
      Top = 28
      Width = 77
      Height = 13
      AutoSize = False
      Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088
      EllipsisPosition = epWordEllipsis
      FocusControl = Panel1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
  end
  object Button1: TButton
    Left = 67
    Top = 101
    Width = 40
    Height = 20
    Caption = #1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnClick = Button1Click
  end
end
