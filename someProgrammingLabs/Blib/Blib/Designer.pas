unit Designer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Grids, Buttons,{ NumEdit, Validations, ValCtrls,} Spin;

type
  TDesignerForm = class(TForm)
    Grid: TDrawGrid;
    edComment: TEdit;
    edTitle: TEdit;
    cbLevel: TComboBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    SaveBtn: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button2: TButton;
    Button3: TButton;
    Bevel3: TBevel;
    SpeedButton7: TSpeedButton;
    Label7: TLabel;
    OpenDialog1: TOpenDialog;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Label12: TLabel;
    Label14: TLabel;
    Messages: TPanel;
    SaveAs: TBitBtn;
    SaveDialog1: TSaveDialog;
    FileLabel: TLabel;
    Bevel2: TBevel;
    edEnergy: TSpinEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure GridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure cbLevelChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure edTitleChange(Sender: TObject);
    procedure edEnergyChange(Sender: TObject);
    procedure edCommentChange(Sender: TObject);
    procedure edPasswordChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edTitleEnter(Sender: TObject);
    procedure edEnergyExit(Sender: TObject);
  private
    { Private declarations }
  public
    procedure OpenLevel(ALevel: Integer);
    procedure FileToArray(AFile: String);
    procedure CreateNew(AFile: String);
    procedure ShowMessage;
    procedure HideMessage;
  end;

var
  DesignerForm: TDesignerForm;

implementation

{$R *.DFM}
uses Main;

type TStatus = (stFound,stNotFound,stTooMany);

var Element: TCode;
MouseDrawing, Modified, GridError: Boolean;
DMap: array[0..29,0..19] of TCode;
MapArray: array[1..15,0..29,0..19] of TCode;
LevelArray: array[1..15,1..4] of String;
MaxLev, CurrLev: Integer;
BlipStatus, HeartsStatus, ExitStatus: TStatus;

procedure TDesignerForm.ShowMessage;
begin
  Messages.Caption := 'SAVING FILE...';
  Messages.Show;
  Application.ProcessMessages;
end;

procedure TDesignerForm.HideMessage;
begin
  Messages.Hide;
  Application.ProcessMessages;
end;

procedure TDesignerForm.BitBtn2Click(Sender: TObject);
begin
  if Modified then if MessageDlg('File is not saved. Close anyway?',mtConfirmation,[mbYes,mbNo],0)
    = mrNo then Exit;
  Close;
end;

procedure TDesignerForm.FileToArray(AFile: String);
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
    Modified := False;
    cbLevel.Clear;
    AssignFile(DatFile,AFile);
    Reset(DatFile);
    MaxLev := 0;
    while not eof(DatFile) do begin
    Inc(MaxLev);
    cbLevel.Items.Add(IntToStr(MaxLev));
    Readln(DatFile,LevelArray[MaxLev,1]);
    Readln(DatFile,LevelArray[MaxLev,2]);
    Readln(DatFile,LevelArray[MaxLev,3]);
    Readln(DatFile,LevelArray[MaxLev,4]);
    for i := 0 to 19 do begin
     for j := 0 to 28 do begin
       Read(DatFile,c);
       MapArray[MaxLev,j,i] := CharToCode(c);
     end;
     Readln(DatFile,c);
     MapArray[MaxLev,j,i] := CharToCode(c);
    end;
    end;
    CloseFile(DatFile);
end;

