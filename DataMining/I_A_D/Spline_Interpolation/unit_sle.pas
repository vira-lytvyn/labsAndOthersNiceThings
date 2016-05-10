unit unit_sle;

interface

type

  TMatrix = array of array of extended;

  TSLESolver = class
    class procedure TridiagonalShuttle(S:TMatrix; R:array of extended; var X:array of extended);
  end;

implementation

class procedure TSLESolver.TridiagonalShuttle(S:TMatrix; R:array of extended; var X:array of extended);
var a, b:array of extended;
    n,i:integer;
begin
  n := Length(R);
  SetLength(a, n);
  SetLength(b, n);

  A[1]:=-S[0, 1]/S[0, 0];
  B[1]:=R[0]/S[0, 0];

  for i:=1 to n-2 do
    begin
      A[i+1] := -S[i, i+1]/(S[i, i] +S[i, i-1]*a[i]);
      B[i+1] := (-S[i, i-1]*b[i] + R[i])/(S[i, i] +S[i, i-1]*a[i]);
    end;

  x[n-1] := (-S[n-1, n-2]*b[n-1] + R[n-1])/(S[n-1, n-1] +S[n-1, n-2]*a[n-1]);

  for i:= n-2 downto 0 do
    x[i] := a[i+1]*x[i+1] + b[i+1];
end;

end.
 