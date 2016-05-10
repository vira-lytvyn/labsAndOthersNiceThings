	program lagranzh;

	var n: integer;
	    x,y: array [1..1000] of real;
	    dx: real;
	    f: text;

	function fi(i: integer; xx: real):real;
	var j:integer;
	    res: real;
	begin
	res:=1;
	for j:=0 to n do
	    begin
    if j=i then continue;
	    res:=res*(xx-x[j])/(x[i]-x[j]);
	    end;
	fi:=res;
	end;

	function l(xx: real):real;
	var s: real;
	    i: integer;
	begin
	s:=0;
	for i:=0 to n do
	    s:=s+y[i]*fi(i,xx);
	l:=s;
	end;

	procedure readin;
	begin
	assign(f,'F:\CHIS_M~1\vhid3.txt');
	reset(f); n:=0;
	while not eof(f) do
	    begin
	    readln(f,x[n],y[n]);
	    n:=n+1;
	    end;
	close(f);
	n:=n-1;
	dx:=x[n]-x[n-1];
	end;

	procedure writeout;
	var i: integer;
	    xx: real;
	begin
	assign(f,'F:\CHIS_M~1\vuhid3.txt');
	rewrite(f);
	xx:=0; dx:=dx/4;
	while xx<=x[n] do
	    begin
	    writeln(f,xx,' ',l(xx));
	    xx:=xx+dx;
	    end;
	close(f);
	end;

	begin
	readin;
	writeout;
	end.
