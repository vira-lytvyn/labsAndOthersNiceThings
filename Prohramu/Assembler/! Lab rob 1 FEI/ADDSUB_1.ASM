
        IDEAL
        DOSSEG
        MODEL   small
        STACK   256

        DATASEG

exitCode        DB      0
count           DW      1

        CODESEG

Start:  
        mov     ax, @data       ; Initialize DS to address
        mov     ds, ax          ;  of data segment

        mov     ax, 4
        mov     bx, 2
        add     ax, bx          ; ax <- ax + bx


Exit:
        mov     ah, 04Ch        ; DOS function: Exit program
        mov     al, [exitCode]  ; Return exit code value
        int     21h             ; Call DOS.  Terminate program

        END     Start           ; End of program / entry point
