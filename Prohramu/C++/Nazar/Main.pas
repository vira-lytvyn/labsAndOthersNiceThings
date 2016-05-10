unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, XPMan, StdCtrls, Buttons;

type matr=array[0..4,0..4] of Integer;
     matrs=array[1..3,1..3] of String;
var num : matr;
    s0 : string = '123456780';
    s1:string ;
    pole : matr=
    (
    (9,9,9,9,9),
    (9,8,1,3,9),
    (9,7,5,4,9),
    (9,6,2,0,9),
    (9,9,9,9,9)
    );
    pole0 : matr=
    (
    (9,9,9,9,9),
    (9,8,1,3,9),
    (9,7,5,4,9),
    (9,6,2,0,9),
    (9,9,9,9,9)
    );
    polex : matr=
    (
    (9,9,9,9,9),
    (9,1,2,3,9),
    (9,4,5,6,9),
    (9,7,0,8,9),
    (9,9,9,9,9)
    );

    posx : matr=
    (
    (9,9,9,9,9),
    (9,1,107,213,9),
    (9,1,107,213,9),
    (9,1,107,213,9),
    (9,9,9,9,9)
    );
    posy : matr=
    (
    (9,9,9,9,9),
    (9,1,1,1,9),
    (9,107,107,107,9),
    (9,213,213,213,9),
    (9,9,9,9,9)
    );
    pos : matrs=
    (
    //('','','','',''),
    ('11','1071','2131'),
    ('1107','107107','213107'),
    ('1213','107213','213213')
    //('','','','','')
    );
    {pos : matrs=
    (
    //('','','','',''),
    ('11','1107','1213'),
    ('1071','107107','107213'),
    ('2131','213107','213213')
    //('','','','','')
    );}

type
  TForm1 = class(TForm)
    pnl1: TPanel;
    b2: TImage;
    b3: TImage;
    b4: TImage;
    b5: TImage;
    b6: TImage;
    b7: TImage;
    b8: TImage;
    b1: TImage;
    ng: TBitBtn;
    exit: TBitBtn;
    Image1: TImage;
    procedure exitClick(Sender: TObject);
    procedure b8Click(Sender: TObject);
    procedure b6Click(Sender: TObject);
    procedure b1Click(Sender: TObject);
    procedure b2Click(Sender: TObject);
    procedure b3Click(Sender: TObject);
    procedure b4Click(Sender: TObject);
    procedure b5Click(Sender: TObject);
    procedure b7Click(Sender: TObject);
    procedure ngClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Congr;

{$R *.dfm}

procedure TForm1.exitClick(Sender: TObject);
begin
    close
end;


