(* strman.pas -- StrMan string manipulation library

   This file is part of the StrMan string manipulation library.

   Copyright (c) 1999 Aleksey V. Vaneev

   The StrMan library is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 2 of
   the License, or (at your option) any later version.

   The StrMan library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with the StrMan library; see the file COPYING.
   If not, write to the Free Software Foundation, Inc.,
   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

   Aleksey V. Vaneev
   <picoder@sbis.komi.ru>
   http://sbis.komi.ru/picoder
 *)

UNIT _StrMan;

INTERFACE

(*
 * CharReplicate
 * --------------------------------------------------------------------------
 * eng: This function returns a string with Character replicated Count
 *      times.
 * --------------------------------------------------------------------------
 * rus: Данная функция возвращает строку, состоящую из Count повторений
 *      символа Character.
 * --------------------------------------------------------------------------
 * MyString := CharReplicate ('A', 64);
 *)

FUNCTION CharReplicate (Character: Char; Count: Byte): String;

(*
 * StringReplicate
 * --------------------------------------------------------------------------
 * eng: This function returns a string with Source string replicated Count
 *      times.
 * --------------------------------------------------------------------------
 * rus: Данная функция возвращает строку, состоящую из Count повторений
 *      строки Source.
 * --------------------------------------------------------------------------
 * MyString := StringReplicate ('Hi! ', 10);
 *)

FUNCTION StringReplicate (Source: String; Count: Byte): String;

(*
 * CharPos
 * --------------------------------------------------------------------------
 * eng: This function searches for a character CharToFind in a string Source
 *      starting at character Offs (counts from zero). Returns nonzero
 *      position of occurence, or zero if character was not found.
 * --------------------------------------------------------------------------
 * rus: Данная функция ищет символ CharToFind в строке Source, начиная с
 *      символа Offs (счет ведется с нуля). Возвращает ненулевую позицию
 *      в строке, если символ был найден, а если символ не найден -
 *      возвращается нуль.
 * --------------------------------------------------------------------------
 * position := CharPos ('a', 'This is a test string', 0);
 *)

FUNCTION CharPos (CharToFind: Char; Source: String; Offs: Byte): Byte;

(*
 * StringPos
 * --------------------------------------------------------------------------
 * eng: This function searches for a substring StringToFind in a string
 *      Source starting at Offs character (counts from zero). Returns
 *      nonzero position of occurence, or zero if specified substring was
 *      not found.
 * --------------------------------------------------------------------------
 * rus: Данная функция ищет строку StringToFind в строке Source, начиная с
 *      символа Offs (счет ведется с нуля). Возвращает ненулевую позицию
 *      в строке, если строка был найдена, а если не найдена - возвращается
 *      нуль.
 * --------------------------------------------------------------------------
 * position := StringPos ('test', 'This is a test string', 0);
 *)

FUNCTION StringPos (StringToFind: String; Source: String; Offs: Byte): Byte;

(*
 * StringJustifyRight, StringJustifyLeft, StringJustifyCenter
 * --------------------------------------------------------------------------
 * eng: This set of functions can be used to justify string Source to
 *      specified position (right, left or center) and pad it with
 *      characters JustifyChar to form a string of Width length. If length
 *      of Source is larger than the specified Width truncation will take
 *      place.
 * --------------------------------------------------------------------------
 * rus: Данный набор функций может быть использован для выравнивания строки
 *      Source по левому или правому краю, или по центру. Выравнивание
 *      осуществляется с помощью символов JustifyChar. Окончательная строка
 *      будет иметь длину Width. Если длина строки Source больше Width, то
 *      произойдет ее усечение.
 * --------------------------------------------------------------------------
 * OutString := StringJustifyRight ('Item1', 40, '.');
 * OutString := StringJustifyLeft ('Item1', 40, '.');
 * OutString := StringJustifyCenter ('Item1', 40, '.');
 *)

FUNCTION StringJustifyRight (Source: String; Width: Byte; JustifyChar: Char): String;
FUNCTION StringJustifyLeft (Source: String; Width: Byte; JustifyChar: Char): String;
FUNCTION StringJustifyCenter (Source: String; Width: Byte; JustifyChar: Char): String;

