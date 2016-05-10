unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls;

type
  TMainForm = class(TForm)
    BitImage: TImage;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Exit1: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure File1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.File1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then
      begin
           BitImage.Picture.LoadFromFile(OpenDialog1.FileName);
           Caption:=OpenDialog1.Filename;
           end;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
Close;
end;

end.
