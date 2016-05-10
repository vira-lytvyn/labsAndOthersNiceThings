unit unitXOMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, XPMan, ExtCtrls, unitXOAI;

type
  TfrmXO = class(TForm)
    MainMenu: TMainMenu;
    XPMAN: TXPManifest;
    N1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    imgMain: TImage;
    procedure N8Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
    xsize, ysize: Integer;
    procedure NewGame;
  private
    arr: TMyArr;
    bmp: Array[0..4] of TBitmap;
    isGame: Boolean;
    isCanMove: Boolean;
    procedure DrawField;
  end;

var
  frmXO: TfrmXO;

implementation

uses unitFrmAbout, unitFrmOptions;

{$R *.dfm}

procedure TfrmXO.N10Click(Sender: TObject);
begin
  frmAbout.Left := (Screen.Width - frmAbout.Width) div 2;
  frmAbout.Top := (Screen.Height - frmAbout.Height) div 2;
  Beep;
  frmAbout.ShowModal;
end;

procedure TfrmXO.N2Click(Sender: TObject);
begin
  NewGame;
end;

procedure TfrmXO.N8Click(Sender: TObject);
begin
  frmOptions.Left := (Screen.Width - frmOptions.Width) div 2;
  frmOptions.Top := (Screen.Height - frmOptions.Height) div 2;
  frmOptions.ShowModal;
end;

procedure TfrmXO.NewGame;
var
  i, j: Integer;
begin
  Randomize;
  SetLength(arr, xsize, ysize);
  ClientWidth := xsize * 20;
  ClientHeight := ysize * 20;

  for i := 0 to xsize - 1 do
    for j := 0 to ysize - 1 do
      arr[i, j] := 0;

  isGame := True;
  isCanMove := True;
  DrawField;
end;

procedure TfrmXO.FormCreate(Sender: TObject);
var
  i, j, k: Integer;
begin
  xsize := 30;
  ysize := 30;

  NewGame;

  for i := 0 to 4 do
  begin
    bmp[i] := TBitmap.Create;
    bmp[i].Width := 20;
    bmp[i].Height := 20;

    for j := 0 to 19 do
      for k := 0 to 19 do
        bmp[i].Canvas.Pixels[j, k] := imgMain.Canvas.Pixels[j + i * 20, k];
  end;
end;

procedure TfrmXO.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to 3 do
    bmp[i].Free;
    
  SetLength(arr, 0, 0);
  Finalize(arr);
end;

procedure TfrmXO.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

  procedure WinTest(i: Integer);
  begin
    isGame := False;
    if i < 0 then
      MessageBox(Handle, 'Победил компьютер!', ':(', MB_OK)
    else
      if i > 0 then
        MessageBox(Handle, 'Вы победили!!', ':)', MB_OK)
      else
        isGame := True;

    if not isGame then
      DrawField;
  end;

begin
  if isGame and isCanMove then
  begin
    isCanMove := False;

    X := X div 20;
    Y := Y div 20;

    if (X >= 0) and (X < xsize) and (Y >= 0) and (Y < ysize) then
      if arr[X, Y] = 0 then
      begin
        arr[X, Y] := 2;

        DrawField;

        WinTest(isWin(arr, xsize, ysize));

        if isGame then
        begin
          AI(arr, xsize, ysize);
          DrawField;
          WinTest(isWin(arr, xsize, ysize));
        end;
      end;

    isCanMove := True;
  end;
end;

procedure TfrmXO.FormPaint(Sender: TObject);
begin
  DrawField;
end;

procedure TfrmXO.DrawField;
var
  i, j: Integer;
  ps: TPaintStruct;
begin
  BeginPaint(Handle, ps);

  for i := 0 to xsize - 1 do
    for j := 0 to ysize - 1 do
      Canvas.Draw(i * 20, j * 20, bmp[arr[i, j]]);

  for i := 1 to xsize - 1 do
  begin
    Canvas.MoveTo(i * 20, 0);
    Canvas.LineTo(i * 20, ClientHeight);
  end;

  for i := 1 to ysize - 1 do
  begin
    Canvas.MoveTo(0, i * 20);
    Canvas.LineTo(ClientWidth, i * 20);
  end;

  EndPaint(Handle, ps);
end;

end.
