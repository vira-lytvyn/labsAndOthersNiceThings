// Fecha de Envio    18/02/2002  10:04:30 p.m.
// De:               "Remberto Gonzales C." <rembert@usfx.edu.bo>
// Organizacion:     TR7SOFT
// Compatibilidad:   probado en Delphi 5
// Subject:          Fast Transparent Forms, on Image
// Limitaciones:     Solo BMP's con 256 colores
// Comentarios a:    rembert@usfx.edu.bo

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms,
  Buttons, StdCtrls, ExtCtrls, Controls, Menus;

type
  TForm1 = class(TForm)
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Close1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  tot_reg, tmp_reg    : HRGN;
  colu_img, fila_img,
  x_a, x_b            : Integer;
  color_transparente  : TColor;
  linea               : PByteArray;
  Virtual_Image       : TBitmap;
begin
  tot_reg       := CreateRectRgn(0, 0, Image1.Width, Image1.Height);
  Virtual_Image := Image1.Picture.BitMap;
  linea         := Virtual_Image.ScanLine[0];

  // definimos el color transparente, como el primer pixel de la imagen (izquierda, superior)
  color_transparente := linea[0];

  // procesamos scanline x scanline
  for fila_img := 0 to (Virtual_Image.Height-1) do
  begin
    linea    := Virtual_Image.ScanLine[fila_img];
    colu_img := 0;
    x_a      := colu_img;
    while (colu_img <= (Virtual_Image.Width-1)) do
    begin
      x_b := TColor(linea[colu_img]);
      if (x_b <> color_transparente)
      then begin
         tmp_reg := CreateRectRgn(x_a, fila_img, colu_img, fila_img+1);
         CombineRgn(tot_reg, tot_reg, tmp_reg, RGN_XOR);
         DeleteObject(tmp_reg);

         // avanzamos, hasta encontrar un color transparente
         repeat
           inc(colu_img);
         until ((TColor(linea[colu_img])=color_transparente) or (colu_img=Virtual_Image.Width-1));
         x_a := colu_img;
      end; // if (x_b <> color_transparente)
      inc(colu_img);
    end; // while (colu_img <> (Virtual_Image.Width-1)) do

    // procesamos tambien, si el ultimo pixel de la imagen es de "color transparente"
    if TColor(linea[colu_img-1])=color_transparente
    then begin
      tmp_reg := CreateRectRgn(x_a, fila_img, colu_img+1, fila_img+1);
      CombineRgn(tot_reg, tot_reg, tmp_reg, RGN_XOR);
      DeleteObject(tmp_reg);
    end; // if TColor(linea[colu_img-1])=color_transparente
  end; // for fila_img := 0 to Virtual_Image.Height-1 do

  SetWindowRgn(form1.Handle, tot_reg, true);
  deleteobject(tot_reg);
end; // procedure TForm1.FormCreate(Sender: TObject);

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: Integer);
begin
  ReleaseCapture;
  TForm(form1).perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
 Close;
end;

end.
