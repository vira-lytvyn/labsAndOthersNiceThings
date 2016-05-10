unit _vec2d;

interface

uses math;

type tvector2=record
x,y:single;
end;


type TRGB = record
             r,g,b:single;
            end;

type TRGBB = record
             r,g,b:byte;
            end;

type TUV = record
             u,v:single;
            end;


type TVector2D = record
                  u,v:single;
                 end;




function projvect2(a,b:tvector2):tvector2;
function normaliz2(n:tvector2):tvector2;
function dotvector2(v1,v2:tvector2):single;

function IntersectCircleLine(center,p1,p2:tvector2;radius:single):integer;

function ispnt(x,y,x0,y0,x1,y1:single):boolean;

implementation

function ispnt(x,y,x0,y0,x1,y1:single):boolean;
var center,p1,p2:tvector2;
//a,b,c:tvector2;
//x,y:single;
begin
(*
b.x:=x1-x0;
b.y:=y1-y0;

         c.x:=-b.y;
         c.y:=b.x;

c:=normaliz2(c);

x:=zx-c.x*0.5;
y:=zy-c.y*0.5;

(*
center.x:=x;
center.y:=y;
p1.x:=x0;
p2.x:=x1;
p1.y:=y0;
p2.y:=y1;*)

if (y-y0)*(x1-x0)-(x-x0)*(y1-y0)>0 then
 result:=not true
 else
 result:=not false;
(*

if IntersectCircleLine(center,p1,p2,0.5)>0 then
 result:=not true
 else
 result:=not false;
*)
end;

function IntersectCircleLine(center,p1,p2:tvector2;radius:single):integer;
var x01,y01,x02,y02,dx,dy,a,b,c:single;
begin
   x01:=p1.x-center.x;
   y01:=p1.y-center.y;
   x02:=p2.x-center.x;
   y02:=p2.y-center.y;

   dx:=x02-x01;
   dy:=y02-y01;

   a:=dx*dx+dy*dy;
   b:=2.0*(x01*dx+y01*dy);
   c:=x01*x01+y01*y01-radius*radius;

//   clrscr;

//   writeln(round(a), ' ',round(b), ' ',round(c));

  if (-b<0) then
   begin
    if (c<0) then result:=1 else result:=0;
//    writeln('A');
    exit;
   end;

  if (-b<(2.0*a)) then
   begin
    if (4.0*a*c-b*b<0) then result:=2 else result:=0;
//    writeln('B');
    exit;
   end;

  if (a+b+c<0) then begin
   result:=3;
//    writeln('C');
   end
   else result:=0;




end;





function dotvector2(v1,v2:tvector2):single;
begin
 result:=v1.x*v2.x+v1.y*v2.y;
end;

function normaliz2(n:tvector2):tvector2;
var l:single;
tm:tvector2;
begin
l:=sqrt(n.x*n.x+n.y*n.y);
if l<>0 then
begin
tm.x:=n.x/l;
tm.y:=n.y/l;
end;
result:=tm;
end;


function projvect2(a,b:tvector2):tvector2;
var proj:tvector2;
    dp:single;

begin
dp:= (a.x*b.x + a.y*b.y);
proj.x:= ( dp / (b.x*b.x + b.y*b.y) ) * b.x;
proj.y:= ( dp / (b.x*b.x + b.y*b.y) ) * b.y;
result:=proj;

end;






end.