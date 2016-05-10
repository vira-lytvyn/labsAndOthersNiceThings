unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm5 = class(TForm)
    VariantsLabel: TLabel;
    YouVSPC: TLabel;
    YouVSYou: TLabel;
    YouVSYouinTCP: TLabel;
    Exit: TButton;
    procedure ExitClick(Sender: TObject);
    procedure YouVSPCMouseEnter(Sender: TObject);
    procedure YouVSYouMouseEnter(Sender: TObject);
    procedure YouVSYouMouseLeave(Sender: TObject);
    procedure YouVSPCMouseLeave(Sender: TObject);
    procedure YouVSPCClick(Sender: TObject);
    procedure YouVSYouClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit1, hotseat;

{$R *.dfm}

procedure TForm5.ExitClick(Sender: TObject);
begin
halt;
end;

procedure TForm5.YouVSPCMouseEnter(Sender: TObject);
begin
youvspc.Font.Color:=clPurple;
end;

procedure TForm5.YouVSYouMouseEnter(Sender: TObject);
begin
youvsyou.Font.Color:=clPurple;
end;

procedure TForm5.YouVSYouMouseLeave(Sender: TObject);
begin
youvsyou.Font.Color:=clGreen;
end;

procedure TForm5.YouVSPCMouseLeave(Sender: TObject);
begin
youvspc.Font.Color:=clGreen;
end;

procedure TForm5.YouVSPCClick(Sender: TObject);
begin
form1.showmodal;
end;

procedure TForm5.YouVSYouClick(Sender: TObject);
begin
form6.showmodal;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
form5.left:=(screen.Width-form5.Width) div 2;
form5.top:=(screen.Height-form5.Height) div 2;
end;

end.
