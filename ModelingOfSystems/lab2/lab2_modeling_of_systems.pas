program lab2_modeling_of_systems;
uses crt;
type vec = array [1..6] of real;
type matr = array [1..6, 1..6] of real;
type veci = array [1..6] of integer;
var
   Y, D, temp : vec;
   P : matr;
   i, r, j, x : integer;
   d1, pc : real;

function randomizer(rando : integer) : vec;
var p : vec;
l : veci;
i, ri : integer;
sum, rr : real;

begin
  sum := 0;
    for i:= 1 to 6 do
    begin
      l[i] := 0;
      p[i] := 0;
    end;
   for i := 2 to 6 do
      begin
         p[i] := random(101);
         sum := sum + p[i];
      end;
      for i := 2 to 6 do
      begin
         p[i] := p[i] / sum;
      end;
   for i := 1 to 30 do
      begin
         ri := random(5) + 2;
         rr := random(101)/100;
         if (rr <= p[ri]) then
            begin
         l[ri] := l[ri] + 1;
            end;
      end;
   sum := 0;
   for i := 2 to 6 do
      sum := sum + l[i];
   for i := 2 to 6 do
      p[i] := l[i]/sum;
   randomizer := p;
end;

function GetMaxx(vvv : vec) : integer;
var i, ma : integer;
max : real;
begin
ma := 0;
max := 0;
   for i := 1 to 6 do
      begin
         if vvv[i] >= max then
         begin
         ma := i;
         max := vvv[i];
         end;
      end;
GetMaxx := ma;
end;

BEGIN
clrscr;
randomize;
D := randomizer(5);
r := GetMaxx(d);
for i := 1 to 1000 do
begin
   temp := randomizer(i);
   for j := 1 to 6 do
   begin
      P[r,j] := temp[j];
   end;
   r := GetMaxx(temp);
end;
for i := 1 to 6 do
for j := 1 to 6 do
writeln(p[i,j]:2:2);
   for i := 1 to 5 do
   begin
      Y[i] := random(2);
   end;
   writeln();
   writeln('Primary probability distribution');
      for j := 1 to 2 do
      begin
      if j = 1 then
         write('Z|')
      else
         write('D|');
         for i := 1 to 5 do
            begin
            if j = 1 then
               write(' Z', i, '  ')
            else
               write(' ', D[i]:1:2);
            end;
            writeln();
      end;
   writeln('Output table');
   for j := 1 to 2 do
      begin
      if j = 1 then
         write('Z|')
      else
         write('Y|');
         for i := 1 to 6 do
            begin
            if j = 1 then
               write(' Z', i-1, '  ')
            else
               write(' ', Y[i]:1:2);
            end;
            writeln();
      end;
   writeln('P Matrix');
   write('z0   z1    z2    z3   z4   z5 ');
   for j := 1 to 6 do
      begin
      writeln();
      for i := 1 to 6 do
         begin
            if j = 1 then
              BEGIN
                write(D[i]:1:2, ' ');
              END
            else
              write(P[j, i]:1:2, ' ');
         end;
      end;
end. 
