MODEL	SMALL
STACK 256	
DATASEG

CODESEG
start:
	mov ax,0013h
	int 10h
	mov cx,319
	mov dx,0

maljuvannja:
	mov al,5
	mov ah,0Ch
	int 10h
loop maljuvannja
	mov cx,319
	mov dx,199

maljuvannja_1:
	mov al,5
	mov ah,0Ch
	int 10h
loop maljuvannja_1
        mov dx,1

mitka_1:        
        mov cx,1
	
maljuvannja_2:
        mov al,5	
        mov ah,0Ch
	int 10h
loop maljuvannja_2
        inc dx
        cmp dx,199

  je peres
  jcxz mitka_1

peres:
        mov dx,1

mitka_2:        
        mov cx,1
	
maljuvannja_3:
        mov al,5	
        mov ah,0Ch
	int 10h
loop maljuvannja_3
        inc dx
        cmp dx,199

  je peres1
  jcxz mitka_2

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