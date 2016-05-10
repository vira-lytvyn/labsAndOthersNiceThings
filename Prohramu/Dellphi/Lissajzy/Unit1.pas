unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    PaintBox1: TPaintBox;
    procedure PaintBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.PaintBox1Click(Sender: TObject);
var a, fi, t, w1, w2, k: Double;
    Dx, Dy: Integer;
begin
    a:=90;
    w1:=StrToFloat(Edit1.Text);
    w2:=StrToFloat(Edit2.Text);
    w1:=w1*100;
    w2:=w2*100;
    fi:=-pi/4;
    k:=1;
    Dx:=PaintBox1.ClientWidth div 2;
    Dy:=PaintBox1.ClientHeight div 2;
    PaintBox1.Canvas.Pen.Color:=cllime;
    repeat PaintBox1.Repaint;
    fi:=fi+0.1;
    t:=0;
    repeat t:= t + 0.0001;
    PaintBox1.Canvas.MoveTo(Round(a*cos(w1*(t-0.0001)))+dx, Round (a*cos(w2+t-0.0001)+fi) + dy);
    PaintBox1.Canvas.LineTo(Round(a*cos(w1+t))+dx, Round (a*cos(w2*t+fi)) + dy);
    until t>2*pi/w1+pi;
    Sleep (100);
    until fi >2*pi*k;
end;

end.
