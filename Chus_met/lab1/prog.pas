Program first;
var i : Integer;

Function f4(x:real):real;
begin
    f4:=x*cos(x);
end;

Begin
	Xe[0]:=al;
		For i:=0 to Ne-1 do             {Табуляція функції x*sin(x)}
            Begin
              Ye[i]:=f4(Xe[i]);
              Xe[i+1]:=Xe[i]+h
            End;

End.
