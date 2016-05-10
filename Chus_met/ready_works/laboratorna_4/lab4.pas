program lab4;
const m = 4;  n = 30;  a = 0;  b = 3;
type mat = array[1..50,1..50] of real;
	 vec = array[1..50] of real;
var t:text;
  h,y,ymnk,sum,eps:real;
  i,j:integer;
  xv,bf,agr:vec;
  af:mat;
  fout: Text;


procedure gaus(a:mat;b:vec;nn:integer;var x:vec);
var i,j,k:integer;
r:real;
begin
  for i:=1 to nn-1 do 
  begin
	k:=i;
	r:=abs(a[i,i]);
  for j:=i+1 to nn do
	if abs(a[i,i])>=r then 
	begin
		r:=abs(a[i,i]);
		k:=j;
	end;
	if k<>i then begin
		r:=b[k];
		b[k]:=b[i];
		b[i]:=r;
	for j:=i to nn do begin
		r:=a[k,j];
		a[k,j]:=a[i,j];
		a[i,j]:=r;
	end;
  end;
  r:=a[i,i];
  b[i]:=b[i]/r;
  for j:=i to nn do
	a[i,j]:=a[i,j]/r;
  for k:=i+1 to nn do begin
	r:=a[k,i];
	b[k]:=b[k]-r*b[i];
	a[k,i]:=0;
	for j:=i+1 to nn do
		a[k,j]:=a[k,j]-r*a[i,j];
  end;
  end;
  x[nn]:=b[nn]/a[nn,nn];
  for i:=nn-1 downto 1 do begin
	r:=b[i];
  for j:=i+1 to n do
	r:=r-a[i,j]*x[j];
  x[i]:=r;
  end;
end;

function f(x:real):real;
begin
  f := sin(x);
end;

function s(a:real;st:integer):real;
var sum:real;
i:integer;
begin
  if st = 0 then
     s := 1
  else
   begin
	sum := a;
    for i := 2 to st do
		a := a * sum;
    s := a;
  end;
end;

procedure formuv_a(var forma:mat);
var i,k,l:integer;
sum:real;
begin
for k:=1 to m do
  for l:=1 to m do
  begin
      sum:=0;
         for i:=0 to n do
                sum:=sum + s(xv[i],k+l);
         forma[k,l]:=sum;
  end;
end;

procedure formuv_b(var formb:vec);
var i,k:integer;
sum:real;
begin
  for k:=1 to m do begin
  sum:=0;
  for i:=0 to n do
	sum := sum + s(xv[i], k) * f(xv[i]);
	formb[k] := sum;
  end;
end;

function approx(xvh:real;vh:vec):real;
var sum:real;
j:integer;
begin
  sum := 0;
  for j := 0 to m do
	sum := sum + s(xvh,j)*vh[j];
  approx := sum;
end;


BEGIN
  assign(t,'input.txt');
  rewrite(t);

  assign(fout,'data.txt');
  rewrite (fout);


  h := (b - a) / n;
  for i := 0 to n do
  begin
	xv[i] := a + i * h;
	writeln(t,xv[i]:3:3);
  end;

  formuv_a(af);
  formuv_b(bf);

  gaus(af,bf,m,agr);

  for i:=1 to n do
    sum:=sum+sqr(approx(xv[i],agr)-f(xv[i]));
  sum:=sqrt(sum/(n+1));
  writeln(fout, 'zna4en dyspresii: ', sum);
  writeln(fout, '===============');

  y:=a;
  while y<=b do
  begin
    writeln(fout,y, '  ', f(y), ' ', approx(y,agr), ' ' , abs(f(y)- approx(y,agr)) );
    y := y + h;
  end;
	
  close(t);
  close(fout);

END.
