<Plain DOS file in RUSSIAN language>
Декабрь 1998г
-------------------------------------------------------------------------------
                     "KRYPTON" - Криптографическая система.

                    Краткая документация к версии 1.3.xx БЕТА. 
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
1 - КРАТКАЯ ИНФОРМАЦИЯ О ПРОГРАММЕ
-----------------------------------------------------------------------------

 KRYPTON - Система шифрования файлов.

 ПРИМЕЧАНИЯ:
 1) При применении Кодовых Книг (keybook) их файлы должны быть доступны для
    записи, т.к. программа вносит в них служебные данные 
    для предотвращения двух и более кратного примения одинаковых ключей.
 2) Во всех функциях шифрования (a,akw,apw,...) допустимо применение
    неявных имен файлов (*.exe,?der??.b??,*.*)
    Для функций расшифровки это недопустимо - обязательны полные имена
    файлов с расширением. Для извлечения ВСЕХ файлов - не передавайте
    этот параметр программе.(Например: krypton ekw myenc.enc)
  
 Описание параметров коммандной строки:

 Для запуска оболочки не передавайте ни ках параметров.
 Для получения подсказки и выяснения регистрационной принадлежности
 запустите программу с параметром ?

 krypton a myenc file1.txt file2.zz file3
 Комманда шифрует файлы 'file1.txt', 'file2.zz' и 'file3'
 обычным методом (OTP) в файлы 'myenc.enc' и 'myenc.key'
 (Файлы данных и ключа - оба практически одинаково защищены, но в '.enc'
  файле находятся еще и координатно-именные незашифрованные данные.)

 krypton akb myenc mykb10 file1.txt file2.zz file3
  Тоже самое, но по методу Кодовая Книга с использованием спецфайла
  'mykb10.kyb', который уже должен быть в этой-же директории.
  По окончании шифрования программа выведет число "Key ID#"
  без которого расшифровка невозможна. (Позиционный номер ключа)

 krypton gkb curkb
  Эта команда генерирует новую кодовую книгу 'curkb.kyb'.
  Программа запросит длину одного ключа и их общее количество.

 krypton e myenc
  Эта команда расшифрует все файлы из шифровки (OTP) 'myenc.enc'
  по ключу 'myenc.key'. Следующими параметрами могут быть конкретные
  имена файлов.

 krypton ekb myenc smbook raritet.com
  Команда извлекает файл 'raritet.com' из шифровки 'myenc.enc' созданной по
  методу Кодовой Книги на базе спецфайла 'smbook.kyb'. Перед расшифровкой
  программа запросит номер ключа "Key ID#".
  
 krypton mkb badbook
  Комманда модификации служебной информации кодовой книги 'badbook.kyb'.
  Используйте с осторожностью! Никогда не обновляйте кодовую книгу
  "перемоткой" счетчиков - шифровки на базе одинаковых ключей гораздо
  проще расшифровать!

 krypton l myenc
  Команда для просмотра содержимого шифровки 'myenc.enc'

 krypton l unknown xfile.12
  Команда проверки на наличие файла в шифровке. Внимание! С этой командой
  программа проверяет только ОДНО имя файла! (Один параметр коммандной строки)
  Для '.bat' файлов: Программа возвращает 0 при обнаружении файла и 1 при его
  отсутствии.

 krypton akw myenc file1.txt file2.zz file3
  Комманда шифровки по методу ГДМП в файл 'myenc.enc'.

 krypton ekw myenc raritet.com
  Комманда расшифровки по методу ГДМП из файла 'myenc.enc'.

 Краткая информация об используемых методах шифрования:

 OTP - One-Time-Pad - Одноразовый Блокнот
 Простая схема шифрования с ключем имеющим длину исходного файла.
 Ключ, имеющий околослучайный характер, накладывается на исходный
 файл и результат записывается. По одиночке, ключ и результат практически
 неуязвимы.

 ГДМП - Комплексный метод, позволяющий преобразовывать файл в
 околослучайную последовательность данных.

 Внимание: Минимальная длина кодовой фразы ограничена двумя символами.
           Для условно-бесплатной версии максимальная длина - четыре символа.
           Для регистрированной - семдесят восемь символов.

 Рейтинг методов:
 * OTP
 * DDRND (ГДМП) - проходит тестирование - Возможно сильнее чем OTP.
 * KeyBook - Не рекомендуется к применению - метод будет изменен в
             финальной версии.

