unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Buttons, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpinEdit1: TSpinEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    SpeedButton2: TSpeedButton;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpinEdit5: TSpinEdit;
    Image2: TPaintBox;
    Image1: TPaintBox;
    Panel6: TPanel;
    Image3: TPaintBox;
    Panel5: TPanel;
    SpeedButton3: TSpeedButton;
    Label8: TLabel;
    SpinEdit6: TSpinEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    SpinEdit7: TSpinEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  rnd,x1,x2,x3,y1,y2,y3,FinalAge:integer;
  c:char;
  ot:string;
cc,AngleR,AngleL,StartAngle,ConCoef:Real;
implementation

{$R *.dfm}
{Treugolnik Serpinskogo}


procedure Line(x1,y1,x2,y2:real; C:TCanvas);
begin
 c.Moveto(round(x1),round(y1));
 c.lineto(round(x2),round(y2));
 end;

Procedure TriS(age:integer;x1,y1,x2,y2,x3,y3:real);
var
xd,yd,xe,ye,xf,yf:real;
begin
inc(age);

if age= FinalAge then
begin
line(x1,y1,x2,y2, Form1.Image1.Canvas);
line(x2,y2,x3,y3, Form1.Image1.Canvas);
line(x3,y3,x1,y1, Form1.Image1.Canvas);
form1.Image1.Canvas.Refresh;
end
else
begin
xd:=round((x1+x2)/2);
yd:=round((y1+y2)/2);

xe:=round((x2+x3)/2);
ye:=round((y2+y3)/2);

xf:=round((x1+x3)/2);
yf:=round((y1+y3)/2);

TriS(age,x1,y1,xd,yd,xf,yf);
TriS(age,xd,yd,x2,y2,xe,ye);
TriS(age,xf,yf,xe,ye,x3,y3);
end;
end;




procedure TForm1.SpeedButton1Click(Sender: TObject);
begin

image1.Canvas.Brush.Color:=clWhite;
image1.Canvas.rectangle(0,0,image1.Width,image1.Height);

x1:=10;
y1:=10;
x2:=320;
y2:=470;
x3:=630;
y3:=10;

image1.Canvas.CleanupInstance;
image1.Canvas.rectangle(0,0,640,480);
if spinedit1.value >0 then
begin
Finalage:=Spinedit1.Value;
Tris(0,x1,y1,x2,y2,x3,y3);
end;
end;

Procedure drawtree(age,kx,ky,r:integer; naklon:real);
var
sx,sy:integer;
begin
 r:=round(r-0.2*r);
inc(AGe);
  if age=FinalAge then
  begin
   Line(kx,ky,round(kx + R * cos(naklon)), round(ky + R * sin(naklon)),form1.Image2.Canvas);
   sx:=round(kx + R * cos(naklon));
   sy:=round(ky + R * sin(naklon));
   Line(sx,sy,round(sx + R * cos(naklon-angleL)), round(sy + R * sin(naklon-angleL)), form1.Image2.Canvas);
   Line(sx,sy,round(sx + R * cos(naklon+angleR)), round(sy + R * sin(naklon+angleR)),form1.Image2.Canvas);
  end
 else
  begin
   sx:=round(kx + R * cos(naklon));
   sy:=round(ky + R * sin(naklon));
drawtree(age,sx,sy,r+random(rnd),naklon-angleL);
drawtree(age,sx,sy,r+random(rnd),naklon+angleR);
   Line(kx,ky,round(kx + R * cos(naklon)), round(ky + R * sin(naklon)),form1.Image2.Canvas);
  end;
end;


procedure TForm1.SpeedButton2Click(Sender: TObject);
var
StartX,StartY,StartHeight:integer;
ot,tm:string;
i,j,iter,Total:longint;
StartH,StartM,StartS,StartS1,StopH,StopM,StopS,StopS1:word;
begin

ConCoef:=(pi/180);

AngleL:=spinedit3.value*ConCoef;        AngleR:=Spinedit4.value*ConCoef;

 StartHeight:=spinedit7.Value;
 StartAngle:=3/2*pi;
 StartX:=320;
 StartY:=480;
 Color:=15;
 RND:=0;

 Image2.canvas.CleanupInstance;
image2.Canvas.Brush.Color:=clWhite;
 image2.Canvas.rectangle(0,0,image2.Width,image2.Height);

if (spinedit2.Value>0) and (spinedit5.Value>=0) then
begin
RND:=spinedit5.Value;
FinalAge:=Spinedit2.Value;
drawtree(0,StartX,StartY,StartHeight,StartAngle);
end;



end;



Procedure DrawDragon(age:integer;x1,y1,x2,y2:real;n:real);
var
dx,dy,AC,CD,AD,cx,cy:real;
begin

inc(age);
if Age=FinalAge then
begin
line(x1,y1,x2,y2, form1.image3.canvas);
end

else

begin

cx:=(x2+x1)/2;
cy:=(y2+y1)/2;

AC:=sqrt(sqr(cx-x1)+sqr(cy-y1));
dx:=cx + AC * (cos(n+pi/2));
dy:=cy + AC * (sin(n+pi/2));
drawdragon(age,x1,y1,dx,dy,n+45*cc);
drawdragon(age,x2,y2,dx,dy,n+90*cc+45*cc);

end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin

x1:=145;
y1:=160;
x2:=560;
y2:=160;

CC:=(pi/180);

FinalAge:=spinedit6.Value;

image3.Canvas.Brush.Color:=clWhite;
image3.Canvas.rectangle(0,0,image3.Width,image3.Height);
DrawDragon(0,x1,y1,x2,y2,0);


end;

end.
