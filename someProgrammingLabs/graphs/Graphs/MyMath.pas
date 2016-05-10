unit MyMath;

interface

uses SysUtils,math;

type
   func=(more,less,same);
type TOtv=record
   Resh:string;
   StartStr,EndStr:word;
   end;

var otv:totv;

function maxmin(a,b:string):func;
procedure swapstr(var a,b:string);
procedure swaparr(var a,b:array of shortint);
procedure delnull(var a:string);
procedure multiply(var a,b:string);
procedure addition(var a,b:string);
procedure substract(var a,b:string);
procedure division(zn:cardinal; var a,b:string);
procedure uni(str:string; n:word; deystv:string);
procedure unie(str:string; n:word);
procedure unitrig(str:string; n:word; deystv:string);
function erranalise(str:string):string;
function analise(str:string):string;

implementation

function maxmin(a,b:string):func;
var ch1:cardinal;
begin
//удаление нулей
delnull(a);
delnull(b);
//проверка на отрицательность
if (a[1]='-')and(b[1]<>'-') then
   begin
   maxmin:=less;
   exit;
   end;
if (a[1]<>'-')and(b[1]='-') then
   begin
   maxmin:=more;
   exit;
   end;
//проверка на запятые
if pos(',',a)=0 then a:=a+',0';
if pos(',',b)=0 then b:=b+',0';
if pos(',',a)>pos(',',b) then
   begin
   maxmin:=more;
   exit;
   end;
if pos(',',a)<pos(',',b) then
   begin
   maxmin:=less;
   exit;
   end;
if length(a)>length(b) then
   for ch1:=1 to length(a)-length(b) do
      b:=b+'0';
if length(a)<length(b) then
   for ch1:=1 to length(b)-length(a) do
      a:=a+'0';
for ch1:=1 to length(a) do
   begin
   if a[ch1]<b[ch1] then
      begin
      maxmin:=less;
      exit;
      end;
   if a[ch1]>b[ch1] then
      begin
      maxmin:=more;
      exit;
      end;
   end;
maxmin:=same;
end;

procedure swapstr(var a,b:string);
var c:^string;
begin
new(c);
c^:=a;
a:=b;
b:=c^;
dispose(c);
end;

procedure swaparr(var a,b:array of shortint);
var c,ch1:cardinal;
   q:shortint;
begin
if (high(a)-low(a))=(high(b)-low(b)) then
   begin
   if (low(a)>low(b))or(low(a)=low(b)) then
      begin
      c:=low(a)-low(b);
      for ch1:=low(a) to high(a) do
         begin
         q:=a[ch1];
         a[ch1]:=b[ch1-c];
         b[ch1-c]:=q;
         end;
      end;
   if low(a)<low(b) then
      begin
      c:=low(b)-low(a);
      for ch1:=low(a) to high(a) do
         begin
         q:=a[ch1-c];
         a[ch1-c]:=b[ch1];
         b[ch1]:=q;
         end;
      end;
   end;
end;

procedure delnull(var a:string);
var min1:boolean;
begin
min1:=false;
if pos('-',a)=1 then
   begin
   min1:=true;
   delete(a,1,1);
   end;
if a='' then
   begin
   a:='0';
   exit;
   end;
//убираются ненужные нули в начале и конце чисел
while a[1]='0' do
   begin
   delete(a,1,1);
   if a='' then
      begin
      a:='0';
      break;
      end;
   end;
if pos(',',a)<>0 then
   while a[length(a)]='0' do
      delete(a,length(a),1);
if a[length(a)]=',' then delete(a,length(a),1);
if a='' then a:='0';
if a[1]=',' then a:='0'+a;
if (min1=true)and(a<>'0') then a:='-'+a;
end;

procedure multiply(var a,b:string);
var ch1,ch2,z,la,lb:cardinal;
   min1,min2,min:boolean;
   a1,b1,c:array of byte;
begin
//убираются ненужные нули в начале и конце чисел
delnull(a);
delnull(b);
//обработка минусов
min1:=false;
min2:=false;
z:=0;
if pos('-',a)=1 then
   begin
   min1:=true;
   delete(a,1,1);
   end;
if pos('-',b)=1 then
   begin
   min2:=true;
   delete(b,1,1);
   end;
