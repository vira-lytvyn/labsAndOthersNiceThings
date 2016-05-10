MODEL	SMALL
STACK 256	
DATASEG

CODESEG
start:
	mov ax,0013h       ;rozshurenia
	int 10h


	mov cx,319   ;x
	mov dx,0    ;y
draw:
	mov al,10    ;color
	mov ah,0Ch
	int 10h
loop draw


	mov cx,319   ;x
	mov dx,199   ;y
draw1:
	mov al,12    ;color
	mov ah,0Ch
	int 10h
loop draw1


        mov dx,1   ;y
fest:        
        mov cx,1   ;x
        mov al,10    ;color	
        mov ah,0Ch
	int 10h
        inc dx
        cmp dx,199
  je peres
  jmp fest
peres:


        mov dx,1   ;y
fest1:        
        mov cx,1   ;x
	mov cx,319
        mov al,10    ;color	
        mov ah,0Ch
	int 10h
        inc dx
        cmp dx,199
  je peres1
  jmp fest1
peres1:


ex:
	mov ah,1
	int 16h
jz ex

	mov ax,0003h
	int 10h
	mov ah,04Ch
	int 021h
end start


