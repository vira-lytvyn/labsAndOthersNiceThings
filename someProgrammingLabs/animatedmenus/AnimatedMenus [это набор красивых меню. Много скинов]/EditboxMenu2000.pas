
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       Add-On Menu Components                          }
{       TEditboxMenu2000 Component                      }
{                                                       }
{       Copyright © 1997-2001 by AnimatedMenus.com      }
{                                                       }
{*******************************************************}

//
//  For technical information and latest versions please visit
//  http://www.animatedmenus.com/support/teditboxmenu2000/
//

unit EditboxMenu2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, RichEdit, am2000menuitem, am2000popupmenu, am2000;

type
  TEditboxMenu2000 = class(TPopupMenu2000)
  private
    FShowShortCuts: Boolean;

  protected
    function GetComponentItemsCaption: String; override;
    procedure CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean); override;

    procedure UndoClick(Sender: TObject); virtual;
    procedure CutClick(Sender: TObject); virtual;
    procedure CopyClick(Sender: TObject); virtual;
    procedure PasteClick(Sender: TObject); virtual;
    procedure DeleteClick(Sender: TObject); virtual;
    procedure SelectAllClick(Sender: TObject); virtual;

  published
    property ShowShortCuts: Boolean
      read FShowShortCuts write FShowShortCuts default False;

  end;

procedure Register;

implementation

uses
  am2000cache;

procedure Register;
begin
  RegisterComponents('Animated Menus', [TEditboxMenu2000]);
end;


{ TEditboxMenu2000 }

procedure TEditboxMenu2000.CreateComponentItems(Items: TMenuItem2000; AddEmpty: Boolean);
var
  Selection: LongRec;
  MI: TMenuItem2000;
  ShortCuts: array [Boolean, 0..7] of String;
begin
  ShortCuts[True, 0]:= SCtrl + '+Z';
  ShortCuts[True, 1]:= '';
  ShortCuts[True, 2]:= SCtrl + '+X';
  ShortCuts[True, 3]:= SCtrl + '+C';
  ShortCuts[True, 4]:= SCtrl + '+V';
  ShortCuts[True, 5]:= SDel;
  ShortCuts[True, 6]:= '';
  ShortCuts[True, 7]:= SCtrl + '+A';

  if PopupComponent is TWinControl
  then
    with PopupComponent as TWinControl
    do begin
      LongInt(Selection):= Perform(em_GetSel, 0, 0);

      Items.Add(NewItem2000('&Undo',       '', False, Perform(em_CanUndo, 0, 0) <> 0, UndoClick,
        0, ShortCuts[FShowShortCuts, 0]));
      Items.Add(NewLine);

      Items.Add(NewItem2000('Cu&t',        '', False, Selection.Lo <> Selection.Hi, CutClick,
        0, ShortCuts[FShowShortCuts, 2]));
      Items.Add(NewItem2000('&Copy',       '', False, Selection.Lo <> Selection.Hi, CopyClick,
        0, ShortCuts[FShowShortCuts, 3]));
      Items.Add(NewItem2000('&Paste',      '', False, IsClipboardFormatAvailable(cf_Text), PasteClick,
        0, ShortCuts[FShowShortCuts, 4]));

      MI:= NewItem2000('&Delete',     '', False, Selection.Lo <> Selection.Hi, DeleteClick,
        0, ShortCuts[FShowShortCuts, 5]);
      MI.DefaultIndex:= -2;
      Items.Add(MI);

      Items.Add(NewLine);
      Items.Add(NewItem2000('&Select All', '', False, (Selection.Lo <> 0)
        or (Selection.Hi <> Perform(wm_GetTextLength, 0, 0)),
        SelectAllClick, 0, ShortCuts[FShowShortCuts, 7]));
    end;
end;

procedure TEditboxMenu2000.CopyClick(Sender: TObject);
begin
  if PopupComponent is TWinControl then
    TWinControl(PopupComponent).Perform(wm_Copy, 0, 0);
end;

procedure TEditboxMenu2000.CutClick(Sender: TObject);
begin
  if PopupComponent is TWinControl then
    TWinControl(PopupComponent).Perform(wm_Cut, 0, 0);
end;

procedure TEditboxMenu2000.DeleteClick(Sender: TObject);
begin
  if PopupComponent is TWinControl then
    TWinControl(PopupComponent).Perform(wm_Clear, 0, 0);
end;

procedure TEditboxMenu2000.PasteClick(Sender: TObject);
begin
  if PopupComponent is TWinControl then
    TWinControl(PopupComponent).Perform(wm_Paste, 0, 0);
end;

procedure TEditboxMenu2000.SelectAllClick(Sender: TObject);
begin
  if PopupComponent is TWinControl then
    with PopupComponent as TWinControl do
      Perform(em_SetSel, 0, Perform(wm_GetTextLength, 0, 0));
end;

procedure TEditboxMenu2000.UndoClick(Sender: TObject);
begin
  if PopupComponent is TWinControl then
    TWinControl(PopupComponent).Perform(em_Undo, 0, 0);
end;

function TEditboxMenu2000.GetComponentItemsCaption: String;
begin
  Result:= 'Editbox Menu Items';
end;

end.

