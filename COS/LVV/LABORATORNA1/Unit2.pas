unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Math;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  data_mas : array [0..359] of Integer;
  rizn_data_mas : array [0..359] of Integer;
  i, mk : integer;
  first : TextFile;
  second : File of Integer ;
  third : file of Integer ;
  fourth : file of Byte ;

   Procedure BinStr (i : Integer ; Var s : String) ;
   Procedure BinVal (s : String ;  Var i : Integer ; Var Code : Integer) ;

implementation

   Procedure BinStr(i : Integer ; Var s : String) ;
   {
      convert an integer to a string in binary format
   }
   begin
         s := '' ;
         while i > 0 do begin
            if i MOD 2 > 0 then
               s := '1' + s
            else
               s := '0' + s ;
            i := i DIV 2
         end ;
         if Length (s) = 0 then
            s := '0'
   end ;

   Procedure BinVal (s : String ; Var i : Integer ; Var Code : Integer) ;
   {
      convert a string in binary format to an integer
   }
   Var
      Sign, j, n  : Integer ;

   begin
      if s[1] IN ['0', '1'] then
      begin
                     Sign := 1 ;
                     n    := 1 ;
         i := 0 ;
         for j := n to Length(s) do
            if s[j] IN ['0', '1'] then
               i := 2*i + Ord(s[j]) - Ord('0')
            else begin
               Code := j ;
               Exit
            end ;
         i := Sign * i
      end
      else begin
         i     := 0 ;
         Code  := 1 ;
      end;
    { i := i shr 2;
     Code := Code shr 2;
     i := i shl 2;
     Code := Code shl 2;   }
   end ;

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
var ss1, ss2 : String;
    th1, th2, th3, th4 : integer;
begin
    AssignFile(first, 'First.txt');
    AssignFile(second, 'Second.txt');
    AssignFile(third, 'Third.txt');
    AssignFile(fourth, 'Fourth.txt');
    ReWrite(first);
    Rewrite(second);
    Rewrite(third);
    Rewrite(fourth);

    for i:= 0 to 359 do
    begin
        mk := random (40);
        data_mas [ i ] := 760 + mk;
        Memo1.Lines.Add (inttostr(i) + ')     ' + inttostr (data_mas [ i ]) + '     ' + IntToStr(mk)) ;
        WriteLn (first, data_mas [ i ]);
        Write (second, data_mas [ i ]);
        BinStr(mk, ss2);
        BinVal(ss2, th3, th4);
        Write (fourth, th3);
    end;
    CloseFile(first);
    CloseFile(second);
    CloseFile(fourth);
    for i:= 0 to 359 do
    begin
        BinStr(data_mas [ i ], ss1);
        BinVal(ss1, th1, th2);
        Write (third, th1);
    end;
    CloseFile(third);


end;

procedure TForm2.FormCreate(Sender: TObject);
begin
     Memo1.Text := '';
end;

end.

