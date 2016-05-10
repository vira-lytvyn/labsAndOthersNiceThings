object Form6: TForm6
  Left = 699
  Top = 223
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1088#1077#1089#1090#1080#1082#1080'-'#1085#1086#1083#1080#1082#1080' Hot Seat'
  ClientHeight = 112
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 8
    Top = 120
    Width = 377
    Height = 377
    Center = True
    Visible = False
    OnClick = Image1Click
  end
  object Player1Label: TLabel
    Left = 8
    Top = 10
    Width = 179
    Height = 16
    Caption = 'Enter name first player (cross):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Player2Label: TLabel
    Left = 8
    Top = 59
    Width = 197
    Height = 16
    Caption = 'Enter name second player (zero):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object winOw1: TLabel
    Left = 210
    Top = 50
    Width = 11
    Height = 25
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object winXw1: TLabel
    Left = 210
    Top = 2
    Width = 11
    Height = 25
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 76
    Height = 16
    Caption = 'Playername:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label2: TLabel
    Left = 8
    Top = 59
    Width = 76
    Height = 16
    Caption = 'Playername:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 20
    Top = 108
    Width = 3
    Height = 16
  end
  object Player1Name: TEdit
    Left = 8
    Top = 32
    Width = 201
    Height = 24
    MaxLength = 10
    TabOrder = 0
  end
  object Player2Name: TEdit
    Left = 8
    Top = 80
    Width = 201
    Height = 24
    MaxLength = 10
    TabOrder = 1
  end
  object Button1: TButton
    Left = 280
    Top = 80
    Width = 105
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Exit: TButton
    Left = 280
    Top = 16
    Width = 105
    Height = 25
    Caption = 'Exit'
    TabOrder = 3
    OnClick = ExitClick
  end
  object Refresh: TButton
    Left = 280
    Top = 48
    Width = 105
    Height = 25
    Caption = 'Renew'
    TabOrder = 4
    Visible = False
    OnClick = RefreshClick
  end
end
