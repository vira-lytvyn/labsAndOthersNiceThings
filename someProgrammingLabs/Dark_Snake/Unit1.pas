// А.Мясников, DarkSoftware


unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls, math, ImgList, ComCtrls;

type
  TForm1 = class(TForm)
    DrawGrid: TDrawGrid;
    BitBtn1: TBitBtn;
    Timer: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    il: TImageList;
    Label5: TLabel;
    Label6: TLabel;
    Memo1: TRichEdit;
    wsb: TComboBox;
    Label7: TLabel;
    PBX: TProgressBar;
    PBY: TProgressBar;
    Label8: TLabel;
    Label9: TLabel;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure TimerTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
  procedure GameOver;
  procedure RandomObjects;
  procedure CheckPrize(x,y: integer);
    { Public declarations }
  end;

var
  Form1: TForm1;


var map: array [0..599,0..599] of TColor;
var cnt: integer = 0;
var money: integer=0;
var gun: integer=0;
var stop: boolean=false;

type tdir = (_up,_down, _left ,_right);

type TSC= record
dir: tdir;
ldir: tdir;
posx: integer;
posy: integer;
lposx: integer;
lposy: integer;
end;

var Serpent: array of TSC=nil;
var Sirpent: array of TSC=nil;
var tSirpent: array of TSC=nil;

var Bullet: array of TSC=nil;

var world: integer=25;


var rndw: integer=0;

implementation

{$R *.dfm}


procedure TForm1.RandomObjects;
var i, n, c, max: integer;
begin
max:=randomrange((world div 25)+2,(world div 9)+4);
c:=0;

repeat
if stop then
begin
timer.Enabled:=false;
stop:=false;
exit;
end;

i:=random(world-1);
n:=random(world-1);

if map[i,n]=clWhite then begin

case random (100) of
0..25: begin
map[i,n]:=clRed;
inc(c);
if c=max then exit;
end;

26..50:
begin
map[i,n]:=clGreen;
inc(c);
if c=max then exit;
end;

51..65:
begin
map[i,n]:=clBlue;
inc(c);
if c=max then exit;
end;

66..75:
begin
map[i,n]:=clMaroon;
inc(c);
if c=max then exit;
end;

76..80:
begin
map[i,n]:=clGray;
inc(c);
if c=max then exit;
end;


81..87:
begin
map[i,n]:=clSkyBlue;
inc(c);
if c=max then exit;
end;


end;


end;

until c=max;


end;

procedure TForm1.CheckPrize(x,y: integer);
begin
if map[x,y] in [4..6] then begin
GameOver();
ShowMessage('Змейку съели!');
exit;
end
else
if map[x,y]=clRed then begin
GameOver();
ShowMessage('Змейка отравилась!');
exit;
end
else if map[x,y]=clGreen then begin
money:=money+Trunc(randomrange(7,10)*length(Serpent)*0.6);
end
else if map[x,y]=clBlue then begin
SetLength (Serpent, (Length(Serpent)+1));
end
else if map[x,y]=clMaroon then begin
if timer.Interval>10 then timer.Interval:=timer.Interval-5;
end
else if map[x,y]=clGray then begin
timer.Interval:=timer.Interval+5;
end
else if map[x,y]=clSkyBlue then begin
inc(gun,2);
end

end;

procedure TForm1.GameOver;
begin
Timer.Enabled:=false;
wsb.Enabled:=true;
ShowMessage('Вот и все!');
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var i,n: integer;
begin
world:=strtointdef(wsb.Text,25);
wsb.Enabled:=false;
drawgrid.ColCount:=world;
drawgrid.RowCount:=world;
pbx.Max:=world;
pby.Max:=world;
Timer.Interval:=120;
SetLength(Serpent,2);
SetLength(Sirpent,5);
cnt:=0;
money:=0;
gun:=0;

