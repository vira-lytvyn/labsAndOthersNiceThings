object Form1: TForm1
  Left = 236
  Top = 131
  Width = 785
  Height = 540
  Caption = #1060#1088#1072#1082#1090#1072#1083#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCC0
    000CCCC0000000000CCCC7777CCCCCCC0000CCCC00000000CCCC7777CCCCCCCC
    C0000CCCCCCCCCCCCCC7777CCCCC0CCCCC0000CCCCCCCCCCCC7777CCCCC700CC
    C00CCCC0000000000CCCC77CCC77000C0000CCCC00000000CCCC7777C7770000
    00000CCCC000000CCCC777777777C000C00000CCCC0000CCCC77777C777CCC00
    CC00000CCCCCCCCCC77777CC77CCCCC0CCC000CCCCC00CCCCC777CCC7CCCCCCC
    CCCC0CCCCCCCCCCCCCC7CCCCCCCCCCCC0CCCCCCCCCCCCCCCCCCCCCC7CCC70CCC
    00CCCCCCCC0CC0CCCCCCCC77CC7700CC000CCCCCC000000CCCCCC777CC7700CC
    0000CCCC00000000CCCC7777CC7700CC0000C0CCC000000CCC7C7777CC7700CC
    0000C0CCC000000CCC7C7777CC7700CC0000CCCC00000000CCCC7777CC7700CC
    000CCCCCC000000CCCCCC777CC7700CC00CCCCCCCC0CC0CCCCCCCC77CC770CCC
    0CCCCCCCCCCCCCCCCCCCCCC7CCC7CCCCCCCC0CCCCCCCCCCCCCC7CCCCCCCCCCC0
    CCC000CCCCC00CCCCC777CCC7CCCCC00CC00000CCCCCCCCCC77777CC77CCC000
    C00000CCCC0000CCCC77777C777C000000000CCCC000000CCCC777777777000C
    0000CCCC00000000CCCC7777C77700CCC00CCCC0000000000CCCC77CCC770CCC
    CC0000CCCCCCCCCCCC7777CCCCC7CCCCC0000CCCCCCCCCCCCCC7777CCCCCCCCC
    0000CCCC00000000CCCC7777CCCCCCC0000CCCC0000000000CCCC7777CCC0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 777
    Height = 513
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '[ '#1058#1088#1077#1091#1075#1086#1083#1100#1085#1080#1082' '#1057#1077#1088#1087#1080#1085#1089#1082#1086#1075#1086' ]'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 129
        Height = 482
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object SpeedButton1: TSpeedButton
          Left = 8
          Top = 77
          Width = 113
          Height = 27
          Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100
          OnClick = SpeedButton1Click
        end
        object Label4: TLabel
          Left = 10
          Top = 20
          Width = 25
          Height = 16
          Caption = 'Age'
        end
        object SpinEdit1: TSpinEdit
          Left = 8
          Top = 39
          Width = 113
          Height = 26
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 1
          OnChange = SpeedButton1Click
        end
      end
      object Panel2: TPanel
        Left = 129
        Top = 0
        Width = 640
        Height = 482
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 1
        object Image1: TPaintBox
          Left = 1
          Top = 1
          Width = 638
          Height = 480
          Align = alClient
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '[ '#1044#1077#1088#1077#1074#1086' ]'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 129
        Top = 0
        Width = 640
        Height = 482
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object Image2: TPaintBox
          Left = 1
          Top = 1
          Width = 638
          Height = 480
          Align = alClient
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 129
        Height = 482
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object SpeedButton2: TSpeedButton
          Left = 8
          Top = 75
          Width = 113
          Height = 27
          Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100
          OnClick = SpeedButton2Click
        end
        object Label1: TLabel
          Left = 10
          Top = 116
          Width = 56
          Height = 16
          Caption = 'LeftAngle'
        end
        object Label2: TLabel
          Left = 10
          Top = 174
          Width = 66
          Height = 16
          Caption = 'RightAngle'
        end
        object Label3: TLabel
          Left = 10
          Top = 20
          Width = 25
          Height = 16
          Caption = 'Age'
        end
        object Label5: TLabel
          Left = 12
          Top = 231
          Width = 30
          Height = 16
          Caption = 'RND'
        end
        object Label13: TLabel
          Left = 10
          Top = 290
          Width = 39
          Height = 16
          Caption = 'Height'
        end
        object SpinEdit2: TSpinEdit
          Left = 8
          Top = 39
          Width = 113
          Height = 26
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 1
          OnChange = SpeedButton2Click
        end
        object SpinEdit3: TSpinEdit
          Left = 8
          Top = 136
          Width = 113
          Height = 26
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 25
        end
        object SpinEdit4: TSpinEdit
          Left = 8
          Top = 193
          Width = 113
          Height = 26
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 25
        end
        object SpinEdit5: TSpinEdit
          Left = 8
          Top = 250
          Width = 113
          Height = 26
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object SpinEdit7: TSpinEdit
          Left = 8
          Top = 310
          Width = 113
          Height = 26
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 120
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = '[ '#1044#1088#1072#1082#1086#1085#1086#1074#1072' '#1083#1086#1084#1072#1085#1072#1103' ]'
      ImageIndex = 2
      object Panel6: TPanel
        Left = 129
        Top = 0
        Width = 640
        Height = 482
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object Image3: TPaintBox
          Left = 1
          Top = 1
          Width = 638
          Height = 480
          Align = alClient
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 129
        Height = 482
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object SpeedButton3: TSpeedButton
          Left = 8
          Top = 75
          Width = 113
          Height = 27
          Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100
          OnClick = SpeedButton3Click
        end
        object Label8: TLabel
          Left = 10
          Top = 20
          Width = 25
          Height = 16
          Caption = 'Age'
        end
        object SpinEdit6: TSpinEdit
          Left = 8
          Top = 39
          Width = 113
          Height = 26
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 1
          OnChange = SpeedButton3Click
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1054' '#1055#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 3
      object Label6: TLabel
        Left = 10
        Top = 20
        Width = 175
        Height = 16
        Caption = '(c) '#1044#1084#1080#1090#1088#1080#1081' '#1041#1086#1088#1097#1072#1085#1077#1085#1082#1086'  '
      end
      object Label7: TLabel
        Left = 10
        Top = 39
        Width = 110
        Height = 16
        Caption = #1050#1053#1059#1041#1040' / '#1048#1059#1057#1058'-22'
      end
      object Label9: TLabel
        Left = 10
        Top = 59
        Width = 223
        Height = 16
        Caption = '"'#1047#1072#1088#1080#1089#1086#1074#1082#1080' '#1085#1072' '#1090#1077#1084#1091' "'#1060#1088#1072#1082#1090#1072#1083#1099'""'
      end
      object Label10: TLabel
        Left = 9
        Top = 87
        Width = 299
        Height = 36
        Caption = 'www.Gusto.x.kiev.ua'
        Color = clBtnFace
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -30
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentColor = False
        ParentFont = False
      end
    end
  end
end
