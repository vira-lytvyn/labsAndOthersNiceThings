unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, Menus;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    APropos1: TMenuItem;
    APropos2: TMenuItem;
    Image: TImage;
    Label5: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton5: TSpeedButton;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure APropos2Click(Sender: TObject);
    procedure FormCenter;
    private
    Drawing: Boolean;
    Origin, MovePt: TPoint;
    DrawingTool : byte;
    { Private declarations }
    public
    procedure DrawShape(TopLeft, BottomRight: TPoint; AMode: TPenMode);
    
    { Public declarations }
  end;
  
var
  Form1: TForm1;
  
implementation

{$R *.DFM}

uses disktrat, Unit2;

const max = 30;
  
type Vertek = record
    posx,posy : Integer;
  end;
  
  AVertek = Array [1..max] of Vertek;

var count : byte;
  awal,akhir : byte;
  Node : AVertek;
  bool_awal,bool_akhir : Boolean;
  node1,node2 : byte;
  Data : TJarak;
  Closed : TPath;

procedure TForm1.DrawShape(TopLeft, BottomRight: TPoint; AMode: TPenMode);
begin
  with Image.Canvas do
  begin
    Pen.Mode := AMode;
    case DrawingTool of
      2: {LINE}
      begin
        Image.Canvas.MoveTo(TopLeft.X, TopLeft.Y);
        Image.Canvas.LineTo(BottomRight.X, BottomRight.Y);
      end;
    end;
  end;
end;


procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
  if Drawing then
  begin
    DrawShape(Origin, MovePt, pmNotXor);
    MovePt := Point(X, Y);
    DrawShape(Origin, MovePt, pmNotXor);
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Drawingtool := 1;
  Image.Canvas.Pen.Mode := pmcopy;
  
end;

procedure TForm1.ImageMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
var XX,YY,i : byte;
begin
  if Drawing then
  begin
    DrawShape(Origin, MovePt, pmNotXor); //afficher;
    if drawingtool=2 then
    begin
      bool_akhir := False;
      for i := 1 to count do
        if (X>Node[i].posX-10) and (Y>Node[i].posY-10) and (X<Node[i].posX+10) and (Y<Node[i].posY+10) then
      begin
        bool_akhir := True;
        node2 := i;
        break;
      end;
      
      
      if (node1<>0) and (node2<>0) and bool_awal and bool_akhir then
      begin
        DrawShape(Point(Node[node1].posx,Node[node1].posy), Point(Node[node2].posx,Node[node2].posy), pmCopy);
        Data[node1,node2] := round(sqrt(sqr(abs(Node[node2].posy-Node[node1].posy)/9) + sqr(abs(Node[node2].posx-Node[node1].posx)/9)));
        Data[node2,node1] := Data[node1,node2];
        XX := Node[node1].posx;
        YY := Node[node1].posy;
        
        with Image.Canvas do
        begin
          Image.Canvas.Pen.Mode := pmcopy;
          Ellipse(XX-10,YY-10,XX+10,YY+10);
          if node1 div  10 > 0 then
            Textout(xX-7,Yy-6,IntToStr(node1))
          else
            Textout(Xx-3,Yy-6,IntToStr(node1));
        end;
        XX := Node[node2].posx;
        YY := Node[node2].posy;
        
        with Image.Canvas do
        begin
          Image.Canvas.Pen.Mode := pmcopy;
          Ellipse(XX-10,YY-10,XX+10,YY+10);
          if node2 div  10 > 0 then
            Textout(xX-7,Yy-6,IntToStr(node2))
          else
            Textout(Xx-3,Yy-6,IntToStr(node2));
        end;
        
        image.Canvas.TextOut((Node[node1].posx+Node[node2].posx)div 2 ,(Node[node1].posy+Node[node2].posy) div 2,IntToStr(Data[node1,node2]));
        
      end;
    end; //if
    Drawing := False;
    
    if drawingtool=1 then
    begin
      count :=  count + 1;
      with Node[count] do
      begin
        posx := x;
        posy := y;
      end;
      with Image.Canvas do
      begin
        Image.Canvas.Pen.Mode := pmcopy;
        Ellipse(X-10,Y-10,X+10,Y+10);
        if count div  10 > 0 then
          Textout(x-7,y-6,IntToStr(count))
        else
          Textout(x-3,y-6,IntToStr(count));
      end;
      
    end;
  end;
end;

procedure TForm1.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
  if Drawing then
  begin
    DrawShape(Origin, MovePt, pmNotXor);
    MovePt := Point(X, Y);
    DrawShape(Origin, MovePt, pmNotXor);
  end;
end;

