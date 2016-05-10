object Form1: TForm1
  Left = 384
  Top = 120
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cross-zero'
  ClientHeight = 455
  ClientWidth = 385
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
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF
    FFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFF
    FFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FF8E88EFFFFFF
    FFFFF00FFFFFFFFFF00F8EFFF8EFFFFFFFFFF00FFFFFFFFFF0086FFFFF8FFFFF
    FFFFF00FFFFFFFFFF00FEFFFFFEFFFFFFFFFF00FFFFFFFFFF00FF8FFFE8FFFFF
    FFFFF00FFFFFFFFFF00FF8E8E8FFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFF
    FFFFF00FFFFFFFFFF00FFFFFFFFF000000000000000000000000000000000000
    0000000000000000000000000000FFFFFFFFF00FFFFFFFF8F00FFFFFFFFFFFFF
    FFFFF00F98FFFF89F00FFFFFFFFFFFFFFFFFF00FF97FFF98F00FFFFFFFFFFFFF
    FFFFF00FFF98F98FF00FFFFFFFFFFFFFFFFFF00FFFF998FFF00FFFFFFFFFFFFF
    FFFFF00FFFF998FFF00FFFFFFFFFFFFFFFFFF00FF798F97FF00FFFFFFFFFFFFF
    FFFFF00F798FFF97F00FFFFFFFFFFFFFFFFFF00FF8FFFFF9F00FFFFFFFFF0000
    000000000000000000000000000000000000000000000000000000000000F9FF
    FFF9800FFFFFFFFFF00FFFFFFFFFF89FFF89F00FF8E888FFF00FFFFFFFFFFFF9
    FF9FF00FFEFFFE8FF00FFFFFFFFFFFF899FFF0086FFFFF8FF00FFFFFFFFFFFF8
    99FFF0086FFFFF8FF00FFFFFFFFFFF99FF9FF00FF8FFFE8FF00FFFFFFFFFF99F
    FF89F00FF8E888FFF00FFFFFFFFFF7FFFFFF800FFFFFFFFFF00FFFFFFFFF0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 8
    Top = 48
    Width = 369
    Height = 369
    Center = True
    OnClick = Image1Click
  end
  object winTw1: TLabel
    Left = 246
    Top = 5
    Width = 11
    Height = 25
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clFuchsia
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object winOw1: TLabel
    Left = 187
    Top = 5
    Width = 11
    Height = 25
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object winXw1: TLabel
    Left = 128
    Top = 5
    Width = 11
    Height = 25
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 142
    Top = 30
    Width = 52
    Height = 16
    Caption = 'Difficulty:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Diff: TLabel
    Left = 201
    Top = 30
    Width = 44
    Height = 16
    Caption = 'Normal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Reload: TButton
    Left = 8
    Top = 8
    Width = 97
    Height = 25
    Caption = 'Renew'
    TabOrder = 0
    OnClick = ReloadClick
  end
  object Exit: TButton
    Left = 280
    Top = 8
    Width = 98
    Height = 25
    Caption = 'Exit'
    TabOrder = 1
    OnClick = ExitClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 461
    Width = 241
    Height = 188
    Caption = ' '#1048#1085#1092#1086' '
    TabOrder = 2
    Visible = False
    object winXw: TLabel
      Left = 187
      Top = 138
      Width = 11
      Height = 25
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object winOw: TLabel
      Left = 187
      Top = 79
      Width = 11
      Height = 25
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object qwer: TLabel
      Left = 10
      Top = 30
      Width = 36
      Height = 16
      Caption = 'In text:'
    end
    object qwert: TLabel
      Left = 59
      Top = 30
      Width = 49
      Height = 16
      Caption = 'x - cross'
    end
    object qwerty: TLabel
      Left = 59
      Top = 49
      Width = 43
      Height = 16
      Caption = '0 - zero'
    end
    object qwertyu: TLabel
      Left = 128
      Top = 30
      Width = 88
      Height = 16
      Caption = '"space" - none'
    end
    object a22: TLabel
      Left = 78
      Top = 143
      Width = 16
      Height = 32
      Caption = 'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object a11: TLabel
      Left = 48
      Top = 113
      Width = 16
      Height = 32
      Caption = 'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object a00: TLabel
      Left = 18
      Top = 84
      Width = 16
      Height = 32
      Caption = 'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object a10: TLabel
      Left = 48
      Top = 84
      Width = 16
      Height = 32
      Caption = 'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object a01: TLabel
      Left = 18
      Top = 113
      Width = 16
      Height = 32
      Caption = 'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object a02: TLabel
      Left = 18
      Top = 143
      Width = 16
      Height = 32
      Caption = 'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object a12: TLabel
      Left = 48
      Top = 143
      Width = 16
      Height = 32
      Caption = 'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object a21: TLabel
      Left = 78
      Top = 113
      Width = 16
      Height = 32
      Caption = 'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object a20: TLabel
      Left = 78
      Top = 84
      Width = 16
      Height = 32
      Caption = 'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 128
      Top = 148
      Width = 55
      Height = 16
      Caption = 'Victories:'
    end
    object Label5: TLabel
      Left = 128
      Top = 89
      Width = 50
      Height = 16
      Caption = 'Defeats:'
    end
    object Label6: TLabel
      Left = 128
      Top = 118
      Width = 41
      Height = 16
      Caption = 'Tie up:'
    end
    object winTw: TLabel
      Left = 187
      Top = 108
      Width = 11
      Height = 25
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clFuchsia
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 39
      Top = 89
      Width = 30
      Height = 29
    end
    object Bevel9: TBevel
      Left = 69
      Top = 148
      Width = 29
      Height = 29
    end
    object Bevel8: TBevel
      Left = 39
      Top = 148
      Width = 30
      Height = 29
    end
    object Bevel3: TBevel
      Left = 69
      Top = 89
      Width = 29
      Height = 29
    end
    object Bevel6: TBevel
      Left = 69
      Top = 118
      Width = 29
      Height = 30
    end
    object Bevel5: TBevel
      Left = 39
      Top = 118
      Width = 30
      Height = 30
    end
    object Bevel4: TBevel
      Left = 10
      Top = 118
      Width = 29
      Height = 30
    end
    object Bevel7: TBevel
      Left = 10
      Top = 148
      Width = 29
      Height = 29
    end
    object Bevel1: TBevel
      Left = 10
      Top = 89
      Width = 29
      Height = 29
    end
  end
  object Info: TButton
    Left = 16
    Top = 424
    Width = 353
    Height = 25
    Caption = 'More Info >>'
    TabOrder = 3
    OnClick = InfoClick
  end
  object GroupBox2: TGroupBox
    Left = 256
    Top = 461
    Width = 121
    Height = 188
    Caption = ' Difficulty '
    TabOrder = 4
    object RadioButton1: TRadioButton
      Left = 10
      Top = 20
      Width = 100
      Height = 21
      Caption = 'Hard'
      TabOrder = 0
      OnClick = RadioButton1Click
    end
    object RadioButton3: TRadioButton
      Left = 10
      Top = 57
      Width = 100
      Height = 21
      Caption = 'Normal'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = RadioButton3Click
    end
    object RadioButton4: TRadioButton
      Left = 10
      Top = 91
      Width = 100
      Height = 21
      Caption = 'Easy'
      TabOrder = 2
      OnClick = RadioButton4Click
    end
    object RadioButton5: TRadioButton
      Left = 10
      Top = 128
      Width = 100
      Height = 21
      Caption = 'Very easy'
      TabOrder = 3
      OnClick = RadioButton5Click
    end
  end
end
