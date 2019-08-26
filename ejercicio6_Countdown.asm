;Cuenta regresiva del 9 a 1 (9-8-7-6-5-4-3-2-1)
%macro write 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
%macro read 2
	mov eax, 3
	mov ebx, 2
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
section .data
	menu db "Cuenta regresiva ENTER para iniciar",0xA
	len_menu4 equ $-menu
	sep db "  -  "
	secuencia equ 10
	timeval:
	tv_sec  dd 0
	tv_usec dd 0
	
section .bss
	confirm resb 2
	aux rest 2
section .text
	global _start
	
			_start:
				write menu, len_menu4
				read confirm,2

			cont:
				mov ecx,secuencia
				jmp time

			time:
				push ecx
				add ecx,'0'
				mov [aux], ecx
				write aux,2
				write sep,2
				mov dword [tv_sec], 1
				mov dword [tv_usec], 0
				mov eax, 162
				mov ebx, timeval
				mov ecx, 0
				int 0x80

				pop ecx
				loop time
			salir:
				mov eax, 1
				mov ebx, 0
				int 80H
