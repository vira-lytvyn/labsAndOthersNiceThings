unit DLL_1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TfmFahrToCels = class(TForm)
    laedFahr: TLabeledEdit;
    laedCels: TLabeledEdit;
    bbtnClose: TBitBtn;
    procedure laedFahrChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmFahrToCels: TfmFahrToCels;

implementation

function FahrToCels(FahrDegree: real): real;
         StdCall external 'FTOC.DLL';
{$R *.dfm}

procedure TfmFahrToCels.laedFahrChange(Sender: TObject);
begin
  laedCels.Text :=
    FloatToStr(FahrToCels(StrToFloat('0' + laedFahr.Text)));
end;

end.