procedure TDesignerForm.CreateNew(AFile: String);
var i: Integer;
begin
  AssignFile(DatFile,AFile);
  Rewrite(DatFile);
  Writeln(DatFile,'1');
  Writeln(DatFile,'FIRST');
  Writeln(DatFile,'50');
  Writeln(DatFile,'This is a new file of Blip levels.');
  for i := 1 to 20 do
    Writeln(DatFile,'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
  CloseFile(DatFile);
end;

procedure TDesignerForm.OpenLevel(ALevel: Integer);
var i,j: Integer;
begin
  CurrLev := ALevel;
  cbLevel.Text := LevelArray[ALevel,1];
  edTitle.Text := Copy(LevelArray[ALevel,2],1,1)
   +LowerCase(Copy(LevelArray[ALevel,2],2,Length(LevelArray[ALevel,2])-1));
  edEnergy.Text := LevelArray[ALevel,3];
  edComment.Text := LevelArray[ALevel,4];
  for i := 0 to 19 do
   for j := 0 to 29 do
    DMap[j,i] := MapArray[ALevel,j,i];
  Grid.Repaint;
end;

procedure TDesignerForm.FormActivate(Sender: TObject);
begin
  FileToArray(DatFileName);
  OpenLevel(1);
end;

procedure TDesignerForm.GridDrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
var Image: PChar;
begin
  Image := 'FREE';
  case DMap[Col,Row] of
    W: Image := 'WALL';
    F: Image := 'FREE';
    B: Image := 'BLIP';
    E: Image := 'ENERGY';
    H: Image := 'HEART';
    X: Image := 'EXIT';
    A: Image := 'WATER';
    S: Image := 'INWATER';
    L: Image := 'INVWALL';
    K: Image := 'INVFREE';
  end;
  Bmp.Handle := LoadBitmap(HInstance,Image);
  Grid.Canvas.Draw(Rect.Left, Rect.Top, Bmp);
end;

procedure TDesignerForm.GridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Col, Row: Integer;
begin
  Modified := True;
  MouseDrawing := True;
  Grid.MouseToCell(X,Y,Col,Row);
  DMap[Col,Row] := Element;
  MapArray[CurrLev,Col,Row] := Element;
  GridDrawCell(Self,Col,Row,Rect(Col*16,Row*16,Col*16+15,Row*16+15),[]);
end;

procedure TDesignerForm.FormCreate(Sender: TObject);
begin
  Element := W;
  HideMessage;
  FileLabel.Caption:= 'File: '+ExtractFileName(DatFileName);
end;

procedure TDesignerForm.SpeedButton1Click(Sender: TObject);
begin
  Element := W;
end;

procedure TDesignerForm.SpeedButton2Click(Sender: TObject);
begin
  Element := F;
end;

procedure TDesignerForm.SpeedButton3Click(Sender: TObject);
begin
  Element := H;
end;

procedure TDesignerForm.SpeedButton4Click(Sender: TObject);
begin
  Element := B;
end;

procedure TDesignerForm.SpeedButton5Click(Sender: TObject);
begin
  Element := E;
end;

procedure TDesignerForm.SpeedButton6Click(Sender: TObject);
begin
  Element := X;
end;

procedure TDesignerForm.GridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if MouseDrawing then GridMouseDown(Self,mbLeft,[],X,Y);
end;

procedure TDesignerForm.GridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseDrawing := False;
end;

procedure TDesignerForm.Button3Click(Sender: TObject);
var i,j: Integer;
begin
  for i := 0 to 29 do
   for j := 0 to 19 do begin
    DMap[i,j] := Element;
    MapArray[CurrLev,i,j] := Element;
  end;
  Modified := True;
  Grid.Repaint;
end;

procedure TDesignerForm.SaveBtnClick(Sender: TObject);
var i,j,q,el: Integer;
begin
  ShowMessage;
  if (Sender as TBitBtn) = SaveAs then begin
  SaveDialog1.FileName := DatFileName;
  if SaveDialog1.Execute then begin
    DatFileName := SaveDialog1.Filename;
    DesignerForm.Caption := 'Level Designer - '+ExtractFileName(DatFileName);
  end
  else begin
    HideMessage;
    Exit;
  end;
  end;
  AssignFile(DatFile,DatFileName);
  Rewrite(DatFile);
  GridError := False;
  for q := 1 to MaxLev do begin
    BlipStatus := stNotFound;
    HeartsStatus := stNotFound;
    ExitStatus := stNotFound;
    Writeln(DatFile,LevelArray[q,1]);
    Writeln(DatFile,UpperCase(LevelArray[q,2]));
    Writeln(DatFile,LevelArray[q,3]);
    Writeln(DatFile,LevelArray[q,4]);
    for i := 0 to 19 do begin
     for j := 0 to 29 do
      case MapArray[q,j,i] of
      W: Write(DatFile,'W');
      F: Write(DatFile,'F');
      B: begin
      if BlipStatus<>stNotFound then BlipStatus := stTooMany
      else BlipStatus := stFound;
      Write(DatFile,'B');
      end;
      E: Write(DatFile,'E');
      H: begin
      if HeartsStatus = stNotFound then HeartsStatus := stFound;
      Write(DatFile,'H');
      end;
      X: begin
      if ExitStatus = stNotFound then ExitStatus := stFound;
      Write(DatFile,'X');
      end;
      A: Write(DatFile,'A');
      S: Write(DatFile,'S');
      L: Write(DatFile,'L');
      K: Write(DatFile,'K');
    end;
    Writeln(DatFile);
    end;
    if BlipStatus=stTooMany then begin
    MessageDlg('Don''t you think there are too many Blips in level '
    +IntToStr(q)+' ?',mtWarning,[mbOk],0);
    GridError := True;
    el := q;
    end;
    if BlipStatus=stNotFound then begin
    MessageDlg('Don''t you think it''s a good idea to put a Blip in level '
    +IntToStr(q)+' ?',mtWarning,[mbOk],0);
    GridError := True;
    el := q;
    end;
    if HeartsStatus=stNotFound then begin
    MessageDlg('You need to put at least one Heart in level '
    +IntToStr(q)+' !',mtWarning,[mbOk],0);
    GridError := True;
    el := q;
    end;
    if ExitStatus=stNotFound then begin
    MessageDlg('What about adding an Exit in level '
    +IntToStr(q)+' ?',mtWarning,[mbOk],0);
    GridError := True;
    el := q;
    end;
  end;
  CloseFile(DatFile);
  HideMessage;
  if GridError then begin
    MessageDlg('Can''t save current file. There are errors.',mtWarning,[mbOk],0);
    OpenLevel(el);
  end
  else Close;
end;

procedure TDesignerForm.SpeedButton7Click(Sender: TObject);
begin
  Element := A;
end;

procedure TDesignerForm.cbLevelChange(Sender: TObject);
begin
  OpenLevel(StrToInt(cbLevel.Text));
end;

procedure TDesignerForm.Button1Click(Sender: TObject);
begin
  if Modified then if MessageDlg('Current file is not saved. Proceed anyway?',mtConfirmation,[mbYes,mbNo],0)
    = mrNo then Exit;
  OpenDialog1.FileName := DatFileName;
  if OpenDialog1.Execute then begin
      DatFileName := OpenDialog1.Filename;
      DesignerForm.Caption := 'Level Designer - '+ExtractFileName(DatFileName);
      FileLabel.Caption:= 'File: '+ExtractFileName(DatFileName);
    // create a new file if necessary
    if not FileExists(OpenDialog1.Filename) then begin
      CreateNew(DatFileName);
      MessageDlg('A new file has been created.',mtInformation,[mbOK],0);
    end;
    FileToArray(DatFileName);
    OpenLevel(1);
  end;
end;

procedure TDesignerForm.SpeedButton8Click(Sender: TObject);
begin
  Element := L;
end;

procedure TDesignerForm.SpeedButton9Click(Sender: TObject);
begin
  Element := K;
end;

procedure TDesignerForm.edTitleChange(Sender: TObject);
begin
  LevelArray[CurrLev,2] := edTitle.Text;
end;

procedure TDesignerForm.edEnergyChange(Sender: TObject);
begin
  LevelArray[CurrLev,3] := edEnergy.Text;
end;

procedure TDesignerForm.edCommentChange(Sender: TObject);
begin
  LevelArray[CurrLev,4] := edComment.Text;
end;

procedure TDesignerForm.edPasswordChange(Sender: TObject);
begin
  LevelArray[CurrLev,2] := edTitle.Text;
end;

procedure TDesignerForm.Button2Click(Sender: TObject);
var i,j: Integer;
begin
  if MaxLev < 15 then begin
  Inc(MaxLev);
  CurrLev := MaxLev;
  for i := 0 to 29 do
   for j := 0 to 19 do begin
    DMap[i,j] := F;
    MapArray[CurrLev,i,j] := F;
  end;
  LevelArray[CurrLev,2] := 'Title';
  LevelArray[CurrLev,3] := '100';
  LevelArray[CurrLev,4] := 'Comment...';
  cbLevel.Items.Add(IntToStr(CurrLev));
  cbLevel.Text := IntToStr(CurrLev);
  edTitle.Text := LevelArray[CurrLev,2];
  edEnergy.Text := LevelArray[CurrLev,3];
  edComment.Text := LevelArray[CurrLev,4];
  Grid.Repaint;
  MessageDlg('Level '+IntToStr(CurrLev)+' created.',mtInformation,[mbOk],0);
  end
  else MessageDlg('A file contains a maximum of 15 levels.',mtWarning,[mbOk],0);
end;

procedure TDesignerForm.edTitleEnter(Sender: TObject);
begin
  Modified := True;
end;

procedure TDesignerForm.edEnergyExit(Sender: TObject);
begin
  if (edEnergy.Value<20) or (edEnergy.Value>200) then begin
  MessageDlg('Energy must be between 20 and 200.',mtWarning,[mbOk],0);
  edEnergy.Value := 100;
  DesignerForm.ActiveControl := edEnergy;
  end;
end;

end.
