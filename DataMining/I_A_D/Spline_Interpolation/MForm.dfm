object Form1: TForm1
  Left = 223
  Top = 124
  Width = 843
  Height = 661
  Caption = 'Spline Interpolator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 0
    Width = 835
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    MinSize = 140
    ResizeStyle = rsUpdate
  end
  object PaintBox1: TPaintBox
    Left = 8
    Top = 8
    Width = 657
    Height = 609
  end
  object Label1: TLabel
    Left = 672
    Top = 40
    Width = 15
    Height = 13
    Caption = 'a ='
  end
  object Label2: TLabel
    Left = 672
    Top = 72
    Width = 18
    Height = 13
    Caption = 'b = '
  end
  object Label3: TLabel
    Left = 672
    Top = 104
    Width = 18
    Height = 13
    Caption = 'h = '
  end
  object Label4: TLabel
    Left = 672
    Top = 136
    Width = 17
    Height = 13
    Caption = 'x = '
  end
  object CheckBox2: TCheckBox
    Left = 703
    Top = 243
    Width = 97
    Height = 17
    Caption = 'Lines'
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = CheckBox3Click
  end
  object CheckBox1: TCheckBox
    Left = 703
    Top = 220
    Width = 97
    Height = 17
    Caption = 'Nodes'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CheckBox3Click
  end
  object CheckBox3: TCheckBox
    Left = 703
    Top = 197
    Width = 97
    Height = 17
    Caption = 'Values'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = CheckBox3Click
  end
  object Button3: TButton
    Left = 704
    Top = 416
    Width = 90
    Height = 25
    Caption = 'Interpolate'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 704
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '0.3'
  end
  object Edit2: TEdit
    Left = 704
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '0.7'
  end
  object Edit3: TEdit
    Left = 704
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '0.11'
  end
  object Edit4: TEdit
    Left = 704
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '0.4'
  end
end
