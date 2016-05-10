Program Slogplot;
Uses Crt,Graph,Dos,Printer;

Const	Convert	=	(3.1415926536*2)/360 ;

Var	Particles	:	LongInt;
	Held		:	Integer;
	Old_Held	:	Integer;
	Textline	:	String;
	Blanker	:	Pointer;
	Time_Start	:	LongInt;
	Time_Last   :	LongInt;
	Time_Work	:	LongInt;
	Time_Total	:	LongInt;
	Old_Hour	:	Integer;
	MaxX		:	Integer;
	MaxY		:	Integer;
      Plotter     :     Char;

Function secs : LongInt;
Var Hour,Min,Sec,Sec100 : Word;
	Work	: Longint;
Begin
	Gettime( Hour, Min , Sec , Sec100 );
	If ( Old_Hour = -1 ) then Old_Hour := Hour ;
	If ( Hour < Old_Hour ) Then Hour := Hour + 24 ;

	Work := Hour * 60 * 60 + Min * 60 + sec ;
	secs := Work;
End;

Procedure Start_graphics;
Var	Graphmode , Graphdriver : integer;
	Error				: Boolean;
Begin
     Graphdriver := detect;
     Graphmode := 0;

     Initgraph( Graphdriver , Graphmode , '' );
     Error := ( Graphresult <> 0 );
     If (Error) then Halt(1);
     MaxX := GetMaxX;
     MaxY := GetMaxY;
end;

Procedure End_graphics;
Begin
     Closegraph;
End;

Procedure Init_Plotter;
Begin
	Writeln(Lst,'RE;');
	Writeln(Lst,'HO;');
End;

Procedure Plot_Line(X1,Y1,X2,Y2:Word);
Var	Plotline	:	String;
	Work		:	String;
Begin
	Plotline := 'LN ';
	Str(X1,Work);
	Plotline := Plotline + Work + ',';
	Str(Y1,Work);
	Plotline := Plotline + Work + ',';
	Str(X2,Work);
	Plotline := Plotline + Work + ',';
	Str(Y2,Work);
	Plotline := Plotline + Work + ';';
	Writeln(lst,Plotline);
End;

(* Draw a box in the are of (-100,-100) - (100,100) *)
Procedure Plot_Point(X,Y:Integer);
Var	X1,Y1,X2,Y2	:	Word;
Begin
	X := X * 9 + 1250 ;
	Y := Y * 9 + 919 ;

	X1 := X - 4 ;
	X2 := X + 4 ;
	Y1 := Y - 4 ;
	Y2 := Y + 4 ;
	Plot_Line(X1,Y1,X2,Y1);
	Plot_Line(X2,Y1,X2,Y2);
	Plot_Line(X2,Y2,X1,Y2);
	Plot_Line(X1,Y2,X1,Y1);
End;

Procedure Do_Particle;
Var	X,Y	:	Integer;
	X1,Y1	:	Integer;
	Angle	:     Real;
	Done	:	Word;
Begin
	Angle := Random(360);
      Angle := Angle*Convert;
	X := Trunc(Sin(Angle)*100);
	Y := Trunc(Cos(Angle)*100);
	X1 := X + 150 ;
	Y1 := Y + 150 ;
	done := 0 ;
	While  (     (GetPixel(X1-1,Y1-1)=0)
		   and (GetPixel(X1,Y1-1)=0)
		   and (GetPixel(X1+1,Y1-1)=0)
		   and (GetPixel(X1-1,Y1)=0)
		   and (GetPixel(X1+1,Y1)=0)
		   and (GetPixel(X1-1,Y1+1)=0)
		   and (GetPixel(X1,Y1+1)=0)
		   and (GetPixel(X1+1,Y1+1)=0)
		   and ( done = 0 )) do
	Begin
		PutPixel(X1,Y1,0);
		Case Random(4) of
			0 :	X := X + 1 ;
			1 :	Y := Y + 1 ;
			2 :	X := X - 1 ;
			3 :	Y := Y - 1 ;
		End;
            X1 := X + 150 ;
	      Y1 := Y + 150 ;
		If (Sqr(X)+Sqr(Y)>10000) then done := 1
		else PutPixel(X1,Y1,1);
	End;
	If (done=0) then
	Begin
		Held := Held + 1 ;
		If Plotter='Y' then
			Plot_Point(X,Y);
	End;
	Particles := Particles + 1;
End;

Procedure InfoLine;
Begin
	Moveto(0,0);
	PutImage(0,0,Blanker^,CopyPut);
	OutText('Part:');
	Str((Particles+1):6,Textline);
	OutText(Textline);
      OutText('  Held:');
      Str(Held:6,Textline);
      OutText(Textline);
	OutText('  Time:');
	Str((Time_Work-Time_Last):6,TextLine);
	OutText(TextLine);
	OutText('  Average Time:');
	If (Held = 0 ) then
		Textline := '    0.00'
	else
		Str(((Time_Work-Time_Start) / Held) :7:2,TextLine);
	OutText(TextLine);
	OutText('  Total Time:');
	Str((Time_Work-Time_Start):8,TextLine);
	OutText(TextLine);
End;

Begin
	ClrScr;
	Writeln('                       Slo-Gro Fractal Generator');
	Writeln('                           -+- Devin Cook -+-');
	Writeln;
	Plotter := ' ';
	While(NOT(Plotter In ['Y','N'])) do
	Begin
		Write('Plotter (Y/N)');
		Readln(Plotter);
		If Plotter='y' then Plotter := 'Y';
		If Plotter='n' then Plotter := 'N';
	End;
	If Plotter = 'Y' then Init_Plotter;
	Randomize;
	Old_Hour := -1 ;
	NoSound;
	Start_Graphics;
	GetMem( Blanker , ImageSize(0,0,MaxX,8));
	GetImage( 0,0,MaxX,8,Blanker^);
	PutPixel(150,150,1);
	If (Plotter='Y') then Plot_Point(0,0);
	Particles := 0 ;
	Held := 0 ;
      Old_Held := - 1;
	Time_Start := secs;
	Time_Last := Time_Start;
	Time_Work := Time_Last;
	Time_Total := 0 ;
	Repeat
		If (Held<>Old_Held) then InfoLine;
            Old_Held := Held;
		Time_Last := Time_Work;
		Do_Particle;
		Time_Work := secs;
	until (Keypressed);
	End_Graphics;
End.