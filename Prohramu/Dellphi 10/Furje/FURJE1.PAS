Procedure Furje(Xe,Ye:Vector;Ne:Integer;Var Yg: Vector; Var Ng:Integer;Var c:Vec);
Var a, b : Array[0..40] of Real;
    i, k                 :Integer;
    w, KOM, S, G, D          :Real;
Begin
  TP := bl - al;
  w := 2 * Pi / TP;
  For k := 1 to Ng do
   Begin
    KOM := k * w;
    G := 0;  
    D := 0;
    For i:=1 to Ne do
     Begin
      s := KOM * Xe[i];
      G := G + Ye[i] * Cos (S);
      D := D + Ye[i] * Sin (S)
     End;
     a[k] := 2 * G / Ne;
     b[k] := 2 * D / Ne;
     c[k] := Sqrt(Sqr(a[k])+Sqr(b[k]));
   End;
  a[0] := 0;
  For i := 1 to Ne do
   a[0] := a[0] + Ye[i];
  a[0] := a[0] / Ne;
  For i := 0 to Ne - 1 do
   Begin
    S := 0;
    D := Xe[i] * w;
     For k:=1 to Ng do
      Begin
       KOM := k *d;
       S := S + b[k] * Sin (KOM) + a[k] * Cos (KOM)
      End;
     YG[i] := a[0] + S
   End
End;

