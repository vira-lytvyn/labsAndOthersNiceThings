unit disktrat;
interface

const max = 70;
Type TJarak = Array [1..max,1..max] of Integer;
  TPath  = record
    nodeke : byte;
    Arraypath : Array [1..max] of byte;
    Jarak     : Integer;
  end;
Procedure RuteTerpendek(var Data : TJarak; var Closed : TPath;var awal,tujuan : byte;count : byte);

Implementation

Procedure RuteTerpendek(var Data : TJarak; var Closed : TPath;var awal,tujuan : byte;count : byte);

Var
  Path : Array [ 1..max] of  TPath;
  Open,Jauh : Array[1..max] of Real ;
  
procedure Initdata(count : byte);
var i,j : byte;
begin
  for i := 1 to count do
  begin
    open[i] := 0 ;
    path[i].Jarak  := 0;
    jauh[i] := data[awal,i] ;
    path[i].arraypath[1] := awal;
    path[i].nodeke := 1;
    path[i].arraypath[2] := i;
    path[i].nodeke := path[i].nodeke + 1;
    path[i].Jarak  := Data[path[i].arraypath[1],path[i].arraypath[2]]
  end;
  open[awal] := awal ;
end;
procedure update_close(var Closed: TPath);
begin
  closed := path[Tujuan] ;
  // Mise a jour de la liste
end ;

function successor(count : byte) : byte ;
var i,j : byte ;
  minimum : Real ;
begin
  minimum := 9999 ;
  for i := 1 to count do
    if (jauh[i] < minimum) and (open[i] = 0) then
  begin
    minimum := jauh[i] ;
    j := i ;
  end ;
  successor := j ;
  // Tous les successeur
end ;

procedure lessthen(count,x : byte) ;
var i : byte ;
  a,b : Real ;
begin
  for i := 1 to count do
  begin
    a := jauh[x] + data[x,i] ;
    b := jauh[i] ;
    if a < b then  // Comparaison Efficace
    begin
      jauh[i] := a ;
      path[i] := path[x];
      path[i].nodeke := path[i].nodeke + 1;
      path[i].arraypath[path[i].nodeke] := i;
      path[i].Jarak  := path[i].Jarak + Data[path[i].arraypath[path[i].nodeke-1],path[i].arraypath[path[i].nodeke]]
    end;
  end ;
end ;

procedure disktra(count : byte) ;
var i,j : byte ;
begin
  for i := 1 to count do
  begin
    lessthen(count,successor(count)) ;
    update_close(closed);
    open[successor(count)] := successor(count) ;
  end ;
end ;
begin
  initdata(count);
  disktra(count);
end;

end.