(*
 * StringJustifyWrap
 * --------------------------------------------------------------------------
 * eng: This function can be used to expand the string to the requested
 *      Width. Necessary amount of chars JustifyChar is added between the
 *      words of the string which is delimited to words with characters
 *      contained in WordDelimiters string (one or more continuous
 *      delimiting characters in a string is processed as a single
 *      delimiter). If specified Width is less than the length of the
 *      string, the string will not be truncated.
 * --------------------------------------------------------------------------
 * rus: Данная функция может быть использована для расширения строки до
 *      необходимой длины Width. Функция равномерно добавляет необходимое
 *      число символов JustifyChar между словами строки, которая разделена
 *      на слова символами, содержащимися в строке WordDelimiters (несколько
 *      разделительных символов в обрабатываемой строке подряд
 *      обрабатываются как один). Если указанная длина Width меньше, чем
 *      длина самой обрабатываемой строки, строка не будет усечена.
 * --------------------------------------------------------------------------
 * OutString := StringJustifyWrap ('This is a JustifyWrap', 40, ' ', '.');
 *)

FUNCTION StringJustifyWrap (Source: String; Width: Byte; WordDelimiters: String; JustifyChar: Char): String;

(*
 * StringTrimRight, StringTrimLeft, StringTrimAll
 * --------------------------------------------------------------------------
 * eng: This set of functions can be used to remove all unwanted leading or
 *      trailing characters, or both. All unwanted characters specified in
 *      Garbage string. Common use of these functions is a trimming of
 *      space and tab characters before some kind of text parsing.
 * --------------------------------------------------------------------------
 * rus: Данный набор функций может быть использован для удаления всех
 *      нежелательных символов в начале строки, в конце ее или одновременно
 *      и в начале, и в конце нее. Символы, которые необходимо убрать,
 *      указываются в строке Garbage. Обычно данные функции применяют для
 *      удаления символов "пробел" и "таб" перед какой-либо лексической
 *      обработкой текстовых данных.
 * --------------------------------------------------------------------------
 * OutString := StringTrimRight ('   a string for test     ', ' ');
 * OutString := StringTrimLeft ('   a string for test     ', ' ');
 * OutString := StringTrimAll ('   a string for test     ', ' ');
 *)

FUNCTION StringTrimRight (Source: String; Garbage: String): String;
FUNCTION StringTrimLeft (Source: String; Garbage: String): String;
FUNCTION StringTrimAll (Source: String; Garbage: String): String;

(*
 * StringReverse
 * --------------------------------------------------------------------------
 * eng: This function reverses string Source, so that string 'today' will
 *      look 'yadot'.
 * --------------------------------------------------------------------------
 * rus: Данный функция "переворачивает" строку Source так, что, к примеру,
 *      строка 'today' будет выглядеть как 'yadot'.
 * --------------------------------------------------------------------------
 * OutString := StringReverse ('today');
 *)

FUNCTION StringReverse (Source: String): String;

(*
 * StringFromData
 * --------------------------------------------------------------------------
 * eng: This function retrieves a pascal-string from untyped data.
 * --------------------------------------------------------------------------
 * rus: Данная функция извлекает строку из нетипизированных данных.
 * --------------------------------------------------------------------------
 * OutString := StringFromData (MyDataPtr, 255);
 *)

FUNCTION StringFromData (Source: Pointer; Count: Byte): String;

(*
 * StringFromNul
 * --------------------------------------------------------------------------
 * eng: This function retrieves a pascal-string from ASCIIZ string which
 *      ends with 0 character. If length of ASCIIZ string is more than 255
 *      characters truncation will take place.
 * --------------------------------------------------------------------------
 * rus: Функция извлекает строку из ASCIIZ строки, которая заканчивается
 *      символом 0. Если длина ASCIIZ строки больше 255 символов, остальные
 *      символы будут откинуты.
 * --------------------------------------------------------------------------
 * OutString := StringFromNul (StrPtr);
 *)

FUNCTION StringFromNul (Source: Pointer): String;

(*
 * StringCase
 * --------------------------------------------------------------------------
 * eng: This functions recodes string Source using 256-byte table
 *      RecodeTable. Common use for this function is upper- or lowercasing
 *      of strings.
 * --------------------------------------------------------------------------
 * rus: Данная функция перекодирует строку Source, используя 256-байтовую
 *      таблицу RecodeTable. Обычно данная функция необходима при
 *      конвертировании строк в верхний или нижний регистр, а также
 *      при изменении кодировки (например, из cp866 в win1251).
 * --------------------------------------------------------------------------
 * OutString := StringCase ('This is a test', @UpperCase);
 *)

FUNCTION StringCase (Source: String; RecodeTable: Pointer): String;

