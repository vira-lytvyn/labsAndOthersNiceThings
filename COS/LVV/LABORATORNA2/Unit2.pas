unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    BitBtn4: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

function kilkinmas( some_text : String; k : Integer; a : char) : Integer;
var kilk, j : integer;
begin
  kilk := 0;
  for j := 0 to k do
    begin
       if (some_text[j] = a) then
          begin
            kilk := kilk + 1;
          end;
    end;
    Result := kilk;
end;

function kilkparinmas( some_text : String; k : Integer; a : Char; b : Char) : Integer;
var kilk, j, i : integer;
begin
  kilk := 0;

  for j := 0 to k-1 do
    begin
       if (some_text[j] = a) then
          begin
            if (some_text[j+1] = b) then
            begin
              kilk := kilk + 1;
            end;
          end;
    end;
    Result := kilk;
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
var   text, text_all : String;
  inp, alf : TextFile;
  vector : TextFile;
  matrix : TextFile;
  result : TextFile;
  imov : array [0..36] of Real;
  um_imov : array [0..36,0..36] of Real;
  alfav : array [0..36] of Char;
  mas_kilk : array [0..36] of Integer;
  k_zah, k_alf, kilkmas, i, j : integer;
  p1, sum_im, sum_um_im : Real;
begin
  AssignFile(inp, 'Input.txt');
  AssignFile(result, 'Results.txt');
  Rewrite(result);
  k_zah := 0;
  p1 := 0;
  Reset(inp);
       while not Eof(inp) do
              begin
                ReadLn (inp, text);
                Memo1.Lines.Add(text);
                k_zah := k_zah + Length(text);
              end;
  text_all := Memo1.Text;

  AssignFile(alf, 'Alfavit.txt');
  Reset(alf);
        while not Eof(alf) do
              begin
                for i := 0 to 36 do
                  begin
                    ReadLn (alf, alfav[i]);
                  end;
              end;
  p1 := 1.0 / 37;

  for i := 0 to 36 do
    begin
      mas_kilk[i] := kilkinmas(text_all, k_zah, alfav[i]);
    end;
  AssignFile(vector, 'Vector.txt');
  Rewrite(vector);
  sum_im := 0.0;
  for i := 0 to 36 do
    begin
      imov[i]:= mas_kilk[i] / k_zah;
      sum_im := sum_im + imov[i];
      Writeln(vector,i,')  ', 'imovirnist symvoly "', alfav[i] ,'" = ',  FloatToStr(imov[i]));
    end;
    Writeln(result, 'Syma imovirnostej poyavy koznoji litery = ' ,  FloatToStr(sum_im));

   AssignFile(matrix, 'Matrix.txt');
   Rewrite(matrix);
   sum_um_im := 0.0;
   for i := 0 to 36 do
       for j := 0 to 36 do
         begin
           um_imov[i,j] := kilkparinmas(text_all, k_zah, alfav[i], alfav[j]) / k_zah;
           sum_um_im := sum_um_im + um_imov[i,j];
           writeln(matrix,'symvol "', alfav[i], '" pered "', alfav[j], '" = ', um_imov[i, j]:4:7);
         end;
  Writeln(result, 'Syma vsih umovnyh imovirnostej litery = ' ,  FloatToStr(sum_um_im));

  CloseFile(matrix);
  CloseFile(vector);
  CloseFile(inp);
  CloseFile(alf);
  CloseFile(result);
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
     Memo1.Text := '';
end;

end.

