//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//    Автор: Борисов С. А.
//    E-mail: save-x@yandex.ru
//    Сайт автора: www.DelphiDevelop.ru
//
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TArray = Array [1..4, 1..4] of Real;

type
  _3D = class
    x,y,z:integer;
  end;

Const NumVersin = 8;

var
  Form1: TForm1;
  tr: array [1..NumVersin, 1..NumVersin] of byte;

  Figura: array [1..NumVersin] of _3D;
  FiguraNew: array [1..NumVersin] of _3D;
  EE, DD: _3D;  // DD - точка куда смотрит наблюдатель
                // EE - координаты обозревателя

  BMP: TBitMap;
  angle: Integer = 1;
  i, j: integer;

  T: TArray = ((1,0,0,0),
               (0,1,0,0),
               (0,0,1,0),
               (0,0,0,1));

  Tobr: TArray = ((1,0,0,0),
                  (0,1,0,0),
                  (0,0,1,0),
                  (0,0,0,1));

  D: TArray = ((1,0,0,0),
               (0,1,0,0),
               (0,0,1,0),
               (0,0,0,1));

  E: TArray = ((1,0,0,0),
               (0,1,0,0),
               (0,0,1,0),
               (0,0,0,1));

  Rx: TArray = ((1,0,0,0),
               (0,0,0,0),
               (0,0,0,0),
               (0,0,0,1));

  DTemp: TArray = ((0,0,0,0),
                   (0,0,0,0),
                   (0,0,0,0),
                   (0,0,0,0));

  ETemp: TArray = ((0,0,0,0),
                   (0,0,0,0),
                   (0,0,0,0),
                   (0,0,0,0));

  F: TArray = ((0,0,0,0),
               (0,0,0,0),
               (0,0,0,0),
               (0,0,0,0));

  G: TArray = ((1,0,0,0),
               (0,1,0,0),
               (0,0,1,0),
               (0,0,0,1));

  Q: TArray = ((0,0,0,0),
               (0,0,0,0),
               (0,0,0,0),
               (0,0,0,0));

  SS: TArray = ((1,0,0,0),
                (0,1,0,0),
                (0,0,1,0),
                (0,0,0,1));

  O: TArray = ((0,0,0,0),
               (0,0,0,0),
               (0,0,0,0),
               (0,0,0,0));

  tmp: TArray = ((0,0,0,0),
               (0,0,0,0),
               (0,0,0,0),
               (0,0,0,0));

implementation


{$R *.dfm}


function MixMatrix(A,B:TArray): TArray;
const n=4;
var i,j,k:integer;
    s:real;
begin
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      s:=0;
      for k := 1 to n do
      begin
        s:=s+A[i,k]*B[k,j];
      end;
      Result[i,j]:=s;
    end;
  end;
end;


// процедура поворота на угол alpha
procedure Rotate(alpha:real);
begin
  alpha:=alpha/57;

  Rx[2,2]:=cos(alpha);
  Rx[2,3]:=sin(alpha);
  Rx[3,2]:=-sin(alpha);
  Rx[3,3]:=cos(alpha);
end;


procedure DrLine(x1,y1, x2,y2: Integer; Delta:integer);
begin
  x1:=x1*3;
  y1:=y1*3;
  x2:=x2*3;
  y2:=y2*3;

  BMP.Canvas.MoveTo(x1+Delta,y1+Delta);
  BMP.Canvas.LineTo(x2+Delta,y2+Delta);
end;

