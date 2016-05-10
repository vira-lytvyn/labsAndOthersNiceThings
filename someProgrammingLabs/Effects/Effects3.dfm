object formShift: TformShift
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'formShift'
  ClientHeight = 240
  ClientWidth = 322
  Color = clBtnFace
  TransparentColorValue = clMaroon
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 322
    Height = 240
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 0
    object btnClose: TButton
      Left = 96
      Top = 116
      Width = 75
      Height = 25
      Caption = 'btnClose'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 216
    Top = 136
  end
end
