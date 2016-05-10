unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, Buttons, ComCtrls, clipbrd;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn0: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn0Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  st: string;

  implementation

uses ABOUT, ABOUT1;

{$R *.dfm}

  // Функция вычисления уравнения

function Calculate(SMyExpression: string; digits: Byte): string;

var
   z: Char;
   ipos: Integer;

   function StrToReal(chaine: string): Real;
   var
     r: Real;
     Pos: Integer;
   begin
     Val(chaine, r, Pos);
     if Pos > 0 then Val(Copy(chaine, 1, Pos - 1), r, Pos);
     Result := r;
   end;

   function RealToStr(inreal: Extended; digits: Byte): string;
   var
     S: string;
   begin
     Str(inreal: 0: digits, S);
     realToStr := S;
   end;

   procedure NextChar;
   var
     s: string;
   begin
     if ipos > Length(SMyExpression) then
     begin
       z := #9;
       Exit;
     end
     else
     begin
       s := Copy(SMyExpression, ipos, 1);
       z := s[1];
       Inc(ipos);
     end;
     if z = ' ' then nextchar;
   end;

   function Expression: Real;
   var
     w: Real;

     function Factor: Real;
     var
       ws: string;
     begin
       Nextchar;
       if z in ['0'..'9'] then
       begin
         ws := '';
         repeat
           ws := ws + z;
           nextchar
         until not (z in ['0'..'9', '.']);
         Factor := StrToReal(ws);
       end
       else if z = '(' then
       begin
         Factor := Expression;
         nextchar
       end
       else if z = '+' then Factor := +Factor
       else if Z = '-' then Factor := -Factor;
     end;

     function Term: Real;
      var
       W: Real;
     begin
       W := Factor;
       while Z in ['*', '/'] do
         if z = '*' then w := w * Factor
       else
       w := w / Factor;
       Term := w;
      end;
   begin
     w := term;
     while z in ['+', '-'] do
       if z = '+' then w := w + term
     else
       w := w - term;
     Expression := w;
   end;
 begin
   ipos   := 1;
   Result := RealToStr(Expression, digits);

 end;

// Функция удаления последних нулей и точек

function StrFl(st: string): string;
label
  p1, p2, p3;
var
  poz: Byte;
  k: integer;
  stt: string;
begin
  k := Length(st);
if k <= 1 then
goto p2;
  p1:
  stt := Copy(st, 1, 1); {Очистка от пробелов}
if stt = ' ' then
begin
  st := Copy(st, 2, k - 1);
  k := k - 1;
goto p1;
end;
  stt := Copy(st, k, 1);
if stt = ' ' then
begin
  st := Copy(st, 1, k - 1);
  k := k - 1;
goto p1;
end;
  p3:
  poz := Pos('.', st); {Очистка от нулей}
if poz = 0 then
goto p2;
  stt := Copy(st, k, 1);
if stt = '0' then
begin
  st := Copy(st, 1, k - 1);
  k := k - 1;
goto p3;
end;
if stt = '.' then {Очистка от точки}
begin
  st := Copy(st, 1, k - 1);
end;
  p2:
  StrFl := st;
end;

// Для 0

procedure TForm1.BitBtn0Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='0';
  st:=st+'0';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'0';
  st:=st+'0';
end;
end;
end;
end;

// Для 1

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='1';
  st:=st+'1';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'1';
  st:=st+'1';
end;
end;
end;
end;

// Для 2

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='2';
  st:=st+'2';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'2';
  st:=st+'2';
end;
end;
end;
end;

// Для 3

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='3';
  st:=st+'3';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'3';
  st:=st+'3';
end;
end;
end;
end;

// Для 4

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='4';
  st:=st+'4';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'4';
  st:=st+'4';
end;
end;
end;
end;

// Для 5

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='5';
  st:=st+'5';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'5';
  st:=st+'5';
end;
end;
end;
end;

