unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActnList, CheckLst, CategoryButtons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);





  private
    { Private declarations }
  public
    { Public declarations }

  end;
  var
 Form1 : TForm1;
   type vector= array[0..900] of double;
   var Xe,Ye,Xg,Yg :Vector;
   a,b,c       :Array[0..900] of real;
      minYg,maxYg,MaxX,MaxY,MinX,MinY,Kx,Ky,Zx,Zy ,x,y        :Real;
      al,bl , h,Krx,Kry,xx,yy,Tp,Gx,Gy,Max     :Real;
      NE,KrokX,KrokY,l,Ng,j,x1,y1,e         :Integer;
implementation

{$R *.dfm}
function f(x:real):real;
            begin
              Tp:=bl-al;
                if x<TP/2 then f:=1
                        else
                if(x>=TP/2)and(x<3*TP/4) then
                f:=4*(TP-2*x)/TP
                         else
                f:=8*(x-TP)/TP;
       end;
        procedure Furje(Xe,Ye:vector;Ne:integer;var Yg:vector );
        var
          i,k        :integer;
          w,S,G,D,KOM   :real;
      begin
          TP:=bl-al;
          w:=2*pi/TP;
            for k:=1 to ng do
              begin
                KOM:=k*w;
                G:=0;
                D:=0;
                for i:=1 to Ne-1 do
                  begin
                    S:=KOM*Xe[i];
                    G:=G+Ye[i]*cos(S);
                    D:=D+Ye[i]*sin(S);
                  end;
                a[k]:=2*G/Ne;
                b[k]:=2*D/Ne;
                c[k]:=sqrt(sqr(a[k])+sqr(b[k]));
              end;
          a[0]:=0;
          for i:=1 to Ne do
           a[0]:=a[0]+Ye[i];
           a[0]:=a[0]/Ne;
           for i:=0 to Ne do
            begin
             S:=0;
             D:=Xe[i]*w;
              for k:=1 to ng do
               begin
                KOM:=k*D;
                S:=S+b[k]*sin(KOM)+a[k]*cos(KOM);
               end;
             Yg[i]:=a[0]+S;
            end;
      end;
 procedure Grafik (al,bl:real);
 var i:integer;
 begin


 Ng:=StrToInt(Form1.edit3.text);
 Ne:=600;

 h:=(bl-al)/(ne-1);
 l :=15;
 xe[0]:=al;
 for i:=0 to ne-1 do
   begin
     ye[i]:=f(xe[i]);
     xe[i+1]:=xe[i]+h;
   end;
   Furje(Xe,Ye,Ne,Yg);
 minx:=xe[0];
 maxx:=xe[ne-1];
 minyg:=ye[0];
 maxyg:=ye[0];

  For i:=l to Ne-l do
      Begin
        If MaxYg<Yg[i] then MaxYg:=Yg[i];
        If MinYg>Yg[i] then MinYg:=Yg[i];
      End;
  MinY:=Ye[0];MaxY:=Ye[0];
    For i:=l to Ne-l do
      Begin
        If MaxY<Ye[i] then MaxY:=Ye[i];
        If MinY>Ye[i] then MinY:=Ye[i];
      End;

  If MaxY<MaxYg then MaxY:=MaxYg;
  If MinY>MinYg then MinY:=MinYg;


 kx:=(Form1.Image1.Width - 2 * l)/(Maxx - minx);
 ky:=(Form1.Image1.Height - 2 * l)/(miny - maxyg);
 zx:=(Form1.Image1.Width * minx - l * (minx+maxx))/(minx - maxx);
 zy:=(Form1.Image1.Height * maxy - l * (miny+maxy))/(maxy - minyg);
 if minx * maxx <= 0 then gx := 0;
 if (minx * maxx > 0 ) then gx := minx;
 if ((minx * maxx) >0) and (minx < 0) then gx := maxx;
 if miny* maxy <=0 then gy :=0;
 if (miny * maxy > 0 ) and (miny > 0) then gy := miny;
 if ((miny * maxy) >0) and (miny < 0) then gy := maxy;
  Form1.Image1.Canvas.Pen.Color:=clteal;
  Form1.Image1.Canvas.pen.Width:=3;
 Form1.Image1.Canvas.MoveTo(l,round(ky * gy +zy));
 Form1.Image1.Canvas.lineTo(round(Form1.Image1.Width-l),round(ky * gy +zy));
 Form1.Image1.Canvas.MoveTo(round(kx * gx +zx),l);
 Form1.Image1.Canvas.LineTo(round(kx* gx +zx),round(Form1.Image1.Height -l));
 Form1.Image1.Canvas.Pen.Color:=clteal;
{Обчислення відстаней між лініями гратки по осях Х і У}
    KrokX:=(Form1.Image1.Width-2*l)div 10;
    KrokY:=(Form1.Image1.Height-2*l)div 10;
   Form1.Image1.Canvas.pen.Width:=3;
   {Побудова гратки}
    for i:=0 to 10 do
         begin

          Form1.Image1.Canvas.MoveTo(l,Round(Ky*Gy+Zy)+i*KrokY); //-----
          Form1.Image1.Canvas.LineTo(Form1.Image1.Width-l,Round(Ky*Gy+Zy)+i*KrokY);
          Form1.Image1.Canvas.MoveTo(l,Round(Ky*Gy+Zy)-i*KrokY);
          Form1.Image1.Canvas.LineTo(Form1.Image1.Width-l,Round(Ky*Gy+Zy)-i*KrokY);


          Form1.Image1.Canvas.MoveTo(Round(Kx*Gx+Zx)+i*KrokX,l);
          Form1.Image1.Canvas.LineTo(Round(Kx*Gx+Zx)+i*KrokX,Form1.Image1.Height-l);
          Form1.Image1.Canvas.MoveTo(Round(Kx*Gx+Zx)-i*KrokX,l);
          Form1.Image1.Canvas.LineTo(Round(Kx*Gx+Zx)-i*KrokX,Form1.Image1.Height-l);
          Form1.Image1.Canvas.Pen.Color:=clskyblue;
           Form1.Image1.Canvas.pen.Width:=2;

         end;
          xx:=minx;
          yy:=maxy;
          {Обчислення кроків зміни значень маштабних підписів по осях Х та У}
          Krx:=(MaxX-MinX)/10;
          Kry:=(MaxY-MinY)/10;
          {Виведення масштабних підписів}
            For i:=0 to 10 do
              Begin


               Form1.Image1.Canvas.TextOut(L+i*KrokX,Round(Ky*Gy+Zy)-L+10,FloatToStrF(xx,ffGeneral, 4,0));
               Form1.Image1.Canvas.TextOut(round(kx*gx+zx)-L+10 ,L+i*Kroky-5,FloatToStrF((yy),ffGeneral,1,1));
               Form1.Image1.Canvas.Pen.Color:=clred;

      {  Form1.Image1.Canvas.Pen.Style:=psdash; }
               XX:=XX+KrX;
               yy:=yy-KrY;
               Form1.Image1.Canvas.pen.Width:=2;
              End;

 end;





