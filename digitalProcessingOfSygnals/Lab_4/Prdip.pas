unit Prdip;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtDlgs, ExtCtrls, StdCtrls,jpeg, TeEngine, Series, TeeProcs,
  Chart,Math;
  Type mas=array [1..256] of real48;
      mas2=array [1..256,1..256] of real48;
type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    Edit1: TEdit;
    Label1: TLabel;
    Image3: TImage;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Chart1: TChart;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    N12: TMenuItem;
    Image2: TImage;
    Image1: TImage;
    N13: TMenuItem;
    N6: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    Image4: TImage;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    Label2: TLabel;
    N20: TMenuItem;
    Series1: TBarSeries;
    N21: TMenuItem;
    N901: TMenuItem;
    N1801: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    D1: TMenuItem;
    N27: TMenuItem;

    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N901Click(Sender: TObject);
    procedure N1801Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    

  private
    { Private declarations }

    nh,nw,n,k:integer;
    a,b:array[1..256,1..256] of byte;
    c,d:array[0..255] of longword;
    imre,imim,imre1,imim1:mas2;
    cl:TColor;
    imet:byte;
    cmax:real48;
    bgist,bspk:boolean;
  public
    { Public declarations }
         Bitmap1,Bitmap2,Bitmap3,Bitmap4: TBitmap;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
procedure pfur( d,n:integer; var xre,xim:mas);
label 1,2,3;
var k,l,l1,l2,i,j,i1,n2,m1,m:integer;
    u1,u2,u3,a2,c,s,t1,t2,t3,t4:real;
begin
  m:=0;
  repeat m:=m+1 until((n-1) shr m)=0;
  n2:= n div 2; l2:=n+n; l1:=n;
  for l:=1 to m do
    begin
      l2:=l2 div 2;
      l1:=l1 div 2;
      u1:=1.0; u2:=0.0;
      a2:=pi/l1; c:=cos(a2); s:=d*sin(a2);
      for j:=1 to l1 do
        begin
          i:=j; while i<=n do
                  begin
                    i1:=i+l1;
                    t1:=xre[i]+xre[i1];
                    t2:=xim[i]+xim[i1];
                    t3:=xre[i]-xre[i1];
                    t4:=xim[i]-xim[i1];
                    xre[i1]:=t3*u1-t4*u2;
                    xim[i1]:=t4*u1+t3*u2;
                    xre[i]:=t1; xim[i]:=t2;
                    i:=i+l2;
                  end;
          u3:=u1*c-u2*s;
          u2:=u2*c+u1*s; u1:=u3;
        end;
    end;
  m1:=n-1; j:=1;
  for i:=1 to m1 do
    begin
      if i>=j then goto 1;
      t1:=xre[j]; t2:=xim[j];
      xre[j]:=xre[i];
      xim[j]:=xim[i];
      xre[i]:=t1; xim[i]:=t2;
   1: k:=n2;
   2: if k>=j then goto 3;
      j:=j-k;
      k:=k div 2;
      goto 2;
   3: j:=j+k;
    end;
  if d=-1 then for i:=1 to n do begin
        xre[i]:=xre[i]/n; xim[i]:=xim[i]/n;end;
end;

procedure pfur2(d,n:integer; var imre,imim:mas2);
var i,k:integer;
    xre,xim:mas;
begin

  for k:=1 to n do begin
    for i:=1 to n do
      begin
        xre[i]:=imre[i,k];
        xim[i]:=imim[i,k];
      end;
    pfur(d,n,xre,xim);
    for i:=1 to n do
      begin
      imre[i,k]:=xre[i]; imim[i,k]:=xim[i]; end;
    end;
  for i:=1 to n do begin
    for k:=1 to n do
      begin
      xre[k]:=imre[i,k]; xim[k]:=imim[i,k]; end;
    pfur(d,n,xre,xim);
    for k:=1 to n do
      begin
       imre[i,k]:=xre[k]; imim[i,k]:=xim[k]; end;
    end;
