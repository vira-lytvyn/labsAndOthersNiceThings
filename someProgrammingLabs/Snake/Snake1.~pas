unit Snake1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Menus, ExtCtrls, StdCtrls, ImgList, Snake2, Snake3;

type
  TDirections = (ToRight, ToLeft, ToUp, ToDown);

  TSnake = record
    Col: SmallInt;
    Row: SmallInt;
    PrevDir: TDirections;
    CurDir: TDirections;
  end;

  TfmMain = class(TForm)
    sgField: TStringGrid;
    pnlScore: TPanel;
    lblPlayer: TLabel;
    lblRecord: TLabel;
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mmiGameRecords: TMenuItem;
    N3: TMenuItem;
    mmiGameStop: TMenuItem;
    mmiGamePause: TMenuItem;
    mmiGameStart: TMenuItem;
    imglSnake: TImageList;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure mmiGamePauseClick(Sender: TObject);
    procedure mmiGameRecordsClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mmiGameStartClick(Sender: TObject);
    procedure mmiGameStopClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure sgFieldDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AddApple;
    procedure DrawHead(OldHeadPosR, OldHeadPosL,
                       OldHeadPosU, OldHeadPosD: string;
                       TypeOfHead: Char);
    procedure DrawTail(Turn1: string; Tail1: Char; Dir1: TDirections;
                       Turn2: string; Tail2: Char; Dir2: TDirections;
                       TypeOfTail: Char);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

type
  TRecords = record
    Name: String[10];
    Date: TDate;
    Score: Integer;
  end;

  TApple = record
    Col, Row: SmallInt;
  end;

var
  Top10: File of TRecords;
  Top10List: array [1..10] of TRecords;
  Apple: TApple;
  Head, Tail: TSnake;
  EndOfGame: Boolean;

{$R *.dfm}

procedure TfmMain.AddApple;
begin
  with sgField do
  begin
    repeat
      Apple.Col := random(14);
      Apple.Row := random(14);
    until Cells[Apple.Col,Apple.Row] = '';
    Cells[Apple.Col,Apple.Row] := 'Яблоко';
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var MaxScore: Integer;
    FName: String;
    i: Byte;
begin
  FName := ExtractFilePath(Application.ExeName) + 'Top10.dat';
  AssignFile(Top10, FName);
  MaxScore := 0;
  i := 1;
  if not FileExists(FName)
  then Rewrite(Top10)
  else begin
    Reset(Top10);
    while not EOF(Top10) do
    begin
      Read(Top10, Top10List[i]);
      if Top10List[i].Score > MaxScore
        then MaxScore := Top10List[i].Score;
      Inc(i);
    end;
  end;
  CloseFile(Top10);
  lblRecord.Caption := IntToStr(MaxScore);
end;

