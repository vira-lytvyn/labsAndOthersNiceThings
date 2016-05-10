//******************************************************************************
// Author : Georgy Moshkin
// -----------------------------------------------
// email  : tmtlib@narod.ru
// WWW    : http://www.tmtlib.narod.ru/
//
// License:
// --------
// This unit is freely distributable without licensing fees and is
// provided without guarantee or warrantee expressed or implied. This unit
// is Public Domain. Feel free to use or enhance this code. You can use the
// program for any purpose you see fit.
//
//******************************************************************************

unit rtsmain;

interface

uses BMP,OpenGL,_strman,sysutils,math,windows,_vec2d, Dialogs;


// Тип для описания энгергии (жизненной, магической и т.п.)
type TEnergia=record
               nazv  :string; // Название энергии для меню
               max   :single; // Максимально возможный уровень
               vosst :single; // Скорость восстановления энергии
              end;

// Тип для описания различных ударов
type TUdar=record
            nazv       :string; // Название удара
            chto       :string; // Какую энергию уменьшает (жизненную или магическую и т.п.)
            sila       :single; // Сила удара (сколько отнимет энергии при ударе)
            treb_energ :string; // Требуется ли для удара какая-нибудь другая энергия
            rash_energ :single; // Расход другой энергии (если она требуется)
           end;

// Тип для описания добычи ресурсов
type TDobicha=record
               nazv   :string; // что может добыть юнит
               kolvo  :single; // в каком количестве за один заход (сколько может нести с собой)
               vrem   :single; // время, за которое юнит сможет наполнить свой мешок / срубить дерево и т.п.
              end;

// Тип для описания цены юнитов
type TCena=record
            nazv    :string; // название требуемого ресурса (например, золото)
            kolvo   :single; // цена в единицах NAZV
            vrem    :single; // время, за которое будет создан объект с данной стоимостью
           end;

// Тип для описания количества чего-либо
type TKolvo=record
             nazv   :string; // нечто, что нужно посчитать
             kolvo  :single; // количество этого нечто
            end;

// Тип для описания апгрейда
type TUpgrade=record
               nazv    :string; // название юнита, в который апгрейдимся
               cena    :array of TCena;   // сколько стоит такой апгрейд (массив - дерево, золото, нефть и т.д.)
               kolvo   :array of TKolvo;  // количество требуемых для апгрейда объектов (ферм, заводов и т.д.)
              end;

// Тип для описания кадров анимации
type TKadri=record
             texturnum:integer;     // номер текстуры со спрайтами
             kadr:array of integer; // номера кадров (номера строк со спрайтами)
            end;

// Тип для описания юнита
type TOpisan=record
              nazv     :string; // название юнита (для движка)
              nazvdisp :string; // отображаемое на экране название (для того, кто играет в игру)

              spritestex   :array of GLUINT;     // OpenGL-евский идентификатор текстуры
              posledovatelnost: array of TKadri; // Элементы массива с последовательностями
                                                 // анимации. Описание элементов: 0 - ходьба,
                                                 // 1 - атака, 2 - падение, 3 - альтернативная ходьба (с мешком золота)

              radius     : single;  // радиус описанной вокруг юнита окружности - служит для алгоритма проверки столкновений

              XSize,YSize:integer;  // размеры текстуры со спрайтами
              sprX, sprY : integer; // размеры спрайта (маленький спрайт в большой текстуре со спрайтами)

              energia  :array of TEnergia; // виды энергии юнита
              skorost  :array of single;   // виды скорости юнита (возможность передвигаться по земле, воде, болоту и т.д.)
              udar     :array of TUdar;    // виды ударов, которыми владеет юнит
              stroyka  :array of string;   // массив - названия юнитов, которые может строить данный юнит
              remont   :array of string;   // массив с названиями юнитов, которые может чинить данный юнит
              dobicha  :array of TDobicha; // какие ресурсы может добывать юнит
              upgrade  :array of TUpgrade; // во что может апгрейдиться данный юнит

              cena     :array of TCena;  // цена юнита (измеряется в ресурсах)
              neobh    :array of TKolvo; // необходимые для создания юнита объекты

              resurs    :boolean;  // является ли данный юнит ресурсом (дерево, золотник, нефтяная вышка)
              resursmax :single;   // максимальный уровень ресурса (сколько золота в золотнике)

             end;


// Тип предназначен для хранения описания всех юнитов данной рассы
type TRassa = record
               Opisan:array of TOpisan; // список с описаниями юнитов
              end;

// Массив для хранения всех загруженных расс
var Rassa:array of TRassa;

// Массив для хранения игроков
type TIgrok = record
                Resurs:array[0..2] of single; // Ресурсы, которые добыл данный игрок
                AI:boolean; // Управляется ли данный игрок с помощью искуственного интеллекта (AI)
              end;

// Примечание: расса может быть одна, а игроков - много
// смотри НОМЕР ДРУЖБЫ


// Массив для хранения четырёх игроков 0,1,2,3
var Igroki:array[0..3] of TIgrok;

// Тип, который служит для описания параметров РАСКЛОНИРОВАННОГО юнита
type TObyekt = record
nomRas:integer; // номер рассы
nomTip:integer; // номер типа -nomTip- внутри данной рассы -nomRas-
nomDru:integer; // НОМЕР ДРУЖБЫ

energia :array of single; // значения энергий юнита
resurs  :array of single; // значения добытых ресурсов

pos:TVector2; // положение юнита - точка (pos.x, pos.y)
phi :single;  // угол поворота юнита (в градусах)

TekushKadr:single;  // текущий кадр анимации
TekushPosl:integer; // текущая последовательность (ходьба, атака, рубка деревьев, полёт и т.п.)

TipAtaki:integer; // выбранный тип атаки

MISL1:string; // первая мысль - ГЛАВНАЯ. Идёт её выполнение
MISL2:string; // вторая мысль - ВТОРОСТЕПЕННАЯ. Ждёт, когда главная выполнится

// Примечание: после того, как главная мысль выполнена,
// на её место становится второстепенная:
//
// MISL1:=MISL2
// MISL2:=''
//
// а второстепенная обнуляется.

MISLPROGRESS:integer; // прогресс выполнения мысли

vibran:boolean; // выбран ли данный юнит

end;

// Массив для хранения объектов (реальных юнитов игры - как бы расклонированые юниты)
var Obyekti:array of TObyekt;

// Примечание:
//
// Смысл клонирования здесь заключается в том,
// что внутри РАССЫ уже есть по одному экземпляру
// описаний. Мы же клонируем только изменяющиеся
// параметры, а к неизменяющимся обращаемся
// по ссылкам nomRas и nomTip (номер рассы и номер типа)


// Какая текущая команда, если нажать мышку на карте
var Komanda:integer=0;

// Есть-ли какой-нибудь юнит под курсором мышки
var KtoNibudPodKursorom:integer=-1; // отрицательное значение - под курсором никого нет

// Идентификатор, указывающий на OpenGL-евскую текстуру, в которой хранятся
// спрайты карты (травка, камешки и т.п.)
var MapTexture:GLUINT;

// Показывать ли энергии в виде полосок? true/false
var showEnerg:boolean;

// Процедура выводит спрайт (sprX,sprY) из текстуры (XSize,YSize)
procedure Kvadrat(XSize, YSize, sprX, sprY, strok, stolb:integer; flip:boolean);
// XSize, YSize - размеры текстуры
// sprX, sprY - размеры спрайта внутри этой текстуры
// strok, stolb - номер строки и столбца, в котором находится спрайт
// flip (true/false) - сделать ли зеркальное отображение

