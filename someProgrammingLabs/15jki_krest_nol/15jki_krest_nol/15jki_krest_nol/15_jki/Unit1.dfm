object Main: TMain
  Left = 688
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tags'
  ClientHeight = 378
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020040000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000007
    77777777770777777777070000000000000000000070000000000070000000E6
    600E888EEE0E8888EEEE060770700EEE608FFFF8EE08FFFFF88E066006070EEE
    608FFFFF000000FFFF806666660700EE660EFF0EEEE6660080006666660700EE
    E60E00EEEEEE66660EEE066666070EEEE0F8E0EEEEEEE6668F88066666070EEE
    E0FF80EEEEEEEE60FFF80666660700EEE0FF80EEEEEEE6608FF8066660700000
    EE0F8E0000000000E8E066666070000000E000EE888888EE0606666007000000
    000E088FFF0F888EE06660070000000000008FFFFF0FFF88EE00070000000000
    000EFFFFFF0FFFF88EE0700000000000000FFFFFFF0FFFFF88E0700000000000
    000FFFFFFFFFFFFF88E0700000000000000FFFFFFFFFFFFFF8E0700000000000
    000FF7F7FFFFF7F7F8E0700000000000000FFFFFFFFFFFFFF8E0700000000000
    0000FFFFF0FF0FFFF80700000000000000008FFFFFFFFFFF8E07000000000000
    00000000000000000000700000000000000FEEEEEEEEEEEEEEE0700000000000
    000FED8EEED8EEED8EE0700000000000000FE8DEEE8DEEE8DEE0700000000000
    000FEEEFEEEEEEEEEEE0700000000000000FEFF0FEEEEE0EEEE0700000000000
    000FF0000FEEE0000EE07000000000000000000000FF00000000700000000000
    000000000000000000000000000000000000000000000000000000000000E002
    00BFC000009F8000000100000000000000008000000080000000000000000000
    000080000001C0000001F0000003FC00000FFE00003FFC00007FFC00007FFC00
    007FFC00007FFC00007FFC00007FFE0000FFFE0000FFFC00007FFC00007FFC00
    007FFC00007FFC00007FFC00007FFC10207FFC78787FFDFCFEFFFFFFFFFF}
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 257
    Height = 249
    OnClick = Image1Click
  end
  object Label1: TLabel
    Left = 8
    Top = 266
    Width = 81
    Height = 16
    Caption = 'Whole steps: '
  end
  object Label2: TLabel
    Left = 118
    Top = 266
    Width = 7
    Height = 16
    Caption = '0'
  end
  object Reset: TLabel
    Left = 8
    Top = 294
    Width = 36
    Height = 16
    Caption = 'Reset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = ResetClick
    OnMouseEnter = ResetMouseEnter
    OnMouseLeave = ResetMouseLeave
  end
  object ChangeLang: TLabel
    Left = 138
    Top = 294
    Width = 77
    Height = 16
    Caption = 'ChangeLang'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = ChangeLangClick
    OnMouseEnter = ChangeLangMouseEnter
    OnMouseLeave = ChangeLangMouseLeave
  end
  object Help: TLabel
    Left = 8
    Top = 323
    Width = 29
    Height = 16
    Caption = 'Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = HelpClick
    OnMouseEnter = HelpMouseEnter
    OnMouseLeave = HelpMouseLeave
  end
  object PKeyboard: TLabel
    Left = 8
    Top = 353
    Width = 68
    Height = 16
    Caption = 'PKeyboard'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = PKeyboardClick
    OnMouseEnter = PKeyboardMouseEnter
    OnMouseLeave = PKeyboardMouseLeave
  end
  object Exit: TLabel
    Left = 138
    Top = 323
    Width = 21
    Height = 16
    Caption = 'Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = ExitClick
    OnMouseEnter = ExitMouseEnter
    OnMouseLeave = ExitMouseLeave
  end
  object HeyHey: TLabel
    Left = 152
    Top = 266
    Width = 7
    Height = 16
    Caption = '0'
    Visible = False
  end
end