(*
 * StringExtract
 * --------------------------------------------------------------------------
 * eng: This functions extracts Count-sized substring from a string Source,
 *      starting at offset Offs (counting from zero). If Offs is out of
 *      range, empty string will be returned. If specified Count is larger
 *      than the actual data present, it will be automatically decreased
 *      to correct amount.
 * --------------------------------------------------------------------------
 * rus: Данная функция извлекает подстроку длиной Count символов из строки
 *      Source, начиная с позиции Offs (счет ведется с нуля). Если указанный
 *      Offs оказался вне диапазоа, будет возвращена пустая строка. Если
 *      указан Count больший, чем есть данных на самом деле, он будет
 *      автоматически уменьшен до допустимой величины.
 * --------------------------------------------------------------------------
 * OutString := StringExtract ('This is a test', 0, 4);
 *)

FUNCTION StringExtract (Source: String; Offs: Byte; Count: Byte): String;

(*
 * StringRemove
 * --------------------------------------------------------------------------
 * eng: This functions removes Count characters from string Source starting
 *      at Offs character (counts from zero). If specified Offs is out of
 *      range, no removing will take place.
 * --------------------------------------------------------------------------
 * rus: Данная функция удаляет Count символов из строки Source, начиная с
 *      позиции Offs (счет ведется с нуля). Если указанный Offs вне
 *      диапазона, результат будет равен Source.
 * --------------------------------------------------------------------------
 * OutString := StringRemove ('This is a test', 0, 5);
 *)

FUNCTION StringRemove (Source: String; Offs: Byte; Count: Byte): String;

(*
 * StringInsert
 * --------------------------------------------------------------------------
 * eng: This functions inserts substring SubString to string Source at Offs
 *      character (counts from zero). If specified Offs is out of range,
 *      substring will be appended to the end of the string.
 * --------------------------------------------------------------------------
 * rus: Данная функция вставляет строку SubString в строку Source в позицию
 *      Offs (счет ведется с нуля). Если указанный Offs вне диапазона,
 *      строка будет присоединена.
 * --------------------------------------------------------------------------
 * OutString := StringInsert ('is ', 'This a test', 5);
 *)

FUNCTION StringInsert (SubString: String; Source: String; Offs: Byte): String;

(*
 * StringWordCount, StringWordGet, StringWordPos
 * --------------------------------------------------------------------------
 * eng: This set of functions can be used for extraction of single words (or
 *      tokens) from a string Source delimited with characters contained in
 *      a string WordDelimiters. (If string Source contains places with
 *      several delimiters together they will be processed as a single
 *      delimiter. If string has leading or trailing delimiters they will be
 *      ignored during processing). Functions "Get" and "Pos" also have a
 *      Num parameter (counts from 1) that specifies word that is needed.
 *
 *      StringWordGet returns empty string if specified word number is out
 *      of range.
 *
 *      StringWordPos returns zero if specified word number is out of range.
 * --------------------------------------------------------------------------
 * rus: Данный набор функций может быть использован для извлечения отдельных
 *      слов из строки Source, разделенной на слова символами, содержащимися
 *      в строке WordDelimiters. (В строке Source несколько разделительных
 *      символов подряд при обработке объединяются в один. Если в строке
 *      разделители встречаются в начале и/или в конце нее, они
 *      игнорируются). Функции "Get" и "Pos", кроме этого, имеют параметр
 *      Num (счет ведется с 1), который указывает номер необходимого слова.
 *
 *      Функция StringWordGet возвращает пустую строку, если указанное слово
 *      вне диапазона.
 *
 *      Функция StringWordPos возвращает нуль, если указанное слово вне
 *      диапазона.
 * --------------------------------------------------------------------------
 * WordCount := StringWordCount ('cmd1; comment; execstr', '; ');
 * WordString := StringWordGet ('cmd1; comment; execstr', '; ', 1);
 * WordPosition := StringWordPos ('cmd1; comment; execstr', '; ', 3);
 *)

FUNCTION StringWordCount (Source: String; WordDelimiters: String): Byte;
FUNCTION StringWordGet (Source: String; WordDelimiters: String; Num: Byte): String;
FUNCTION StringWordPos (Source: String; WordDelimiters: String; Num: Byte): Byte;

(*
 * StringMatching
 * --------------------------------------------------------------------------
 * eng: This function can be used to test a string for matching with the
 *      specified pattern. Pattern can contain '?' and '*' characters. '?'
 *      means there can be any character in a string, '*' means there can be
 *      any amount or none of any characters in a string.
 * --------------------------------------------------------------------------
 * rus: Данная функция может быть использована для проверки строки на
 *      соответствие заданной маске. Маска может содержать символы '?' и
 *      '*'. Символ '?' в маске означает, что в этом месте в проверяемой
 *      строке может быть любой символ. Символ '*' в строке означает, что с
 *      этого места в проверяемой строке может быть любое число (или не быть
 *      совсем) любых символов.
 * --------------------------------------------------------------------------
 * Matching := StringMatching ('This is a test', '*is*');
 *)

