object Form1: TForm1
  Left = 452
  Top = 137
  Width = 812
  Height = 788
  Caption = 
    #1040#1087#1088#1086#1082#1089#1080#1084#1072#1094#1110#1103' '#1084#1077#1090#1086#1076#1086#1084' '#1085#1072#1081#1084#1077#1085#1096#1080#1093' '#1082#1074#1072#1076#1088#1072#1090#1110#1074' ('#1087#1088#1086#1075#1088#1072#1084#1091' '#1085#1072#1087#1080#1089#1072#1074' '#1043#1086#1088#1110#1085 +
    ' '#1054#1083#1077#1075' '#1030#1075#1086#1088#1086#1074#1080#1095', '#1075#1088#1091#1087#1072' '#1060#1045#1030'-12)'
  Color = clBtnFace
  Constraints.MaxHeight = 788
  Constraints.MaxWidth = 812
  Constraints.MinHeight = 788
  Constraints.MinWidth = 812
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 761
    Height = 513
  end
  object Label1: TLabel
    Left = 360
    Top = 608
    Width = 95
    Height = 15
    Caption = #1042#1074#1077#1076#1110#1090#1100' Ne (3~10)'
  end
  object Label2: TLabel
    Left = 360
    Top = 640
    Width = 137
    Height = 15
    Caption = #1042#1074#1077#1076#1110#1090#1100' '#1089#1090#1077#1087#1110#1085#1100' '#1087#1086#1083#1110#1085#1086#1084#1072
  end
  object Label3: TLabel
    Left = 360
    Top = 672
    Width = 121
    Height = 15
    Caption = #1042#1074#1077#1076#1110#1090#1100' Ngr (100~300)'
  end
  object Label4: TLabel
    Left = 672
    Top = 656
    Width = 65
    Height = 15
    Caption = #1055#1088#1072#1074#1072' '#1084#1077#1078#1072
  end
  object Label5: TLabel
    Left = 544
    Top = 656
    Width = 55
    Height = 15
    Caption = #1051#1110#1074#1072' '#1084#1077#1078#1072
  end
  object Label6: TLabel
    Left = 593
    Top = 696
    Width = 66
    Height = 15
    Caption = #1053#1080#1078#1085#1103' '#1084#1077#1078#1072
  end
  object Label7: TLabel
    Left = 592
    Top = 616
    Width = 69
    Height = 15
    Caption = #1042#1077#1088#1093#1085#1103' '#1084#1077#1078#1072
  end
  object Label8: TLabel
    Left = 464
    Top = 528
    Width = 219
    Height = 15
    Caption = #1050#1086#1077#1092#1110#1094#1110#1108#1085#1090#1080' '#1072#1087#1088#1086#1082#1089#1080#1084#1091#1102#1095#1086#1075#1086' '#1087#1086#1083#1110#1085#1086#1084#1072
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 544
    Width = 345
    Height = 81
    ColCount = 11
    DefaultColWidth = 30
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 632
    Width = 345
    Height = 113
    Caption = 'Start!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MV Boli'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 499
    Top = 620
    Width = 17
    Height = 17
    Enabled = False
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 371
    Top = 620
    Width = 121
    Height = 23
    TabOrder = 3
    Text = '5'
  end
  object Edit2: TEdit
    Left = 371
    Top = 652
    Width = 121
    Height = 23
    TabOrder = 4
    Text = '3'
  end
  object Edit3: TEdit
    Left = 371
    Top = 684
    Width = 121
    Height = 23
    TabOrder = 5
    Text = '100'
  end
  object CheckBox2: TCheckBox
    Left = 499
    Top = 652
    Width = 17
    Height = 17
    Enabled = False
    TabOrder = 6
  end
  object CheckBox3: TCheckBox
    Left = 499
    Top = 684
    Width = 17
    Height = 17
    Enabled = False
    TabOrder = 7
  end
  object Edit4: TEdit
    Left = 552
    Top = 672
    Width = 41
    Height = 23
    TabOrder = 8
    Text = '-10'
  end
  object Edit5: TEdit
    Left = 680
    Top = 672
    Width = 41
    Height = 23
    TabOrder = 9
    Text = '10'
  end
  object CheckBox4: TCheckBox
    Left = 611
    Top = 676
    Width = 17
    Height = 17
    Enabled = False
    TabOrder = 10
  end
  object CheckBox5: TCheckBox
    Left = 739
    Top = 676
    Width = 17
    Height = 17
    Enabled = False
    TabOrder = 11
  end
  object Edit6: TEdit
    Left = 606
    Top = 712
    Width = 41
    Height = 23
    TabOrder = 12
    Text = '-10'
  end
  object Edit7: TEdit
    Left = 606
    Top = 632
    Width = 41
    Height = 23
    TabOrder = 13
    Text = '30'
  end
  object CheckBox6: TCheckBox
    Left = 650
    Top = 716
    Width = 17
    Height = 17
    Enabled = False
    TabOrder = 14
  end
  object CheckBox7: TCheckBox
    Left = 650
    Top = 636
    Width = 17
    Height = 17
    Enabled = False
    TabOrder = 15
  end
  object StringGrid2: TStringGrid
    Left = 392
    Top = 552
    Width = 313
    Height = 49
    ColCount = 11
    DefaultColWidth = 30
    FixedCols = 10
    RowCount = 2
    TabOrder = 16
  end
  object CheckBox8: TCheckBox
    Left = 347
    Top = 548
    Width = 17
    Height = 17
    Enabled = False
    TabOrder = 17
  end
end
