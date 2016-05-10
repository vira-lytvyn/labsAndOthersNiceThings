unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, Grids, ComCtrls, About, Load, Designer,
  Buttons, BtnMess, MMSystem, QHelp, IniFiles;

type
  TCode = (W,F,B,E,H,X,A,S,L,K);
  TMessages = (Pause,Loading,EndGame,Energy,NoHearts,Finished,Wait);
{
W - Wall
F - Free
B - Blip
E - Energy
H - Heart
X - Exit
A - Water
S - Water Blip
L - Invisible Wall
K - Invisible Free
}

type
  TMainForm = class(TForm)
    Grid: TDrawGrid;
    MainMenu1: TMainMenu;
    Game1: TMenuItem;
    About1: TMenuItem;
    New1: TMenuItem;
    Load1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Bevel1: TBevel;
    lbLevel: TLabel;
    lbTitle: TLabel;
    StatusBar1: TStatusBar;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    lbEnergy: TLabel;
    Bevel5: TBevel;
    lbHearts: TLabel;
    Bevel6: TBevel;
    LivesBox: TPaintBox;
    Timer1: TTimer;
    Options1: TMenuItem;
    LevelDesigner1: TMenuItem;
    Pause1: TMenuItem;
    Abort1: TMenuItem;
    Sound1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Help1: TMenuItem;
    Messages: TPanel;
    Restart1: TMenuItem;
    N1: TMenuItem;
    QuickHelp1: TMenuItem;
    procedure GridDrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure LivesBoxPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure LevelDesigner1Click(Sender: TObject);
    procedure Abort1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure Restart1Click(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sound1Click(Sender: TObject);
    procedure QuickHelp1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure Die;
    procedure LoadLevel(ALevel: Integer; AFile: String);
    procedure StopGame;
    procedure SetEnergy;
    procedure SetMessage(Mess: TMessages);
    procedure SetBtnMessage(Mess: TMessages);
    procedure SetPassMessage(ALevel: Integer; APassword: String);
    procedure StartLevel(ALevel: Integer);
    procedure HideMessage;
  end;

var
  MainForm: TMainForm;
  Map: array[0..29,0..19] of TCode;
  DatFile: Text;
  Bmp: TBitmap;
  Level, Title, Comment,
  StrSeconds, DatFileName: String;
  Bx, By, Hearts, TotalHearts, NewX, NewY,
  Lives, Seconds, CurrentLevel: Integer;
  Playing, GameEnded: Boolean;
  fINI: TIniFile;
  WinDir: PChar;
  newIni: text;

implementation

{$R *.DFM}

procedure TMainForm.SetMessage(Mess: TMessages);
begin
  case Mess of
  Pause: begin
    Messages.Caption := 'GAME PAUSED - PRESS F4';
    Messages.Font.Color := clBlue;
  end;
  Loading: begin
    Messages.Caption := 'PLEASE WAIT...';
    Messages.Font.Color := clNavy;
  end;
  EndGame: begin
    Messages.Caption := 'GAME OVER';
    Messages.Font.Color := clRed;
  end;
  Finished: begin
    Messages.Caption := 'ALL LEVELS COMPLETED !!';
    Messages.Font.Color := clBlue;
  end;
  Wait: begin
    Messages.Caption := 'PRESS F2 TO PLAY';
    Messages.Font.Color := clBlue;
  end;
  end;
  Messages.Show;
  Application.ProcessMessages;
end;

procedure TMainForm.SetBtnMessage(Mess: TMessages);
begin
  with BtnMessages do begin
    case Mess of
      NoHearts: lbComment.Caption := 'YOU MISSED SOME HEARTS';
      Energy: lbComment.Caption := 'OUT OF ENERGY';
    end;
    lbComment.Font.Color := clNavy;
    if Sound1.Checked then
      PlaySound('Error.wav',0,snd_Async);
    lbComment.Left := (Panel.Width-lbComment.Width) div 2;
    ShowModal;
  end;
  Application.ProcessMessages;
end;

procedure TMainForm.SetPassMessage(ALevel: Integer; APassword: String);
begin
  with BtnMessages do begin
    lbComment.Caption := 'PASSWORD LEVEL '+IntToStr(ALevel)+': '+APassword;
    lbComment.Font.Color := clNavy;
    lbComment.Left := (Panel.Width-lbComment.Width) div 2;
    ShowModal;
  end;
  Application.ProcessMessages;
end;

procedure TMainForm.StartLevel(ALevel: Integer);
begin
  with BtnMessages do begin
    lbComment.Caption := 'STARTING LEVEL '+IntToStr(ALevel);
    lbComment.Font.Color := clNavy;
    lbComment.Left := (Panel.Width-lbComment.Width) div 2;
    ShowModal;
  end;
  Application.ProcessMessages;
  Timer1.Enabled := True;
end;

procedure TMainForm.HideMessage;
begin
  Messages.Hide;
  Application.ProcessMessages;
end;

procedure TMainForm.StopGame;
begin
  Playing := False;
  GameEnded := True;
  Timer1.Enabled := False;
end;

procedure TMainForm.SetEnergy;
begin
  if Seconds > 200 then Seconds := 200;
  lbEnergy.Caption := 'Energy: '+IntToStr(Seconds);
  if Seconds <= 0 then begin
    lbEnergy.Caption := 'Energy: 0';
    Timer1.Enabled := False;
    SetBtnMessage(Energy);
    Die;
  end;
end;

procedure TMainForm.LoadLevel(ALevel: Integer; AFile: String);
var i,j: Integer;
c: Char;

function CharToCode(AChar: Char): TCode;
begin
  Result := F;
  case AChar of
    'W': Result := W;
    'F': Result := F;
    'B': Result := B;
    'E': Result := E;
    'H': Result := H;
    'X': Result := X;
    'A': Result := A;
    'S': Result := S;
    'L': Result := L;
    'K': Result := K;
  end;
end;

begin
  Playing := False;
  SetMessage(Loading);
  if FileExists(AFile) then begin
    Timer1.Enabled := False;
    AssignFile(DatFile,AFile);
    Reset(DatFile);
    repeat
    Readln(DatFile,Level);
    until (Level=IntToStr(ALevel)) or (Level='');
    if Level='' then begin
      StopGame;
      CloseFile(DatFile);
      SetMessage(Finished);
    end
    else begin
    Readln(DatFile,Title);
    Readln(DatFile,StrSeconds);
    Readln(DatFile,Comment);
    lbLevel.Caption := 'Level: '+Level;
    lbTitle.Caption := 'Title: '+Copy(Title,1,1)
      +LowerCase(Copy(Title,2,Length(Title)-1));
    StatusBar1.SimpleText := ' '+Comment;
    Seconds := StrToInt(StrSeconds);
    SetEnergy;
    TotalHearts := 0;
    Hearts := 0;
    for i := 0 to 19 do begin
      for j := 0 to 28 do begin
        Read(DatFile,c);
        Map[j,i] := CharToCode(c);
        if c='H' then Inc(TotalHearts);
        if c='B' then begin
          Bx := j;
          By := i;
        end;
      end;
      Readln(DatFile,c);
      if c='H' then Inc(TotalHearts);
      if c='B' then begin
        Bx := j;
        By := i;
      end;
      Map[j,i] := CharToCode(c);
    end;
    Grid.Repaint;
    LivesBox.Repaint;
    lbHearts.Caption := 'Hearts: '+IntToStr(Hearts)+'/'+IntToStr(TotalHearts);
    CloseFile(DatFile);
    HideMessage;
    Playing := True;
    GameEnded := False;
    end;
  end
  else begin
  MessageDlg('Error: can''t find '''+DatFileName+'''.',mtError,[mbOk],0);
  if ExtractFileName(DatFileName) = 'Blip.dat' then
   MessageDlg('If you lost or accidentally deleted BLIP.DAT proceed this way:'+#13+
   ' - rename or copy BACKUP.DAT into BLIP.DAT'+#13+
   ' - please make sure the file is in the same directory of BLIP.EXE',mtInformation,[mbOK],0);
  Application.Terminate;
  end;
end;

procedure TMainForm.Die;
begin
  Timer1.Enabled := False;
  if Lives > 0 then Dec(Lives);
  LivesBox.Repaint;
  if Lives = 0 then begin
    SetMessage(EndGame);
    StopGame;
  end
  else begin
  LoadLevel(CurrentLevel,DatFileName);
  if Pause1.Checked then begin
    Playing := False;
    Timer1.Enabled := False;
    SetMessage(Pause);
  end
  else StartLevel(CurrentLevel);
  end;
end;

procedure TMainForm.GridDrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
var Image: PChar;
begin
  Image := 'FREE';
  case Map[Col,Row] of
    W: Image := 'WALL';
    F: Image := 'FREE';
    B: Image := 'BLIP';
    E: Image := 'ENERGY';
    H: Image := 'HEART';
    X: Image := 'EXIT';
    A: Image := 'WATER';
    S: Image := 'INWATER';
    L: Image := 'FREE';
    K: Image := 'WALL';
  end;
  Bmp.Handle := LoadBitmap(HInstance,Image);
  Grid.Canvas.Draw(Rect.Left, Rect.Top, Bmp);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // leggo il file INI o ne creo uno nuovo
  GetMem(WinDir, 144);
  GetWindowsDirectory(WinDir, 144);
  StrCat(WinDir, '\Blip.ini');
  if not FileExists(StrPas(WinDir)) then begin
    AssignFile(newIni,WinDir);
    Rewrite(newIni);
    CloseFile(newIni);
  end;
  fIni := TIniFile.Create('Blip.ini');
  with fIni do begin
    if ReadBool('Options', 'Sound', True) = true then
     Sound1.Checked := True else Sound1.Checked := False;
    Free;
  end;
  FreeMem(WinDir, 144);
  Bmp := TBitmap.Create;
  DatFileName := 'Blip.dat';
  Lives := 3;
  CurrentLevel := 1;
  LoadLevel(CurrentLevel,DatFileName);
  Playing := False;
  GameEnded := True;
  SetMessage(Wait);
end;

procedure TMainForm.About1Click(Sender: TObject);
begin
{  AboutBox1.ShowModal;}
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.LivesBoxPaint(Sender: TObject);
begin
  LivesBox.Canvas.Refresh;
  Bmp.Handle := LoadBitmap(HInstance,'BLIP');
  if Lives = 3 then
    LivesBox.Canvas.Draw(8,3,Bmp);
  if Lives > 1 then
    LivesBox.Canvas.Draw(28,3,Bmp);
  if Lives > 0 then
    LivesBox.Canvas.Draw(48,3,Bmp);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  Dec(Seconds);
  SetEnergy;
end;

procedure TMainForm.New1Click(Sender: TObject);
begin
  Lives := 3;
  CurrentLevel := 1;
  LoadLevel(CurrentLevel,DatFileName);
  if Pause1.Checked then begin
    Playing := False;
    Timer1.Enabled := False;
    SetMessage(Pause);
  end
  else StartLevel(CurrentLevel);
end;

procedure TMainForm.Load1Click(Sender: TObject);
begin
  Timer1.Enabled := False;
  LoadForm.ShowModal;
end;

procedure TMainForm.LevelDesigner1Click(Sender: TObject);
begin
  if Playing then
  MessageDlg('You must Abort or Pause current game before'+#13
    +'opening the Level Designer.',mtWarning,[mbOk],0)
  else DesignerForm.ShowModal;
end;

procedure TMainForm.Abort1Click(Sender: TObject);
begin
  Playing := False;
  Timer1.Enabled := False;
  SetMessage(EndGame);
end;

procedure TMainForm.Pause1Click(Sender: TObject);
begin
  if not GameEnded then begin
  if Pause1.Checked then begin
    Playing := True;
    Timer1.Enabled := True;
    HideMessage;
  end
  else begin
    Playing := False;
    Timer1.Enabled := False;
    SetMessage(Pause);
  end;
  Pause1.Checked := not Pause1.Checked;
  end;
end;

procedure TMainForm.Restart1Click(Sender: TObject);
begin
  Die;
end;

procedure TMainForm.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

procedure MoveBlip;
begin
  if Map[Bx,By] = S then Map[Bx,By] := A
  else Map[Bx,By] := F;
  GridDrawCell(Self,Bx,By,Rect(Bx*16,By*16,Bx*16+15,By*16+15),[]);
  Bx := NewX;
  By := NewY;
  if Map[Bx,By] = A then Map[Bx,By] := S
  else Map[Bx,By] := B;
  GridDrawCell(Self,Bx,By,Rect(Bx*16,By*16,Bx*16+15,By*16+15),[]);
end;

begin
  if (key<41) and (key>36) and Playing then begin
    NewX := Bx;
    NewY := By;
    case key of
      38: if NewY >0 then NewY := By-1;
      40: if NewY <19 then NewY := By+1;
      37: if NewX >0 then NewX := Bx-1;
      39: if NewX <29 then NewX := Bx+1;
    end;
    case Map[NewX,NewY] of
      // *** ENERGY ***
      E: begin
        MoveBlip;
        if Sound1.Checked then
        PlaySound('Energy.wav',0,snd_Async);
        Seconds := Seconds + 20;
        SetEnergy;
      end;
      // *** SIMPLE MOVE ***
      F: MoveBlip;
      // *** WATER ***
      A: begin
      MoveBlip;
      if Sound1.Checked then
      PlaySound('Water.wav',0,snd_Async);
      Seconds := Seconds - 5;
      SetEnergy;
      end;
      // *** HEART ***
      H: begin
        MoveBlip;
        if Sound1.Checked then
        PlaySound('Heart.wav',0,snd_Async);
        Inc(Hearts);
        lbHearts.Caption := 'Hearts: '+IntToStr(Hearts)+'/'+IntToStr(TotalHearts);
      end;
      // *** HIDDEN WALL ***
      L: begin
        if Sound1.Checked then
          PlaySound('Hidewall.wav',0,snd_Async);
        Map[NewX,NewY] := W;
        GridDrawCell(Self,NewX,NewY,Rect(NewX*16,NewY*16,NewX*16+15,NewY*16+15),[]);
      end;
      // *** HIDDEN FREE CELL ***
      K: begin
        if Sound1.Checked then
          PlaySound('Hidefree.wav',0,snd_Async);
        MoveBlip;
      end;
      // *** EXIT ***
      X: begin
      MoveBlip;
      // go to next level or die
      if Hearts=TotalHearts then begin
        if Sound1.Checked then
        PlaySound('Exit.wav',0,snd_Async);
        Playing := False;
        Inc(CurrentLevel);
        LoadLevel(CurrentLevel,DatFileName);
        if Level <> '' then begin
          SetPassMessage(CurrentLevel,Title);
          StartLevel(CurrentLevel);
          Timer1.Enabled := True;
          Playing := True;
        end;
      end
      else begin
        Timer1.Enabled := False;
        SetBtnMessage(NoHearts);
        Die;
      end;
      end;
    end;
  end;
end;

procedure TMainForm.Sound1Click(Sender: TObject);
begin
  Sound1.Checked := not Sound1.Checked;
end;

procedure TMainForm.QuickHelp1Click(Sender: TObject);
begin
  QHelpForm.ShowModal;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fIni := TIniFile.Create('Blip.ini');
  with fIni do begin
    if Sound1.Checked then WriteBool('Options', 'Sound', True)
      else WriteBool('Options', 'Sound', False);
    Free;
  end;
end;

end.
