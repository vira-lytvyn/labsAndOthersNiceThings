unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, Series, Buttons;

type
  TForm1 = class(TForm)
    Chart1: TChart;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Button2: TButton;
    Series1: TLineSeries;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var  a, b, x, y : Real;
begin
    Chart1.Series[0].Clear;
    a:=StrToFloat(Edit1.Text);
    b:=StrToFloat(Edit2.Text);
    x:=a;
    while x<=b do
    begin
        y:=x*Sin(x);
        chart1.Series[0].AddXY(x,y);
        x:=x+0.01;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     Chart1.Series[0].Clear;
     Edit1.Text:='';
     Edit2.Text:='';
end;

end.