// Процедура загрузки рассы
procedure ZagruzRassa(fname,fpath:string);
// Формат файла рассы:
///
// имя_первого_вида_юнитов.txt
// имя_второго_вида_юнитов.txt
// имя_третьего_вида_юнитов.txt
// имя_четвёртого_вида_юнитов.txt
// ...
// и т.д.
//
// fname - имя файла. Например, orki.txt
// fpath - путь к файлу

// Процедура загрузки описаний юнитов
procedure ZagruzOpisan(fname:string;var fRassa:TRassa);
// считывается файл с описанием fname.txt
// в рассу fRassa


// Процедура создания нового объекта (нового юнита)
procedure NewObyekt(nomRas, nomTip, nomDru:integer;x,y,phi:single);
// создаёт новый юнит типа -nomTip-,
// описание которого содержится в рассе nomRas.
//
// Примечание:
// НОМЕР ДРУЖБЫ nomDru у друзей равен,
// поэтому у союзников nomDru нужно задавать
// одинаковыми
//
// x,y,phi - начальное положение юнита в 2-D пространстве.


// Процедура для вывода спрайта с учётом параметров объекта
// и данных анимации
procedure SuperKvadrat(nomerObj,nomerPosl:integer);
//
// nomerObj - номер юнита, который необходимо вывести
// nomerPosl - номер последовательности
//
// Значения nomerPosl:
// -1 - стоит наместе
// 0 - ходьба
// 1 - атака/рубка деревьев
// 2 - падение
// 3 - ходьба с мешком (альтернативная версия ходьбы)
//
// Примечание:
// У неподвижных объектов мы можем всё делать одинаково:
//
// )индексы
// 0 1
// 0 1
// 0 1
// 0 1
//
// Выше приведен отрывок из файла описания юнита БАЗА.
// Так как в каждой строке описан только один кадр (1)
// нулевой текстуры (0), то анимации не будет


// Процедура загрузки текстуры, в которой
// хранятся спрайты травы, камней и т.п.
procedure LoadMapTexture;

// Процедура рендеринга всех юнитов
procedure RenderObjects;

// Процедура рендеринга (отрисовки на экран) карты
procedure RenderKarta;

// Процедура, реализующая искуственный интеллект
// для игрока playerNum
procedure Intellekt(playerNum:integer);

// Интерпретатор мыслей
procedure InterpretirovatMisli;

// Примечание: при вызове процедуры InterpretirovatMisli
// происходит анализ содержимого MISL1 и MISL2 каждого
// юнита. На основе анализа производятся различные
// вычисления и манипуляции с координатами, энергиями и
// другими параметрами юнитов.


// Процедура для отображения курсора
procedure Kursor(tip:integer;dx:single);

// Процедура для проверки столкновений и реализации "толкания"
function Centurus(var center1,center2:TVector2;radius1,radius2:single;tip1,tip2:integer):boolean;

// Процедура для проверки, находится ли юнит i под курсором (kursx, kursy)
function podkursorom(i:integer;kursx,kursy:single):boolean;

// Процедура НУЖНОДОГОНЯТЬ
procedure NujnoDogonyat(i,j:integer);
// i,j - номера юнитов
//
// Данная процедура вызывается, когда
// юниты i и j находятся далеко друг от друга
//
// Когда функция Centurus выдаёт false,
// вызывается NujnoDogonyat
//
// Главный смысл: если у юнита ГЛАВНАЯ мысль - АТАКА,
// но цель слишком далеко, то делаем
// ГЛАВНУЮ мысль - подойти,
// а ВТОРОСТЕПЕННУЮ мысль - атака
//
// Как только мы коснёмся юнита (цели), то Centurus
// выдаст true, и мы вызовем Stolknulsa


// Процедура СТОЛКНУЛСЯ
procedure Stolknulsa(i,j:integer);
// i,j - номера юнитов
//
// Данная процедура проверяет различные виды столкновений:
// - столкновения для добычи золота
// - столкновение после погони (после NujnoDogonyat)
//
// Если сработало столкновени при погоне, то можно
// опять вернуть ГЛАВНУЮ мысль - АТАКУ, которую мы
// делали второстепенной в процедуре NujnoDogonyat

function BlizhZolotnik(objnum:integer):integer;


implementation

//                  текстура      спрайт    строка  столбец
procedure Kvadrat(XSize, YSize, sprX, sprY, strok, stolb:integer; flip:boolean);
begin

if (flip=true) then // вариант с зеркальным отражением
begin
glBegin(GL_QUADS);
glTexCoord2f( (SprX+(stolb-1)*sprX)/XSize, 1-(sprY+(strok-1)*sprY)/YSize); glVertex2f(0,0);
glTexCoord2f( (0+(stolb-1)*sprX)/XSize, 1-(sprY+(strok-1)*sprY)/YSize); glVertex2f(sprX,0);
glTexCoord2f( (0+(stolb-1)*sprX)/XSize, 1-(0+(strok-1)*sprY)/YSize);glVertex2f(sprX,sprY);
glTexCoord2f( (SprX+(stolb-1)*sprX)/XSize, 1-(0+(strok-1)*sprY)/YSize);glVertex2f(0,sprY);
glEnd;
end
 else // вариант без зеркального отражения
begin
glBegin(GL_QUADS);
glTexCoord2f( (0   +(stolb-1)*sprX)/XSize, 1-(sprY+(strok-1)*sprY)/YSize); glVertex2f(0,0);
glTexCoord2f( (SprX+(stolb-1)*sprX)/XSize, 1-(sprY+(strok-1)*sprY)/YSize); glVertex2f(sprX,0);
glTexCoord2f( (SprX+(stolb-1)*sprX)/XSize, 1-(0+(strok-1)*sprY)/YSize);glVertex2f(sprX,sprY);
glTexCoord2f( (0   +(stolb-1)*sprX)/XSize, 1-(0+(strok-1)*sprY)/YSize);glVertex2f(0,sprY);
glEnd;
end;

end;


// Загрузка РАССЫ
procedure ZagruzRassa(fname,fpath:string);
var f:text;
    s:string;
begin
 assignFile(f,fpath+fname); // открываем файл
 reset(f);

 SetLength(Rassa,Length(Rassa)+1); // Увеличиваем длину массива Rassa на единицу

 // Примечание:
 // Это такой способ увеличения динамических массивов
 // с помощью SetLength
 //
 // Мы узнаём длину с помощью Length(Rassa), увеличиваем на 1 (+1)
 // и подставляем в SetLength новое значение Length(Rassa)+1
 //
 // Например, если размер массива был 10,
 // то вызовется SetLength(Rassa, 10+1)
 // и длина станет 11.
 //
 // При следующем вызове - опять увеличим на единицу
 // и т.д..


 repeat
  readln(f,s); // считываем в переменную S название файла
  zagruzOpisan(fpath+s,Rassa[length(rassa)-1]); // загружаем файл
 until eof(f);

 // Итак, здесь мы просто напросто
 // взяли для каждой строчки файла F
 // вызвали процедуру загрузки описания
 // юнита.
 //
 // Например, файл F содержал следующее:
 //
 // krestyanin.txt
 // baza.txt
 // zolotnik.txt
 //
 // Это означает, что в блоке REPEAT-UNTIL
 // три раза вызовется процедура zagruzOpisan:
 //
 // 1) zagruzOpisan('krestyanin.txt',0)
 // 2) zagruzOpisan('baza.txt',1)
 // 3) zagruzOpisan('zolotnik.txt',2)
 //
 // Обратите внимание, что хотя золотник и принадлежит
 // этой рассе, но это условно
 // Мы могли бы вообще сделать отдельную рассу,
 // состоящую из одних только ресурсов
 //
 // Дело в том, что у самого ресурса есть
 // идентификатор resurs:boolean
 //
 // Поэтому другие рассы без труда распознают
 // золотник.
 //
 // ЗОЛОТНИКИ РАСПОЗНАЮТСЯ ПО НОМЕРУ ДРУЖБЫ 555
 // (nomDru=555)


 closeFile(f); // закрываем файл
