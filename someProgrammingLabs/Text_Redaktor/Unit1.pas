unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, Menus, StdCtrls, ShellAPI, Printers, XPMan, ComCtrls,
  StdActns, ActnList;

type
  TForm1 = class(TForm)
    FontDialog1: TFontDialog;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N25: TMenuItem;
    N9: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N2: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N3: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N26: TMenuItem;
    OpenTextFileDialog1: TOpenTextFileDialog;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    XPManifest1: TXPManifest;
    RichEdit1: TRichEdit;
    FindDialog1: TFindDialog;
    ReplaceDialog1: TReplaceDialog;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    PopupMenu1: TPopupMenu;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    ActionList1: TActionList;
    EditUndo1: TEditUndo;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditDelete1: TEditDelete;
    EditSelectAll1: TEditSelectAll;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N24Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure ReplaceDialog1Find(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  OpenFile: string = '';

implementation

{$R *.dfm}


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if RichEdit1.Modified = true then
begin
case Application.MessageBox('Документ был изменён. Сохранить?', 'Внимание!',
  MB_YESNOCANCEL + MB_ICONQUESTION) of
  IDCANCEL: Abort;//Отменить
  IDYES:
begin
  N6.Click;//Сохранить
if RichEdit1.Modified = true then
  CanClose:=false;
end;
end;
end;
end;

procedure TForm1.N19Click(Sender: TObject);
begin
  RichEdit1.SelText:=DateTimeToStr(Now);
end;

procedure TForm1.N20Click(Sender: TObject);
begin
if RichEdit1.ScrollBars=ssVertical then
  RichEdit1.ScrollBars:=ssBoth
else
  RichEdit1.ScrollBars:=ssVertical;
end;

procedure TForm1.N21Click(Sender: TObject);
begin
FontDialog1.Font:=RichEdit1.Font;
if FontDialog1.Execute then
  RichEdit1.Font:=FontDialog1.Font;
end;

procedure TForm1.N24Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.N25Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TForm1.N27Click(Sender: TObject);
begin
  FindDialog1.Execute;
end;

procedure TForm1.N28Click(Sender: TObject);
begin
  ReplaceDialog1.Execute;
end;

procedure TForm1.N4Click(Sender: TObject); //Создать
begin
if RichEdit1.Modified = true then
begin
case Application.MessageBox('Документ был изменён. Сохранить?', 'Внимание!',
  MB_YESNOCANCEL + MB_ICONQUESTION) of
  IDYES:
begin
  N6.Click;
if RichEdit1.Modified = false then
begin
  RichEdit1.Clear;
  OpenFile:='';
  Form1.Caption:='Текстовый редактор';
  RichEdit1.Modified:= false;
end;
end;
  IDNO:
begin
  RichEdit1.Clear;
  OpenFile:='';
  Form1.Caption:='Текстовый редактор';
  RichEdit1.Modified:= false;
end;
end;
end
else
begin
  RichEdit1.Clear;
  OpenFile:='';
  Form1.Caption:='Текстовый редактор';
  RichEdit1.Modified:= false;
end;
end;

procedure TForm1.N5Click(Sender: TObject); //Открыть
begin
if RichEdit1.Modified = true then
begin
case Application.MessageBox('Документ был изменён. Сохранить?', 'Внимание!',
  MB_YESNOCANCEL + MB_ICONQUESTION) of
  IDYES:
begin
  N6.Click;
if RichEdit1.Modified = false then
if OpenTextFileDialog1.Execute then
begin
  RichEdit1.Lines.LoadFromFile(OpenTextFileDialog1.FileName);
  OpenFile:=OpenTextFileDialog1.FileName;
  Form1.Caption:='Текстовый редактор - '+ExtractFileName(OpenFile);
  RichEdit1.Modified:= false;
end;
end;
  IDNO:
begin
if OpenTextFileDialog1.Execute then
begin
  RichEdit1.Lines.LoadFromFile(OpenTextFileDialog1.FileName);
  OpenFile:=OpenTextFileDialog1.FileName;
  Form1.Caption:='Текстовый редактор - '+ExtractFileName(OpenFile);
  RichEdit1.Modified:= false;
end;
end;
end;
end
else
if OpenTextFileDialog1.Execute then
begin
  RichEdit1.Lines.LoadFromFile(OpenTextFileDialog1.FileName);
  OpenFile:=OpenTextFileDialog1.FileName;
  Form1.Caption:='Текстовый редактор - '+ExtractFileName(OpenFile);
  RichEdit1.Modified:= false;
end;
end;

procedure TForm1.N6Click(Sender: TObject); //Сохранить
begin
if OpenFile <> '' then
begin
  RichEdit1.Lines.SaveToFile(OpenFile);
  RichEdit1.Modified:= false;
end
else
  N7.Click;
end;

procedure TForm1.N7Click(Sender: TObject); //Сохранить как
begin
case SaveTextFileDialog1.FilterIndex of
  1: SaveTextFileDialog1.DefaultExt:='txt';
end;
if SaveTextFileDialog1.Execute then
begin
  RichEdit1.Lines.SaveToFile(SaveTextFileDialog1.FileName);
  OpenFile:=SaveTextFileDialog1.FileName;
  Form1.Caption:='Текстовый редактор - '+ExtractFileName(OpenFile);
  RichEdit1.Modified:= false;
end
end;

procedure TForm1.N9Click(Sender: TObject); //Печать
var
  i: integer;
  f:System.TextFile;
  lst: TStringList;
begin
  lst:= TStringList.Create;
  lst.Text:= RichEdit1.SelText;
if lst.Text <> ''  then
  PrintDialog1.Options:= [poSelection];
  PrintDialog1.PrintRange:=prAllPages;
if PrintDialog1.Execute then
if PrintDialog1.PrintRange = prAllPages then
begin
//Printer.Canvas.Font := RichEdit1.Font;
  AssignPrn(f);
try
  Rewrite(f);
for i:=0 to RichEdit1.Lines.Count-1 do
  Writeln(f, RichEdit1.Lines[i]);
finally
  CloseFile(f);
  lst.Free;
end;
end
else
if PrintDialog1.PrintRange = prSelection then
begin
 //Printer.Canvas.Font := RichEdit1.Font;
  AssignPrn(f);
try
  Rewrite(f);
for i:=0 to lst.Count-1 do
  Writeln(f, lst.Strings[i]);
finally
  CloseFile(f);
  lst.Free;
end;
end;
  PrintDialog1.Options:= [];
end;

procedure TForm1.FindDialog1Find(Sender: TObject); //Найти
var
  StartPos, ToPos, FoundPos: Integer;
  Opt: TSearchTypes;
begin
if frMatchCase in FindDialog1.Options then
  Opt:=[stMatchCase];
if frWholeWord in FindDialog1.Options then
  Opt:=Opt+[stWholeWord];
  StartPos:=RichEdit1.SelStart+RichEdit1.SelLength;
  ToPos:=Length(RichEdit1.Text)-StartPos;
  FoundPos:=RichEdit1.FindText(FindDialog1.FindText, StartPos, ToPos, Opt);
if FoundPos<>-1 then
begin
  RichEdit1.SelStart:=FoundPos;
  RichEdit1.SelLength:=Length(FindDialog1.FindText);
  RichEdit1.SetFocus;
end
else
  MessageBox(FindDialog1.Handle, 'Поиск завершён!', '', MB_ICONINFORMATION);
end;

procedure TForm1.ReplaceDialog1Find(Sender: TObject);
var
  StartPos, ToPos, FoundPos: Integer;
  Opt: TSearchTypes;
begin
if frMatchCase in ReplaceDialog1.Options then
  Opt:=[stMatchCase];
if frWholeWord in ReplaceDialog1.Options then
  Opt:=Opt+[stWholeWord];
StartPos:=RichEdit1.SelStart+RichEdit1.SelLength;
ToPos:=Length(RichEdit1.Text)-StartPos;
FoundPos:=RichEdit1.FindText(ReplaceDialog1.FindText, StartPos, ToPos, Opt);
if FoundPos<>-1 then
begin
  RichEdit1.SelStart:=FoundPos;
  RichEdit1.SelLength:=Length(ReplaceDialog1.FindText);
  RichEdit1.SetFocus;
end
else
  MessageBox(ReplaceDialog1.Handle, 'Поиск завершён!', '', MB_ICONINFORMATION);
end;

procedure TForm1.ReplaceDialog1Replace(Sender: TObject);
var
  i, StartPos, ToPos, FoundPos: Integer;
  Opt: TSearchTypes;
begin
if frMatchCase in ReplaceDialog1.Options then
  Opt:=[stMatchCase];
if frWholeWord in ReplaceDialog1.Options then
  Opt:=Opt+[stWholeWord];
  i:=0;
repeat
  StartPos:=RichEdit1.SelStart+RichEdit1.SelLength;
  ToPos:=Length(RichEdit1.Text)-StartPos;
  FoundPos:=RichEdit1.FindText(ReplaceDialog1.FindText, StartPos, ToPos, Opt);
if FoundPos<>-1 then
begin
  RichEdit1.SelStart:=FoundPos;
  RichEdit1.SelLength:=Length(ReplaceDialog1.FindText);
  RichEdit1.SelText:=ReplaceDialog1.ReplaceText;
  RichEdit1.SetFocus;
  inc(i);
end;
until (FoundPos=-1) or not(frReplaceAll in ReplaceDialog1.Options);
if i=0 then
  MessageBox(ReplaceDialog1.Handle, 'Поиск завершён!', '', MB_ICONINFORMATION)
else
if frReplaceAll in ReplaceDialog1.Options then
  ShowMessage('Произведено '+IntToStr(i)+' замен');
end;

end.
