object fmPrint: TfmPrint
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'fmPrint'
  ClientHeight = 686
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poPrintToFit
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPrint: TPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 686
    Align = alClient
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 452
    ExplicitHeight = 586
    object sgPrint: TStringGrid
      Left = 0
      Top = 0
      Width = 600
      Height = 600
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DefaultColWidth = 25
      DefaultRowHeight = 25
      DefaultDrawing = False
      FixedCols = 0
      FixedRows = 0
      ParentCtl3D = False
      TabOrder = 0
      OnDrawCell = sgPrintDrawCell
      ExplicitWidth = 500
      ExplicitHeight = 448
    end
    object redPrint: TRichEdit
      Left = 0
      Top = 600
      Width = 600
      Height = 82
      Align = alBottom
      BevelEdges = []
      BevelInner = bvLowered
      BevelOuter = bvRaised
      BorderStyle = bsNone
      Ctl3D = False
      ParentCtl3D = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object bbtnPrint: TBitBtn
      Left = 427
      Top = 600
      Width = 75
      Height = 23
      Caption = #1055#1077#1095#1072#1090#1100
      TabOrder = 2
      OnClick = bbtnPrintClick
    end
    object bbtnClose: TBitBtn
      Left = 503
      Top = 600
      Width = 75
      Height = 23
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 3
      Kind = bkCancel
    end
  end
end