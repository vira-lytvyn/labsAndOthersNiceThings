program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var x1, x2, x3, a, l, E:real;
    k:integer;
begin
    writeln ('vvedit doslidjzyvane chuslo a= ta pohubky E=');
    readln(a, E);
    if a<0 then
    begin
        writeln('korin ne vuznachenuj na mnozuni dijsnux chusel');
        readln;
        halt;
    end;
    if E<0 then
    begin
        writeln('pohybka ne moze butu vidjemnoju');
        readln;
        halt;
    end;
    if a=0 then
    begin
        writeln('korin x=0');
        readln;
        halt;
    end;
    writeln ('vvedit prubluzne znachennya korenya l= ');
    readln(l);
    x1:=l;
    x2:=0.5*(x1 + (a/x1));
    x3:=-x2;
    k:=1;
    while abs(x2-x1)>E do
    begin
        x1:=x2;
        x2:=0.5*(x1 + (a/x1));
        x3:=-1*(x2);
        k:=k+1;
    end;
    if k=1 then writeln ('Vu vvelu odyn iz koreniv');
    writeln ('koreni x1=', x2, ' x2=', x3,'za k=', k, ' podiliv');
    readln;
end.
 