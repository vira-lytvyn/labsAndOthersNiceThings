
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_WelcomeDlg Unit                        }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000welcome;

{$I am2000.inc}

interface

uses
  {$IFDEF Delphi6OrHigher} DesignIntf, DesignEditors, {$ELSE} DsgnIntf, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, ComCtrls;

type
  T_AM2000_WelcomeDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    MenuFile: TEdit;
    Button3: TButton;
    Button4: TButton;
    SkinFile: TEdit;
    RadioButton3: TRadioButton;
    Image4: TImage;
    Image3: TImage;
    Image1: TImage;
    GroupBox2: TGroupBox;
    Image2: TImage;
    RadioButton4: TRadioButton;
    Upgrade: TEdit;
    Button5: TButton;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton4Enter(Sender: TObject);
    procedure RadioButton3Enter(Sender: TObject);

  private
    FMenu, FUpgrade: TMenu;
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);

  public
    { Public declarations }
  end;


procedure ShowWelcome(AMenu: TComponent;
{$IFDEF Delphi6OrHigher}
      ADesigner: IDesigner
{$ELSE}
{$IFDEF Delphi4OrHigher}
      ADesigner: IFormDesigner
{$ELSE}
      ADesigner: TFormDesigner
{$ENDIF}
{$ENDIF}
);

implementation

uses
  Registry, 
  am2000cache, am2000skin, am2000utils, am2000designer, am2000mainmenu,
  am2000popupmenu, am2000menuitem;

{$R *.DFM}

const
  MENU_REGISTRY_KEY : String = '\Software\AnimatedMenus.com\AnimatedMenus/2000\';


procedure ShowWelcome;
var
  F: T_AM2000_WelcomeDlg;
  Reg: TRegistry;
  S: String;
  ModalResult: TModalResult;
  C: TComponent;
  NewMainMenu: TMainMenu;
  NewPopupMenu: TPopupMenu;
  I: Integer;
  I2: TMenuItem;


  procedure CopyItems(const Source, Dest: TMenuItem);
  var
    S: TMenuItem;
    MI: TMenuItem2000;
    I: Integer;
    TempName: String;
  begin
    with TMenuItem2000(Dest)
    do begin
      S:= TMenuItem(Source);

      Caption:= S.Caption;
      Enabled:= S.Enabled;
      Default:= S.Default;
      Checked:= S.Checked;
      Visible:= S.Visible;
      Hint:=    S.Hint;
      ShortCut:= ShortCutToText(S.ShortCut);
      OnClick:= S.OnClick;

{$IFDEF Delphi4OrHigher}
      Bitmap.Assign(S.Bitmap);
      Action:= S.Action;
      ImageIndex:= S.ImageIndex;
      OnDrawItem:= S.OnDrawItem;
      OnMeasureItem:= S.OnMeasureItem;
{$ENDIF}

{$IFDEF Delphi5OrHigher}
      OnAdvancedDrawItem:= S.OnAdvancedDrawItem;
      SubMenuImages:= S.SubMenuImages;
{$ENDIF}

      for I:= 0 to S.Count -1
      do begin
        MI:= TMenuItem2000(ADesigner.CreateComponent(TMenuItem2000, S[I].Owner, 0, 0, 0, 0));
        TempName:= S[I].Name;
        S[I].Name:= '';
        MI.Name:= TempName;

        CopyItems(S[I], MI);
        Add(MI);
      end;
    end;
  end;


