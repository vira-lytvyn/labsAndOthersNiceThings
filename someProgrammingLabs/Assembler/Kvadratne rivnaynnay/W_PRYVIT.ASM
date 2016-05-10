; winhello.asm
; Графическое win32-приложениe
; Выводит окно типа mesagebox с текстом "Usim Pryvit!"
;
; Компиляция MASM
;  ml /c /coff /Cp W_pryvit.asm
;  link W_pryvit.obj /subsystem:windows

;
include def32.inc
include kernel32.inc
include user32.inc

	.386
	.model flat
	.const
; заголовок окна
hello_title	db 'XIO first win32 GUI proga',0
; сообщение
hello_message	db 'Usim pryvit!',0
	.code
_start:
	push	MB_ICONINFORMATION	; стиль окна
	push	offset hello_title	; адрес строки с заголовком
	push	offset hello_message	; адрес строки с сообщением
	push	0			; идентификатор предка
	call	MessageBox

	push	0		; код выхода 
	call	ExitProcess	; завершение программы
end	_start