for i:=0 to High(Serpent) do begin
Serpent[i].dir:=_right;
Serpent[i].posx:=length(Serpent)-i;
Serpent[i].posy:=0;
Serpent[i].lposx:=(length(Serpent)-i)-1;
Serpent[i].lposy:=0;
end;

for i:=0 to High(Sirpent) do begin
Sirpent[i].dir:=_right;
Sirpent[i].posx:=length(Sirpent)-i;
Sirpent[i].posy:=world-1;
Sirpent[i].lposx:=(length(Sirpent)-i)-1;
Sirpent[i].lposy:=0;
end;


for i:=0 to world-1 do
for n:=0 to world-1 do
map[i,n]:=clWhite;

DrawGrid.Canvas.Create;
Timer.Enabled:=true;
randomobjects();
end;

procedure TForm1.DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin

if map[ACol, ARow]=1 then begin

DrawGrid.Canvas.Brush.Color:=clWhite;
DrawGrid.Canvas.FillRect(Rect);



if length(serpent)>0 then begin

case serpent[0].dir of
_up: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,0);
end;
_down: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,1);
end;
_left: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,2);
end;
_right: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,3);
end;

end;


end;


end  else


if map[ACol, ARow] in [2..3] then begin

DrawGrid.Canvas.Brush.Color:=clWhite;
DrawGrid.Canvas.FillRect(Rect);



if length(serpent)>0 then begin

case serpent[0].dir of
_up: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,4);
end;
_down: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,5);
end;
_left: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,6);
end;
_right: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,7);
end;
end;
end;

end



else begin
DrawGrid.Canvas.Brush.Color:=map[ACol, ARow];
DrawGrid.Canvas.FillRect(Rect);

end;


////
if map[ACol, ARow]=4 then begin

DrawGrid.Canvas.Brush.Color:=clWhite;
DrawGrid.Canvas.FillRect(Rect);



if length(sirpent)>0 then begin

case sirpent[0].dir of
_up: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,8);
end;
_down: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,9);
end;
_left: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,10);
end;
_right: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,11);
end;

end;


end;


end  else


if map[ACol, ARow] in [5..6] then begin

DrawGrid.Canvas.Brush.Color:=clWhite;
DrawGrid.Canvas.FillRect(Rect);



if length(serpent)>0 then begin

case sirpent[0].dir of
_up: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,12);
end;
_down: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,13);
end;
_left: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,14);
end;
_right: begin
il.Draw(DrawGrid.Canvas,rect.Left,rect.Top,15);
end;
end;
end;

end;





////

end;



procedure TForm1.TimerTimer(Sender: TObject);
var i: integer;a,b: integer; SirpentSmaller: boolean;
begin

application.ProcessMessages;


if stop then
begin
timer.Enabled:=false;
stop:=false;
exit;
end;


SirpentSmaller:=false;

{

/-----------------------------------/

inc(rndw,randomrange(1,3));

if rndw>randomrange(55,90) then begin
rndw:=0;
case randomrange(0,3) of
0:  if Sirpent[0].dir<>_down then
begin
Sirpent[0].ldir:=sirpent[0].dir;
Sirpent[0].dir:=_up;
end;
1:  if Sirpent[0].dir<>_up then
begin
Sirpent[0].ldir:=sirpent[0].dir;
Sirpent[0].dir:=_down;
end;
2:  if Sirpent[0].dir<>_right then
begin
Sirpent[0].ldir:=sirpent[0].dir;
Sirpent[0].dir:=_left;
end;
3:  if Sirpent[0].dir<>_left then
begin
Sirpent[0].ldir:=sirpent[0].dir;
Sirpent[0].dir:=_right;
end;
end;
end else

/-----------------------------------/

}

begin
a:=(Sirpent[0].posx-Serpent[0].posx);
b:=(Sirpent[0].posy-Serpent[0].posy);
if abs(a)<abs(b) then
begin

if a>0 then
begin

if sirpent[0].dir<>_right then
sirpent[0].dir:=_left
///
 else begin

