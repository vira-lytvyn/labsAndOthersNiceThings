program laba_3;
type mas = array [0..100] of extended;
var j,n: integer;
        tabulation_array : mas;
        a, b, h, t : extended;
        out_f,out_approx, out_x, out_error: Text;
        
function f (x : extended) : extended;
begin
        f := cos(x) + x;
end;
function f_subst(t : extended) : extended;
var x : extended;
begin
    x := a + t * (b - a)/n;
    f_subst := f(x);
end;

procedure tabulation (var y : mas);
var i : integer;
begin
       for i := 0 to n do
           y[i] := f(a + i*h);
end;

function factorial (k : longint) : extended;
var i,s : longint;
begin
        if k = 0 then
                factorial := 1
        else
        begin
                s := 1;
                for i := 2 to k do
                        s := s * i;
                factorial := s;
        end;

end;
function factor_mnog (t : extended; k : longint) : extended;
var i : integer;
        s : extended;
begin
        s := 1;
        for i := 0 to k-1 do
                s := s * (t - i);
        factor_mnog := s;

end;

function combination(i : longint; k : longint) : extended;
begin
        combination := factorial(k)/( factorial(i)*factorial(k - i));
end;

function minusone(k : integer) : integer;
begin
      if odd(k) then
        minusone := -1
      else minusone := 1;
end;

function rozdilrizn(k : integer; fk : mas) : extended;
var i : integer;
        s : extended;
begin
        s := 0;
        for i := 0 to k do
                s := s + combination(i, k) * minusone(k - i) * fk[i];
        rozdilrizn := s;
end;

function approx(t : extended; n : integer) : extended;
var k : integer;
        s : extended;
begin
        s := 0;
        for k := 0 to n do
                s := s + factor_mnog(t, k) * (rozdilrizn(k, tabulation_array) / factorial(k));
        approx := s;
end;

function error(t : extended) : extended;
begin
    error := abs(f_subst(t) - approx(t,n));
end;

begin
	assign(out_f,'data_f.txt');
	rewrite (out_f);
	assign(out_approx,'data_approx.txt');
	rewrite (out_approx);
	assign(out_x,'data_x.txt');
	rewrite (out_x);
	assign(out_error,'data_error.txt');
	rewrite (out_error);

	a := -3;
	b := 3;
	n := 10;
    h := (b - a) / n;
    tabulation(tabulation_array);
    t := 0;
    while t <= n do
    begin
		writeln(out_f, f_subst(t):8:6);
        writeln(out_approx, approx(t, n):8:6);
        writeln(out_error, error(t));
        writeln(out_x, t:8:6);
        t := t + 0.01;
	end;
	close(out_f);
    close(out_x);
    close(out_approx);
    close(out_error);
end.
