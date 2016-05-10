library ShowFToC;

uses
  SysUtils, Classes, ShowFToCInt, DLL_1, Forms;

procedure ShowFToCForm(AHandle: THandle); StdCall;
var FToCForm: TfmFahrToCels;
begin
  Application.Handle := AHandle;
  FToCForm := TfmFahrToCels.Create(Application);
  try
    FToCForm.ShowModal;
    FToCForm.Free;
  except
  end;
end;

exports
  ShowFToCForm;
begin
end.