procedure TForm1.Button1Click(Sender: TObject);

var i:integer;
 t,v,p :real;
begin
   RadioGroup1.Enabled:=true;

   Image1.Picture:= nil;
   al:=StrToFloat(edit1.text);
   bl:=StrToFloat(edit2.text);
   if (al>=bl) and (al=0) and (bl=0) then
 Begin
   Showmessage('Невірно заданий проміжок');
   Exit;
 End;
  Image1.Picture:= nil;
 if form1.RadioGroup1.ItemIndex = 0 then begin
 with Image1 do
            begin

            Grafik (al,bl);

               Form1.canvas.Pen.Color:=clRed;
               Canvas.MoveTo(Round(Kx*XE[0]+Zx),Round(Ky*Ye[0]+Zy));
                    For i:=0 to Ne-1 do
               Form1.Image1.Canvas.LineTO(Round (Kx*XE[i]+Zx),Round(Ky*Ye[i]+Zy));
              Form1.Image1.canvas.Pen.Color:=clblue;
               Form1.Image1.Canvas.pen.Width:=3;



            canvas.MoveTo(Round(Kx*XE[0]+Zx),Round(Ky*Yg[0]+Zy));
                    For i:=0 to Ne-1 do

            Form1.Image1.canvas.LineTO(Round (Kx*XE[i]+Zx),Round(Ky*Yg[i]+Zy));

         End;
 end;

if form1.RadioGroup1.ItemIndex = 1 then

 begin

  try
    begin
t:=bl-al;


  v:=2*pi/t;



      Krokx :=Image1.ClientWidth div (Ng+5);
       Kroky :=Image1.Clientheight div (Ng+5);
      Max:=c[1];
      For i:= 0 to Ng do

If c[i] > Max then
Max:=c[i];
Ky := 300/max;


Image1.Canvas.Pen.Color:=clteal;
Image1.Canvas.Pen.Width:=2;
Image1.Canvas.MoveTo( L , L+20 );{^}
Image1.Canvas.LineTo(L+10, L+10);{^}
Image1.Canvas.LineTo(L+20, L+20);{^}
Image1.Canvas.MoveTo(L+10, L+10);
Image1.Canvas.LineTo(L+10, Image1.ClientHeight-50);
Image1.Canvas.LineTo(Image1.ClientWidth-20, Image1.ClientHeight-50);
      Image1.Canvas.MoveTo( Image1.ClientWidth-40, Image1.ClientHeight-60 );{>}
      Image1.Canvas.LineTo(Image1.ClientWidth-20, Image1.ClientHeight-50);{>}
      Image1.Canvas.LineTo(Image1.ClientWidth-40, Image1.ClientHeight-40);{>}

Image1.Canvas.TextOut(L-5,L ,'C');
Image1.Canvas.TextOut(Image1.ClientWidth-20, Image1.ClientHeight-45 ,'W');
Image1.Canvas.Pen.Color:=clRed;
Image1.Canvas.Pen.Width:=2;

 x:=KrokX+20;
 y:=kroky+420;
For i:= 1 to Ng do
Begin

Image1.Canvas.MoveTo(Round(x)+3,Image1.ClientHeight-50);
Image1.Canvas.LineTo(Round(x)+3,Image1.ClientHeight-50-Round(ky*c[i]));


Image1.Canvas.TextOut(round(x),Image1.ClientHeight - Round(ky*c[i])-65,FloatToStrF(x,ffGeneral,0,0));
Image1.Canvas.Ellipse(Round(x)+1,Image1.ClientHeight-50-Round(ky*c[i]),Round(x)+7,Image1.ClientHeight-50-Round(ky*c[i])+5);

Image1.Canvas.TextOut(round(x),round(y),FloatToStrF(v,ffGeneral,0,0));
Image1.Canvas.Ellipse(round(x),Image1.ClientHeight-53,round(x)+5,Image1.ClientHeight-48);
x:=x+KrokX;


 end;


 end;
 except
      ShowMessage('Спочатку потрібно побудувати "Ряд Фурє" ');
    end;


 end;
end;




procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;
end.








