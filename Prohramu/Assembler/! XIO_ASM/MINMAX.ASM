   IDEAL
   DOSSEG
   MODEL small
   STACK 256

   DATASEG
Dani  DW  20,7,12,3,5,23,67,3,6,8,54,23,1,2,5,9,77,4,33,11,7
EXC   DB  0
   CODESEG
Start:  mov ax,@data
       mov ds,ax
       mov Es,ax
       mov di,0
       call minmax
Exit:  mov ah,04ch
       mov al,[EXC]
       int 21h
proc   MINMAX
       push cx
       push di
       mov cx,[word ES:DI]
       DEC cx
       push cx
       mov bx,[word ES:DI+2]
       mov ax,bx

       ;min

       add di,4
       push di
  L1:  cmp [word ES:DI],bx
       jae nomin
       mov bx,[word ES:DI]
nomin: add di,2
       loop l1
       
       ;max
        
       pop di
       pop cx
 l2:   cmp [word ES:DI],ax
       jbe nomax
       mov ax,[word ES:DI]
nomax: add di,2
       loop l2
       
       ;sum
       pop di
       pop cx
       mov dx,cx
       mov cx,21
 l3:   add dx,[word ES:DI]
       add di,2
       loop l3
       



       pop di
       pop cx
       ret
       endp minmax
       END START