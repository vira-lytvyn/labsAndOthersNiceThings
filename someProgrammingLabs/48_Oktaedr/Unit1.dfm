object Form1: TForm1
  Left = 195
  Top = 120
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 260
  ClientWidth = 327
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnMouseWheelDown = FormMouseWheelDown
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 241
    Height = 209
    Cursor = crArrow
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
  end
end