-----------------------------------------------------------------------------
2 - РЕГИСТРАЦИЯ:
-----------------------------------------------------------------------------

 Регистрация официально закрепляет за вами право использования программы.
 + Скидки на последующие основные версии (если будут).
 + Снятие ограничения на длину пароля (до 78 символов) в ГДМП шифровании.

 Цена для частных лиц - 16$
 Цена для юридических лиц - 160$ начальная + 11$ за каждый PC на котором
                            будет использоваться программа.

 qregistr.exe (DOS) - программа регистрирующая KRYPTON.

 Для регистрации, упомянутая сумма должна быть выслана вместе с
 регформой (ниже) по этому адресу:

 "Куда: МОСКВА 125422,
  Кому: Владимиру В. Сунгоркину - до востребования"

 Также вы можете выслать копию регформы на этот E-MAIL:
 overmaster@geocities.com

 После получения письма (около месяца) на указанный вами E-MAIL будет выслана
 регистрационная информация.

<== РЕГФОРМА - со следующей строки... ==>
ZX-0023-01
Registration form for KRYPTON 1.3 (DOS)

Имя на которое регистрировать(обязательно):
__________________________________________________________

Страна__________________________ Город_______________________________________

E-MAIL(обязательно)__________________________________________________________

Откуда вы получили KRYPTON?(не обязательно)__________________________________

Дата дд/мм/гггг [    /    /    ]

--------- Заполняется автором ---------------

DATE [     /     /     ]              SIGN______________

SIC:___________________________________________________________

S/N:___________________________________________________________

NOTES:

<== РЕГФОРМА - ...до этой строки ==>

-----------------------------------------------------------------------------
3 - POSSIBLE Q&A:
-----------------------------------------------------------------------------

Q: Why don't WINDOWS but DOS?
A: Cause i'd like it more... or, possible, programming in it better...
   or (possible) i'm nearly 100% sure that it's work there! ;-)

Q: Is there some kind of data integrity checks?
A: No. KRYPTON protects data from being readed in it original form, but
   not from modifying it! If after receiving & decrypting file you get a
   scratch from some place in it, it's very possible that this file was
   tampered with.

Q(Obsolete): I'm see RAR archiver - how nice shell it have! Why don't you
   include something like it in krypton?
A: I'm think it's not needed - one time i'm even include it, completed it
   for about 70%, but then scrap. Why (i'm think) someone can need shell?
   Nowdays, not much people works with DOS (thankly to Win95), but thouse
   whose works - knows how to handle it. They definitly use some kind of
   shell, possible even best of them - Norton Commander - so there is no need
   to include any shell in KRYPTON. The main purpose of shell - to easily
   work with files - already maked well by NC! Such thinks maked KRYPTON
   looks how it's looks now - i.e. without any shell. Others - Win95 users -
   buy 'NC for Win95' or don't buy! (I'm not - DOS & NC already works well!) 
A2: Or, in two MAIN words: I'm LAZY. (Not simply lazy, but really LAZY!)

Q: (From hackers) Why this program have such simple registration protection?
A: If some program worth to be cracked - it will be cracked.
   I'm never seen any program that's be able to override this rule. So, why
   then i'm need to include sophisticated protection? Currently, it protects
   only from persons with minimal (by my opinion) hacking abilities -
   from businessmans, kids whom-think-that-they-a-great-hackers, and so on.
   Anyone other can cheat registration easily.
   Anyway, if this program worth hacking - that's a very good sign! ;-)
   And if i'm found it hacked somewhere - it's a VERY GOOD sign! But if i'm
   found someone who hacking my program...  8-)

-----------------------------------------------------------------------------
4 - KNOWN POSSIBLE PROBLEMS:
-----------------------------------------------------------------------------

