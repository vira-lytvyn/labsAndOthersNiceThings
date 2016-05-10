
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Shortcut editor                                 }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}

unit am2000shortcut;

{$I am2000.inc}

interface

uses
  SysUtils, Windows, ComCtrls, StdCtrls, Controls, ExtCtrls, Classes, Forms,
  {$IFDEF Delphi6OrHigher} DesignIntf, DesignEditors, {$ELSE} DsgnIntf, {$ENDIF}
  am2000designer, am2000;

type
  // shortcut property
  T_AM2000_ShortCutProperty = class(TPropertyEditor)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    function GetAttributes: TPropertyAttributes; override;
    function AllEqual: Boolean; override;
    procedure Edit; override;

  end;

  // shortcut editor
  T_AM2000_ShortCutEditor = class(TForm)
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    ListView1: TListView;
    ListView2: TListView;
    ListView3: TListView;
    _AM2000_Panel1: T_AM2000_Panel;
    Button4: TButton;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    procedure RebuildShortCuts(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);

  private
    FShortCuts: String;
    procedure SetShortCuts(AShortCuts: String);
    function GetShortCuts: String;

  protected
    procedure Loaded; override;

  public
    function EditShortCuts(var AShortCuts: String): Boolean;

  end;

implementation

uses
  Registry,
  am2000cache;

const
  SHORTCUT_REGISTRY_KEY : String = 'Software\AnimatedMenus.com\AnimatedMenus/2000\ShortCutEditor';

{$R *.DFM}

{ T_AM2000_ShortCutProperty }

procedure T_AM2000_ShortCutProperty.Edit;
var
  ShortCutEditor: T_AM2000_ShortCutEditor;
  S: String;
begin
  ShortCutEditor:= T_AM2000_ShortCutEditor.Create(Application);

  S:= GetStrValue;
  if ShortCutEditor.EditShortCuts(S)
  then begin
    SetStrValue(S);
    Modified;
  end;

  ShortCutEditor.Free;
end;

function T_AM2000_ShortCutProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog];
end;

function T_AM2000_ShortCutProperty.GetValue: string;
begin
  Result:= GetStrValue;
  if Result = '' then Result:= '(None)';
end;

procedure T_AM2000_ShortCutProperty.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

function T_AM2000_ShortCutProperty.AllEqual: Boolean;
var
  I: Integer;
  S: String;
begin
  Result:= False;
  if PropCount > 1 then
  begin
    S:= GetStrValue;
    for I:= 1 to PropCount - 1 do
      if GetStrValueAt(I) <> S then Exit;
  end;
  Result:= True;
end;


{ T_AM2000_ShortCutEditor }

procedure T_AM2000_ShortCutEditor.Loaded;
var
  R: TRegistry;
begin
  R:= TRegistry.Create;
  R.OpenKey(SHORTCUT_REGISTRY_KEY, True);
  try Left:= R.ReadInteger('Left');
  except end;
  try Top:= R.ReadInteger('Top');
  except end;
  try Width:= R.ReadInteger('Width');
  except end;
  try Height:= R.ReadInteger('Height');
  except end;
  try PageControl1.ActivePage:= PageControl1.Pages[R.ReadInteger('ActivePageIndex')];
  except end;

  R.Free;

  RebuildShortCuts(nil);
end;

procedure T_AM2000_ShortCutEditor.SetShortCuts(AShortCuts: String);

  procedure CheckListView(AListView: TListView);
  var
    I, P, E: Integer;
    T: TListItem;
  begin
    for I:= 0 to AListView.Items.Count -1
    do begin
      T:= AListView.Items[I];
      P:= Pos(T.Caption, AShortCuts);
      E:= P + Length(T.Caption);
      if (P <> 0)
      and ((P = 1) or (AShortCuts[P -1] = ';'))
      and ((E > Length(AShortCuts)) or (AShortCuts[E] = ';'))
      then begin
        T.Checked:= True;
        Delete(AShortCuts, P, E -P);
      end
      else
        if T.Checked
        then T.Checked:= False;
    end;
  end;

begin
  CheckListView(ListView1);
  CheckListView(ListView2);
  CheckListView(ListView3);
end;

function T_AM2000_ShortCutEditor.GetShortCuts: String;
var
  I: Integer;
  T: TListItem;