if b>0 then
begin
if sirpent[0].dir<>_down then
sirpent[0].dir:=_up
end
else

begin
if sirpent[0].dir<>_up then
sirpent[0].dir:=_down
///
 else begin

if b>0 then
begin
if sirpent[0].dir<>_down then
sirpent[0].dir:=_up
end
else

begin
if sirpent[0].dir<>_up then
sirpent[0].dir:=_down;
end;

end; ///

end;

end; ///


end

else
begin
if sirpent[0].dir<>_left then
sirpent[0].dir:=_right
///
 else begin

if b>0 then
begin
if sirpent[0].dir<>_down then
sirpent[0].dir:=_up


else ///

begin

if a>0 then
begin

if sirpent[0].dir<>_right then
sirpent[0].dir:=_left
end

else
begin
if sirpent[0].dir<>_left then
sirpent[0].dir:=_right

end

end ///

end
else

begin
if sirpent[0].dir<>_up then
sirpent[0].dir:=_down


else ///

begin

if a>0 then
begin

if sirpent[0].dir<>_right then
sirpent[0].dir:=_left
end

else
begin
if sirpent[0].dir<>_left then
sirpent[0].dir:=_right

end

end ///


end;

end; ///


end

end

///
 else begin

if b>0 then
begin
if sirpent[0].dir<>_down then
sirpent[0].dir:=_up
end
else

begin
if sirpent[0].dir<>_up then
sirpent[0].dir:=_down;
end;

end; ///

end;

if (not (drawgrid.Focused)) then if

drawgrid.CanFocus then drawgrid.SetFocus;





/////////
//////////////
for i:=0 to High(Sirpent) do begin


if i>High(Sirpent) then break;

if i=0 then begin

case Sirpent[i].dir of

_up: begin

Sirpent[i].lposy:=Sirpent[i].posy;
Sirpent[i].lposx:=Sirpent[i].posx;
Sirpent[i].ldir:=Sirpent[i].dir;
if sirpent[i].posy>0 then
sirpent[i].posy:=sirpent[i].posy-1 else
begin
if sirpent[i].posx>10 then Sirpent[i].dir:=_left else Sirpent[i].dir:=_right;
Sirpent[i].ldir:=Sirpent[i].dir;
end;

if Map[sirpent[i].posx, sirpent[i].posy]=clRed
then
begin
if Length(Sirpent)>2 then
SirpentSmaller:=true;
end;

if Map[sirpent[i].posx, sirpent[i].posy] = clBlue
then
begin
SetLength(Sirpent,Length(Sirpent)+1);
end;


if Map[sirpent[i].posx, sirpent[i].posy] in [1..3]
then
begin
GameOver();
ShowMessage('Змейку съели!');
end;

Map[sirpent[i].posx, sirpent[i].posy]:=4;
Map[sirpent[i].lposx, sirpent[i].lposy]:=clWhite;

end;

_down: begin
sirpent[i].lposy:=sirpent[i].posy;
sirpent[i].lposx:=sirpent[i].posx;
sirpent[i].ldir:=sirpent[i].dir;
if sirpent[i].posy<world-1 then
sirpent[i].posy:=sirpent[i].posy+1 else
begin
if sirpent[i].posx>10 then Sirpent[i].dir:=_left else Sirpent[i].dir:=_right;
Sirpent[i].ldir:=Sirpent[i].dir;
end;

if Map[sirpent[i].posx, sirpent[i].posy]=clRed
then
begin
if Length(Sirpent)>2 then
SirpentSmaller:=true;
end;

if Map[sirpent[i].posx, sirpent[i].posy] = clBlue
then
begin
SetLength(Sirpent,Length(Sirpent)+1);
end;


if Map[sirpent[i].posx, sirpent[i].posy] in [1..3]
then
begin
GameOver();
ShowMessage('Змейку съели!');
end;

Map[sirpent[i].posx, sirpent[i].posy]:=4;
Map[sirpent[i].lposx, sirpent[i].lposy]:=clWhite;
end;

