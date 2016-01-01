unit Unalgfloyda;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, Spin, Grids;
  const
  n_some = 8;
  mas : array[1..8] of char = ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h');
type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    StringGrid3: TStringGrid;
    Label1: TLabel;
    btn1: TButton;
    lst1: TListBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  i,j,k,m,c,n:integer;
  W,T,Q:array[1..20,1..20] of integer;
implementation
{$R *.dfm}
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 try
   with StringGrid1 do
   begin
      for i := 1 to StringGrid1.ColCount - 1 do
      begin
      for j := 1 to StringGrid1.RowCount - 1 do
       begin
        if (Cells[i,j]='') and (i<>j) then
         W[i,j]:=999
        else
       W[i,j]:=StrToInt(stringgrid1.cells[i,j]);
       end;
      end;
    for i := 1 to StringGrid1.ColCount - 1 do
    begin
      for j := 1 to StringGrid1.RowCount - 1 do
      begin
       T[i,j]:=W[i,j];
       Q[i,i]:=0;
       if W[i,j]=999 then
        Q[i,j]:=0
       else
        Q[i,j]:=j;
      end;
    end;
    for i := 1 to StringGrid1.ColCount - 1 do
    begin
      for j := 1 to StringGrid1.RowCount - 1 do
      begin
       for k := 1 to StringGrid1.ColCount - 1 do
       begin
        Q[i,i]:=0;
        if (i<>j) and (T[j,i]<>999) and (i<>k) and
        (T[i,k]<>999) and ((T[j,k]=999) or (T[j,k]>T[j,i]+T[i,k]))
        then
        begin
        Q[j,k]:=Q[j,i];
        T[j,k]:=T[j,i]+T[i,k];
        end;
       end;
      end;
        for j := 1 to StringGrid1.RowCount - 1 do
       begin
         if T[j,j]<0 then break;
       end;
    end;
    for j := 1 to StringGrid1.ColCount - 1 do
    begin
       for k := 1 to StringGrid1.RowCount - 1 do
       begin
        stringgrid2.cells[j,k]:=inttostr(T[j,k]);
        stringgrid3.Cells[j,k]:=inttostr(Q[j,k]);
        end;
    end;
   end;
  except
  ShowMessage('ÎÊ ;)');
  end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
for i:=1 to 6 do
    begin
        StringGrid1.Cells[i,0]:=mas[i];
        StringGrid1.Cells[0,i]:=mas[i];
        StringGrid1.Cells[i,i]:='0';
        StringGrid2.Cells[i,0]:=mas[i];
        StringGrid2.Cells[0,i]:=mas[i];
        StringGrid3.Cells[i,0]:=mas[i];
        StringGrid3.Cells[0,i]:=mas[i];
    end;
    StringGrid1.Cells[1,1]:='0';
    StringGrid1.Cells[2,1]:='-2';
    StringGrid1.Cells[3,1]:='3';
    StringGrid1.Cells[4,1]:='-3';
    StringGrid1.Cells[2,2]:='0';
    StringGrid1.Cells[3,2]:='2';
    StringGrid1.Cells[3,3]:='0';
    StringGrid1.Cells[4,3]:='-3';
    StringGrid1.Cells[1,4]:='4';
    StringGrid1.Cells[2,4]:='5';
    StringGrid1.Cells[3,4]:='5';
    StringGrid1.Cells[5,4]:='0';
end;
procedure TForm1.btn1Click(Sender: TObject);
 var i,j,k,m,c,k1:integer;
begin
try 
for m:=1 to StringGrid1.ColCount - 1 do
for c:=1 to StringGrid1.ColCount - 1 do
  begin
     if m<>c then
     begin
       if T[c,m]<>999 then
       begin
       lst1.Items.Add('Øëÿõ ç  '+IntToStr(c)+' ó  '+IntToStr(m)+' : ');
       lst1.Items.Add('---> '+(IntToStr(T[c,m])));
       end
       else
       begin
        lst1.Items.Add(' Íåìàº øëÿõó ì³æ '+IntToStr(c)+' ³ '+IntToStr(m));
        Break;
       end;
     begin
      lst1.Items.Add('Øëÿõ ç '+IntToStr(c)+' ó '+IntToStr(m)+' : ');
      lst1.Items.Add('---> '+IntToStr(c));
      lst1.Items.Add(' ---> '+(IntToStr(Q[c,m])));
         for i:=1 to StringGrid1.ColCount - 1 do
         begin
               if (q[c,m]<>0) and (q[c,k]=0) then
               k:=q[c,m];
               k1:=q[k,m];
               end;
         if (Q[k,m]<>0) and (Q[k1,m]<>0) then
         begin
         lst1.Items.Add(' ---> '+(IntToStr(Q[k,m])));
         lst1.Items.Add(' ---> '+(IntToStr(Q[k1,m])));
         end;
       end;
       end;
     end;
   except
   ShowMessage(';)');
  end;
end;
end.
