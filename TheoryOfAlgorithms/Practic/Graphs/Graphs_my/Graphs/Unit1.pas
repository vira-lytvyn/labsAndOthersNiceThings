unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, Grids, IdBaseComponent,
  IdAntiFreezeBase, IdAntiFreeze;

type
  TForm1 = class(TForm)
    XPManifest1: TXPManifest;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Button3: TButton;
    StringGrid2: TStringGrid;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button5: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
  //  procedure Button1Click(Sender: TObject);
//    procedure Button2Click(Sender: TObject);
//    procedure Button3Click(Sender: TObject);
//    procedure Button5Click(Sender: TObject);
//    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{


 matrix,v: array [0..100,0..100] of integer;
  coordX,coordY,lineX1,lineY1,lineX2,lineY2,queue,queue1,used,down: array [0..100] of integer;
  size,start,pointer : integer;
  i,j,k,lineCount : integer;
  matrixInc : array [0..100,0..100] of integer;//Матриця інцидентності
  vertex,lines:integer;//Кількість вершин і ребер
  visited: array [0..100] of boolean;
  count,finish:integer;


procedure dfs(v: integer);  // відображає проходження
var
  i: integer;
begin
  visited[v] := true;
  for i := 0 to size-1 do
    if (matrix[v, i]>=1) and (not visited[i]) then
    begin
      queue1[count] := i;
      count:= count + 1;
      dfs(i);
    end;
end;

procedure convertMatrix();   //Перетворення матриці інцидентності в матрицю суміжностей
var temp:integer;
begin
  temp := -1;
  for i := 0 to (lines-1) do
    for j := 0 to (vertex-1) do
    begin
      if(matrixInc[j,i] = 1) and (temp = -1) then
      begin
        temp:=j;
        Continue;
      end;
      if(matrixInc[j,i] = 1) and (temp <> -1) then
      begin
        matrix[j,temp]:=1;
        matrix[temp,j]:=1;
        temp:=-1;
      end;
    end;
    size:=vertex;
end;

procedure convertSumToInc();  // Перетворення матриці суміжностей в матрицю інцедентності
begin
  vertex:=size;
  lines:=0;
  for i:=0 to size-1 do
    for j:=i+1 to size-1 do
    begin
      if(matrix[i,j]>=1) then
      begin
        matrixInc[i,lines]:=1;
        matrixInc[j,lines]:=1;
        lines:=lines+1;
      end;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);  // заповнює матрицю суміжності
begin
  size := StrToInt(Edit1.Text);
  StringGrid1.ColCount:=size;
  StringGrid1.RowCount:=size;
  for i := 0 to size-1 do
    for j := 0 to size-1 do
    begin
      StringGrid1.Cells[i,j] := '0';
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);  // здійснює обхід вширину
begin
  pointer := 1;
  queue[0] := 1;
  for i := 0 to size-1 do
    for j := 0 to size-1 do
    begin
      v[i,j] := matrix[i,j];
    end;
    for i := 0 to size-1 do
      for j := 0 to size-1 do
      begin
        if(v[queue[i]-1][j]>=1) then
        begin
                queue[pointer] := j+1;
                v[queue[i]-1][j]:=-1;
                v[j][queue[i]-1]:=-1;
                pointer := pointer + 1;
        end;
      end;
    Label2.Caption:='';
    for i := 0 to size-1 do
       Label2.Caption := Label2.Caption + IntToStr(queue[i])+' ';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  for i := 0 to size-1 do
    for j := 0 to size-1 do
    begin
      v[i,j] := matrix[i,j];
    end;
    queue1[0]:=0;
    count := 1;
    dfs(0);
    Label2.Caption := '';
    for i := 0 to size-1 do
      Label2.Caption := Label2.Caption + IntToStr(queue1[i]+1)+' ';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  StringGrid2.ColCount:=StrToInt(Edit2.Text);
  StringGrid2.RowCount:=StrToInt(Edit3.Text);
  lines:=StrToInt(Edit2.Text);
  vertex:=StrToInt(Edit3.Text);
  size:=vertex;
  for i := 0 to lines-1 do
    for j := 0 to vertex-1 do
    begin
      StringGrid2.Cells[i,j] := '0';
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   for i := 0 to (StringGrid2.ColCount-1) do
    for j := 0 to (StringGrid2.RowCount-1) do
    begin
      matrixInc[j,i] := StrToInt (StringGrid2.Cells[i,j]);
    end;
  convertMatrix;
  Edit1.Text:= IntToStr(size);
  for i := 0 to (size-1) do
    for j := 0 to (size-1) do
    begin
      StringGrid1.Cells[i,j] := IntToStr(matrix[i,j]);
    end;
  StringGrid1.ColCount:=size;
  StringGrid1.RowCount:=size;
  end;
          }
end.


