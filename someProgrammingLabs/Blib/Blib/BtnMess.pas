unit BtnMess;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TBtnMessages = class(TForm)
    Panel: TPanel;
    lbComment: TLabel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BtnMessages: TBtnMessages;

implementation

{$R *.DFM}

uses Main;

procedure TBtnMessages.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TBtnMessages.FormActivate(Sender: TObject);
begin
  Left := MainForm.Left+135;
  Top := MainForm.Top+191;
end;

end.
