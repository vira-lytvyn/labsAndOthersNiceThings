	program newton;

	var n: integer;
	    x,y: array [0..1000] of real;
	    dx: real;
	    f: text;

	function fk(k: integer):real;
	var i,j:integer;
	    res,rez: real;
	Begin	{ }
	res:=0;
	for i:=n downto n-k do
	    begin
	    rez:=y[i];
	    for j:=n downto n-k do
	        begin
	        if j=i then continue;
	        rez:=rez/(x[i]-x[j]);
	    end;
	    res:=res+rez;
	    end;
	fk:=res;
	end;

	function rizn(k: integer; xx: real):real;
	var i: integer;
	    rezult: real;
	begin
	rezult:=1;
	for i:=0 to k-1 do
	    rezult:=rezult*(xx-x[n-i]);
	rizn:=rezult;
        end;

	function l(xx: real):real;
	var s: real;
	    i: integer;
	begin
	s:=y[n];
	for i:=1 to n do
	    s:=s+fk(i)*rizn(i,xx);
	l:=s;
	end;

	procedure readin;
	begin
	assign(f,'in.txt');
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
	assign(f,'output.txt');
	rewrite(f);
	xx:=0; dx:=dx/4;
	while abs(xx-x[n])>=0.00001 do
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