procedure TForm1.ImageMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
var i : byte;
begin
  Drawing := True;
  Image.Canvas.MoveTo(X, Y);
  Origin := Point(X, Y);
  MovePt := Origin;
  if drawingtool=2 then
  begin
    bool_awal := False;
    for i := 1 to count do
      if (X>Node[i].posX-10) and (Y>Node[i].posY-10) and (X<Node[i].posX+10) and (Y<Node[i].posY+10) then
    begin
      bool_awal := True;
      node1 := i;
      break;
    end;
    
  end
  else
    
  if drawingtool in [3,4] then
  begin
    for i := 1 to count do
      if (X>Node[i].posX-10) and (Y>Node[i].posY-10) and (X<Node[i].posX+10) and (Y<Node[i].posY+10) then
    begin
      case drawingtool of
        3  : begin
        awal := i;
        edit2.Text := IntToStr(i);
      end;
      4  : begin
      akhir := i;
      edit3.Text := IntToStr(i);
    end;
  end; //case
  break;
end; //if
end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  Drawingtool := 2;
  
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Bitmap: TBitmap;
  xx,yy : byte;
begin
  Form1.Left := Screen.Width  div 2 - Width  div 2;
  Form1.Top  := Screen.Height div 2 - Height div 2;
  DoubleBuffered := True;      
  
  Bitmap := nil;
  try
    Bitmap := TBitmap.Create;
    Bitmap.Width := 350;
    Bitmap.Height := 300;
    Image.Picture.Graphic := Bitmap;
  finally
    Bitmap.Free;
  end;
  Memo1.Clear;
  Drawingtool := 1;
  count := 0;
  awal:= 0;
  akhir := 0;
  edit2.Text := '';
  edit3.Text := '';
  for xx := 1 to max do
    for yy := 1 to max do
  begin
    if xx=yy then
      Data[xx,yy] := 0
    else
      Data[xx,yy] := 999;
  end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  Drawingtool := 3;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Drawingtool := 4;
end;
procedure TForm1.SpeedButton5Click(Sender: TObject);
var i : byte;
  XX,YY : byte;
begin
  memo1.Clear;
  Drawingtool := 2;
  RuteTerpendek(Data,Closed,awal,akhir,count);
  if (awal<>0) and (akhir<>0) and (closed.jarak<>0) and  (closed.jarak<>999)  then
  begin
    Drawing := True;
    edit1.Text := IntToStr(closed.jarak);
    for i := 1 to closed.nodeke-1 do
    begin
      memo1.Text := memo1.Text + IntToStr(closed.arraypath[i]) + '-';
      image.Canvas.Pen.Color := clred;
      DrawShape(Point(Node[closed.arraypath[i]].posx,Node[closed.arraypath[i]].posy), Point(Node[closed.arraypath[i+1]].posx,Node[closed.arraypath[i+1]].posy), pmCopy);
      XX := Node[closed.arraypath[i]].posx;
      YY := Node[closed.arraypath[i]].posy;
      with Image.Canvas do
      begin
        Image.Canvas.Pen.Mode := pmcopy;
        Ellipse(XX-10,YY-10,XX+10,YY+10);
        if node2 div  10 > 0 then
          Textout(xX-7,Yy-6,IntToStr(closed.arraypath[i]))
        else
          Textout(Xx-3,Yy-6,IntToStr(closed.arraypath[i]));
      end;
      
    end;
    XX := Node[closed.arraypath[closed.nodeke]].posx;
    YY := Node[closed.arraypath[closed.nodeke]].posy;
    with Image.Canvas do
    begin
      Image.Canvas.Pen.Mode := pmcopy;
      Ellipse(XX-10,YY-10,XX+10,YY+10);
      if closed.nodeke div  10 > 0 then
        Textout(xX-7,Yy-6,IntToStr(closed.arraypath[closed.nodeke]))
      else
        Textout(Xx-3,Yy-6,IntToStr(closed.arraypath[closed.nodeke]));
    end;
    image.Canvas.Pen.Color := clblack;
    memo1.Text :=  memo1.Text + IntToStr(closed.arraypath[closed.nodeke]);
    Drawing := False;
  end
  else
  begin
    memo1.Text :=  'iln''ya pas de connections';
    edit1.Text :=  '';
  end;
  Drawingtool := 5;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  Drawingtool := 6;
  FormCreate(Sender);
  SpeedButton1Click(Sender);
  edit1.Clear;
end;

procedure TForm1.FormCenter;
begin
  with Form2 do begin
  Left := Screen.Width  div 2 - Width  div 2;
  Top  := Screen.Height div 2 - Height div 2;
  end;
end;

procedure TForm1.APropos2Click(Sender: TObject);
begin
  with Form2 do begin
  Form2 := TForm2.Create(Application);
  { Centre la fiche }
  FormCenter;
  { Application de la fonction : AnimateWindow }
  AnimateWindow(Handle, 250{Vitesse}, AW_CENTER);
  Show;
  end;
end;
end.
