unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMain = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Reset: TLabel;
    ChangeLang: TLabel;
    Help: TLabel;
    PKeyboard: TLabel;
    Exit: TLabel;
    HeyHey: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ResetClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ChangeLangClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PKeyboardClick(Sender: TObject);
    procedure ResetMouseEnter(Sender: TObject);
    procedure HelpMouseEnter(Sender: TObject);
    procedure PKeyboardMouseEnter(Sender: TObject);
    procedure ChangeLangMouseEnter(Sender: TObject);
    procedure ExitMouseEnter(Sender: TObject);
    procedure ResetMouseLeave(Sender: TObject);
    procedure HelpMouseLeave(Sender: TObject);
    procedure PKeyboardMouseLeave(Sender: TObject);
    procedure ChangeLangMouseLeave(Sender: TObject);
    procedure ExitMouseLeave(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;
  Pjat: array [1..16] of integer;
  steps, keybpos: integer;
  keyb: string;
implementation

uses Unit2,pre;

{$R *.dfm}

procedure startpjat();
var
 i,q,w,a:integer;
begin
steps:=0;
main.label2.caption:='0';
randomize;
pjat[1]:=random(16);
for i:=2 to 16 do
        begin
        a:=1;
        while (a=1) do
                begin
                w:=0;
                pjat[i]:=random(16);
                for q:=i-1 downto 1 do
                        if (pjat[i]=pjat[q]) then w:=w+1;
                if (w=0) then a:=2;
                end;
        end;
end;

procedure hey();
begin
 main.HeyHey.Caption:=inttostr(strtoint(main.HeyHey.Caption)+1);
end;

procedure ReloadPole(canvas: TCanvas);
var i,q,w,x,y:integer;
begin
canvas.Rectangle(0,0,201,201);
if keyb='yes' then
        begin
        canvas.Brush.Color:=clGradientInactiveCaption;
        case keybpos of
        1:  begin x:=0; y:=0; end;
        2:  begin x:=50; y:=0; end;
        3:  begin x:=100; y:=0; end;
        4:  begin x:=150; y:=0; end;
        5:  begin x:=0; y:=50; end;
        6:  begin x:=50; y:=50; end;
        7:  begin x:=100; y:=50; end;
        8:  begin x:=150; y:=50; end;
        9:  begin x:=0; y:=100; end;
        10: begin x:=50; y:=100; end;
        11: begin x:=100; y:=100; end;
        12: begin x:=150; y:=100; end;
        13: begin x:=0; y:=150; end;
        14: begin x:=50; y:=150; end;
        15: begin x:=100; y:=150; end;
        16: begin x:=150; y:=150; end;
        end;
        canvas.Rectangle(x,y,x+51,y+51);
        canvas.Brush.Color:=clWhite;
        end;
w:=3;
for q:=0 to w do
        for i:=0 to w do
        begin
        canvas.MoveTo(i*50,q*50);
        canvas.LineTo((i)*50,(w-q+1)*50);
        canvas.MoveTo(i*50,q*50);
        canvas.LineTo((w-i+1)*50,(q)*50);
        end;
w:=1;
for q:=1 to 4 do
        for i:=1 to 4 do
        begin
        if (pjat[w]<>0) then
        if (keyb='yes') and (keybpos=w) then
                begin
                canvas.Brush.Color:=clGradientInactiveCaption;
                canvas.TextOut(i*50-30,q*50-30,inttostr(pjat[w]));
                canvas.Brush.Color:=clWhite;
                end else
        canvas.TextOut(i*50-30,q*50-30,inttostr(pjat[w]));
        w:=w+1;
        end;
end;

function CheckPole():string;
var i:integer;
begin
result:='yes';
for i:=1 to 15 do if (pjat[i]<>i) then result:='no';
if (pjat[16]<>0) then result:='no';
end;

procedure TMain.FormCreate(Sender: TObject);
begin
startpjat();
reloadPole(image1.Canvas);
main.left:=(screen.Width-main.Width) div 2;
main.top:=(screen.Height-main.Height) div 2;
keyb:='no';
keybpos:=1;
end;

procedure TMain.ResetClick(Sender: TObject);
begin
startpjat();
reloadPole(image1.Canvas);
end;

procedure go (i,cell:integer);
begin
pjat[i]:=pjat[cell];
pjat[cell]:=0;
steps:=steps+1;
reloadPole(main.image1.Canvas);
main.label2.Caption:=inttostr(steps);
if CheckPole='yes' then showmessage(pre.wintext);
Hey();
end;

procedure direction (dire: string);
var cell: integer;
begin
if dire='sdown' then if (keybpos<=12) then keybpos:=keybpos+4;
if dire='sleft' then if (keybpos<>1)  and (keybpos<>5) and (keybpos<>9) and (keybpos<>13) then keybpos:=keybpos-1;
if dire='sup'   then if (keybpos>=5)  then keybpos:=keybpos-4;
if dire='sright'then if (keybpos<>4)  and (keybpos<>8) and (keybpos<>12) and (keybpos<>16) then keybpos:=keybpos+1;
if dire='space' then begin
cell:=keybpos;
if (pjat[cell-1]=0) and (cell>=2) and (cell<=17) then
        go (cell-1,cell);
if (pjat[cell+1]=0) and (cell>=0) and (cell<=15) then
        go (cell+1,cell);
if (pjat[cell-4]=0) and (cell>=5) and (cell<=20) then
        go (cell-4,cell);
if (pjat[cell+4]=0) and (cell>=-3) and (cell<=12) then
        go (cell+4,cell);

                     end;
reloadPole(main.image1.Canvas);
end;

procedure TMain.Image1Click(Sender: TObject);
var
 x,y,cell:integer;
begin
if keyb='no' then
        begin
x:=mouse.CursorPos.x-image1.left-main.Left-4;
y:=mouse.CursorPos.y-image1.top-main.top-30;
x:=x div 50;
y:=y div 50;
cell:=x*1+y*4+1;

if (pjat[cell-1]=0) and (cell>=2) and (cell<=17) then
        go (cell-1,cell);
if (pjat[cell+1]=0) and (cell>=0) and (cell<=15) then
        go (cell+1,cell);
if (pjat[cell-4]=0) and (cell>=5) and (cell<=20) then
        go (cell-4,cell);
if (pjat[cell+4]=0) and (cell>=-3) and (cell<=12) then
        go (cell+4,cell);
        end;
end;

procedure TMain.ExitClick(Sender: TObject);
begin
 halt;
end;

procedure TMain.HelpClick(Sender: TObject);
begin
 rules.showmodal;
end;

procedure TMain.FormPaint(Sender: TObject);
begin
 main.Caption:=pre.MainCaption;
 reset.Caption:=pre.ResetCaption;
 exit.Caption:=pre.exitCaption;
 label1.Caption:=pre.WholestepsText;
 help.Caption:=pre.RulesCaption;
 changelang.Caption:=pre.changelangcaption;
 if keyb='no'
 then Pkeyboard.Caption:=pre.playkeyb;
 if keyb='yes'
 then Pkeyboard.Caption:=pre.playmouse;
end;

procedure TMain.ChangeLangClick(Sender: TObject);
begin
 Close;
end;

procedure TMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if keyb='yes'
 then
  case Key of
      vk_down:  direction ('sdown');
      vk_left:  direction ('sleft');
      vk_up:    direction ('sup');
      vk_right: direction ('sright');
      vk_space: direction ('space');
      VK_TAB: PKeyboardClick(Sender);
    end
   else
    case key of
      VK_TAB: PKeyboardClick(Sender);
    end;
end;

procedure TMain.PKeyboardClick(Sender: TObject);
begin
 if (keyb='yes')
 then
  begin
   PKeyboard.Caption:=pre.playkeyb;
   keyb:='no';
   reloadpole(image1.Canvas);
  end
 else
  begin
   PKeyboard.Caption:=pre.playmouse;
   keyb:='yes';
   reloadpole(image1.Canvas);
  end;
end;

procedure TMain.ResetMouseEnter(Sender: TObject);
begin
 reset.Font.Color:=clPurple;
end;

procedure TMain.HelpMouseEnter(Sender: TObject);
begin
 help.Font.Color:=clPurple;
end;

procedure TMain.PKeyboardMouseEnter(Sender: TObject);
begin
 Pkeyboard.Font.Color:=clPurple;
end;

procedure TMain.ChangeLangMouseEnter(Sender: TObject);
begin
 changelang.Font.Color:=clPurple;
end;

procedure TMain.ExitMouseEnter(Sender: TObject);
begin
 exit.Font.Color:=clPurple;
end;

procedure TMain.ResetMouseLeave(Sender: TObject);
begin
 reset.Font.Color:=clNavy;
end;

procedure TMain.HelpMouseLeave(Sender: TObject);
begin
 help.Font.Color:=clNavy;
end;

procedure TMain.PKeyboardMouseLeave(Sender: TObject);
begin
 pkeyboard.Font.Color:=clNavy;
end;

procedure TMain.ChangeLangMouseLeave(Sender: TObject);
begin
 changelang.Font.Color:=clNavy;
end;

procedure TMain.ExitMouseLeave(Sender: TObject);
begin
 exit.Font.Color:=clNavy;
end;

end.
