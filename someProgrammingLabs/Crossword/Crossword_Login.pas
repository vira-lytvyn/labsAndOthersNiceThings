unit Crossword_Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Crossword_DM, StdCtrls, Buttons, ExtCtrls;

type
  TfmLogin = class(TForm)
    laedDatabase: TLabeledEdit;
    laedUser: TLabeledEdit;
    laedPassword: TLabeledEdit;
    bbtnFind: TBitBtn;
    bbtnConnect: TBitBtn;
    bbtnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnConnectClick(Sender: TObject);
    procedure laedDatabaseChange(Sender: TObject);
    procedure bbtnFindClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLogin: TfmLogin;

implementation

{$R *.dfm}

procedure TfmLogin.bbtnConnectClick(Sender: TObject);
begin
  with DM.sqlcDict do
  begin
    Params.Values['Database'] := laedDatabase.Text;
    Params.Values['User_Name'] := laedUser.Text;
    Params.Values['Password'] := laedPassword.Text;
  end;
  try
    Screen.Cursor := crSQLWait;
    DM.sqlcDict.Open;
    Screen.Cursor := crDefault;
    DM.WriteStrParam('База данных', laedDatabase.Text);
    DM.WriteStrParam('Пользователь', laedUser.Text);
    ModalResult := mrOK;
  except
    Screen.Cursor := crDefault;
    MessageDlg('Неверно указана база данных, '+
               'пользователь или пароль!',mtError,[mbOK],0);
  end;
end;

procedure TfmLogin.bbtnFindClick(Sender: TObject);
begin
  with DM.dlgOpen do
  begin
    Filter := 'База данных InterBase|*.gdb';
    FileName := laedDatabase.Text;
    if Execute then
    begin
      laedDatabase.Text := FileName;
      laedUser.SetFocus;
    end;
  end;
end;

procedure TfmLogin.FormCreate(Sender: TObject);
begin
  laedDatabase.Text := DM.ReadStrParam('База данных');
  laedUser.Text := DM.ReadStrParam('Пользователь');
end;

procedure TfmLogin.FormShow(Sender: TObject);
begin
  if laedDatabase.Text <> '' then laedPassword.SetFocus;
end;

procedure TfmLogin.laedDatabaseChange(Sender: TObject);
begin
  bbtnConnect.Enabled := (laedDatabase.Text <> '') and
                         (laedUser.Text <> '') and
                         (laedPassword.Text <> '');
end;

end.