min:=false;
if (min1=true)or(min2=true) then min:=true;
if (min1=true)and(min2=true)then min:=false;
//запоминается количество знаков после запятой, чтобы в конце их вставить
if pos(',',a)<>0 then
   begin
   z:=length(a)-pos(',',a);
   delete(a,pos(',',a),1);
   end;
if pos(',',b)<>0 then
   begin
   z:=abs(z+length(b)-pos(',',b));
   delete(b,pos(',',b),1);
   end;
//создаются массивы
la:=length(a);
lb:=length(b);
setlength(a1,la);
setlength(b1,lb);
setlength(c,la+lb);
//запоминание в массивах чисел
for ch1:=0 to la-1 do
   a1[ch1]:=strtoint(a[ch1+1]);
for ch1:=0 to lb-1 do
   b1[ch1]:=strtoint(b[ch1+1]);
//обнуление массива произведения
for ch1:=0 to la+lb do
   c[ch1]:=0;
//произведение
for ch1:=la-1 downto 0 do
	for ch2:=lb-1 downto 0 do
   	begin
      c[ch1+ch2+1]:=c[ch1+ch2+1]+a1[ch1]*b1[ch2];
      if c[ch1+ch2+1]>9 then
      	begin
         c[ch1+ch2]:=c[ch1+ch2]+c[ch1+ch2+1]div 10;
         c[ch1+ch2+1]:=c[ch1+ch2+1]-(c[ch1+ch2+1]div 10)*10;
         end;
      end;
//запоминание ответа в строке
a:='';
b:='0';
if min=true then a:='-';
for ch1:=0 to la+lb-1 do
   a:=a+inttostr(c[ch1]);
if z<>0 then insert(',',a,abs(length(a)-z+1));
//убираются ненужные нули в начале и конце числа
delnull(a);
delnull(b);
//освобождение памяти от массивов
finalize(a1);
finalize(b1);
finalize(c);
end;

procedure addition(var a,b:string);
var ch1,z,z2,la:cardinal;
   min1,min2:boolean;
   a1,b1,c:array of byte;
begin
//убираются ненужные нули в начале и конце числа
delnull(a);
delnull(b);
//обработка минусов
min1:=false;
min2:=false;
z:=0;
z2:=0;
if pos('-',a)=1 then
   begin
   min1:=true;
   delete(a,1,1);
   end;
if pos('-',b)=1 then
   begin
   min2:=true;
   delete(b,1,1);
   end;
//запоминается количество знаков после запятой, чтобы в конце их вставить
if pos(',',a)<>0 then
   begin
   z:=length(a)-pos(',',a);
   delete(a,pos(',',a),1);
   end;
if pos(',',b)<>0 then
   begin
   z2:=length(b)-pos(',',b);
   delete(b,pos(',',b),1);
   end;
//добавляются нули для создания одинаковой длинны чисел
if z>z2 then
   for ch1:=1 to z-z2 do
      b:=b+'0';
if z<z2 then
   begin
   for ch1:=1 to z2-z do
      a:=a+'0';
   z:=z2;
   end;
if length(a)>length(b) then
   for ch1:=1 to length(a)-length(b) do
      b:='0'+b;
if length(a)<length(b) then
   for ch1:=1 to length(b)-length(a) do
      a:='0'+a;
la:=length(a);
//создаются массивы
setlength(a1,la);
setlength(b1,la);
setlength(c,la+1);
//запоминание в массивах чисел
for ch1:=0 to la-1 do
   begin
   a1[ch1]:=strtoint(a[ch1+1]);
   b1[ch1]:=strtoint(b[ch1+1]);
   //обнуление массива вычитания
   c[ch1]:=0;
   end;
c[la]:=0;
if (min1=true)and(min2=false) then
   begin
   swapstr(a,b);
   substract(a,b);
   exit;
   end;
if (min1=false)and(min2=true) then
   begin
   substract(a,b);
   exit;
   end;
if (min1=true)and(min2=true) then
   begin
   a:='-'+a;
   substract(a,b);
   exit;
   end;
//сложение
for ch1:=la-1 downto 0 do
  	begin
   c[ch1+1]:=c[ch1+1]+a1[ch1]+b1[ch1];
   if c[ch1+1]>9 then
     	begin
      c[ch1]:=c[ch1+1]div 10;
      c[ch1+1]:=c[ch1+1]-10;
      end;
   end;
//запоминание ответа в строке
a:='';
b:='0';
if min1=true then a:='-';
for ch1:=0 to la do
   a:=a+inttostr(c[ch1]);
