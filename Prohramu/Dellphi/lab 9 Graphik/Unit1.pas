unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
 Vector=array[0..640] of Real;
  TForm1 = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    ComboBox2: TComboBox;
    PaintBox1: TPaintBox;
    Label6: TLabel;
    ComboBox3: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var L:Integer;
    Xe, Ye:Vector;
    g,t, i,j, Ne:Integer;
    h:real;
    cx, cy:real;
    al, bl:real;
    MaxX, MaxY, MinX, MinY:real;
    Mx, My, KrokX, KrokY, Gx0, Gy0:Integer;
    Gx, Gy, Kx, Ky, Zx, Zy,xx,yy,Krx,Kry:real;
    grafs:Boolean;
Function f1(x:real):real;
 Begin
    f1:=sin(x);
 End;
 Function f2(x:real):real;
  begin
    f2:=cos(x);
  end;
Function f3(x:real):real;
begin
    f3:=x*sin(x);
end;
Function f4(x:real):real;
begin
    f4:=x*cos(x);
end;
BEGIN
    PaintBox1.Refresh;
    grafs:=false;
    PaintBox1.Canvas.Brush.Style:=bsClear;
    PaintBox1.Canvas.FillRect(Rect(0,0, PaintBox1.Width, PaintBox1.Height));
    try
        al:=StrToFloat(Edit1.Text);
        bl:=StrToFloat(Edit2.Text);
    Ne:=265;
    h:=(bl-al)/(Ne-1);
    case ComboBox1.ItemIndex of
      0:  begin
            grafs:=false;
            Xe[0]:=al;
            For i:=0 to Ne-1 do             {Табуляція функції sin(x)}
            Begin
              Ye[i]:=f1(Xe[i]);
              Xe[i+1]:=Xe[i]+h
            End;
          end;
      1:  begin
            grafs:=false;
            Xe[0]:=al;
            For i:=0 to Ne-1 do             {Табуляція функції cos(x)}
            Begin
              Ye[i]:=f2(Xe[i]);
              Xe[i+1]:=Xe[i]+h
            End;
          end;
      2:  begin
            grafs:=false;
            Xe[0]:=al;
            For i:=0 to Ne-1 do             {Табуляція функції x*sin(x)}
            Begin
              Ye[i]:=f3(Xe[i]);
              Xe[i+1]:=Xe[i]+h
            End;
          end;
       end;

    case ComboBox3.ItemIndex of
      0:  begin
              grafs:=true;
              Xe[0]:=al;
              For i:=0 to Ne-1 do             {Табуляція функцій x*sin(x) та x*cos(x)}
              Begin
                Ye[i]:=f3(Xe[i]);
                Xe[i+1]:=Xe[i]+h
              End;
              Xe[Ne+1]:=al;
              for i:=Ne+1 to 2*Ne do
              Begin
                Ye[i]:=f4(Xe[i]);
                Xe[i+1]:=Xe[i]+h
              end;
          end;
      1:  begin
              grafs:=true;
              Xe[0]:=al;
              For i:=0 to Ne-1 do             {Табуляція функцій sin(x) та cos(x)}
              Begin
                Ye[i]:=f1(Xe[i]);
                Xe[i+1]:=Xe[i]+h
              End;
              Xe[Ne+1]:=al;
              for i:=Ne+1 to 2*Ne do
              Begin
                Ye[i]:=f2(Xe[i]);
                Xe[i+1]:=Xe[i]+h
              end;
          end;
      2:  begin
              grafs:=true;
              Xe[0]:=al;
              For i:=0 to Ne-1 do             {Табуляція функцій sin(x) та x*cos(x)}
              Begin
                Ye[i]:=f1(Xe[i]);
                Xe[i+1]:=Xe[i]+h
              End;
              Xe[Ne+1]:=al;
              for i:=Ne+1 to 2*Ne do
              Begin
                Ye[i]:=f4(Xe[i]);
                Xe[i+1]:=Xe[i]+h
              end;
          end;
    end;
L:=55;
MaxX:=bl;                        {екстремальні значення}
MinX:=al;
MaxY:=Ye[0];
MinY:=Ye[0];
  For i:=1 to Ne do
    Begin
        If MaxY<Ye[i] then MaxY:=Ye[i];
        If MinY>Ye[i] then MinY:=Ye[i];
    End;
 if (grafs=true) then
 For i:=Ne+1 to 2*Ne do
    Begin
      If MaxY<Ye[i] then MaxY:=Ye[i];
      If MinY>Ye[i] then MinY:=Ye[i];
    End;
