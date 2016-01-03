unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button2: TButton;
    Button3: TButton;
    Edit4: TEdit;
    Button4: TButton;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
function f(x:real):real;
begin
     f:= exp(x) - sin (x);
end;

function pohidna(x,dx:real):real;
begin
     pohidna:=(f(x+dx)-f(x))/dx;
end;

Function n(k:integer):integer;
  begin
    n:=k;
  end;

function Sign(x:real):real;
begin
      if x=0 then  Sign:=0;
      if x>0 then  Sign:=1;
      if x<0 then  Sign:=-1;
end;

procedure TForm2.Button1Click(Sender: TObject);
label K;
var
a,b,g,d,c,w,x,fd,fc:real;
begin
  a:=StrtoFloat(Edit1.Text);
  b:=StrtoFloat(Edit2.Text);
  g:=StrtoFloat(Edit3.Text);
   if a>b then
   begin
      w:=a;
      a:=b;
      b:=w;
   end;
    K:
     d:=a+(b-a)*(sqrt(5)-1)/2;
     fd:=f(d);
     c:=b-(b-a)*(sqrt(5)-1)/2;
     fc:=f(c);
  //   while abs(b-a)<g do
    //  begin
         if fc>=fd then
         begin
           //b:=d;
           //d:=c;
           //c:=b-(b-a)*(sqrt(5)-1)/2;
           //fd:=fc;
           //fc:=f(c);
           a:=c;
          end
          else
          begin
          //a:=c;
           //c:=d;
           //d:=a+(b-a)*(sqrt(5)-1)/2;
           //fc:=fd;
           //fd:=f(d);
           b:=d;
          end;
        if abs(b-a)<g then
                 begin
      x:=(a+b)/2;

      Label5.Caption:=FloatToStr(x);
       Label7.Caption:=FloattoStr(f(x));
        Label9.Caption:=Floattostr(pohidna(x,g))
                 end
                 else
                 goto K;
end;

procedure TForm2.Button2Click(Sender: TObject);
label M;
var
a,b,eps,g,c,q,p,x:real;
begin
  a:=StrtoFloat(Edit1.Text);
  b:=StrtoFloat(Edit2.Text);
  g:=StrtoFloat(Edit3.Text);
  eps:=0.00000001;

    if a>b then
   begin
      c:=a;
      a:=b;
      b:=c;
   end;

M:
   if abs(f(b)-f(a))<g then
      x:=(a+b)/2
      else

     begin
       p:=(a+b)/2+eps;
       q:=(a+b)/2-eps;
       if f(p)<f(q) then
       begin
          a:=p;
       end
       else
       begin
         b:=q;

       end;
       goto M;
     end;
        Label5.Caption:=FloatToStr(x);
        Label7.Caption:=FloattoStr(f(x));
        Label9.Caption:=Floattostr(pohidna(x,g))

end;

procedure TForm2.Button3Click(Sender: TObject);
var
  a,b,c,x,fmin,g:real;
  l,z,i,k,a1,b1:integer;
  xi,fxi:array [1..30000] of real;
begin
   a := StrtoFloat(Edit1.Text);
   b := StrtoFloat(Edit2.Text);
   z := StrToInt(Edit4.Text);
   g := StrtoFloat(Edit3.Text);
   if z<=30000 then
      begin
   l:=n(z);
   if a>b then
   begin
      c:=a;
      a:=b;
      b:=c;
   end;
   a1:=round(a*100000000);
   b1:=round(b*100000000);
   for i := 1 to l do
   begin
      randomize();
      xi[i]:=(a1+random(b1))/100000000;
   end;
   for i := 1 to l do
   begin
      fxi[i]:=f(xi[i]);
   end;
   fmin:=fxi[1];
   k:=1;
   for i := 2 to l do
   begin
      if fxi[i]<=fmin then
      begin
          fmin:=fxi[i];
          k:=i;
      end;
   end;
   x:=xi[k];
   Label5.Caption:=FloatToStr(x);
   Label7.Caption:=FloattoStr(f(x));
   Label9.Caption:=Floattostr(pohidna(x,g));
      end
      else
      ShowMessage('Кількість точок перевищує допустиме значення');
end;

procedure TForm2.Button4Click(Sender: TObject);
var
    x0,g,h,e,eps,i,i1,x,xx:real;
label M;
begin
    h:=StrToFloat(Edit5.Text);
    e:=StrToFloat(Edit6.Text);
    x0:=StrToFloat(Edit7.Text);
    eps:=StrToFloat(Edit8.Text);
M:
    begin
        g:=(f(x0+eps)-f(x0))/eps;
        i:=sign(round(g));
        x:=x0-h*g;
        g:=(f(x)-f(x0))/(x-x0);
        x0:=x;
        i1:=sign(g);
    end;
    if abs(g)<e then
        xx:=x
    else
    begin
      if i1=i then
         h:=h*1.6
         else
         begin
         h:=h/2;
         end;
         i:=i1;
         goto M;
    end;
    label5.Caption:=FloatToStr(xx);
    label7.Caption:=FloattoStr(f(xx));
    label9.Caption:=FloatToStr(g);
end;
end.
