unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    BitBtn1: TBitBtn;
    XPManifest1: TXPManifest;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a, b, z, E: Real;
  Kmax, k: integer;

implementation

{$R *.dfm}
Function F(x:Real;i:byte):Real;
begin
   if (i=0) then
      F:=x*x-4
    else
      F:=3*x-4*ln(x)-5;
end;
Function  P1 (x, dx:Real;i:byte):Real;
Begin
    P1:=(F(x+dx,i)-F(x,i))/dx;
End;
Function  P2 (x, dx:Real;i:byte):Real;
Begin
    P2:=(F(x+dx,i)+F(x-dx,i)-2*F(x,i))/(dx*dx);
End;

procedure TForm1.BitBtn1Click(Sender: TObject);
var i:byte;
    c, x1, x2, dx, Dpx : Real;
begin
    a := StrToFloat(Edit1.Text);
    b := StrToFloat(Edit2.Text);
    if a>b then
        begin
          z:=a;
          a:=b;
          b:=z;
        end;
    E := StrToFloat(Edit3.Text);
    Kmax := StrToInt(Edit4.Text);
     case ComboBox2.ItemIndex of
     0: begin
            i:=0;
        end;
     1: begin
            i:=1;
        end;
     end;
     case ComboBox1.ItemIndex of  {Nuton}
      0:  begin
            k:=1;
            dx := 0.00001;
            x1 := b;
            if (F(b,i)*P2(b,dx,i)<0) then
            begin
               x1 := a;
               if (F(a,i)*P2(a,dx,i)<0) then
                begin
                    ShowMessage( 'Dlya zadanoho rivnannya zbiznist ne garantujetsa');
                    exit;
                end;
            end;
                for k:=1 to Kmax do
                begin
                    Dpx := F(x1,i)/P1(x1,dx,i);
                    x1 := x1 - Dpx;
                    if(abs(Dpx)<E) then
		                begin
                        Edit5.Text := FloatToStr(x1);
                        Edit6.Text := IntToStr(k);
                        exit;
                    end;
                    if k>=Kmax then
                    begin
                      ShowMessage('za zadanu kilkist iteratzij korenya ne znajdeno');
                      exit;
                    end;
                end;
          end;
      1:  begin  {MPD}
            k:=0;
          if abs(F(a,i))<E then
           begin
              Edit5.Text := FloatToStr(a);
              Edit6.Text := IntToStr(k);
           end
          else
          if abs(F(b,i))<E then
           begin
              Edit5.Text := FloatToStr(b);
              Edit6.Text := IntToStr(k);
           end;
          repeat
            c:=0.5*(b-a)+a;
            k:=k+1;
            if F(a,i)*F(c,i)>0 then a:= c else b:=c;
            if k>kmax then
            begin
                ShowMessage('vvedeni mezi e nekorektni abo za zadanu kilkist iteraziy  znaytu korin ne mozlyvo');
                exit;
            end;
          until (abs(F(c,i))<E);
          Edit5.Text := FloatToStr (c);
          Edit6.Text := IntToStr (k);
          end;
      end;
   end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
    Edit1.Clear;
    Edit2.Clear;
    Edit3.Clear;
    Edit4.Clear;
    Edit5.Clear;
    Edit6.Clear;
end;

end.