// Для 6

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='6';
  st:=st+'6';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'6';
  st:=st+'6';
end;
end;
end;
end;

// Для 7

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='7';
  st:=st+'7';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'7';
  st:=st+'7';
end;
end;
end;
end;

// Для 8

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='8';
  st:=st+'8';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'8';
  st:=st+'8';
end;
end;
end;
end;

// Для 9

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='9';
  st:=st+'9';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if st<>'0' then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9','(','+','-','*','/','.'] then
begin
  Panel1.Caption:=Panel1.Caption+'9';
  st:=st+'9';
end;
end;
end;
end;

// Для точки

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if st<>'' then
begin
if AnsiPos('.',st)<1 then
begin
if AnsiPos('=',Panel1.Caption)<1 then
begin
  Panel1.Caption:=Panel1.Caption+'.';
  st:=st+'.';
end;
end;
end;
end;

// Для открывающей скобки

procedure TForm1.BitBtn11Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='(';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['-','+','*','/','('] then
begin
  Panel1.Caption:= Panel1.Caption + '(';
end;
end;
end;

// Функция поиска одинакового количества символов в строке

function CountPos(const subtext: string; Text: string): Integer;
begin
if (Length(subtext) = 0) or (Length(Text) = 0) or (Pos(subtext, Text) = 0) then
  Result := 0
else
  Result := (Length(Text) - Length(StringReplace(Text, subtext, '', [rfReplaceAll]))) div
  Length(subtext);
end;

// Для закрывающей скобки

procedure TForm1.BitBtn12Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption<>'' then
begin
if CountPos('(',Panel1.Caption)> CountPos(')', Panel1.Caption) then
begin
if AnsiPos('=',Panel1.Caption)<1 then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9',')'] then
begin
  Panel1.Caption:= Panel1.Caption + ')';
end;
end;
end;
end;
end;

// Для +

procedure TForm1.BitBtn13Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption<>'' then
begin
if AnsiPos('=',Panel1.Caption)<1 then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9',')'] then
begin
  Panel1.Caption:= Panel1.Caption + '+';
  st:='';
end;
end;
end;
end;

// Для -

procedure TForm1.BitBtn14Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption='' then
begin
  Panel1.Caption:='-';
  st:='';
end
else
if AnsiPos('=',Panel1.Caption)<1 then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9',')','('] then
begin
  Panel1.Caption:= Panel1.Caption + '-';
  st:='';
end;
end;
end;

// Для *

procedure TForm1.BitBtn15Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption<>'' then
begin
if AnsiPos('=',Panel1.Caption)<1 then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9',')'] then
begin
  Panel1.Caption:= Panel1.Caption + '*';
  st:='';
end;
end;
end;
end;

// Для /

procedure TForm1.BitBtn16Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption<>'' then
begin
if AnsiPos('=',Panel1.Caption)<1 then
begin
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9',')'] then
begin
  Panel1.Caption:= Panel1.Caption + '/';
  st:='';
end;
end;
end;
end;

// Для =

procedure TForm1.BitBtn19Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if CountPos('(',Panel1.Caption)<> CountPos(')', Panel1.Caption) then
begin
  AboutBox1.Label1.Caption:='Введите закрывающую скобку';
  AboutBox1.ShowModal;
  AboutBox1.Position:=poMainFormCenter;
end
  //MessageBox(Handle,'Введите нужное количество закрывающих скобок','',0)
else
begin
if AnsiPos('=',Panel1.Caption)<1 then
begin
if Panel1.Caption<>'' then
begin
try
if Panel1.Caption[Length(Panel1.Caption)] in ['0'..'9',')'] then
if StrFl(Calculate(Panel1.Caption, 3))='-0' then
   Panel1.Caption:= Panel1.Caption+' = 0'
else
   Panel1.Caption:= Panel1.Caption+' = '+StrFl(copy(Calculate(Panel1.Caption, 3), 1, 16));
