            PAGE        60,132
;****************************************************************
;*                 FRAC.ASM - SLO-GRO FRACTAL Routines          *
;*                 Devin Cook        10/24/88                   *
;*                 Mutalation Software Design                   *
;****************************************************************

            TITLE       FRAC.ASM    SLO-GRO Fractal Routines

CODE        SEGMENT     BYTE        PUBLIC
            ASSUME      CS:CODE,DS:DSEG;

            PUBLIC      INIT_ARRAY,FRAC;

INIT_ARRAY  PROC        NEAR
            LEA         BX,ARRAY    ; Point to the array
            MOV         CX,5199     ; Its a big boy!
LOOP1:      MOV         BYTE PTR [BX],0         ; Clear it!
            INC         BX
            LOOP        LOOP1
            SUB         AX,AX       ; Set Pixel 0,0
            MOV         X,AX
            MOV         Y,AX
            CALL        SET_PIX
            RET
INIT_ARRAY  ENDP
                       
FRAC        PROC        NEAR
            PUSH        BP          ; Save BP
            MOV         BP,SP       ; Set up stack frame

            SUB         AX,AX
            MOV         LOOPS,AX    ; Save loop count

; Ok, the BS is out of the way, now to pull X & Y off stack.

DO_RAND:    CALL        RANDOM      ; Get 0-3 in AL
            MOV         BX,X
            MOV         CX,Y

            CMP         AL,0        ; Random 0
            JNZ         NOT_0
            INC         BX          ; X := X + 1
            MOV         X,BX
            JMP         CHK_SZ

NOT_0:      CMP         AL,1        ; Random 1
            JNZ         NOT_1
            DEC         BX          ; X := X - 1
            MOV         X,BX
            JMP         CHK_SZ

NOT_1:      CMP         AL,2        ; Random 2
            JNZ         NOT_2
            INC         CX          ; Y := Y + 1
            MOV         Y,CX
            JMP         CHK_SZ

NOT_2:      DEC         CX          ; Y := Y - 1
            MOV         Y,CX

CHK_SZ:     MOV         AX,CX
            MUL         CX
            MOV         CX,AX
            MOV         AX,BX
            MUL         BX
            ADD         AX,CX
            CMP         AX,10000
            JLE         UNDR_10G
            SUB         AX,AX       ; Report its off the map!
            JMP         EXIT

UNDR_10G:   MOV         AX,X        ; Check ( X-1 , Y-1 )
            DEC         AX          ;
            MOV         TEMPX,AX    ;
            MOV         AX,Y        ;
            DEC         AX          ;
            MOV         TEMPY,AX    ;
            CALL        CHECK_PIX   ;
            JB          WINNER      ; Bit SET!!

            INC         TEMPX       ; Check ( X , Y - 1 );
            CALL        CHECK_PIX   ;
            JB          WINNER      ;

            INC         TEMPX       ; Check ( X + 1 , Y - 1 );
            CALL        CHECK_PIX   ;
            JB          WINNER      ;

            INC         TEMPY       ; Check ( X + 1 , Y  );
            CALL        CHECK_PIX   ;
            JB          WINNER      ;

            DEC         TEMPX       ; Check ( X-1 , Y  );
            DEC         TEMPX       ;
            CALL        CHECK_PIX   ;
            JB          WINNER      ;

            INC         TEMPY       ; Check ( X-1 , Y + 1 );
            CALL        CHECK_PIX   ;
            JB          WINNER      ;

            INC         TEMPX       ; Check ( X , Y + 1 );
            CALL        CHECK_PIX   ;
            JB          WINNER      ;

            INC         TEMPX       ; Check ( X+1 , Y + 1 );
            CALL        CHECK_PIX   ;
            JB          WINNER      ;

            INC         LOOPS       ;
            MOV         AX,LOOPS
            CMP         AX,10000    ; Must have trouble!
            MOV         AX,0        ;
            JZ          EXIT

            JMP         DO_RAND     ; Loop again!

; Report a hit!
WINNER:
            CALL        SET_PIX     ; Give it a home!
            MOV         AX,1        ; Boolean TRUE

EXIT:
            POP         BP
            RET                     ; Remove 2 words from stack

FRAC        ENDP

; Check X-Y from TEMPX/TEMPY , sets CARRY flag
CHECK_PIX   PROC        NEAR

            MOV         AX,TEMPY    ; Get Y pos
            ADD         AX,101      ; Make it ( 0 - 201 )
            MOV         BL,25       ; # of bytes per line
            MUL         BL          ; ( Y + 101 ) * 25
            ADD         AX,OFFSET ARRAY    ; Add to base address
            MOV         [ADDRS],AX  ; Save the byte addr for later

            MOV         AX,TEMPX    ; Get X Pos
            ADD         AX,104      ;
            MOV         DL,8        ;
            DIV         DL          ; ( X + 104 ) / 8
            MOV         CL,AH       ; remainder
            INC         CL          ; + 1  ( Number of shifts to do )

            SUB         AH,AH       ;
            MOV         BX,AX       ; Bytes
            ADD         BX,[ADDRS]  ;   + Byte Addr
            MOV         AL,[BX]     ; Get that damn byte finally

            ROR          AL,CL      ; Do it finally!
            RET
CHECK_PIX   ENDP

; Set Pixel data at X,Y
SET_PIX     PROC        NEAR

            MOV         AX,Y        ; Get Y pos
            ADD         AX,101      ; Make it ( 0 - 201 )
            MOV         BL,25       ; # of bytes per line
            MUL         BL          ; ( Y + 101 ) * 25
            ADD         AX,OFFSET ARRAY    ; Add to base address
            MOV         [ADDRS],AX  ; Save the byte addr for later

            MOV         AX,X        ; Get X Pos
            ADD         AX,104      ;
            MOV         DL,8        ;
            DIV         DL          ; ( X + 104 ) / 8
            MOV         CL,AH       ; remainder  ( bit to set! )

            SUB         AH,AH       ;
            MOV         BX,AX       ; Bytes
            ADD         BX,[ADDRS]  ;   + Byte Addr
            MOV         AL,[BX]     ; Get that damn byte finally

            MOV         DL,1        ;
            SHL         DL,CL       ; Sheft bit to proper position
            OR          AL,DL       ; Set Bit
            MOV         [BX],AL     ; Save Byte
            RET
SET_PIX     ENDP
            




; Return random 0-3 in AX
RANDOM      PROC        NEAR
            MOV         AX,SEED
            MOV         BX,31421
            MUL         BX
            ADD         AX,6927
            MOV         SEED,AX
            MOV         BX,4
            MUL         BX
            MOV         AX,DX
            AND         AX,3        ; Just making sure!!!!
            RET
RANDOM      ENDP

CODE        ENDS


DSEG        SEGMENT     WORD  PUBLIC
            EXTRN       X:WORD,Y:WORD,LOOPS:WORD,SEED:WORD;
            EXTRN       TEMPX:WORD,TEMPY:WORD;
ADDRS       DW          ?
ARRAY       DW          2600 dup (?) ; Array for pixel like data
DSEG        ENDS

END

