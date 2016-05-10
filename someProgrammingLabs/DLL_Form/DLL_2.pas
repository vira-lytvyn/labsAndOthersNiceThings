unit DLL_2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
procedure ShowFToCForm(AHandle: THandle); StdCall external 'SHOWFTOC.DLL';

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  ShowFToCForm(Handle);
end;

end.
