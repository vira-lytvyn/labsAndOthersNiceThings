object Form1: TForm1
  Left = 207
  Top = 255
  Width = 870
  Height = 640
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 488
    Width = 12
    Height = 13
    Caption = 'a='
  end
  object Label2: TLabel
    Left = 16
    Top = 528
    Width = 12
    Height = 13
    Caption = 'b='
  end
  object Chart1: TChart
    Left = 24
    Top = 24
    Width = 809
    Height = 425
    BackWall.Brush.Color = clWhite
    BackWall.Color = 16760704
    BackWall.Pen.Color = 16747287
    BackWall.Pen.Width = 7
    BottomWall.Brush.Color = 16744448
    BottomWall.Pen.Color = 16744448
    BottomWall.Pen.Width = 7
    Foot.Color = 8454143
    Gradient.StartColor = clYellow
    Gradient.Visible = True
    LeftWall.Brush.Color = 16744448
    LeftWall.Color = 16744448
    LeftWall.Pen.Color = 16744448
    LeftWall.Pen.Width = 7
    Title.Text.Strings = (
      'TChart')
    BackColor = 16760704
    Frame.Color = 16747287
    Frame.Width = 7
    Legend.Color = 16744448
    Legend.DividingLines.Color = clYellow
    Legend.DividingLines.Width = 2
    Legend.DividingLines.Visible = True
    Legend.ShadowColor = clYellow
    Legend.Visible = False
    View3D = False
    BevelWidth = 0
    BorderWidth = 15
    BorderStyle = bsSingle
    TabOrder = 0
    object Series1: TLineSeries
      Cursor = crHandPoint
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clYellow
      LinePen.Color = 16744448
      LinePen.Width = 3
      Pointer.HorizSize = 3
      Pointer.InflateMargins = False
      Pointer.Style = psDiamond
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object Edit1: TEdit
    Left = 80
    Top = 488
    Width = 73
    Height = 25
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 80
    Top = 528
    Width = 73
    Height = 25
    TabOrder = 2
  end
  object Button1: TButton
    Left = 224
    Top = 488
    Width = 121
    Height = 65
    Caption = #1041#1091#1076#1091#1074#1072#1090#1080' '#1075#1088#1072#1092#1110#1082' '
    TabOrder = 3
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 520
    Top = 488
    Width = 121
    Height = 65
    Caption = '& '#1042#1080#1081#1090#1080' '
    TabOrder = 4
    Kind = bkClose
  end
  object Button2: TButton
    Left = 376
    Top = 488
    Width = 121
    Height = 65
    Caption = #1054#1095#1080#1089#1090#1080#1090#1080' '#1074#1089#1077' '
    TabOrder = 5
    OnClick = Button2Click
  end
end
