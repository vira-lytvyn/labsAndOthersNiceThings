object AboutForm: TAboutForm
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'О программе'
  ClientHeight = 142
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 201
    Height = 105
    Align = alTop
    Alignment = taCenter
    Lines.Strings = (
      'Прога для рисования графиков по '
      'заданной функции.'
      'Автор Кутовой Сергей Витальевич '
      'aka Voice'
      'Кидайте отзывы, предложения, '
      'замечания и заказы на мыло:'
      'i_am_voice@mail.ru')
    ReadOnly = True
    TabOrder = 0
  end
  object OKBtn: TButton
    Left = 63
    Top = 112
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = OKBtnClick
  end
end
