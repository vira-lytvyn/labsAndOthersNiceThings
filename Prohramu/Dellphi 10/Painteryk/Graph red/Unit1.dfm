object Form1: TForm1
  Left = 189
  Top = 105
  Width = 465
  Height = 351
  HorzScrollBar.Position = 579
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = -579
    Top = 0
    Width = 921
    Height = 707
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
  end
  object SpinEdit1: TSpinEdit
    Left = 341
    Top = 8
    Width = 97
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = SpinEdit1Change
  end
  object ColorGrid1: TColorGrid
    Left = 341
    Top = 32
    Width = 100
    Height = 100
    BackgroundIndex = 15
    TabOrder = 1
    OnChange = ColorGrid1Change
  end
  object SavePictureDialog1: TSavePictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp|All Files|*.*'
    Left = 952
    Top = 152
  end
end
