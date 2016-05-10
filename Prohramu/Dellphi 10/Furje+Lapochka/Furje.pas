unit Furje;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls ;

type
  Vector=array[0..640] of Real;
  vec=array[0..40] of real;
  TForm2 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TPaintBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  var Xe, Ye, Xg, Yg :          Vector;
      a, b, c           :vec;
      minYg, maxYg, MaxX, MaxY, MinX, MinY, Kx, Ky, Zx, Zy, x, Gx, Gy, xx, yy :Real;
      al, bl, h, Krx, Kry, Tp, Max, ay, bx                :Real;
      Ne, Ngr, KrokX, KrokY, L, Ng, j, i   :Integer;


implementation

{$R *.dfm}
function f(x:real):real;

         begin
              TP:=bl-al;
                if x<TP/2 then f:=8  // x<TP/2
                        else
                if(x>=TP/2)and(x<3*TP/4) then // x<3*TP/4
                f:=16*(TP-2*x)/TP  //4*(TP-2*x)/TP
                         else
                f:=32*(x-TP)/TP;   //8*(x-TP)/TP;
       end;
            {begin
                if ( x >= -5 ) and ( x <= 3 ) then f := 8
                else
                if(x>3)and(x<5) then
                f := -5*x + 15
                else
                if ( x >=5 )and ( x <= 7 ) then f := 5*x - 35;
            end;  }
  procedure Fur(Xe,Ye:vector;Ne:integer;var Yg:vector);
        var
         	k        :integer;
         	w, S, G, D, KOM   :real;
      begin
          TP:=bl-al;
          w:=2*pi/TP;
            for k:=1 to Ng do
              begin
                KOM:=k*w;
                G:=0;
                D:=0;
                for i:=1 to Ne do
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
           for i:=0 to Ne-1 do
            begin
             S:=0;
             D:=Xe[i]*w;
              for k:=1 to Ng do
               begin
                KOM:=k*D;
                S:=S+b[k]*sin(KOM)+a[k]*cos(KOM);
               end;
             Yg[i]:=a[0]+S;
            end;
      end;
procedure rozrah(al, bl: Real; Ne, Ngr: Integer;var Xe,Ye,Yg :Vector );
begin
	h := ( bl - al ) / ( Ne - 1 );
    Xe [ 0 ] := al;
    for i :=  0 to Ne - 1 do
    	begin
          Ye [ i ] := f ( Xe [i]);
          Xe [ i + 1 ] := Xe [ i ] + h;
        end;
   // al := Xe [ 0 ];
   // bl := Xe [Ne - 1];
    Fur (Xe, Ye, Ne, Yg);
    L := 15;
    Minx := Xe [ 0 ];
  	MaxX := Xe [Ne - 1];
  	MinYg :=Ye[0];  //Yg
  	MaxYg :=Ye[0];  //Yg
    For i:=0 to Ne - 1 do  // Ngr - 1
      Begin
        If MaxYg<Yg[i] then MaxYg:=Yg[i];
        If MinYg>Yg[i] then MinYg:=Yg[i];
      End;
    MinY:=Ye[0];MaxY:=Ye[0];
    For i:=0 to Ne - 1 do
      Begin
        If MaxY<Ye[i] then MaxY:=Ye[i];
        If MinY>Ye[i] then MinY:=Ye[i];
      End;
    If MaxY<MaxYg then MaxY:=MaxYg;
    If MinY>MinYg then MinY:=MinYg;
  	Kx:=(Form2.Image1.ClientWidth-2*L)/(MaxX-MinX);
  	Ky:=(Form2.Image1.ClientHeight-2*L)/(MinY-MaxYg);  // - MaxY
  	Zx:=(Form2.Image1.ClientWidth*MinX-L*(MinX+MaxX))/(MinX-MaxX);
  	Zy:=(Form2.Image1.ClientHeight*MaxY-L*(MinY+MaxY))/(MaxY-MinYg);   // - MinY
  	If  MinX*MaxX<=0 then Gx:=0;
  	If ( minX*MaxX>0) then Gx:=MinX;
  	If (( MinX*MaxX>0)and(MinX<0)) then Gx:=MaxX;
  	If ( MinY*MaxY <=0) then Gy:=0;
  	If ((MinY*MaxY>0)and(MinY>0))then Gy:=MinY;
  	If ((MinY*MaxY>0)and(MinY<0))then Gy:=MaxY;
  	ay := Kx * Gx + Zx;
  	bx := Ky * Gy + Zy;