end;

// Загрузчик-парсер файлов с описаниями
procedure ZagruzOpisan(fname:string;var fRassa:TRassa);
var f         :text;
    razdel    :string; // переменная для хранения имени раздела
    podrazdel :string; // переменная для хранения имени подраздела
    s         :string;
    i         :integer;
    j         :integer;
    k         :integer;
    m         :integer;
    n         :integer;

begin
 assignFile(f,fname);  // открываем файл
 reset(f);

  repeat // в цикле считываем все строки

   readln(f,s); // считали
   s:=trim(s);  // убрали лишние пробелы про краям

   if s<>'' then // если это не пустая строка
    begin

     if s[1]=')' then razdel:=StringWordGet(s, ')',1) // значит РАЗДЕЛ
      else
     if s[1]=']' then podrazdel:=StringWordGet(s, ']',1) // значит ПОДраздел
      else
       begin

       // Далее парсим разделы и подразделы
       //
       // Примечание: описание функции StringWordGet
       // вы можете найти в файле _strman.pas

        if razdel='название' then
         begin
          SetLength(fRassa.Opisan,
                    length(fRassa.Opisan)+1);
          i:=length(fRassa.Opisan)-1;
          fRassa.Opisan[i].nazv:=StringWordGet(s, ' ',1);
          fRassa.Opisan[i].nazvdisp:=StringWordGet(s, ' ',2);

          fRassa.Opisan[i].resurs:=false;
         end;

        if razdel='спрайты' then
         begin
          SetLength(fRassa.Opisan[i].SpritesTex,
                    length(fRassa.Opisan[i].SpritesTex)+1);
          j:=length(fRassa.Opisan[i].SpritesTex)-1;

          LoadTexture(s,fRassa.Opisan[i].SpritesTex[j]);
         end;

        if razdel='индексы' then
         begin
          SetLength(fRassa.Opisan[i].posledovatelnost,
                    length(fRassa.Opisan[i].posledovatelnost)+1);
          j:=length(fRassa.Opisan[i].posledovatelnost)-1;

          m:=StringWordCount(s,' ')-1;

          setlength(fRassa.Opisan[i].posledovatelnost[j].kadr,m);

          fRassa.Opisan[i].posledovatelnost[j].texturnum:=StrToInt(StringWordGet(s, ' ',1));

          for n:=2 to 2+m-1 do
           fRassa.Opisan[i].posledovatelnost[j].kadr[n-2]:=StrToInt(StringWordGet(s, ' ',n));



         end;


    if razdel='параметры' then
         begin
           fRassa.Opisan[i].radius:=StrToInt(StringWordGet(s, ' ',1));
           fRassa.Opisan[i].XSize:=StrToInt(StringWordGet(s, ' ',2));
           fRassa.Opisan[i].YSize:=StrToInt(StringWordGet(s, ' ',3));
           fRassa.Opisan[i].sprX:=StrToInt(StringWordGet(s, ' ',4));
           fRassa.Opisan[i].sprY:=StrToInt(StringWordGet(s, ' ',5));
         end;


        if razdel='энергия' then
         begin
          SetLength(fRassa.Opisan[i].energia,
                    length(fRassa.Opisan[i].energia)+1);
          j:=length(fRassa.Opisan[i].energia)-1;

          fRassa.Opisan[i].energia[j].nazv:=StringWordGet(s, ' ',1);
          fRassa.Opisan[i].energia[j].max:=StrToFloat(StringWordGet(s, ' ',2));
          fRassa.Opisan[i].energia[j].max:=StrToFloat(StringWordGet(s, ' ',3));
         end;

       if razdel='скорость' then
        begin
         SetLength(fRassa.Opisan[i].skorost,
                   length(fRassa.Opisan[i].skorost)+1);
         j:=length(fRassa.Opisan[i].skorost)-1;

         fRassa.Opisan[i].skorost[j]:=StrToFloat(StringWordGet(s, ' ',2));
        end;

      if razdel='удар' then
       begin
         SetLength(fRassa.Opisan[i].udar,
                   length(fRassa.Opisan[i].udar)+1);
         j:=length(fRassa.Opisan[i].udar)-1;

         fRassa.Opisan[i].udar[j].nazv:=StringWordGet(s, ' ',1);
         fRassa.Opisan[i].udar[j].chto:=StringWordGet(s, ' ',2);
         fRassa.Opisan[i].udar[j].sila:=StrToFloat(StringWordGet(s, ' ',3));
         fRassa.Opisan[i].udar[j].treb_energ:=StringWordGet(s, ' ',4);
         fRassa.Opisan[i].udar[j].rash_energ:=StrToFloat(StringWordGet(s, ' ',5));

       end;

      if razdel='стройка' then
       begin
         SetLength(fRassa.Opisan[i].stroyka,
                   length(fRassa.Opisan[i].stroyka)+1);
         j:=length(fRassa.Opisan[i].stroyka)-1;

         fRassa.Opisan[i].stroyka[j]:=s;
       end;

      if razdel='ремонт' then
       begin
         SetLength(fRassa.Opisan[i].remont,
                   length(fRassa.Opisan[i].remont)+1);
         j:=length(fRassa.Opisan[i].remont)-1;

         fRassa.Opisan[i].remont[j]:=s;
       end;

      if razdel='добыча' then
       begin
         SetLength(fRassa.Opisan[i].dobicha,
                   length(fRassa.Opisan[i].dobicha)+1);
         j:=length(fRassa.Opisan[i].dobicha)-1;

         fRassa.Opisan[i].dobicha[j].nazv:=StringWordGet(s, ' ',1);
         fRassa.Opisan[i].dobicha[j].kolvo:=StrToFloat(StringWordGet(s, ' ',2));
         fRassa.Opisan[i].dobicha[j].vrem:=StrToFloat(StringWordGet(s, ' ',3));

       end;

      if (razdel='апгрейд') and (podrazdel='название') then
       begin
         SetLength(fRassa.Opisan[i].upgrade,
                   length(fRassa.Opisan[i].upgrade)+1);
         j:=length(fRassa.Opisan[i].upgrade)-1;

         fRassa.Opisan[i].upgrade[j].nazv:=s
       end;

      if (razdel='апгрейд') and (podrazdel='ресурсы') then
       begin
         SetLength(fRassa.Opisan[i].upgrade[j].cena,
                   length(fRassa.Opisan[i].upgrade[j].cena)+1);
         k:=length(fRassa.Opisan[i].upgrade[j].cena)-1;

         fRassa.Opisan[i].upgrade[j].cena[k].nazv:=StringWordGet(s, ' ',1);
         fRassa.Opisan[i].upgrade[j].cena[k].kolvo:=StrToFloat(StringWordGet(s, ' ',2));
         fRassa.Opisan[i].upgrade[j].cena[k].vrem:=StrToFloat(StringWordGet(s, ' ',3));

       end;

      if (razdel='апгрейд') and (podrazdel='объекты') then
       begin
         SetLength(fRassa.Opisan[i].upgrade[j].kolvo,
                   length(fRassa.Opisan[i].upgrade[j].kolvo)+1);
         k:=length(fRassa.Opisan[i].upgrade[j].kolvo)-1;

         fRassa.Opisan[i].upgrade[j].kolvo[k].nazv:=StringWordGet(s, ' ',1);
         fRassa.Opisan[i].upgrade[j].kolvo[k].kolvo:=StrToFloat(StringWordGet(s, ' ',2));
       end;



 if (razdel='цена') and (podrazdel='ресурсы') then
       begin
         SetLength(fRassa.Opisan[i].cena,
                   length(fRassa.Opisan[i].cena)+1);
         j:=length(fRassa.Opisan[i].cena)-1;

         fRassa.Opisan[i].cena[j].nazv:=StringWordGet(s, ' ',1);
         fRassa.Opisan[i].cena[j].kolvo:=StrToFloat(StringWordGet(s, ' ',2));
         fRassa.Opisan[i].cena[j].vrem:=StrToFloat(StringWordGet(s, ' ',3));
       end;

 if (razdel='цена') and (podrazdel='объекты') then
        begin
         SetLength(fRassa.Opisan[i].neobh,
                   length(fRassa.Opisan[i].neobh)+1);
         j:=length(fRassa.Opisan[i].neobh)-1;

         fRassa.Opisan[i].neobh[j].nazv:=StringWordGet(s, ' ',1);
         fRassa.Opisan[i].neobh[j].kolvo:=StrToFloat(StringWordGet(s, ' ',2));
        end;

      if razdel='ресурс' then
         begin
          i:=length(fRassa.Opisan)-1;
          fRassa.Opisan[i].resurs:=true;
          fRassa.Opisan[i].resursmax:=StrToFloat(s);
         end;



       end;
    end;



  until eof(f); // по достижению конца файла прекращаем парсинг

 closeFile(f); // закрываем файл
