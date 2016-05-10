unit unitFrmOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TfrmOptions = class(TForm)
    lblOptSizeX: TLabel;
    lblOptSizeY: TLabel;
    tbW: TTrackBar;
    tbH: TTrackBar;
    lblW: TLabel;
    lblH: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tbWChange(Sender: TObject);
    procedure tbHChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

uses unitXOMain;

{$R *.dfm}

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOptions.btnOkClick(Sender: TObject);
begin
  frmXO.xsize := tbW.Position;
  frmXO.ysize := tbH.Position;
  frmXO.NewGame;
  Close;
end;

procedure TfrmOptions.tbHChange(Sender: TObject);
begin
  lblH.Caption := IntToStr(tbH.Position);
end;

procedure TfrmOptions.tbWChange(Sender: TObject);
begin
  lblW.Caption := IntToStr(tbW.Position);
end;

end.
