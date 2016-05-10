unit Beep1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, ComCtrls, ToolWin, ExtCtrls, Buttons,
  Spin, BeepThread, Printers;

type
  TfmMain = class(TForm)
    sgLine: TStringGrid;
    Menu: TMainMenu;
    mmiFile: TMenuItem;
    mmiFileNew: TMenuItem;
    mmiFileOpen: TMenuItem;
    mmiFileSave: TMenuItem;
    N1: TMenuItem;
    mmiFileExit: TMenuItem;
    lblSize: TLabel;
    cbxSize: TComboBox;
    pnlS_Cd: TPanel;
    pnlS_Dd: TPanel;
    pnlS_Fd: TPanel;
    pnlS_Gd: TPanel;
    pnlS_Ad: TPanel;
    pnl1_Cd: TPanel;
    pnl1_Dd: TPanel;
    pnl1_Fd: TPanel;
    pnl1_Gd: TPanel;
    pnl1_Ad: TPanel;
    pnl2_Cd: TPanel;
    pnl2_Dd: TPanel;
    pnl2_Fd: TPanel;
    pnl2_Gd: TPanel;
    pnl2_Ad: TPanel;
    pnl3_Cd: TPanel;
    pnl3_Dd: TPanel;
    pnl3_Fd: TPanel;
    pnl3_Gd: TPanel;
    pnl3_Ad: TPanel;
    pnlS_H: TPanel;
    pnlS_G: TPanel;
    pnlS_F: TPanel;
    pnlS_E: TPanel;
    pnlS_D: TPanel;
    pnlS_C: TPanel;
    pnlS_A: TPanel;
    pnl3_H: TPanel;
    pnl3_G: TPanel;
    pnl3_F: TPanel;
    pnl3_E: TPanel;
    pnl3_D: TPanel;
    pnl3_C: TPanel;
    pnl3_A: TPanel;
    pnl2_H: TPanel;
    pnl2_G: TPanel;
    pnl2_F: TPanel;
    pnl2_E: TPanel;
    pnl2_D: TPanel;
    pnl2_C: TPanel;
    pnl2_A: TPanel;
    pnl1_H: TPanel;
    pnl1_G: TPanel;
    pnl1_F: TPanel;
    pnl1_E: TPanel;
    pnl1_D: TPanel;
    pnl1_C: TPanel;
    pnl1_A: TPanel;
    pnlLength: TPanel;
    sb1: TSpeedButton;
    sb2: TSpeedButton;
    sb4: TSpeedButton;
    sb8: TSpeedButton;
    sb16: TSpeedButton;
    sb32: TSpeedButton;
    sbPoint: TSpeedButton;
    pnlPause: TPanel;
    sbP1: TSpeedButton;
    sbP2: TSpeedButton;
    sbP4: TSpeedButton;
    sbP8: TSpeedButton;
    sbP16: TSpeedButton;
    sbP32: TSpeedButton;
    pnlRec: TPanel;
    btnDelete: TButton;
    btnPlay: TButton;
    lblTempo: TLabel;
    sedTempo: TSpinEdit;
    bbtnExit: TBitBtn;
    btnStop: TButton;
    dlgSave: TSaveDialog;
    dlgOpen: TOpenDialog;
    dlgPrint: TPrintDialog;
    mmiFilePrint: TMenuItem;
    procedure mmiFilePrintClick(Sender: TObject);
    procedure mmiFileExitClick(Sender: TObject);
    procedure sgLineDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure cbxSizeChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure pnlS_CMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlS_CMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlRecClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure sbP1Click(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure mmiFileSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mmiFileOpenClick(Sender: TObject);
    procedure mmiFileNewClick(Sender: TObject);
  private
    { Private declarations }
    FilledPartOfTakt, TaktLength: real;
    function CurSign(isNote: Boolean; ACol, ARow: Integer): string;
    function SelectedLength: string;
    procedure SetNote(Key: byte);
    function CheckLength(curLength: string): Boolean;
    procedure NewTakt;
    procedure DrawLine(y: integer);
    procedure DrawAddLines(n, x, y: integer);
  public
    function SignLength(curLength: string): real;
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  NotesFrq: array[1..48] of Integer;

implementation

{$R *.dfm}

procedure TfmMain.mmiFileExitClick(Sender: TObject);
begin
  Close;
end;

function TfmMain.CurSign(isNote: Boolean; ACol, ARow: Integer): string;
var TailDown: Boolean;
    s: string[6];
begin
  with sgLine do
  begin
    s := copy(Cells[ACol, 0], 1, pos('/',Cells[ACol, 0]));
    if isNote   //ноты
    then begin
      TailDown := (ARow < 8) or
                  ((ARow = 8) and (Cells[ACol, ARow][1] = '+'));
      if s = '1/' then Result := 'w';
      if s = '2/' then
        if TailDown then Result := 'H' else Result := 'h';
      if s = '4/' then
        if TailDown then Result := 'Q' else Result := 'q';
      if s = '8/' then
        if TailDown then Result := 'E' else Result := 'e';
      if s = '16/' then
        if TailDown then Result := 'X' else Result := 'x';
      if s = '32/' then
        if TailDown then Result := 'R' else Result := 'r';
      if pos('#', Cells[ACol, ARow]) > 0 then Result := '#' + Result;
    end else
    begin
      if (s = '1/') or (s = '2/') then Result := 'о';
      if s = '4/' then Result := 'О';
      if s = '8/' then Result := 'д';
      if s = '16/' then Result := 'Е';
      if s = '32/' then Result := 'Ё';
    end;
  end;
end;

procedure TfmMain.sgLineDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var dx, dy, i: integer;
    s: string[6];
begin
  with sgLine, Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Style := psSolid;
    Brush.Style := bsClear;
    Font.Name := 'MusicalSymbols';
    Font.Size := 30;
    if (ARow = 5) and (ACol = 0) then
      TextOut(Rect.Left + 5, Rect.Bottom - 12, '&'); //Скрипичный ключ
    if (ARow = 5) and (ACol = 1) then //Размер
    begin
      Brush.Style := bsSolid;
      Pen.Color := clWhite;
      Rectangle(Rect.Left, 0, Rect.Right, Height - DefaultRowHeight);
      Brush.Style := bsClear;
      Pen.Color := clBlack;
      TextOut(Rect.Left, Rect.Top - 35, copy(Cells[1,5], 1, 1));
      TextOut(Rect.Left, Rect.Bottom - 23, copy(Cells[1,5],3,1));
    end;
    if ARow in [5..9] then //Нотный стан
    begin
      MoveTo(Rect.Left-1, Rect.Bottom);
      LineTo(Rect.Right+1, Rect.Bottom);
    end;
    if (Cells[ACol, ARow] <> '') and (ACol > 1) and (ARow > 0)
    then begin //ноты и паузы
      if AnsiLowerCase(Cells[ACol, ARow]) <> 'p'   //ноты
      then begin
        if ARow > 10 then  //нижние доп. линейки
        begin
          if Cells[ACol, ARow][1] = '0' then dy := -41 - ARow else dy := -46 - ARow;
          for i := 0 to ARow - 11 do
          begin
            MoveTo(Rect.Left, Rect.Top - i*DefaultRowHeight + 9 - ARow);
            LineTo(Rect.Right, Rect.Top - i*DefaultRowHeight + 9 - ARow);
          end;
        end else
        if ARow < 6 then //верхние доп. линейки
        begin
          if Cells[ACol, ARow][1] = '0' then dy := -45 - ARow else dy := -50 - ARow;
          for i := ARow to 5 do
            if not ((i = 5) and (Cells[ACol, ARow][1] = '0'))
            then begin
              MoveTo(Rect.Left, Rect.Bottom - (i-4)*DefaultRowHeight + 5 - ARow);
              LineTo(Rect.Right, Rect.Bottom - (i-4)*DefaultRowHeight + 5 - ARow);
            end;
        end else
          if Cells[ACol, ARow][1] = '0' then dy := -50 else dy := -56;
        if pos('#', Cells[ACol, ARow]) > 0 then dx := 1 else dx := 8;
      end else
      begin  //для пауз
        dx := 10;
        dy := -52;
        s := copy(Cells[ACol, 0], 1, pos('/', Cells[ACol, 0]));
        if s = '2/' then Inc(dy, 6);
        if (s = '4/') or (s = '16/') then Inc(dy, 8);
        if s = '32/' then Inc(dy, 14);
      end;
      if pos('.', Cells[ACol, 0]) > 0 then Dec(dx);
      TextOut(Rect.Left + dx, Rect.Top + dy,
              CurSign(AnsiLowerCase(Cells[ACol, ARow]) <> 'p', ACol, ARow));
      if pos('.', Cells[ACol, 0]) > 0
        then TextOut(Rect.Right - 5, Rect.Top + dy, '.');
    end;
    if (Cells[ACol, 0] = '|') and (ARow = 0)  //такты
    then begin
      MoveTo(Rect.Left + 5, Rect.Top + 6*DefaultRowHeight + 5);
      LineTo(Rect.Left + 5, Rect.Top + 11*DefaultRowHeight);
    end;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  NotesFrq[1] := 131;  NotesFrq[2] := 139;  NotesFrq[3] := 147;
  NotesFrq[4] := 156;  NotesFrq[5] := 165;  NotesFrq[6] := 175;
  NotesFrq[7] := 186;  NotesFrq[8] := 196;  NotesFrq[9] := 208;
  NotesFrq[10] := 220;  NotesFrq[11] := 234;  NotesFrq[12] := 247;
  NotesFrq[13] := 262;  NotesFrq[14] := 278;  NotesFrq[15] := 294;
  NotesFrq[16] := 312;  NotesFrq[17] := 330;  NotesFrq[18] := 349;
  NotesFrq[19] := 371;  NotesFrq[20] := 392;  NotesFrq[21] := 416;
  NotesFrq[22] := 440;  NotesFrq[23] := 467;  NotesFrq[24] := 494;
  NotesFrq[25] := 523;  NotesFrq[26] := 555;  NotesFrq[27] := 587;
  NotesFrq[28] := 623;  NotesFrq[29] := 659;  NotesFrq[30] := 699;
  NotesFrq[31] := 742;  NotesFrq[32] := 785;  NotesFrq[33] := 832;
  NotesFrq[34] := 880;  NotesFrq[35] := 934;  NotesFrq[36] := 988;
  NotesFrq[37] := 1047;  NotesFrq[38] := 1111;  NotesFrq[39] := 1174;
  NotesFrq[40] := 1246;  NotesFrq[41] := 1318;  NotesFrq[42] := 1396;
  NotesFrq[43] := 1482;  NotesFrq[44] := 1568;  NotesFrq[45] := 1664;
  NotesFrq[46] := 1760;  NotesFrq[47] := 1868;  NotesFrq[48] := 1975;
  sgLine.ColWidths[0] := 35;
  cbxSizeChange(Self);
  FilledPartOfTakt := 0;
end;

procedure TfmMain.cbxSizeChange(Sender: TObject);
begin
  sgLine.Cells[1,5] := cbxSize.Items[cbxSize.ItemIndex];
  sgLine.Repaint;
  case cbxSize.ItemIndex of
    0: TaktLength := 0.5;
    1: TaktLength := 1;
  else TaktLength := 0.75;
  end;
end;

procedure TfmMain.FormPaint(Sender: TObject);
begin
  sgLine.Refresh;
end;

function TfmMain.SelectedLength: string;
begin
  if sb1.Down then Result := '1/';
  if sb2.Down then Result := '2/';
  if sb4.Down then Result := '4/';
  if sb8.Down then Result := '8/';
  if sb16.Down then Result := '16/';
  if sb32.Down then Result := '32/';
  if sbPoint.Down then Result := Result + '.';
end;

procedure TfmMain.SetNote(Key: byte);
begin
  with sgLine do
  begin
    ColCount := ColCount + 1;
    Cells[ColCount - 1, 0] := SelectedLength;
    case Key of
      1: Cells[ColCount - 1, 14] := '0'; //C
      2: Cells[ColCount - 1, 14] := '0#'; //C#
      3: Cells[ColCount - 1, 14] := '+'; //D
      4: Cells[ColCount - 1, 14] := '+#'; //D#
      5: Cells[ColCount - 1, 13] := '0'; //E
      6: Cells[ColCount - 1, 13] := '+'; //F
      7: Cells[ColCount - 1, 13] := '+#'; //F#
      8: Cells[ColCount - 1, 12] := '0'; //G
      9: Cells[ColCount - 1, 12] := '0#'; //G#
      10: Cells[ColCount - 1, 12] := '+'; //A
      11: Cells[ColCount - 1, 12] := '+#'; //A#
      12: Cells[ColCount - 1, 11] := '0'; //H
      13: Cells[ColCount - 1, 11] := '+'; //C
      14: Cells[ColCount - 1, 11] := '+#'; //C#
      15: Cells[ColCount - 1, 10] := '0'; //D
      16: Cells[ColCount - 1, 10] := '0#'; //D#
      17: Cells[ColCount - 1, 10] := '+'; //E
      18: Cells[ColCount - 1, 9] := '0'; //F
      19: Cells[ColCount - 1, 9] := '0#'; //F#
      20: Cells[ColCount - 1, 9] := '+'; //G
      21: Cells[ColCount - 1, 9] := '+#'; //G#
      22: Cells[ColCount - 1, 8] := '0'; //A
      23: Cells[ColCount - 1, 8] := '0#'; //A#
      24: Cells[ColCount - 1, 8] := '+'; //H
      25: Cells[ColCount - 1, 7] := '0'; //C
      26: Cells[ColCount - 1, 7] := '0#'; //C#
      27: Cells[ColCount - 1, 7] := '+'; //D
      28: Cells[ColCount - 1, 7] := '+#'; //D#
      29: Cells[ColCount - 1, 6] := '0'; //E
      30: Cells[ColCount - 1, 6] := '+'; //F
      31: Cells[ColCount - 1, 6] := '+#'; //F#
      32: Cells[ColCount - 1, 5] := '0'; //G
      33: Cells[ColCount - 1, 5] := '0#'; //G#
      34: Cells[ColCount - 1, 5] := '+'; //A
      35: Cells[ColCount - 1, 5] := '+#'; //A#
      36: Cells[ColCount - 1, 4] := '0'; //H
      37: Cells[ColCount - 1, 4] := '+'; //C
      38: Cells[ColCount - 1, 4] := '+#'; //C#
      39: Cells[ColCount - 1, 3] := '0' ; //D
      40: Cells[ColCount - 1, 3] := '0#'; //D#
      41: Cells[ColCount - 1, 3] := '+'; //E
      42: Cells[ColCount - 1, 2] := '0'; //F
      43: Cells[ColCount - 1, 2] := '0#'; //F#
      44: Cells[ColCount - 1, 2] := '+'; //G
      45: Cells[ColCount - 1, 2] := '+#'; //G#
      46: Cells[ColCount - 1, 1] := '0'; //A
      47: Cells[ColCount - 1, 1] := '0#'; //A#
      48: Cells[ColCount - 1, 1] := '+'; //H
    end;
  end;
end;

function TfmMain.SignLength(curLength: string): real;
var x: real;
begin
  x := 1 / StrToInt(copy(curLength, 1, pos('/', curLength) - 1));
  if pos('.', curLength) > 0 then x := x + x / 2;
  Result := x;
end;

function TfmMain.CheckLength(curLength: string): Boolean;
var x: real;
begin
  x := SignLength(curLength);
  if (FilledPartOfTakt + x) > TaktLength then Result := False
  else begin
    FilledPartOfTakt := FilledPartOfTakt + x;
    Result := True;
  end;
end;

procedure TfmMain.NewTakt;
begin
  with sgLine do
  begin
    ColCount := ColCount + 1;
    ColWidths[ColCount - 1] := 10;
    Cells[ColCount - 1, 0] := '|';
    FilledPartOfTakt := 0;
  end;
end;

procedure TfmMain.pnlS_CMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TPanel(Sender).BevelOuter := bvLowered;
  Windows.Beep(NotesFrq[TPanel(Sender).Tag], 80);
  if pnlRec.Color = clRed then
    if CheckLength(SelectedLength)
    then begin
      SetNote(TPanel(Sender).Tag);
      btnDelete.Enabled := True;
      cbxSize.Enabled := False;
      mmiFileSave.Enabled := True;
      sbPoint.Down := False;
      if FilledPartOfTakt = TaktLength then NewTakt;
      sgLine.Col := sgLine.ColCount - 1;
    end else
    begin
      TPanel(Sender).BevelOuter := bvRaised;
      MessageDlg('Длительность превышает такт', mtError, [mbOk], 0);
    end;
end;

procedure TfmMain.pnlS_CMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TPanel(Sender).BevelOuter := bvRaised;
end;

procedure TfmMain.pnlRecClick(Sender: TObject);
begin
  with pnlRec do
    if Color = clRed
    then begin
      Color := clBtnFace;
      Font.Color := clBlack;
      BevelOuter := bvRaised;
    end
    else begin
      Color := clRed;
      Font.Color := clWhite;
      BevelOuter := bvLowered;
    end;
end;

procedure TfmMain.btnDeleteClick(Sender: TObject);
begin
  with sgLine do
  begin
    if Cells[ColCount - 1, 0] = '|'
    then begin
      Cols[ColCount - 1].Clear;
      ColCount := ColCount - 1;
      FilledPartOfTakt := TaktLength;
    end;
    FilledPartOfTakt := FilledPartOfTakt - SignLength(Cells[ColCount - 1, 0]);
    Cols[ColCount - 1].Clear;
    ColCount := ColCount - 1;
    Col := ColCount - 1;
    btnDelete.Enabled := (ColCount > 2);
    cbxSize.Enabled := not btnDelete.Enabled;
    mmiFileSave.Enabled := True;
    sbPoint.Down := False;
  end;
end;

procedure TfmMain.sbP1Click(Sender: TObject);
var s: string;
begin
  if pnlRec.Color = clRed then
  begin
    s := TSpeedButton(Sender).Name + '/';
    Delete(s, 1, 3);
    if sbPoint.Down then s := s + '.';
    if CheckLength(s)
    then begin
      sgLine.ColCount := sgLine.ColCount + 1;
      sgLine.Cells[sgLine.ColCount - 1, 0] := s;
      sgLine.Cells[sgLine.ColCount - 1, 7] := 'p';
      btnDelete.Enabled := True;
      cbxSize.Enabled := False;
      mmiFileSave.Enabled := True;
      sbPoint.Down := False;
      if FilledPartOfTakt = TaktLength then NewTakt;
      sgLine.Col := sgLine.ColCount - 1;
    end else MessageDlg('Длительность превышает такт', mtError, [mbOk], 0);
  end;
end;

procedure TfmMain.btnStopClick(Sender: TObject);
begin
  btnStop.Enabled := False;
end;

procedure TfmMain.btnPlayClick(Sender: TObject);
var MusicThread: TMusicThread;
begin
  MusicThread := TMusicThread.Create(False);
end;

procedure TfmMain.mmiFileSaveClick(Sender: TObject);
var i, j: integer;
    F: TextFile;
begin
  if dlgSave.Execute then
  begin
    Caption := ExtractFileName(dlgSave.FileName);
    AssignFile(F, dlgSave.FileName);
    Rewrite(F);
    for i := 0 to sgLine.ColCount - 1 do
      for j := 0 to sgLine.RowCount - 1 do
        Writeln(F,sgLine.Cells[i,j]);
    CloseFile(F);
    mmiFileSave.Enabled := False;
  end;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var mr: Word;
begin
  if mmiFileSave.Enabled then
  begin
    mr := MessageDlg('Были внесены изменения!' + #13 + 'Сохранить их?',
                     mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if mr = mrCancel then CanClose := False else
      if mr = mrYes then mmiFileSave.Click;
  end;
end;

procedure TfmMain.mmiFileOpenClick(Sender: TObject);
var i, j: integer;
    F: TextFile;
    s: string;
begin
  if mmiFileSave.Enabled then
    if MessageDlg('Были внесены изменения!' + #13 + 'Сохранить их?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then mmiFileSave.Click;
  if dlgOpen.Execute then
  with sgLine do
  begin
    Caption := ExtractFileName(dlgOpen.FileName);
    AssignFile(F, dlgOpen.FileName);
    Reset(F);
    for i := 1 to ColCount - 1 do Cols[i].Clear;
    ColCount := 1;
    Refresh;
    FilledPartOfTakt := 0;
    repeat
      for j := 0 to RowCount - 1 do
      begin
        Readln(F, s);
        Cells[ColCount - 1, j] := s;
        if s = '|'
        then begin
          ColWidths[ColCount - 1] := 10;
          FilledPartOfTakt := 0;
        end else
          if pos('/', s) > 0
          then FilledPartOfTakt := FilledPartOfTakt + SignLength(s);
      end;
      ColCount := ColCount + 1;
    until EOF(F);
    CloseFile(F);
    ColCount := ColCount - 1;
    cbxSize.ItemIndex := cbxSize.Items.IndexOf(Cells[1,5]);
    cbxSizeChange(Self);
    btnDelete.Enabled := (ColCount > 2);
    cbxSize.Enabled := not btnDelete.Enabled;
  end;
end;

procedure TfmMain.mmiFileNewClick(Sender: TObject);
var i: integer;
begin
  if mmiFileSave.Enabled then
    if MessageDlg('Были внесены изменения!' + #13 + 'Сохранить их?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then mmiFileSave.Click;
  Caption := '[Новая музыка]';
  with sgLine do
  begin
    for i := 2 to ColCount - 1 do Cols[i].Clear;
    ColCount := 2;
    Refresh;
    btnDelete.Enabled := False;
    cbxSize.Enabled := True;
    FilledPartOfTakt := 0;
  end;
end;

procedure TfmMain.DrawLine(y: integer);
var i: integer;
begin
  with Printer, Canvas do
  begin
    for i := 0 to 4 do
    begin
      MoveTo(20, y + 200 + i*30);
      LineTo(PageWidth - 20, y + 200 + i*30);
    end;
    TextOut(20, y + 165, '&');
    TextOut(100, y + 80, copy(sgLine.Cells[1,5], 1, 1));
    TextOut(100, y + 140, copy(sgLine.Cells[1,5], 3, 1));
  end;
end;

procedure TfmMain.DrawAddLines(n, x, y: integer);
var i: integer;
begin
  with Printer, Canvas do
    for i := 0 to n - 1 do
    begin
      MoveTo(x - 10, y + i*30);
      LineTo(x + 55, y + i*30);
    end;
end;

procedure TfmMain.mmiFilePrintClick(Sender: TObject);
var i, j, c, x, y, dy, Takt: Integer;
    s: string;
begin
  if dlgPrint.Execute then
    for c := 1 to dlgPrint.Copies do
      with Printer, Canvas do
      begin
        BeginDoc;
        Font.Name := 'MS Sans Serif';
        Font.Size := 10;
        TextOut(20,20, Caption);
        Font.Name := 'MusicalSymbols';
        Font.Size := 22;
        Pen.Color := clBlack;
        Brush.Style := bsClear;
        y := 80;
        x := 170;
        DrawLine(y);
        for i := 2 to sgLine.ColCount - 1 do
        begin
          if (sgLine.Cells[i, 0] = '|') and (x > 150)
          then begin
            MoveTo(x, y + 200);
            LineTo(x, y + 320);
            Inc(x, 20);
            Takt := 0;
            for j := (i+1) to sgLine.ColCount - 1 do
              if sgLine.Cells[j, 0] = '|'
              then begin
                Inc(Takt, 20);
                Break;
              end else Inc(Takt, 90);
            if (PageWidth - x - 20) < Takt
            then begin
              Inc(y, 470);
              if (y + 470) > PageHeight then NewPage;
              DrawLine(y);
              x := 170;
            end;
          end
          else
            for j := 1 to sgLine.RowCount - 1 do
              if sgLine.Cells[i, j] <> '' then
              begin
                if j > 10
                then begin
                  DrawAddLines(j - 10, x, y + 350);
                  if sgLine.Cells[i,j][1] = '0'
                  then dy := j*30 - 118 else dy := (j-1)*30 - 103;
                end else
                if j < 6
                then begin
                  if ((j = 5) and (pos('+', sgLine.Cells[i,j]) > 0)) or
                     ((j = 4) and (pos('0', sgLine.Cells[i,j]) > 0))
                  then DrawAddLines(1, x, y + 170) else
                  if ((j = 4) and (pos('+', sgLine.Cells[i,j]) > 0)) or
                     ((j = 3) and (pos('0', sgLine.Cells[i,j]) > 0 ))
                  then DrawAddLines(2, x, y + 140) else
                  if ((j = 3) and (pos('+', sgLine.Cells[i,j]) > 0)) or
                     ((j = 2) and (pos('0', sgLine.Cells[i,j]) > 0 ))
                  then DrawAddLines(3, x, y + 110) else
                  if ((j = 2) and (pos('+', sgLine.Cells[i,j]) > 0)) or
                     ((j = 1) and (pos('0', sgLine.Cells[i,j]) > 0 ))
                  then DrawAddLines(4, x, y + 80)
                  else if pos('+', sgLine.Cells[i,j]) > 0
                       then DrawAddLines(5, x, y + 50);
                  if sgLine.Cells[i,j][1] = '0'
                  then dy := j*30 - 118 else dy := (j-1)*30 - 103;
                end else
                  if sgLine.Cells[i,j][1] = '0'
                  then dy := j*30 - 118 else dy := (j-1)*30 - 103;
                if AnsiLowerCase(sgLine.Cells[i, j]) = 'p'
                then begin
                  dy := 93;
                  Inc(x, 20);
                  s := copy(sgLine.Cells[i, 0], 1, pos('/', sgLine.Cells[i, 0]));
                  if s = '2/' then Inc(dy, 12);
                  if (s = '4/') or (s = '16/') then Inc(dy, 18);
                  if s = '32/' then Inc(dy, 28);
                end;
                if pos('#', sgLine.Cells[i,j]) > 0
                  then TextOut(x - 15, y + dy, CurSign(True, i, j))
                  else TextOut(x, y + dy,
                               CurSign(AnsiLowerCase(sgLine.Cells[i, j]) <> 'p', i, j));
                if pos('.', sgLine.Cells[i, 0]) > 0 then
                begin
                  if AnsiLowerCase(sgLine.Cells[i, j]) = 'p' then Dec(dy, 5);
                  if pos('#', sgLine.Cells[i,j]) = 0
                    then TextOut(x + 40, y + dy, '.')
                    else TextOut(x + 55, y + dy, '.');
                end;
                Inc(x, 90);                 
                Break;
              end;
        end;
        EndDoc;
      end;
end;

end.
