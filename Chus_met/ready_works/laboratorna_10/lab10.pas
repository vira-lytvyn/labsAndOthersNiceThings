program lab10;
var
  iter, itermax, err : integer;
  xn1, x1, x2, xn, eps, tau, xm1 : real;
  outFile : text;
   
function f(x:real):real;
begin
	f := cos(x * x);
end;

function fp(x:real):real;
begin
	fp := - 2 * x * sin(x * x);
end;
  
function f2p(x:real):real;
begin
	f2p := -2 * sin(x * x )-4 * x * x * cos(x * x);
end; 
begin
	assign(outFile, 'out.txt');
	rewrite(outFile);

	xn1 := -1.05;
	itermax := 10000;
	eps := 1e-12;
	tau := 0.25; 
  
	//проста ітерація
	writeln ('Simple iterations: ');
	iter := 0;
	err := 0;
	repeat
		xn := xn1;
		xn1 := xn + tau * f(xn);
		iter := iter + 1; 
	until ((abs(xn1 - xn) < eps) AND (abs(f(xn1)) < eps) or (iter > itermax));
	writeln ('iter= ' ,iter);
    writeln ('x= ',xn1);
    writeln();
    writeln(outFile, 'Simple iterations: iterations = ', iter, ' x= ', xn1);
  
	//Ньютона
	writeln (' Nutona:');
	xn1 := -1.05;
	iter := 0;
	err := 0;
	repeat
		xn:=xn1;
		xn1 := xn-f(xn)/fp(xn);
		iter := iter + 1; 
	until ((abs(xn1 - xn)<eps) AND (abs(f(xn1)) < eps) or (iter > itermax));
    writeln ('iter= ' ,iter);
    writeln ('x= ',xn1);
    writeln;
    writeln(outFile, 'Method Newton: iterations = ', iter, ' x= ', xn1);
  
  //метод чебишева 
    writeln ('Method of Chebusheva:');
	xn1 := -1.05;
	iter := 0;
	err := 0;
	repeat
		xn := xn1;
		xn1 := xn-(f(xn)/fp(xn))-(1/2)*(sqr(f(xn))*f2p(xn))/(fp(xn)*fp(xn)*fp(xn));
		iter := iter+1; 
	until ((abs(xn1-xn)<eps) AND (abs(f(xn1))<eps) or (iter > itermax));
    writeln ('iter= ' ,iter);
    writeln ('x= ',xn1);
    writeln;
    writeln(outFile, 'Method of Chebusheva: iterations  = ', iter, ' x= ', xn1);
  
    writeln ('Metod of chords:');
	iter:=0;
	err:=0;
	xn1 := -1.05;
	xm1 := xn + tau * f(xn);
	repeat
		xn := xn1;
		xn1 := xn - f(xn) * ((xn-xm1) / (f(xn)-f(xm1)));
		iter := iter + 1;  
	until ((abs(xn1 - xn) < eps) AND (abs(f(xn1))<eps) or (iter > itermax));
    writeln ('iter= ' ,iter);
    writeln ('x= ',xn1);
    writeln;
    writeln(outFile, 'Method of Hord: iterations  = ', iter, ' x= ', xn1);
  
	writeln('Method of simple relaxation:');
	iter := 0;
	err := 0;
	xn1 := -1.05;
	repeat
		xn := xn1;
		xn1 := xn + tau * f(xn);
		iter := iter + 1;
	until ((abs(xn1 - xn) < eps) AND (abs(f(xn1))<eps) or (iter > itermax));
	writeln ('iter= ' ,iter);
    writeln ('x= ',xn1);
    writeln;
    writeln(outFile, 'Method of simple relaxation: iterations  = ', iter, ' x= ', xn1);
    
    writeln('Eytkin method:');
    iter := 0;
    err := 0;
    xn1 := -1.05;
    repeat
		xn := xn1;
		x1 := xn + tau * f(xn);
		x2 := x1 + tau * f(x1);
		xn1 := x2 +  sqr(x2 - x1) / (2 * x1 - x2 - xn);
		iter := iter + 1;
    until ((abs(xn1 - xn) < eps) AND (abs(f(xn1))<eps) or (iter > itermax));
	writeln ('iter= ' ,iter);
    writeln ('x= ',xn1);
    writeln;
    writeln(outFile, 'Method of Eytkin: iterations  = ', iter, ' x= ', xn1);
	
	writeln('Method of back interpolation:');
    iter := 0;
    err := 0;
    xn1 := -1.05;
    repeat
		xn := xn1;
		x1 := xn + tau * f(xn);
		xn1 := - f(xn) * x1 / (f(x1) - f(xn)) - f(x1) * xn / (f(xn) - f(x1));
		iter := iter + 1;
    until ((abs(xn1 - xn) < eps) AND (abs(f(xn1))<eps) or (iter > itermax));
	writeln ('iter= ' ,iter);
    writeln ('x= ',xn1);
    writeln;
    writeln(outFile, 'Method of back interpolation: iterations  = ', iter, ' x= ', xn1);
    
    close(outFile);
  readln;
end.
