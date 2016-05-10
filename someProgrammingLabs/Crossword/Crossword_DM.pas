unit Crossword_DM;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, Dialogs, Registry, DBClient,
  SimpleDS, FMTBcd, Variants;

type
  TOpType = (DeleteTopic, AddTopic, EditTopic,
             DeleteWord, AddWord, EditWord);

  TDM = class(TDataModule)
    sqlcDict: TSQLConnection;
    dlgOpen: TOpenDialog;
    sidsTopics: TSimpleDataSet;
    sspDelTopic: TSQLStoredProc;
    sspFindTopic: TSQLStoredProc;
    sspAddTopic: TSQLStoredProc;
    sspEditTopic: TSQLStoredProc;
    sidsWords: TSimpleDataSet;
    sspDelWord: TSQLStoredProc;
    sspAddWord: TSQLStoredProc;
    sspEditWord: TSQLStoredProc;
    sqlqTopics: TSQLQuery;
    sidsFindWord: TSimpleDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WriteStrParam(sName, sValue: string);
    function ReadStrParam(sName: string): string;
    procedure Perform(opType: TopType);
    function TopicIDByName(tName: string): integer;
    procedure WordsByTopic(FullList: Boolean; tName: string);
    procedure FillTopicsList(withLocate: Boolean);
    procedure SetWordParams(curSP: TSQLStoredProc);
    function CurrentWord: string;
    function FindWord(TopicID: integer; CharMask: string): boolean;
  end;


var
  DM: TDM;

implementation
uses Crossword_Main;

{$R *.dfm}

function TDM.FindWord(TopicID: integer; CharMask: string): boolean;
var i: byte;
    c: string[1];
    s: string;
begin
  with sidsFindWord do
  begin
    Close;
    s := 'SELECT * FROM WORDS WHERE WORD_TOPIC = ' +
         IntToStr(TopicID);
    for i := 1 to Length(CharMask) do
    begin
      c := copy(CharMask, i, 1);
      if c = '*' then
        if i < 10
          then s := s + ' AND WORD_C0' + IntToStr(i) + ' <> ' + #39 + #39
          else s := s + ' AND WORD_C' + IntToStr(i) + ' <> ' + #39 + #39;
      if c <> '*' then
        if i < 10
          then s := s + ' AND WORD_C0' + IntToStr(i) + ' = ' + #39 + c + #39
          else s := s + ' AND WORD_C' + IntToStr(i) + ' = ' + #39 + c + #39;
    end;
    for i := (Length(CharMask) + 1) to 15 do
      if i < 10
        then s := s + ' AND WORD_C0' + IntToStr(i) + ' = ' + #39 + #39
        else s := s + ' AND WORD_C' + IntToStr(i) + ' = ' + #39 + #39;
    DataSet.CommandText := s;
    Open;
    Result := not Fields[0].IsNull;
  end;
end;

function TDM.CurrentWord: string;
var i: byte;
begin
  Result := '';
  for i := 1 to 15 do
    if i < 10
      then Result := Result + sidsWords.FieldByName('WORD_C0' + IntToStr(i)).AsString
      else Result := Result + sidsWords.FieldByName('WORD_C' + IntToStr(i)).AsString;
end;

procedure TDM.FillTopicsList(withLocate: Boolean);
begin
  with fmMain.cbxTopics, sqlqTopics do
  begin
    Items.Clear;
    Open;
    while not EOF do
    begin
      Items.Add(Fields[0].AsString);
      Next;
    end;
    Close;
    if withLocate then
      ItemIndex := Items.IndexOf(sidsWords.FieldByName('TOPIC_NAME').AsString);
  end;
end;

procedure TDM.WordsByTopic(FullList: Boolean; tName: string);
begin
  with sidsWords do
  begin
    Close;
    DataSet.CommandText := 'SELECT * FROM FULLWORDS_VIEW';
    if not FullList then
      DataSet.CommandText := DataSet.CommandText +
                             ' WHERE TOPIC_NAME = ' + #39 + tName + #39;
    DataSet.CommandText := DataSet.CommandText +
                           ' ORDER BY TOPIC_NAME, WORD_C01, WORD_C02, ' +
                           'WORD_C03, WORD_C04, WORD_C05, WORD_C06, ' +
                           'WORD_C07, WORD_C08, WORD_C09, WORD_C10';
    Open;
    Fields[0].Visible := False;
  end;
end;

function TDM.TopicIDByName(tName: string): integer;
begin
  with sspFindTopic do
  begin
    ParamByName('pTopicName').Value := tName;
    ParamByName('rTopicID').Value := 0;
    ExecProc;
    Result := ParamByName('rTopicID').AsInteger;
  end;
end;

procedure TDM.SetWordParams(CurSP: TSQLStoredProc);
var i: byte;
begin
  with CurSP do
  begin
    ParamByName('pWordTopic').Value := TopicIDByName(fmMain.cbxTopics.Text);
    for i := 1 to 15 do
      if i < 10
        then ParamByName('pWordC0' + IntToStr(i)).Value :=
               copy(fmMain.edWord.Text, i, 1)
        else ParamByName('pWordC' + IntToStr(i)).Value :=
               copy(fmMain.edWord.Text, i, 1);
    ParamByName('pWordDescr').Value := fmMain.edDescr.Text;
  end;
