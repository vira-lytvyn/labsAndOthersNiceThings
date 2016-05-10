object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 181
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblOptSizeX: TLabel
    Left = 8
    Top = 8
    Width = 71
    Height = 13
    Caption = #1064#1080#1088#1080#1085#1072' '#1087#1086#1083#1103':'
  end
  object lblOptSizeY: TLabel
    Left = 8
    Top = 63
    Width = 68
    Height = 13
    Caption = #1042#1099#1089#1086#1090#1072' '#1087#1086#1083#1103':'
  end
  object lblW: TLabel
    Left = 96
    Top = 8
    Width = 14
    Height = 13
    Caption = '30'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblH: TLabel
    Left = 96
    Top = 63
    Width = 14
    Height = 13
    Caption = '30'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object tbW: TTrackBar
    Left = 8
    Top = 27
    Width = 217
    Height = 30
    Max = 50
    Min = 10
    Position = 30
    TabOrder = 0
    OnChange = tbWChange
  end
  object tbH: TTrackBar
    Left = 8
    Top = 82
    Width = 217
    Height = 30
    Max = 50
    Min = 10
    Position = 30
    TabOrder = 1
    OnChange = tbHChange
  end
  object btnOk: TButton
    Left = 39
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 120
    Top = 144
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