Mx:=640;                      {коефіцієнти}
My:=480;
Kx:=(Mx-2*L)/(MaxX-MinX);
Ky:=(My-2*L)/(MinY-MaxY);
Zx:=(Mx*MinX-L*(MinX+MaxX))/(MinX-MaxX);
Zy:=(My*MaxY-L*(MinY+MaxY))/(MaxY-MinY);
If MinX*MaxX <=0 then Gx:=0;                     {"плаваючі" осі}
If (MinX*MaxX>0) then GX:=MinX;
If (MinX*MaxX>0) and (MinX<0) then Gx:=MaxX;
If Miny*Maxy <=0 then Gy:=0;
If (Miny*Maxy>0) then Gy:=Miny;
If (Miny*Maxy>0) and (Miny<0) then Gy:=Maxy;
Gy0:=round(Ky*Gy+Zy);                         {координати (0,0)}
Gx0:=Round(Kx*Gx+Zx);

KrokX:=(Mx-2*L) div 10;
KrokY:=(My-2*L) div 10;
If Minx*MaxX<0 then
  Cx:=(abs(MinX)*KrokX)/(Gx0-L)
else
  Cx:=(abs(MaxX-MinX)*KrokX)/(Mx-2*L);
If Miny*MaxY<0 then
  Cy:=(abs(MaxY)*Kroky)/(Gy0-L)
else
  Cy:=(abs(MaxY-MinY)*KrokY)/(My-2*L);
g:=0;
While (Gx0+g*KrokX)<(Mx-L) do
begin          {побудова вертикальних ліній гратки в 1, 4 чвертях}
  PaintBox1.Canvas.MoveTo(Gx0+g*KrokX, L);
  PaintBox1.Canvas.LineTo(Gx0+g*KrokX, My-L);
  PaintBox1.Canvas.Pen.Color:=clTeal;
  PaintBox1.Canvas.Pen.Style:=psDash;
  PaintBox1.Canvas.Pen.Width:=1;
  If (Gx0+g*KrokX)<(Mx-L-10) then
    begin
        PaintBox1.Canvas.MoveTo(Gx0+g*KrokX, Gy0-5);
        PaintBox1.Canvas.LineTo(Gx0+g*KrokX, Gy0+5);
    end;
  g:=g+1;
  end;
for i:=1 to g-1 do
  Begin
    If Minx*MaxX<0 then
      begin
        PaintBox1.Canvas.TextOut(Gx0+i*Krokx, Gy0+10, FloatToStrF((0+i*Cx),ffGeneral,2,5));
      end
    else
        PaintBox1.Canvas.TextOut(Gx0+i*Krokx, Gy0+10, FloatToStrF((Minx+i*Cx),ffGeneral,2,5))
    end;
g:=0;
While (Gx0-g*KrokX)>L do
  begin        {побудова вертикальних ліній гратки в 2, 3 чвертях}
    PaintBox1.Canvas.MoveTo(Gx0-g*KrokX, L);
    PaintBox1.Canvas.LineTo(Gx0-g*KrokX, My-L);
    PaintBox1.Canvas.Pen.Color:=clTeal;
    PaintBox1.Canvas.Pen.Style:=psDash;
    PaintBox1.Canvas.Pen.Width:=1;
    PaintBox1.Canvas.MoveTo(Gx0-g*KrokX, Gy0-5);
    PaintBox1.Canvas.LineTo(Gx0-g*KrokX, Gy0+5);
    g:=g+1
  end;
for i:=1 to g-1 do
  Begin
    If Minx*MaxX<0 then
      PaintBox1.Canvas.TextOut(Gx0-i*Krokx, Gy0+10, FloatToStrF((0-i*Cx), ffGeneral,2,5))
    else
      PaintBox1.Canvas.TextOut(Gx0-i*Krokx, Gy0+10, FloatToStrF((MaxX-i*Cx), ffGeneral,2,5));
  end;
t:=1;
While (Gy0-t*KrokY)>L do
  begin             {побудова горизонтальних ліній гратки в 1, 2 чвертях}
    PaintBox1.Canvas.MoveTo(L,Gy0-T*Kroky);
    PaintBox1.Canvas.LineTo(Mx-L,Gy0-t*Kroky);
    PaintBox1.Canvas.Pen.Color:=clTeal;
    PaintBox1.Canvas.Pen.Style:=psDash;
    PaintBox1.Canvas.Pen.Width:=1;
If (Gy0-t*Kroky)>(L+10) then
begin
  PaintBox1.Canvas.MoveTo(Gx0-5,Gy0-t*Kroky);
  PaintBox1.Canvas.LineTo(Gx0+5, Gy0-t*Kroky);
