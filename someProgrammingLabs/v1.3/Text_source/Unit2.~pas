unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,Richedit,Registry;

type
  TForm2 = class(TForm)
    ColorDialog1: TColorDialog;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Edit1: TEdit;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Edit2: TEdit;
    Button4: TButton;
    Panel3: TPanel;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  FlagProkrutka:Integer;
  FlagMask:Integer;
  mask: Word;
implementation

uses Unit1;
{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
if(ColorDialog1.Execute=True) then
begin
Form1.RichEdit1.Color:=ColorDialog1.Color;
Panel1.Color:=Form1.RichEdit1.Color;
end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var st:String;
reg: TRegistry;
begin

if(Form2.CheckBox7.Checked=True)then
FlagSaveOut:=True
else
FlagSaveOut:=False;

if(Form2.CheckBox3.Checked=True)then
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_CLASSES_ROOT;
  reg.OpenKey('.txt\shell\open\command', true);
  reg.DeleteValue('');
  reg.WriteString('',ParamStr(0)+' %1');
  reg.CloseKey;
  reg.free;
end
else
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_CLASSES_ROOT;
  reg.DeleteKey('.txt\shell');
  reg.CloseKey;
  reg.free;
end;

if(Form2.CheckBox6.Checked=True)then
begin
if length(Edit2.Text)=0 then
BufferDel:=#13
else
BufferDel:=#13+Edit2.Text+#13;
end
else
BufferDel:='';
if(Form2.CheckBox5.Checked=True)then
begin
if FlagMask=0 then
st:=Form1.RichEdit1.Lines.Text;
mask := SendMessage(Form1.RichEdit1.Handle, EM_GETEVENTMASK, 0, 0);
SendMessage(Form1.RichEdit1.Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
SendMessage(Form1.RichEdit1.Handle, EM_AUTOURLDETECT, Integer(True), 0);
if FlagMask=0 then
begin
Form1.RichEdit1.Lines.Clear;
Form1.RichEdit1.Lines.Add(st);
Form1.RichEdit1.Lines.Move(Form1.RichEdit1.Lines.Capacity+1,0);
Form1.RichEdit1.Lines.Delete(0);
end;
if(FlagPos=1) then
Form1.RichEdit1.Modified:=True
else
Form1.RichEdit1.Modified:=False;
st:='';
FlagMask:=1;
end
else
begin
if FlagMask=1 then
begin
st:=Form1.RichEdit1.Lines.Text;
mask := SendMessage(Form1.RichEdit1.Handle, EM_GETEVENTMASK, 0, 0);
SendMessage(Form1.RichEdit1.Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
SendMessage(Form1.RichEdit1.Handle, EM_AUTOURLDETECT, Integer(False), 0);
Form1.RichEdit1.Lines.Clear;
Form1.RichEdit1.Lines.Add(st);
Form1.RichEdit1.Lines.Move(Form1.RichEdit1.Lines.Capacity+1,0);
Form1.RichEdit1.Lines.Delete(0);
if(FlagPos=1) then
Form1.RichEdit1.Modified:=True
else
Form1.RichEdit1.Modified:=False;
st:='';
FlagMask:=0;
end;
end;

if(Form2.CheckBox1.Checked=True)then
begin
SetPriorityClass(ProcessHandle,HIGH_PRIORITY_CLASS);
FlagProcess:=1;
FlagOpen:=1;
end
else
SetPriorityClass(ProcessHandle,NORMAL_PRIORITY_CLASS);
if(Form2.CheckBox2.Checked=True)then
FlagNote:=1
else
FlagNote:=0;

if(Form1.Timer1.Enabled=True)then
FlagProkrutka:=1;
if(FlagProkrutka=1)then
begin
Form1.Timer1.Enabled:=False;
Form1.Timer1.Interval:=2500-TrackBar1.Position;
Form1.Timer1.Enabled:=True;
end
else
Form1.Timer1.Interval:=2500-TrackBar1.Position;
if(length(Edit1.Text)>0)then
StringTab:=StrToInt(Edit1.Text);

if(Form2.CheckBox4.Checked=True)then
Form1.Panel7.Visible:=True
else
Form1.Panel7.Visible:=False;

FlagProkrutka:=0;
Close;

if(Form2.CheckBox8.Checked=True)then
Form1.SaveInit
else
Form1.DelInit;

end;

procedure TForm2.Button3Click(Sender: TObject);
begin

if(ColorDialog1.Execute=True) then
begin
Form1.RichEdit1.Font.Color:=ColorDialog1.Color;
Panel2.Color:=Form1.RichEdit1.Font.Color;
end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
reg: TRegistry;
begin
FlagMask:=0;
FlagProkrutka:=0;
FormStyle:=fsStayOnTop;
Panel1.Color:=Form1.RichEdit1.Color;
Panel2.Color:=Form1.RichEdit1.Font.Color;
Panel3.Color:=HighLightColor;
reg := TRegistry.Create;
reg.RootKey := HKEY_CLASSES_ROOT;
if reg.KeyExists('.txt\shell\open\command')=True then
Form2.CheckBox3.Checked:=True;
reg.CloseKey;
reg.free;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
Edit1.Text:=IntToStr(StringTab);
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
if(ColorDialog1.Execute=True) then
begin
HighLightColor:=ColorDialog1.Color;
Panel3.Color:=HighLightColor;
end;
end;

end.
