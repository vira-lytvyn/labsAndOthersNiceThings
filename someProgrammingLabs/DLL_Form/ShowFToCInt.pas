unit ShowFToCInt;

interface

procedure ShowFToCForm(AHandle: THandle); StdCall;

implementation

procedure ShowFToCForm; external 'SHOWFTOC.DLL' name 'ShowFToCForm';

end.
