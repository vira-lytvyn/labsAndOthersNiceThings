	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	V 300h
	?debug	S "stdc2.cpp"
	?debug	C E915A888380973746463322E637070
	?debug	C E94019CA181B473A5C626F726C616E64635C696E636C7564655C73+
	?debug	C 7464696F2E68
	?debug	C E94019CA181B473A5C626F726C616E64635C696E636C7564655C5F+
	?debug	C 646566732E68
	?debug	C E94019CA181C473A5C626F726C616E64635C696E636C7564655C5F+
	?debug	C 6E66696C652E68
	?debug	C E94019CA181B473A5C626F726C616E64635C696E636C7564655C5F+
	?debug	C 6E756C6C2E68
	?debug	C E94019CA181B473A5C626F726C616E64635C696E636C7564655C63+
	?debug	C 6F6E696F2E68
_TEXT	segment byte public 'CODE'
_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	int	main ()
   ;	
	assume	cs:_TEXT
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,20
   ;	
   ;	{
   ;		double	a, c ;
   ;		float	b ;
   ;		printf ("Input A[double]  : ") ;
   ;	
	mov	ax,offset DGROUP:s@
	push	ax
	call	near ptr _printf
	pop	cx
   ;	
   ;		scanf  ("%lf", &a) ;
   ;	
	lea	ax,word ptr [bp-8]
	push	ax
	mov	ax,offset DGROUP:s@+20
	push	ax
	call	near ptr _scanf
	pop	cx
	pop	cx
   ;	
   ;		printf ("\nInput B[float]  : ") ;
   ;	
	mov	ax,offset DGROUP:s@+24
	push	ax
	call	near ptr _printf
	pop	cx
   ;	
   ;		scanf  ("%f", &b) ;
   ;	
	lea	ax,word ptr [bp-20]
	push	ax
	mov	ax,offset DGROUP:s@+44
	push	ax
	call	near ptr _scanf
	pop	cx
	pop	cx
   ;	
   ;		c = a + b ;
   ;	
	fld	dword ptr [bp-20]
	fadd	qword ptr [bp-8]
	fstp	qword ptr [bp-16]
   ;	
   ;		printf ("\n %8.3lf + %8.3f = %8.3lf\n", a, b, c) ;
   ;	
	fld	qword ptr [bp-16]
	sub	sp,8
	fstp	qword ptr [bp-28]
	fld	dword ptr [bp-20]
	sub	sp,8
	fstp	qword ptr [bp-36]
	fld	qword ptr [bp-8]
	sub	sp,8
	fstp	qword ptr [bp-44]
	mov	ax,offset DGROUP:s@+47
	push	ax
	fwait	
	call	near ptr _printf
	add	sp,26
   ;	
   ;		getch () ;
   ;	
	call	near ptr _getch
   ;	
   ;		return 0 ;
   ;	
	xor	ax,ax
	jmp	short @1@58
@1@58:
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
_main	endp
	?debug	C E9
	?debug	C FA00000000
_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
	db	'Input A[double]  : '
	db	0
	db	'%lf'
	db	0
	db	10
	db	'Input B[float]  : '
	db	0
	db	'%f'
	db	0
	db	10
	db	' %8.3lf + %8.3f = %8.3lf'
	db	10
	db	0
_DATA	ends
_TEXT	segment byte public 'CODE'
_TEXT	ends
	extrn	__turboFloat:word
	public	_main
	extrn	_getch:near
	extrn	_scanf:near
	extrn	_printf:near
_s@	equ	s@
	end