end;


// Процедура создания нового обхекта
procedure NewObyekt(nomRas, nomTip, nomDru:integer;x,y,phi:single);
var i:integer;
    j:integer;
    k:integer;
begin

   SetLength(Obyekti,
             length(Obyekti)+1); // Увеличиваем длину массива на 1

   i:=length(Obyekti)-1; // Определяем последний элемент в массиве

   // Примечание:
   //
   // Сначала мы с помощью процедуры SetLength
   // увеличили длину массива Obyekti на единицу,
   // для чего узнали старую длину и прибавили к ней
   // единицу: length(Obyekti)+1
   //
   // А так как элементы в массиве отсчитываюся от НУЛЯ,
   // то последний элемент будет на 1 меньше длины:
   // i:=length(Obyekti)-1;
   //
   // Например, в массиве длиной 5
   // индексы элементов 0,1,2,3,4
   // поэтому индекс последнего и равен i:=5-1


   // Устанавливаем начальную позицию и угол поворота юнита
   Obyekti[i].pos.x:=x;
   Obyekti[i].pos.y:=y;
   Obyekti[i].phi:=phi;

   // Устанавливаем номер РАССЫ, номер ТИПА юнита и НОМЕР ДРУЖБЫ
   Obyekti[i].nomRas:=nomRas;
   Obyekti[i].nomTip:=nomTip;
   Obyekti[i].nomDru:=nomDru;

   // Определяем длину мыссива С ВИДАМИ ЭНЕРГИИ у рассы
   k:=length(Rassa[nomRas].Opisan[nomTip].energia);

   // Примечание: здесь мы и видим клонирование:
   // ТАК КАК ЗНАЧЕНИЯ ЭНЕРГИИ МОЖЕТ МЕНЯТЬСЯ (уменьшается
   // от вражеских ударов), ТО МЫ ДЕЛАЕМ У КЛОНА массив
   // для хранения изменившихся значений с той же длиной K:
   setlength(Obyekti[i].energia,k);

   // Так как юнит свеженький, сто мы ставим ему всё на максимум:
   for j:=0 to k-1 do Obyekti[i].energia[j]:=Rassa[nomRas].Opisan[nomTip].energia[j].max;

   // Максимальные значения берём как раз из РАСС, из базоывх описаний, которые в самой
   // игре не бегают.

   // Примерно то же самое делаем и с возможностями по добыче ресурсов:
   k:=length(Rassa[nomRas].Opisan[nomTip].dobicha); // определили длину у БАЗОВОГО ОПИСАНИЯ
   setlength(Obyekti[i].resurs,k); // сделали такую же длину КЛОНУ

   // То есть определили K и тут же сделали массив с длиной K.

   // На всякий случай обнуляем значения добытых ресурсов (т.к. юнит новый, он ещё ничего не добывал)
   for j:=0 to k-1 do Obyekti[i].resurs[j]:=0;

   // ЕСЛИ ЖЕ ЭТОТ ЮНИТ ЯВЛЯЕТСЯ РЕСУРСОМ (золотник, дерево, ...)
   if Rassa[nomRas].Opisan[nomTip].resurs = true
    then
     begin // ТО МЫ ДОБАВЛЯЕМ ЕМУ ЕГО МАКСИМАЛЬНЫЙ РЕСУРС
      setlength(Obyekti[i].resurs,1);
      Obyekti[i].resurs[0]:=Rassa[nomRas].Opisan[nomTip].ResursMax;
     end;

   // То есть если рассмотреть файл ZOLOTNIK.TXT,
   // и взять раздел РЕСУРС, то мы увидим:
   //
   // )ресурс
   // 100000
   //
   // Это значение и находится после считывания в
   // переменной Rassa[nomRas].Opisan[nomTip].ResursMax;


end;

// Процедура вывода анимированного спрайта из большой текстуры со спрайтами
procedure SuperKvadrat(nomerObj,nomerPosl:integer);
var m,n:integer;
var kolonka:integer;
var zerkalno:boolean;
var XSize,YSize,sprX,sprY:integer;
var kadr:integer;
var nomerPosledovatelnosti:integer;
var tempAngle:single;
begin

// Если номер последовательности 555 - значит крестьянин
// находится внутри золотника. ПОЭТОМУ мы ЗАПУСКАЕМ
// основной блок BEGIN-END только для тех, кто находится
// вне золотника (<>555). Получилось похоже на WarCraft:
// когда крестьянин добывает золото, то его не видно.

