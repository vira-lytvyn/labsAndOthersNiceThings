unit hotseat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm6 = class(TForm)
    Image1: TImage;
    Player1Name: TEdit;
    Player2Name: TEdit;
    Player1Label: TLabel;
    Player2Label: TLabel;
    Button1: TButton;
    Exit: TButton;
    Refresh: TButton;
    winOw1: TLabel;
    winXw1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure ExitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;
  pole: array [0..2,0..2] of integer;
  whole,aX,aY: integer;
implementation

uses Unit1;

{$R *.dfm}

procedure TForm6.ExitClick(Sender: TObject);
begin
 close;
end;

function ifwins():integer;
begin
 if (pole[0,0]=0) and (pole[0,1]=0) and (pole[0,2]=0) then result:=0 else
 if (pole[1,0]=0) and (pole[1,1]=0) and (pole[1,2]=0) then result:=0 else
 if (pole[2,0]=0) and (pole[2,1]=0) and (pole[2,2]=0) then result:=0 else
 if (pole[0,0]=0) and (pole[1,0]=0) and (pole[2,0]=0) then result:=0 else
 if (pole[0,1]=0) and (pole[1,1]=0) and (pole[2,1]=0) then result:=0 else
 if (pole[0,2]=0) and (pole[1,2]=0) and (pole[2,2]=0) then result:=0 else
 if (pole[0,0]=0) and (pole[1,1]=0) and (pole[2,2]=0) then result:=0 else
 if (pole[0,2]=0) and (pole[1,1]=0) and (pole[2,0]=0) then result:=0 else
 if (pole[0,0]=1) and (pole[0,1]=1) and (pole[0,2]=1) then result:=1 else
 if (pole[1,0]=1) and (pole[1,1]=1) and (pole[1,2]=1) then result:=1 else
 if (pole[2,0]=1) and (pole[2,1]=1) and (pole[2,2]=1) then result:=1 else
 if (pole[0,0]=1) and (pole[1,0]=1) and (pole[2,0]=1) then result:=1 else
 if (pole[0,1]=1) and (pole[1,1]=1) and (pole[2,1]=1) then result:=1 else
 if (pole[0,2]=1) and (pole[1,2]=1) and (pole[2,2]=1) then result:=1 else
 if (pole[0,0]=1) and (pole[1,1]=1) and (pole[2,2]=1) then result:=1 else
 if (pole[0,2]=1) and (pole[1,1]=1) and (pole[2,0]=1) then result:=1 else
 if (whole>8) then result:=5;
end;

function ifwinspos(winner :integer):integer;
begin
 result:=9;
 if (pole[0,0]=pole[0,1]) and (pole[0,2]=pole[0,1]) and (pole[0,1]=winner) then result:=4 else
 if (pole[1,0]=pole[1,1]) and (pole[1,2]=pole[1,1]) and (pole[1,1]=winner) then result:=5 else
 if (pole[2,0]=pole[2,1]) and (pole[2,2]=pole[2,1]) and (pole[2,1]=winner) then result:=6 else
 if (pole[0,0]=pole[1,0]) and (pole[2,0]=pole[1,0]) and (pole[1,0]=winner) then result:=1 else
 if (pole[0,1]=pole[1,1]) and (pole[2,1]=pole[1,1]) and (pole[1,1]=winner) then result:=2 else
 if (pole[0,2]=pole[1,2]) and (pole[2,2]=pole[1,2]) and (pole[1,2]=winner) then result:=3 else
 if (pole[0,0]=pole[1,1]) and (pole[2,2]=pole[1,1]) and (pole[1,1]=winner) then result:=7 else
 if (pole[0,2]=pole[1,1]) and (pole[2,0]=pole[1,1]) and (pole[1,1]=winner) then result:=8;
end;

procedure putX(a:integer;b:integer);
begin
 form6.Image1.Canvas.Pen.Color:=clRed;
 form6.Image1.Canvas.Pen.Width:=5;
 form6.Image1.Canvas.MoveTo(a+5,b+5);
 form6.Image1.Canvas.LineTo(a+95,b+95);
 form6.Image1.Canvas.MoveTo(a+5,b+95);
 form6.Image1.Canvas.LineTo(a+95,b+5);
 whole:=whole+1;
end;

procedure DrawCircle(X, Y, R: Integer; Can:TCanvas; Col: TColor);
begin
 Can.Pen.Width:=1;
 Can.Pen.Color:=Col;
 Can.Ellipse(X-R , Y-R , X+R , Y+R);
end;

procedure putO(a:integer;b:integer);
begin
 DrawCircle(a+50,b+50,45,form6.Image1.Canvas,clBlue);
 whole:=whole+1;
end;

procedure reloadcell();
begin
 form6.Image1.Canvas.Rectangle(0,0,300,300);
 form6.Image1.Canvas.Refresh;
 form6.Image1.Canvas.Pen.Color:=clBlack;
 form6.Image1.Canvas.Pen.Width:=3;
 form6.Image1.Canvas.MoveTo(0,100);
 form6.Image1.Canvas.LineTo(300,100);
 form6.Image1.Canvas.MoveTo(0,200);
 form6.Image1.Canvas.LineTo(300,200);
 form6.Image1.Canvas.MoveTo(100,0);
 form6.Image1.Canvas.LineTo(100,300);
 form6.Image1.Canvas.MoveTo(200,0);
 form6.Image1.Canvas.LineTo(200,300);
