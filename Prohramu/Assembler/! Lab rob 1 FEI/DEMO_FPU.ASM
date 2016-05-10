                  IDEAL
                  MODEL   small
                  STACK   256
                  DATASEG
x		  DD	  1., 2., 3., 4.
Y		  DD	  2., 4., 6., 8.
N                 DW	  4
EXC               DB	  0
CXY               DD      ?
SY		  DD	  ?
SX		  DD	  ?
MY		  DD	  ?
MX		  DD	  ?
	          CODESEG
START:		  mov	  ax, @data	  ; Запис в DS
	          mov	  ds,ax	          ;   data segment
	          mov	  cx,[N]
		  FINIT
		  FLDZ
		  FLDZ
		  FLDZ
		  FLDZ
		  FLDZ
	  XOR	  SI,SI
	  lea	  AX,[X]
	  MOV	  BX,DS
	  ADD	  AX,BX
	  MOV	  ES,AX
NACH:		  FLD	  [DWORD  PTR ES:SI]
		  FADD	  ST(5),ST
		  FLD	  ST(0)
		  FMUL	  ST,ST(0)
		  FADDP	  ST(4),ST
        	  FLD	  [DWORD PTR DS:SI+010h]
		  FADD	  ST(5),ST
		  FLD	  ST(0)
		  FMUL	  ST,ST(0)
		  FADDP	  ST(4),ST
		  FMUL
		  FADD
		  ADD	  SI,4
	  LOOP	  NACH
    		  FSTP	  [CXY]
    		  FSTP	  [ SY]
    		  FSTP	  [ SX]
    		  FSTP	  [ MY]
    		  FSTP	  [ MX]
	  Exit:   mov	  ah, 04Ch	  ; DOS-ф-цiя  Exit program
                  mov	  al, [exC]	  ; Return exit	code value
     	          int	  21h		  ; Call DOS.  Terminate program
     	          END	  Start