if nomerPosl<>555 then
 begin

 // во временные переменные m и n записываем номер РАССЫ и номер ТИПА ЮНИТА
 m:=Obyekti[nomerObj].nomRas;
 n:=Obyekti[nomerObj].nomTip;

 // если номер последовательности отрицательный - значит юнит стоит на месте
 // при этом мы берём первый кадр и используем его как статичный спрайт
 if nomerPosl<0 then
  begin
    Obyekti[nomerObj].TekushKadr:=0; // БЕРЁМ ПЕРВЫЙ КАДР (кадры считаются от нуля, поэтому 0)
    nomerPosledovatelnosti:=abs(nomerPosl)-1; // ВЫЧИСЛЯЕМ НОМЕР ПОСЛЕДОВАТЕЛЬНОСТИ
    // смысл здесь такой:
    // 1) у нас ходьба находится в последовательности 0
    // 2) нам нужен первый кадр ходьбы (выглядит, как будто юнит стоит)
    // 3) поэтому мы берём абсолютное значение от -1
    //    и получаем 1. А 1-1=0, что и есть анимация ходьбы
    //    НО т.к. нам не нужна анимация, то строчкой выше
    //    мы постоянно делаем текущий кадр НУЛЕВЫМ (берём первый кадр)

    // примечание:
    // Можно взять первый кадр и из другой анимации.
    // Например, для nomerPosl=-2:
    // abs(-2)=2
    // 2-1=1
    // значит из первой последовательности (атака)
    // всё время будет показывается первый (НУЛЕВОЙ) кадр
    
  end
   else

  nomerPosledovatelnosti:=nomerPosl; // Номер последовательности


 // Если номер кадра перевалил за допустимые пределы
 if Obyekti[nomerObj].TekushKadr>length(Rassa[m].Opisan[n].posledovatelnost[nomerPosledovatelnosti].kadr)-1
  then
   if nomerPosl<>2 then Obyekti[nomerObj].TekushKadr:=0 // для кадра ПАДЕНИЯ не нужно продолжать анимацию
    else Obyekti[nomerObj].TekushKadr:=length(Rassa[m].Opisan[n].posledovatelnost[nomerPosledovatelnosti].kadr)-1; // поэтому для падения ставим ПОСЛЕДНИЙ КАДР

 zerkalno:=false; // пока что будем считать, что не зеркально

 tempAngle:=Obyekti[nomerObj].phi-90; // так как спрайты повёрнуты относительно нашей системы отсчёта, пришлось ввести корректировку на 90 градусов

 if tempAngle<0 then tempAngle:=360+tempAngle; // крайние значения

 kolonka:=round( tempAngle ) div 45 + 1; // определяем номер колонки (45 взялось оттуда, что спрайты у нас нарисованы дискретно - с углом поворота в 45 градусов)

 // ЕСЛИ КОЛОНКА БОЛЬШЕ ПЯТИ (а такой у нас нет), ТО ТУТ-ТО КАК РАЗ И ДЕЛАЕМ ЗЕРКАЛЬНОЕ ОТОБРАЖЕНИЕ
 if kolonka>5 then kolonka:=5-(kolonka-5) else zerkalno:=true;


 // Перетаскиваем размеры:
 XSize:=Rassa[m].Opisan[n].XSize;
 YSize:=Rassa[m].Opisan[n].YSize;
 sprX:=Rassa[m].Opisan[n].sprX;
 sprY:=Rassa[m].Opisan[n].sprY;

 // Загоняем в OpenGL нужную текстуру
 glBindTexture(GL_TEXTURE_2D,Rassa[m].Opisan[n].spritesTex[Rassa[m].Opisan[n].posledovatelnost[nomerPosledovatelnosti].texturnum]);

 // Округляем значение кадра (получаем дискретное значение)
 kadr:=round(Obyekti[nomerObj].TekushKadr);

 glpushMatrix; // Сохраняем матрицу

 // Перемещаем спрайт таким образом, чтобы координата X,Y оказалась в центре спрайта
 glTranslatef(Obyekti[nomerObj].pos.x-sprX/2, Obyekti[nomerObj].pos.y-sprY/2,-5);

 // Рисуем квадрат со спрайтом
 Kvadrat(XSize,YSize,
         sprX,sprY,
         Rassa[m].Opisan[n].posledovatelnost[nomerPosledovatelnosti].kadr[kadr],
         kolonka,
         zerkalno);

 // Отдаляемся в Z- направлении (в ортогональной проекции это не видно)
 glTranslatef(0,0,0.5);
 // это служит для определения того, ЧТО РИСОВАТЬ НА ПЕРВОМ ПЛАНЕ

 // Примечание:
 //
 // По поводу 2D графики и что рисовать на первом плане
 // читайте про Z - координату в 2-D пространстве X,Y,
 // и как это работает в OpenGL.

 glDisable(GL_TEXTURE_2D); // Отключаем текстуры, нам нужны только цвета
 glLineWidth(3); // Делаем линии потолще

 // Если показываем всякие значки и полоски энергии, то
 if ShowEnerg then begin
  glBegin(GL_LINES);
  glColor3f(1,0,0);glVertex2f(0,0+sprY);
  glColor3f(1,1,0);glVertex2f(0+Obyekti[nomerObj].energia[0]/20,0+sprY);
  glColor3f(1,1,0);glVertex2f(0+Obyekti[nomerObj].energia[0]/20,0+sprY);
  glColor3f(0,1,0);glVertex2f(0+Obyekti[nomerObj].energia[0]/10,0+sprY);
  // ВЫШЕ ЗАДАВАЛОСЬ ТРИ ЦВЕТА - читайте как работают цвета в OpenGL
  // КРАСНЫЙ 1 0 0
  // ЖЁЛТЫЙ  1 1 0
  // ЗЕЛЁНЫЙ 0 1 0
  glEnd;
 end;

 glLineWidth(1);
 glBegin(GL_LINE_LOOP);
 glColor3f(0,0,1);
 if Obyekti[nomerObj].vibran then // Рисуем квадрат вокруг выбранных ЮНИТОВ
  begin
   glVertex2f(0,0);
   glVertex2f(0,0+sprY);
   glVertex2f(0+sprX,0+sprY);
   glVertex2f(0+sprX,0);
  end;
 glEnd;

 glEnable(GL_TEXTURE_2D); // Обратно включаем текстуры
 glColor3f(1,1,1);


 glpopMatrix; // Возвращаем матрицу, которую мы выше СОХРАНИЛИ с помощью glPushMatrix


 // Примечание:
 //
 // Смысл glPushMatrix и glPopMatrix следующий:
 //
 // ЕСЛИ СДЕЛАТЬ
 //
 // glPushMatrix; // С О Х Р А Н Я Е Т
 // glTranslatef(1234,4563,123);
 // glPopMatrix; // В О С С Т А Н А В Л И В А Е Т
 //
 // ТО ЭТО НИКАК НЕ ПОВЛИЯЕТ НА ПРОГРАММУ
 // В ПЛАНЕ ДАЛЬНЕЙШЕГО ПОЛОЖЕНИЯ ИЗОБРАЖЕНИЙ НА ЭКРАНЕ
 //
 // Поэтому это удобно использовать для того, если
 // вы делали какие-нибудь нужные преобразоывния
 // glTranslatef/glRotatef, а затем вам нужно
 // много раз сделать какие-нибудь перемещения/повороты
 // относительно сохранённой позиции
 //
 // ...PUSH... - сохраняет состояние
 // ...POP... - восстанавливает состояние


// Наращиваем номер кадра (здесь лучше использовать число,
// основанное на текущем FPS, чем константу 0.1)
 Obyekti[nomerObj].TekushKadr:=Obyekti[nomerObj].TekushKadr+0.1;

end; 

end;

// Загрузка - очень просто
procedure LoadMapTexture;
begin
 LoadTexture('.\maps\summer2.bmp',MapTexture);
end;


// Рендеринг карты - всё просто
procedure RenderKarta;
var i,j:integer;
begin

 glBindTexture(GL_TEXTURE_2D,mapTexture);
for i:=-10 to 10 do
 for j:=-10 to 10 do
  begin
   glPushMatrix;
   glTranslatef(i*32,j*32,0);
   Kvadrat(512, 256, 32, 32, 5,1,false);
   glPopMatrix;
  end;

end;


// Рендеринг всех объектов - очень просто
procedure RenderObjects;
var i:integer;
    m,n:integer;
begin

 for i:=0 to length(Obyekti)-1 do
  begin
   m:=Obyekti[i].nomRas;
   n:=Obyekti[i].nomTip;

   if Obyekti[i].energia[0]>0 then
    begin
     SuperKvadrat(i,Obyekti[i].TekushPosl);
    end
     else
     SuperKvadrat(i,2);

  end;



end;

// Это я тоже придумал когда делал 3d движок.
// ФУНКЦИЯ CENTURUS - это уникальнейшая вещь
// с помощью неё можно сделать "толкающиеся", "скользящие" объекты
// функция возвращает BOOLEAN: было ли касание двух окружностей
// center1,2 - центы двух окружностей
// radius1,2 - их радиусы
// tip1,2 - типы объектов
//       Centurus( центры окружностей         ; радиусы              ;  типы объектов )
function Centurus(var center1,center2:TVector2;radius1,radius2:single;tip1,tip2:integer):boolean;
var c1,c2,e,napr:TVector2; // вспомогательные переменные
    dlina,movi:single;     //