if z<>0 then insert(',',a,abs(length(a)-z+1));
//убираются ненужные нули в начале и конце числа
delnull(a);
delnull(b);
//освобождение памяти от массивов
finalize(a1);
finalize(b1);
finalize(c);
end;

procedure substract(var a,b:string);
var ch1,z,z2,la:cardinal;
   min1,min2:boolean;
   a1,b1,c:array of shortint;
   max:func;
begin
//удаление лишних нулей
delnull(a);
delnull(b);
//очистка переменных
min1:=false;
min2:=false;
z:=0;
z2:=0;
//обработка минусов
if pos('-',a)=1 then
   begin
   min1:=true;
   delete(a,1,1);
   end;
if pos('-',b)=1 then
   begin
   min2:=true;
   delete(b,1,1);
   end;
//запоминается количество знаков после запятой, чтобы в конце их вставить
if pos(',',a)<>0 then
   begin
   z:=length(a)-pos(',',a);
   delete(a,pos(',',a),1);
   end;
if pos(',',b)<>0 then
   begin
   z2:=length(b)-pos(',',b);
   delete(b,pos(',',b),1);
   end;
//добавляются нули для создания одинаковой длинны чисел
if z>z2 then
   for ch1:=1 to z-z2 do
      b:=b+'0';
if z<z2 then
   begin
   for ch1:=1 to z2-z do
      a:=a+'0';
   z:=z2;
   end;
if length(a)>length(b) then
   for ch1:=1 to length(a)-length(b) do
      b:='0'+b;
if length(a)<length(b) then
   for ch1:=1 to length(b)-length(a) do
      a:='0'+a;
la:=length(a);
//создаются массивы
setlength(a1,la);
setlength(b1,la);
setlength(c,la+1);
//запоминание в массивах чисел
for ch1:=0 to la-1 do
   begin
   a1[ch1]:=strtoint(a[ch1+1]);
   b1[ch1]:=strtoint(b[ch1+1]);
   //обнуление массива вычитания
   c[ch1]:=0;
   end;
c[la]:=0;
//замена действий в зависимости от знака числа
if (min1=true)and(min2=false) then
   begin
   addition(a,b);
   a:='-'+a;
   exit;
   end;
if (min1=true)and(min2=true) then
   begin
   //меняем местами числа
   swapstr(a,b);
   substract(a,b);
   exit;
   end;
if (min1=false)and(min2=true) then
   begin
   addition(a,b);
   exit;
   end;
//перестановка чисел если второе больше первого
max:=maxmin(a,b);
if max=less then swaparr(a1,b1);
//вычитание
for ch1:=la-1 downto 0 do
  	begin
   c[ch1+1]:=c[ch1+1]+a1[ch1]-b1[ch1];
   if c[ch1+1]<0 then
     	begin
      c[ch1]:=c[ch1]-1;
      c[ch1+1]:=c[ch1+1]+10;
      end;
   end;
//запоминание ответа в строке
a:='';
b:='0';
if max=less then a:='-';
for ch1:=0 to la do
   a:=a+inttostr(c[ch1]);
if z<>0 then insert(',',a,abs(length(a)-z+1));
//убираются ненужные нули в начале и конце числа
delnull(a);
delnull(b);
//освобождение памяти от массивов
finalize(a1);
finalize(b1);
finalize(c);
end;

procedure division(zn:cardinal; var a,b:string);
var ch1:cardinal;
   z:longint;
   min1,min2,min:boolean;
   c:shortint;
   a2,b2,c2:string;
   temp:string;
label m1;
begin
//убираются ненужные нули в начале и конце чисел
delnull(a);
delnull(b);
if (a='0')or(b='0') then
   begin
   a:='0';
   b:='0';
   exit;
   end;
//обработка минусов
min1:=false;
min2:=false;
if pos('-',a)=1 then
   begin
   min1:=true;
   delete(a,1,1);
   end;
if pos('-',b)=1 then
   begin
   min2:=true;
   delete(b,1,1);
   end;
min:=false;
if (min1=true)or(min2=true) then min:=true;
if (min1=true)and(min2=true)then min:=false;
a2:=a;
b2:=b;
a:='';
z:=0; //запоминает позицию запятой в ответе
if min=true then a:='-';
ch1:=0;  //счетчик номеров цифр, которые нужно прибавлять к строке
//домножение делимого на десять, пока оно меньше делителя
while maxmin(a2,b2)=less do
   begin
