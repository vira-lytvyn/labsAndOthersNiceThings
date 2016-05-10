unit MForm;

interface

uses
  Dialogs, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, ComCtrls, Grids, ValEdit,
  class_node, class_interpolator, Menus, XPMan;
                   
type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PaintBox1: TPaintBox;
    NodeView: TValueListEditor;
    Panel4: TPanel;
    Button2: TButton;
    Button3: TButton;
    Splitter1: TSplitter;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Save1: TMenuItem;
    Load1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Button1: TButton;
    XPManifest1: TXPManifest;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
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

{$R *.dfm}
function f(x : Extended):Extended;
var y : Extended;
begin
    y := ( 1 / x ) - ( 1 / ( ln( x ) ) );
end;

//Add a node
procedure TForm1.Button1Click(Sender: TObject);
var i, d:integer;
begin
  i:=0;
  while NodeView.FindRow(IntToStr(i), d) do
    inc(i);
  NodeView.InsertRow(IntToStr(i), '0', true);
end;

//Delete a node
procedure TForm1.Button2Click(Sender: TObject);
begin
  if NodeView.Selection.Top >0 then
    NodeView.DeleteRow(NodeView.Selection.Top);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Panel2.Width:= Panel1.Width - 150;
  NodeView.ColWidths[0]:=(NodeView.Width div 2) - 7;
  NodeView.ColWidths[1]:=NodeView.ColWidths[0] - 7;
end;

procedure TForm1.Button3Click(Sender: TObject);
var i, j:integer;
    a_b, b_b, h_z : Extended;
begin
    a_b := StrToFloat(Edit1.Text);
    b_b := StrToFloat(Edit2.Text);
    h_z := StrToFloat(Edit3.Text);
    j := 1;
  while a_b<=b_b do
     begin
          Nodes[i].Y := f(a_b);
          NodeView.Cells[0,i-1] := FloattoStr(Nodes[i].Y);
          a_b:=a_b+h_z;
          j:=j+1;
         //NodeView.RowCount := j;
     end;
  for i:=1 to NodeView.RowCount - 1 do   //Check input data
    begin
      SetLength(Nodes, i);
      if TryStrToFloat(NodeView.Cells[0, i], Nodes[i-1].X) then
       if not TryStrToFloat(NodeView.Cells[1, i], Nodes[i-1].Y) then
        Raise Exception.Create('Invalid data at row ' + IntToStr(i) + '!')
       else
      else
        Raise Exception.Create('Invalid data at row ' + IntToStr(i) + '!');
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

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  NodeView.Strings.SaveToFile(ExtractFilePath(Paramstr(0))+Dialogs.InputBox('Save File', 'Enter Filename:', 'Untitled.dat'));
end;

procedure TForm1.Load1Click(Sender: TObject);
begin
  NodeView.Strings.LoadFromFile(ExtractFilePath(Paramstr(0))+Dialogs.InputBox('Load File', 'Enter Filename:', 'Untitled.dat'));
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