begin
  Result:= '';

  for I:= 0 to ListView1.Items.Count -1
  do begin
    T:= ListView1.Items[I];
    if T.Checked
    then begin
      if Result <> '' then AppendStr(Result, ';');
      AppendStr(Result, T.Caption);
    end;
  end;

  for I:= 0 to ListView2.Items.Count -1
  do begin
    T:= ListView2.Items[I];
    if T.Checked
    then begin
      if Result <> '' then AppendStr(Result, ';');
      AppendStr(Result, T.Caption);
    end;
  end;

  for I:= 0 to ListView3.Items.Count -1
  do begin
    T:= ListView3.Items[I];
    if T.Checked
    then begin
      if Result <> '' then AppendStr(Result, ';');
      AppendStr(Result, T.Caption);
    end;
  end;
end;

procedure T_AM2000_ShortCutEditor.RebuildShortCuts(Sender: TObject);
const
  nMaxPref = 8;
var
  I: Integer;
  C: Char;
  Prefixes : array [0..nMaxPref -1] of String;

  procedure AddCustomShortCut(SC: String);
  var
    I: Integer;
  begin
    ListView3.Items.Add.Caption:= SC;
    for I:= 1 to nMaxPref -1 do
      with ListView3.Items.Add
      do Caption:= Prefixes[I] + SC;
  end;

begin
  Prefixes[0]:= '';
  Prefixes[1]:= SCtrl + '+';
  Prefixes[2]:= SAlt + '+' ;
  Prefixes[3]:= SShift + '+';
  Prefixes[4]:= SCtrl + '+' + SAlt + '+';
  Prefixes[5]:= SShift + '+' + SAlt + '+';
  Prefixes[6]:= SShift + '+' + SCtrl + '+';
  Prefixes[7]:= SShift + '+' + SCtrl + '+' + SAlt  + '+';

  with ListView1.Items
  do begin
    BeginUpdate;
    Clear;

    for C:= 'A' to 'Z'
    do begin
      Add.Caption:= Prefixes[1] + C;
      Add.Caption:= Prefixes[2] + C;
      Add.Caption:= Prefixes[4] + C;
      Add.Caption:= Prefixes[5] + C;
      Add.Caption:= Prefixes[6] + C;
      Add.Caption:= Prefixes[7] + C;
    end;

{      for I:= 1 to nMaxPref -1
      do
       if (I <> 3)
      then}
//          Add.Caption:= Prefixes[I] + C;

    EndUpdate;
  end;

  with ListView2.Items
  do begin
    BeginUpdate;
    Clear;

    for I:= 1 to 12
    do begin
      Add.Caption:= Prefixes[0] + 'F' + IntToStr(I);
      Add.Caption:= Prefixes[1] + 'F' + IntToStr(I);
      Add.Caption:= Prefixes[2] + 'F' + IntToStr(I);
      Add.Caption:= Prefixes[3] + 'F' + IntToStr(I);
      Add.Caption:= Prefixes[4] + 'F' + IntToStr(I);
      Add.Caption:= Prefixes[5] + 'F' + IntToStr(I);
      Add.Caption:= Prefixes[6] + 'F' + IntToStr(I);
      Add.Caption:= Prefixes[7] + 'F' + IntToStr(I);
    end;

    EndUpdate;
  end;

  with ListView3.Items
  do begin
    BeginUpdate;
    Clear;

    AddCustomShortCut('Esc');
    AddCustomShortCut(SIns);
    AddCustomShortCut(SDel);
    AddCustomShortCut('BkSp');
    AddCustomShortCut('Enter');

    EndUpdate;
  end;

//  SetShortCuts(FShortCuts);
end;

procedure T_AM2000_ShortCutEditor.Button2Click(Sender: TObject);
begin
  SetShortCuts('');
end;

function T_AM2000_ShortCutEditor.EditShortCuts(
  var AShortCuts: String): Boolean;
begin
  SetShortCuts(AShortCuts);
  FShortCuts:= AShortCuts;
  Result:= ShowModal = mrOk;
  if Result then AShortCuts:= GetShortCuts;
end;

procedure T_AM2000_ShortCutEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  R: TRegistry;
begin
  R:= TRegistry.Create;
  R.OpenKey(SHORTCUT_REGISTRY_KEY, True);
  try R.WriteInteger('Left', Left);
  except end;
  try R.WriteInteger('Top', Top);
  except end;
  try R.WriteInteger('Width', Width);
  except end;
  try R.WriteInteger('Height', Height);
  except end;
  try R.WriteInteger('ActivePageIndex', PageControl1.ActivePage.PageIndex);
  except end;

  R.Free;
end;

procedure T_AM2000_ShortCutEditor.Button4Click(Sender: TObject);
begin
  SetShortCuts(FShortCuts);
end;

end.