//   exit;
   temp:='10';
   multiply(a2,temp);
   a:=a+'0';
   z:=2;
   end;
//убирание запятых
while (pos(',',a2)<>0)or(pos(',',b2)<>0) do
   begin
   temp:='10';
   multiply(a2,temp);
   temp:='10';
   multiply(b2,temp);
   end;
//деление
b:=b2;
c:=0;
c2:='0';
min:=false;
min2:=false;   //если первый раз собирается число c2 из a2, то нули не рисуются
while ((length(a)-z+1<zn)and(z<>0))or(z=0) do
   begin
   min1:=false;   //счетчик прибавляемых цифр, если это вторая, то в ответ добавляется ноль
   while maxmin(c2,b2)=less do
      begin
      if (min2=true)and(min1=true)then
         a:=a+'0';
      ch1:=ch1+1;
      if ch1>length(a2) then min:=true;
      if min=true then
         begin
         a2:=a2+'0';  //если числа a2 не хватает, то оно домножается на 10
         if z=0 then z:=length(a)+1;   //запоминание позиции запятой
         end;
      c2:=c2+a2[ch1];
      min1:=true;
      end;
   min2:=true;
   while (maxmin(c2,b2)=more)or(maxmin(c2,b2)=same) do
      begin
      substract(c2,b2);
      b2:=b;
      c:=c+1;
      end;
   a:=a+inttostr(c);
   if (c2='')or(c2='0') then break;
   c:=0;
   end;
//запоминание ответа в строке
if z<>0 then insert(',',a,z);
b:='0';
//убираются ненужные нули в начале и конце числа
delnull(a);
delnull(b);
end;

procedure unie(str:string; n:word);
var ch1,ch2:string;
   l,z:word;
   min:boolean;
begin
ch1:='';
ch2:='';
z:=0;
if str[n+1]='-' then str[n+1]:='~';
for l:=n-1 downto 1 do
   begin
   if ((str[l]<'0')or(str[l]>'9'))and(str[l]<>',')and(str[l]<>'~') then break;
   if str[l]='~' then ch1:='-'+ch1
      else ch1:=str[l]+ch1;
   end;
min:=false;
if ch1[1]='-' then
   begin
   min:=true;
   delete(ch1,1,1);
   end;
for l:=n+1 to length(str) do
   begin
   if ((str[l]<'0')or(str[l]>'9'))and(str[l]<>'~') then break;
   if str[l]='~' then ch2:=ch2+'-'
      else ch2:=ch2+str[l];
   end;
if abs(strtofloat(ch2))>30 then
   begin
   otv.resh:='0';
   exit;
   end;
if pos(',',ch1)<>0 then
   begin
   z:=length(ch1)-pos(',',ch1);
   delete(ch1,pos(',',ch1),1);
   end;
otv.resh:=ch1;
if ch2[1]<>'-' then
   begin
   for l:=1 to strtoint(ch2) do
      begin
      z:=z+1;
      otv.resh:=otv.resh+'0';
      end;
   if (z<>0)and(z<>length(otv.resh)) then insert(',',otv.resh,z);
   end;
if ch2[1]='-' then
   begin
   delete(ch2,1,1);
   for l:=1 to strtoint(ch2) do
      otv.resh:='0'+otv.resh;
   insert(',',otv.resh,2);
   end;
delnull(otv.resh);
if min=true then otv.resh:='~'+otv.resh;
end;

procedure uni(str:string; n:word; deystv:string);
var ch1,ch2:string;
   l:word;
begin
ch1:='';
ch2:='';
for l:=n-1 downto 1 do
   begin
   if ((str[l]<'0')or(str[l]>'9'))and(str[l]<>',')and(str[l]<>'~') then break;
   if str[l]='~' then ch1:='-'+ch1
      else ch1:=str[l]+ch1;
   end;
otv.startstr:=n-length(ch1);
for l:=n+1 to length(str) do
   begin
   if ((str[l]<'0')or(str[l]>'9'))and(str[l]<>',')and(str[l]<>'~') then break;
   if str[l]='~' then ch2:=ch2+'-'
      else ch2:=ch2+str[l];
   end;
