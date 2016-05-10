                  IDEAL
                  MODEL   small
                  STACK   256
                  DATASEG
a		  DD	   2.
b		  DD	   4.
c                 Dd	  -7.
FOUR              DD      4.
EXC               DB	  0
D                 DD      ?

	          CODESEG
START:		  mov	  ax, @data	  ; Запис в DS
	          mov	  ds,ax	          ;   data segment
		  FINIT
		  fld     [b]
                  fmul    st,st(0)
                  fld     [FOUR]
                  fmul    [a]
                  fmul    [c]
                  fsub
                  fst     [d]           
  Exit:   mov	  ah, 04Ch	  ; DOS-ф-цiя  Exit program
                  mov	  al, [exC]	  ; Return exit	code value
     	          int	  21h		  ; Call DOS.  Terminate program
     	          END	  Start

