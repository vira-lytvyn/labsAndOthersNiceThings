object FormMain: TFormMain
  Left = 227
  Top = 128
  Caption = #1054#1087#1090#1080#1084#1072#1083#1100#1085#1086#1077' '#1082#1086#1076#1080#1088#1086#1074#1072#1085#1080#1077' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
  ClientHeight = 505
  ClientWidth = 772
  Color = clBtnFace
  Constraints.MinHeight = 550
  Constraints.MinWidth = 790
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
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
  Position = poDefault
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 17
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 772
    Height = 31
    BandBorderStyle = bsNone
    Bands = <
      item
        Control = edText
        ImageIndex = -1
        MinHeight = 20
        Width = 770
      end>
    EdgeInner = esNone
    EdgeOuter = esNone
    object edText: TEdit
      Left = 11
      Top = 0
      Width = 761
      Height = 20
      TabOrder = 0
      Text = #1050#1059#1050#1059#1064#1050#1040'_'#1050#1059#1050#1059#1064#1054#1053#1050#1059'_'#1050#1059#1055#1048#1051#1040'_'#1050#1040#1055#1070#1064#1054#1053
      OnChange = edTextChange
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 31
    Width = 772
    Height = 211
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label3: TLabel
      Left = 0
      Top = 0
      Width = 772
      Height = 24
      Align = alTop
      Caption = '  '#1052#1086#1076#1077#1083#1080#1088#1086#1074#1097#1080#1082
      Color = clHighlight
      Constraints.MinHeight = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      ExplicitWidth = 114
    end
    object Panel5: TPanel
      Left = 0
      Top = 24
      Width = 772
      Height = 187
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 3
      Caption = 'Panel5'
      TabOrder = 0
      object memAnalyze: TMemo
        Left = 3
        Top = 3
        Width = 766
        Height = 181
        Align = alClient
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 242
    Width = 772
    Height = 263
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 772
      Height = 24
      Align = alTop
      Caption = '  '#1050#1086#1076#1080#1088#1086#1074#1097#1080#1082
      Color = clHighlight
      Constraints.MinHeight = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      ExplicitWidth = 95
    end
    object Panel4: TPanel
      Left = 0
      Top = 24
      Width = 772
      Height = 239
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 4
      Caption = 'Panel4'
      TabOrder = 0
      object PageControl1: TPageControl
        Left = 4
        Top = 4
        Width = 764
        Height = 231
        ActivePage = TabSheet1
        Align = alClient
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = #1064#1077#1085#1085#1086#1085#1072'-'#1060#1072#1085#1086
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 756
            Height = 199
            Align = alClient
            BevelOuter = bvLowered
            Caption = 'Panel1'
            TabOrder = 0
            object memShannonFano: TMemo
              Left = 1
              Top = 103
              Width = 754
              Height = 95
              Align = alBottom
              BorderStyle = bsNone
              Color = 15132390
              Ctl3D = True
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 0
            end
            object sgShannonFano: TStringGrid
              Left = 1
              Top = 1
              Width = 754
              Height = 102
              Align = alClient
              BorderStyle = bsNone
              ColCount = 32
              DefaultColWidth = 24
              DefaultRowHeight = 20
              FixedCols = 0
              RowCount = 32
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goThumbTracking]
              TabOrder = 1
              ColWidths = (
                60
                96
                73
                63
                66
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24)
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #1061#1072#1092#1092#1084#1072#1085#1072
          ImageIndex = 1
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 756
            Height = 199
            Align = alClient
            BevelOuter = bvLowered
            Caption = 'Panel3'
            TabOrder = 0
            object memHuffman: TMemo
              Left = 1
              Top = 102
              Width = 754
              Height = 96
              Align = alBottom
              BorderStyle = bsNone
              Color = 15132390
              Ctl3D = True
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 0
            end
            object sgHuffman: TStringGrid
              Left = 1
              Top = 1
              Width = 754
              Height = 101
              Align = alClient
              BorderStyle = bsNone
              ColCount = 32
              DefaultColWidth = 24
              DefaultRowHeight = 20
              FixedCols = 0
              RowCount = 32
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goThumbTracking]
              TabOrder = 1
              ColWidths = (
                61
                91
                73
                65
                66
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24
                24)
            end
          end
        end
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 183
    Top = 92
  end
end
