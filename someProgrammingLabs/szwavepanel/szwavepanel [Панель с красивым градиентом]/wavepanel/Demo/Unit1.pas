unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WavePanel, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    WavePanel1: TWavePanel;
    WavePanel2: TWavePanel;
    WavePanel3: TWavePanel;
    WavePanel4: TWavePanel;
    WavePanel5: TWavePanel;
    WavePanel6: TWavePanel;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Image1: TImage;
    Label4: TLabel;
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ShellApi;

const
  MaxSpaceHome = 'http://www.zecos.com/maxspc';

{$R *.dfm}

procedure TForm1.Image1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', MaxSpaceHome, '', '', SW_MAXIMIZE);
end;

end.
