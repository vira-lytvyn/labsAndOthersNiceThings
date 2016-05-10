object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1088#1077#1076#1072#1082#1090#1086#1088
  ClientHeight = 646
  ClientWidth = 942
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 942
    Height = 646
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    PlainText = True
    PopupMenu = PopupMenu1
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Options = []
    Left = 50
    Top = 387
  end
  object MainMenu1: TMainMenu
    Left = 53
    Top = 24
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N4: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100
        ShortCut = 16462
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = N6Click
      end
      object N7: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
        ShortCut = 49235
        OnClick = N7Click
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object N25: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1077#1095#1072#1090#1080
        OnClick = N25Click
      end
      object N9: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100
        ShortCut = 16464
        OnClick = N9Click
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object N24: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 32883
        OnClick = N24Click
      end
    end
    object N2: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      object N10: TMenuItem
        Action = EditUndo1
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object N12: TMenuItem
        Action = EditCut1
        Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      end
      object N13: TMenuItem
        Action = EditCopy1
        Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      end
      object N14: TMenuItem
        Action = EditPaste1
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      end
      object N15: TMenuItem
        Action = EditDelete1
        Caption = #1059#1076#1072#1083#1080#1090#1100
        ShortCut = 16452
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object N17: TMenuItem
        Action = EditSelectAll1
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object N27: TMenuItem
        Caption = #1053#1072#1081#1090#1080
        ShortCut = 16454
        OnClick = N27Click
      end
      object N28: TMenuItem
        Caption = #1047#1072#1084#1077#1085#1080#1090#1100
        ShortCut = 16456
        OnClick = N28Click
      end
      object N29: TMenuItem
        Caption = '-'
      end
      object N19: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1074#1088#1077#1084#1103' '#1080' '#1076#1072#1090#1091
        OnClick = N19Click
      end
    end
    object N3: TMenuItem
      Caption = #1060#1086#1088#1084#1072#1090
      object N20: TMenuItem
        AutoCheck = True
        Caption = #1055#1077#1088#1077#1085#1086#1089' '#1087#1086' '#1089#1083#1086#1074#1072#1084
        Checked = True
        OnClick = N20Click
      end
      object N21: TMenuItem
        Caption = #1064#1088#1080#1092#1090
        OnClick = N21Click
      end
    end
    object N22: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N26: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      end
    end
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 48
    Top = 96
  end
  object PrintDialog1: TPrintDialog
    Left = 51
    Top = 321
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 51
    Top = 249
  end
  object SaveTextFileDialog1: TSaveTextFileDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 48
    Top = 168
  end
  object XPManifest1: TXPManifest
    Left = 160
    Top = 40
  end
  object FindDialog1: TFindDialog
    OnFind = FindDialog1Find
    Left = 240
    Top = 128
  end
  object ReplaceDialog1: TReplaceDialog
    OnFind = ReplaceDialog1Find
    OnReplace = ReplaceDialog1Replace
    Left = 240
    Top = 224
  end
  object PopupMenu1: TPopupMenu
    Left = 192
    Top = 352
    object N30: TMenuItem
      Action = EditUndo1
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    end
    object N31: TMenuItem
      Caption = '-'
    end
    object N32: TMenuItem
      Action = EditCut1
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
    end
    object N33: TMenuItem
      Action = EditCopy1
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
    end
    object N34: TMenuItem
      Action = EditPaste1
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
    end
    object N35: TMenuItem
      Action = EditDelete1
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16452
    end
    object N36: TMenuItem
      Caption = '-'
    end
    object N37: TMenuItem
      Action = EditSelectAll1
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
    end
  end
  object ActionList1: TActionList
    Left = 320
    Top = 352
    object EditUndo1: TEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 3
      ShortCut = 16474
    end
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditDelete1: TEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 5
      ShortCut = 46
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
  end
end