FUNCTION StringMatching (InString: String; Pattern: String): Boolean;

(* LowerCase
 * --------------------------------------------------------------------------
 * eng: This table can be used to lower case all uppercase letters in a
 *      string. Be cautious - this table also lowers all russian letters
 *      in code page 866. If you don't need that, use LowerCaseEng instead.
 * --------------------------------------------------------------------------
 * rus: Данная таблица может быть использована для перевода всех прописных
 *      букв в строчные. Русские буквы здесь приведены в кодировке cp866.
 *)

CONST
  LowerCase: ARRAY [0..255] OF Byte = (
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
    18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
    34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
    50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 97,
    98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
    111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 91,
    92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105,
    106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118,
    119, 120, 121, 122, 123, 124, 125, 126, 127, 160, 161, 162, 163,
    164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 224,
    225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237,
    238, 239, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170,
    171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183,
    184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196,
    197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209,
    210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222,
    223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235,
    236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248,
    249, 250, 251, 252, 253, 254, 255);

(* UpperCase
 * --------------------------------------------------------------------------
 * eng: This table can be used to upper case all lowercase letters in a
 *      string. Be cautious - this table also uppers all russian letters
 *      in code page 866. If you don't need that, use UpperCaseEng instead.
 * --------------------------------------------------------------------------
 * rus: Данная таблица может быть использована для перевода всех строчных
 *      букв в прописные. Русские буквы здесь приведены в кодировке cp866.
 *)

CONST
  UpperCase: ARRAY [0..255] OF Byte = (
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
    18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
    34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
    50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65,
    66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81,
    82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 65,
    66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81,
    82, 83, 84, 85, 86, 87, 88, 89, 90, 123, 124, 125, 126, 127,
    128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140,
    141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153,
    154, 155, 156, 157, 158, 159, 128, 129, 130, 131, 132, 133, 134,
    135, 136, 137, 138, 139, 140, 141, 142, 143, 176, 177, 178, 179,
    180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192,
    193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205,
    206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218,
    219, 220, 221, 222, 223, 144, 145, 146, 147, 148, 149, 150, 151,
    152, 153, 154, 155, 156, 157, 158, 159, 240, 241, 242, 243, 244,
    245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255);

(* LowerCaseEng
 * --------------------------------------------------------------------------
 * eng: This table can be used to lower case all uppercase letters in a
 *      string. Only english characters are affected.
 * --------------------------------------------------------------------------
 * rus: Данная таблица может быть использована для перевода всех прописных
 *      букв в строчные. Регистр изменяется только у английских букв.
 *)

CONST
  LowerCaseEng: ARRAY [0..255] OF Byte = (
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
    18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
    34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
    50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 97,
    98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
    111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 91,
    92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105,
    106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118,
    119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131,
    132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144,
    145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157,
    158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170,
    171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183,
    184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196,
    197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209,
    210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222,
    223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235,
    236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248,
    249, 250, 251, 252, 253, 254, 255);

(* UpperCaseEng
 * --------------------------------------------------------------------------
 * eng: This table can be used to upper case all lowercase letters in a
 *      string. Only english characters are affected.
 * --------------------------------------------------------------------------
 * rus: Данная таблица может быть использована для перевода всех строчных
 *      букв в прописные. Регистр изменяется только у английских букв.
 *)

CONST
  UpperCaseEng: ARRAY [0..255] OF Byte = (
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
    18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
    34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
    50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65,
    66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81,
    82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 65,
    66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81,
    82, 83, 84, 85, 86, 87, 88, 89, 90, 123, 124, 125, 126, 127,
    128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140,
    141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153,
    154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166,
    167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179,
    180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192,
    193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205,
    206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218,
    219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231,
    232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244,
    245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255);

IMPLEMENTATION

(* strman.pa0 -- subunit of string manipulation library

   This file is part of the StrMan string manipulation library.

   Copyright (c) 1999 Aleksey V. Vaneev

   The StrMan library is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 2 of
   the License, or (at your option) any later version.

   The StrMan library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with the StrMan library; see the file COPYING.
   If not, write to the Free Software Foundation, Inc.,
   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

   Aleksey V. Vaneev
   <picoder@sbis.komi.ru>
   http://sbis.komi.ru/picoder
 *)

