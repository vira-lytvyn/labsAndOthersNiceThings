unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Math, jpeg;

type
  TForm1 = class(TForm)
    Reload: TButton;
    Image1: TImage;
    Exit: TButton;
    GroupBox1: TGroupBox;
    winXw: TLabel;
    winOw: TLabel;
    qwer: TLabel;
    qwert: TLabel;
    qwerty: TLabel;
    qwertyu: TLabel;
    a22: TLabel;
    a11: TLabel;
    a00: TLabel;
    a10: TLabel;
    a01: TLabel;
    a02: TLabel;
    a12: TLabel;
    a21: TLabel;
    a20: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    winTw: TLabel;
    Info: TButton;
    winTw1: TLabel;
    winOw1: TLabel;
    winXw1: TLabel;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Label1: TLabel;
    Diff: TLabel;
    Bevel2: TBevel;
    Bevel9: TBevel;
    Bevel8: TBevel;
    Bevel3: TBevel;
    Bevel6: TBevel;
    Bevel5: TBevel;
    Bevel4: TBevel;
    Bevel7: TBevel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ReloadClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Pole: array[0..2,0..2] of integer;
  whole,infovar,position: integer;
  win:string;
  difficult:integer;
implementation

{$R *.dfm}

procedure updatetextXO();
var
i,q:integer;
textpole:array[0..2,0..2] of string;
begin
for i:=0 to 2 do
        for q:=0 to 2 do
        if (pole[i,q]=5) then textpole[i,q]:=' ' else
        if (pole[i,q]=1) then textpole[i,q]:='x' else
        if (pole[i,q]=0) then textpole[i,q]:='o';
form1.a00.Caption:=textpole[0,0];
form1.a01.Caption:=textpole[0,1];
form1.a02.Caption:=textpole[0,2];
form1.a10.Caption:=textpole[1,0];
form1.a11.Caption:=textpole[1,1];
form1.a12.Caption:=textpole[1,2];
form1.a20.Caption:=textpole[2,0];
form1.a21.Caption:=textpole[2,1];
form1.a22.Caption:=textpole[2,2];
end;

procedure reloadcell();
begin
form1.Image1.Canvas.Rectangle(0,0,300,300);
form1.Image1.Canvas.Refresh;
form1.Image1.Canvas.Pen.Color:=clBlack;
form1.Image1.Canvas.Pen.Width:=3;
form1.Image1.Canvas.MoveTo(0,100);
form1.Image1.Canvas.LineTo(300,100);
form1.Image1.Canvas.MoveTo(0,200);
form1.Image1.Canvas.LineTo(300,200);
form1.Image1.Canvas.MoveTo(100,0);
form1.Image1.Canvas.LineTo(100,300);
form1.Image1.Canvas.MoveTo(200,0);
form1.Image1.Canvas.LineTo(200,300);
end;

procedure putX(a:integer;b:integer);
begin
form1.Image1.Canvas.Pen.Color:=clRed;
form1.Image1.Canvas.Pen.Width:=5;
form1.Image1.Canvas.MoveTo(a+5,b+5);
form1.Image1.Canvas.LineTo(a+95,b+95);
form1.Image1.Canvas.MoveTo(a+5,b+95);
form1.Image1.Canvas.LineTo(a+95,b+5);
whole:=whole+1;
end;

procedure DrawCircle(X, Y, R: Integer; Can:TCanvas; Col: TColor);
begin
Can.Pen.Width:=1;
Can.Pen.Color:=Col;
Can.Ellipse(X-R , Y-R , X+R , Y+R);
end;

procedure TheEnd(pos: integer);
var x:integer;
begin
x:=0;
form1.Image1.Canvas.Pen.Color:=clFuchsia;
form1.Image1.Canvas.Pen.Width:=7;
if (pos=1) then
        begin
        form1.Image1.Canvas.MoveTo(25,50);
        form1.Image1.Canvas.LineTo(275,50);
        end else
if (pos=2) then
        begin
        form1.Image1.Canvas.MoveTo(25,150);
        form1.Image1.Canvas.LineTo(275,150);
        end else
if (pos=3) then
        begin
        form1.Image1.Canvas.MoveTo(25,250);
        form1.Image1.Canvas.LineTo(275,250);
        end else
