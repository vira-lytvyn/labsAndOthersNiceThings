object Form1: TForm1
  Left = 246
  Top = 173
  Width = 702
  Height = 514
  Caption = 'OpenGL demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 694
    Height = 33
    Align = alTop
    Caption = 
      'RTS Engine by Georgy Moshkin (http://www.tmtlib.narod.ru) --- Sp' +
      'rites by Dima (http://www.varyag.h12.ru/)'
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 209
    Height = 447
    Align = alLeft
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 193
      Height = 25
      Caption = '1. '#1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1072#1085#1085#1099#1077'.'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 40
      Width = 193
      Height = 25
      Caption = '2. '#1057#1086#1079#1076#1072#1090#1100' '#1090#1077#1089#1090#1086#1074#1099#1081' '#1091#1088#1086#1074#1077#1085#1100'.'
      TabOrder = 1
      OnClick = Button2Click
    end
    object PageControl1: TPageControl
      Left = 8
      Top = 352
      Width = 193
      Height = 89
      ActivePage = TabSheet2
      TabIndex = 0
      TabOrder = 2
      object TabSheet2: TTabSheet
        Caption = #1040#1090#1072#1082#1072
        ImageIndex = 1
        object ComboBox1: TComboBox
          Left = 24
          Top = 8
          Width = 145
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = #1058#1080#1087' '#1072#1090#1072#1082#1080
        end
      end
      object TabSheet3: TTabSheet
        Caption = #1057#1090#1088#1086#1080#1090#1100
        ImageIndex = 2
        object ComboBox2: TComboBox
          Left = 24
          Top = 8
          Width = 145
          Height = 21
          ItemHeight = 0
          TabOrder = 0
          Text = #1058#1080#1087' '#1086#1073#1098#1077#1082#1090#1072
        end
        object Button3: TButton
          Left = 48
          Top = 32
          Width = 75
          Height = 25
          Caption = #1056#1077#1084#1086#1085#1090
          TabOrder = 1
        end
      end
      object TabSheet4: TTabSheet
        Caption = #1040#1087#1075#1088#1077#1081#1076
        ImageIndex = 3
        object ComboBox3: TComboBox
          Left = 24
          Top = 8
          Width = 145
          Height = 21
          ItemHeight = 0
          TabOrder = 0
          Text = #1058#1080#1087' '#1072#1087#1075#1088#1077#1081#1076#1072
        end
      end
    end
    object ListBox1: TListBox
      Left = 8
      Top = 80
      Width = 193
      Height = 233
      ItemHeight = 13
      TabOrder = 3
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 328
      Width = 73
      Height = 17
      Caption = #1055#1086#1083#1086#1089#1082#1080
      TabOrder = 4
    end
    object CheckBox2: TCheckBox
      Left = 80
      Top = 328
      Width = 97
      Height = 17
      Caption = #1050#1072#1088#1090#1072
      TabOrder = 5
    end
  end
  object Panel3: TPanel
    Left = 209
    Top = 33
    Width = 485
    Height = 447
    Align = alClient
    Color = clBlack
    FullRepaint = False
    TabOrder = 2
    OnMouseDown = MyMouseDown
    OnMouseMove = MyMouseCursor
  end
  object Timer1: TTimer
    Interval = 10
    OnTimer = TimerDraw
    Left = 8
  end
end