(*
 * Pure pascal implementation (can be relatively slow).
 * --------------------------------------------------------------------------
 * ╨хрышчрЎш  эр ўшёЄюь ярёърых (ьюцхЄ с√Є№ ёЁртэшЄхы№эю ьхфыхээющ).
 *)

PROCEDURE SetStringLength (VAR s: String; NewLength: Byte);
BEGIN
  {$IFDEF WIN32}
    SetLength (s, NewLength);
  {$ELSE}
    s [0] := Char (NewLength);
  {$ENDIF}
END;

FUNCTION CharReplicate (Character: Char; Count: Byte): String;
VAR
  OutStr: String;
BEGIN
  SetStringLength (OutStr, Count);

  FillChar (OutStr [1], Count, Character);

  CharReplicate := OutStr;
END;

FUNCTION StringReplicate (Source: String; Count: Byte): String;
VAR
  OutStr: String;
BEGIN
  OutStr := '';

  WHILE (Count > 0) DO
    BEGIN
      IF (Length (OutStr) + Length (Source) > 255) THEN
        BEGIN
          OutStr := OutStr + Copy (Source, 1, 255 - Length (OutStr));

          Break;
        END;

      OutStr := OutStr + Source;

      Dec (Count);
    END;

  StringReplicate := OutStr;
END;

FUNCTION CharPos (CharToFind: Char; Source: String; Offs: Byte): Byte;
VAR
  i: Integer;
BEGIN
  CharPos := 0;

  IF (Offs >= Length (Source)) THEN
    Exit;

  FOR i := Offs + 1 TO Length (Source) DO
    IF (Source [i] = CharToFind) THEN
      BEGIN
        CharPos := i;

        Exit;
      END;
END;

FUNCTION StringPos (StringToFind: String; Source: String; Offs: Byte): Byte;
VAR
  i, j: Integer;
BEGIN
  StringPos := 0;

  IF (Length (StringToFind) = Length (Source)) THEN
    BEGIN
      IF (StringToFind = Source) THEN
        StringPos := 1;

      Exit;
    END
  ELSE
    IF (Length (StringToFind) > Length (Source)) THEN
      Exit;

  IF (Offs >= Length (Source) - Length (StringToFind) + 1) THEN
    Exit;

  i := Offs + 1;
  j := 1;

  WHILE (i <= Length (Source)) DO
    BEGIN
      IF (Source [i] = StringToFind [j]) THEN
        BEGIN
          IF (j = Length (StringToFind)) THEN
            BEGIN
              StringPos := i - j + 1;

              Break;
            END;

          Inc (j);
        END
      ELSE
        j := 1;

      Inc (i);
    END;
END;

FUNCTION StringJustifyRight (Source: String; Width: Byte; JustifyChar: Char): String;
BEGIN
  IF (Width = 0) THEN
    BEGIN
      StringJustifyRight := '';

      Exit;
    END;

  IF (Length (Source) >= Width) THEN
    BEGIN
      StringJustifyRight := Copy (Source, Length (Source) - Width + 1, Width);

      Exit;
    END;

  StringJustifyRight := CharReplicate (JustifyChar, Width - Length (Source)) + Source;
END;

FUNCTION StringJustifyLeft (Source: String; Width: Byte; JustifyChar: Char): String;
BEGIN
  IF (Width = 0) THEN
    BEGIN
      StringJustifyLeft := '';

      Exit;
    END;

  IF (Length (Source) >= Width) THEN
    BEGIN
      StringJustifyLeft := Copy (Source, 1, Width);

      Exit;
    END;

  StringJustifyLeft := Source + CharReplicate (JustifyChar, Width - Length (Source));
END;

FUNCTION StringJustifyCenter (Source: String; Width: Byte; JustifyChar: Char): String;
BEGIN
  IF (Width = 0) THEN
    BEGIN
      StringJustifyCenter := '';

      Exit;
    END;

  IF (Length (Source) >= Width) THEN
    BEGIN
      StringJustifyCenter := Copy (Source, (Length (Source) - Width) SHR 1 + ((Width - Length (Source)) AND 1) + 1, Width);

      Exit;
    END;

  StringJustifyCenter := CharReplicate (JustifyChar, (Width - Length (Source)) SHR 1) + Source +
    CharReplicate (JustifyChar, ((Width - Length (Source)) SHR 1) + ((Width - Length (Source)) AND 1));
END;