end;


                 {Ввести}
procedure TForm1.N3Click(Sender: TObject);
var i,j:integer;
    fname:string;
    c:byte;
    jp: TJPEGImage;
begin
  Bitmap1 := TBitmap.Create;
  jp := TJPEGImage.Create;
   if OpenPictureDialog1.Execute then
     fname:=OpenPictureDialog1.FileName;
          if (Extractfileext(fname)='.bmp') or (Extractfileext(fname)='.BMP')
          then Bitmap1.LoadFromFile(fname);
         if Extractfileext(fname)='.jpg'
           then
            begin
                jp.LoadFromFile(fname);
                Bitmap1.Assign(jp);
            end;
    Image1.Picture.Assign(BitMap1);
    nh:=256;
    nw:=256;
    n:=nh*nw;
    for i:=1 to nh do
      for j:=1 to nw do
         begin
         c:=Lo(BitMap1.Canvas.Pixels[i,j] and $000000FF);
        a[i,j]:=c;
         end;
   bgist:=False;
   bspk:=False;
end;

                {Дискретизувати}
procedure TForm1.N5Click(Sender: TObject);
begin
    Label1.Visible:=True;
    Label2.Visible:=True;
    Label1.Caption:='Введіть коефіцієнт дискретизації :';
    Edit1.Visible:=True;
    Edit1.SetFocus;
    imet:=1;
end;

