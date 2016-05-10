unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Gauges, MyMath, Unit2;

type
  TForm1 = class(TForm)
    StartBtn: TButton;
    Image1: TImage;
    ClearBtn: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Gauge1: TGauge;
    FormEd: TEdit;
    XStart: TEdit;
    XEnd: TEdit;
    StepEd: TEdit;
    LinesCh: TCheckBox;
    MashCh: TCheckBox;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    XEd: TEdit;
    YEd: TEdit;
    StartBtn2: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    OpenBtn: TButton;
    SaveBtn: TButton;
    AbBtn: TButton;
    procedure StartBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure StartBtn2Click(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure AbBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

var x,y:array of extended;
   xmnoj,ymnoj,ymin,ymax,xe,xs,step:extended;
   graph:boolean=false;
   ram:boolean=false;
   f:file of extended;
   fn:string;

procedure XYMinMax;
var n:cardinal;
   imh,imw:word;
begin
form1.caption:='Graphics - Поиск минимальных и максимальных значений для масштабирования';
form1.gauge1.maxvalue:=high(y);
if form1.mashch.checked=true then
   begin
   //если масштабирование отмечено, то ищется множитель для x и y
   imh:=form1.image1.height;
   imw:=form1.image1.width;
   ymax:=y[1];
   ymin:=y[1];
   for n:=0 to high(y) do
      begin
      if ymax<y[n] then ymax:=y[n];
      if ymin>y[n] then ymin:=y[n];
      form1.gauge1.progress:=n;
      end;
   if ymax-ymin=0 then ymnoj:=1
      else ymnoj:=imh/abs(ymax-ymin);
   if xe-xs=0 then xmnoj:=1
      else xmnoj:=imw/abs(xe-xs);
   end else
   //а если масштабирование не отмечено, то множители равны нулю
   begin
   ymnoj:=1;
   xmnoj:=1;
   end;
form1.caption:='Graphics - Поиск завершен';
end;

procedure ris;
var n:cardinal;
   imh,imw:word;
begin
form1.caption:='Graphics - Построение графика';
form1.image1.canvas.pen.color:=clwhite;
imh:=form1.image1.height;
imw:=form1.image1.width;
form1.gauge1.maxvalue:=high(x);
//рисует оси
with form1.image1.canvas do
   begin
   pen.style:=psdot;
   moveto(0,imh-trunc((-ymin)*ymnoj));
   lineto(imw,imh-trunc((-ymin)*ymnoj));
   moveto(trunc((-xs)*xmnoj),0);
   lineto(trunc((-xs)*xmnoj),imh);
   pen.style:=pssolid;
   end;
if form1.linesch.checked=true then
   begin
   //если отмечено соединение линиями, то точки соединяются между собой...
   for n:=0 to high(x)-1 do
      begin
      with form1.image1.canvas do
         begin
         moveto(trunc((x[n]-xs)*xmnoj),imh-trunc((y[n]-ymin)*ymnoj));
         lineto(trunc((x[n+1]-xs)*xmnoj),imh-trunc((y[n+1]-ymin)*ymnoj));
         end;
      form1.gauge1.progress:=n;
      end;
   form1.gauge1.progress:=high(x);
   end else //а если нет, то не соединяются
   for n:=0 to high(x) do
      begin
      form1.image1.canvas.moveto(trunc((x[n]-xs)*xmnoj),imh-trunc((y[n]-ymin)*ymnoj));
      form1.image1.canvas.lineto(trunc((x[n]-xs)*xmnoj)+1,imh-trunc((y[n]-ymin)*ymnoj)+1);
      form1.gauge1.progress:=n;
      end;
graph:=true;
form1.caption:='Graphics - Построение завершено';
end;

procedure TForm1.StartBtnClick(Sender: TObject);
var n:cardinal;
   m:word;
   str:string;
label a;
begin
form1.caption:='Graphics - Расчет точек';
graph:=true;
ram:=true;
xe:=strtofloat(xend.text);
xs:=strtofloat(xstart.text);
if xe<xs then
   begin
   str:=xend.text;
   xend.text:=xstart.text;
   xstart.text:=str;
   xe:=xe+xs;
   xs:=xe-xs;
   xe:=xe-xs;
   end;
step:=strtofloat(steped.text);
if (step>abs(xe-xs))or(step<0) then
   begin
   showmessage('Неверный шаг');
   exit;
   end;
setlength(x,trunc(abs(xe-xs)/step)+1);
setlength(y,trunc(abs(xe-xs)/step)+1);
gauge1.maxvalue:=high(y);
for n:=0 to high(x) do
   begin
   x[n]:=xs+n*step;
   str:=formed.text;
   str:=erranalise(str);
   a:;   //метка для обновления длинны str в цикле
   for m:=1 to length(str) do
      begin
      //подстановка числа вместо x
      if ((str[m]='x')or(str[m]='X')){and(x[n]>=0)} then
         begin
         delete(str,m,1);
         insert(floattostr(x[n]),str,m);
         goto a;
         end;
{      if ((str[m]='x')or(str[m]='X'))and(x[n]<0) then
         begin
         delete(str,m,1);
         insert(floattostr(x[n]),str,m);
         str[m]:='~';
         goto a;
         end;}
      end;
   //решение функции в точке x
   y[n]:=strtofloat(analise(str));
   gauge1.progress:=n;
   end;
xyminmax;
ris;
end;

procedure TForm1.ClearBtnClick(Sender: TObject);
begin
with form1.image1.canvas do
   begin
   brush.color:=clblack;
   pen.color:=clblack;
   rectangle(0,0,form1.image1.width,form1.image1.height);
   end;
graph:=false;
xed.text:='0';
yed.text:='0';
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
finalize(x);
finalize(y);
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if graph then
   begin
   xed.text:=floattostr((x/image1.width)*(xe-xs)+xs);
   yed.text:=floattostr(ymax-(y/image1.height)*(ymax-ymin));
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
with form1.image1.canvas do
   begin
   brush.color:=clblack;
   pen.color:=clblack;
   rectangle(0,0,form1.image1.width,form1.image1.height);
   end;
end;

procedure TForm1.StartBtn2Click(Sender: TObject);
begin
xyminmax;
ris;
end;

procedure TForm1.OpenBtnClick(Sender: TObject);
var l:extended;
   formula:string;
   n:word;
begin
form1.caption:='Graphics - Открытие файла';
if opendialog.execute then
   fn:=opendialog.filename;
if fn='' then exit;
setlength(x,0);
setlength(y,0);
assignfile(f,fn);
{$I-}
reset(f);
{$I+}
if ioresult=0 then
   begin
   finalize(x);
   finalize(y);
   read(f,l);
   formula:='';
   for n:=1 to trunc(l) do
      begin
      read(f,l);
      formula:=formula+chr(trunc(l));
      end;
   read(f,xe,xs,step);
   while not eof(f) do
      begin
      setlength(x,high(x)+2);
      setlength(y,high(y)+2);
      read(f,x[high(x)],y[high(y)]);
      end;
   setlength(x,high(x));
   setlength(y,high(y));
   formed.text:=formula;
   xstart.text:=floattostr(xs);
   xend.text:=floattostr(xe);
   steped.text:=floattostr(step);
   end else showmessage('Не могу открыть файл');
closefile(f);
form1.caption:='Graphics - Открытие завершено';
end;

procedure TForm1.SaveBtnClick(Sender: TObject);
var n:cardinal;
   l:extended;
begin
form1.caption:='Graphics - Сохранение файла';
if savedialog.execute then
   fn:=savedialog.filename;
if fn='' then exit;
l:=0;
for n:=length(fn) downto 1 do
   if fn[n]='\' then
      begin
      l:=n;
      break;
      end;
if pos('.',copy(fn,trunc(l),length(fn)-trunc(l)))=0 then fn:=fn+'.grf';
assignfile(f,fn);
rewrite(f);
l:=length(formed.text);
write(f,l);
for n:=1 to length(formed.text) do
   begin
   l:=ord(formed.text[n]);
   write(f,l);
   end;
write(f,xe,xs,step);
for n:=0 to high(x) do
   write(f,x[n],y[n]);
closefile(f);
form1.caption:='Graphics - Сохранение завершено';
end;

procedure TForm1.AbBtnClick(Sender: TObject);
begin
AboutForm.ShowModal;
end;

end.
