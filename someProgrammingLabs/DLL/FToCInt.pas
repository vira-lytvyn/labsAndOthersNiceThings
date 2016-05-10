unit FToCInt;

interface

function FahrToCels(FahrDegree: real): real; StdCall;

implementation

function FahrToCels; external 'FTOC.DLL' name 'FahrToCels';

end.
