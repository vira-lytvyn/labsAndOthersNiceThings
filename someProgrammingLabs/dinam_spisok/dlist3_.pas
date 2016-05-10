unit dlist3_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}

type
  TPStudent=^TStudent; //указатель на тип TStudent

  TStudent = record
        f_name:string[20];  // фамили€
	l_name:string[20];  // им€
	next: TPStudent;    // следующий элемент списка
  end;

var
  head: TPStudent;  // начало (голова) списка

procedure TForm1.Button1Click(Sender: TObject);
var
   node: TPStudent;  // новый узел списка
   curr: TPStudent;  // текущий узел списка
   pre:  TPStudent;  // предыдущий, относительно curr, узел
begin
   new(node); // создание нового элемента списка
   node^.f_name:=Edit1.Text;
   node^.l_name:=Edit2.Text;
   // добавление узла в список
   // сначала найдем подход€щее место в списке дл€ узла
   curr:=head;
   pre:=NIL;
   { ¬нимание!
     если приведенное ниже условие заменить
     на (node.f_name>curr^.f_name)and(curr<>NIL)
     то при добавлении первого узла возникает ошибка времени
     выполнени€, так как curr = NIL и, следовательно,
     переменной curr.^name нет!
     ¬ используемом варианте услови€ ошибка не возникает, так как
     сначала провер€етс€ условие (curr <> NIL), значение которого
     FALSE и второе условие в этом случае не провер€етс€.
   }
   while (curr <> NIL)and(node.f_name > curr^.f_name)  do
   begin
     // введенное значение больше текущего
     pre:= curr;
     curr:=curr^.next; // к следующему узлу
   end;
   if pre = NIL
     then
        begin
          // новый узел в начало списка
          node^.next:=head;
	  head:=node;
        end
     else
        begin
          // новый узел после pre, перед curr
	  node^.next:=pre^.next;
          pre^.next:=node;
        end;

   Edit1.text:='';
   Edit2.text:='';
   Edit1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 curr: TPStudent;  // текущий элемент списка
 n:integer; // длина (кол-во элементов) списка
 st:string; // строковое представление списка
begin
 n:=0;
 st:='';
 curr:=head;
 while curr <> NIL do
    begin
      n:=n+1;
      st:=st+curr^.f_name+' '+curr^.l_name+#13;
      curr:=curr^.next;
    end;
 if n <> 0
    then ShowMessage('—писок:'+#13+st)
    else ShowMessage('¬ списке нет элементов.');
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
     head:=NIL;
end;

// щелчок на кнопке ”далить
procedure TForm1.Button3Click(Sender: TObject);
var
  curr:TPStudent; // текущий, провер€емый узел
  pre: TPStudent; // предыдущий узел
  found:boolean;  // TRUE - узел, который надо удалить, есть в списке

begin
  if head = NIL then
     begin
        MessageDlg('—писок пустой!',mtError,[mbOk],0);
        Exit;
     end;
  curr:=head;   // текущий узел - первый узел
  pre:=NIL;     // предыдущего узла нет
  found:=FALSE;

  // найти узел, который надо удалить
  while (curr <> NIL) and (not found) do
      begin
          if (curr^.f_name = Edit1.Text) and (curr^.l_name = Edit2.Text)
            then found:=TRUE // нужный узел найден
            else  // к следующему узлу
               begin
                 pre:=curr;
                 curr:=curr^.next;
               end;
      end;
      if found then
         begin
            // нужный узел найден
            if MessageDlg('”зел будет удален из списка!',
                           mtWarning,[mbOk,mbCancel],0) <> mrYes
               then Exit;

            // удал€ем узел
            if pre = NIL
               then  head:=curr^.next      // удал€ем первый узел списка
               else pre^.next:=curr.next;
             Dispose(curr);
             MessageDlg('”зел' + #13 +
                      '»м€:'+Edit1.Text + #13 +
                      '‘амили€:' + Edit2.Text + #13 +
                      'удален из списка.',
                      mtInformation,[mbOk],0);
         end
      else // узла, который надо удалить, в списке нет
           MessageDlg('”зел' + #13 +
                      '»м€:' + Edit1.Text + #13 +
                      '‘амили€:' + Edit2.Text + #13 +
                      'в списке не найден.',
                      mtError,[mbOk],0);
      Edit1.Text:='';
      Edit1.Text:='';
      Edit1.SetFocus;
end;


end.