procedure TForm1.b1Click(Sender: TObject);
var i,ii ,j, jj : integer ;
begin
    for i := 1 to 3 do
    for j := 1 to 3 do
    if pos[i,j] = IntToStr(b1.Left)+IntToStr(b1.Top) then
    begin
        jj := j;
        ii:= i;
        //ShowMessage(pos[ii,jj]);
    end;
    {ShowMessage(IntToStr(ii));
    ShowMessage(IntToStr(jj));
    ShowMessage(pos[ii,jj]);}
    if pole[ii,jj+1] = 0 then
    begin
        pole[ii,jj+1] := 1;
        pole[ii,jj] := 0;
        b1.Left := posx[ii,jj+1];
        b1.Top := posy[ii,jj+1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii,jj-1] = 0 then
    begin
        pole[ii,jj-1] := 1;
        pole[ii,jj] := 0;
        b1.Left := posx[ii,jj-1];
        b1.Top := posy[ii,jj-1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii+1,jj] = 0 then
    begin
        pole[ii+1,jj] := 1;
        pole[ii,jj] := 0;
        b1.Left := posx[ii+1,jj];
        b1.Top := posy[ii+1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii-1,jj] = 0 then
    begin
        pole[ii-1,jj] := 1;
        pole[ii,jj] := 0;
        b1.Left := posx[ii-1,jj];
        b1.Top := posy[ii-1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end;
    s1 := '';
    for i := 1 to 3 do
    for j := 1 to 3 do
        s1 :=  s1 + IntToStr(pole[i,j]);
    if s1 = s0 then ShowMessage('Вітаю!!!');
end;

procedure TForm1.b2Click(Sender: TObject);
var i,ii ,j, jj : integer ;
begin
    for i := 1 to 3 do
    for j := 1 to 3 do
    if pos[i,j] = IntToStr(b2.Left)+IntToStr(b2.Top) then
    begin
        jj := j;
        ii:= i;
        //ShowMessage(pos[ii,jj]);
    end;
    {ShowMessage(IntToStr(ii));
    ShowMessage(IntToStr(jj));
    ShowMessage(pos[ii,jj]);}
    if pole[ii,jj+1] = 0 then
    begin
        pole[ii,jj+1] := 2;
        pole[ii,jj] := 0;
        b2.Left := posx[ii,jj+1];
        b2.Top := posy[ii,jj+1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii,jj-1] = 0 then
    begin
        pole[ii,jj-1] := 2;
        pole[ii,jj] := 0;
        b2.Left := posx[ii,jj-1];
        b2.Top := posy[ii,jj-1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii+1,jj] = 0 then
    begin
        pole[ii+1,jj] := 2;
        pole[ii,jj] := 0;
        b2.Left := posx[ii+1,jj];
        b2.Top := posy[ii+1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii-1,jj] = 0 then
    begin
        pole[ii-1,jj] := 2;
        pole[ii,jj] := 0;
        b2.Left := posx[ii-1,jj];
        b2.Top := posy[ii-1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end;
    s1 := '';
    for i := 1 to 3 do
    for j := 1 to 3 do
        s1 :=  s1 + IntToStr(pole[i,j]);
    if s1 = s0 then ShowMessage('Вітаю!!!');

end;

procedure TForm1.b3Click(Sender: TObject);
var i,ii ,j, jj : integer ;
begin
    for i := 1 to 3 do
    for j := 1 to 3 do
    if pos[i,j] = IntToStr(b3.Left)+IntToStr(b3.Top) then
    begin
        jj := j;
        ii:= i;
        //ShowMessage(pos[ii,jj]);
    end;
    {ShowMessage(IntToStr(ii));
    ShowMessage(IntToStr(jj));
    ShowMessage(pos[ii,jj]);}
    if pole[ii,jj+1] = 0 then
    begin
        pole[ii,jj+1] := 3;
        pole[ii,jj] := 0;
        b3.Left := posx[ii,jj+1];
        b3.Top := posy[ii,jj+1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii,jj-1] = 0 then
    begin
        pole[ii,jj-1] := 3;
        pole[ii,jj] := 0;
        b3.Left := posx[ii,jj-1];
        b3.Top := posy[ii,jj-1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii+1,jj] = 0 then
    begin
        pole[ii+1,jj] := 3;
        pole[ii,jj] := 0;
        b3.Left := posx[ii+1,jj];
        b3.Top := posy[ii+1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii-1,jj] = 0 then
    begin
        pole[ii-1,jj] := 3;
        pole[ii,jj] := 0;
        b3.Left := posx[ii-1,jj];
        b3.Top := posy[ii-1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end;
    s1 := '';
    for i := 1 to 3 do
    for j := 1 to 3 do
        s1 :=  s1 + IntToStr(pole[i,j]);
    if s1 = s0 then ShowMessage('Вітаю!!!');

end;

procedure TForm1.b4Click(Sender: TObject);
var i,ii ,j, jj : integer ;
begin
    for i := 1 to 3 do
    for j := 1 to 3 do
    if pos[i,j] = IntToStr(b4.Left)+IntToStr(b4.Top) then
    begin
        jj := j;
        ii:= i;
        //ShowMessage(pos[ii,jj]);
    end;
    {ShowMessage(IntToStr(ii));
    ShowMessage(IntToStr(jj));
    ShowMessage(pos[ii,jj]);}
    if pole[ii,jj+1] = 0 then
    begin
        pole[ii,jj+1] := 4;
        pole[ii,jj] := 0;
        b4.Left := posx[ii,jj+1];
        b4.Top := posy[ii,jj+1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii,jj-1] = 0 then
    begin
        pole[ii,jj-1] := 4;
        pole[ii,jj] := 0;
        b4.Left := posx[ii,jj-1];
        b4.Top := posy[ii,jj-1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii+1,jj] = 0 then
    begin
        pole[ii+1,jj] := 4;
        pole[ii,jj] := 0;
        b4.Left := posx[ii+1,jj];
        b4.Top := posy[ii+1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii-1,jj] = 0 then
    begin
        pole[ii-1,jj] := 4;
        pole[ii,jj] := 0;
        b4.Left := posx[ii-1,jj];
        b4.Top := posy[ii-1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end;
    s1 := '';
    for i := 1 to 3 do
    for j := 1 to 3 do
        s1 :=  s1 + IntToStr(pole[i,j]);
    if s1 = s0 then ShowMessage('Вітаю!!!');

end;

procedure TForm1.b5Click(Sender: TObject);
var i,ii ,j, jj : integer ;
begin
    for i := 1 to 3 do
    for j := 1 to 3 do
    if pos[i,j] = IntToStr(b5.Left)+IntToStr(b5.Top) then
    begin
        jj := j;
        ii:= i;
        //ShowMessage(pos[ii,jj]);
    end;
    {ShowMessage(IntToStr(ii));
    ShowMessage(IntToStr(jj));
    ShowMessage(pos[ii,jj]);}
    if pole[ii,jj+1] = 0 then
    begin
        pole[ii,jj+1] := 5;
        pole[ii,jj] := 0;
        b5.Left := posx[ii,jj+1];
        b5.Top := posy[ii,jj+1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii,jj-1] = 0 then
    begin
        pole[ii,jj-1] := 5;
        pole[ii,jj] := 0;
        b5.Left := posx[ii,jj-1];
        b5.Top := posy[ii,jj-1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii+1,jj] = 0 then
    begin
        pole[ii+1,jj] := 5;
        pole[ii,jj] := 0;
        b5.Left := posx[ii+1,jj];
        b5.Top := posy[ii+1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii-1,jj] = 0 then
    begin
        pole[ii-1,jj] := 5;
        pole[ii,jj] := 0;
        b5.Left := posx[ii-1,jj];
        b5.Top := posy[ii-1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end;
    s1 := '';
    for i := 1 to 3 do
    for j := 1 to 3 do
        s1 :=  s1 + IntToStr(pole[i,j]);
    if s1 = s0 then ShowMessage('Вітаю!!!');

end;

procedure TForm1.b6Click(Sender: TObject);
var i,ii ,j, jj : integer ;
begin
    for i := 1 to 3 do
    for j := 1 to 3 do
    if pos[i,j] = IntToStr(b6.Left)+IntToStr(b6.Top) then
    begin
        jj := j;
        ii:= i;
        //ShowMessage(pos[ii,jj]);
    end;
    {ShowMessage(IntToStr(ii));
    ShowMessage(IntToStr(jj));
    ShowMessage(pos[ii,jj]);}
    if pole[ii,jj+1] = 0 then
    begin
        pole[ii,jj+1] := 6;
        pole[ii,jj] := 0;
        b6.Left := posx[ii,jj+1];
        b6.Top := posy[ii,jj+1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii,jj-1] = 0 then
    begin
        pole[ii,jj-1] := 6;
        pole[ii,jj] := 0;
        b6.Left := posx[ii,jj-1];
        b6.Top := posy[ii,jj-1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii+1,jj] = 0 then
    begin
        pole[ii+1,jj] := 6;
        pole[ii,jj] := 0;
        b6.Left := posx[ii+1,jj];
        b6.Top := posy[ii+1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii-1,jj] = 0 then
    begin
        pole[ii-1,jj] := 6;
        pole[ii,jj] := 0;
        b6.Left := posx[ii-1,jj];
        b6.Top := posy[ii-1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end;
    s1 := '';
    for i := 1 to 3 do
    for j := 1 to 3 do
        s1 :=  s1 + IntToStr(pole[i,j]);
    if s1 = s0 then ShowMessage('Вітаю!!!');

end;

procedure TForm1.b7Click(Sender: TObject);
var i,ii ,j, jj : integer ;
begin
    for i := 1 to 3 do
    for j := 1 to 3 do
    if pos[i,j] = IntToStr(b7.Left)+IntToStr(b7.Top) then
    begin
        jj := j;
        ii:= i;
        //ShowMessage(pos[ii,jj]);
    end;
    {ShowMessage(IntToStr(ii));
    ShowMessage(IntToStr(jj));
    ShowMessage(pos[ii,jj]);}
    if pole[ii,jj+1] = 0 then
    begin
        pole[ii,jj+1] := 7;
        pole[ii,jj] := 0;
        b7.Left := posx[ii,jj+1];
        b7.Top := posy[ii,jj+1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii,jj-1] = 0 then
    begin
        pole[ii,jj-1] := 7;
        pole[ii,jj] := 0;
        b7.Left := posx[ii,jj-1];
        b7.Top := posy[ii,jj-1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii+1,jj] = 0 then
    begin
        pole[ii+1,jj] := 7;
        pole[ii,jj] := 0;
        b7.Left := posx[ii+1,jj];
        b7.Top := posy[ii+1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii-1,jj] = 0 then
    begin
        pole[ii-1,jj] := 7;
        pole[ii,jj] := 0;
        b7.Left := posx[ii-1,jj];
        b7.Top := posy[ii-1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end;
    s1 := '';
    for i := 1 to 3 do
    for j := 1 to 3 do
        s1 :=  s1 + IntToStr(pole[i,j]);
    if s1 = s0 then ShowMessage('Вітаю!!!');

end;

procedure TForm1.b8Click(Sender: TObject);
var i,ii ,j, jj : integer ;
begin
    for i := 1 to 3 do
    for j := 1 to 3 do
    if pos[i,j] = IntToStr(b8.Left)+IntToStr(b8.Top) then
    begin
        jj := j;
        ii:= i;
        //ShowMessage(pos[ii,jj]);
    end;
    {ShowMessage(IntToStr(ii));
    ShowMessage(IntToStr(jj));
    ShowMessage(pos[ii,jj]);}
    if pole[ii,jj+1] = 0 then
    begin
        pole[ii,jj+1] := 8;
        pole[ii,jj] := 0;
        b8.Left := posx[ii,jj+1];
        b8.Top := posy[ii,jj+1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii,jj-1] = 0 then
    begin
        pole[ii,jj-1] := 8;
        pole[ii,jj] := 0;
        b8.Left := posx[ii,jj-1];
        b8.Top := posy[ii,jj-1];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii+1,jj] = 0 then
    begin
        pole[ii+1,jj] := 8;
        pole[ii,jj] := 0;
        b8.Left := posx[ii+1,jj];
        b8.Top := posy[ii+1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end
    else
    if pole[ii-1,jj] = 0 then
    begin
        pole[ii-1,jj] := 8;
        pole[ii,jj] := 0;
        b8.Left := posx[ii-1,jj];
        b8.Top := posy[ii-1,jj];
        //ShowMessage(pos[ii+1,jj]);
    end;
    s1 := '';
    for i := 1 to 3 do
    for j := 1 to 3 do
        s1 :=  s1 + IntToStr(pole[i,j]);
    if s1 = s0 then Form2.showmodal;


end;

procedure TForm1.ngClick(Sender: TObject);
begin
    ng.Caption:='NG';
end;

end.
