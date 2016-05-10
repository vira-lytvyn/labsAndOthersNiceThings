program Project3;

{$APPTYPE CONSOLE}

uses
    SysUtils;
  
var a, z, x1, x2, dx, b , E:real;
    Kmax, k: integer;
Function F( x: Real): Real;
Begin
    //F:=3*x-4*ln(x)-5;
    f:=(abs(x*11e10*(-4.5810291)/3/1.47398e10)-abs(8.85e-12*0.34*1.47398e10*sqr((-4.5810291))/4))/(1-0.34) - 2.042;
END;
Function  P1 (x, dx:Real):Real;
Begin
    P1:=(F(x+dx)-F(x))/dx;
End;
Function  P2 (x, dx:Real):Real;
Begin
    P2:=(F(x+dx)+F(x-dx)-2*F(x))/(dx*dx);
End;
BEGIN
    writeln('vvedit mezi a, b');
    readln (a, b);
    writeln('vvedit tochnist E=  ta kilkist iteratsij Kmax=');
    readln (E, Kmax);
    if E<=0 then
    begin
        writeln ('vvedena pohybka je ne korektnojy');
        readln;
        halt;
    end;
    writeln('vvedit pryblyzne znachennya arhymentu x1=');
    readln (x1);
    {if x1<=E then
    begin
        writeln (' ne korektne znachenna x1, x1>0');
        readln;
        halt;
    end;     }
    if a>b then
    begin
        z:=a;
        a:=b;
        b:=z;
    end;
    k:=0;
    dx:= E/1000.0;
    x2:=x1-(F(x1)/P1(x1,dx));
    if abs(F(x1)/P1(x1,dx))<E then
    begin
        writeln ('korin x=', x2);
        readln;
        halt;
    end
    else
    repeat
        x1:=x2;
        x2:=x1-(F(x1)/P1(x1,dx));
        k:=k+1;
    until abs(x2-x1)>=E;
    if k>=Kmax then
    begin
        writeln ('za zadanu kilkist iteratzij korenay ne znajdeno');
        readln;
        halt;
    end;
    if (F(b)*P2(b,dx)<0) or (F(a)*P2(a,dx)<0)then
    writeln ('korin ne isnuje abo bude znajdenyj netochno');
    writeln ('korin x=', x2, ' znajdeno za k=', k, ' iterazij');
    readln;
end.
