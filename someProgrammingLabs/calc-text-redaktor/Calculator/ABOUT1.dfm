object AboutBox1: TAboutBox1
  Left = 200
  Top = 108
  BorderStyle = bsNone
  ClientHeight = 70
  ClientWidth = 225
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
    Width = 225
    Height = 70
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    OnClick = Panel1Click
    object Label1: TLabel
      Left = 19
      Top = 27
      Width = 184
      Height = 13
      Alignment = taCenter
      AutoSize = False
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1072#1082#1088#1099#1074#1072#1102#1097#1091#1102' '#1089#1082#1086#1073#1082#1091
      EllipsisPosition = epWordEllipsis
      FocusControl = Panel1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      OnClick = Label1Click
      IsControl = True
    end
  end
end