end;

procedure TForm6.Button1Click(Sender: TObject);
var
 i,q:integer;
begin
 if (player1name.Text='') or (player2name.Text='')
 then Messagebox(0,'You can''t enter "empty" names!','Error!',mb_OK) else
 if (player1name.Text=player2name.Text)
 then messagebox(0,'You can''t enter alike names!','Error!',mb_OK)
 else
  begin
   label1.Caption:='Player name 1 - '+Player1name.Text+':';
   label2.Caption:='Player name 2 - '+Player2name.Text+':';
   label1.Visible:=true;
   label2.Visible:=true;
   player1name.Visible:=false;
   player1label.Visible:=false;
   player2name.Visible:=false;
   player2label.Visible:=false;
   winXw1.Visible:=true;
   winOw1.Visible:=true;
   image1.Visible:=true;
   button1.Visible:=false;
   refresh.Visible:=true;
   whole:=0;
   form6.Height:=534;
   form6.top:=(screen.Height-form6.Height) div 2;
   aX:=0;
   aY:=1;
   reloadcell();
   reloadcell();
   for i:=0 to 2 do
    for q:=0 to 2 do
     pole[i,q]:=5;
   end;
end;

procedure TheEnd(pos: integer);
begin
form6.Image1.Canvas.Pen.Color:=clFuchsia;
form6.Image1.Canvas.Pen.Width:=7;
if (pos=1) then
        begin
        form6.Image1.Canvas.MoveTo(25,50);
        form6.Image1.Canvas.LineTo(275,50);
        end else
if (pos=2) then
        begin
        form6.Image1.Canvas.MoveTo(25,150);
        form6.Image1.Canvas.LineTo(275,150);
        end else
if (pos=3) then
        begin
        form6.Image1.Canvas.MoveTo(25,250);
        form6.Image1.Canvas.LineTo(275,250);
        end else
if (pos=4) then
        begin
        form6.Image1.Canvas.MoveTo(50,25);
        form6.Image1.Canvas.LineTo(50,275);
        end else
if (pos=5) then
        begin
        form6.Image1.Canvas.MoveTo(150,25);
        form6.Image1.Canvas.LineTo(150,275);
        end else
if (pos=6) then
        begin
        form6.Image1.Canvas.MoveTo(250,25);
        form6.Image1.Canvas.LineTo(250,275);
        end else
if (pos=7) then
        begin
        form6.Image1.Canvas.MoveTo(25,25);
        form6.Image1.Canvas.LineTo(275,275);
        end else
if (pos=8) then
        begin
        form6.Image1.Canvas.MoveTo(25,275);
        form6.Image1.Canvas.LineTo(275,25);
        end;
end;

procedure Change(z:integer);
begin
if z=0 then
        begin
        aX:=0; aY:=1;
        end else
        begin
        aX:=1; aY:=0;
        end;
end;

procedure TForm6.Image1Click(Sender: TObject);
var x,y,winpos,winner,a:integer;
begin
x:=mouse.CursorPos.x-image1.left-form6.Left-4;
y:=mouse.CursorPos.y-image1.top-form6.top-30;
x:=x div 100;
y:=y div 100;
if (pole[x,y]=5) then
        begin
        a:=whole mod 2;
        if (a=0) then  //ax==0
                begin
                putX(x*100,y*100);
                pole[x,y]:=1;
                end;
        if (a=1) then  //ay==1
                begin
                putO(x*100,y*100);
                pole[x,y]:=0;
                end;
        end;

winner:=ifwins();
winpos:=ifwinspos(winner);

if (winner=1) or (winner=0) or (winner=5) then
        begin
        theend(winpos);
        if (winner=0) then
                begin
                winOw1.Caption:=inttostr(strtoint(winOw1.Caption)+1);
                showmessage('Zeros win!');
                end;
        if (winner=1) then
                begin
                winXw1.Caption:=inttostr(strtoint(winXw1.Caption)+1);
                showmessage('Cross win!');
                end;
        if (winner=5) then showmessage('Tie up');
        RefreshClick(Sender);
        end;
end;

procedure TForm6.RefreshClick(Sender: TObject);
var i,q:integer;
begin
reloadcell();
reloadcell();
for i:=0 to 2 do
        for q:=0 to 2 do
        pole[i,q]:=5;
whole:=0;
end;

procedure TForm6.FormCreate(Sender: TObject);
var
 i,q:integer;
begin
 aX:=0; aY:=1;
 form6.left:=(screen.Width-form6.Width) div 2;
 form6.top:=(screen.Height-form6.Height) div 2;
 reloadcell();
 reloadcell();
 for i:=0 to 2 do
  for q:=0 to 2 do
   pole[i,q]:=5;
 whole:=0;
end;

end.