1 - Do not even try to generate a huge keybook file ( >2gigabytes )!
    KRYPTON cannot work with internal counters, and files aren't generated.
    NOTE: This is not bug, and it cannot be corrected anyhow - 2gb is limit
          which is declared by 'long' variable size, and FAT16. I'm don't
          include any limiters in keybook generation - so be careful not
          to get out of this limit, it's can be dangerous for data on HD.

-=BETA NOTES (KNOWN BUGS)=-

Shell: * Changing drive to floppy without diskette resulting to undeterminate
         result. (Depends on handler) Most possibly quit.
       *

-----------------------------------------------------------------------------
5 - LEGAL:
-----------------------------------------------------------------------------

ALL RIGHTS NOT EXPRESSLY GRANTED HERE ARE RESERVED BY VLADIMIR SOUNGORKINE

ALL COPYRIGHTS TO SOFTWARE ARE EXCLUSIVELY OWNED BY THE AUTHOR -
VLADIMIR SOUNGORKINE

THIS SOFTWARE IS PROVIDED "AS IS". THE AUTOR WILL NOT BE LIABLE FOR ANY
KIND OF LOSS OR DAMAGE ARISING OUT OF THE USE, ABUSE OR THE INABILITY TO USE
THIS SOFTWARE. USE IT AT YOUR OWN RISK!

THIS SOFTWARE COMES WITHOUT ANY KIND OF WARRANTY, EITHER EXPRESSED OR
IMPLIED, INCLUDING, BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.

IF YOU DON'T AGREE WITH THIS TERMS OR IF YOUR JURISTDICTION DOES NOT ALLOW
THE EXCLUSION OF WARRANTY AND LIABILITY AS STATED ABOVE YOU ARE NOT ALLOWED
TO USE THIS SOFTWARE AT ALL.

ONCE REGISTERED, the user is granted a non-exclusive
   license to use KRYPTON on one computer (i.e. a single motherboard),
   for any legal purpose, at a time.  The registered KRYPTON
   software may not be rented or leased, but may be
   permanently transferred, if the person receiving it agrees
   to terms of this license.  If the software is an update,
   the transfer must include the update and all previous
   versions.

THIS SOFTWARE IS SHAREWARE. NON-EXCLUSIVE LICENSE TO USE THIS SOFTWARE IN
ITS UNMODIFIED FORM FOR ANY LEGAL PURPOSE HEREBY GRANTED FOR 30 DAYS TRIAL
PERIOD (BEGINNING FROM DATE OF FIRST INSTALLATION OF THIS SOFTWARE). AFTER
EXPIRING OF THAT PERIOD, ONLY REGISTERED USERS ALLOWED TO USE THIS SOFTWARE
ON THE SAME LICENSE BASIS, AS STATED IN THIS TERMS. IF SOFTWARE REMAINS
UNREGISTERED TO THE END OF TRIAL PERIOD YOU MUST REMOVE IT FROM YOUR COMPUTER.
IF YOU ALREADY SEND REGISTRATION FORM, YOU MUST CEASE TO USE SOFTWARE UNTIL
REGISTRATION INFO WAS RECEIVED AND SOFTWARE REGISTERED VIA INCLUDED
REGISTRATION PROGRAM.

YOU ARE NOT ALLOWED TO USE OTHER METHODS OF REGISTRATION THAN VIA INCLUDED IN
ORIGINAL DISTRIBUTION REGISTRATION PROGRAM AND REGISTRATION INFORMATION
WHICH YOU RECEIVE AFTER PAYMENT OF LICENSE FEES TO COPYRIGHT HOLDER.

YOU ARE NOT ALLOWED TO USE OTHER REGISTRATION INFO THAN BY THOUSE PROVIDED TO
YOU BY COPYRIGHT HOLDER.

THE UNREGISTERED SHAREWARE VERSION OF SOFTWARE MAY BE FREELY DISTRIBUTED,
PROVIDED THE DISTRIBUTION PACKAGE IS NOT MODIFIED. NO PERSON OR COMPANY
MAY CHARGE A FEE FOR THE DISTRIBUTION OF SOFTWARE WITHOUT WRITTEN PERMISSION
FROM THE COPYRIGHT HOLDER. YOU ARE NOT ALLOWED TO REDISTRIBUTE REGISTERED
COPIES OF THE SOFTWARE OR MERE PARTS OF IT.

