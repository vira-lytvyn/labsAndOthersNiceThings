unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TRules = class(TForm)
    Me: TImage;
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Rules: TRules;

implementation
uses pre;
{$R *.dfm}

procedure TRules.FormCreate(Sender: TObject);
begin
 rules.left:=(screen.Width-rules.Width) div 2;
 rules.top:=(screen.Height-rules.Height) div 2;
end;

procedure TRules.FormPaint(Sender: TObject);
begin
 rules.Caption:=pre.RulesCaption;
 memo1.Text:=pre.RulesText+pre.RulesText1;
end;

end.