begin
  // find folders
  Reg:= TRegistry.Create;

  if Reg.OpenKey(MENU_REGISTRY_KEY + 'Welcome', False)
  then begin
    try
      if not Reg.ReadBool('ShowAgain')
      then begin
        Reg.Free;
        Exit;
      end;
    except
    end;

    try
      FMenuFilename:= Reg.ReadString('MenuFilename');
    except
    end;

    try
      FSkinFilename:= Reg.ReadString('SkinFilename');
    except
    end;

    try
      FMenuFormat:= Reg.ReadInteger('MenuFormat');
    except
    end;

    try
      FSkinFormat:= Reg.ReadInteger('SkinFormat');
    except
    end;
  end;

  // create
  F:= T_AM2000_WelcomeDlg.Create(Application);

  with F
  do begin
    FMenu:= TMenu(AMenu);
    MenuFile.Text:= ExtractFilename(FMenuFilename);
    SkinFile.Text:= ExtractFilename(FSkinFilename);

    C:= F.FindComponent(S);
    if (C <> nil)
    and (C is TRadioButton)
    then TRadioButton(C).Checked:= True;

    if FMenu.Owner = nil
    then begin
      Button5.Enabled:= False;
      RadioButton4.Enabled:= False;
    end;
  end;

  ModalResult:= F.ShowModal;

  Reg.OpenKey(MENU_REGISTRY_KEY + 'Welcome', True);

  // last selection
  if F.RadioButton1.Checked
  then Reg.WriteString('LastSelection', 'RadioButton1');

  if F.RadioButton2.Checked
  then Reg.WriteString('LastSelection', 'RadioButton2');

  if F.RadioButton3.Checked
  then Reg.WriteString('LastSelection', 'RadioButton3');

  if F.RadioButton4.Checked
  then Reg.WriteString('LastSelection', 'RadioButton4');

  Reg.WriteString('MenuFilename', FMenuFilename);
  Reg.WriteString('SkinFilename', FSkinFilename);
  Reg.WriteInteger('MenuFormat', FMenuFormat);
  Reg.WriteInteger('SkinFormat', FSkinFormat);
  Reg.WriteBool('ShowAgain', F.CheckBox1.Checked);

  // initialize component with selection
  if ModalResult = mrOk
  then begin
    if F.RadioButton2.Checked
    then begin
      LoadMenuFromFileFormat(AMenu, FMenuFilename, FMenuFormat);
    end;

    if F.RadioButton3.Checked
    then begin
      LoadSkinFromFileFormat(AMenu, FSkinFilename, FSkinFormat);
    end;

    if F.RadioButton4.Checked
    then begin
      NewMainMenu:= nil;
      NewPopupMenu:= nil;
      if AMenu is TCustomMainMenu2000
      then begin
        NewMainMenu:= TCustomMainMenu2000(AMenu);

        // copy properties & items
        CopyMenuProperties(F.FUpgrade, NewMainMenu);
        NewMainMenu.AutoMerge:= TMainMenu(F.FUpgrade).AutoMerge;
        CopyItems(F.FUpgrade.Items, NewMainMenu.Items);

        I2:= TCustomMainMenu2000(NewMainMenu).Items2000;
      end
      else
      if AMenu is TCustomPopupMenu2000
      then begin
        NewPopupMenu:= TCustomPopupMenu2000(AMenu);

        // copy properties & items
        CopyMenuProperties(F.FUpgrade, NewMainMenu);
        NewPopupMenu.Alignment:= TPopupMenu(F.FUpgrade).Alignment;
        NewPopupMenu.AutoPopup:= TPopupMenu(F.FUpgrade).AutoPopup;
{$IFDEF Delphi4OrHigher}
        NewPopupMenu.TrackButton:= TPopupMenu(F.FUpgrade).TrackButton;
{$ENDIF}
        CopyItems(F.FUpgrade.Items, NewMainMenu.Items);

        I2:= TCustomPopupMenu2000(NewPopupMenu).Items2000;
      end;

      // remove subitems
{$IFDEF Delphi5OrHigher}
      F.FUpgrade.Items.Clear;
{$ELSE}
      with F.FUpgrade
      do
        while Items.Count > 0
        do Items[0].Free;
{$ENDIF}



      // redirect all links
      if (AMenu.Owner is TCustomForm)
      and (TForm(AMenu.Owner).Menu = F.FUpgrade)
      then TForm(AMenu.Owner).Menu:= NewMainMenu;


      if AMenu.Owner is TControl
      then begin
        for I:= 0 to TWinControl(AMenu.Owner).ControlCount -1
        do begin
          C:= TWinControl(AMenu.Owner).Controls[I];

          if (C is TControl)
          and (TForm(C).PopupMenu = F.FUpgrade)
          then TForm(C).PopupMenu:= NewPopupMenu;

{$IFDEF Delphi6OrHigher}
          if (C is TToolbar)
          and (TToolbar(C).Menu = F.FUpgrade)
          then TToolbar(C).Menu:= NewMainMenu;
{$ENDIF}

{$IFDEF Delphi3OrHigher}
          if (C is TToolButton)
          and (TToolButton(C).DropdownMenu = F.FUpgrade)
          then TToolButton(C).DropdownMenu:= NewPopupMenu;
{$ENDIF}
        end;
      end;

      if (AMenu is TCustomMainMenu2000)
      and TCustomMainMenu2000(AMenu).ComponentLoaded
      then TCustomMainMenu2000(AMenu).DoLoaded;

      if (AMenu is TCustomPopupMenu2000)
      and TCustomPopupMenu2000(AMenu).ComponentLoaded
      then TCustomPopupMenu2000(AMenu).DoLoaded;

      // free
      F.FUpgrade.Free;
    end;
  end;

  F.Free;
  Reg.Free;
end;


