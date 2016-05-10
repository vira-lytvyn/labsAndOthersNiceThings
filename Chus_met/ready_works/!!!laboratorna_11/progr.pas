Program Lab12;
Uses CRT;

type vector = array [0..3] of double;

var
  A, B, C               :vector;
  XK, XK_res               :double;
  IterMax               :integer;
  i,j,k,m               :integer;
  inputFile             :text;
  eps                   :double;
  alpha, alpha_res         :double;
  beta, beta_res           :double;
  p,q, p1, q1           :double;

function func(xf :double):double;
var j, k : integer;
	mlt, sum : double;
Begin
	sum := 0;
	for j := 0 to m - 1 do
	begin
		mlt := 1;
		for k := 1 to j do
			mlt := mlt * xf;
		sum := a[j] * mlt;
	end;
	func := sum;
End;

BEGIN
  clrscr;
  
  assign(inputFile, 'input.txt');
  reset(inputFile);
  readln(inputFile, eps);
  readln(inputFile, XK);
  readln(inputFile, alpha);
  readln(inputFile, beta);
  readln(inputFile, m);
  for i := 0 to m - 1 do 
	readln(inputFile, a[i]);

  XK := -a[3] / a[2];
  Writeln('   XK = ', XK);
  IterMax := 300;
  i := 0;
  m := 3;
  eps := 1E-8;
  while (i < IterMax) do
    Begin
      B[m] := A[m];
      for j := m - 1 downto 0 do
        B[j] := A[j] + XK * B[j+1];

      C[m] := B[m];
      for j := m - 1 downto 1 do
        C[j] := B[j] + XK * C[j + 1];

      XK_res:= XK - B[0] / C[1];

      if (abs(XK_res-XK)<eps) then
        Break
      else
        Begin
          XK := XK_res;
          i := i + 1;
        End;

    End;

  Writeln('    X= ', XK_res);
  Writeln('iter= ', i);

  i := 0;
  for i:=0 to m do
    Begin
      B[i]:=0;
      C[i]:=0;
    End;
  while (i <IterMax) do
    Begin
      p :=  2 * alpha;
      q := alpha * alpha + beta * beta;
      B[m] := A[m];
      B[m - 1] := A[m - 1] - p * B[m];
      for i := m - 2  downto 2 do
        B[i] := A[i] - p * B[i+1] - q * B[i + 2];

      q1 := A[0] / B[2];
      p1 :=(A[1] * B[2] - A[0] * B[3]) / (B[2] * B[2]);
      alpha_res := p1 / 2;
      beta_res := sqrt(abs(alpha_res * alpha_res - q1));
      if ((abs(alpha_res - alpha) < eps) and (abs(beta_res - beta) < eps)) then
        break
      else
        Begin
          i := i + 1;
          alpha := alpha_res;
          beta := beta_res;
        End;
    End;

    Writeln(' ');
    Writeln('Imaginary roots');
    Writeln('   ',-alpha_res, ' + i*(', beta_res,')');
    Writeln('   ',-alpha_res, ' + i*(', -beta_res,')');
    Writeln('IterNum = ', i);
    
  close(inputFile);
  readln;
END.
