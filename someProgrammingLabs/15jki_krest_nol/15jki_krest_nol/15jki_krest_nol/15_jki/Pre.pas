unit Pre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TChoseLang = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    English: TButton;
    Russian: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure EnglishClick(Sender: TObject);
    procedure RussianClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChoseLang: TChoseLang;
  ResetCaption,
  exitCaption,MainCaption,RulesText,RulesText1,RulesCaption,WinText,
  WholestepsText,changelangcaption,playkeyb,playmouse:string;
  heyhey: array [1..50] of string;

implementation

uses Unit1;

{$R *.dfm}

procedure locate (lang:string);
begin
 if lang='rus'
 then
  begin
   ResetCaption:='Заново';
   exitCaption:='Выход';
   MainCaption:='Пятнашки';
   RulesText:='В начале игры вы видите поле с цифрами. Цель игры - расставить все числа по возрастающей,'+' начиная сединицы, расположенной в левом верхнем углу, заканчивая шестнадцатью (пустая клетка), расположенной внижнем правом углу.';
   RulesText1:=' Перемещать клетки можно, лишь меняя их местами с пустой клеткой. При этом перемещаемаяклетка должна быть расположена рядом с пустой.';
   RulesCaption:='Правила';
   WinText:='Вы выиграли!';
   WholestepsText:='Всего ходов:';
   changelangcaption:='Сменить язык';
   playkeyb:='Играть на клавиатуре (click or Ctrl+Tab)';
   playmouse:='Играть на мышке (click or Ctrl+Tab)';
   heyhey[1]:='Ну же, ну!';
  end;
 if lang='eng'
 then
  begin
   ResetCaption:='Renew';
   exitCaption:='Exit';
   MainCaption:='Tags';
   RulesText:='At the start, you see the field with numbers. The goal of the game - place all numbers under increasing, beginnings from One, located at lion, upper corner, finishing sixteen (the empty cell), located at lower, right corner.';
   RulesText1:='Move the cells possible, only changing their places with empty cell. Herewith moveable cell shall be disposed near empty cell.';
   RulesCaption:='Rules';
   WinText:='You win!';
   WholestepsText:='Whole steps:';
   changelangcaption:='Change language';
   playkeyb:='Play on keyboard (click or Ctrl+Tab)';
   playmouse:='Play on mouse (click or Ctrl+Tab)';
  end;
 main.showmodal;
end;

procedure TChoseLang.FormCreate(Sender: TObject);
begin
 ChoseLang.left:=(screen.Width-ChoseLang.Width) div 2;
 ChoseLang.top:=(screen.Height-ChoseLang.Height) div 2;
end;

procedure TChoseLang.EnglishClick(Sender: TObject);
begin
 locate('eng');
end;

procedure TChoseLang.RussianClick(Sender: TObject);
begin
 locate('rus');
end;

procedure TChoseLang.Button1Click(Sender: TObject);
begin
 Halt;
end;

end.
