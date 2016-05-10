object Form2: TForm2
  Left = 404
  Top = 265
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'Form2'
  ClientHeight = 194
  ClientWidth = 258
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnMouseDown = FormMouseDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 8
    Width = 189
    Height = 45
    Caption = 'Image2Text'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -32
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label1Click
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 150
    Height = 19
    Caption = #1056#1077#1072#1083#1080#1079#1072#1094#1080#1103': Dr.Virpool'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    OnClick = Label2Click
  end
  object Label3: TLabel
    Left = 16
    Top = 80
    Width = 162
    Height = 19
    Caption = 'http://mvc2006.narod.ru'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label3Click
    OnMouseEnter = Label3MouseEnter
    OnMouseLeave = Label3MouseLeave
  end
  object Label4: TLabel
    Left = 16
    Top = 104
    Width = 227
    Height = 19
    Caption = #1048#1076#1077#1103': '#1042#1083#1072#1076#1080#1089#1083#1072#1074' [go-get] '#1060#1059#1056#1044#1040#1050
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    OnClick = Label4Click
  end
  object Label5: TLabel
    Left = 16
    Top = 128
    Width = 178
    Height = 19
    Caption = 'e-mail: SolarGS@yandex.ru'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label5Click
    OnMouseEnter = Label5MouseEnter
    OnMouseLeave = Label5MouseLeave
  end
  object Label6: TLabel
    Left = 112
    Top = 168
    Width = 36
    Height = 21
    Caption = '2006'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label6Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
  end
end
