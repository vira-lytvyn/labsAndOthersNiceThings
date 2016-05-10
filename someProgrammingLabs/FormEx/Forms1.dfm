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
  object btnPassword: TButton
    Left = 20
    Top = 16
    Width = 75
    Height = 25
    Caption = 'btnPassword'
    TabOrder = 0
    OnClick = btnPasswordClick
  end
  object btnNewForm: TButton
    Left = 104
    Top = 16
    Width = 75
    Height = 25
    Caption = 'btnNewForm'
    TabOrder = 1
    OnClick = btnNewFormClick
  end
  object btnMsg: TButton
    Left = 188
    Top = 16
    Width = 75
    Height = 25
    Caption = 'btnMsg'
    TabOrder = 2
    OnClick = btnMsgClick
  end
  object Edit1: TEdit
    Left = 20
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 20
    Top = 84
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit2'
  end
end