begin

c1.x:=center1.x; // перегоняем во временную переменную
c1.y:=center1.y;

c2.x:=center2.x; // тоже и для второй точки
c2.y:=center2.y;

e.x:=(c1.x-c2.x); // определяем вектор, соединяющий точки C1 и C2
e.y:=(c1.y-c2.y);

dlina:=sqrt(e.x*e.x+e.y*e.y); // определяем длину вектора (отрезка между C1 и С2)

napr:=normaliz2(e); // определяем единичный вектор направления

if dlina<radius1+radius2 then // если окружности наезжают друг на друга, то
 begin

  movi:=radius1+radius2-dlina; // определяем насколько окружности наехали друг на друга

  c1.x:=c1.x+napr.x*movi/2; // перемещаем центр одной окружности на половину MOVI
  c1.y:=c1.y+napr.y*movi/2;

  c2.x:=c2.x-napr.x*movi/2; // А ЦЕНТР ВТОРОЙ - в противоположную сторону (знак минус)
  c2.y:=c2.y-napr.y*movi/2;

  result:=true; // ЕСТЬ столкновение (true)

 end else result:=false; // НЕТ столкновения (false)


 // для первой окружности
 if tip1>0 then begin
  center1.x:=c1.x;
  center1.y:=c1.y;
  end;

 // для второй
 if tip2>0 then begin
  center2.x:=c2.x;
  center2.y:=c2.y;
  end;

end;


// Процедура перемещения в некоторую точку пространства
// i - НОМЕР ЮНИТА
// x,y - КУДА ЭТОТ ЮНИТ ДОЛЖЕН ИДТИ
procedure IdtiVpoziciu(i:integer;x,y:single);
var fff,x1,y1:single;
m,n:integer;
begin

    m:=Obyekti[i].nomRas;
    n:=Obyekti[i].nomTip;

     // находим вектор между начальной и конечной точкой
    x:=x-Obyekti[i].pos.x;
    y:=y-Obyekti[i].pos.y;

    // находим длину вектора
    fff:=sqrt(x*x+y*y);

    // если уже пришли, то обнуляем мысль
    if fff<rassa[m].Opisan[n].radius then Obyekti[i].misl1:='';

    if fff>0 then
     begin
      x:=x/fff;
      y:=y/fff;
     end;

    // Поварачиваем единичный вектор на угол PHI
    x1:=1*cos(DegToRad(Obyekti[i].phi));
    y1:=1*sin(DegToRad(Obyekti[i].phi));

    // НАХОДИМ УГОЛ МЕЖДУ ВЕКТОРОМ ТЕКУЩЕГО НАПРАВЛЕНИЯ (x1,y1)
    // и вектором нужного направления (x,y)
    fff:=x*x1+y*y1;

    fff:=arccos(fff);

    fff:=RadToDeg(fff); // найденный угол переводим в градусы

    // Если угол существенный - более 5, то
    if fff>5 then
      Obyekti[i].phi:=Obyekti[i].phi+5; // начинаем поворачивать юнит


    // Примечание:
    // Рано или поздно этот юнит из-за
    // кручения по 5 градусов найдёт правильное
    // направление (режим "поиска");


    fff:=DegToRad(Obyekti[i].phi); // Переводим угол в радианы

    // Перемещаем ЮНИТ в направлении угла FFF

    Obyekti[i].pos.x:=Obyekti[i].pos.x+1*cos(fff);
    Obyekti[i].pos.y:=Obyekti[i].pos.y+1*sin(fff);



end;

// Процедура искуственного интеллекта
// на входе - playerNum
// номер игрока, которым урпавляет AI (искуственный интеллект)
procedure Intellekt(playerNum:integer);
var i,j,k:integer;

    FoundBaza:integer;     // БАЗА ЕСТЬ?
    FoundKrest:integer;    // КРЕСТЬЯНИН ЕСТЬ?
    FoundDobicha:integer;  // КТО-НИБУДЬ ДОБЫВАЕТ ЗОЛОТО?
    FoundFree:integer;     // ЕСТЬ СВОБОДНЫЕ КРЕСТЬЯНЕ?

    FoundZolotnik:integer; // ЗОЛОТНИК ПОБЛИЗОСТИ ЕСТЬ?

    misl,params:string;    // МЫСЛЬ и ЕЁ параметры

    FreeArray:array of integer; // МАССИВ с индексами свободных крестьян

    FoundAll:integer; // СКОЛЬКО ВСЕГО КРЕСТЬЯН?

    FoundVrag:integer; // ВРАГА НАШЛИ? КАКОЙ У НЕГО ИНДЕКС?


begin

 SetLength(FreeArray,length(Obyekti)); // для надёжности берём по максимуму

 // СНАЧАЛА МЫ НИЧЕГО НЕ НАШЛИ, ПОЭТОМУ нули И минус единицы:
    FoundBaza:=-1;
    FoundKrest:=-1;
    FoundDobicha:=0;

    FoundFree:=0;
    FoundAll:=0;

    FoundVrag:=-1;

  // Просматриваем ВСЕ юниты:
 for i:=0 to length(Obyekti)-1 do
  begin

   misl:=   StringWordGet(Obyekti[i].misl1,' ',1);
   params:= StringWordGet(Obyekti[i].misl1,' ',2);

  if Obyekti[i].nomDru<>555 then // золотники 555 не смотрим
  if Obyekti[i].energia[0]>0 then 
  begin
   if (Obyekti[i].nomDru=playerNum) then // смотрим только своих (НОМЕР ДРУЖБЫ СОВПАДАЕТ)
    begin
     if (Obyekti[i].nomTip=1) then FoundBaza:=i; // Нашли свою базу
     if (Obyekti[i].nomTip=0) then FoundKrest:=i; // Нашли своего крестьянина
     if (Obyekti[i].nomTip=0) then inc(FoundAll);  // Увеличиваем счётчик найденных крестьян
     if (Obyekti[i].nomTip=0) and (misl='dobicha') then inc(FoundDobicha); // Увеличиваем счётчик крестьян, найденных в золотнике
     if (Obyekti[i].nomTip=0) and (misl='') then
      begin
       FreeArray[FoundFree]:=i; // Эти крестьяне ничем не заняты
       inc(FoundFree);
      end;
    end else FoundVrag:=i; // Нашли ВРАГА! И записали его номер
  end;


  end;


// Строительство НОВОЙ БАЗЫ:
 if FoundBaza<0 then // ЕСЛИ не нашли базу
  if FoundKrest>=0 then  // И есть ХОТЯ БЫ один крестьянин, то
   begin
    // задаём этому крестьянину мысль о строительстве базы
                        Obyekti[FoundKrest].MISL1:='stroyka 1'
                                        +','+intToStr(round(Obyekti[FoundKrest].pos.x+random(25)-random(50)))
                                        +','+intToStr(round(Obyekti[FoundKrest].pos.y+random(25)-random(50)));
                        Obyekti[FoundKrest].MISL2:='';
   end;


// Добыча ЗОЛОТА
 if Igroki[playerNum].Resurs[0]<100 then // Если золота маловато
 if FoundAll<=3 then // И крестьян тоже мало (скорее всего из-за нехватки золота)
 if (FoundDobicha<1) and (FoundFree>0) then // Бросаем на добычу золота СВОБОДНЫХ КРЕСТЬЯН
  begin
         FoundZolotnik:=blizhZolotnik(FreeArray[0]); // Ищем ближайший золотник к ПЕРВОМУ свободному крестьянину
         if FoundZolotnik>-1 then // Если нашли золотник
          begin
           // делаем крестьянину мысль идти за золотом (идти заюнитом с номером ЗОЛОТНИКА), а дальше всё автоматически сработает
           Obyekti[FreeArray[0]].MISL1:='idtiza '+IntToStr(FoundZolotnik);
           Obyekti[FoundKrest].MISL2:='';
          end;
  end;

