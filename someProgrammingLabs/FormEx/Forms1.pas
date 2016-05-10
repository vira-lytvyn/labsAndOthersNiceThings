unit Forms1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TformMain = class(TForm)
    btnPassword: TButton;
    btnNewForm: TButton;
    btnMsg: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure btnMsgClick(Sender: TObject);
    procedure btnNewFormClick(Sender: TObject);
    procedure btnPasswordClick(Sender: TObject);
    procedure btnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

uses Password;

{$R *.dfm}

procedure TformMain.btnClick(Sender: TObject);
begin
  Caption := TButton(Sender).Caption;
end;

procedure TformMain.btnPasswordClick(Sender: TObject);
begin
  Application.CreateForm(TPasswordDlg,PasswordDlg);
  if PasswordDlg.ShowModal = mrOK
    then Caption := 'Нажата кнопка ОК'
    else Caption := 'Нажата кнопка Cancel';
  PasswordDlg.Free;
end;


procedure TformMain.btnNewFormClick(Sender: TObject);
var NewForm: TForm;
begin
  Application.CreateForm(TForm,NewForm);
  NewForm.InsertControl(TButton.Create(NewForm));
  NewForm.InsertControl(TButton.Create(NewForm));
  with TButton(NewForm.Components[0]) do
  begin
    Caption := 'OK';
    ModalResult := mrOK;
    OnClick := btnClick;
  end;
  with NewForm.Components[1] as TButton do
  begin
    Caption := 'Отмена';
    ModalResult := mrCancel;
    Left := 80;
    OnClick := btnClick;
  end;
  NewForm.ShowModal;
  NewForm.Free;
end;

procedure TformMain.btnMsgClick(Sender: TObject);
var i, BtnCount, EditCount: Integer;
    s: String;
begin
  BtnCount := 0;
  EditCount := 0;
  with formMain do
    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i] is TButton then Inc(BtnCount);
      if Components[i] is TEdit then Inc(EditCount);
    end;
  Edit1.Text := 'Кнопок - ' + IntToStr(BtnCount);
  Edit2.Text := 'Полей ввода - ' + IntToStr(EditCount);
  if Application.MessageBox('Нажмите кнопку ОК',
                            'Проверка',
                            MB_OKCANCEL) = IDOK
  then ShowMessage('Вы все сделали правильно!')
  else begin
    MessageDlg('Вы не послушались и нажали другую кнопку!', mtError,[mbOK],0);
    while MessageDlg('Теперь вы должны ответить на штрафной вопрос.'#13 +
                     'Согласны?', mtConfirmation, [mbYes,mbNo], 0) <> mrYes do ;
    s := '';
    repeat
      InputQuery('Вопрос на засыпку...', 'Как зовут автора этой книги?',s);
    until s = 'Юрий Шпак';
    ShowMessage('Верно!');
  end;
end;

end.
