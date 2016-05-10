program lab_7;

var a, b, h, int0, int1 : extended;
	n, i : integer;

function f(x : extended) : extended;
begin
	f := 3 * x * x * cos(x * x * x);
end;

function fint(x : extended) : extended;
begin
	fint := sin(x * x * x);
end;

function factorial(n :extended):extended;
Begin
	if (n=0) then
		factorial := 1
	else
    begin
		if (n=1) then
			factorial := 1
        else
			factorial := n*factorial(n-1);
    end;
End;

function Cki (n:extended; k:extended):extended;
Begin
	Cki := factorial(n) / (factorial(k) * factorial(n - k));
End;

function minus(n:integer):integer;
begin
  if (n mod 2 = 0) then
    minus := 1
  else
    minus := -1;
end;

function RR(k, m : integer) : extended;
var sum : extended;
	j : integer;
begin
	sum := 0;
	for j := 0 to k do
	begin
		sum := sum + minus(k - j) * cki(k, j) * f(a + (j + m) * h);
	end;
	RR := sum;
end;

begin
	a := -1;
	b := 1;
	n := 400;
	h := (b - a) / n;
	int0 := fint(b) - fint(a);
	writeln('Tochne znachenya = ', int0);
	int1 := f(b) + f(a);
	for i := 1 to n - 1 do
	begin
		int1 := int1 + 2 * f(a + i * h);
	end;
	int1 := int1 * h / 2;
	writeln('eps1 = ', abs(int1 - int0));
	
	int1 := int1 + h / 12 * (RR(1, 0) - RR(1, n - 1));
	writeln('eps2 = ', abs(int1 - int0));
	
	int1 := int1 - h / 24 * (RR(2, 0) + RR(2, n - 2));
	writeln('eps3 = ', abs(int1 - int0));
	
	int1 := int1 + 19 * h / 720 * (RR(3, 0) - RR(3, n - 3));
	writeln('eps4 = ', abs(int1 - int0));
	
	int1 := int1 - 3 * h / 160 * (RR(4, 0) + RR(4, n - 4));
	writeln('eps5 = ', abs(int1 - int0));
	
	int1 := int1 + 863 * h / 60480 * (RR(5, 0) - RR(5, n - 5));
	writeln('eps6 = ', abs(int1 - int0));
	
	int1 := int1 - 275 * h / 24192 * (RR(6, 0) + RR(6, n - 6));
	writeln('eps7 = ', abs(int1 - int0));
end.

