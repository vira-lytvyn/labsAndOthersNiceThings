object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 375
  ClientWidth = 510
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
    Left = 24
    Top = 51
    Width = 14
    Height = 13
    Caption = 'a='
  end
  object Label2: TLabel
    Left = 24
    Top = 91
    Width = 14
    Height = 13
    Caption = 'b='
  end
  object Label3: TLabel
    Left = 24
    Top = 136
    Width = 25
    Height = 13
    Caption = 'eps='
  end
  object Label4: TLabel
    Left = 72
    Top = 240
    Width = 24
    Height = 13
    Caption = 'min='
  end
  object Label5: TLabel
    Left = 102
    Top = 240
    Width = 3
    Height = 13
  end
  object Edit1: TEdit
    Left = 72
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 72
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 72
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 72
    Top = 176
    Width = 121
    Height = 25
    Caption = 'start'
    TabOrder = 3
    OnClick = Button1Click
  end
end