_right: begin
sirpent[i].lposy:=sirpent[i].posy;
sirpent[i].lposx:=sirpent[i].posx;
sirpent[i].ldir:=sirpent[i].dir;
if sirpent[i].posx<world-1 then
sirpent[i].posx:=sirpent[i].posx+1 else
begin
if sirpent[i].posy>10 then Sirpent[i].dir:=_up else Sirpent[i].dir:=_down;
Sirpent[i].ldir:=Sirpent[i].dir;

end;

if Map[sirpent[i].posx, sirpent[i].posy]=clRed
then
begin
if Length(Sirpent)>2 then
SirpentSmaller:=true;
end;

if Map[sirpent[i].posx, sirpent[i].posy] = clBlue
then
begin
SetLength(Sirpent,Length(Sirpent)+1);
end;


if Map[sirpent[i].posx, sirpent[i].posy] in [1..3]
then
begin
GameOver();
ShowMessage('Змейку съели!');
end;


Map[sirpent[i].posx, sirpent[i].posy]:=4;
Map[sirpent[i].lposx, sirpent[i].lposy]:=clWhite;
end;

_left: begin
sirpent[i].lposy:=sirpent[i].posy;
sirpent[i].lposx:=sirpent[i].posx;
sirpent[i].ldir:=sirpent[i].dir;
if sirpent[i].posx>0 then
sirpent[i].posx:=sirpent[i].posx-1 else
begin
if sirpent[i].posy>10 then Sirpent[i].dir:=_up else Sirpent[i].dir:=_down;
Sirpent[i].ldir:=Sirpent[i].dir;

end;

if Map[sirpent[i].posx, sirpent[i].posy]=clRed
then
begin
if Length(Sirpent)>2 then
SirpentSmaller:=true;
end;

if Map[sirpent[i].posx, sirpent[i].posy] = clBlue
then
begin
SetLength(Sirpent,Length(Sirpent)+1);
end;


if Map[sirpent[i].posx, sirpent[i].posy] in [1..3]
then
begin
GameOver();
ShowMessage('Змейку съели!');
end;

Map[sirpent[i].posx, sirpent[i].posy]:=4;
Map[sirpent[i].lposx, sirpent[i].lposy]:=clWhite;
end;

end;

end else begin
sirpent[i].lposy:=sirpent[i].posy;
sirpent[i].lposx:=sirpent[i].posx;
sirpent[i].ldir:=sirpent[i].dir;
sirpent[i].posx:=sirpent[i-1].lposx;
sirpent[i].posy:=sirpent[i-1].lposy;
sirpent[i].dir:=sirpent[i-1].dir;

if i=high(sirpent) then
Map[sirpent[i].posx, sirpent[i].posy]:=6 else
Map[sirpent[i].posx, sirpent[i].posy]:=5;
Map[sirpent[i].lposx, sirpent[i].lposy]:=clWhite;

end;

end;

//////////////

/////////





for i:=0 to High(Serpent) do begin

if i=0 then begin

case Serpent[i].dir of

_up: begin

Serpent[i].lposy:=Serpent[i].posy;
Serpent[i].lposx:=Serpent[i].posx;
Serpent[i].ldir:=Serpent[i].dir;
if serpent[i].posy>0 then
Serpent[i].posy:=Serpent[i].posy-1 else
begin
GameOver();
ShowMessage('Змейка разбилась насмерть!');
end;
CheckPrize(Serpent[i].posx, Serpent[i].posy);
Map[Serpent[i].posx, Serpent[i].posy]:=1;
Map[Serpent[i].lposx, Serpent[i].lposy]:=clWhite;

end;

_down: begin
Serpent[i].lposy:=Serpent[i].posy;
Serpent[i].lposx:=Serpent[i].posx;
Serpent[i].ldir:=Serpent[i].dir;
if serpent[i].posy<world-1 then
Serpent[i].posy:=Serpent[i].posy+1 else
begin
GameOver();
ShowMessage('Змейка разбилась насмерть!');
end;

