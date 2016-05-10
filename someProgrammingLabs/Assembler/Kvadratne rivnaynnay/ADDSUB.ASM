%TITLE "ADD, SUB, INC, DEC demo"

        IDEAL
        DOSSEG
        MODEL   small
        STACK   256

        DATASEG

exC             DB      0
count           DW      1

        CODESEG

Start:  
        mov     ax, @data       ; Запис в DS  aдрeси
        mov     ds, ax          ;   data segment

        mov     ax, 1
        mov     bx, -5
        mov     cx, 6
	imul    bx, bx          ; bx <- bx * bx
	imul    ax, ax, 4       ; ax <- ax * 4
	imul    ax, cx          ; cx <- cx * ax * 4
	sub     bx, ax          ; bx <- bx * bx - 4 * ax * cx
	div     
        
        add     cx, [count]     ; cx <- cx + [count]

        add     [count], cx     ; [count] <- cx + [count]

        inc     [count]         ; [count] <- [count] + 1
        dec     [count]         ; [count] <- [count] - 1
        inc     ax              ; ax <- ax + 1
        dec     cx              ; cx <- cx + 1

Exit:
        mov     ah, 04Ch        ; DOS-ф-цiя  Exit program
        mov     al, [exC]       ; Return exit code value
        int     21h             ; Call DOS.  Terminate program

        END     Start         