procedure TfmMain.sgFieldDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var ImgIdx: SmallInt;
begin
  ImgIdx := -1;
  with sgField do
  begin
    if Cells[ACol, ARow] = 'ХвостR' then ImgIdx := 0;
    if Cells[ACol, ARow] = 'ХвостL' then ImgIdx := 1;
    if Cells[ACol, ARow] = 'ХвостU' then ImgIdx := 2;
    if Cells[ACol, ARow] = 'ХвостD' then ImgIdx := 3;
    if Cells[ACol, ARow] = 'ТелоRL' then ImgIdx := 4;
    if Cells[ACol, ARow] = 'ТелоUD' then ImgIdx := 5;
    if Cells[ACol, ARow] = 'ГоловаR1' then ImgIdx := 6;
    if Cells[ACol, ARow] = 'ГоловаR2' then ImgIdx := 7;
    if Cells[ACol, ARow] = 'ГоловаR3' then ImgIdx := 8;
    if Cells[ACol, ARow] = 'ГоловаL1' then ImgIdx := 9;
    if Cells[ACol, ARow] = 'ГоловаL2' then ImgIdx := 10;
    if Cells[ACol, ARow] = 'ГоловаL3' then ImgIdx := 11;
    if Cells[ACol, ARow] = 'ГоловаU1' then ImgIdx := 12;
    if Cells[ACol, ARow] = 'ГоловаU2' then ImgIdx := 13;
    if Cells[ACol, ARow] = 'ГоловаU3' then ImgIdx := 14;
    if Cells[ACol, ARow] = 'ГоловаD1' then ImgIdx := 15;
    if Cells[ACol, ARow] = 'ГоловаD2' then ImgIdx := 16;
    if Cells[ACol, ARow] = 'ГоловаD3' then ImgIdx := 17;
    if Cells[ACol, ARow] = 'ИзгибRD' then ImgIdx := 18;
    if Cells[ACol, ARow] = 'ИзгибLU' then ImgIdx := 19;
    if Cells[ACol, ARow] = 'ИзгибLD' then ImgIdx := 20;
    if Cells[ACol, ARow] = 'ИзгибRU' then ImgIdx := 21;
    if Cells[ACol, ARow] = 'Яблоко' then ImgIdx := 22;
    Canvas.FillRect(Rect);
    if ImgIdx >= 0
      then imglSnake.Draw(Canvas, Rect.Left - 3, Rect.Top - 3, ImgIdx);
  end;
end;

procedure TfmMain.DrawHead(OldHeadPosR, OldHeadPosL,
                           OldHeadPosU, OldHeadPosD: string;
                           TypeOfHead: Char);
var DistToApple: SmallInt;
    InOneLine: Boolean;
begin
  with sgField do
  begin
    //заполняем старую позицию головы
    case Head.PrevDir of
      ToRight: Cells[Head.Col, Head.Row] := OldHeadPosR;
      ToLeft: Cells[Head.Col, Head.Row] := OldHeadPosL;
      ToUp: Cells[Head.Col, Head.Row] := OldHeadPosU;
      ToDown: Cells[Head.Col, Head.Row] := OldHeadPosD;
    end;
    //смещаем голову
    if (Head.CurDir = ToRight) or (Head.CurDir = ToLeft)
    then begin
      if Head.CurDir = ToRight then Inc(Head.Col) else Dec(Head.Col);
      if (Head.CurDir = ToRight) and (Head.Col = ColCount)
        then Head.Col := 0;
      if (Head.CurDir = ToLeft) and (Head.Col = -1)
        then Head.Col := ColCount - 1;
      DistToApple := Abs(Apple.Col - Head.Col);
      InOneLine := Apple.Row = Head.Row;
    end else
    begin
      if Head.CurDir = ToDown then Inc(Head.Row) else Dec(Head.Row);
      if (Head.CurDir = ToDown) and (Head.Row = RowCount)
        then Head.Row := 0;
      if (Head.CurDir = ToUp) and (Head.Row = -1)
        then Head.Row := RowCount - 1;
      DistToApple := Abs(Apple.Row - Head.Row);
      InOneLine := Apple.Col = Head.Col;
    end;
    //рисуем голову
    if (DistToApple = 2) and InOneLine
    then Cells[Head.Col, Head.Row] := 'Голова' + TypeOfHead + '2'
    else if (DistToApple = 1) and InOneLine
         then Cells[Head.Col, Head.Row] := 'Голова' + TypeOfHead + '3'
         else begin
           EndOfGame := (Cells[Head.Col, Head.Row] <> 'Яблоко') and
                        (Cells[Head.Col, Head.Row] <> '');
           Cells[Head.Col, Head.Row] := 'Голова' + TypeOfHead + '1';
         end;
    Head.PrevDir := Head.Curdir;
  end;
end;

procedure TfmMain.DrawTail(Turn1: string; Tail1: Char; Dir1: TDirections;
                           Turn2: string; Tail2: Char; Dir2: TDirections;
                           TypeofTail: Char);
