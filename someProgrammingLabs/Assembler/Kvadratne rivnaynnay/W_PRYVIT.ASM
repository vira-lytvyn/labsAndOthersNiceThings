; winhello.asm
; ����᪮� win32-�ਫ�����e
; �뢮��� ���� ⨯� mesagebox � ⥪�⮬ "Usim Pryvit!"
;
; ��������� MASM
;  ml /c /coff /Cp W_pryvit.asm
;  link W_pryvit.obj /subsystem:windows

;
include def32.inc
include kernel32.inc
include user32.inc

	.386
	.model flat
	.const
; ��������� ����
hello_title	db 'XIO first win32 GUI proga',0
; ᮮ�饭��
hello_message	db 'Usim pryvit!',0
	.code
_start:
	push	MB_ICONINFORMATION	; �⨫� ����
	push	offset hello_title	; ���� ��ப� � ����������
	push	offset hello_message	; ���� ��ப� � ᮮ�饭���
	push	0			; �����䨪��� �।��
	call	MessageBox

	push	0		; ��� ��室� 
	call	ExitProcess	; �����襭�� �ணࠬ��
end	_start
