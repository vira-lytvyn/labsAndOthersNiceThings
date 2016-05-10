object fmLogin: TfmLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1082' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 105
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object laedDatabase: TLabeledEdit
    Left = 8
    Top = 24
    Width = 300
    Height = 21
    EditLabel.Width = 69
    EditLabel.Height = 13
    EditLabel.Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093':'
    TabOrder = 0
    OnChange = laedDatabaseChange
  end
  object laedUser: TLabeledEdit
    Left = 8
    Top = 72
    Width = 145
    Height = 21
    EditLabel.Width = 76
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
    TabOrder = 1
    OnChange = laedDatabaseChange
  end
  object laedPassword: TLabeledEdit
    Left = 164
    Top = 72
    Width = 145
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1072#1088#1086#1083#1100':'
    PasswordChar = '*'
    TabOrder = 2
    OnChange = laedDatabaseChange
  end
  object bbtnFind: TBitBtn
    Left = 324
    Top = 12
    Width = 120
    Height = 25
    Caption = #1053#1072#1081#1090#1080' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093
    TabOrder = 3
    OnClick = bbtnFindClick
  end
  object bbtnConnect: TBitBtn
    Left = 324
    Top = 40
    Width = 120
    Height = 25
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
    Default = True
    Enabled = False
    TabOrder = 4
    OnClick = bbtnConnectClick
  end
  object bbtnCancel: TBitBtn
    Left = 324
    Top = 68
    Width = 120
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 5
    Kind = bkCancel
  end
end
