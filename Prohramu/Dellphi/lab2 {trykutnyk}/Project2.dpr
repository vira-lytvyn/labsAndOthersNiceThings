program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

function Storona (k1, k2, l1, l2: Real) : Real;
begin
    Storona := sqrt(sqr(k2-k1)+sqr(l2-l1));
end;
var x1, x2, x3, x, y1, y2, y3, y, p, p1,p2,p3,b1,b2,b3, s, s1, s2, s3, a1, a2, a3:real;
begin
    writeln('vvedit koordunaty pershoi tochku');
    readln(x1,y1);
    writeln('vvedit koordunaty dryhoi tochku');
    readln(x2,y2);
    writeln('vvedit koordunaty tretoi tochku');
    readln(x3,y3);
    writeln('vvedit koordunaty doslidzyvanoi tochky');
    readln(x,y);
    a1:=Storona(x2, x1, y2, y1);
    a2:=Storona(x3, x1, y3, y1);
    a3:=Storona(x3, x2, y3, y2);
    p:=(a3+a1+a2)/2;
    s:=sqrt(p*(p-a1)*(p-a2)*(p-a3));
    b1:=Storona(x, x1, y, y1);
    b2:=Storona(x, x2, y, y2);
    b3:=Storona(x, x3, y, y3);
    p1:=(a1+b1+b2)/2;
    p2:= (a2+b1+b3)/2;
    p3:=(a3+b2+b3)/2;
    s1:=sqrt(p1*(p1-a1)*(p1-b1)*(p1-b2));
    if  ((x1=x) and (y1=y)) or ((x2=x) and (y2=y)) or ((x3=x) and (y3=y)) then
        begin
            writeln ('tochka je vershunoy trukytnuka');
            readln;
            halt;
        end;
    if s1=0 then
        begin
            writeln('tochka potraplyae na storny a1');
            readln;
            halt;
        end;
        s2:=sqrt(p2*(p2-a2)*(p2-b1)*(p2-b3));
        if s2=0 then
        begin
            writeln('tochka potraplyae na storny a2');
            readln;
            halt;
        end;
        s3:=sqrt(p3*(p3-a3)*(p3-b2)*(p3-b3));
        if s3=0 then
            begin
                writeln('tochka potraplyae na storny a3');
                readln;
                halt;
            end;
        if abs(s-(s1+s2+s3))<= exp(8)  then
            begin
                writeln('tochka potraplaye v ploshchuny trukytnuka') ;
                readln;
            end
                else
                    begin
                        writeln('tochka za mezamu trukytnuka');
                        readln;
                    end;
end.

