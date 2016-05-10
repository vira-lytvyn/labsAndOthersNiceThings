program TabulFunc;
var al, bl, h : Real;
	Xe, Ye : array [0..99] of Real;
	Ne, i : Integer;
function f(x : Real) : Real;
var W : Real;
begin
	W := bl - al;
	if (x >= 0) and (x < 5) then
		f := 0.4 * x
	else if (x >= 5) and (x <= 10) then
		f := -x
	else f := 0;
end;

begin
	Ne := 20;
	al := 0;
	bl := 10;
	h := (bl - al)/Ne; 
	Xe[0] := al;
	for i := 0 to 20 do
		begin
			Ye[i] := f(Xe[i]);
			Xe[i + 1] := Xe[i] + h;
			Writeln('Y = ', Xe[i]:1:6);
		end;
end.