procedure TForm1.N6Click(Sender: TObject);
                {Спектр Фур'є}
var  i,j:integer;
     r:real48;
     spim,j1,i1:byte;
begin
  for i:=1 to nh do
     for j:=1 to nw do
       begin
         imre[i,j]:=a[i,j];
         imim[i,j]:=0;
       end;
     pfur2(-1,nh,imre,imim);
   cmax:=0;
   for i:=1 to nh do
     for j:=1 to nw do
       begin
       r:=sqrt(sqr(imre[i,j])+sqr(imim[i,j]));
       if cmax<r then cmax:=r;
       end;
    Bitmap2:= TBitmap.Create;
    Bitmap2.PixelFormat := pf24bit;
    Bitmap2.Width := Image2.Width;
    Bitmap2.Height := Image2.Height;
    for i:=1 to nh do
     for j:=1 to nw do
       begin
         spim:=round(2000*ln(sqrt(sqr(imre[i,j])+sqr(imim[i,j]))/cmax*255+1));
         cl:=spim+256*spim+65536*spim;
         j1:=127+j; i1:=127+i;
         BitMap2.Canvas.Pixels[j1,i1]:=cl;
       end;
     Image2.Picture.Assign(Bitmap2);
     bspk:=True;
end;


procedure TForm1.N7Click(Sender: TObject);
                    {Діагональна лінія}
var  i,j, diff:integer;
     spim:byte;
begin
    Bitmap1:= TBitmap.Create;
    Bitmap1.PixelFormat := pf24bit;
    Bitmap1.Width := Image1.Width;
    Bitmap1.Height := Image1.Height;
    for i:=1 to 256 do
        for j:=1 to 256 do
        begin
                a[i,j]:=200;
                cl:=a[i,j]+ a[i,j] shl 8 + a[i,j] shl 16;
                Bitmap1.Canvas.Pixels[j-1,i-1]:=cl;
        end;
    for i:=10 to 246 do
        for j:=10 to 246 do
        if  (i = j) or (i = j-1) or (i = j+1) then
        begin
            a[i,j]:=100;
            cl:=a[i,j]+ a[i,j] shl 8 + a[i,j] shl 16;
            Bitmap1.Canvas.Pixels[j-1,i-1]:=cl;
        end;
    Image1.Picture.Assign(Bitmap1);
    bgist:=False;
    bspk:=False;
end;

procedure TForm1.N26Click(Sender: TObject);
                    {Коло}
var  i,j,r,c:integer;
begin
    Bitmap1:= TBitmap.Create;
    Bitmap1.PixelFormat := pf24bit;
    Bitmap1.Width := Image1.Width;
    Bitmap1.Height := Image1.Height;
      for i:=1 to 256 do
        for j:=1 to 256 do
        begin
          a[i,j]:=200;
          cl:=a[i,j]+256*a[i,j]+65536*a[i,j];
          Bitmap1.Canvas.Pixels[i,j]:=cl;
        end;
      r:=64;
      c:=128;
        for i:=64 to 192 do
          for j:=-round(sqrt(r*r-(i-c)*(i-c)))+c to round(sqrt(r*r-(i-c)*(i-c)))+c do
          begin
            a[i,j]:=100;
            cl:=a[i,j]+256*a[i,j]+65536*a[i,j];
            Bitmap1.Canvas.Pixels[i,j]:=cl;
          end;

     Image1.Picture.Assign(Bitmap1);
     bgist:=False;
     bspk:=False;
end;

procedure TForm1.N8Click(Sender: TObject);
               {Гістограма -> c}
var i,j:integer;
begin
   Chart1.Visible:=True;
   Series1.Clear;


   bgist:=True;
end;

procedure TForm1.N9Click(Sender: TObject);
                {Вирівнювання гістограми}
var i,j:integer;
begin
   if not bgist then N8Click(Self);


     Image3.Picture.Assign(Bitmap3);
end;

procedure TForm1.N10Click(Sender: TObject);
                {Стиск гістограми}
begin
    Label1.Visible:=True;
    Label2.Visible:=True;
    Label1.Caption:='Коефіцієнт:';
    Edit1.Visible:=True;
    Edit1.SetFocus;
    imet:=2;
end;

procedure TForm1.N11Click(Sender: TObject);
                  {Записати}
var fname:string;
begin
  if SavePictureDialog1.Execute
  then
    begin
    fname:=SavePictureDialog1.FileName+'.bmp';
    BitMap3.SaveToFile(fname);
    end
    else
      Application.MessageBox('Запис не відбувся','Помилка запису',MB_OKCANCEL);
end;

procedure TForm1.N12Click(Sender: TObject);
                {Квантування}
  begin
    Label1.Visible:=True;
    Label2.Visible:=True;
    Label1.Caption:='Введіть кількість рівнів яскравості:';
    Edit1.Visible:=True;
    Edit1.SetFocus;
    imet:=3;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    BitMap3:= TBitmap.Create;
    BitMap3.PixelFormat := pf24bit;
    BitMap3.Width := Image3.Width;
    BitMap3.Height := Image3.Height;
    bgist:=False;
    bspk:=False;
end;

procedure TForm1.N15Click(Sender: TObject);
                {Білий шум}
begin
  Label1.Visible:=True;
  Label2.Visible:=True;
  Label1.Caption:='Введіть коефіцієнт шуму:';
  Edit1.Visible:=True;
  Edit1.SetFocus;
  imet:=4;
end;

procedure TForm1.N16Click(Sender: TObject);
                {Ідеальний ФНЧ}
begin
  if not bspk then N6Click(Self);
  Label1.Visible:=True;
  Label2.Visible:=True;
  Label1.Caption:='Введіть частоту зрізу:';
  Edit1.Visible:=True;
  Edit1.SetFocus;
  imet:=5;
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i1,j1,spim, lx,ly:byte;
    i,j,k1:integer;
    ls:longint;
    r:real48;
    gamma:Real;
  begin
  if Key=VK_RETURN then
    begin
    case imet of
    1:begin
        {dyskr}
       k:=StrToInt(Edit1.Text);
       j1:=1;
      repeat
        i1:=1;
        repeat
          ls:=0;
          for i:=i1 to (i1+k-1) do
            for j:=j1 to (j1+k-1) do
              ls:=ls+a[i,j];

          for i:=i1 to (i1+k-1) do
            for j:=j1 to (j1+k-1) do
              b[i,j]:=round(ls/(k*k));
          i1:=i1+k;
        until (i>=256);
        j1:=j1+k;
      until (j>=256);

      end;
      2:begin
     {Stysk}
     k:=StrToInt(Edit1.Text);

      end;
         3:begin
        {Kvant}
          k:=StrToInt(Edit1.Text);
          k1:=round(log2(256/k));
          for i:=1 to 256 do
              for j:=1 to 256 do
                  b[i,j]:=((a[i,j] shr k1) shl k1);
        end;
        4:begin
     {Shym}
  k:=StrToInt(Edit1.Text);


        end;
        5,6:begin
     {FNCh}
   Chart1.Visible:=False;
   k:=StrToInt(Edit1.Text);


     end;
       7:begin
             k:=StrToInt(Edit1.Text);

            
         end; {7}

       8:begin
       {zmenshyty}
          k:=StrToInt(Edit1.Text);
       j1:=1; ly:=1;
      repeat
        i1:=1;
        lx:=1;
        repeat
          ls:=0;
          for i:=i1 to (i1+k-1) do
            for j:=j1 to (j1+k-1) do
              ls:=ls+a[i,j];
          b[lx,ly]:=round(ls/(k*k));
          i1:=i1+k;
          lx:=lx+1;
        until (i>=256-k);
        j1:=j1+k;
        ly:=ly+1;
      until (j>=256-k);
       end;
    end; {case}
    case imet of
      1..4,7:
          begin
            for i:=1 to 256 do
              for j:=1 to 256 do
                begin
                  cl:=b[i,j]+256*b[i,j]+65536*b[i,j];
                  BitMap3.Canvas.Pixels[i-1,j-1]:=cl;
                end;
             Image3.Picture.Assign(BitMap3);
           end;
      8:
      begin
            for i:=1 to 256 do
              for j:=1 to 256 do
                BitMap3.Canvas.Pixels[i,j]:=rgb(255,255,255);

            for i:=1 to lx do
              for j:=1 to ly do
                begin
                  cl:=rgb(b[i,j],b[i,j],b[i,j]);
                  BitMap3.Canvas.Pixels[i,j]:=cl;
                end;
             Image3.Picture.Assign(BitMap3);
      end;
         5,6:begin
           Bitmap4:= TBitmap.Create;
           Bitmap4.PixelFormat := pf24bit;
           Bitmap4.Width := Image4.Width;
           Bitmap4.Height := Image4.Height;
           for i:=1 to 256 do
             for j:=1 to 256 do
               begin
                 spim:=round(2000*ln(sqrt(sqr(imre1[i,j])+sqr(imim1[i,j]))/cmax*255+1));
                 cl:=spim+256*spim+65536*spim;
                 j1:=127+j; i1:=127+i;
                 BitMap4.Canvas.Pixels[j1,i1]:=cl;
                end;
            Image4.Picture.Assign(Bitmap4);
            end;
         end;  {case}
  end;
end;

procedure TForm1.N17Click(Sender: TObject);
        {Обернене ДПФ}
var i,j:integer;
begin
  pfur2(1,nh,imre1,imim1);
  for i:=1 to 256 do
    for j:=1 to 256 do
      b[i,j]:=round(imre1[i,j]);
  for i:=1 to 256 do
    for j:=1 to 256 do
      begin
        cl:=b[i,j]+256*b[i,j]+65536*b[i,j];
        BitMap3.Canvas.Pixels[i-1,j-1]:=cl;
      end;
  Image3.Picture.Assign(BitMap3);
end;

procedure TForm1.N18Click(Sender: TObject);
                {Ідеальний ФВЧ}
begin
  Label1.Visible:=True;
  Label2.Visible:=True;
  Label1.Caption:='Введіть частоту зрізу:';
  Edit1.Visible:=True;
  Edit1.SetFocus;
  imet:=6;
end;

procedure TForm1.N19Click(Sender: TObject);
                {Сіль і перець}
begin
  Label1.Visible:=True;
  Label2.Visible:=True;
  Label1.Caption:='Введіть коефіцієнт шуму (<32000):';
  Edit1.Visible:=True;
  Edit1.SetFocus;
  imet:=7;
end;
                    {Обмін}
procedure TForm1.N20Click(Sender: TObject);
var i,j:integer;
     r:byte;
begin
  Label1.Visible:=False;
  Label2.Visible:=False;
  Edit1.Visible:=False;
  for i:=1 to 255 do
    for j:=1 to 255 do
      begin
      r:=a[i,j];
      a[i,j]:=b[i,j];
      b[i,j]:=r;
      BitMap1.Canvas.Pixels[i-1,j-1]:=a[i,j]+a[i,j] shl 8+a[i,j] shl 16;
      BitMap3.Canvas.Pixels[i-1,j-1]:=r+r shl 8+r shl 16;
      end;
    Image3.Picture.Assign(BitMap3);
    Image1.Picture.Assign(BitMap1);
end;

        {Поворот на 90 градусів}
procedure TForm1.N901Click(Sender: TObject);
var i,j:Integer;
begin
      for i:=1 to 256 do
        for j:=1 to 256 do
        begin
              b[i,j]:=a[256-j+1,i];
              cl:=rgb(b[i,j],b[i,j],b[i,j]);
              BitMap3.Canvas.Pixels[i,j]:=cl;
        end;
        Image3.Picture.Assign(BitMap3);
end;

          {Поворот на 180 градусів}
procedure TForm1.N1801Click(Sender: TObject);
var i,j:Integer;
begin
      for j:=1 to 256 do
        for i:=1 to 256 do
        begin
              b[i,j]:=a[256-i+1,256-j+1];
              cl:=rgb(b[i,j],b[i,j],b[i,j]);
              BitMap3.Canvas.Pixels[i,j]:=cl;
        end;
        Image3.Picture.Assign(BitMap3);
end;


procedure TForm1.N23Click(Sender: TObject);
begin

end;
                   {Збільшити} 
procedure TForm1.N24Click(Sender: TObject);
var   i1,j1:byte;
      i,j,lx,ly:integer;
begin
      j1:=1; ly:=1;
      repeat
        i1:=1;
        lx:=129;
        repeat
          for i:=i1 to i1+1 do
            for j:=j1 to j1+1 do
              b[i,j]:=a[lx,ly];
          i1:=i1+2;
          lx:=lx+1;
        until (i>=256);
        j1:=j1+2;
        ly:=ly+1;
      until (j>=256);
            for i:=1 to 256 do
              for j:=1 to 256 do
                BitMap3.Canvas.Pixels[i,j]:=rgb(b[i,j],b[i,j],b[i,j]);
      Image3.Picture.Assign(BitMap3);
end;
                    {Зменшити}
procedure TForm1.N25Click(Sender: TObject);
begin
  Label1.Visible:=True;
  Label2.Visible:=True;
  Label1.Caption:='Введіть коефіцієнт зменшення (<?????):';
  Edit1.Visible:=True;
  Edit1.SetFocus;
  imet:=8;
end;

      {Поворот на заданий кут}
procedure TForm1.N22Click(Sender: TObject);
var i,j,i1,j1:Integer;
    fi:Real;
begin
        Label1.Visible:=True;
        Label2.Visible:=True;
        Label1.Caption:='Введіть кут повороту (в радіанах):';
        Edit1.Visible:=True;
        Edit1.SetFocus;
      fi:=StrToFloat(Edit1.Text);

      for j:=1 to 256 do
        for i:=1 to 256 do
        begin
              i1:=round(i*cos(fi)-j*sin(fi));
              j1:=round(i*cos(fi)+j*sin(fi));
              if((j1>=0)and(i1>=0))then
              begin
                b[i1,j1]:=a[i,j];
                cl:=rgb(b[i1,j1],b[i1,j1],b[i1,j1]);
                BitMap3.Canvas.Pixels[i1,j1]:=cl;
              end;
        end;
        Image3.Picture.Assign(BitMap3);

end;

procedure TForm1.N31Click(Sender: TObject);
                    {Ромб}
var  i,j, diff:integer;
     spim:byte;
begin
    Bitmap1:= TBitmap.Create;
    Bitmap1.PixelFormat := pf24bit;
    Bitmap1.Width := Image1.Width;
    Bitmap1.Height := Image1.Height;
    for i:=1 to 256 do
        for j:=1 to 256 do
        begin
                a[i,j]:=200;
                cl:=a[i,j]+ a[i,j] shl 8 + a[i,j] shl 16;
                Bitmap1.Canvas.Pixels[j-1,i-1]:=cl;
        end;
    {верхня права частина}
    {for i:=110 to 218 do
        for j:=10 to 118 do
        if  (i = j) or (i = j-1) or (i = j+1) then
        begin
            a[i,j]:=100;
            cl:=a[i,j]+ a[i,j] shl 8 + a[i,j] shl 16;
            Bitmap1.Canvas.Pixels[j-1,i-1]:=cl;
        end;      }

    diff:=64;
        for i:=diff to 2*diff do
          for j:=-diff+i to diff+i do
          begin
            a[i,j]:=100;
            cl:=a[i,j]+256*a[i,j]+65536*a[i,j];
            Bitmap1.Canvas.Pixels[i,j]:=cl;
          end;
    Image1.Picture.Assign(Bitmap1);
    bgist:=False;
    bspk:=False;
end;

procedure TForm1.N32Click(Sender: TObject);
                    {Вертикальна лінія}
var  i,j:integer;
     spim:byte;
begin
    Bitmap1:= TBitmap.Create;
    Bitmap1.PixelFormat := pf24bit;
    Bitmap1.Width := Image1.Width;
    Bitmap1.Height := Image1.Height;
      for i:=1 to 256 do
        for j:=1 to 256 do
        begin
          a[i,j]:=200;
          cl:=a[i,j]+256*a[i,j]+65536*a[i,j];
          Bitmap1.Canvas.Pixels[i,j]:=cl;
        end;

        i:=200;
        for j:=1 to 256 do
        begin
          a[i,j]:=100;
          cl:=a[i,j]+256*a[i,j]+65536*a[i,j];
          Bitmap1.Canvas.Pixels[i,j]:=cl;
        end;
     Image1.Picture.Assign(Bitmap1);
     bgist:=False;
     bspk:=False;
end;

procedure TForm1.N27Click(Sender: TObject);
var i,j:integer;
    r:real48;
    spim,j1,i1:byte;
begin
  for i:=1 to 256 do
    for j:=1 to 256 do
      begin
          imre1[i,j]:=0;
          imim1[i,j]:=0;
      end;
  i:=200;
  for j:=1 to 256 do
    imre1[i,j]:=100;

  pfur2(-1,nh,imre1,imim1);
  
  for i:=1 to nh do
     for j:=1 to nw do
       begin
         imre[i,j]:=imre1[i,j];
         imim[i,j]:=imim1[i,j];
       end;
   cmax:=0;
   for i:=1 to nh do
     for j:=1 to nw do
       begin
       r:=sqrt(sqr(imre[i,j])+sqr(imim[i,j]));
       if cmax<r then cmax:=r;
       end;
    Bitmap1:= TBitmap.Create;
    Bitmap1.PixelFormat := pf24bit;
    Bitmap1.Width := Image1.Width;
    Bitmap1.Height := Image1.Height;
    for i:=1 to nh do
     for j:=1 to nw do
       begin
         spim:=round(2000*ln(sqrt(sqr(imre[i,j])+sqr(imim[i,j]))/cmax*255+1));
         cl:=spim+256*spim+65536*spim;
         j1:=127+j; i1:=127+i;
         BitMap2.Canvas.Pixels[j1,i1]:=cl;
       end;
     Image1.Picture.Assign(Bitmap1);
     bspk:=True;
end;

end.
