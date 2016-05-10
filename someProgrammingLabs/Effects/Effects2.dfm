object formBlend: TformBlend
  Left = 0
  Top = 0
  Width = 347
  Height = 240
  AlphaBlend = True
  AlphaBlendValue = 1
  Caption = 'formBlend'
  Color = clBtnFace
  TransparentColorValue = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton
    Left = 180
    Top = 36
    Width = 75
    Height = 25
    Caption = 'btnClose'
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 116
    Top = 92
  end
end
