unit Effects4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ImgList;

type
  TformTransp = class(TForm)
    imgTransp: TImage;
    Timer1: TTimer;
    btnClose: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formTransp: TformTransp;
  curImage: Byte;
  curPath: string;

implementation

{$R *.dfm}

procedure TformTransp.FormShow(Sender: TObject);
begin
  curPath := ExtractFilePath(Application.ExeName);
  imgTransp.Picture.LoadFromFile(CurPath + '0.bmp');
  TransparentColor := True;
  btnClose.Visible := False;
  curImage := 0;
  Timer1.Enabled := True;
end;

procedure TformTransp.Timer1Timer(Sender: TObject);
begin
  if CurImage <= 8
  then begin
    imgTransp.Picture.LoadFromFile(CurPath + IntToStr(CurImage) + '.bmp');
    Inc(CurImage);
  end else
  begin
    Timer1.Enabled := False;
    TransparentColor := False;
    btnClose.Visible := True;
  end;
end;

end.