end;
procedure Gratka();
begin
       with Form2.Image1.Canvas do
         begin
          Pen.Color:=clteal;
          pen.Width:=2;
          MoveTo(L,Round(bx));
          LineTo(Round(Form2.Image1.ClientWidth-L),Round(bx));
          MoveTo(Round(ay),L);
          lineTo(Round(ay),Form2.Image1.ClientHeight-L);
            KrokX:=(Form2.Image1.ClientWidth-2*L)div 10;
  			KrokY:=(Form2.Image1.ClientHeight-2*L)div 10;
          Pen.Width:=2;
          for i:=0 to 10 do
          begin
           	pen.Style:=psDot;
          	MoveTo(L,Round(bx)+i*KrokY);
          	LineTo(Form2.Image1.ClientWidth-L,Round(bx)+i*KrokY);
            MoveTo(L,Round(bx)-i*KrokY);
          	LineTo(Form2.Image1.ClientWidth-L,Round(bx)-i*KrokY);
          	MoveTo(Round(ay)+i*KrokX,L);
          	LineTo(Round(ay)+i*KrokX,Form2.Image1.ClientHeight-L);
            MoveTo(Round(ay)-i*KrokX,L);
          	LineTo(Round(ay)-i*KrokX,Form2.Image1.ClientHeight-L);
            Pen.Color:=clskyblue;
            Pen.Width:=1;
          end;
          Krx:=(MaxX-MinX)/10;
          Kry:=(MaxY-MinY)/10;
          xx:=minx;
          yy:=maxy;
          For i:=0 to 10 do
              Begin
               Pen.Color:=clblack;
               Pen.Style:=psdash;
               TextOut(L+i*KrokX+10,Round(Ky*Gy+Zy)-L+10,FloatToStrF(xx,ffGeneral,0,0));
               TextOut(Round(Kx*Gx+Zx)-25,L+i*KrokY+25,FloatToStrF(yy,ffGeneral,0,0));
               XX:=XX+KrX;
               yy:=yy-KrY;
              End;
       End;
End;

procedure TForm2.BitBtn1Click(Sender: TObject);
var hgr,krok, t,v :real;
	isInStart:boolean;

