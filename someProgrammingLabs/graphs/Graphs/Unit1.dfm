object Form1: TForm1
  Left = 229
  Top = 133
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Graphics'
  ClientHeight = 376
  ClientWidth = 696
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCC0
    000CCCC0000000000CCCC7777CCCCCCC0000CCCC00000000CCCC7777CCCCCCCC
    C0000CCCCCCCCCCCCCC7777CCCCC0CCCCC0000CCCCCCCCCCCC7777CCCCC700CC
    C00CCCC0000000000CCCC77CCC77000C0000CCCC00000000CCCC7777C7770000
    00000CCCC000000CCCC777777777C000C00000CCCC0000CCCC77777C777CCC00
    CC00000CCCCCCCCCC77777CC77CCCCC0CCC000CCCCC00CCCCC777CCC7CCCCCCC
    CCCC0CCCCCCCCCCCCCC7CCCCCCCCCCCC0CCCCCCCCCCCCCCCCCCCCCC7CCC70CCC
    00CCCCCCCC0CC0CCCCCCCC77CC7700CC000CCCCCC000000CCCCCC777CC7700CC
    0000CCCC00000000CCCC7777CC7700CC0000C0CCC000000CCC7C7777CC7700CC
    0000C0CCC000000CCC7C7777CC7700CC0000CCCC00000000CCCC7777CC7700CC
    000CCCCCC000000CCCCCC777CC7700CC00CCCCCCCC0CC0CCCCCCCC77CC770CCC
    0CCCCCCCCCCCCCCCCCCCCCC7CCC7CCCCCCCC0CCCCCCCCCCCCCC7CCCCCCCCCCC0
    CCC000CCCCC00CCCCC777CCC7CCCCC00CC00000CCCCCCCCCC77777CC77CCC000
    C00000CCCC0000CCCC77777C777C000000000CCCC000000CCCC777777777000C
    0000CCCC00000000CCCC7777C77700CCC00CCCC0000000000CCCC77CCC770CCC
    CC0000CCCCCCCCCCCC7777CCCCC7CCCCC0000CCCCCCCCCCCCCC7777CCCCCCCCC
    0000CCCC00000000CCCC7777CCCCCCC0000CCCC0000000000CCCC7777CCC0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 320
    Top = 8
    Width = 369
    Height = 361
    OnMouseMove = Image1MouseMove
  end
  object StartBtn: TButton
    Left = 8
    Top = 280
    Width = 97
    Height = 25
    Caption = #1056#1080#1089#1086#1074#1072#1090#1100
    TabOrder = 0
    OnClick = StartBtnClick
  end
  object ClearBtn: TButton
    Left = 112
    Top = 280
    Width = 97
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 1
    OnClick = ClearBtnClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 169
    Caption = ' '#1043#1088#1072#1092#1080#1082' '
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 28
      Width = 80
      Height = 16
      Caption = #1060#1091#1085#1082#1094#1080#1103' y ='
    end
    object Label2: TLabel
      Left = 8
      Top = 65
      Width = 28
      Height = 16
      Caption = 'X '#1086#1090
    end
    object Label3: TLabel
      Left = 92
      Top = 65
      Width = 28
      Height = 16
      Caption = 'X '#1076#1086
    end
    object Label4: TLabel
      Left = 191
      Top = 65
      Width = 29
      Height = 16
      Caption = #1064#1072#1075
    end
    object Gauge1: TGauge
      Left = 12
      Top = 104
      Width = 277
      Height = 17
      Progress = 0
    end
    object FormEd: TEdit
      Left = 96
      Top = 24
      Width = 193
      Height = 24
      MaxLength = 256
      TabOrder = 0
      Text = 'x^4-4*x^3'
    end
    object XStart: TEdit
      Left = 44
      Top = 64
      Width = 37
      Height = 24
      TabOrder = 1
      Text = '-2'
    end
    object XEnd: TEdit
      Left = 136
      Top = 63
      Width = 41
      Height = 24
      TabOrder = 2
      Text = '4,5'
    end
    object StepEd: TEdit
      Left = 232
      Top = 63
      Width = 57
      Height = 24
      TabOrder = 3
      Text = '0,01'
    end
    object LinesCh: TCheckBox
      Left = 12
      Top = 135
      Width = 181
      Height = 21
      Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077' '#1083#1080#1085#1080#1103#1084#1080
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object MashCh: TCheckBox
      Left = 207
      Top = 135
      Width = 83
      Height = 21
      Caption = #1052#1072#1089#1096#1090#1072#1073
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 200
    Width = 305
    Height = 57
    Caption = ' '#1055#1086#1083#1077' '
    TabOrder = 3
    object Label5: TLabel
      Left = 8
      Top = 27
      Width = 21
      Height = 16
      Caption = 'X = '
    end
    object Label6: TLabel
      Left = 155
      Top = 27
      Width = 22
      Height = 16
      Caption = 'Y = '
    end
    object XEd: TEdit
      Left = 32
      Top = 22
      Width = 113
      Height = 24
      TabOrder = 0
      Text = '0'
    end
    object YEd: TEdit
      Left = 184
      Top = 22
      Width = 113
      Height = 24
      TabOrder = 1
      Text = '0'
    end
  end
  object StartBtn2: TButton
    Left = 8
    Top = 312
    Width = 201
    Height = 25
    Caption = #1056#1080#1089#1086#1074#1072#1090#1100' '#1073#1077#1079' '#1087#1077#1088#1077#1089#1095#1077#1090#1077
    TabOrder = 4
    OnClick = StartBtn2Click
  end
  object OpenBtn: TButton
    Left = 216
    Top = 280
    Width = 97
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 5
    OnClick = OpenBtnClick
  end
  object SaveBtn: TButton
    Left = 216
    Top = 312
    Width = 97
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 6
    OnClick = SaveBtnClick
  end
  object AbBtn: TButton
    Left = 8
    Top = 344
    Width = 305
    Height = 25
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    TabOrder = 7
    OnClick = AbBtnClick
  end
  object OpenDialog: TOpenDialog
    Filter = #1043#1088#1072#1092#1080#1082' '#1092#1091#1085#1082#1094#1080#1080' (*.grf)|*.grf'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 324
    Top = 22
  end
  object SaveDialog: TSaveDialog
    Filter = #1043#1088#1072#1092#1080#1082' '#1092#1091#1085#1082#1094#1080#1080' (*.grf)|*.grf'
    Left = 362
    Top = 22
  end
end
