unit Snake2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  TfmStart = class(TForm)
    editNew: TEdit;
    listPlayer: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    tbarLevel: TTrackBar;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    procedure editNewChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmStart: TfmStart;

implementation

{$R *.dfm}

procedure TfmStart.FormShow(Sender: TObject);
var F: TextFile;
    FName, s: String;
begin
  FName := ExtractFilePath(Application.ExeName) + 'Players.dat';
  AssignFile(F, FName);
  if not FileExists(FName)
    then Rewrite(F)
    else begin
      Reset(F);
      while not EOF(F) do
      begin
        Readln(F, s);
        listPlayer.Items.Add(s);
      end;
    end;
  CloseFile(F);
  if listPlayer.Items.Count > 0
    then listPlayer.ItemIndex := 0
    else bbtnOK.Enabled := False;
end;

procedure TfmStart.editNewChange(Sender: TObject);
begin
  bbtnOK.Enabled := (listPlayer.Items.Count > 0) and
                    (listPlayer.Items.IndexOf(editNew.Text) = -1) or
                    (listPlayer.Items.Count = 0) and
                    (editNew.Text <> '');
end;

end.
