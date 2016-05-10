unit Snake3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids;

type
  TfmRecords = class(TForm)
    sgTop10: TStringGrid;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRecords: TfmRecords;

implementation

{$R *.dfm}

end.
