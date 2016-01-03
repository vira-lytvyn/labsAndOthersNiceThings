object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 286
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 51
    Width = 18
    Height = 13
    Caption = 'a:='
  end
  object Label2: TLabel
    Left = 40
    Top = 83
    Width = 18
    Height = 13
    Caption = 'b:='
  end
  object Label3: TLabel
    Left = 88
    Top = 184
    Width = 24
    Height = 13
    Caption = 'min='
  end
  object Label4: TLabel
    Left = 178
    Top = 184
    Width = 3
    Height = 13
  end
  object Edit1: TEdit
    Left = 88
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 88
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 88
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 2
    OnClick = Button1Click
  end
end