YOU MAY NOT USE, COPY(EXCEPT FOR YOUR ONE PERSONAL BACKUP COPY),
EMULATE, CLONE, RENT, LEASE, SELL, MODIFY, DECOMPILE, DISASSEMBLE,
OTHERWISE REVERSE ENGINEER, OR TRANSFER THE LICENSED PROGRAM OR ANY SUBSET OF
LICENSED PROGRAM EXCEPT AS PROVIDED FOR IN THIS AGREEMENT. ANY SUCH
UNAUTHORIZED USE SHALL RESULT IN IMMEDIATE AND AUTOMATIC TERMINATION OF THIS
LICENSE AND MAY RESULT IN CRIMINAL AND/OR CIVIL PROSECUTION

ALL BRANDNAMES AND TRADEMARKS ARE PROPERTY OF THEIR RESPECTIVE HOLDERS.

-----------------------------------------------------------------------------
6 - HISTORY:
-----------------------------------------------------------------------------

Version      Date                         Info
  0.7b    3.jun.1998     Initial beta release - nothing more to say...
                         Supports single file OTP.
                         C-source:300+ lines

  0.xxb  __.ju_.1998     There be some versions with NC style shell.
                         But they never went in big world.
                         C-source:about 1400 lines (don't sure)
                         
  0.17b   8.jul.1998     Completly rewrited version:
                         ADDED: Ability to form a multi-file archives,
                         registration,shareware time limiters.
                         REMOVED: Some nasty bugs! ;-)
                         C-source:550+ lines

  1.0    14.jul.1998     Initial commercial release. Also 'l' option added.
                         C-source:600+ lines

  1.1    24.jul.1998     Second commercial release:
                         ADDED: Pass Phrase encoding.
                         CHANGED: Encryption method's maked stronger;
                         so, this version cannot work with 1.0 created
                         encryptions. Sorry. Also changed some internal
                         things, to allow use other file extensions in
                         extraction process.
                         REMOVED: ShareWare internal time limiters!
                         (Previous version have expiration timelimiter)
                         C-source:850+ lines

  1.2    25.aug.1998     Third commercial release - first time WWW publiced.
                         Many minor changes. (Added progress meter, etc.)
                         Very hightly improved encryption for KeyBooks.
                         For Pass Phrase encryption it's changed to DDRND.
                         (I.e. practically rewrited - so new format for all
                         files - and again no more previous versions support.
                         Sorry.)
                         C-source:1200+ lines
                         P.S. Still no one registeres. So bad it?
                         There will be just one next version, then work will
                         be stopped, untill i'm don't have at least 20 reg's.
                         Or, may be, even next version don't be.

  1.21    7.sep.1998     Service Release.
                         Very huge bug detected and removed - you need
                         to re-encrypt all previous encryptions that uses
                         password method.

  1.3.xx xx.nov.1998     Next version. Improved DDRND method, so you need
                         to re-encrypt all previous encryptions that uses
                         password method. But anyway, in previous versions
                         this method was availible only in registered version
                         but i'm still don't receive any registrations - so
                         this doesnt bothers you! ;-) Also added NC (or RAR)
                         style shell and opened password encryption, with
                         limit to 4 chars in password itself. (You may call
                         it 'Priview' - as it noway else limited)
                         "NULL FILE" bug corrected.
                         "epw no params" bug corrected. 
                         C-source: 1800+

-----------------------------------------------------------------------------
7 - FUTURE OF KRYPTON:
-----------------------------------------------------------------------------

Version 1.3 planned to be released in decembre, but may be late - i don't
have time to spend on it - for me it already work's well.
Also unpaid work is slow work.

-----------------------------------------------------------------------------
8 - HOW TO CONTACT:
-----------------------------------------------------------------------------

E-Mail: overmaster@geocities.com

-----------------------------------------------------------------------------
P.S. Доперевожу позже - вместе с финальной версией...
