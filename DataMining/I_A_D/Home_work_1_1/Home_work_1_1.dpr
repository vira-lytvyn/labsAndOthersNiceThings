program Home_work_1_1;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var  khar, dod, vid, tzil, drob, parn, neparn : String;
     N : Double;
     n2 : Integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  Writeln('vvedit chyslo');
  Readln(N);

  dod := 'dodatne';
  vid := 'vidjemne';
  tzil := 'tzile';
  drob := 'drobove';
  parn := 'parne';
  neparn := 'neparne';

  khar := 'vvedene chyslo je ';

  if (N > 0) or (N = 0) then
    khar := khar + ' ' + dod
  else
    khar := khar + ' ' + vid;

  if (N - Round(N) = 0) then
  begin
    khar := khar + ' ' + tzil;
    n2 := Round(N);
    if ( n2 mod 2 = 0) then
      khar := khar + ' ' + parn
    else
      khar := khar + ' ' + neparn;
  end
  else
    khar := khar + ' ' + drob;

  Writeln(khar);
  Readln;
end.
