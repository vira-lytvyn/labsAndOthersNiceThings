unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;
type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Find_Btn: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Edit5: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit7: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit4: TEdit;
    Label9: TLabel;
    procedure Find_BtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a, b, x: Real;

implementation

uses Math;

{$R *.dfm}

function f(x : Real):Real;
var y : Real;
begin
    y := exp(x) - Sin(x);
end;

Function  P1 (x, dx:Real):Real;
Begin
    P1:= exp(x) - cos(x);
End;

procedure TForm1.Find_BtnClick(Sender: TObject);
var d, c, p, q, fd, fc, eps, dx, sygma, y1 : Double;
begin
    a := StrToFloat(Edit5.Text);
    b := StrToFloat(Edit6.Text);
    sygma := StrToFloat(Edit3.Text);
    eps := 0.01*sygma;
    y1 := 0;
    //dx := 0.00001;
    case ComboBox1.ItemIndex of
    0:  begin
            d := a + (b - a) * 0.61803398874989484820458683436564;
            c := b - (b - a) * 0.61803398874989484820458683436564;
            fd := f(d);
            fc := f(c);
            while ( abs( b - a ) > eps ) do // repeat
                begin
                    if (fc >= fd) then
                        begin
                             a := c;
                             //b := d;
                             c := d;
                             d := a + (b - a) * 0.61803398874989484820458683436564;
                             fc := fd;
                             fd := f(d);
                        end
                    else
                        begin
                              b := d;
                              //a := c;
                              d := c;
                              c := b - (b - a) * 0.61803398874989484820458683436564;
                              fd := fc;
                              fc := f(c);
                        end;
                    x := 0.5*( a + b );
                   // y1 := f(x);
                end;
            //until abs (b - a) > sygma;
            //y1 := f(x);
        end;
    1:  begin

        end;
    2:  begin
        end;
    3:  begin
            while ( abs( b - a ) > sygma ) do //repeat
                begin
                    p := 0.5*(a + b) + eps;
                    q := 0.5*(a + b) - eps;
                    if (f(p) < f(q)) then
                        begin
                            a := q;
                            //b := b;
                        end
                    else
                        begin
                           // a := a;
                            b := p;
                        end;
                    x := 0.5*( a + b ) ;
                    y1 := f(x);
                end;

           /// until abs (b - a) > sygma;
           // y_1 := f(x);
        end;
    end;
    // �������a ��� ���������� ����, �� ����� � ������ ������ !!!
    //y1 := f(x);
    Edit1.Text := FloatToStr(x);
    
    Edit4.Text := FloatToStr(P1(x, dx));

    Edit2.Text := FloatToStr(y1);

    if (abs(P1(x, dx)) <= eps) then
      begin
          Label9.Caption := '������ ����� � ������ �������';
      end
    else
      begin
           Label9.Caption := ' ';
      end;
end;

end.
