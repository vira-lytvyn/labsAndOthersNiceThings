program lab_5;
var x0, h, h0, eps : extended;
	out_data : text;
	
function f(x : extended) : extended;
begin
	f := x * x * x;
end;

function fp(x : extended) : extended;
begin
	fp := 3 * x * x;
end;

function fnp(x, h : extended) : extended;
begin
	fnp := (f(x + h) - f(x - h)) / (2 * h);
end;

function RR(x, h : extended) : extended;
begin
	RR := fnp(x, h) + (fnp(x, h) - fnp(x, 2 * h)) / 3;
end;

function eyt(x, h : extended) : extended;
var y1, y2 : extended;
begin
	y1 := (sqr(fnp(x, 2 * h))) / (2 * fnp(x, 2 * h) - (fnp(x, 4 * h) + fnp(x, h))); 
	y2 := fnp(x, 4 * h) * fnp(x, h) / (2 * fnp(x, 2 * h) - (fnp(x, 4 * h) + fnp(x, h)));
	eyt := y1 - y2;
end;

function pd(x, h : extended) : extended;
begin
	pd := 1 / ln(2) * ln(abs((fnp(x, 4 * h) - fnp(x, 2 * h)) / (fnp(x, 2 * h) - fnp(x, h))));
end;

begin
	assign(out_data, 'out.txt');
	rewrite(out_data);
	
	h := 1e-8;
	x0 := 0.5;
	while h <= 1e-4 do
	begin
		eps := abs(fp(x0) - fnp(x0, h));
		writeln(out_data, h, '  ', eps);
		h := h * 1.1;
	end;
	
	h0 := 2e-4;
	eps := abs(fp(x0) - fnp(x0, h0));
	writeln('h0 := ', h0, ' eps := ', eps);
	
	writeln('RR := ', RR(x0, h0), ' eps = ', abs(fp(x0) - RR(x0, h0)));
	writeln('eytkin := ', eyt(x0, h0), ' eps = ', abs(fp(x0) - eyt(x0, h0)));
	writeln('p := ', pd(x0, h));
	
	close(out_data);
end.
