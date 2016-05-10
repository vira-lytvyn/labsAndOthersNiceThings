unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,CheckLst, ComCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    ScrollBar1: TScrollBar;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  temp:Integer;
  temp2:String;

implementation
uses Unit1;
{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
sc:Integer;
//I, J,PosReturn, SkipChars: Integer;
begin
temp2:=FloatToStr(Round((ScrollBar1.Position*Form1.RichEdit1.Lines.Capacity)/100));
temp:=StrToInt(temp2);
if  ScrollBar1.Position = 0 then
temp:=1;
//SkipChars:=0;
//for I := 0 to temp-2 do
//SkipChars := SkipChars + Length(Form1.RichEdit1.Lines[I]);
//SkipChars := SkipChars + (I*2);
//Form1.RichEdit1.SetFocus;
//Form1.RichEdit1.SelStart := SkipChars;
//Form1.RichEdit1.SelLength :=0;

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
percent:=(Round((Form1.RichEdit1.CaretPos.Y+1)/(Form1.RichEdit1.Lines.Capacity)*100));
if(percent>100)then
percent:=100;
Form1.Panel3.Caption:=''+FloatToStr(percent)+'%';
Form3.Hide;
Close;
end;

procedure TForm3.ScrollBar1Change(Sender: TObject);
begin
Label1.Caption:=''+IntToStr(ScrollBar1.Position)+'%';
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
FormStyle:=fsStayOnTop;
end;

end.