FUNCTION StringJustifyWrap (Source: String; Width: Byte; WordDelimiters: String; JustifyChar: Char): String;
VAR
  WordCount: Integer;
  SpaceCount: Integer;
  SpaceAtStart: Boolean;
  SpaceAtEnd: Boolean;
  TextLength: Integer;
  FreeLength: Integer;
  SpaceLength: Integer;
  AddSpaceLength: Integer;
  i: Integer;
  OutStr: String;

  FUNCTION GetSpaceLength: Integer;
  BEGIN
    IF (AddSpaceLength > 0) THEN
      BEGIN
        GetSpaceLength := SpaceLength + 1;

        Dec (AddSpaceLength);
      END
    ELSE
      GetSpaceLength := SpaceLength;
  END;

BEGIN
  WordCount := StringWordCount (Source, WordDelimiters);

  IF (WordCount = 0) THEN
    BEGIN
      IF (Source = '') THEN
        StringJustifyWrap := ''
      ELSE
        StringJustifyWrap := CharReplicate (JustifyChar, Width);

      Exit;
    END;

  SpaceCount := WordCount - 1;

  IF (CharPos (Source [1], WordDelimiters, 0) <> 0) THEN
    BEGIN
      Inc (SpaceCount);
      SpaceAtStart := True;
    END
  ELSE
    SpaceAtStart := False;

  IF (CharPos (Source [Length (Source)], WordDelimiters, 0) <> 0) THEN
    BEGIN
      Inc (SpaceCount);
      SpaceAtEnd := True;
    END
  ELSE
    SpaceAtEnd := False;

  IF (WordCount = 1) AND (NOT SpaceAtStart) AND (NOT SpaceAtEnd) THEN
    BEGIN
      StringJustifyWrap := Source;

      Exit;
    END;

  TextLength := 0;

  FOR i := 1 TO WordCount DO
    TextLength := TextLength + Length (StringWordGet (Source, WordDelimiters, i));

  IF (TextLength + SpaceCount >= Width) THEN
    BEGIN
      IF (SpaceAtStart) THEN
        OutStr := JustifyChar
      ELSE
        OutStr := '';

      FOR i := 1 TO WordCount - 1 DO
        OutStr := OutStr + StringWordGet (Source, WordDelimiters, i) + JustifyChar;

      OutStr := OutStr + StringWordGet (Source, WordDelimiters, WordCount);

      IF (SpaceAtEnd) THEN
        OutStr := OutStr + JustifyChar;
    END
  ELSE
    BEGIN
      FreeLength := Width - TextLength;
      SpaceLength := FreeLength DIV SpaceCount;
      AddSpaceLength := FreeLength MOD SpaceCount;

      IF (SpaceAtStart) THEN
        OutStr := CharReplicate (JustifyChar, GetSpaceLength)
      ELSE
        OutStr := '';

      FOR i := 1 TO WordCount - 1 DO
        OutStr := OutStr + StringWordGet (Source, WordDelimiters, i) + CharReplicate (JustifyChar, GetSpaceLength);

      OutStr := OutStr + StringWordGet (Source, WordDelimiters, WordCount);

      IF (SpaceAtEnd) THEN
        OutStr := OutStr + CharReplicate (JustifyChar, GetSpaceLength);
    END;

  StringJustifyWrap := OutStr;
END;

FUNCTION StringTrimRight (Source: String; Garbage: String): String;
VAR
  j: Integer;
BEGIN
  j := Length (Source);

  WHILE (j > 0) do
    BEGIN
      IF (CharPos (Source [j], Garbage, 0) = 0) THEN
        BEGIN
          StringTrimRight := Copy (Source, 1, j);

          Exit;
        END;

      j := j - 1;
    END;

  StringTrimRight := '';
END;

FUNCTION StringTrimLeft (Source: String; Garbage: String): String;
VAR
  i: Integer;
BEGIN
  i := 1;

  WHILE (i <= Length (Source)) DO
    BEGIN
      IF (CharPos (Source [i], Garbage, 0) = 0) THEN
        BEGIN
          StringTrimLeft := Copy (Source, i, Length (Source) - i + 1);

          Exit;
        END;

      i := i + 1;
    END;

  StringTrimLeft := '';
END;

FUNCTION StringTrimAll (Source: String; Garbage: String): String;
VAR
  i, j: Integer;
BEGIN
  i := 1;

  WHILE (i <= Length (Source)) DO
    BEGIN
      IF (CharPos (Source [i], Garbage, 0) = 0) THEN
        BEGIN
          j := Length (Source);

          WHILE (j > 0) do
            BEGIN
              IF (CharPos (Source [j], Garbage, 0) = 0) THEN
                BEGIN
                  StringTrimAll := Copy (Source, i, j - i + 1);

                  Exit;
                END;

              j := j - 1;
            END;
        END;

      i := i + 1;
    END;

  StringTrimAll := '';