CheckPrize(Serpent[i].posx, Serpent[i].posy);
Map[Serpent[i].posx, Serpent[i].posy]:=1;
Map[Serpent[i].lposx, Serpent[i].lposy]:=clWhite;
end;

_right: begin
Serpent[i].lposy:=Serpent[i].posy;
Serpent[i].lposx:=Serpent[i].posx;
Serpent[i].ldir:=Serpent[i].dir;
if serpent[i].posx<world-1 then
Serpent[i].posx:=Serpent[i].posx+1 else
begin
GameOver();
ShowMessage('Змейка разбилась насмерть!');
end;

CheckPrize(Serpent[i].posx, Serpent[i].posy);
Map[Serpent[i].posx, Serpent[i].posy]:=1;
Map[Serpent[i].lposx, Serpent[i].lposy]:=clWhite;
end;

_left: begin
Serpent[i].lposy:=Serpent[i].posy;
Serpent[i].lposx:=Serpent[i].posx;
Serpent[i].ldir:=Serpent[i].dir;
if serpent[i].posx>0 then
Serpent[i].posx:=Serpent[i].posx-1 else
begin
GameOver();
ShowMessage('Змейка разбилась насмерть!');
end;

CheckPrize(Serpent[i].posx, Serpent[i].posy);
Map[Serpent[i].posx, Serpent[i].posy]:=1;
Map[Serpent[i].lposx, Serpent[i].lposy]:=clWhite;
end;

end;

end else begin
Serpent[i].lposy:=Serpent[i].posy;
Serpent[i].lposx:=Serpent[i].posx;
Serpent[i].ldir:=Serpent[i].dir;
Serpent[i].posx:=Serpent[i-1].lposx;
Serpent[i].posy:=Serpent[i-1].lposy;
Serpent[i].dir:=Serpent[i-1].dir;
if i=high(serpent) then
Map[Serpent[i].posx, Serpent[i].posy]:=3 else
Map[Serpent[i].posx, Serpent[i].posy]:=2;
Map[Serpent[i].lposx, Serpent[i].lposy]:=clWhite;

end;

end;


if length(bullet)>0 then

case bullet[0].dir of

_up: begin

Bullet[0].lposy:=Bullet[0].posy;
Bullet[0].lposx:=Bullet[0].posx;
Bullet[0].ldir:=Bullet[0].dir;
if Bullet[0].posy>0 then
begin
Bullet[0].posy:=Bullet[0].posy-1;

if Map[Bullet[0].posx, Bullet[0].posy]=clWhite then
Map[Bullet[0].posx, Bullet[0].posy]:=clPurple else begin
if Map[Bullet[0].posx, Bullet[0].posy]=clRed then inc(money,5);
if Map[Bullet[0].posx, Bullet[0].posy] in [4..6] then SetLength(Sirpent,(length(sirpent)+1));
Map[Bullet[0].lposx, Bullet[0].lposy]:=clWhite;
Map[Bullet[0].posx, Bullet[0].posy]:=clWhite;
SetLength(Bullet,0);
end;
if length(bullet)>0 then Map[Bullet[0].lposx, Bullet[0].lposy]:=clWhite;

end
 else
begin

Map[Bullet[0].posx, Bullet[0].posy]:=clWhite;
SetLength(Bullet,0);
end;


end;

_down: begin
Bullet[0].lposy:=Bullet[0].posy;
Bullet[0].lposx:=Bullet[0].posx;
Bullet[0].ldir:=Bullet[0].dir;
if Bullet[0].posy<world-1 then
begin
Bullet[0].posy:=Bullet[0].posy+1;
if Map[Bullet[0].posx, Bullet[0].posy]=clWhite then
Map[Bullet[0].posx, Bullet[0].posy]:=clPurple else begin
if Map[Bullet[0].posx, Bullet[0].posy] in [4..6] then SetLength(Sirpent,(length(sirpent)+1));
if Map[Bullet[0].posx, Bullet[0].posy]=clRed then inc(money,5);
Map[Bullet[0].lposx, Bullet[0].lposy]:=clWhite;
Map[Bullet[0].posx, Bullet[0].posy]:=clWhite;
SetLength(Bullet,0);
end;
if length(bullet)>0 then Map[Bullet[0].lposx, Bullet[0].lposy]:=clWhite;

