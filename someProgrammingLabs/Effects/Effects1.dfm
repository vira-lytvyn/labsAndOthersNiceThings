object formMain: TformMain
  Left = 0
  Top = 0
  Width = 347
  Height = 240
  Caption = 'formMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnBlend: TButton
    Left = 36
    Top = 36
    Width = 75
    Height = 25
    Caption = 'btnBlend'
    TabOrder = 0
    OnClick = btnBlendClick
  end
  object btnShift: TButton
    Left = 120
    Top = 36
    Width = 75
    Height = 25
    Caption = 'btnShift'
    TabOrder = 1
    OnClick = btnShiftClick
  end
  object btnTransp: TButton
    Left = 208
    Top = 36
    Width = 75
    Height = 25
    Caption = 'btnTransp'
    TabOrder = 2
    OnClick = btnTranspClick
  end
end
