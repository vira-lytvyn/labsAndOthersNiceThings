unit Crossword_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Menus, ImgList, StdActns, ActnList, StdCtrls,
  Grids, ExtCtrls, StrUtils, Crossword_DM, Crossword_Login, DBGrids, DB, DBCtrls,
  Buttons, DBXpress, Crossword_Variants, Crossword_Print;

type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    ilMain: TImageList;
    mmiFile: TMenuItem;
    mmiFileOpen: TMenuItem;
    mmiFileSave: TMenuItem;
    N1: TMenuItem;
    mmiFileExit: TMenuItem;
    tlbrMain: TToolBar;
    tbtnNew: TToolButton;
    tbtnOpen: TToolButton;
    tbtnSave: TToolButton;
    mmiFileNew: TMenuItem;
    tbtnExit: TToolButton;
    alMain: TActionList;
    FileExit: TFileExit;
    FileNew: TAction;
    FileOpen: TFileOpen;
    FileSave: TFileSaveAs;
    pcMain: TPageControl;
    tsCrossword: TTabSheet;
    tsDics: TTabSheet;
    sgCrossword: TStringGrid;
    pnlTopics: TPanel;
    cbAllTopics: TCheckBox;
    dsTopics: TDataSource;
    dbgTopics: TDBGrid;
    dbnTopics: TDBNavigator;
    sbDelTopic: TSpeedButton;
    edTopic: TEdit;
    sbAddTopic: TSpeedButton;
    sbEditTopic: TSpeedButton;
    pnlWords: TPanel;
    sbDelWord: TSpeedButton;
    sbAddWord: TSpeedButton;
    sbEditWord: TSpeedButton;
    dbgWords: TDBGrid;
    dbnWords: TDBNavigator;
    edWord: TEdit;
    dsWords: TDataSource;
    cbxTopics: TComboBox;
    edDescr: TEdit;
    laSearch: TLabel;
    edSearch: TEdit;
    btnLoad: TButton;
    dlgOpen: TOpenDialog;
    pnlCrossword: TPanel;
    laedSizeH: TLabeledEdit;
    updnSizeH: TUpDown;
    laedSizeV: TLabeledEdit;
    updnSizeV: TUpDown;
    sgWordsV: TStringGrid;
    sgWordsH: TStringGrid;
    FilePrint: TFilePrintSetup;
    N2: TMenuItem;
    tlbtnPrint: TToolButton;
    procedure FilePrintAccept(Sender: TObject);
    procedure FileOpenBeforeExecute(Sender: TObject);
    procedure FileOpenAccept(Sender: TObject);
    procedure FileSaveAccept(Sender: TObject);
    procedure sgWordsHKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgWordsHDblClick(Sender: TObject);
    procedure sgWordsHMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure updnSizeVClick(Sender: TObject; Button: TUDBtnType);
    procedure updnSizeHClick(Sender: TObject; Button: TUDBtnType);
    procedure btnLoadClick(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure sbEditWordClick(Sender: TObject);
    procedure sbAddWordClick(Sender: TObject);
    procedure sbDelWordClick(Sender: TObject);
    procedure tsDicsEnter(Sender: TObject);
    procedure dsWordsDataChange(Sender: TObject; Field: TField);
    procedure cbAllTopicsClick(Sender: TObject);
    procedure sbEditTopicClick(Sender: TObject);
    procedure sbAddTopicClick(Sender: TObject);
    procedure sbDelTopicClick(Sender: TObject);
    procedure dsTopicsDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgCrosswordMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sgCrosswordMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sgCrosswordDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FileNewExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    AllowSizeChanging: Boolean;
    function WordLength(Vert: Boolean; CurCol, CurRow: integer): byte;
    procedure SetNumbers;
    function ExtractField(s: string; fDelim: char): string;
    procedure MakeWordsList(Vert: Boolean; CurList: TStringGrid);
    procedure InsertWord(Horizontal: Boolean; wNum, wWord: string);
    procedure InsertChar(CurList: TStringGrid; CharPos: byte;
                         wNum: string; wChar: Char);
    procedure DelWord(Horizontal: Boolean; wNum, wWord: string; cRow: integer);
    function DeleteChar(CurList: TStringGrid;
                        wNum: string; CharPos: byte): Boolean;
    function CountWords: integer;
    procedure SaveGrid(var F: TextFile; CurGrid: TStringGrid);
    procedure SavingWithConfirm(s: string);
    procedure FillWordsDescr(CurList: TStringGrid; s: string);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

function TfmMain.CountWords: integer;
var i: integer;
begin
  Result := 0;
  for i := 1 to sgWordsH.RowCount - 1 do
    if (pos('*', sgWordsH.Cells[1, i]) = 0) and
       (sgWordsH.Cells[1, i] <> '') then Inc(Result);
  for i := 1 to sgWordsV.RowCount - 1 do
    if (pos('*', sgWordsV.Cells[1, i]) = 0) and
       (sgWordsV.Cells[1, i] <> '') then Inc(Result);
end;

procedure TfmMain.sgCrosswordDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var CurNumber: integer;
    CurLetter: Char;
begin
  with sgCrossword, Canvas do
  begin
    if Cells[ACol, ARow] = '_'
      then Brush.Color := clGray
      else Brush.Color := clWhite;
    FillRect(Rect);
    if Cells[ACol, ARow] <> '_' then
    begin
      CurNumber := StrToInt(Copy(Cells[ACol, ARow], 1, 3));
      if Length(Cells[ACol, ARow]) < 4
        then CurLetter := ' '
        else CurLetter := Copy(Cells[ACol, ARow], 4, 1)[1];
      Font.Size := 12;
      TextOut(Rect.Left + 10, Rect.Top + 6, CurLetter);
      if CurNumber <> 0
      then begin
        Font.Size := 6;
        TextOut(Rect.Left + 1, Rect.Top + 1, IntToStr(CurNumber));
      end;
    end;
  end;
end;

procedure TfmMain.sgCrosswordMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  sgCrosswordMouseMove(Sender, Shift, X, Y);
end;

procedure TfmMain.sgCrosswordMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var CurCol, CurRow: integer;
    WasChanged: Boolean;
begin
  WasChanged := False;
  if AllowSizeChanging then
  with sgCrossword do
  begin
    MouseToCell(X, Y, CurCol, CurRow);
    if (CurCol > -1) and (CurRow > -1)
    then begin
      if Shift = [ssLeft] then
        if Cells[CurCol, CurRow] = '_'
        then begin
          Cells[CurCol, CurRow] := '000';
          WasChanged := True;
        end;
      if Shift = [ssRight] then
        if Length(Cells[CurCol, CurRow]) < 4
        then begin
          Cells[CurCol, CurRow] := '_';
          WasChanged := True;
        end;
    end;
  end;
  if WasChanged then SetNumbers;
end;

procedure TfmMain.InsertChar(CurList: TStringGrid; CharPos: byte;
                             wNum: string; wChar: Char);
var n: integer;
begin
  with CurList do
  begin
    n := Cols[0].IndexOf(wNum);
    if n > - 1 then
      if copy(Cells[1, n], CharPos, 1) = '*' then
        Cells[1, n] := StuffString(Cells[1, n], CharPos, 1, wChar);
  end;
end;

procedure TfmMain.InsertWord(Horizontal: Boolean; wNum, wWord: string);
var i, j, c, x, CharPos: integer;
begin
  with sgCrossword do
    for j := 0 to RowCount - 1 do
      for i := 0 to ColCount - 1 do
        if LeftStr(Cells[i, j], 3) = wNum
        then begin
          for c := 1 to Length(wWord) do
            if Horizontal
              then begin
                Cells[i + c - 1, j] :=
                  StuffString(Cells[i + c - 1, j], 4, 1, wWord[c]);
                x := j;
                CharPos := 0;
                while Cells[i + c - 1, x] <> '_' do
                begin
                  Dec(x);
                  Inc(CharPos);
                  if x = -1 then Break;
                end;
                InsertChar(sgWordsV, CharPos,
                           LeftStr(Cells[i + c - 1, x + 1], 3), wWord[c]);
              end
              else begin
                Cells[i, j + c - 1] :=
                  StuffString(Cells[i, j + c - 1], 4, 1, wWord[c]);
                x := i;
                CharPos := 0;
                while Cells[x, j + c - 1] <> '_' do
                begin
                  Dec(x);
                  Inc(CharPos);
                  if x = -1 then Break;
                end;
                InsertChar(sgWordsH, CharPos,
                           LeftStr(Cells[x + 1, j + c - 1], 3), wWord[c]);
              end;
          Break;
        end;
  FileSave.Enabled := True;
  if CountWords = (sgWordsH.RowCount + sgWordsV.RowCount - 2)
  then ShowMessage('Поздравляем! Кроссворд заполнен!');
end;

function TfmMain.DeleteChar(CurList: TStringGrid;
                            wNum: string; CharPos: byte): Boolean;
var n: integer;
begin
  with CurList do
  begin
    n := Cols[0].IndexOf(wNum);
    if n = - 1
      then Result := True
      else
        if pos('*', Cells[1, n]) = 0
          then Result := False
          else begin
            Cells[1, n] := StuffString(Cells[1, n], CharPos, 1, '*');
            Cells[2, n] := '';
            Cells[3, n] := '';
            Result := True;
          end;
  end;
end;

procedure TfmMain.DelWord(Horizontal: Boolean; wNum, wWord: string; cRow: integer);
var i, j, c, x, CharPos: integer;
begin
  with sgCrossword do
    for j := 0 to RowCount - 1 do
      for i := 0 to ColCount - 1 do
        if LeftStr(Cells[i, j], 3) = wNum
        then begin
          for c := 1 to Length(wWord) do
            if Horizontal
              then begin
                x := j;
                CharPos := 0;
                while Cells[i + c - 1, x] <> '_' do
                begin
                  Dec(x);
                  Inc(CharPos);
                  if x = -1 then Break;
                end;
                if DeleteChar(sgWordsV, LeftStr(Cells[i + c - 1, x + 1], 3),
                              CharPos)
                then begin
                  Cells[i + c - 1, j] := LeftStr(Cells[i + c - 1, j], 3);
                  sgWordsH.Cells[1, cRow] :=
                    StuffString(sgWordsH.Cells[1, cRow], c, 1, '*');
                  sgWordsH.Cells[2, cRow] := '';
                  sgWordsH.Cells[3, cRow] := '';
                end;
              end
              else begin
                x := i;
                CharPos := 0;
                while Cells[x, j + c - 1] <> '_' do
                begin
                  Dec(x);
                  Inc(CharPos);
                  if x = -1 then Break;
                end;
                if DeleteChar(sgWordsH, LeftStr(Cells[x + 1, j + c - 1], 3),
                              CharPos)
                then begin
                  Cells[i, j + c - 1] := LeftStr(Cells[i, j + c - 1], 3);
                  sgWordsV.Cells[1, cRow] :=
                    StuffString(sgWordsV.Cells[1, cRow], c, 1, '*');
                  sgWordsV.Cells[2, cRow] := '';
                  sgWordsV.Cells[3, cRow] := '';
                end;
              end;
          Break;
        end;
  AllowSizeChanging := (CountWords = 0);
  FileSave.Enabled := True;
end;

procedure TfmMain.sgWordsHDblClick(Sender: TObject);
begin
  with Sender as TStringGrid do
    if pos('*', Cells[1, Row]) > 0
    then begin
      fmVariants := TfmVariants.Create(nil);
      fmVariants.lblMask.Caption := Cells[1, Row];
      if fmVariants.ShowModal = mrOk
      then begin
        Cells[1,Row] :=
          fmVariants.sgVariants.Cells[0, fmVariants.sgVariants.Row];
        Cells[2,Row] :=
          fmVariants.sgVariants.Cells[1, fmVariants.sgVariants.Row];
        Cells[3,Row] :=
          fmVariants.sgVariants.Cells[2, fmVariants.sgVariants.Row];
        AllowSizeChanging := False;
        InsertWord(Sender = sgWordsH, Cells[0,Row], Cells[1,Row]);
      end;
      fmVariants.Free;
    end; 
end;

procedure TfmMain.sgWordsHKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Return then sgWordsHDblClick(Sender);
  if Key = vk_Delete then
    with Sender as TStringGrid do
    if pos('*', Cells[1, Row]) = 0 then
      if MessageDlg('Удалить из кроссворда слово "' + Cells[1, Row] + '" ?',
                    mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then DelWord(Sender = sgWordsH, Cells[0, Row], Cells[1, Row], Row);
end;

procedure TfmMain.sgWordsHMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var CurCol, CurRow: integer;
begin
  with Sender as TStringGrid do
  begin
    MouseToCell(X, Y, CurCol, CurRow);
    if (CurCol > -1) and (CurRow > -1) then Hint := Cells[3, CurRow];
  end;
end;

procedure TfmMain.tsDicsEnter(Sender: TObject);
begin
  DM.WordsByTopic(cbAllTopics.Checked, DM.sidsTopics.Fields[1].AsString);
  DM.FillTopicsList(True);
end;

procedure TfmMain.updnSizeHClick(Sender: TObject; Button: TUDBtnType);
var i: integer;
begin
  if AllowSizeChanging then
    with sgCrossword do
    begin
      if Button = btPrev
        then ColCount := ColCount - 1
        else begin
          ColCount := ColCount + 1;
          for i := 0 to RowCount - 1 do Cells[ColCount - 1, i] := '_';
        end;
      laedSizeH.Text := IntToStr(updnSizeH.Position);
      SetNumbers;
    end;
end;

procedure TfmMain.updnSizeVClick(Sender: TObject; Button: TUDBtnType);
var i: integer;
begin
  if AllowSizeChanging then
    with sgCrossword do
    begin
      if Button = btPrev
        then RowCount := RowCount - 1
        else begin
          RowCount := RowCount + 1;
          for i := 0 to ColCount - 1 do Cells[i, RowCount - 1] := '_';
        end;
      laedSizeV.Text := IntToStr(updnSizeV.Position);
      SetNumbers;
    end;
end;

function TfmMain.WordLength(Vert: Boolean; CurCol, CurRow: integer): byte;
var i: byte;
begin
  with sgCrossword do
  begin
    Result := 0;
    if Vert then
      for i := CurRow to RowCount - 1 do
      begin
        if Cells[CurCol, i] = '_' then Break;
        Inc(Result);
      end;
    if not Vert then
      for i := CurCol to ColCount - 1 do
      begin
        if Cells[i, CurRow] = '_' then Break;
        Inc(Result);
      end;
  end;
end;

procedure TfmMain.MakeWordsList(Vert: Boolean; CurList: TStringGrid);
var i, j, c: integer;
begin
  CurList.RowCount := 2;
  CurList.Rows[1].Clear;
  for j := 0 to sgCrossword.RowCount - 1 do
    for i := 0 to sgCrossword.ColCount - 1 do
      if (sgCrossword.Cells[i, j] <> '_') and
         (LeftStr(sgCrossword.Cells[i, j], 3) <> '000')
      then begin
        c := WordLength(Vert, i, j);
        if c > 2 then
          if (Vert and
              ((j = 0) or
               (j > 0) and (sgCrossword.Cells[i, j-1] = '_'))) or
             (not Vert
              and ((i = 0) or
                   (i > 0) and (sgCrossword.Cells[i-1, j] = '_')))
          then with CurList do
               begin
                 Cells[0, RowCount - 1] := LeftStr(sgCrossword.Cells[i, j], 3);
                 Cells[1, RowCount - 1] := DupeString('*', c);
                 Cells[2, RowCount - 1] := '';
                 Cells[3, RowCount - 1] := '';
                 RowCount := RowCount + 1;
               end;
      end;
  if CurList.RowCount > 2 then
    CurList.RowCount := CurList.RowCount - 1;
end;

procedure TfmMain.SetNumbers;
var i, j, c: integer;
    IsNumber: Boolean;
begin
  with sgCrossword do
  begin
    c := 0;
    IsNumber := False;
    for j := 0 to RowCount - 1 do
      for i := 0 to ColCount - 1 do
        if Cells[i, j] <> '_'
        then begin
           IsNumber := ((i = 0) and (WordLength(False, i, j) > 2)) or
                       ((j = 0) and (WordLength(True, i, j) > 2));
           if not IsNumber then
             if i > 0 then
               IsNumber := (Cells[i - 1, j] = '_') and
                           (WordLength(False, i, j) > 2);
           if not IsNumber then
             if j > 0 then
               IsNumber := (Cells[i, j - 1] = '_') and
                           (WordLength(True, i, j) > 2);
           if IsNumber
           then begin
             Inc(c);
             if c < 10 then Cells[i,j] := '00' + IntToStr(c) else
               if c < 100
               then Cells[i,j] := '0' + IntToStr(c)
               else Cells[i,j] := IntToStr(c);
           end else Cells[i,j] := '000';
        end;
    MakeWordsList(True, sgWordsV);
    MakeWordsList(False, sgWordsH);
    FileSave.Enabled := True;
  end;
end;

function TfmMain.ExtractField(s: string; fDelim: char): string;
begin
  if pos(fDelim, s) = 0
    then Result := ''
    else begin
      s := copy(s, pos(fDelim, s), Length(s) - pos(fDelim, s) + 1);
      Delete(s, 1, 1);
      Result := copy(s, 1, pos(fDelim, s) - 1);
    end;
end;

procedure TfmMain.btnLoadClick(Sender: TObject);
var F: TextFile;
    s: string;
    TopicName: string[30];
    TopicID: integer;
    Descr: string[50];
    TD: TTRansactionDesc;
    cOfWords, cOfNewT, cOfNewW: integer;
begin
  TD.TransactionID := 1;
  TD.IsolationLevel := xilREADCOMMITTED;
  if dlgOpen.Execute
  then begin
    cOfWords := 0;
    cOfNewT := 0;
    cOfNewW := 0;
    if DM.TopicIDByName('Без темы') = 0
    then begin
      try
        DM.sqlcDict.StartTransaction(TD);
        DM.sspAddTopic.ParamByName('pTopicName').Value := 'Без темы';
        DM.sspAddTopic.ExecProc;
        DM.sqlcDict.Commit(TD);
        DM.FillTopicsList(True);
        Inc(cOfNewT);
      except
        on E: Exception do
        begin
          DM.sqlcDict.Rollback(TD);
          MessageDlg('Ошибка создания тематики "Без темы"!' + #13 +
                     E.Message, mtError, [mbOk], 0);
        end;
      end;
    end;
    Screen.Cursor := crHourGlass;
    AssignFile(F, dlgOpen.FileName);
    Reset(F);
    while not EOF(F) do
    begin
      Readln(F, s);
      inc(cOfWords);
      btnLoad.Caption := 'Просмотр: ' + IntToStr(COfWords);
      Refresh;
      TopicName := ExtractField(s, '#');
      if TopicName = '' then TopicName := 'Без темы';
      TopicID := DM.TopicIDByName(TopicName);
      Descr := ExtractField(s, '^');
      if pos('#', s) > 0 then
        Delete(s, pos('#' + TopicName + '#', s), Length(TopicName) + 2);
      if pos('^', s) > 0 then
        Delete(s, pos('^' + Descr + '^', s), Length(Descr) + 2);
      try
        if TopicID = 0
        then begin
          DM.sqlcDict.StartTransaction(TD);
          DM.sspAddTopic.ParamByName('pTopicName').Value := TopicName;
          DM.sspAddTopic.ExecProc;
          DM.sqlcDict.Commit(TD);
          DM.FillTopicsList(True);
          Inc(cOfNewT);
        end;
        TopicID := DM.TopicIDByName(TopicName);
        if not DM.FindWord(TopicID, AnsiUpperCase(s))
        then begin
          cbxTopics.ItemIndex := cbxTopics.Items.IndexOf(TopicName);
          edWord.Text := AnsiUpperCase(s);
          edDescr.Text := Descr;
          DM.sqlcDict.StartTransaction(TD);
          DM.SetWordParams(DM.sspAddWord);
          DM.sspAddWord.ExecProc;
          DM.sqlcDict.Commit(TD);
          Inc(cOfNewW);
        end;
      except
        on E: Exception do
        begin
          Screen.Cursor := crDefault;
          DM.sqlcDict.Rollback(TD);
          MessageDlg('Ошибка операции!' + #13 +
                     E.Message, mtError, [mbOk], 0);
          Screen.Cursor := crHourGlass;
        end;
      end;
    end;
    CloseFile(F);
    btnLoad.Caption := 'Загрузить из файла';
    Screen.Cursor := crDefault;
    DM.sidsTopics.CancelUpdates;
    DM.sidsTopics.Refresh;
    DM.WordsByTopic(cbAllTopics.Checked, DM.sidsTopics.Fields[1].AsString);
    MessageDlg('Просмотрено слов - ' + IntToStr(cOfWords) + '.' + #13 +
               'Дополнения: ' + #13 +
               '  тематики - ' + IntToStr(cOfNewT) + ';' + #13 +
               '  слова - ' + IntToStr(cOfNewW),
               mtInformation, [mbOK], 0);
  end;
end;

procedure TfmMain.cbAllTopicsClick(Sender: TObject);
begin
  DM.WordsByTopic(cbAllTopics.Checked, DM.sidsTopics.Fields[1].AsString);
end;

procedure TfmMain.dsTopicsDataChange(Sender: TObject; Field: TField);
begin
  edTopic.Text := dbgTopics.Fields[0].AsString;
  if not cbAllTopics.Checked then
    DM.WordsByTopic(False, DM.sidsTopics.Fields[1].AsString);
end;

procedure TfmMain.dsWordsDataChange(Sender: TObject; Field: TField);
begin
  cbxTopics.ItemIndex :=
    cbxTopics.Items.IndexOf(DM.sidsWords.FieldByName('TOPIC_NAME').AsString);
  edWord.Text := DM.CurrentWord;
  edDescr.Text := DM.sidsWords.FieldByName('WORD_DESCR').AsString;
end;

procedure TfmMain.edSearchChange(Sender: TObject);
begin
  DM.sidsWords.Locate('WORD_C01;WORD_C02;WORD_C03;'+
                      'WORD_C04;WORD_C05;WORD_C06;WORD_C07;'+
                      'WORD_C08;WORD_C09;WORD_C10;WORD_C11;'+
                      'WORD_C12;WORD_C13;WORD_C14;WORD_C15',
                      VarArrayOf([copy(edSearch.Text, 1, 1),
                                  copy(edSearch.Text, 2, 1),
                                  copy(edSearch.Text, 3, 1),
                                  copy(edSearch.Text, 4, 1),
                                  copy(edSearch.Text, 5, 1),
                                  copy(edSearch.Text, 6, 1),
                                  copy(edSearch.Text, 7, 1),
                                  copy(edSearch.Text, 8, 1),
                                  copy(edSearch.Text, 9, 1),
                                  copy(edSearch.Text, 10, 1),
                                  copy(edSearch.Text, 11, 1),
                                  copy(edSearch.Text, 12, 1),
                                  copy(edSearch.Text, 13, 1),
                                  copy(edSearch.Text, 14, 1),
                                  copy(edSearch.Text, 15, 1)]),
                      [loCaseInsensitive]);
end;

procedure TfmMain.FileNewExecute(Sender: TObject);
var i, j: integer;
begin
  SavingWithConfirm('созданием нового кроссворда');
  with sgCrossword do
  begin
    RowCount := 15;
    ColCount := 15;
    for i := 0 to ColCount - 1 do
      for j := 0 to RowCount - 1 do Cells[i, j] := '_';
    laedSizeH.Text := '15';
    laedSizeV.Text := '15';
    updnSizeH.Position := 15;
    updnSizeV.Position := 15;
    SetNumbers;
  end;
  AllowSizeChanging := True;
  FileSave.Enabled := False;
end;

procedure TfmMain.SavingWithConfirm(s: string);
begin
  if FileSave.Enabled then
    if MessageDlg('Есть несохраненные изменения!' +#13 +
                  'Сохранить их перед ' + s + '?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then FileSave.Execute;
end;

procedure TfmMain.FileOpenAccept(Sender: TObject);
var F: TextFile;
    s: string;
    CurGrid: TStringGrid;
    c, i, j: integer;
begin
  AssignFile(F, FileOpen.Dialog.FileName);
  Reset(F);
  for c := 1 to 3 do
  begin
    Readln(F, s);
    if s = 'sgCrossword' then CurGrid := sgCrossword;
    if s = 'sgWordsH' then CurGrid := sgWordsH;
    if s = 'sgWordsV' then CurGrid := sgWordsV;
    Readln(F, s);
    CurGrid.RowCount := StrToInt(s);
    Readln(F, s);
    CurGrid.ColCount := StrToInt(s);
    for j := 0 to CurGrid.RowCount - 1 do
    begin
      Readln(F, s);
      for i := 0 to CurGrid.ColCount do
      begin
        CurGrid.Cells[i, j] := copy(s, 1, pos('^', s) - 1);
        Delete(s, 1, pos('^', s));
      end;
    end;
  end;
  CloseFile(F);
  FileSave.Enabled := False;
  AllowSizeChanging := (CountWords = 0);
end;

procedure TfmMain.FileOpenBeforeExecute(Sender: TObject);
begin
  SavingWithConfirm('открытием другого кроссворда');
end;

procedure TfmMain.FillWordsDescr(CurList: TStringGrid; s: string);
var i: integer;
    dLine: string;
begin
  with fmPrint.redPrint, CurList do
  begin
    Lines.Add('');
    SelAttributes.Style := [fsBold];
    Lines.Add(s);
    SelAttributes.Style := [];
    dLine := '';
    for i := 1 to RowCount - 1 do
      dLine := dLine + IntToStr(StrToInt(Cells[0, i])) +
               '. ' + Cells[3, i] + '. ';
    Lines.Add(dLine);
  end;
end;

procedure TfmMain.FilePrintAccept(Sender: TObject);
var i: integer;
begin
  fmPrint := TfmPrint.Create(nil);
  with fmPrint, sgPrint do
  begin
    RowCount := sgCrossword.RowCount;
    ColCount := sgCrossword.ColCount;
    for i := 0 to ColCount - 1 do
      Cols[i].Assign(sgCrossword.Cols[i]);
    FillWordsDescr(sgWordsH, 'По горизонтали:');
    FillWordsDescr(sgWordsV, 'По вертикали:');
    ShowModal;
  end;
  fmPrint.Free;
end;

procedure TfmMain.SaveGrid(var F: TextFile; CurGrid: TStringGrid);
var i, j: integer;
    s: string;
begin
  with CurGrid do
  begin
    Writeln(F, Name);
    Writeln(F, RowCount);
    Writeln(F, ColCount);
    for j := 0 to RowCount - 1 do
    begin
      s := '';
      for i := 0 to ColCount do
        s := s + Cells[i, j] + '^';
      Writeln(F, s);
    end;
  end;
end;

procedure TfmMain.FileSaveAccept(Sender: TObject);
var F: TextFile;
begin
  AssignFile(F, FileSave.Dialog.FileName);
  Rewrite(F);
  SaveGrid(F, sgCrossword);
  SaveGrid(F, sgWordsH);
  SaveGrid(F, sgWordsV);
  CloseFile(F);
  FileSave.Enabled := False;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.sqlcDict.Close;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SavingWithConfirm('выходом из программы');
  CanClose :=  MessageDlg('Выйти из программы?', mtConfirmation,
                          [mbYes, mbNo], 0) = mrYes;
end;

procedure TfmMain.FormResize(Sender: TObject);
begin
  sgWordsV.Height := (pnlCrossword.Height - 60) div 2;
  sgWordsH.Height := sgWordsV.Height;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  DM.sidsTopics.Open;
  dbgTopics.Fields[0].Visible := False;
  tbtnNew.Click;
  with sgWordsV do
  begin
    Cells[0,0] := '№';
    Cells[1,0] := 'Слова по вертикали';
    Cells[2,0] := 'Тематика';
    Cells[3,1] := 'Описание';
  end;
  with sgWordsH do
  begin
    Cells[0,0] := '№';
    Cells[1,0] := 'Слова по горизонтали';
    Cells[2,0] := 'Тематика';
  end;
end;

procedure TfmMain.pcMainChange(Sender: TObject);
begin
  if pcMain.TabIndex = 0
    then sgWordsH.SetFocus
    else dbgWords.SetFocus;
end;

procedure TfmMain.sbAddTopicClick(Sender: TObject);
begin
  if DM.TopicIDByName(edTopic.Text) = 0
    then DM.Perform(AddTopic)
    else ShowMessage('Такая тематика уже существует!');
end;

procedure TfmMain.sbAddWordClick(Sender: TObject);
begin
  DM.Perform(AddWord);
end;

procedure TfmMain.sbDelTopicClick(Sender: TObject);
begin
  if MessageDlg('Удалить тематику "' +
                DM.sidsTopics.Fields[1].AsString +'" ?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes
  then DM.Perform(DeleteTopic);
end;

procedure TfmMain.sbDelWordClick(Sender: TObject);
begin
  if MessageDlg('Удалить слово "' + DM.CurrentWord + '" ?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes
  then DM.Perform(DeleteWord);
end;

procedure TfmMain.sbEditTopicClick(Sender: TObject);
begin
  DM.Perform(EditTopic);
end;

procedure TfmMain.sbEditWordClick(Sender: TObject);
begin
  DM.Perform(EditWord);
end;

end.
