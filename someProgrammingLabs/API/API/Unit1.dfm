object Form1: TForm1
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'API'
  ClientHeight = 425
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 153
    Height = 25
    Caption = 'Control Panel'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 40
    Width = 153
    Height = 25
    Caption = 'Open As'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 72
    Width = 153
    Height = 25
    Caption = 'About windows'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 104
    Width = 153
    Height = 25
    Caption = 'DeskOptions'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 136
    Width = 153
    Height = 25
    Caption = 'SortingWindows'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 168
    Width = 153
    Height = 25
    Caption = 'DisplaceWindowsDownwards'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 200
    Width = 153
    Height = 25
    Caption = 'RepaintScreen'
    TabOrder = 6
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 8
    Top = 232
    Width = 153
    Height = 25
    Caption = 'ExecuteExplorer'
    TabOrder = 7
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 264
    Width = 153
    Height = 25
    Caption = 'KeyboardDisable'
    TabOrder = 8
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 8
    Top = 296
    Width = 153
    Height = 25
    Caption = 'MouseDisable'
    TabOrder = 9
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 8
    Top = 328
    Width = 153
    Height = 25
    Caption = 'SwapMouseButton'
    TabOrder = 10
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 8
    Top = 360
    Width = 153
    Height = 25
    Caption = 'SetCursorPos'
    TabOrder = 11
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 8
    Top = 392
    Width = 153
    Height = 25
    Caption = 'wnetConnectDialog'
    TabOrder = 12
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 168
    Top = 8
    Width = 153
    Height = 25
    Caption = 'wnetDisconnectDialog'
    TabOrder = 13
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 168
    Top = 40
    Width = 153
    Height = 25
    Caption = 'Failure'
    TabOrder = 14
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 168
    Top = 72
    Width = 153
    Height = 25
    Caption = 'DiskCopyRunDll'
    TabOrder = 15
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 168
    Top = 104
    Width = 153
    Height = 25
    Caption = 'RnaWizard'
    TabOrder = 16
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 168
    Top = 136
    Width = 153
    Height = 25
    Caption = 'SHFormatDrive'
    TabOrder = 17
    OnClick = Button18Click
  end
  object Button19: TButton
    Left = 168
    Top = 168
    Width = 153
    Height = 25
    Caption = 'ReloadExplorer'
    TabOrder = 18
    OnClick = Button19Click
  end
  object Button20: TButton
    Left = 168
    Top = 200
    Width = 153
    Height = 25
    Caption = 'SetCaretBlinkTime'
    TabOrder = 19
    OnClick = Button20Click
  end
  object Button21: TButton
    Left = 168
    Top = 232
    Width = 153
    Height = 25
    Caption = 'SetDoubleClickTime'
    TabOrder = 20
    OnClick = Button21Click
  end
  object Button22: TButton
    Left = 168
    Top = 264
    Width = 153
    Height = 25
    Caption = 'InstallDevice_Rundll'
    TabOrder = 21
    OnClick = Button22Click
  end
  object Button23: TButton
    Left = 168
    Top = 296
    Width = 153
    Height = 25
    Caption = 'ShutDown'
    TabOrder = 22
    OnClick = Button23Click
  end
  object Button24: TButton
    Left = 168
    Top = 328
    Width = 153
    Height = 25
    Caption = 'Reboot'
    TabOrder = 23
    OnClick = Button24Click
  end
  object Button25: TButton
    Left = 168
    Top = 360
    Width = 153
    Height = 25
    Caption = 'LogoOff'
    TabOrder = 24
    OnClick = Button25Click
  end
  object Button26: TButton
    Left = 168
    Top = 392
    Width = 153
    Height = 25
    Caption = 'OpenCD'
    TabOrder = 25
    OnClick = Button26Click
  end
  object Button27: TButton
    Left = 328
    Top = 8
    Width = 153
    Height = 25
    Caption = 'CloseCD'
    TabOrder = 26
    OnClick = Button27Click
  end
  object Button30: TButton
    Left = 328
    Top = 40
    Width = 153
    Height = 25
    Caption = 'UserName'
    TabOrder = 27
    OnClick = Button30Click
  end
  object Button29: TButton
    Left = 328
    Top = 72
    Width = 153
    Height = 25
    Caption = 'ComputerName'
    TabOrder = 28
    OnClick = Button29Click
  end
  object Button31: TButton
    Left = 328
    Top = 104
    Width = 153
    Height = 25
    Caption = 'WindowsDirectory'
    TabOrder = 29
    OnClick = Button31Click
  end
  object Button32: TButton
    Left = 328
    Top = 136
    Width = 153
    Height = 25
    Caption = 'SystemDirectory'
    TabOrder = 30
    OnClick = Button32Click
  end
  object Button33: TButton
    Left = 328
    Top = 168
    Width = 153
    Height = 25
    Caption = 'SystemTime'
    TabOrder = 31
    OnClick = Button33Click
  end
  object Button34: TButton
    Left = 328
    Top = 200
    Width = 153
    Height = 25
    Caption = 'LocalTime'
    TabOrder = 32
    OnClick = Button34Click
  end
  object Button35: TButton
    Left = 328
    Top = 232
    Width = 153
    Height = 25
    Caption = 'CurrentDirectory'
    TabOrder = 33
    OnClick = Button35Click
  end
  object Button36: TButton
    Left = 328
    Top = 264
    Width = 153
    Height = 25
    Caption = 'TempPath'
    TabOrder = 34
    OnClick = Button36Click
  end
  object Button37: TButton
    Left = 328
    Top = 296
    Width = 153
    Height = 25
    Caption = 'LogicalDrives'
    TabOrder = 35
    OnClick = Button37Click
  end
  object Button38: TButton
    Left = 328
    Top = 328
    Width = 153
    Height = 25
    Caption = 'OSVersion'
    TabOrder = 36
    OnClick = Button38Click
  end
  object Button39: TButton
    Left = 328
    Top = 360
    Width = 153
    Height = 25
    Caption = 'GetShortPathName'
    TabOrder = 37
    OnClick = Button39Click
  end
  object Button40: TButton
    Left = 328
    Top = 392
    Width = 153
    Height = 25
    Caption = 'ApplicationExeName'
    TabOrder = 38
    OnClick = Button40Click
  end
end
