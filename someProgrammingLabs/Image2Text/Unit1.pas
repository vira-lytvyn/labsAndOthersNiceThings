unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Menus, xpman;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    OpenPictureDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    RichEdit1: TRichEdit;
    Button1: TSpeedButton;
    Button2: TSpeedButton;
    Button3: TSpeedButton;
    PopupMenu1: TPopupMenu;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    Screenshot1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Screenshot1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
imgtotxt, unit2, unit3;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
if openpicturedialog1.Execute then
image1.Picture.LoadFromFile(openpicturedialog1.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if savedialog1.Execute then
richedit1.Lines.SaveToFile(savedialog1.FileName);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 if checkbox1.Checked
 then richedit1.Clear;
 richedit1.SelText:=img2text(image1.Picture.Bitmap, checkbox2.Checked, edit1.Text, edit2.Text);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 richedit1.Font.Size:=2;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
 richedit1.Font.Size:=4;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
 richedit1.Font.Size:=8;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
if openpicturedialog1.Execute then
image1.Picture.LoadFromFile(openpicturedialog1.FileName);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
if savedialog1.Execute then
richedit1.Lines.SaveToFile(savedialog1.FileName);
end;

procedure TForm1.N7Click(Sender: TObject);
begin
if checkbox1.Checked then richedit1.Clear;
richedit1.SelText:=img2text(image1.Picture.Bitmap, checkbox2.Checked, edit1.Text, edit2.Text);
end;

procedure TForm1.N9Click(Sender: TObject);
begin
form2.Visible:=true;
form2.timer1.Enabled:=true;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
close;
end;

procedure TForm1.Screenshot1Click(Sender: TObject);
begin
form3.Visible:=true;
end;

end.
 