begin
  with sgField do
  begin
    if (Tail.CurDir = ToRight) or (Tail.CurDir = ToLeft)
    then begin
      if Tail.CurDir = ToRight then Inc(Tail.Col) else Dec(Tail.Col);
      if (Tail.CurDir = ToRight) and (Tail.Col = ColCount)
        then Tail.Col := 0;
      if (Tail.CurDir = ToLeft) and (Tail.Col = -1)
        then Tail.Col := ColCount - 1;
    end else
    begin
      if Tail.CurDir = ToDown then Inc(Tail.Row) else Dec(Tail.Row);
      if (Tail.CurDir = ToDown) and (Tail.Row = RowCount)
        then Tail.Row := 0;
      if (Tail.CurDir = ToUp) and (Tail.Row = -1)
        then Tail.Row := RowCount - 1;
    end;
    //проверяем, нет ли поворота
    if Cells[Tail.Col, Tail.Row] = 'Изгиб' + Turn1
    then begin
      Cells[Tail.Col, Tail.Row] := 'Хвост' + Tail1;
      Tail.CurDir := Dir1;
    end else
        if Cells[Tail.Col, Tail.Row] = 'Изгиб' + Turn2
        then begin
          Cells[Tail.Col, Tail.Row] := 'Хвост' + Tail2;
          Tail.CurDir := Dir2;
        end
        else Cells[Tail.Col, Tail.Row] := 'Хвост' + TypeOfTail;
  end;
end;

procedure TfmMain.Timer1Timer(Sender: TObject);
var i,j: Byte;
    FName: String;
begin
  with sgField do
  begin
    //прорисовка головы змеи
    case Head.CurDir of
      ToRight: DrawHead('ТелоRL', '', 'ИзгибLD', 'ИзгибLU', 'R');
      ToDown: DrawHead('ИзгибRD', 'ИзгибLD', '', 'ТелоUD', 'D');
      ToLeft: DrawHead('', 'ТелоRL', 'ИзгибRD', 'ИзгибRU', 'L');
      ToUp: DrawHead('ИзгибRU', 'ИзгибLU', 'ТелоUD', '', 'U');
    end;
    if EndOfGame
    then begin
      Timer1.Enabled := False;
      mmiGamePause.Enabled := False;
      Beep;
      ShowMessage('Игра окончена!'#13'Вы набрали ' +
                  pnlScore.Caption + ' очков');
      for i := 1 to 10 do
        if StrToint(pnlScore.Caption) >= Top10List[i].Score
        then begin
          for j := 10 downto i + 1 do
            Top10List[j] := Top10List[j-1];
          Top10List[i].Name := lblPlayer.Caption;
          Top10List[i].Date := Date;
          Top10List[i].Score := StrToint(pnlScore.Caption);
          Break;
        end;
      FName := ExtractFilePath(Application.ExeName) + 'Top10.dat';
      AssignFile(Top10, FName);
      Rewrite(Top10);
      for i := 1 to 10 do Write(Top10, Top10List[i]);
      CloseFile(Top10);
      mmiGameRecords.Click;
    end
    else
    if (Head.Col = Apple.Col) and (Head.Row = Apple.Row)
      then begin
        AddApple; //если змея съела яблоко, то рисуем новое яблоко
        pnlScore.Caption := IntToStr(StrToInt(pnlScore.Caption) + sgField.Tag);
      end else
      begin
        Cells[Tail.Col, Tail.Row] := ''; //стираем старый хвост
        //прорисовка хвоста в новой позиции
        case Tail.CurDir of
          ToRight: DrawTail('RD', 'D', ToDown, 'RU', 'U', ToUp, 'R');
          ToDown: DrawTail('LU', 'R', ToRight, 'RU', 'L', ToLeft, 'D');
          ToLeft: DrawTail('LD', 'D', ToDown, 'LU', 'U', ToUp, 'L');
          ToUp: DrawTail('LD', 'R', ToRight, 'RD', 'L', ToLeft, 'U');
        end;
      end;
  end;