begin
	al:=StrToFloat( Edit1.text);
    bl:=StrToFloat( Edit2.text);
    if (abs(al)>=abs(bl)) or (al=0) or (bl=0) or (bl=al) or (bl= -1*al) then
    Begin
      Showmessage('Incorrect boundaries');
      Exit;
    End;
    Ne := StrToInt( Edit5.Text);
    Ngr := StrToInt( Edit4.Text);
    Ng := StrToInt( Edit3.Text);
    hgr:=(bl-al)/Ngr;
    rozrah(al, bl, Ne, Ngr, Xe, Ye, Yg);
    krok:=hgr/h;
  //  isInStart:=false;
    case ComboBox1.ItemIndex of
  0:begin
  		Form2.Image1.Refresh;
        Gratka();
        if (Ngr > Ne) then
    	begin
    		Application.MessageBox ('Graphic has some defects because Ngr > Ne', 'Error!!!', MB_OK);
            Halt;
        end;
        with Form2.Image1.Canvas do
         begin
           Pen.Color := clBlue;
           pen.Width:=2;
           //MoveTo(Round(Kx*XE[0]+Zx),Round(Ky*Yg[0]+Zy));
           for i := 0 to Ne - 1 do   //Ngr
             Begin
             //	if((Xe[i{round(i*krok)}]>=-5)and (Xe[round(i*krok)]<=7))then
               Ellipse(Round (Kx*Xe[{round(i*krok)}i]+Zx)-2, Round(Ky*Ye[{round(i*krok)}i]+Zy)-2,
               Round (Kx*Xe[i{round(i*krok)}]+Zx)+2, Round(Ky*Ye[{round(i*krok)}i]+Zy)+2);
               {if((Xe[round(i*krok)]>=-5)and (Xe[round(i*krok)]<=3))then
               LineTo( Round (Kx*Xe[Round(i*krok)]+Zx), Round(Ky*Ye[Round(i*krok)]+Zy));       }

             End;
         end;
     end;
  1:Begin
        Image1.Refresh;
        Gratka();
        if (Ngr > Ne) then
    	begin
    		Application.MessageBox ('Graphic has some defects because Ngr > Ne', 'Error!!!', MB_OK);
            Halt;
        end;
      with Image1.Canvas do
            begin
               Pen.Color:=clBlue;
               pen.Width:=2;
               //MoveTo(Round(Kx*XE[0]+Zx),Round(Ky*Ye[0]+Zy));
               For i:=0 to Ne-1 do // Ngr
               begin
               //   if((Xe[round(i*krok)]>=-5)and (Xe[round(i*krok)]<=7))then
               {LineTo( Round (Kx*Xe[i*krok]+Zx), Round(Ky*Ye[i*krok]+Zy)); }
               Ellipse(Round (Kx*Xe[i{round(i*krok)}]+Zx)-2, Round(Ky*Ye[i{round(i*krok)}]+Zy)-2,
               Round (Kx*Xe[i{round(i*krok)}]+Zx)+2, Round(Ky*Ye[i{round(i*krok)}]+Zy)+2);
               end;
               Pen.Color:=clAqua;
               Pen.Width:=4;
               Pen.Style:=psDash;
               For i:=0 to Ne-1 do
                  Begin
                      //if((Xe[i]>=-5)and (Xe[i]<=7)and(isInStart=false))then
                     // begin
                      	//isInStart:=true;
                      	MoveTo(Round (Kx*XE[round(i)]+Zx),Round(Ky*Yg[round(i)]+Zy));
                     // end;
                      //if((Xe[i]>=-5)and (Xe[i]<=7)and (isInStart=true))then
                        LineTo(Round (Kx*XE[round(i)]+Zx),Round(Ky*Yg[round(i)]+Zy));
                  End;
            End;
    End;
  2:Begin
        Image1.Refresh;
    t:=bl-al;
 v:=2*pi/t;
        Krokx :=Image1.ClientWidth div (Ng+5);
    Max:=c[1];
      For i:= 0 to Ng do
        If c[i] > Max then Max:=c[i];
    Ky := 300/max;
    Image1.Canvas.Pen.Color := clAqua;
    with Image1.Canvas do
    	Begin
    		MoveTo(L, Image1.ClientHeight-50 );
    		LineTo(Image1.ClientWidth-40, Image1.ClientHeight-50);
    		TextOut(Image1.ClientWidth-20, Image1.ClientHeight-45 ,'X');
            MoveTo(Image1.ClientWidth-40, Image1.ClientHeight-50);                       {побудова стрілок}
          	LineTo(Image1.ClientWidth-45, Image1.ClientHeight-55);
  		   	MoveTo(Image1.ClientWidth-40, Image1.ClientHeight-50);
  			LineTo(Image1.ClientWidth-45, Image1.ClientHeight-45);
        End;
    x:=KrokX+15;
    For i:= 1 to Ng do
      Begin
          Image1.Canvas.Pen.Color := clBlue;
          Image1.Canvas.MoveTo(Round(x)+3,Image1.ClientHeight-50);
          Image1.Canvas.LineTo(Round(x)+3,Image1.ClientHeight-50-Round(ky*c[i]));
          Image1.Canvas.TextOut(round(x)-10,Image1.ClientHeight - Round(ky*c[i])-60,FloatToStrF(x,ffGeneral,2,0));
          Image1.Canvas.Ellipse(round(x),Image1.ClientHeight-53,round(x)+5,Image1.ClientHeight-48);
          Image1.Canvas.Ellipse(Round(x)+1,Image1.ClientHeight-50-Round(ky*c[i]),Round(x)+7,Image1.ClientHeight-50-Round(ky*c[i])+5);
          Image1.Canvas.TextOut(round(x),Image1.ClientHeight-40,FloatToStrF(v,ffGeneral,0,0));
          Image1.Canvas.Ellipse(round(x),Image1.ClientHeight-53,round(x)+5,Image1.ClientHeight-48);
          x:=x+KrokX;
      end;
    End;
  end;
end;

end.