if (pos=4) then
        begin
        form1.Image1.Canvas.MoveTo(50,25);
        form1.Image1.Canvas.LineTo(50,275);
        end else
if (pos=5) then
        begin
        form1.Image1.Canvas.MoveTo(150,25);
        form1.Image1.Canvas.LineTo(150,275);
        end else
if (pos=6) then
        begin
        form1.Image1.Canvas.MoveTo(250,25);
        form1.Image1.Canvas.LineTo(250,275);
        end else
if (pos=7) then
        begin
        form1.Image1.Canvas.MoveTo(25,25);
        form1.Image1.Canvas.LineTo(275,275);
        end else
if (pos=8) then
        begin
        form1.Image1.Canvas.MoveTo(25,275);
        form1.Image1.Canvas.LineTo(275,25);
        end else
if (pos=9) then
        begin
        if (pole[0,0]=0) then
                begin
                form1.image1.Canvas.MoveTo(50,50); x:=1; end;
        if (pole[0,1]=0) then if (x=0) then
                begin form1.image1.Canvas.MoveTo(50,150); x:=1 end else
                form1.Image1.Canvas.LineTo(50,150);
        if (pole[0,2]=0) then if (x=0) then
                begin form1.image1.Canvas.MoveTo(50,250); x:=1 end else
                form1.Image1.Canvas.LineTo(50,250);
        if (pole[1,0]=0) then if (x=0) then
                begin form1.image1.Canvas.MoveTo(150,50); x:=1 end else
                form1.Image1.Canvas.LineTo(150,50);
        if (pole[1,1]=0) then if (x=0) then
                begin form1.image1.Canvas.MoveTo(150,150); x:=1 end else
                form1.Image1.Canvas.LineTo(150,150);
        if (pole[1,2]=0) then if (x=0) then
                begin form1.image1.Canvas.MoveTo(150,250); x:=1 end else
                form1.Image1.Canvas.LineTo(150,250);
        if (pole[2,0]=0) then if (x=0) then
                begin form1.image1.Canvas.MoveTo(250,50); x:=1 end else
                form1.Image1.Canvas.LineTo(250,50);
        if (pole[2,1]=0) then if (x=0) then
                begin form1.image1.Canvas.MoveTo(250,150); x:=1 end else
                form1.Image1.Canvas.LineTo(250,150);
        if (pole[2,2]=0) then if (x=0) then
                begin form1.image1.Canvas.MoveTo(250,250) end else
                form1.Image1.Canvas.LineTo(250,250);
        end;
end;

