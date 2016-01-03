object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 376
  ClientWidth = 591
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
    Left = 72
    Top = 40
    Width = 14
    Height = 13
    Caption = 'h='
  end
  object Label2: TLabel
    Left = 72
    Top = 88
    Width = 14
    Height = 13
    Caption = 'e='
  end
  object Label3: TLabel
    Left = 72
    Top = 128
    Width = 20
    Height = 13
    Caption = 'x0='
  end
  object Label4: TLabel
    Left = 72
    Top = 176
    Width = 25
    Height = 13
    Caption = 'eps='
  end
  object Edit1: TEdit
    Left = 120
    Top = 37
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 120
    Top = 85
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 120
    Top = 125
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Edit4: TEdit
    Left = 120
    Top = 173
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object Button1: TButton
    Left = 120
    Top = 216
    Width = 121
    Height = 25
    Caption = 'Start'
    TabOrder = 4
    OnClick = Button1Click
  end
end
