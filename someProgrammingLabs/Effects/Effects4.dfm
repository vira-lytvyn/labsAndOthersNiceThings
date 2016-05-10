object formTransp: TformTransp
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'formTransp'
  ClientHeight = 240
  ClientWidth = 347
  Color = clBtnFace
  TransparentColor = True
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
  object imgTransp: TImage
    Left = 0
    Top = 0
    Width = 347
    Height = 240
    Align = alClient
    Stretch = True
  end
  object btnClose: TButton
    Left = 136
    Top = 60
    Width = 75
    Height = 25
    Caption = 'btnClose'
    ModalResult = 2
    TabOrder = 0
    Visible = False
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 108
    Top = 112
  end
end
