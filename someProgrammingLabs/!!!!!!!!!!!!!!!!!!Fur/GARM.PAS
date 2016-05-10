Procedure Garm(Ng:Integer; c:Vec);
    Var i , Krokx, x, y :Integer;
    Max, Ky:Real;
    Txt:String[20];
Begin
Krokx :=600 div Ng;
Max:=c[1];
For i := 2 to Ng do
If c[i] > Max then Max:=c[i];
Ky := 300/max;
SetBkColor(Yellow);
SetColor (Brown);
Line (20, 400, 620, 400);
Line (20, 20, 20, 400);
SetColor (Blue);
OutTextXY (23,20 ,'C');
OutTextXY (625, 395 ,'W');
SetLineStyle(0,0,3);
 x:=KrokX+20;
SetTextJustify(1,1);
For i:= 1 to ng do
Begin
Line (x, 400, x, 400 - Round(ky*c[i]));
Str(c[i]:5:2,Txt);
OutTextXY(x,395 - Round(ky*c[i]),Txt);
Circle(x,400,2);
x:=x+KrokX;
end;

OutTextXY(450, 450, 'Press Any Key');
End;
