program Home_work_1_2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var a, b, d, R : Double;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  writeln ('vvedit radius stola');
  Readln(R);
  Writeln ('vvedit rozmiry prystroju a= ; b= ;');
  Readln (a,b);
  d := sqrt (sqr(a) + sqr(b)) ;
  if (d > R) then
    Writeln('Prystrij ne pomistytsja na stoli radiusa ', R);
  if (d < R) or (d = R) then
    Writeln('Prystrij pomistytsja na stoli radiusa ', R);

  Readln;
end.