except
  AboutBox1.Label1.Caption:='Деление на нуль запрещено';
  AboutBox1.ShowModal;
  AboutBox1.Position:=poMainFormCenter;
  //MessageBox(Handle,'Деление на нуль запрещено','',MB_ICONWARNING);
end;
end;
end;
end;
end;

// Для кнопки отмена

procedure TForm1.BitBtn18Click(Sender: TObject);
var
  s:string;
  x:integer;
  y:integer;
begin
  GroupBox1.SetFocus;
if Panel1.Caption<>'' then
if AnsiPos('=',Panel1.Caption)<1 then
begin
for x:=1 to Length(Panel1.Caption)-1 do s:=s+Panel1.Caption[x];
  Panel1.Caption:= s;
  st:='';
for y:=Length(Panel1.Caption) downto 1 do
if Panel1.Caption[y] in ['(',')','+','-','/','*'] then
  break
else
  st:=Panel1.Caption[y]+st;
end
else
begin
  Panel1.Caption:='';
  st:='';
end;
end;

// Для кнопки сброс

procedure TForm1.BitBtn17Click(Sender: TObject);
begin
  GroupBox1.SetFocus;
if Panel1.Caption<>'' then
  Panel1.Caption:='';
  st:='';
end;

// Функция  для определения нажата ли клавиша Shift

function ShiftDown : Boolean;
var
  State : TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Shift] and 128) <> 0);
end;

// Реакция программы на нажатие клавиш клавиатуры

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GroupBox1.SetFocus;
if (key=27) then
  Form1.Close;
if (key=49) then
  BitBtn1.Click;
if (key=97) then
  BitBtn1.Click;
if (key=50) then
  BitBtn2.Click;
if (key=98) then
  BitBtn2.Click;
if (key=51) then
  BitBtn3.Click;
if (key=99) then
  BitBtn3.Click;
if (key=52) then
  BitBtn4.Click;
if (key=100) then
  BitBtn4.Click;
if (key=53) then
  BitBtn5.Click;
if (key=101) then
  BitBtn5.Click;
if (key=54) then
  BitBtn6.Click;
if (key=102) then
  BitBtn6.Click;
if (key=55) then
  BitBtn7.Click;
if (key=103) then
  BitBtn7.Click;
if (key=104) then
  BitBtn8.Click;
if (key=105) then
  BitBtn9.Click;
if (key=96) then
  BitBtn0.Click;
if (key=190) then
  BitBtn10.Click;
if (key=188) then
  BitBtn10.Click;
if (key=110) then
  BitBtn10.Click;
if (key=107) then
  BitBtn13.Click;
if (key=109) then
  BitBtn14.Click;
if (key=189) then
  BitBtn14.Click;
if (key=106) then
  BitBtn15.Click;
if (key=191) then
  BitBtn16.Click;
if (key=111) then
  BitBtn16.Click;
if (key=46) then
  BitBtn17.Click;
if (key=8) then
  BitBtn18.Click;
if (key=13) then
  BitBtn19.Click;
if (key=57) then
begin
if ShiftDown then
  BitBtn11.Click
else
  BitBtn9.Click;
end;
if (key=48) then
begin
if ShiftDown then
  BitBtn12.Click
else
  BitBtn0.Click;
end;
if (key=56) then
begin
if ShiftDown then
  BitBtn15.Click
else
  BitBtn8.Click;
end;
if (key=187) then
begin
if ShiftDown then
  BitBtn13.Click
else
  BitBtn19.Click;
end;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
if AnsiPos('=', Panel1.Caption)>0 then
  Clipboard.asText:=Panel1.Caption;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
if AnsiPos('=', Panel1.Caption)>0 then
  Clipboard.asText:=Copy(Panel1.Caption,AnsiPos('=', Panel1.Caption)+2,MaxInt);
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  AboutBox.ShowModal;
  AboutBox.Position:=poMainFormCenter;
end;

end.
