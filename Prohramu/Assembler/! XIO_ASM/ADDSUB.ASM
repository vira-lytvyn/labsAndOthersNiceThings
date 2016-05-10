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

        mov     ax, 4
        mov     bx, 2
        add     ax, bx          ; ax <- ax + bx

        mov     cx, 8
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