end;

procedure TfmMain.mmiGameStopClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.mmiGameStartClick(Sender: TObject);
var i: SmallInt;
begin
  fmStart := TfmStart.Create(Self);
  if fmStart.ShowModal = mrOK
  then begin
    if fmStart.editNew.Text <> ''
      then begin
        lblPlayer.Caption := fmStart.editNew.Text;
        with fmStart.listPlayer.Items do
        begin
          Add(fmStart.editNew.Text);
          SaveToFile(ExtractFilePath(Application.ExeName) + 'Players.dat');
        end;
      end
      else lblPlayer.Caption := fmStart.listPlayer.Items[fmStart.listPlayer.ItemIndex];
    sgField.Tag := fmStart.tbarLevel.Position;
    Timer1.Interval := 300 - 50 * (sgField.Tag - 1);
    pnlScore.Caption := '0';
    sgField.Visible := True;
    Timer1.Enabled := True;
    mmiGamePause.Enabled := True;
    with sgField do
    begin
      for i := 0 to RowCount do Rows[i].Clear;
      Cells[0,0] := 'ХвостR';
      Cells[1,0] := 'ТелоRL';  Cells[2,0] := 'ТелоRL';
      Cells[3,0] := 'ТелоRL';  Cells[4,0] := 'ТелоRL';
      Cells[5,0] := 'ГоловаR1';
    end;
    Randomize;
    AddApple;
    Head.PrevDir := ToRight;
    Head.CurDir := ToRight;
    Head.Col := 5;
    Head.Row := 0;
    Tail.CurDir := ToRight;
    Tail.Col := 0;
    Tail.Row := 0;
  end;
  fmStart.Free;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if sgField.Visible then
    if (Key >= vk_Left) and (Key <= vk_Down)
    then begin
      Head.PrevDir := Head.CurDir;
      case Key of
        vk_Down: if (Head.CurDir = ToRight) or (Head.CurDir = ToLeft)
                 then Head.CurDir := ToDown;
        vk_Right: if (Head.CurDir = ToDown) or (Head.CurDir = ToUp)
                  then Head.CurDir := ToRight;
        vk_Up: if (Head.CurDir = ToRight) or (Head.CurDir = ToLeft)
               then Head.CurDir := ToUp;
        vk_Left: if (Head.CurDir = ToDown) or (Head.CurDir = ToUp)
                 then Head.CurDir := ToLeft;
      end;
    end;
end;

procedure TfmMain.mmiGameRecordsClick(Sender: TObject);
var i: Integer;
begin
  if mmiGamePause.Enabled then mmiGamePause.Click;
  fmRecords := TfmRecords.Create(Self);
  with fmRecords do
  begin
    sgTop10.Cells[0,0] := '№';
    sgTop10.Cells[1,0] := 'Результат';
    sgTop10.Cells[2,0] := 'Игрок';
    sgTop10.Cells[3,0] := 'Дата';
    for i := 1 to 10 do
    begin
      sgTop10.Cells[0,i] := IntToStr(i) + '.';
      if Top10List[i].Score > 0 then
      begin
        sgTop10.Cells[1,i] := IntToStr(Top10List[i].Score);
        sgTop10.Cells[2,i] := Top10List[i].Name;
        sgTop10.Cells[3,i] := DateToStr(Top10List[i].Date);
      end;
    end;
    ShowModal;
    Free;
  end;
end;

procedure TfmMain.mmiGamePauseClick(Sender: TObject);
begin
  if mmiGamePause.Caption = 'Пауза'
    then begin
      mmiGamePause.Caption := 'Продолжить';
      Timer1.Enabled := False;
    end
    else begin
      mmiGamePause.Caption := 'Пауза';
      Timer1.Enabled := True;
    end;
end;

procedure TfmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key in ['p','P','з','З']) and mmiGamePause.Enabled
    then mmiGamePause.Click;
end;

end.
