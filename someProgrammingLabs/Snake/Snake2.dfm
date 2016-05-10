object fmStart: TfmStart
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1095#1072#1083#1086' '#1080#1075#1088#1099
  ClientHeight = 215
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 8
    Width = 92
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1080#1075#1088#1086#1082#1072':'
  end
  object Label2: TLabel
    Left = 152
    Top = 120
    Width = 104
    Height = 13
    Caption = #1059#1088#1086#1074#1077#1085#1100' '#1089#1083#1086#1078#1085#1086#1089#1090#1080':'
  end
  object Label3: TLabel
    Left = 144
    Top = 8
    Width = 69
    Height = 13
    Caption = #1053#1086#1074#1099#1081' '#1080#1075#1088#1086#1082':'
  end
  object editNew: TEdit
    Left = 140
    Top = 24
    Width = 121
    Height = 21
    MaxLength = 10
    TabOrder = 0
    OnChange = editNewChange
  end
  object listPlayer: TListBox
    Left = 8
    Top = 24
    Width = 121
    Height = 145
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
  end
  object tbarLevel: TTrackBar
    Left = 144
    Top = 140
    Width = 117
    Height = 33
    Max = 5
    Min = 1
    Position = 3
    TabOrder = 2
    TickMarks = tmTopLeft
  end
  object bbtnOK: TBitBtn
    Left = 56
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkOK
  end
  object bbtnCancel: TBitBtn
    Left = 140
    Top = 184
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    Kind = bkCancel
  end
end
