unit MForm;

interface

uses
  Dialogs, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, ComCtrls, Grids, ValEdit,
  class_node, class_interpolator, Menus, XPMan;
                   
type
  TForm1 = class(TForm)
    Splitter1: TSplitter;
    PaintBox1: TPaintBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure NodeViewValidate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: String);
    procedure CheckBox3Click(Sender: TObject);
  private
    Nodes : array of TNode;  //Input nodes
    procedure DrawPlot;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation

uses Math;

{$R *.dfm}

function f(x : Real):Real;
var y : Real;
begin
    y := ( 1 / x ) - ( 1 / ( ln( x ) ) );
end;

{function tabul (a, b, h : Real ) : Real;
var  i, N: Integer;
begin
   N := Ceil(abs( b - a ) / h);
   Nodes[0].X := a ;
   for i := 0 to N - 1 do
   begin
   // while (Nodes[i].X <= b) do
  //  begin
      Nodes[ i ].Y := F (Nodes[ i ].X);
      Nodes[i + 1].X := Nodes[i].X + h;
     // N := N + 1;
   // end;
 //   Continue;
   end;
end; }

procedure TForm1.Button3Click(Sender: TObject);
var i:integer;
    a_b, b_b, h_z : Extended;
begin
    a_b := StrToFloat(Edit1.Text);
    b_b := StrToFloat(Edit2.Text);
    h_z := StrToFloat(Edit3.Text);
    //tabul(a_b, b_b, h_z);
 //   N := Ceil(abs( b_b - a_b ) / h_z);
    for i:=1 to N do   //Check input data
    begin
      SetLength(Nodes, i);
    end;
    Nodes[0].X := a_b ;
    for i := 0 to N-1 do
    begin
   // while (Nodes[i].X <= b) do
  //  begin
      Nodes[ i ].Y := F (Nodes[ i ].X);
      Nodes[i + 1].X := Nodes[i].X + h_z;
     // N := N + 1;
   // end;
 //   Continue;
    end;
  
  TInterpolator.Interpolate(Nodes); //Interpolate
  DrawPlot;    //Draw plot
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  PaintBox1Paint(self);
end;

procedure TForm1.DrawPlot;
var i:integer;
    zerox, zeroy : integer;
    kx, ky, maxx, maxy, maxmx, maxmy, t, tp : extended;
begin
  maxx:=Nodes[0].X;
  maxy:=Nodes[0].Y;
  maxmx:=Nodes[0].X;
  maxmy:=Nodes[0].Y;

  for i:=1 to Length(Nodes)-1 do
    begin
      if Nodes[i].X > maxx then
        maxx := Nodes[i].X;
      if Nodes[i].X < maxmx then
        maxmx := Nodes[i].X;

      if Nodes[i].Y > maxy then
        maxy := Nodes[i].Y;
      if Nodes[i].Y < maxmy then
        maxmy := Nodes[i].Y;
    end;

  with PaintBox1 do
    begin

      if maxmx>=0 then
        kx := abs(maxx)/(Width - 10)
      else
        if maxx<0 then
          kx := abs(maxmx)/(Width - 10)
        else
          kx := (abs(maxx) + abs(maxmx))/(Width - 10);

      if maxmy>=0 then
        ky := abs(maxy)/(Height - 20)
      else
        if maxy<0 then
          ky := abs(maxmy)/(Height - 20)
        else
          ky := (abs(maxy) + abs(maxmy))/(Height - 20);

      if maxmx >= 0 then
        zerox := 5
      else
        if maxx <0 then
          zerox := Width - 5
        else
          zerox := 4 + Round(Abs(maxmx)/kx);

      if maxmy >= 0 then
        zeroy := Height - 5
      else
        if maxy <0 then
          zeroy := 5
        else
          zeroy := Height - 5 - Round(Abs(maxmy)/ky);

      Canvas.Brush.Color := Color;
      Canvas.FillRect(ClientRect);
      Canvas.Pen.Color:=clBlack;
      Canvas.MoveTo(zerox, 5);
      Canvas.LineTo(zerox, Height - 5);
      Canvas.MoveTo(5, zeroy);
      Canvas.LineTo(Width - 5, zeroy);

      if (ky>0)and(kx>0) then
        begin
          Canvas.Pen.Color:=clRed;
          t := TInterpolator.Spline(maxmx);
          tp := t;
          for i:= 5 to Width - 7 do
            try
              Canvas.MoveTo(i, zeroy - Round(tp/ky));
              tp := t;
              if ((i - zerox + 4)*kx)<=maxx then
                begin
                  t:=TInterpolator.Spline((i - zerox + 4)*kx);
                  Canvas.LineTo(i+1, zeroy - Round(t/ky));
                end;
            except
              on Exception do;
            end;
        end;

      Canvas.Pen.Color:=clBlue;
      for i:=0 to Length(Nodes)-1 do
        begin
          if CheckBox2.Checked then
            begin
              Canvas.Pen.Style := psDot;
              Canvas.MoveTo(Round(Nodes[i].X/kx) + zerox - 3, zeroy-3);
              Canvas.LineTo(Round(Nodes[i].X/kx) + zerox - 3, zeroy - Round(Nodes[i].Y/ky)-3);
              Canvas.LineTo(zerox - 3, zeroy - Round(Nodes[i].Y/ky)-3);
            end;
          if CheckBox3.Checked then
            begin
              if ((maxmy/ky>0) or (maxy/ky<13)) then
                Canvas.TextOut(Round(Nodes[i].X/kx) + zerox - 3, zeroy+10, FloatToStrF(Nodes[i].X, ffFixed, 18, 2))
              else
                Canvas.TextOut(Round(Nodes[i].X/kx) + zerox - 3, zeroy-13, FloatToStrF(Nodes[i].X, ffFixed, 18, 2));
              if ((maxmx/kx>=0) or (maxmx/kx>-25)) then
                Canvas.TextOut(zerox + 5, zeroy - Round(Nodes[i].Y/ky), FloatToStrF(Nodes[i].Y, ffFixed, 18, 2))
              else
                Canvas.TextOut(zerox - 30, zeroy - Round(Nodes[i].Y/ky), FloatToStrF(Nodes[i].Y, ffFixed, 18, 2));
            end;
          Canvas.Pen.Style := psSolid;
          if CheckBox1.Checked then
            Canvas.Ellipse(Round(Nodes[i].X/kx) + zerox - 3, zeroy - Round(Nodes[i].Y/ky)-3, Round(Nodes[i].X/kx) + zerox + 3, zeroy - Round(Nodes[i].Y/ky)+3);
        end;

    end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  if TInterpolator.IsDone then  //Draw plot only if it is ready
    DrawPlot;
end;

procedure TForm1.NodeViewValidate(Sender: TObject; ACol, ARow: Integer;
  const KeyName, KeyValue: String);
var d:extended;
begin
  if not (TryStrToFloat(KeyName, d) and TryStrToFloat(KeyValue, d)) then
    begin
      Raise(Exception.Create('Invalid floating point value!'));
    end;
end;

end.
