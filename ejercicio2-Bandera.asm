%macro write 2     ;macaro para escribir en pantalla
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

segment .data
msg2 db  0x1b,"[30;32m","-------",0x1b,"[45;35m","-------",0xA,0x1b,"[50;37m"	;
len2 equ $-msg2

msg3 db 0x1b,"[45;35m","-------",0x1b,"[42;32m","-------",0xA,0x1b,"[30;37m"
len3 equ $-msg3

segment .bss
	res resb 2

segment .text

	global _start
		_start:

		write msg2, len2 ;se imprimen las franjas una sobre la otra
		write msg3, len3
		write msg2, len2
		write msg3, len3
		write msg2, len2
		write msg3, len3
		write msg2, len2
		write msg3, len3


	salir:
		 mov eax, 1
		 mov ebx, 0
		 int 0x80
