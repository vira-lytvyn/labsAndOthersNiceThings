unit BeepThread;

interface

uses
  Classes, Windows;

type
  TMusicThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation
uses Beep1;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TMusicThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TMusicThread }

procedure TMusicThread.Execute;
var i, freq, TimeForQuarta, TimeForSign: integer;
begin
  FreeOnTerminate := True;
  with fmMain do
  begin
    btnStop.Enabled := True;
    TimeForQuarta := round(60 / sedTempo.Value * 1000); //в мс
    with sgLine do
    for i := 2 to ColCount - 1 do
    begin
      if not btnStop.Enabled then Exit;
      Col := i;
      if Cells[i, 14] = '0' then freq := NotesFrq[1] else
      if Cells[i, 14] = '0#' then freq := NotesFrq[2] else
      if Cells[i, 14] = '+' then freq := NotesFrq[3] else
      if Cells[i, 14] = '+#' then freq := NotesFrq[4] else
      if Cells[i, 13] = '0' then freq := NotesFrq[5] else
      if Cells[i, 13] = '+' then freq := NotesFrq[6] else
      if Cells[i, 13] = '+#' then freq := NotesFrq[7] else
      if Cells[i, 12] = '0' then freq := NotesFrq[8] else
      if Cells[i, 12] = '0#' then freq := NotesFrq[9] else
      if Cells[i, 12] = '+' then freq := NotesFrq[10] else
      if Cells[i, 12] = '+#' then freq := NotesFrq[11] else
      if Cells[i, 11] = '0' then freq := NotesFrq[12] else
      if Cells[i, 11] = '+' then freq := NotesFrq[13] else
      if Cells[i, 11] = '+#' then freq := NotesFrq[14] else
      if Cells[i, 10] = '0' then freq := NotesFrq[15] else
      if Cells[i, 10] = '0#' then freq := NotesFrq[16] else
      if Cells[i, 10] = '+' then freq := NotesFrq[17] else
      if Cells[i, 9] = '0' then freq := NotesFrq[18] else
      if Cells[i, 9] = '0#' then freq := NotesFrq[19] else
      if Cells[i, 9] = '+' then freq := NotesFrq[20] else
      if Cells[i, 9] = '+#' then freq := NotesFrq[21] else
      if Cells[i, 8] = '0' then freq := NotesFrq[22] else
      if Cells[i, 8] = '0#' then freq := NotesFrq[23] else
      if Cells[i, 8] = '+' then freq := NotesFrq[24] else
      if Cells[i, 7] = '0' then freq := NotesFrq[25] else
      if Cells[i, 7] = '0#' then freq := NotesFrq[26] else
      if Cells[i, 7] = '+' then freq := NotesFrq[27] else
      if Cells[i, 7] = '+#' then freq := NotesFrq[28] else
      if Cells[i, 6] = '0' then freq := NotesFrq[29] else
      if Cells[i, 6] = '+' then freq := NotesFrq[30] else
      if Cells[i, 6] = '+#' then freq := NotesFrq[31] else
      if Cells[i, 5] = '0' then freq := NotesFrq[32] else
      if Cells[i, 5] = '0#' then freq := NotesFrq[33] else
      if Cells[i, 5] = '+' then freq := NotesFrq[34] else
      if Cells[i, 5] = '+#' then freq := NotesFrq[35] else
      if Cells[i, 4] = '0' then freq := NotesFrq[36] else
      if Cells[i, 4] = '+' then freq := NotesFrq[37] else
      if Cells[i, 4] = '+#' then freq := NotesFrq[38] else
      if Cells[i, 3] = '0' then freq := NotesFrq[39] else
      if Cells[i, 3] = '0#' then freq := NotesFrq[40] else
      if Cells[i, 3] = '+' then freq := NotesFrq[41] else
      if Cells[i, 2] = '0' then freq := NotesFrq[42] else
      if Cells[i, 2] = '0#' then freq := NotesFrq[43] else
      if Cells[i, 2] = '+' then freq := NotesFrq[44] else
      if Cells[i, 2] = '+#' then freq := NotesFrq[45] else
      if Cells[i, 1] = '0' then freq := NotesFrq[46] else
      if Cells[i, 1] = '0#' then freq := NotesFrq[47] else
      if Cells[i, 1] = '+' then freq := NotesFrq[48]
        else freq := 20000;
      if freq <> 20000
      then TimeForSign := round(SignLength(Cells[i,0]) / 0.25 * TimeForQuarta) - 50
      else if pos('/', Cells[i,0]) > 0
           then TimeForSign := round(SignLength(Cells[i,0]) / 0.25 * TimeForQuarta)
           else TimeForSign := 0;
      Windows.Beep(freq, TimeForSign);
    end;
    btnStop.Enabled := False;
  end;
end;

end.
