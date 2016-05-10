;
MODEL	SMALL
STACK 256	
DATASEG

CODESEG
start:
	mov ax,0013h       ;rozshurenia
	int 10h




        mov dx,0  ;y


       
fest3:        
        mov cx,150   ;x
        mov al,4    ;color	
        mov ah,0Ch
	int 10h
        inc dx
        cmp dx,150
  je peres3
  jmp fest3
peres3:


        


        mov dx,90   ;y
fest5:        
        mov cx,100   ;x
        mov al,6    ;color	
        mov ah,0Ch
	int 10h
        inc dx
        cmp dx,169
  je peres5
  jmp fest5
peres5:


       


        mov cx,50   ;y
fest7:        
        mov dx,70   ;x
        mov al,8    ;color	
        mov ah,0Ch
	int 10h
        inc cx
        cmp cx,269
  je peres7
  jmp fest7
peres7:


        mov cx,189   ;y
fest8:        
        mov dx,100   ;x
        mov al,9    ;color	
        mov ah,0Ch
	int 10h
        inc cx
        cmp cx,239
  je peres8
  jmp fest8
peres8:


        mov cx,100   ;y
fest9:        
        mov dx,90   ;x
        mov al,10    ;color	
        mov ah,0Ch
	int 10h
        inc cx
        cmp cx,159
  je peres9
  jmp fest9
peres9:


        mov cx,100   ;y
fest10:        
        mov dx,119   ;x
        mov al,11    ;color	
        mov ah,0Ch
	int 10h
        inc cx
        cmp cx,159
  je peres10
  jmp fest10
peres10:


        mov cx,100   ;y
fest11:        
        mov dx,169   ;x
        mov al,12    ;color	
        mov ah,0Ch
	int 10h
        inc cx
        cmp cx,159
  je peres11
  jmp fest11
peres11:







ex:
	mov ah,1
	int 16h
jz ex

	mov ax,0003h
	int 10h
	mov ah,04Ch
	int 021h
end start