otv.endstr:=n+length(ch2);
if deystv='step' then otv.resh:=floattostr(power(strtofloat(ch1),strtofloat(ch2)));
if deystv='umn' then otv.resh:=floattostr(strtofloat(ch1)*strtofloat(ch2));
if (deystv='del')or(deystv='drob') then otv.resh:=floattostr(strtofloat(ch1)/strtofloat(ch2));
if deystv='sum' then otv.resh:=floattostr(strtofloat(ch1)+strtofloat(ch2));
if deystv='min' then otv.resh:=floattostr(strtofloat(ch1)-strtofloat(ch2));
if otv.resh[1]='-' then otv.resh[1]:='~';
if pos('E',otv.resh)<>0 then unie(otv.resh,pos('E',otv.resh));
end;

procedure unitrig(str:string; n:word; deystv:string);
var l:word;
   ch:string;
begin
otv.startstr:=n;
for l:=n+1+length(deystv) to length(str) do
   begin
   if ((str[l]<'0')or(str[l]>'9'))and(str[l]<>',')and(str[l]<>'~') then break;
   if str[l]='~' then ch:=ch+'-'
      else ch:=ch+str[l];
   end;
otv.endstr:=n+length(ch)+length(deystv);
if deystv='cos' then otv.resh:=floattostr(cos(strtofloat(ch)));
if deystv='sin' then otv.resh:=floattostr(sin(strtofloat(ch)));
if deystv='tan' then otv.resh:=floattostr(sin(strtofloat(ch))/cos(strtofloat(ch)));
if deystv='ctg' then otv.resh:=floattostr(cos(strtofloat(ch))/sin(strtofloat(ch)));
if deystv='log' then otv.resh:=floattostr(log10(strtofloat(ch)));
if deystv='sinh' then otv.resh:=floattostr(sinh(strtofloat(ch)));
if deystv='cosh' then otv.resh:=floattostr(cosh(strtofloat(ch)));
if otv.resh[1]='-' then otv.resh[1]:='~';
if pos('E',otv.resh)<>0 then unie(otv.resh,pos('E',otv.resh));
end;

function erranalise(str:string):string;
var n:word;
   sk:integer;
label a,b;
begin
sk:=0;
//подсчет количества скобок
for n:=1 to length(str) do
   begin
   if str[n]='(' then sk:=sk+1;
   if str[n]=')' then sk:=sk-1;
   end;
//если количество открывающих скобок не равно, то выход
if sk<>0 then
   begin
   erranalise:='0';
   exit;
   end;
a:;
for n:=1 to length(str)-3 do
   //если между числом и тригоном. функциями ничего нет, то вставляется умножение
   //пример 2sin x=2*sin x
   if (((str[n]>='0')and(str[n]<='9'))or(str[n]=')'))and((copy(str,n+1,3)='sin')or
      (copy(str,n+1,3)='cos')or(copy(str,n+1,3)='tan')or
      (copy(str,n+1,3)='ctg')or(copy(str,n+1,3)='log')) then
      begin
      insert('*',str,n+1);
      goto a;
      end;
b:;
for n:=1 to length(str)-1 do
   begin
   //вставляет нехватающий ноль в целую часть
   //пример 36,47+,476=36,47+0,476
   if ((str[n]<'0')or(str[n]>'9'))and(str[n+1]=',') then
      begin
      insert('0',str,n+1);
      goto b;
      end;
   //если между числом и скобкой или буквой ничего нет, то вставляется быстрое умножение
   //пример x(3+4x^2)=x&(3+4&x^2)
   if (((str[n]>='0')and(str[n]<='9'))or(str[n]=')'))and((str[n+1]='(')or
      (str[n+1]>='a')and(str[n+1]<='z')) then
      begin
      insert('&',str,n+1);
      goto b;
      end;
   //если после какого-то знака стоит отриц.число, то ставится "правильный" минус
   //пример 2+-3=2+(-3)=2+~3=2+(~3)
   if ((str[n]='*')or(str[n]='&')or(str[n]=' ')or(str[n]='/')or(str[n]='+')or(str[n]='-')or(str[n]='('))and(str[n+1]='-') then
      str[n+1]:='~';
   end;
erranalise:=str;
end;

function analise(str:string):string;
var str2:string;
   n,m,opsk,clsk:word;
   label a,b,c;