end
 else
begin
Map[Bullet[0].posx, Bullet[0].posy]:=clWhite;
SetLength(Bullet,0);
end;

end;

_right: begin
Bullet[0].lposy:=Bullet[0].posy;
Bullet[0].lposx:=Bullet[0].posx;
Bullet[0].ldir:=Bullet[0].dir;
if Bullet[0].posx<world-1 then
begin
Bullet[0].posx:=Bullet[0].posx+1;
if Map[Bullet[0].posx, Bullet[0].posy]=clWhite then
Map[Bullet[0].posx, Bullet[0].posy]:=clPurple else begin
if Map[Bullet[0].posx, Bullet[0].posy] in [4..6] then SetLength(Sirpent,(length(sirpent)+1));
if Map[Bullet[0].posx, Bullet[0].posy]=clRed then inc(money,5);
Map[Bullet[0].lposx, Bullet[0].lposy]:=clWhite;
Map[Bullet[0].posx, Bullet[0].posy]:=clWhite;
SetLength(Bullet,0);
end;
if length(bullet)>0 then Map[Bullet[0].lposx, Bullet[0].lposy]:=clWhite;

end
else
begin
Map[Bullet[0].lposx, Bullet[0].lposy]:=clWhite;
Map[Bullet[0].posx, Bullet[0].posy]:=clWhite;
SetLength(Bullet,0);
end;

end;

_left: begin
Bullet[0].lposy:=Bullet[0].posy;
Bullet[0].lposx:=Bullet[0].posx;
Bullet[0].ldir:=Bullet[0].dir;
if Bullet[0].posx>0 then
begin
Bullet[0].posx:=Bullet[0].posx-1;
if Map[Bullet[0].posx, Bullet[0].posy]=clWhite then
Map[Bullet[0].posx, Bullet[0].posy]:=clPurple else begin
if Map[Bullet[0].posx, Bullet[0].posy] in [4..6] then SetLength(Sirpent,(length(sirpent)+1));
if Map[Bullet[0].posx, Bullet[0].posy]=clRed then inc(money,5);
Map[Bullet[0].lposx, Bullet[0].lposy]:=clWhite;
Map[Bullet[0].posx, Bullet[0].posy]:=clWhite;
SetLength(Bullet,0);
end;
if length(bullet)>0 then Map[Bullet[0].lposx, Bullet[0].lposy]:=clWhite;

end
 else
begin
Map[Bullet[0].posx, Bullet[0].posy]:=clWhite;
SetLength(Bullet,0);
end;
end;
end;

label1.Caption:=Format('%d : %d',[Serpent[0].posx,Serpent[0].posy]);
label2.Caption:=Format('%d USD',[money]);
label6.Caption:=Format('%d',[gun]);


if serpent[0].dir=_right then begin

if serpent[0].posx+20<world-1 then
DrawGrid.Col:=serpent[0].posx+20 else DrawGrid.Col:=world-1;
end;


if serpent[0].dir=_down then begin
if serpent[0].posy+20<world-1 then
DrawGrid.Row:=serpent[0].posy +20 else DrawGrid.Row:=world-1;
end;


if serpent[0].dir=_left then begin
if serpent[0].posx-20>0 then
DrawGrid.Col:=serpent[0].posx -20 else DrawGrid.Col:=0;
end;

if serpent[0].dir=_up then begin
if serpent[0].posy-20>0 then
DrawGrid.Row:=serpent[0].posy-20 else DrawGrid.Row:=0;
end;

