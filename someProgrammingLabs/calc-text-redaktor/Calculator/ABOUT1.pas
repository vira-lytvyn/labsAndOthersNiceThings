unit ABOUT1;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    procedure Label1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox1: TAboutBox1;

implementation

{$R *.dfm}

procedure TAboutBox1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=13) then
  AboutBox1.Close;
end;

procedure TAboutBox1.Label1Click(Sender: TObject);
begin
  AboutBox1.Close;
end;

procedure TAboutBox1.Panel1Click(Sender: TObject);
begin
  AboutBox1.Close;
end;

end.
 