begin
str:='('+str+')';
str:=erranalise(str);
str2:='';
repeat
a:otv.resh:='';
for n:=1 to length(str) do
   if ((str[n]<'0')or(str[n]>'9'))and(str[n]<>',')and(str[n]<>'(')and(str[n]<>')')and(str[n]<>'~') then otv.resh:='norm';
if otv.resh<>'norm' then goto b;
str2:=str;
opsk:=0;
clsk:=0;
for n:=1 to length(str) do
   begin
   if str[n]='(' then opsk:=n;
   if str[n]=')' then
      begin
      clsk:=n;
      str2:=copy(str,opsk,clsk-opsk+1);
      break;
      end;
   end;
otv.resh:='';
for n:=1 to length(str2) do
   if ((str2[n]<'0')or(str2[n]>'9'))and(str2[n]<>',')and(str2[n]<>'(')and(str2[n]<>')')and(str2[n]<>'~') then
      otv.resh:='norm';
if otv.resh<>'norm' then
   begin
   delete(str,opsk,clsk-opsk+1);
   insert(copy(str2,2,length(str2)-2),str,opsk);
   goto a;
   end;
for m:=1 to 5 do
   begin
   c:;
   for n:=1 to length(str2)-4 do
      if m=3 then
         begin
         if copy(str2,n,4)='cos ' then
            begin
            unitrig(str2,n,'cos');
            delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
            insert(otv.resh,str2,otv.startstr);
            goto c;
            end;
         if copy(str2,n,4)='sin ' then
            begin
            unitrig(str2,n,'sin');
            delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
            insert(otv.resh,str2,otv.startstr);
            goto c;
            end;
         if copy(str2,n,4)='tan ' then
            begin
            unitrig(str2,n,'tan');
            delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
            insert(otv.resh,str2,otv.startstr);
            goto c;
            end;
         if copy(str2,n,4)='ctg ' then
            begin
            unitrig(str2,n,'ctg');
            delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
            insert(otv.resh,str2,otv.startstr);
            goto c;
            end;
         if copy(str2,n,4)='log ' then
            begin
            unitrig(str2,n,'log');
            delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
            insert(otv.resh,str2,otv.startstr);
            goto c;
            end;
         end;
   for n:=1 to length(str2)-5 do
      if m=3 then
         begin
         if copy(str2,n,4)='cosh ' then
            begin
            unitrig(str2,n,'cosh');
            delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
            insert(otv.resh,str2,otv.startstr);
            goto c;
            end;
         if copy(str2,n,4)='sinh ' then
            begin
            unitrig(str2,n,'sinh');
            delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
            insert(otv.resh,str2,otv.startstr);
            goto c;
            end;
         end;
   for n:=1 to length(str2) do
      begin
      if (m=1)and(str2[n]='^') then
         begin
         uni(str2,n,'step');
         delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
         insert(otv.resh,str2,otv.startstr);
         goto c;
         end;
      if (m=2)and(str2[n]='&') then
         begin
         uni(str2,n,'umn');
         delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
         insert(otv.resh,str2,otv.startstr);
         goto c;
         end;
      if (m=2)and(str2[n]='\') then
         begin
         uni(str2,n,'drob');
         delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
         insert(otv.resh,str2,otv.startstr);
         goto c;
         end;
      if (m=4)and(str2[n]='*') then
         begin
         uni(str2,n,'umn');
         delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
         insert(otv.resh,str2,otv.startstr);
         goto c;
         end;
      if (m=4)and(str2[n]='/') then
         begin
         uni(str2,n,'del');
         delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
         insert(otv.resh,str2,otv.startstr);
         goto c;
         end;
      if (m=5)and(str2[n]='+') then
         begin
         uni(str2,n,'sum');
         delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
         insert(otv.resh,str2,otv.startstr);
         goto c;
         end;
      if (m=5)and(str2[n]='-') then
         begin
         uni(str2,n,'min');
         delete(str2,otv.startstr,otv.endstr-otv.startstr+1);
         insert(otv.resh,str2,otv.startstr);
         goto c;
         end;
      end;
   end;
if str2[1]='(' then delete(str2,1,1);
if str2[length(str2)]=')' then delete(str2,length(str2),1);
delete(str,opsk,clsk-opsk+1);
insert(str2,str,opsk);
until opsk=0;
b:if str[1]='(' then delete(str,1,1);
if str[length(str)]=')' then delete(str,length(str),1);
if str[1]='~' then str[1]:='-';
analise:=str;
end;

end.