end;
t:=t+1
end;
for i:=1 to t-1 do
  Begin
    If MinY*MaxY<0 then
      PaintBox1.Canvas.TextOut(Gx0-28, Gy0-i*KrokY, FloatToStrF((0+i*Cy), ffGeneral,2,5))
  else
      PaintBox1.Canvas.TextOut(Gx0-28, Gy0-i*KrokY, FloatToStrF((MinY+i*Cy), ffGeneral,2,5)); end;
t:=1;
While (Gy0+t*KrokY)<(My-L) do
  begin          {побудова горизонтальних ліній гратки в 1, 2 чвертях}
     PaintBox1.Canvas.MoveTo(L, Gy0+t*KrokY);
     PaintBox1.Canvas.LineTo(Mx-L, Gy0+t*KrokY);
     PaintBox1.Canvas.Pen.Color:=clTeal;
     PaintBox1.Canvas.Pen.Style:=psDash;
     PaintBox1.Canvas.Pen.Width:=1;
     PaintBox1.Canvas.MoveTo(Gx0-5,Gy0+t*Kroky);
     PaintBox1.Canvas.LineTo(Gx0+5, Gy0+t*Kroky);
     t:=t+1
  end;
for i:=1 to t-1 do
  Begin
    If MaxY*MinY<0 then
      PaintBox1.Canvas.TextOut(Gx0-28, Gy0+i*KrokY, FloatToStrF((0-i*Cy), ffGeneral,2,5))
  else
      PaintBox1.Canvas.TextOut(Gx0-28, Gy0+i*KrokY, FloatToStrF((MaxY-i*Cy), ffGeneral,2,5));
  end;
If Minx*MaxX<=0 then
  If MinY*MaxY<=0 then
    PaintBox1.Canvas.TextOut(Gx0, Gy0+10, FloatToStr((0.0)));      {побудова осей}
    PaintBox1.Canvas.Pen.Color:=clTeal;
    PaintBox1.Canvas.Pen.Style:=psSolid;
    PaintBox1.Canvas.Pen.Width:=3;
    PaintBox1.Canvas.MoveTo(L, Gy0);
    PaintBox1.Canvas.LineTo(round(Mx-L), Gy0);
    PaintBox1.Canvas.MoveTo(Gx0,L);
    PaintBox1.Canvas.LineTo(Gx0, Round(My-L));
  PaintBox1.Canvas.MoveTo(Round(Mx-L), Gy0);                       {побудова стрілок}
  PaintBox1.Canvas.LineTo(Round(Mx-L)-10, Gy0-5);
  PaintBox1.Canvas.MoveTo(Round(Mx-L), Gy0);
  PaintBox1.Canvas.LineTo(Round(Mx-L)-10, Gy0+5);
  PaintBox1.Canvas.MoveTo(Gx0,L);
  PaintBox1.Canvas.LineTo(Gx0-5,L+10);
  PaintBox1.Canvas.MoveTo(Gx0,L);
  PaintBox1.Canvas.LineTo(Gx0+5,L+10);

case ComboBox2.ItemIndex of                                         {вибір стилю відображення}
0: begin
        PaintBox1.Canvas.Pen.Style:=psSolid;
        PaintBox1.Canvas.Pen.Width:=2;
    end;
1: begin
        PaintBox1.Canvas.Pen.Style:=psDot;
        PaintBox1.Canvas.Pen.Width:=1;
    end;
end;
      PaintBox1.Canvas.MoveTo(Round(Kx*Xe[0]+Zx), Round(Ky*ye[0]+Zy));        {побудова одного графіка}
      For i:=0 to Ne-1 do
        Begin
          PaintBox1.Canvas.Pen.Color:=clBlue;
          PaintBox1.Canvas.LineTo (Round(Kx*Xe[i]+Zx),Round(Ky*Ye[i]+Zy));
        End;
        if (grafs=true) then
        begin
          PaintBox1.Canvas.Moveto(Round(Kx*Xe[Ne+1]+Zx), Round(Ky*ye[Ne+1]+Zy));     {побудова другого графіка}
          For i:=Ne+1 to Ne*2 do
          Begin
            PaintBox1.Canvas.Pen.Color:=clAqua;
            PaintBox1.Canvas.Lineto (Round(Kx*Xe[i]+Zx),Round(Ky*Ye[i]+Zy));
          End;
        end;
    except
        showmessage('Шановний користувач, ви ввели не коректні дані');
    end;
end;

end.
