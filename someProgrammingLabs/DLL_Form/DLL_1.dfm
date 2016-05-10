object fmFahrToCels: TfmFahrToCels
  Left = 0
  Top = 0
  Caption = #1060#1072#1088#1077#1085#1075#1077#1081#1090' - '#1062#1077#1083#1100#1089#1080#1081
  ClientHeight = 113
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object laedFahr: TLabeledEdit
    Left = 172
    Top = 8
    Width = 121
    Height = 21
    EditLabel.Width = 162
    EditLabel.Height = 13
    EditLabel.Caption = #1043#1088#1072#1076#1091#1089#1099' '#1087#1086' '#1096#1082#1072#1083#1077' '#1060#1072#1088#1077#1085#1075#1077#1081#1090#1072':'
    LabelPosition = lpLeft
    TabOrder = 0
    OnChange = laedFahrChange
  end
  object laedCels: TLabeledEdit
    Left = 172
    Top = 40
    Width = 121
    Height = 21
    Color = clScrollBar
    EditLabel.Width = 144
    EditLabel.Height = 13
    EditLabel.Caption = #1043#1088#1072#1076#1091#1089#1099' '#1087#1086' '#1096#1082#1072#1083#1077' '#1062#1077#1083#1100#1089#1080#1103':'
    LabelPosition = lpLeft
    ReadOnly = True
    TabOrder = 1
  end
  object bbtnClose: TBitBtn
    Left = 100
    Top = 80
    Width = 101
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    Kind = bkClose
  end
end
