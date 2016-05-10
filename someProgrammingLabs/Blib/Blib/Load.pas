unit Load;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TLoadForm = class(TForm)
    BitBtn1: TBitBtn;
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    lbFileName: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoadForm: TLoadForm;
  Password: String;

implementation

{$R *.DFM}

uses Main;

procedure TLoadForm.BitBtn1Click(Sender: TObject);
var Found: Boolean;
begin
  if Edit1.Text<>'' then begin
    Found := False;
    AssignFile(DatFile,DatFileName);
    Reset(DatFile);
    repeat
      Readln(DatFile,Level);
      Readln(DatFile,Password);
      Readln(DatFile);
      Readln(DatFile);
      if Password = Edit1.Text then Found := True;
    until (eof(DatFile) or Found);
    CloseFile(DatFile);
    if Found then begin
      Hide;
      Close;
      Lives := 3;
      CurrentLevel := StrToInt(Level);
    with MainForm do begin
      LoadLevel(CurrentLevel,DatFileName);
      if Pause1.Checked then begin
        Playing := False;
        Timer1.Enabled := False;
        SetMessage(Pause);
      end
      else StartLevel(CurrentLevel);
    end;
    end
    else begin
      MessageDlg('Wrong password.',mtError,[mbOK],0);
      ActiveControl := Edit1;
    end;
  end
  else begin
    Close;
    Lives := 3;
    CurrentLevel := 1;
    MainForm.LoadLevel(CurrentLevel,DatFileName);
    MainForm.StartLevel(CurrentLevel);
  end;
end;

procedure TLoadForm.BitBtn2Click(Sender: TObject);
begin
  Close;
  if Playing then
  MainForm.Timer1.Enabled := True;
end;

procedure TLoadForm.FormActivate(Sender: TObject);
begin
  lbFileName.Caption := 'Current file: '+DatFileName;
  Edit1.SelectAll;
  ActiveControl := Edit1;
end;

procedure TLoadForm.Button1Click(Sender: TObject);
begin
  OpenDialog1.FileName := DatFileName;
  if OpenDialog1.Execute then
    DatFileName := OpenDialog1.Filename;
  lbFileName.Caption := 'Current file: '+ExtractFileName(DatFileName);
end;


end.
