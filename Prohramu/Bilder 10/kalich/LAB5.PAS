	program najm_kvadr;

	uses
	  SysUtils;

	var a: array [0..10] of real;
	    c: array [0..10] of real;
	    b: array [0..10,0..10] of real;
	    x,y: array [0..1000] of real;
	    kt: integer;
	    f: text;
	    n: integer;

	procedure readout;
	var i: integer;
	begin
	assignfile(f,'input.txt');
	reset(f);
	readln(f,n);
	i:=0;
	while not eof(f) do
	      begin
	      readln(f,x[i],y[i]);
	      i:=i+1;
	      end;
	kt:=i;
	closefile(f);
	end;

	function pow(xx: real; n: integer):real;
	var dd: integer;
	begin
	if (xx<0)and(odd(n)) then dd:=-1 else dd:=1;
	if n=0 then pow:=1 else if xx=0 then pow:=0 else pow:=dd*exp(n*ln(xx));
	end;

	procedure triang(st:integer);
	var i,j,gol: integer;
	    max,tmp,k: real;
	begin
	max:=abs(b[st][st]); gol:=st;
	for i:=st to n do
	    if abs(b[i][st])>max then
	       begin
	       max:=abs(b[i][st]);
	       gol:=i;
	       end;
	for j:=0 to n+1 do
	    begin
	    tmp:=b[gol][j];
	    b[gol][j]:=b[st][j];
	    b[st][j]:=tmp;
	    end;
	for i:=st+1 to n do
	    begin
	    k:=b[st][st]/b[i][st];
	    for j:=0 to n+1 do
	        b[i][j]:=k*b[i][j]-b[st][j];
	    end;
	end;

	procedure counta;
	var z,i,j: integer;
	begin
	for i:=0 to n do
	    for j:=0 to n do
	        begin
	        b[i][j]:=0;
	        for z:=0 to kt do
	            b[i][j]:=b[i][j]+pow(x[z],i+j);
	        end;
	for i:=0 to n do
            begin
	    c[i]:=0;
	    for z:=0 to kt do
	        c[i]:=c[i]+y[z]*pow(x[z],i);
                end;
	for i:=0 to n do b[i][n+1]:=c[i];

	for i:=0 to n-1 do triang(i);
	for i:=n downto 0 do
	    begin
	    a[i]:=b[i][n+1];
	    for j:=n downto i+1 do
	        a[i]:=a[i]-b[i][j]*a[j];
	    a[i]:=a[i]/b[i][i];
	    end;
	end;

	function fi(xx: real): real;
	var i: integer;
	    s: real;
	begin
	s:=0;
	for i:=0 to n do
	    s:=s+a[i]*pow(xx,i);
	fi:=s;
	end;

	var i: integer;
	    xx: real;

	begin
	readout;
	counta;
	assignfile(f,'output.txt');
	rewrite(f);
	for i:=0 to n do
	    writeln(f,a[i]);
	closefile(f);
	assignfile(f,'output2.txt');
	rewrite(f);
	xx:=x[0];
	while xx<=x[kt-1] do
	      begin
	      writeln(f,xx,' ',fi(xx));
	      xx:=xx+0.01;
	      end;
	closefile(f);
	end.
