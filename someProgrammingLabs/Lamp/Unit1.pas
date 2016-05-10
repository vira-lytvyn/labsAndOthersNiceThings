unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math;

type
  TRGBArray = ARRAY[0..0] OF TRGBTriple;
  pRGBArray = ^TRGBArray;
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const d = 250; // Rayon du faisceau

var
  Form1: TForm1;
  orig, temp: TBitmap;
  r : TRect;
  hypotenuse : Array of Array of Integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  c : TCanvas;
  i, j : Integer;
begin
  DoubleBuffered := true;
  // Disparition du pointeur de souris :
  ShowCursor(false);
  // Ajustement de la taille de la fenêtre :
  Top := 0;
  Left := 0;
  ClientWidth := Screen.Width;
  ClientHeight := Screen.Height;
  r := Rect(0 , 0, ClientWidth, ClientHeight);
  // Création du bitmap "orig" destiné à contenir l'image de fond :
  orig := TBitmap.Create;
  orig.PixelFormat := pf24Bit;
  orig.Width := ClientWidth;
  orig.Height := ClientHeight;
  { Création du bitmap "temp" destiné à contenir l'image gérérée par le
   programme et affichée à l'écran à chaque mouvement de souris : }
  temp := TBitmap.Create;
  temp.Canvas.Brush.Color := clBlack;
  temp.PixelFormat := pf24Bit;
  temp.Width := ClientWidth;
  temp.Height := ClientHeight;
  { Récupération de l'image à l'écran à l'instant de création de la fenêtre
    et attribution au bitmap "orig" : }
  c := TCanvas.Create;
  try
    c.Handle := GetWindowDC(GetDesktopWindow);
    orig.Canvas.CopyRect(r, c, r);
  finally
    c.Free;
  end;
  Canvas.Draw(0, 0, orig);
  { Création d'une table "hypoténuse" destinée à éviter les appels à
    Round(Hypot(x,y)) dans les calculs qui seront effectués. }
  setLength(hypotenuse, d+1, d+1);
  for i := 0 to d do for j := 0 to d do hypotenuse[i, j] := Round(Hypot(i, j));
end;

procedure TForm1.FormClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  orig.Free;
  temp.Free;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  Canvas.Draw(0, 0, temp);
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Close;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i, j, x0, x1, y0, y1, h : Integer;
  O, T : PRGBArray;
begin
  { Calculs des coordonnées des coins haut-gauche et bas-droite du carré
    dans lequel est inscrit le faisceau : }
  x0 := max(0, X - d);
  x1 := min(orig.Width-1, X + d);
  y0 := max(0, Y - d);
  y1 := min(orig.Height-1, Y + d);
  // Remplissage (en noir) du bitmap "temp" :
  temp.Canvas.FillRect(r);
  { On parcourt les points du carré, et cela ligne par ligne (puis colonne
    par colonne) afin d'utiliser "Scanline" : }
  for j := y0 to y1 do begin
    O := orig.Scanline[j];
    T := temp.ScanLine[j];
    for i := x0 to x1 do begin
      // Calcul de la distance avec le centre du faisceau :
      h := hypotenuse[Abs(X-i), Abs(Y-j)];
      if h < d then begin
        // On se ramène à in nombre compris entre 0 et 255 :
        h := Trunc(h/d*255);
        // Et on assombrit les couleurs en fonction de h :
        T[i].rgbtRed := max(0, O[i].rgbtRed - h);
        T[i].rgbtGreen := max(0, O[i].rgbtGreen - h);
        T[i].rgbtBlue := max(0, O[i].rgbtBlue - h);
      end;
    end;
  end;
  Repaint;
end;

end.
 