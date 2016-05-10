Program Lagrang;
Uses Crt;
Const N=15;
Type Vect = array [0..N] of Real;
Var i,j,k:Integer;
    xf, yf,xfs,yfs: text;
    y,x,dy:Vect;
    am,bm,S,df,xl:Real;

BEGIN
        clrscr;
        writeln('vvedit meji a,b');
        readln(am,bm);
        x[0]:=am;
        x[N]:=bm;
        dx:=(x[N]-x[0])/N;

        assign(xf,'F:\Chis_M~1\CML\x.txt');
        assign(yf,'F:\Chis_M~1\CML\y.txt');
        rewrite(xf);
        rewrite(yf);

        for i:=0 to N do
        begin
                y[i]:=sin(3*x[i])+2*x[i]-4*cos(x[i]);
                x[i+1]:=x[i]+dx;
                writeln (xf,x[i]);
                writeln (yf,y[i]);
        end;

        close(xf);
        close(yf);


        for i:=0 to N do
        begin
                df:=y[i];
                for j:=0 to N do
                begin
                        if j<>i then
                        df:=df/(x[i]-x[j]);
                end;
                dy[i]:=df;
        end;

        S:=0;
        for i:=1 to N do
        begin
                df:=dy[i];
                for j:=1 to N do
                begin
                        if i<>j then
                        fd:=df*(xl-x[j]);
                end;
                S:=S+df;
        end;



END.