procedure putO();
var q,i,w,z,a:integer;
begin
w:=27;
if (difficult>0) then begin
{---------------Компьютер - поумней-----------------}
if (difficult>1) then begin
if (whole=1) and (pole[1,1]=5) then
        begin
        pole[1,1]:=0;
        DrawCircle(1*100+50,1*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end;
if (whole=1) and (pole[1,1]=1) then
        begin
        randomize;
        z:=random(4);
                case z of
                0: begin q:=0; i:=0; end;
                1: begin q:=0; i:=2; end;
                2: begin q:=2; i:=0; end;
                3: begin q:=2; i:=2; end;
                end;
        pole[i,q]:=0;
        DrawCircle(i*100+50,q*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end;
end;
if (difficult=3) then begin
if ((whole=3) and (pole[1,1]=1)) and (((pole[0,0]=1) and (pole[2,2]=0)) or
((pole[2,2]=1) and (pole[0,0]=0))or((pole[0,2]=1) and (pole[2,0]=0)) or
((pole[2,0]=1) and (pole[0,2]=0))) then
        begin
        randomize;
        a:=3;
        while a=3 do
        begin
                z:=random(4);
                        case z of
                        0: begin q:=0; i:=0; end;
                        1: begin q:=0; i:=2; end;
                        2: begin q:=2; i:=0; end;
                        3: begin q:=2; i:=2; end;
                        end;
                if pole[i,q]=5 then
                        begin
                        pole[i,q]:=0;
                        DrawCircle(i*100+50,q*100+50,45,form1.image1.Canvas,clBlue);
                        w:=3;
                        a:=5;
                        end;
        end;
        end;
end;
if (w=27) then begin
i:=0;
//////////////////////////
if ((pole[0,0]=pole[1,0]) and (pole[0,0]=i) and (pole[2,0]=5)) or
   ((pole[2,1]=pole[2,2]) and (pole[2,1]=i) and (pole[2,0]=5)) or
   ((pole[0,2]=pole[1,1]) and (pole[0,2]=i) and (pole[2,0]=5)) then
        begin
        pole[2,0]:=0;
        DrawCircle(2*100+50,0*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,0]=pole[2,0]) and (pole[0,0]=i) and (pole[1,0]=5)) or
   ((pole[1,1]=pole[1,2]) and (pole[1,1]=i) and (pole[1,0]=5)) then
        begin
        pole[1,0]:=0;
        DrawCircle(1*100+50,0*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[1,0]=pole[2,0]) and (pole[1,0]=i) and (pole[0,0]=5)) or
   ((pole[0,1]=pole[0,2]) and (pole[0,1]=i) and (pole[0,0]=5)) or
   ((pole[1,1]=pole[2,2]) and (pole[1,1]=i) and (pole[0,0]=5)) then
        begin
        pole[0,0]:=0;
        DrawCircle(0*100+50,0*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,1]=pole[1,1]) and (pole[0,1]=i) and (pole[2,1]=5)) or
   ((pole[2,0]=pole[2,2]) and (pole[2,0]=i) and (pole[2,1]=5)) then
        begin
        pole[2,1]:=0;
        DrawCircle(2*100+50,1*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,1]=pole[2,1]) and (pole[0,1]=i) and (pole[1,1]=5)) or
   ((pole[1,0]=pole[1,2]) and (pole[1,0]=i) and (pole[1,1]=5)) or
   ((pole[0,0]=pole[2,2]) and (pole[0,0]=i) and (pole[1,1]=5)) or
   ((pole[0,2]=pole[2,0]) and (pole[0,2]=i) and (pole[1,1]=5)) then
        begin
        pole[1,1]:=0;
        DrawCircle(1*100+50,1*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[1,1]=pole[2,1]) and (pole[1,1]=i) and (pole[0,1]=5)) or
   ((pole[0,0]=pole[0,2]) and (pole[0,0]=i) and (pole[0,1]=5)) then
        begin
        pole[0,1]:=0;
        DrawCircle(0*100+50,1*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,2]=pole[1,2]) and (pole[0,2]=i) and (pole[2,2]=5)) or
   ((pole[2,0]=pole[2,1]) and (pole[2,0]=i) and (pole[2,2]=5)) or
   ((pole[0,0]=pole[1,1]) and (pole[0,0]=i) and (pole[2,2]=5)) then
        begin
        pole[2,2]:=0;
        DrawCircle(2*100+50,2*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,2]=pole[2,2]) and (pole[0,2]=i) and (pole[1,2]=5)) or
   ((pole[1,0]=pole[1,1]) and (pole[1,0]=i) and (pole[1,2]=5)) then
        begin
        pole[1,2]:=0;
        DrawCircle(1*100+50,2*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[1,2]=pole[2,2]) and (pole[1,2]=i) and (pole[0,2]=5)) or
   ((pole[0,0]=pole[0,1]) and (pole[0,0]=i) and (pole[0,2]=5)) or
   ((pole[1,1]=pole[2,0]) and (pole[1,1]=i) and (pole[0,2]=5)) then
        begin
        pole[0,2]:=0;
        DrawCircle(0*100+50,2*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
i:=1;
//////////////////////////
if ((pole[0,0]=pole[1,0]) and (pole[0,0]=i) and (pole[2,0]=5)) or
   ((pole[2,1]=pole[2,2]) and (pole[2,1]=i) and (pole[2,0]=5)) or
   ((pole[0,2]=pole[1,1]) and (pole[0,2]=i) and (pole[2,0]=5)) then
        begin
        pole[2,0]:=0;
        DrawCircle(2*100+50,0*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,0]=pole[2,0]) and (pole[0,0]=i) and (pole[1,0]=5)) or
   ((pole[1,1]=pole[1,2]) and (pole[1,1]=i) and (pole[1,0]=5)) then
        begin
        pole[1,0]:=0;
        DrawCircle(1*100+50,0*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[1,0]=pole[2,0]) and (pole[1,0]=i) and (pole[0,0]=5)) or
   ((pole[0,1]=pole[0,2]) and (pole[0,1]=i) and (pole[0,0]=5)) or
   ((pole[1,1]=pole[2,2]) and (pole[1,1]=i) and (pole[0,0]=5)) then
        begin
        pole[0,0]:=0;
        DrawCircle(0*100+50,0*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,1]=pole[1,1]) and (pole[0,1]=i) and (pole[2,1]=5)) or
   ((pole[2,0]=pole[2,2]) and (pole[2,0]=i) and (pole[2,1]=5)) then
        begin
        pole[2,1]:=0;
        DrawCircle(2*100+50,1*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,1]=pole[2,1]) and (pole[0,1]=i) and (pole[1,1]=5)) or
   ((pole[1,0]=pole[1,2]) and (pole[1,0]=i) and (pole[1,1]=5)) or
   ((pole[0,0]=pole[2,2]) and (pole[0,0]=i) and (pole[1,1]=5)) or
   ((pole[0,2]=pole[2,0]) and (pole[0,2]=i) and (pole[1,1]=5)) then
        begin
        pole[1,1]:=0;
        DrawCircle(1*100+50,1*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[1,1]=pole[2,1]) and (pole[1,1]=i) and (pole[0,1]=5)) or
   ((pole[0,0]=pole[0,2]) and (pole[0,0]=i) and (pole[0,1]=5)) then
        begin
        pole[0,1]:=0;
        DrawCircle(0*100+50,1*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,2]=pole[1,2]) and (pole[0,2]=i) and (pole[2,2]=5)) or
   ((pole[2,0]=pole[2,1]) and (pole[2,0]=i) and (pole[2,2]=5)) or
   ((pole[0,0]=pole[1,1]) and (pole[0,0]=i) and (pole[2,2]=5)) then
        begin
        pole[2,2]:=0;
        DrawCircle(2*100+50,2*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[0,2]=pole[2,2]) and (pole[0,2]=i) and (pole[1,2]=5)) or
   ((pole[1,0]=pole[1,1]) and (pole[1,0]=i) and (pole[1,2]=5)) then
        begin
        pole[1,2]:=0;
        DrawCircle(1*100+50,2*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
if ((pole[1,2]=pole[2,2]) and (pole[1,2]=i) and (pole[0,2]=5)) or
   ((pole[0,0]=pole[0,1]) and (pole[0,0]=i) and (pole[0,2]=5)) or
   ((pole[1,1]=pole[2,0]) and (pole[1,1]=i) and (pole[0,2]=5)) then
        begin
        pole[0,2]:=0;
        DrawCircle(0*100+50,2*100+50,45,form1.image1.Canvas,clBlue);
        w:=3;
        end else
        end;
end;
{^^^^^^^^^^^^^^^Компьютер - поумней^^^^^^^^^^^^^^^^^}
{---------------Компьютер - дурачёк-----------------}
randomize;
if (whole<9) then
        while w=27 do
        begin
        q:=random(3);
        i:=random(3);
        if (pole[i,q]=5) then
                begin
                pole[i,q]:=0;
                DrawCircle(i*100+50,q*100+50,45,form1.image1.Canvas,clBlue);
                w:=3;
                end;
        end;
{^^^^^^^^^^^^^^^Компьютер - дурачёк^^^^^^^^^^^^^^^^^}
whole:=whole+1;
end;

function ifwins():string;
begin
 if (pole[0,0]=0) and (pole[0,1]=0) and (pole[0,2]=0) then result:='no' else
 if (pole[1,0]=0) and (pole[1,1]=0) and (pole[1,2]=0) then result:='no' else
 if (pole[2,0]=0) and (pole[2,1]=0) and (pole[2,2]=0) then result:='no' else
 if (pole[0,0]=0) and (pole[1,0]=0) and (pole[2,0]=0) then result:='no' else
 if (pole[0,1]=0) and (pole[1,1]=0) and (pole[2,1]=0) then result:='no' else
 if (pole[0,2]=0) and (pole[1,2]=0) and (pole[2,2]=0) then result:='no' else
 if (pole[0,0]=0) and (pole[1,1]=0) and (pole[2,2]=0) then result:='no' else
 if (pole[0,2]=0) and (pole[1,1]=0) and (pole[2,0]=0) then result:='no';

 if (pole[0,0]=1) and (pole[0,1]=1) and (pole[0,2]=1) then result:='yes' else
 if (pole[1,0]=1) and (pole[1,1]=1) and (pole[1,2]=1) then result:='yes' else
 if (pole[2,0]=1) and (pole[2,1]=1) and (pole[2,2]=1) then result:='yes' else
 if (pole[0,0]=1) and (pole[1,0]=1) and (pole[2,0]=1) then result:='yes' else
 if (pole[0,1]=1) and (pole[1,1]=1) and (pole[2,1]=1) then result:='yes' else
 if (pole[0,2]=1) and (pole[1,2]=1) and (pole[2,2]=1) then result:='yes' else
 if (pole[0,0]=1) and (pole[1,1]=1) and (pole[2,2]=1) then result:='yes' else
 if (pole[0,2]=1) and (pole[1,1]=1) and (pole[2,0]=1) then result:='yes';

 if (result<>'no')and(result<>'yes')and(whole>8) then result:='tie';
end;

function ifwinspos(x,y,winner :integer):integer;
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

procedure TForm1.Image1Click(Sender: TObject);
var x,y:integer;
begin
{if (whole>0) then }GroupBox2.Enabled:=false;
x:=mouse.CursorPos.x-image1.left-form1.Left-4;
y:=mouse.CursorPos.y-image1.top-form1.top-30;
x:=x div 100;
y:=y div 100;
if (pole[x,y]=5) then
        begin
        putX(x*100,y*100);
        pole[x,y]:=1;
        putO();
        updatetextXO();

        win:=ifwins();
        if (win='yes') then
                begin
                winXw.Caption:=inttostr(strtoint(winXw.Caption)+1);
                winXw1.Caption:=winXw.Caption;
                Theend(ifwinspos(x,y,1));
                if (messagebox(0,'You win! Would you like to play once again?','Win!',mb_YESNO)=7) then close;
                ReloadClick(Sender);
                end;
        if (win='no') then
                begin
                winOw.Caption:=inttostr(strtoint(winOw.Caption)+1);
                winOw1.Caption:=winOw.Caption;
                Theend(ifwinspos(x,y,0));
                if (messagebox(0,'Have Lost? We shall be won back?','Defeat!',mb_YESNO)=7) then close;
                ReloadClick(Sender);
                end;
        if (win='tie') then
                begin
                winTw.Caption:=inttostr(strtoint(winTw.Caption)+1);
                winTw1.Caption:=winTw.Caption;
                Theend(9);
                if (messagebox(0,'Tie up, but zero''s find true way :)','Tie up!',mb_YESNO)=7) then close;
                ReloadClick(Sender);
                end;
        end;
end;

procedure TForm1.ReloadClick(Sender: TObject);
var
 i,q:integer;
begin
 reloadcell();
 reloadcell();
 for i:=0 to 2 do
  for q:=0 to 2 do
   pole[i,q]:=5;
 updatetextXO();
 whole:=0;
 groupbox2.Enabled:=true;
end;

procedure TForm1.ExitClick(Sender: TObject);
begin
 close;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 i,q:integer;
begin
 difficult:=2;
 form1.left:=(screen.Width-form1.Width) div 2;
 form1.top:=(screen.Height-form1.Height) div 2;
 infovar:=0;
 whole:=0;
 reloadcell();
 reloadcell();
 for i:=0 to 2 do
  for q:=0 to 2 do
   pole[i,q]:=5;
 updatetextXO();
end;

procedure TForm1.InfoClick(Sender: TObject);
begin
 if (infovar=0)
 then
  begin
   form1.Height:=form1.Height+GroupBox1.Height+10;
   Groupbox1.Visible:=true;
   info.Caption:='More info <<';
   infovar:=1;
   end
  else
   if (infovar=1)
   then
    begin
     form1.Height:=484;
     Groupbox1.Visible:=false;
     info.Caption:='More info >>';
     infovar:=0;
    end;
 form1.left:=(screen.Width-form1.Width) div 2;
 form1.top:=(screen.Height-form1.Height) div 2;
end;

procedure TForm1.RadioButton5Click(Sender: TObject);
begin
 difficult:=0;
 diff.Caption:='Very easy';
end;

procedure TForm1.RadioButton4Click(Sender: TObject);
begin
 difficult:=1;
 diff.Caption:='Easy';
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
 difficult:=2;
 diff.Caption:='Normal';
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
 difficult:=3;
 diff.Caption:='Hard';
end;

end.
