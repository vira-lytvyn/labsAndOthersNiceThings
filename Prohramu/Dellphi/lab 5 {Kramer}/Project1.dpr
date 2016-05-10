program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
const n=3;
      m=4;
function Det (b1, b2, b3, b4, b5, b6, b7, b8, b9 : Real): Real;
begin
    Det:=(b1*b5*b9)+(b2*b6*b7)+(b4*b8*b3)-(b3*b5*b7)-(b6*b8*b1)-(b4*b2*b9);
end;
var a : array [1..n, 1..m] of Real;
    i, j : integer;
    det1, det2, det3, detg, x1, x2, x3: Real;
begin
    writeln ('vvedit rozshyrenu matryzu');
    for i:=1 to n do
    begin
        for j:=1 to m do read(a[i,j]);
        readln;
    end;
    detg:=Det(a[1,1],a[1,2],a[1,3],a[2,1],a[2,2],a[2,3],a[3,1],a[3,2],a[3,3]);
    det1:=Det(a[1,4],a[1,2],a[1,3],a[2,4],a[2,2],a[2,3],a[3,4],a[3,2],a[3,3]);
    det2:=Det(a[1,1],a[1,4],a[1,3],a[2,1],a[2,4],a[2,3],a[3,1],a[3,4],a[3,3]);
    det3:=Det(a[1,1],a[1,2],a[1,4],a[2,1],a[2,2],a[2,4],a[3,1],a[3,2],a[3,4]);
    if (detg=0) and (sqr(det1)+sqr(det2)+sqr(det3)=0)then
    begin
        writeln ('systema maje bezlich rozvayzkiv');
        readln;
        halt;
    end;
    if (detg=0) and (sqr(det1)+sqr(det2)+sqr(det3)<>0)then
    begin
        writeln ('systema ne  maje  rozvayzkiv');
        readln;
        halt;
    end;
    x1:=det1/detg;
    x2:=det2/detg;
    x3:=det3/detg;
    writeln('koreni SLAR taki: x1=', x1:2, '; x2=', x2:2,'; x3=', x3:2);
    readln;
    readln;
end.