end;

procedure TDM.Perform(opType: TOpType);
var TD: TTRansactionDesc;
    buf: Variant;
begin
  TD.TransactionID := 1;
  TD.IsolationLevel := xilREADCOMMITTED;
  sqlcDict.StartTransaction(TD);
  try
    case opType of
      DeleteTopic: begin
                     sspDelTopic.ParamByName('pTopicID').Value :=
                       sidsTopics.Fields[0].Value;
                     sspDelTopic.ExecProc;
                     sidsTopics.Delete;
                     FillTopicsList(True);
                   end;
      AddTopic: begin
                  buf := fmMain.edTopic.Text;
                  sspAddTopic.ParamByName('pTopicName').Value := buf;
                  sspAddTopic.ExecProc;
                  sidsTopics.CancelUpdates;
                  sidsTopics.Refresh;
                  sidsTopics.Locate('TOPIC_NAME', buf, [loCaseInsensitive]);
                  FillTopicsList(True);
                end;
      EditTopic: begin
                   buf := fmMain.edTopic.Text;
                   sspEditTopic.ParamByName('pTopicID').Value :=
                      sidsTopics.Fields[0].AsInteger;
                   sspEditTopic.ParamByName('pTopicName').Value := buf;
                   sspEditTopic.ExecProc;
                   sidsTopics.CancelUpdates;
                   sidsTopics.Refresh;
                   sidsTopics.Locate('TOPIC_NAME', buf, [loCaseInsensitive]);
                   FillTopicsList(True);
                 end;
      DeleteWord: begin
                    sspDelWord.ParamByName('pWordID').Value :=
                       sidsWords.Fields[0].Value;
                    sspDelWord.ExecProc;
                    sidsWords.Delete;
                  end;
      AddWord: begin
                 fmMain.edWord.Text := Trim(fmMain.edWord.Text);
                 fmMain.edDescr.Text := Trim(fmMain.edDescr.Text);
                 buf := VarArrayOf([fmMain.cbxTopics.Text,
                                    copy(fmMain.edWord.Text, 1, 1),
                                    copy(fmMain.edWord.Text, 2, 1),
                                    copy(fmMain.edWord.Text, 3, 1),
                                    copy(fmMain.edWord.Text, 4, 1),
                                    copy(fmMain.edWord.Text, 5, 1),
                                    copy(fmMain.edWord.Text, 6, 1),
                                    copy(fmMain.edWord.Text, 7, 1),
                                    copy(fmMain.edWord.Text, 8, 1),
                                    copy(fmMain.edWord.Text, 9, 1),
                                    copy(fmMain.edWord.Text, 10, 1),
                                    copy(fmMain.edWord.Text, 11, 1),
                                    copy(fmMain.edWord.Text, 12, 1),
                                    copy(fmMain.edWord.Text, 13, 1),
                                    copy(fmMain.edWord.Text, 14, 1),
                                    copy(fmMain.edWord.Text, 15, 1)]);
                 SetWordParams(sspAddWord);
                 sspAddWord.ExecProc;
                 sidsWords.CancelUpdates;
                 sidsWords.Refresh;
                 sidsWords.Locate('TOPIC_NAME;WORD_C01;WORD_C02;WORD_C03;'+
                                  'WORD_C04;WORD_C05;WORD_C06;WORD_C07;'+
                                  'WORD_C08;WORD_C09;WORD_C10;WORD_C11;'+
                                  'WORD_C12;WORD_C13;WORD_C14;WORD_C15',
                                  buf, [loCaseInsensitive]);
               end;
      EditWord: begin
                  fmMain.edWord.Text := Trim(fmMain.edWord.Text);
                  fmMain.edDescr.Text := Trim(fmMain.edDescr.Text);
                  buf := sidsWords.Fields[0].Value;
                  sspEditWord.ParamByName('pWordID').Value := buf;
                  SetWordParams(sspEditWord);
                  sspEditWord.ExecProc;
                  sidsWords.CancelUpdates;
                  sidsWords.Refresh;
                  sidsWords.Locate('WORD_ID', buf, [loCaseInsensitive]);
                end;
    end;
    sqlcDict.Commit(TD);
  except
    on E: Exception do
    begin
      sqlcDict.Rollback(TD);
      MessageDlg('Ошибка операции!' + #13 +
                 E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDM.WriteStrParam(sName, sValue: string);
var Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do
  begin
    OpenKey('Software\Crossword', True);
    WriteString(sName, sValue);
    Closekey;
    Free;
  end;
end;

function TDM.ReadStrParam(sName: string): string;
var Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do
  begin
    OpenKey('Software\Crossword', True);
    Result := ReadString(sName);
    Closekey;
    Free;
  end;
end;

end.