pbx.Position:=DrawGrid.Col;
pby.Position:=DrawGrid.Row;

if cnt<80 then begin
inc(cnt);
end else begin
cnt:=0;
randomobjects();
end;



DrawGrid.Repaint;


if SirpentSmaller then begin

for i:=0 to High(Sirpent) do begin
Map[Sirpent[i].posx,Sirpent[i].posy]:=clWhite;
end;

SetLength(tSirpent,Length(Sirpent)-1);
for i:=0 to High(tSirpent) do begin
tSirpent[i]:=Sirpent[i];
end;
SetLength(Sirpent,Length(Sirpent)-1);
for i:=0 to High(Sirpent) do begin
Sirpent[i]:=tSirpent[i];
end;


end;



end;



procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin


if length(serpent)>0 then begin

case key of
vk_Up:
begin
if Serpent[0].dir<>_down then
Serpent[0].dir:=_up;
end;
vk_Down:
begin
if Serpent[0].dir<>_up then
Serpent[0].dir:=_down;
end;
vk_Left:
begin
if Serpent[0].dir<>_right then
Serpent[0].dir:=_left;
end;
vk_Right:
begin
if Serpent[0].dir<>_left then
Serpent[0].dir:=_right;
end;


vk_return: begin
if (length(bullet)>0) or (gun=0) then exit;
case serpent[0].dir of
_up:
begin
if serpent[0].posy>2 then begin
dec(gun);
setlength(bullet,1);
bullet[0].dir:=serpent[0].dir;
bullet[0].posx:=serpent[0].posx;
bullet[0].posy:=serpent[0].posy-2;
bullet[0].lposx:=bullet[0].posx;
bullet[0].lposy:=bullet[0].posy;

end;
end;
_down:
begin
if serpent[0].posy<world-3 then begin
dec(gun);
setlength(bullet,1);
bullet[0].dir:=serpent[0].dir;
bullet[0].posx:=serpent[0].posx;
bullet[0].posy:=serpent[0].posy+2;
bullet[0].lposx:=bullet[0].posx;
bullet[0].lposy:=bullet[0].posy;

end;
end;

_left:
begin
if serpent[0].posx>2 then begin
dec(gun);
setlength(bullet,1);
bullet[0].dir:=serpent[0].dir;
bullet[0].posx:=serpent[0].posx-2;
bullet[0].posy:=serpent[0].posy;
bullet[0].lposx:=bullet[0].posx;
bullet[0].lposy:=bullet[0].posy;

end;
end;

_right:
begin
if serpent[0].posx<world-3 then begin
dec(gun);
setlength(bullet,1);
bullet[0].dir:=serpent[0].dir;
bullet[0].posx:=serpent[0].posx+2;
bullet[0].posy:=serpent[0].posy;
bullet[0].lposx:=bullet[0].posx;
bullet[0].lposy:=bullet[0].posy;

end;
end;

end;



end;
end;
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i, n: integer;
begin
Randomize();

for i:=0 to 49 do
for n:=0 to 49 do
map[i,n]:=clWhite;

for i:=1 to 30 do begin
wsb.Items.Add(inttostr(i*20))
end;

wsb.ItemIndex:=0;

Memo1.SelStart:=1;
Memo1.SelAttributes.Color:=clGreen;
Memo1.Lines.Add('Очки');
Memo1.SelAttributes.Color:=clBlue;
Memo1.Lines.Add('Рост');
Memo1.SelAttributes.Color:=clMaroon;
Memo1.Lines.Add('Скорость');
Memo1.SelAttributes.Color:=clGray;
Memo1.Lines.Add('Замедление');
Memo1.SelAttributes.Color:=clSkyBlue;
Memo1.Lines.Add('Снаряд');
Memo1.SelAttributes.Color:=clRed;
Memo1.Lines.Add('Яд');
Memo1.SelectAll;
Memo1.SelAttributes.Style:=[fsBold];

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
stop:=true;
GameOver();
end;

end.
