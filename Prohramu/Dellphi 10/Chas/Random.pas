unit Random;

interface

uses
  SysUtils, Classes, Controls, StdCtrls;

type
  TRandom = class(TLabel)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('XIO_Cmp', [TRandom]);
end;

end.
