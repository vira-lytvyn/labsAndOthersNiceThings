MODEL	SMALL
STACK 256	
DATASEG

CODESEG
start:
	mov ax,0013h       
	int 10h


        mov cx,80   ;x
fest13:        
        mov dx,100   ;y
        mov al,12    ;color	
        mov ah,0Ch
	int 10h
        inc cx
        cmp cx,230
  je peres13
  jmp fest13
peres13:



        mov dx,30   ;y
fest1:        
        mov cx,1   ;x 
	mov cx,160
        mov al,12    ;	
        mov ah,0Ch
	int 10h
        inc dx
        cmp dx,180
  je peres1
  jmp fest1
peres1:

			Нихній сигмент
	mov cx,91   ;x
        mov dx,101   ;y
fest2:        
        mov al,10    ;color	
        mov ah,0Ch
	int 10h
        inc dx
        cmp dx,150
        inc cx
        cmp cx,160
  je peres2
  jmp fest2
peres2:

			Верхій сигмент
        mov cx,161   ;x
        mov dx,41   ;y
fest3:        
        mov al,10    ;color	
        mov ah,0Ch
	int 10h
        inc dx
        cmp dx,159
        inc cx
        cmp cx,220
  je peres3
  jmp fest3
peres3:



ex:			Вихід
	mov ah,1
	int 16h
jz ex

	mov ax,0003h
	int 10h
	mov ah,04Ch
	int 021h
end start


