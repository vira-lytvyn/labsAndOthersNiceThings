;прога рисует 3-х лепестковую розу. divK - устанавливает ее размер

include pixels.inc ;содержит макросы вывода точки, осей и символа

.model small
.stack 100h
.data
gx dd 20.0 ;масштабные коэффициенты
gy dd 20.0
alpha dd 0.0 ;измен€юща€с€ переменна€ 
delta dd 0.001 ;величина изменени€
xdiv2 dd 320.0 ;середина по X и Y
ydiv2 dd 240.0
tmp dd 0 ;temp
x3 dd 3.0
x10 dd 10.0
divK dd 20.0
xr dw 0 ;координаты выводимой точки
yr dw 0
AboutMe db 177,176,176,177,178,178,177,176,176,177,178,178,177,176,176,177,178,178,177,176,176,177,178,'[KaspeR Demo Project - LabWork #5]',178,177,176,176,177,178,178,177,176,176,177,178,178,177,176,176,177,178,178,177,176,176,177,'$' ;обо мне!!!
Sine db '3l rose$'

.code
.486
start:
mov ax,@DATA
mov ds,ax
xor ax,ax
mov cx,188bh ;количество итераций цикла - 2*Pi/0.001
;------------------------------------------------------------------
mov ah,0h ;инициализаци€ графического режима 640х480
mov al,12h
int 10h
;------------------------------------------------------------------
pusha ;вывод строки AboutMe - скобки др. цветом, потому длинный код
mov cx,80 ;кол-во букв в строке AboutMe
mov bx,0
l2:
mov al,AboutMe[bx]
cmp bx,23 ;с 23 до 56 символа - скобки
jb neI ;NeI - вывод символа красным цветом
cmp bx,56
jg neI
 OutCharG bl,0,0eh,al
 jmp next
neI:
 OutCharG bl,0,04h,al
next:
 inc bx
loop l2
popa
;-----------------------------------------------------------------
pusha ;вывод строки Sine (аналогично AboutMe)
mov cx,7
mov bx,0
l3:
 mov al,Sine[bx]
 inc bx
 OutCharG bl,02h,03h,al
loop l3
popa
;-----------------------------------------------------------------
AxleX ;рисуем оси
AxleY
finit ;инициализаци€ сопроцессора

l1:
 fld alpha         ;ф-ла r=10*sin(3*alpha)
 fmul x3
 fsin
 fmul x10
 fld alpha
 fcos
 fmul divK
 fmul             
 frndint           
 fld xdiv2         
 fadd              
 fistp word ptr xr ;заносим X в переменную дл€ вывода на экран

 fld alpha
 fmul x3
 fsin
 fmul x10
 fld alpha
 fsin
 fmul divK
 fmul              
 frndint           
 fstp tmp          
 fld ydiv2         
 fsub tmp          
 fistp word ptr yr ;заносим Y в переменную дл€ вывода на экран

 PutPixel xr,yr,0ah ;выводим точку зеленым цветом

 fld delta ;вычисл€ем новое значение alpha
 fld alpha
 fadd
 fstp alpha
loop l1 ;цикл по cx
;--------------------------------------------------------------------
mov ah,1h ;ожидание нажати€ клавиши 
int 21h
;--------------------------------------------------------------------
mov ah,0h ;перевод обратно в TextMode
mov al,03h
int 10h
;--------------------------------------------------------------------
exit:
mov ax,4C00h ;стандартный выход
int 21h
END start
