unit imgtotxt;

interface

uses
graphics, classes;

function img2text(bitmap:tbitmap; sjatie:boolean;black,white:string):string;

implementation

function img2text(bitmap:tbitmap; sjatie:boolean;black,white:string):string;
var
 x,y: integer;
 str: string;
 b: tbitmap;
begin
 if sjatie=true
 then
  begin
   b:=tbitmap.Create;
   b.Width:=bitmap.Width;
   b.Height:=bitmap.Height div 2;
   b.Canvas.StretchDraw(rect(0,0,bitmap.Width,bitmap.Height div 2),bitmap)
  end
 else
  begin
   b:=tbitmap.Create;
   b:=bitmap;
  end;

 for y:=0 to b.Height -1 do
  begin
   if y>0
   then str:=str+#13#10;
   for x:=0 to b.Width -1 do
    case b.Canvas.Pixels[x,y] of
     clwhite: str:=str+white;
     clblack: str:=str+black;
     else Exit;
    end;
  end;

 img2text:=str;
end;

end.
