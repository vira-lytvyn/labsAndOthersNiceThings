object Form1: TForm1
  Left = 244
  Top = 138
  Width = 831
  Height = 608
  Caption = #1062#1080#1092#1088#1086#1074#1072' '#1086#1073#1088#1086#1073#1082#1072' '#1079#1086#1073#1088#1072#1078#1077#1085#1100' ('#1085#1072#1074#1095#1072#1083#1100#1085#1072')'
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  DesignSize = (
    815
    550)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 351
    Width = 241
    Height = 13
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Visible = False
  end
  object Image3: TImage
    Left = 0
    Top = 288
    Width = 256
    Height = 256
  end
  object Image2: TImage
    Left = 320
    Top = 0
    Width = 256
    Height = 256
  end
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 256
    Height = 256
  end
  object Image4: TImage
    Left = 320
    Top = 288
    Width = 256
    Height = 256
  end
  object Label2: TLabel
    Left = 405
    Top = 351
    Width = 100
    Height = 13
    Anchors = []
    Caption = #1053#1072#1090#1080#1089#1085#1110#1090#1100' Enter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Visible = False
  end
  object Edit1: TEdit
    Left = 256
    Top = 264
    Width = 49
    Height = 21
    TabOrder = 0
    Text = '2'
    Visible = False
    OnKeyDown = Edit1KeyDown
  end
  object Chart1: TChart
    Left = 320
    Top = 288
    Width = 256
    Height = 256
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      #1043#1110#1089#1090#1086#1075#1088#1072#1084#1072)
    Legend.Visible = False
    View3D = False
    TabOrder = 1
    Visible = False
    object Series1: TBarSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object MainMenu1: TMainMenu
    Left = 280
    object N1: TMenuItem
      Caption = #1047#1086#1073#1088#1072#1078#1077#1085#1085#1103
      object N3: TMenuItem
        Caption = #1042#1074#1077#1089#1090#1080
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = #1057#1090#1074#1086#1088#1080#1090#1080
        object N32: TMenuItem
          Caption = #1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1072' '#1083#1110#1085#1110#1103
          OnClick = N32Click
        end
        object N7: TMenuItem
          Caption = #1044#1110#1072#1075#1086#1085#1072#1083#1100#1085#1072' '#1083#1110#1085#1110#1103
          OnClick = N7Click
        end
        object N26: TMenuItem
          Caption = #1050#1086#1083#1086
          OnClick = N26Click
        end
        object N31: TMenuItem
          Caption = #1056#1086#1084#1073
          OnClick = N31Click
        end
      end
      object N11: TMenuItem
        Caption = #1047#1072#1087#1080#1089#1072#1090#1080
        OnClick = N11Click
      end
      object N20: TMenuItem
        Caption = #1054#1073#1084#1110#1085
        OnClick = N20Click
      end
    end
    object N2: TMenuItem
      Caption = #1055#1088#1086#1089#1090#1086#1088#1086#1074#1072' '#1086#1073#1088#1086#1073#1082#1072
      object N12: TMenuItem
        Caption = #1050#1074#1072#1085#1090#1091#1074#1072#1090#1080
        OnClick = N12Click
      end
      object N5: TMenuItem
        Caption = #1044#1080#1089#1082#1088#1077#1090#1080#1079#1091#1074#1072#1090#1080
        OnClick = N5Click
      end
      object N8: TMenuItem
        Caption = #1042#1080#1074#1110#1076' '#1075#1110#1089#1090#1086#1075#1088#1072#1084#1080
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = #1042#1080#1088#1110#1074#1085#1102#1074#1072#1085#1085#1103' '#1075#1110#1089#1090#1086#1075#1088#1072#1084#1080
        OnClick = N9Click
      end
      object N10: TMenuItem
        Caption = #1057#1090#1080#1089#1082' '#1075#1110#1089#1090#1086#1075#1088#1072#1084#1080
        OnClick = N10Click
      end
      object N14: TMenuItem
        Caption = #1047#1072#1096#1091#1084#1083#1077#1085#1085#1103
        object N15: TMenuItem
          Caption = #1041#1110#1083#1080#1081' '#1096#1091#1084
          OnClick = N15Click
        end
        object N19: TMenuItem
          Caption = #1057#1110#1083#1100' '#1110' '#1087#1077#1088#1077#1094#1100
          OnClick = N19Click
        end
      end
      object N21: TMenuItem
        Caption = #1055#1086#1074#1086#1088#1086#1090' '#1079#1086#1073#1088#1072#1078#1077#1085#1085#1103
        object N901: TMenuItem
          Caption = #1053#1072' 90 '#1075#1088#1072#1076#1091#1089#1110#1074
          OnClick = N901Click
        end
        object N1801: TMenuItem
          Caption = #1053#1072' 180 '#1075#1088#1072#1076#1091#1089#1110#1074
          OnClick = N1801Click
        end
        object N22: TMenuItem
          Caption = #1053#1072' '#1079#1072#1076#1072#1085#1080#1081' '#1082#1091#1090
          OnClick = N22Click
        end
      end
      object N23: TMenuItem
        Caption = #1052#1072#1089#1096#1090#1072#1073#1091#1074#1072#1085#1085#1103
        OnClick = N23Click
        object N24: TMenuItem
          Caption = #1047#1073#1110#1083#1100#1096#1080#1090#1080
          OnClick = N24Click
        end
        object N25: TMenuItem
          Caption = #1047#1084#1077#1085#1096#1080#1090#1080
          OnClick = N25Click
        end
      end
      object N27: TMenuItem
        Caption = #1058#1086#1095#1082#1086#1074#1077' '#1087#1077#1088#1077#1090#1074#1086#1088#1077#1085#1085#1103
        object N28: TMenuItem
          Caption = #1053#1077#1075#1072#1090#1080#1074
          OnClick = N28Click
        end
        object N30: TMenuItem
          Caption = #1043#1072#1084#1084#1072'-'#1087#1077#1088#1077#1090#1074#1086#1088#1077#1085#1085#1103
          OnClick = N30Click
        end
        object N29: TMenuItem
          Caption = #1030#1085#1096#1077' '#1087#1077#1088#1077#1090#1074#1086#1088#1077#1085#1085#1103
          OnClick = N29Click
        end
      end
    end
    object N13: TMenuItem
      Caption = #1063#1072#1089#1090#1086#1090#1085#1072' '#1086#1073#1088#1086#1073#1082#1072
      object N6: TMenuItem
        Caption = #1055#1088#1103#1084#1077' '#1064#1055#1060
        OnClick = N6Click
      end
      object N16: TMenuItem
        Caption = #1030#1076#1077#1072#1083#1100#1085#1080#1081' '#1060#1053#1063
        OnClick = N16Click
      end
      object N17: TMenuItem
        Caption = #1054#1073#1077#1088#1085#1077#1085#1077' '#1064#1055#1060
        OnClick = N17Click
      end
      object N18: TMenuItem
        Caption = #1030#1076#1077#1072#1083#1100#1085#1080#1081' '#1060#1042#1063
        OnClick = N18Click
      end
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 280
    Top = 80
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 280
    Top = 128
  end
end
