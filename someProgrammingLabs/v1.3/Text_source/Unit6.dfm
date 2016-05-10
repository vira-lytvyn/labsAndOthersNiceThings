object Form6: TForm6
  Left = 232
  Top = 264
  BorderStyle = bsNone
  ClientHeight = 21
  ClientWidth = 688
  Color = clTeal
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  DesignSize = (
    688
    21)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 296
    Top = 0
    Width = 73
    Height = 17
    Anchors = [akTop]
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 0
    Visible = False
    OnClick = Button1Click
  end
  object TrackBar1: TTrackBar
    Left = 56
    Top = 0
    Width = 241
    Height = 25
    Max = 255
    Min = 1
    Position = 1
    TabOrder = 1
    Visible = False
    OnChange = TrackBar1Change
  end
  object PopupMenu1: TPopupMenu
    Left = 344
    object N1: TMenuItem
      Caption = #1057#1082#1088#1099#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      object N3: TMenuItem
        Caption = #1062#1074#1077#1090
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = #1055#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100
        OnClick = N4Click
      end
    end
    object N5: TMenuItem
      Caption = #1055#1086#1083#1086#1078#1077#1085#1080#1077
      OnClick = N5Click
    end
  end
  object ColorDialog1: TColorDialog
    Left = 376
  end
end