{ T_AM2000_WelcomeDlg }


procedure T_AM2000_WelcomeDlg.Button3Click(Sender: TObject);
begin
  RadioButton2.Checked:= True;

  if not ExecuteOpenMenuDialog
  then Exit;

  MenuFile.Text:= ExtractFilename(FMenuFilename);
end;

procedure T_AM2000_WelcomeDlg.Button4Click(Sender: TObject);
begin
  RadioButton3.Checked:= True;

  if not ExecuteOpenAnimatedSkinDialog
  then Exit;

  SkinFile.Text:= ExtractFilename(FSkinFilename);
end;

procedure T_AM2000_WelcomeDlg.Button5Click(Sender: TObject);
var
  F: TForm;
  C: TControl;
  I: Integer;
  M: TComponent;
  L: TListBox;
  MenuType, Result: Boolean;
begin
  RadioButton4.Checked:= True;

  F:= TForm.Create(Self);
  F.BorderStyle:= bsDialog;
  F.SetBounds(Left -6, Top +43, 360, 300);
  F.Caption:= 'Select Menu Component';
  with F
  do begin
    C:= TLabel.Create(F);
    TLabel(C).Caption:= 'Select menu for upgrade:';
    C.SetBounds(12, 15, 119, 13);
    C.Parent:= F;

    L:= TListBox.Create(F);
    L.SetBounds(12, 33, 329, 193);
    L.OnClick:= ListBox1Click;
    L.OnDblClick:= ListBox1DblClick;
    L.Parent:= F;

    MenuType:= (FMenu is TCustomMainMenu2000); // true = main; false = popup

    for I:= 0 to FMenu.Owner.ComponentCount -1
    do begin
      M:= FMenu.Owner.Components[I];
      if MenuType
      then
        Result:= (M is TMainMenu) and not (M is TCustomMainMenu2000)
      else
        Result:= (M is TPopupMenu) and not (M is TCustomPopupMenu2000);

      if Result
      then L.Items.Add(M.Name);
    end;


    C:= TButton.Create(F);
    C.Name:= 'OK';
    C.SetBounds(184, 234, 75, 24);
    TButton(C).Enabled:= False;
    TButton(C).Caption:= 'OK';
    TButton(C).Default:= True;
    TButton(C).ModalResult:= mrOk;
    C.Parent:= F;

    C:= TButton.Create(F);
    C.SetBounds(266, 234, 75, 24);
    TButton(C).Caption:= 'Cancel';
    TButton(C).Cancel:= True;
    TButton(C).ModalResult:= mrCancel;
    C.Parent:= F;
  end;

  if F.ShowModal = mrOk
  then begin
    Upgrade.Text:= L.Items[L.ItemIndex];
    FUpgrade:= TMenu(FMenu.Owner.FindComponent(Upgrade.Text));
  end;

  F.Free;
end;

procedure T_AM2000_WelcomeDlg.ListBox1Click(Sender: TObject);
var
  C: TComponent;
begin
  C:= TComponent(Sender).Owner.FindComponent('OK');
  if C <> nil
  then TButton(C).Enabled:= True;
end;

procedure T_AM2000_WelcomeDlg.ListBox1DblClick(Sender: TObject);
begin
  TForm(TComponent(Sender).Owner).ModalResult:= mrOk;
end;

procedure T_AM2000_WelcomeDlg.Button1Click(Sender: TObject);
begin
  if (RadioButton2.Checked)
  and (FMenuFilename = '')
  then begin
    MessageBox(Handle, 'Menu file name expected.'#13'Please choose menu file name.', 'Error', mb_IconInformation);
    Button3Click(Sender);
    Exit;
  end;

  if (RadioButton3.Checked)
  and (FSkinFilename = '')
  then begin
    MessageBox(Handle, 'Skin file name expected.'#13'Please choose skin file name.', 'Error', mb_IconInformation);
    Button4Click(Sender);
    Exit;
  end;

  if (RadioButton4.Checked)
  and (FUpgrade = nil)
  then begin
    MessageBox(Handle, 'Menu component expected.'#13'Please choose menu component to upgrade.', 'Error', mb_IconInformation);
    Button5Click(Sender);
    Exit;
  end;

  ModalResult:= mrOk;
end;

procedure T_AM2000_WelcomeDlg.RadioButton4Enter(Sender: TObject);
begin
  RadioButton1.Checked:= False;
  RadioButton2.Checked:= False;
  RadioButton3.Checked:= False;
end;

procedure T_AM2000_WelcomeDlg.RadioButton3Enter(Sender: TObject);
begin
  RadioButton4.Checked:= False;
end;

end.