// Создание новых КРЕСТЬЯН
 if (FoundAll<10) and (FoundBaza>-1) then // если крестьян маловато, но у нас есть база
 begin
// Делаем базе мысль о создании (строительстве) нового КРЕСТЬЯНИНА
  Obyekti[FoundBaza].MISL1:='stroyka 0'
         +','+intToStr(round(Obyekti[FoundBaza].pos.x+random(25)-random(50)))
         +','+intToStr(round(Obyekti[FoundBaza].pos.y+random(25)-random(50)));

 end;

// Нападение на противника
if Igroki[playerNum].Resurs[0]>100 then // Если золото есть
 if (FoundVrag>-1) and (FoundFree>0) then // Если нашли врага и есть свободные крестьяне
  for j:=0 to FoundFree-1 do // ВСЕХ СВОБОДНЫХ РАЗОМ
   begin
    // ВСЕМ свободным делаем мысль ИДТИ ЗА ВРАГОМ (как только дойдут - так сразу всё и начнётся)
    Obyekti[FreeArray[0]].MISL1:='idtiza '+IntToStr(FoundVrag);
    Obyekti[FoundKrest].MISL2:='';
   end;




end;


// Интерпретатор мыслей
procedure InterpretirovatMisli;
var misl   : string;
    params : string;
    i,j:integer;

    a,b,c:string;
    x,y:single;
    x1,y1:single;
    fff:single;

    m,n:integer;
    o,p:integer;

begin

// СМОТРИМ ВСЕ ЮНИТЫ
for i:=0 to length(Obyekti)-1 do
 if obyekti[i].energia[0]>0 then // ЕСЛИ ЭНЕРГИЯ БОЛЬШЕ НУЛЯ
 begin

  // узнаём номер РАССЫ и номер ТИПА ЮНИТА
  m:=Obyekti[i].nomRas;
  n:=Obyekti[i].nomTip;

  // вытягиваем МЫСЛЬ и её ПАРАМЕТРЫ
  misl:=   StringWordGet(Obyekti[i].misl1,' ',1);
  params:= StringWordGet(Obyekti[i].misl1,' ',2);

  // корректируем углы
  if Obyekti[i].phi>360 then Obyekti[i].phi:=1;
  if Obyekti[i].phi<0 then Obyekti[i].phi:=359;

  // Если мыслей нет - значит ЮНИТ стоит НА МЕСТЕ
  if misl='' then Obyekti[i].TekushPosl:=-1;
  // для юнитов, которые стоят на месте,
  // устанавливаем номер последовательности -1
  //


  // Если ГЛАВНАЯ мысль отсутствует, но ЕСТЬ ВТОРОСТЕПЕННАЯ, то
  if (Obyekti[i].MISL1='') and (Obyekti[i].MISL2<>'') then
   begin
    Obyekti[i].MISL1:=Obyekti[i].MISL2; // ДЕЛАЕМ ВТОРОСТЕПЕННУЮ ГЛАВНОЙ
    Obyekti[i].MISL2:=''; // обнуляем второстепенную
   end;


  // Если МЫСЛИ ЕСТЬ, а ВОЗМОЖНОСТЕЙ НЕТ, то ОБНУЛЯЕМ ТАКИЕ МЫСЛИ: 
  if (misl='idti') and (length(rassa[m].Opisan[n].skorost)=0) then misl:='';
  if (misl='idtiza') and (length(rassa[m].Opisan[n].skorost)=0) then misl:='';
  if (misl='atakovat') and (length(rassa[m].Opisan[n].udar)=0) then misl:='';
  if (misl='stroyka') and (length(rassa[m].Opisan[n].stroyka)=0) then misl:='';
  if (misl='dobicha') and (length(rassa[m].Opisan[n].dobicha)=0) then misl:='';

  // Мысли ИДТИ
  if misl='idti' then
   begin
    Obyekti[i].TekushPosl:=0; // просто идёт
    if Obyekti[i].resurs[0]>0 then // значит с золотом идёт
     Obyekti[i].TekushPosl:=3;

    a:=StringWordGet(params,',',1);
    b:=StringWordGet(params,',',2);

    x:=StrToInt(a); // куда идти?
    y:=StrToInt(b);

    IdtiVpoziciu(i,x,y); // вызываем процедуру передвижения
   end;

  // Мысли ИДТИ ЗА
  if misl='idtiza' then
   begin
    Obyekti[i].TekushPosl:=0;
    if Obyekti[i].resurs[0]>0 then
     Obyekti[i].TekushPosl:=3;    

    j:=StrToInt(params); // за кем идти?

    o:=Obyekti[i].nomRas;
    p:=Obyekti[i].nomTip;

    IdtiVpoziciu(i,Obyekti[j].pos.x,Obyekti[j].pos.y); // вызываем процедуру передвижения
   end;

  // Мысли АТАКОВАТЬ
  if misl='atakovat' then
   begin
    j:=StrToInt(params); // Кого атаковать?

    Obyekti[i].TekushPosl:=1; // Выбираем анимацию  АТАКИ (=1)

    // Начинаем уменьшать энергию у цели (цель имеет номер j - кого атаковать)
    Obyekti[j].energia[0]:=Obyekti[j].energia[0]-
                           Rassa[m].Opisan[n].udar[Obyekti[i].TipAtaki].sila;

    // Делаем у цели ответную мысль атаковать НАС
    Obyekti[j].MISL2:=Obyekti[j].MISL1;
    Obyekti[j].MISL1:='atakovat '+intToStr(i);


    // Нет энергии - нету мыслей:
    if Obyekti[j].energia[0]<=0 then Obyekti[i].MISL1:='';

   end;

  // Мысль СТРОЙКА
  if misl='stroyka' then
   begin
    Obyekti[i].TekushPosl:=1;
    
    a:=StringWordGet(params,',',1); // что строим
    b:=StringWordGet(params,',',2); // где строим (x)
    c:=StringWordGet(params,',',3); // где строим (y)

    // Переводим из текста в числа:
    x:=StrToInt(b);
    y:=StrToInt(c);

    // Есть ли у нас золото?
    if Igroki[Obyekti[i].nomDru].Resurs[0]>0 then // Если есть, то
     begin
      // УВЕЛИЧИВАЕМ ПРОГРЕСС МЫСЛИ О СТРОИТЕЛЬСТВЕ
      Obyekti[i].MislPROGRESS:=Obyekti[i].MislPROGRESS+1;

      // УМЕНЬШАЕМ ДЕНЬГИ ИГРОКА, У КОТОРОГО ЮНИТ ЧТО-ТО СТРОИТ
      Igroki[Obyekti[i].nomDru].Resurs[0]:=Igroki[Obyekti[i].nomDru].Resurs[0]-1;
     end;

    //Строительство завершено?
    if (Obyekti[i].MISLPROGRESS>=Rassa[m].Opisan[StrToInt(a)].cena[0].kolvo) then
     begin
      Obyekti[i].MISLPROGRESS:=0;
      Obyekti[i].MISL1:=''; // раз строительство завершено, УБИРАЕМ МЫСЛЬ о строительстве


     // Описание - NewObyekt(nomRas, nomTip, nomDru:integer;x,y,phi:single);

      NewObyekt(m,
                StrToInt(a),
                Obyekti[i].nomDru,
                x,
                y,
                0);
     end;


   end;

  // Мысль ДОБЫЧА РЕСУРСОВ
  if misl='dobicha' then
   begin
    Obyekti[i].TekushPosl:=555; // Прячем игрока

    j:=StrToInt(params); // определяем номер юнита ЗОЛОТНИК

   // Если в золотнике что-то есть, до идёт процесс ДОБЫЧИ 
   if Obyekti[j].resurs[0]>0 then
    begin
     Obyekti[j].resurs[0]:=Obyekti[j].resurs[0]-0.1;
     Obyekti[i].resurs[0]:=Obyekti[i].resurs[0]+0.1;
    end;
    
   // ЕСЛИ МЕШОК уже ЗАПОЛНЕН ДО предела, то
    if Obyekti[i].resurs[0]>=rassa[m].Opisan[n].dobicha[0].kolvo then
     begin
      // Мысль о добыче делаем второстепенной
      Obyekti[i].MISL1:=Obyekti[i].MISL2;
      // А главная мысль теперь - ИДТИ НА БАЗУ вместе с золотом
      Obyekti[i].MISL2:='idtiza '+params;
     end;

   end;

  end;

