unit Ufigurs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TFFig = class(TForm)
    Image1: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFig: TFFig;

implementation

{$R *.DFM}

procedure TFFig.FormShow(Sender: TObject);
begin
with Image1.Canvas do
 begin
  Font.Style:=[fsBold];
  Arc(10,10,90,90,90,50,10,50);
  TextOut(40,60,'Arc');
  Chord(110,10,190,90,190,50,110,50);
  TextOut(135,60,'Chord');
  Ellipse(210,10,290,50);
  TextOut(230,60,'Ellipse');
  Pie(310,10,390,90,390,30,310,30);
  TextOut(340,60,'Pie');
  PolyGon([Point(30,150),Point(40,130),Point(50,140),Point(60,130),Point(70,150)]);
  TextOut(30,170,'PolyGon');
  PolyLine([Point(130,150),Point(140,130),Point(150,140),Point(160,130),Point(170,150)]);
  TextOut(130,170,'PolyLine');
  Rectangle(230,120,280,160);
  TextOut(230,170,'Rectangle');
  RoundRect(330,120,380,160,20,20);
  TextOut(325,170,'RoundRect');
 end;
end;

end.
