unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  temp:Integer;

implementation
uses Unit1;

{$R *.dfm}

procedure TForm5.FormCreate(Sender: TObject);
begin
FormStyle:=fsStayOnTop;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
if((length(Edit1.Text)>0)and(StrToInt(Edit1.Text)<=Form1.RichEdit1.Lines.Capacity)and(StrToInt(Edit1.Text)>=1))then
begin
temp:=StrToInt(Edit1.Text);
Form1.RichEdit1.Lines.Move(Form1.RichEdit1.Lines.Capacity+1,temp-1);
Form1.RichEdit1.Lines.Delete(temp-1);
if(GetScrollPos (Form1.RichEdit1.Handle,SB_VERT)<temp-1) then
with Form1.RichEdit1 do
perform(EM_ScrollCaret,0,0)
else
with Form1.RichEdit1 do
perform(EM_ScrollCaret,0,0);
if(FlagPos=1) then
Form1.RichEdit1.Modified:=True
else
Form1.RichEdit1.Modified:=False;

Form1.Panel2.Caption:=''+IntToStr(Form1.RichEdit1.CaretPos.Y+1)+':'+IntToStr(Form1.RichEdit1.CaretPos.X);
percent:=(Round((Form1.RichEdit1.CaretPos.Y+1)/(Form1.RichEdit1.Lines.Capacity)*99));
if(percent>100)then
percent:=100;
Form1.Panel3.Caption:=''+FloatToStr(percent)+'%';
Form5.Hide;
Close;
end;

end;

procedure TForm5.FormActivate(Sender: TObject);
begin
Edit1.Clear;
Edit1.SetFocus;
end;

procedure TForm5.Edit1DblClick(Sender: TObject);
begin
Button1.Click;
end;

end.