end;

// Процедура для вывода анимированного курсора
// (выводит курсоры двух типов - tip=0 и tip=1)
procedure Kursor(tip:integer;dx:single);
var i:integer;
begin
glDisable(GL_TEXTURE_2D);
case tip of
1:
begin
       glRotatef(gettickcount/10,0,0,1);
       glColor3f(1,0,0);
       glBegin(GL_LINES);
       glVertex3f(-dx/6,-dx/6,0);
       glVertex3f(-dx/2,-dx/2,0);
       glVertex3f(+dx/6,dx/6,0);
       glVertex3f(+dx/2,+dx/2,0);

       glVertex3f(+dx/6,-dx/6,0);
       glVertex3f(+dx/2,-dx/2,0);

       glVertex3f(-dx/6,+dx/6,0);
       glVertex3f(-dx/2,+dx/2,0);
       glEnd;
   end;
0: begin

       glRotatef(gettickcount/10,0,0,1);
       glColor3f(0,1,0);
       glBegin(GL_LINES);
       for i:=0 to 20 do
       glVertex3f((dx/2+0.1*dx*sin(gettickcount/500))*sin((360/20)*i*3.14/180),
                  (dx/2+0.1*dx*sin(gettickcount/500))*cos((360/20)*i*3.14/180),0);
       glEnd;

   end;
end;

glEnable(GL_TEXTURE_2D);

end;

// Проверка, есть ли под курсором юнит (ЕСЛИ ЕСТЬ - возвращает TRUE)
function podkursorom(i:integer;kursx,kursy:single):boolean;
var a,b,fff,ppp:single;
begin
    a:=KursX-Obyekti[i].pos.x;
    b:=KursY-Obyekti[i].pos.y;
    fff:=sqrt(a*a+b*b);
    ppp:=Rassa[Obyekti[i].nomRas].Opisan[Obyekti[i].nomTip].radius;

    if fff<ppp then result:=true else result:=false;

end;

// Нужно ли догонять?
procedure NujnoDogonyat(i,j:integer);
var misl,params:string;
begin

  misl:=   StringWordGet(Obyekti[i].misl1,' ',1);
  params:= StringWordGet(Obyekti[i].misl1,' ',2);

if misl='atakovat' then  // Если мысль АТАКОВАТЬ, то нужно догонять (idtiza)
 if StrToInt(params)=j then
 begin
  Obyekti[i].misl2:=Obyekti[i].misl1;
  Obyekti[i].MISL1:='idtiza '+params;
 end;


end;


// Процедура выдаёт номер ближайшей к объекту OBJNUM базу
function BlizhBaza(objnum:integer):integer;
var x,y,sss,rasst:single;
var i,j,m,n:integer;
begin

j:=-1;
rasst:=1000000;

for i:=0 to length(Obyekti)-1 do
  if (Obyekti[i].nomTip=1) and (Obyekti[i].nomDru=Obyekti[objNum].nomDru)
   then
    begin
     x:=Obyekti[i].pos.x-Obyekti[objNum].pos.x;
     y:=Obyekti[i].pos.y-Obyekti[objNum].pos.y;
     sss:=x*x+y*y;
     if sss<rasst then
      begin
       j:=i;
       rasst:=sss;
      end;
    end;

result:=j;

end;


// Процедура выдаёт номер ближайшего к юниту OBJNUM золотника
function BlizhZolotnik(objnum:integer):integer;
var x,y,sss,rasst:single;
var i,j,m,n:integer;
begin

j:=-1;
rasst:=1000000;

for i:=0 to length(Obyekti)-1 do
  if (Obyekti[i].nomDru=555)
   then
    begin
     x:=Obyekti[i].pos.x-Obyekti[objNum].pos.x;
     y:=Obyekti[i].pos.y-Obyekti[objNum].pos.y;
     sss:=x*x+y*y;
     if sss<rasst then
      begin
       j:=i;
       rasst:=sss;
      end;
    end;

result:=j;

end;


// Столкновение между юнитами I - J
procedure Stolknulsa(i,j:integer);
var misl,params:string;
var BlizhBazaNum:integer;
begin

  misl:=   StringWordGet(Obyekti[i].misl1,' ',1);
  params:= StringWordGet(Obyekti[i].misl1,' ',2);

if misl='idtiza' then  // Если шёл за кем-нибудь/чем-нибудь, то
 if StrToInt(params)=j then
  begin
   Obyekti[i].misl1:=Obyekti[i].misl2; // идти уже не нужно, сделаем второстепенную мысль главной
   Obyekti[i].misl2:='';

   // СДАЧА ЗОЛОТА НА БАЗУ
   if (Obyekti[j].nomTip=1) and (Obyekti[i].nomDru=Obyekti[j].nomDru) then
    begin
     Igroki[Obyekti[j].nomDru].Resurs[0]:=Igroki[Obyekti[j].nomDru].Resurs[0]+Obyekti[i].resurs[0];
     Obyekti[i].resurs[0]:=0; // у самого юнита золота не осталось (после сдачи на базу)
    end;

  end;


  // new
  misl:=   StringWordGet(Obyekti[i].misl1,' ',1);
  params:= StringWordGet(Obyekti[i].misl1,' ',2);

  // Если мысль пустая (нулевая)
if misl='' then
 if Obyekti[i].nomDru<>Obyekti[j].nomDru then
  if not Rassa[Obyekti[j].nomRas].Opisan[Obyekti[j].nomTip].resurs then
  begin
   Obyekti[i].misl1:='atakovat '+IntToStr(j); // Если это не РЕСУРС, то атакуем
   Obyekti[i].TipAtaki:=0;
  end
   else
  if Obyekti[i].resurs[0]=0 then
  begin
   Obyekti[i].misl1:='dobicha '+IntToStr(j); // Если это золотник, то добываем
   BlizhBazaNum:=BlizhBaza(i);
   if BlizhBazaNum>-1 then
    Obyekti[i].misl2:='idtiza '+IntToStr(BlizhBazaNum); // Заодно второстепенную мысль делаем - ВОЗВРАЩЕНИЕ НА БАЗУ
  end;

// Примечание:
//
// автоматическая добыча золота основана на
// ГЛАВНОЙ и ВТОРОСТЕПЕННОЙ мыслях
//
// В то время, как ЮНИТ занят DOBICHA номер_золотника,
// у него есть второстепенная мысль IDTIZA номер_базы.
//
// Здесь все номера - это номера ЮНИТОВ (и золотник, и база - всё это юниты)
//
// Как только мешок наполнился, главная мысль ПЕРЕСТАЁТ БЫТЬ ГЛАВНОЙ
// и на её место приходит ВТОРОСТЕПЕННАЯ.

end;



end.

