program abc;
var
	al,bl,h1,h0,h2,eps,eps1:double;
	n2,n1,n0,z:word;
function f(x:double):double;
begin
	f:=Sin(x);
end;
function Integral(a,b:double):double;
begin
	Integral:=-cos(b)+cos(a);
end;
function Simpson(al1,S_h:double;S_n:word):double;
var
	r,x:double;
	i:word;
begin
	x:=al;
	r:=f(x);
	for i:=1 to S_n do
	begin
		x:=x+S_h;
		if i mod 2 <> 0 then
			r:=r+4*f(x)
		else
			r:=r+2*f(x);
	end;
	Simpson:=S_h * r / 3;
end; 
function Adapt(a,b,step:double):double;
var
	int0,int1:double;
	c,c1,c2:double;
begin
	c:=(a+b)/2;
	c1:=(a+c)/2;
	c2:=(c+b)/2;
	int0:=step/6*(f(a)+4*f(c)+f(b));
	int1:=step/12*(f(a)+4*f(c1)+f(c))+
				step/12*(f(c)+4*f(c2)+f(b));
	z:=z+1;
	if abs(int1-int0)>=eps then
		Adapt:=Adapt(a,c,step/2)+Adapt(c,b,step/2)
	else
		Adapt:=int0;
end;
var
	p,r,r1,i0,i1,i2:double;
	q,i:word;
	file1:text;
begin
	al:=0;
	bl:=pi;
	n0:=8;
	h0:=(bl-al)/(n0-1);
	r:=Integral(al,bl);
	writeln('Int(',al:1:2,',',bl:1:2,')(sin(x)dx)= ',r);
	eps:=1e-7;
	i0:=Simpson(al,h0,n0);
	assign(file1,'Simpson.txt');
	rewrite(file1);
	eps1:=abs(r-i0);
	n0:=0;
	i:=0;
	while eps<eps1 do
	begin
		n0:=n0+8;
		h0:=(bl-al)/(n0-1);
		i1:=Simpson(al,h0,n0);
		eps1:=abs(r-i1);
		writeln(file1,n0,i1,eps1);
		i:=i+1;
	end;
	close(file1);
	writeln('Iteration i= ',i);
	//---------------  Runge
	q:=2;
	p:=2;
	n0:=48;
	n1:=24;
	n2:=12;
	h0:=(bl-al)/(n0-1);
	h1:=(bl-al)/(n1-1);
	h2:=(bl-al)/(n2-1);
	i0:=Simpson(al,h0,n0);
	i1:=Simpson(al,h1,n1);
	i2:=Simpson(al,h2,n2);
	writeln('n0= ',n0,' h0= ',h0:1:3,' Simpson= ',i0);
	writeln('n1= ',n1,' h1= ',h1:1:3,' Simpson= ',i1);
	writeln('n2= ',n2,' h2= ',h2:1:3,' Simpson= ',i2);
	r1:=i0+(i0-i1)/(exp(ln(q)*p)-1);
	writeln('q=  ',q,'  p= ',p);
	writeln('                 Runge=   ',r1);
	
	assign(file1,'Runge.txt');
	rewrite(file1);
	eps1:=abs(r-r1);
	n0:=0;
	i:=0;
	while eps<eps1 do
	begin
		n0:=n0+8;
		h0:=(bl-al)/(n0-1);
		n1:=n0 div 2;
		h1:=(bl-al)/(n1-1);
		i0:=Simpson(al,h0,n0);
		i1:=Simpson(al,h1,n1);
		r1:=i0+(i0-i1)/(exp(ln(q)*p)-1);
		eps1:=abs(r-r1);
		writeln(file1,n0,r1,eps1);
		i:=i+1;
	end;
	close(file1);
	writeln('Iteration i= ',i);
	r1:=(i1*i1-i0*i2)/(2*i1-(i0+i2));
	p:=ln((i2-i1)/(i1-i0))/ln(q);
	writeln('q=  ',q,'  p= ',p);
	writeln('                 Eitken=  ',r1);
	assign(file1,'Eitken.txt');
	rewrite(file1);
	eps1:=abs(r-r1);
	n0:=0;
	i:=0;
	while eps<eps1 do
	begin
		n0:=n0+8;
		n1:=n0 div q;
		n2:=n1 div q;
		h0:=(bl-al)/(n0-1);
		h1:=(bl-al)/(n1-1);
		h2:=(bl-al)/(n2-1);
		i0:=Simpson(al,h0,n0);
		i1:=Simpson(al,h1,n1);
		i2:=Simpson(al,h2,n2);
		r1:=(i1*i1-i0*i2)/(2*i1-(i0+i2));
		eps1:=abs(r-r1);
		writeln(file1,n0,r1,eps1);
		i:=i+1;
	end;
	close(file1);
	writeln('Iteration i= ',i);
	//---------Adapt. alg.
	n0:=100;
	h0:=(bl-al);
	z:=0;
	eps:=1e-7;
	r1:=Adapt(al,bl,h0);
	writeln('Iteration= ',z,'            Adapt=   ',r1);
	assign(file1,'Adapt.txt');
	rewrite(file1);
	eps:=1e-1;
	for i:=0 to 16 do
	begin
		z:=0;
		r1:=Adapt(al,bl,h0);
		writeln(file1,eps,r1,' ',z);
		eps:=eps/10;
	end;
	close(file1);
end.

