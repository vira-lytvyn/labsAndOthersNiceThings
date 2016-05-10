program lab2;
uses crt;
type vector = array[0..500] of extended;

var a, b, h:extended;
    x0, y0, xe, ye, polinom, eps : vector;
dataTabulation, dataResult : text;
    i, n : integer;

function f(x:extended) : extended;
begin
        f := x + cos(x);
end;

function substraction(k:integer):extended;
var
	j, l : integer;
temp, sum : extended;
begin
	sum:=0;
for j := 0 to k do
begin
		temp := 1;
for l:=0 to k do
			if (j<>l) then
				temp := temp * (x0[j] - x0[l]);
sum := sum+ y0[j] / temp;
end;
substraction := sum;
end;

function omega(k:integer;x:extended): extended;
var j : integer;
temp : extended;
begin
	temp := 1;
for j := 0 to k do
		temp := temp * (x - x0[j]);
omega :=temp;
end;

function newtonPolinomial(x:extended):extended;
var j : integer;
sum:extended;
begin
	sum := 0;
for j := 1 to n do
		sum := sum + omega(j - 1, x) * substraction(j);
newtonPolinomial := sum + y0[0];
end;

BEGIN
	a := 0;
    b := 9;
    n := 10;
    h := (b - a) / n;
    x0[0] := a;
Assign(dataTabulation, 'data0.txt');
Rewrite(dataTabulation);
for i := 0 to n do
begin
		y0[i] := f(x0[i]);
writeln(dataTabulation, x0[i],'   ', y0[i]);
        x0[i+1] := x0[i] + h;
end;
close(dataTabulation);

    h := (b - a) / (20 * n);
xe[0] := a;
Assign(dataResult, 'data.txt');
rewrite(dataResult);
writeln(dataResult, 'y=sin(x)             x                       y                     polinomeps');
for i:=0 to  20 * n do
begin
	ye[i] := f(xe[i]);
polinom[i] := newtonPolinomial(xe[i]);
eps[i] := abs(ye[i] - polinom[i]);
xe[i+1] := xe[i] + h;
writeln(dataResult, xe[i],'   ', ye[i], '   ', polinom[i],'   ', eps[i]);
end;
close(dataResult);
end.

