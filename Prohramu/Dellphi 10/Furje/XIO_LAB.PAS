Program XIO_GOL_Prog;
{$M 64000,200000,264000}
 Uses Crt, Graph;
 Type Extended = Real;
 Vector = Array [0..600] of Extended;
 Vec    = Array [0..40]  of Extended;
 Var Xe, Ye, Xg, Yg         : Vector;
 KP, c                         : Vec;
 MaxX,MaxY,MinX,MinY, Kx, Ky, Zx, Zy, Gx, Gy : Extended;
 MaxYg,MinYg, xx, yy                         : Extended;
 al, bl, h, TP, w, ay, bx, Krx, Kry          : Extended;
 Lf                                    : String [48];
 k2                                    : String [23];
 Fv, Fx                                : Text;
 Ne, Ngr, Ng, KL, i, j, KrokX, KrokY, Drv, Drm, L : Integer;
 Txt                                   : String;
 Function f (x : Extended) : Extended;
  Begin
   TP := bl - al ;
   If x < TP / 2 then f := 3 {!!Тўльки для ряду Фур'ї !!}
                 else
    If (x >= TP / 2) and (x < 3 * TP / 4) then
       f := 4 * (TP - 2 * x) / TP         else
       f := 8 *(x - TP) / TP
   {    f:=1/(1+25*x*x);      }
  End;
{$I Furje.pas} {Пўд'їднання процедури Фур'ї}
{$I Garm.pas}
{ $I Spline.pas}
 BEGIN
Writeln ('Bв. к-сть експ. зн. Ne i к-сть точок графўка Ngr');
  Readln (Ne, Ngr);
  Writeln ('Bведiть ознаку KL');
  Writeln ('1- клавiатура');
  Writeln ('2- табуляцiя');
  Writeln ('3- текст. файл');
  Readln (KL);
  Case KL of
1: Begin
   Writeln ('Введiть експер. результати');
   For i := 0 to Ne - 1 do
    Begin
     Write ('Xe[', i, ']='); Read (Xe[i]);
     Write ('Ye[', i, ']='); Read (Ye[i])
    End
   End;
2: Begin
   Writeln ('Введiть промiжок al bl');
   Readln (al, bl);
   H := (bl - al) / (Ne - 1) ;
   Xe[0] := al;
   For i := 0 to Ne - 1 do
    Begin
     Ye[i] := f (Xe[i]);
     Xe[i + 1] := Xe[i] + h
    End
   End;
3: Begin
   Assign (Fv, 'XIO.xy');
   Reset (Fv);
   For i:=0 to Ne - 1 do
    Begin
     Readln (Fv, Lf);
     k2 := Copy (Lf, 0, 23);
     Val (k2, Xe[i], j);
     k2 :=Copy (Lf, 26, 23);
     Val (k2, Ye[i], j)
    End    End   End;
 KL := 0;  al := Xe[0]; bl := Xe [Ne - 1];
 {Spline (Xe,ye,Ne,Ngr,Xg,yg);}
Furje (Xe, Ye, Ne, Yg , Ng, c);   { Виклик процедури Фур'ї }
 Drv := Detect;
 InitGraph (Drv, Drm, 'C:\Bp\Bgi');
 Garm(Ng,C);
 Readln;
 ClearDevice;
 SetBkColor (White);
 L := 60;
 MinX := Xe[0];
 MaxX := Xe[Ne - 1];
 MinYG := Yg[0];
 MaxYg := Yg[0];
 For i:=0 to Ngr - 1 do
  Begin
   If MaxYg < Yg[i] then MaxYg := Yg[i];
   If MinYg > Yg[i] then MinYg := Yg[i];
  End;
 MinY := Ye[0]; Maxy := Ye[0];
 For i := 0 to Ne - 1 do
  Begin
   If MaxY < Ye[i] then MaxY := Ye[i];
   If MinY > Ye[i] then MinY := Ye[i]
  End;
 If MaxY < MaxYg then MaxY := MaxYg;
 If MinY > MinYg then MinY := MinYg;
 Kx := (GetMaxX - 2 * L) / (MaxX - MinX);
 Ky := (GetMaxY - 2 * L) / (MinY-MaxY);
 Zx := (GetMaxX * MinX - L*(MinX + MaxX))/(MinX - MaxX);
 Zy := (GetMaxY * MaxY - L*(MinY + MaxY))/(MaxY - MinY);
 If   MinX * MaxX <= 0  then Gx := 0;
 If ( MinX * MaxX > 0 ) then Gx := MinX;
 If ( MinX * MaxX > 0 ) And ( MinX<0 ) then Gx := MaxX;
 If ( MinY * MaxY <= 0 ) then Gy := 0;
 If ( MinY * MaxY > 0 ) And ( MinY>0 ) then Gy := MinY;
 If ( MinY * MaxY > 0 ) And ( MinY<0 ) then Gy := MaxY;
 ay := Kx * Gx + Zx;  bx := Ky * Gy + Zy;
 SetColor (Red);
 SetLineStyle(0, 2, 3);
 Line (L, Round (bx), Round (GetMaxX - L), Round (bx));
 Line (Round (ay), L, Round (ay), Round (GetMaxY - L));
 SetLineStyle (3, 0, 1);
 SetColor (Green);
 KrokX := ( GetMaxX - 2 * L) Div 10;
 KrokY := ( GetMaxY - 2 * L) Div 10;
 For i:=1 to 9 do
 Begin
  Line (L, L + i * KrokY, GetMaxX - L, L + i * KrokY);
  Line (L + i * KrokX, L, L + i * KrokX, GetMaxY - L );
  Krx := (MaxX - MinX) / 10.0;
  Kry := (MaxY - MinY) / 10.0;
 End;
 xx := MinX;
 yy := MaxY;
 SetTextStyle(2, 0, 5);
 For i:=0 to 10 do
  Begin
  Str (xx:7:2, Txt);
  SetTextJustify (0, CenterText);
  OutTextXY (L-8+i*KrokX, GetMaxY - L Div 2 - 5, Txt);
  SetTextJustify (CenterText, CenterText);
  Str (yy:7:3, Txt);
  OutTextXY (L - 30, L + i * KrokY, Txt);
  xx := xx + KrX;  yy := yy - KrY;
 End;
 SetColor(Blue);
 For i := 0 to Ne - 1 do
  For j := 1 to 2 do
   Circle (Round (Kx*Xe[i]+Zx),Round (Ky*Ye[i]+Zy), j);
 SetColor ( Red );
 SetLineStyle(0,0,3);
 MoveTo(Round (Kx*Xe[0] + Zx),Round(Ky*Yg[0] + Zy));
 For i := 0 to Ngr - 1 do
  LineTo(Round (Kx*Xe[i] + Zx),Round(Ky*Yg[i] + Zy));
 SetColor (Green);
 SetLineStyle (0, 0, 1);
 RectAngle (L, L, GetMaxX - L, GetMaxY - L);
 Repeat Until KeyPressed;
 END.
