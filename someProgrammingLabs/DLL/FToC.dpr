library FToC;

uses
  SysUtils,
  Classes,
  FToCInt;

function FahrToCels(FahrDegree: real): real; StdCall;
begin
  Result := (FahrDegree - 32) * 5 / 9;
end;

exports
  FahrToCels;
begin
end.