// процедура рисования всего изображения
Procedure DrawAll;
begin
  For i:=1 to NumVersin do
    For j:=i to NumVersin do
    begin
      if (tr[i,j]=1)or(tr[j,i]=1) then
          DrLine(FiguraNew[i].x, FiguraNew[i].y, FiguraNew[j].x, FiguraNew[j].y, 500);
    end;

  form1.Image1.Canvas.Draw(0,0,BMP);
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.DoubleBuffered:=True;

  BMP:=TBitMap.Create;
  BMP.Width:=Screen.Width;
  BMP.Height:=Screen.Height;

  Image1.Width:=Screen.Width;
  Image1.Height:=Screen.Height;

  for i := 1 to NumVersin do Figura[i]:=_3D.Create;
  for i := 1 to NumVersin do FiguraNew[i]:=_3D.Create;
  EE:=_3D.Create;
  DD:=_3D.Create;

  // заполняем координаты вершин
  Figura[1].x:=50;
  Figura[1].y:=50;
  Figura[1].z:=100;

  Figura[2].x:=50;
  Figura[2].y:=0;
  Figura[2].z:=50;

  Figura[3].x:=50;
  Figura[3].y:=50;
  Figura[3].z:=0;

  Figura[4].x:=50;
  Figura[4].y:=100;
  Figura[4].z:=50;

  Figura[5].x:=0;
  Figura[5].y:=50;
  Figura[5].z:=50;

  Figura[6].x:=100;
  Figura[6].y:=50;
  Figura[6].z:=50;

  // заполняем матрицу трансцедентности: ребра
  tr[1,2]:=1;
  tr[1,4]:=1;
  tr[1,5]:=1;
  tr[1,6]:=1;
  tr[3,2]:=1;
  tr[3,4]:=1;
  tr[3,5]:=1;
  tr[3,6]:=1;
  tr[2,5]:=1;
  tr[2,6]:=1;
  tr[4,5]:=1;
  tr[4,6]:=1;

  // Координаты наблюдателя
  EE.x := 50;
  EE.y := 15;
  EE.z := 80;

  // Куда смотрит наблюдатель
  DD.x := 0;
  DD.y := 0;
  DD.Z := 0;
end;

procedure TForm1.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  EE.x:=EE.x+5;
  EE.y:=EE.y+5;
  EE.z:=EE.z+5;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var S,R:Real;
begin
  bmp.Canvas.Rectangle(-1, -1, BMP.Width+1, BMP.Height+1);

  DTemp := D;
  DTemp[4,1]:=-DD.x;
  DTemp[4,2]:=-DD.y;
  DTemp[4,3]:=-DD.z;


  R:=sqrt(EE.x*EE.x+EE.y*EE.y);
  ETemp := E;
  ETemp[1,1]:=EE.x/R;
  ETemp[2,1]:=EE.y/R;
  ETemp[1,2]:=-EE.y/R;
  ETemp[2,2]:=EE.x/R;

  S:=sqrt(EE.x*EE.x+EE.y*EE.y+EE.z*EE.z);
  F[1,1]:=-EE.z/s;
  F[1,3]:=-R/s;
  F[2,2]:=1;
  F[3,1]:=R/s;
  F[3,3]:=-EE.z/s;
  F[4,4]:=1;

  G[4,3]:=S;

  Q:=MixMatrix(DTemp, ETemp);
  Q:=MixMatrix(Q,F);
  Q:=MixMatrix(Q,G);

  T[4,1]:=-Figura[3].x;
  T[4,2]:=-Figura[3].y;
  T[4,3]:=-Figura[3].z;

  TObr[4,1]:=Figura[3].x;
  TObr[4,2]:=Figura[3].y;
  TObr[4,3]:=Figura[3].z;

  inc(angle);
  Rotate(angle);

  tmp:=MixMatrix(T, Rx);
  ss:=MixMatrix(tmp, tObr);

  O:=MixMatrix(SS, Q);

  For i:=1 to NumVersin do
  begin
    FiguraNew[i].x := Round(
      Figura[i].x * O[1,1] +
      Figura[i].y * O[2,1] +
      Figura[i].z * O[3,1] +
      O[4,1]);

    FiguraNew[i].y := Round(
      Figura[i].x * O[1,2] +
      Figura[i].y * O[2,2] +
      Figura[i].z * O[3,2] +
      O[4,2]);

    FiguraNew[i].z := Round(
      Figura[i].x * O[1,3] +
      Figura[i].y * O[2,3] +
      Figura[i].z * O[3,3] +
      O[4,3]);
  end;

  DrawAll;

end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then Form1.Close;
end;

end.

