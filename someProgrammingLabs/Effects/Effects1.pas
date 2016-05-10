unit Effects1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TformMain = class(TForm)
    btnBlend: TButton;
    btnShift: TButton;
    btnTransp: TButton;
    procedure btnTranspClick(Sender: TObject);
    procedure btnShiftClick(Sender: TObject);
    procedure btnBlendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

uses Effects2, Effects3, Effects4;

{$R *.dfm}

procedure TformMain.btnBlendClick(Sender: TObject);
begin
  formBlend.ShowModal;
end;

procedure TformMain.btnShiftClick(Sender: TObject);
begin
  formShift.Width := 0;
  formShift.ShowModal;
end;

procedure TformMain.btnTranspClick(Sender: TObject);
begin
  formTransp.ShowModal;
end;

end.
