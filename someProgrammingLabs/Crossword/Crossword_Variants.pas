unit Crossword_Variants;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Crossword_DM, StdCtrls, CheckLst, Grids, Buttons, ExtCtrls;

type
  TfmVariants = class(TForm)
    pnlTopics: TPanel;
    clbTopics: TCheckListBox;
    btnSelectAll: TButton;
    btnDeselectAll: TButton;
    pnlVariants: TPanel;
    pnlControl: TPanel;
    btnSelect: TButton;
    pnlMask: TPanel;
    lblMask: TLabel;
    pnlWord: TPanel;
    lblWord: TLabel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    sgVariants: TStringGrid;
    procedure sgVariantsDblClick(Sender: TObject);
    procedure sgVariantsClick(Sender: TObject);
    procedure sgVariantsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSelectClick(Sender: TObject);
    procedure clbTopicsClickCheck(Sender: TObject);
    procedure btnDeselectAllClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure SelectDeselect(Check: Boolean);
    procedure CheckEnSelect;
    procedure ShowCurrentWord;
  public
    { Public declarations }
  end;

var
  fmVariants: TfmVariants;

implementation
uses Crossword_Main;

{$R *.dfm}

procedure TfmVariants.ShowCurrentWord;
begin
  lblWord.Caption := sgVariants.Cells[0, sgVariants.Row];
  bbtnOK.Enabled := (lblWord.Caption <> '');
end;

procedure TfmVariants.CheckEnSelect;
var i, c: integer;
begin
  c := 0;
  with clbTopics do
    for i := 0 to Items.Count - 1 do
      if Checked[i] then Inc(c);
  btnSelect.Enabled := (c > 0);
end;

procedure TfmVariants.clbTopicsClickCheck(Sender: TObject);
begin
  CheckEnSelect;
end;

procedure TfmVariants.SelectDeselect(Check: Boolean);
var i: integer;
begin
  with clbTopics do
    for i := 0 to Items.Count - 1 do Checked[i] := Check;
  CheckEnSelect;
end;

procedure TfmVariants.sgVariantsClick(Sender: TObject);
begin
  ShowCurrentWord;
end;

procedure TfmVariants.sgVariantsDblClick(Sender: TObject);
begin
  if bbtnOk.Enabled then bbtnOk.Click;
end;

procedure TfmVariants.sgVariantsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ShowCurrentWord;
end;

procedure TfmVariants.btnDeselectAllClick(Sender: TObject);
begin
  SelectDeselect(False);
end;

procedure TfmVariants.btnSelectAllClick(Sender: TObject);
begin
  SelectDeselect(True);
end;

procedure TfmVariants.btnSelectClick(Sender: TObject);
var i: integer;
    CurWord: string[15];
begin
  if Length(lblMask.Caption) > 15
  then ShowMessage('Слово длиннее 15 символов! Отбор невозможен!')
  else begin
    Screen.Cursor := crHourGlass;
    with clbTopics, DM.sidsFindWord, sgVariants do
    begin
      RowCount := 2;
      for i := 0 to Items.Count - 1 do
        if Checked[i]
        then begin
          DM.FindWord(DM.TopicIDByName(Items[i]), lblMask.Caption);
          while not EOF do
          begin
            CurWord := FieldByname('WORD_C01').AsString +
                       FieldByname('WORD_C02').AsString +
                       FieldByname('WORD_C03').AsString +
                       FieldByname('WORD_C04').AsString +
                       FieldByname('WORD_C05').AsString +
                       FieldByname('WORD_C06').AsString +
                       FieldByname('WORD_C07').AsString +
                       FieldByname('WORD_C08').AsString +
                       FieldByname('WORD_C09').AsString +
                       FieldByname('WORD_C10').AsString +
                       FieldByname('WORD_C11').AsString +
                       FieldByname('WORD_C12').AsString +
                       FieldByname('WORD_C13').AsString +
                       FieldByname('WORD_C14').AsString +
                       FieldByname('WORD_C15').AsString;
            if (fmMain.sgWordsH.Cols[1].IndexOf(CurWord) = -1) and
               (fmMain.sgWordsV.Cols[1].IndexOf(CurWord) = -1)
            then begin
              Cells[0, RowCount - 1] := CurWord;
              Cells[1, RowCount - 1] := Items[i];
              Cells[2, RowCount - 1] := FieldByName('WORD_DESCR').AsString;
              RowCount := RowCount + 1;
            end;
            Next;
          end;
        end;
      if RowCount > 2 then RowCount := RowCount - 1;
      ShowCurrentWord;
      Screen.Cursor := crDefault;
      if Cells[0,1] = ''
       then ShowMessage('Слов для заданной маски нет!');
      sgVariants.SetFocus;
    end;
  end;
end;

procedure TfmVariants.FormShow(Sender: TObject);
begin
  DM.FillTopicsList(False);
  clbTopics.Items.Assign(fmMain.cbxTopics.Items);
  btnSelectAll.Click;
  with sgVariants do
  begin
    Cells[0, 0] := 'Слово';
    Cells[1, 0] := 'Тематика';
    Cells[2, 0] := 'Описание';
  end;
end;

end.