END;

FUNCTION StringReverse (Source: String): String;
VAR
  OutStr: String;
  i: Integer;
BEGIN
  SetStringLength (OutStr, Length (Source));

  FOR i := 1 TO Length (Source) DO
    OutStr [i] := Source [Length (Source) - i + 1];

  StringReverse := OutStr;
END;

FUNCTION StringFromData (Source: Pointer; Count: Byte): String;
VAR
  OutStr: String;
BEGIN
  SetStringLength (OutStr, Count);

  Move (Source^, OutStr [1], Count);

  StringFromData := OutStr;
END;

FUNCTION StringFromNul (Source: Pointer): String;
VAR
  i: Integer;
  OutStr: String;
BEGIN
  i := 0;

  WHILE (i < 255) DO
    BEGIN
      IF (Char (Pointer (LongInt (Source) + i)^) = #0) THEN
        Break;

      i := i + 1;
    END;

  SetStringLength (OutStr, i);

  Move (Source^, OutStr [1], i);

  StringFromNul := OutStr;
END;

FUNCTION StringCase (Source: String; RecodeTable: Pointer): String;
VAR
  i: Integer;
  o: String;
BEGIN
  SetStringLength (o, Length (Source));

  FOR i := 1 TO Length (Source) DO
    o [i] := Char (Pointer (LongInt (RecodeTable) + Byte (Source [i]))^);

  StringCase := o;
END;

FUNCTION StringExtract (Source: String; Offs: Byte; Count: Byte): String;
BEGIN
  IF (Offs >= Length (Source)) THEN
    BEGIN
      StringExtract := '';

      Exit;
    END;

  IF (Offs + Count > Length (Source)) THEN
    StringExtract := Copy (Source, Offs + 1, Length (Source) - Offs)
  ELSE
    StringExtract := Copy (Source, Offs + 1, Count);
END;

FUNCTION StringRemove (Source: String; Offs: Byte; Count: Byte): String;
VAR
  OutStr: String;
BEGIN
  OutStr := Source;

  Delete (OutStr, Offs + 1, Count);

  StringRemove := OutStr;
END;

FUNCTION StringInsert (SubString: String; Source: String; Offs: Byte): String;
VAR
  OutStr: String;
BEGIN
  OutStr := Source;

  Insert (SubString, OutStr, Offs + 1);

  StringInsert := OutStr;
END;

FUNCTION StringWordCount (Source: String; WordDelimiters: String): Byte;
VAR
  WordCount: Integer;
  Space: Boolean;
  CurrentDelimiter: Integer;
  CurrentChar: Integer;
BEGIN
  Space := True;
  WordCount := 0;

  IF (Length (WordDelimiters) = 0) THEN
    BEGIN
      IF (Length (Source) = 0) THEN
        StringWordCount := 0
      ELSE
        StringWordCount := 1;

      Exit;
    END;

  CurrentChar := 1;

  WHILE (CurrentChar <= Length (Source)) DO
    BEGIN
      CurrentDelimiter := 1;

      IF (Space) THEN
        BEGIN
          WHILE (CurrentDelimiter <= Length (WordDelimiters)) DO
            BEGIN
              IF (Source [CurrentChar] = WordDelimiters [CurrentDelimiter]) THEN
                Break;

              Inc (CurrentDelimiter);
            END;

          IF (CurrentDelimiter > Length (WordDelimiters)) THEN
            BEGIN
              Inc (WordCount);
              Space := False;
            END;
        END
      ELSE
        BEGIN
          WHILE (CurrentDelimiter <= Length (WordDelimiters)) DO
            BEGIN
              IF (Source [CurrentChar] = WordDelimiters [CurrentDelimiter]) THEN
                BEGIN
                  Space := True;

                  Break;
                END;

              Inc (CurrentDelimiter);
            END;
        END;

      Inc (CurrentChar);
    END;

  StringWordCount := WordCount;
END;

FUNCTION StringWordAcquire (Source: String; WordDelimiters: String; Num: Byte; VAR WordPos, WordLen: Integer): Boolean;
VAR
  WordCount: Integer;
  Space: Boolean;
  CurrentDelimiter: Integer;
  CurrentChar: Integer;
  Finished: Boolean;
BEGIN
  WordCount := 0;
  Space := True;

  IF (Length (WordDelimiters) = 0) THEN
    BEGIN
      IF (Num <> 1) OR (Length (Source) = 0) THEN
        StringWordAcquire := False
      ELSE
        BEGIN
          WordPos := 1;
          WordLen := Length (Source);

          StringWordAcquire := True;
        END;

      Exit;
    END;

  CurrentChar := 1;

  IF (Num < 1) THEN
    BEGIN
      StringWordAcquire := False;

      Exit;
    END;

  WHILE (CurrentChar <= Length (Source)) DO
    BEGIN
      CurrentDelimiter := 1;

      IF (Space) THEN
        BEGIN
          WHILE (CurrentDelimiter <= Length (WordDelimiters)) DO
            BEGIN
              IF (Source [CurrentChar] = WordDelimiters [CurrentDelimiter]) THEN
                Break;

              Inc (CurrentDelimiter);
            END;

          IF (CurrentDelimiter > Length (WordDelimiters)) THEN
            BEGIN
              Inc (WordCount);

              IF (WordCount = Num) THEN
                BEGIN
                  WordPos := CurrentChar;

                  Inc (CurrentChar);
                  Finished := False;

                  WHILE (CurrentChar <= Length (Source)) AND (NOT Finished) DO
                    BEGIN
                      CurrentDelimiter := 1;

                      WHILE (CurrentDelimiter <= Length (WordDelimiters)) DO
                        BEGIN
                          IF (Source [CurrentChar] = WordDelimiters [CurrentDelimiter]) THEN
                            BEGIN
                              Finished := True;
                              Dec (CurrentChar);

                              Break;
                            END;

                          Inc (CurrentDelimiter);
                        END;

                      Inc (CurrentChar);
                    END;

                  WordLen := CurrentChar - WordPos;

                  StringWordAcquire := True;

                  Exit;
                END;

              Space := False;
            END;
        END
      ELSE
        BEGIN
          WHILE (CurrentDelimiter <= Length (WordDelimiters)) DO
            BEGIN
              IF (Source [CurrentChar] = WordDelimiters [CurrentDelimiter]) THEN
                BEGIN
                  Space := True;

                  Break;
                END;

              Inc (CurrentDelimiter);
            END;
        END;

      Inc (CurrentChar);
    END;

  StringWordAcquire := False;
END;

FUNCTION StringWordGet (Source: String; WordDelimiters: String; Num: Byte): String;
VAR
  WordPos: Integer;
  WordLen: Integer;
BEGIN
  IF (StringWordAcquire (Source, WordDelimiters, Num, WordPos, WordLen)) THEN
    StringWordGet := Copy (Source, WordPos, WordLen)
  ELSE
    StringWordGet := '';
END;

FUNCTION StringWordPos (Source: String; WordDelimiters: String; Num: Byte): Byte;
VAR
  WordPos: Integer;
  WordLen: Integer;
BEGIN
  IF (StringWordAcquire (Source, WordDelimiters, Num, WordPos, WordLen)) THEN
    StringWordPos := WordPos
  ELSE
    StringWordPos := 0;
END;

FUNCTION doStringMatch (InString: String; Pattern: String; i, j: Integer): Boolean;
CONST
  charQuestionMark = '?';
  charAsterisk = '*';

VAR
  PatChar: Char;
  StrChar: Char;
BEGIN
  doStringMatch := False;

  WHILE (j <= Length (Pattern)) DO
    BEGIN
      StrChar := InString [i];
      PatChar := Pattern [j];

      IF (PatChar = StrChar) OR ((PatChar = charQuestionMark) AND (i <= Length (InString))) THEN
        BEGIN
          Inc (i);
          Inc (j);
        END
      ELSE
        IF (PatChar = charAsterisk) THEN
          BEGIN
            WHILE (PatChar = charAsterisk) DO
              BEGIN
                Inc (j);
                PatChar := Pattern [j];

                IF (j > Length (Pattern)) THEN
                  BEGIN
                    doStringMatch := True;

                    Exit;
                  END;
              END;

            WHILE (i <= Length (InString)) DO
              BEGIN
                StrChar := InString [i];

                IF (PatChar = StrChar) OR (PatChar = charQuestionMark) THEN
                  BEGIN
                    IF (doStringMatch (InString, Pattern, i, j)) THEN
                      BEGIN
                        doStringMatch := True;

                        Exit;
                      END;
                  END;

                Inc (i);
              END;

            Exit;
          END
        ELSE
          Exit;
    END;

  IF (i > Length (InString)) THEN
    doStringMatch := True;
END;

FUNCTION StringMatching (InString: String; Pattern: String): Boolean;
BEGIN
  StringMatching := doStringMatch (InString, Pattern, 1, 1);
END;


END.