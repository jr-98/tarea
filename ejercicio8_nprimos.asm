;Comprueba si un muemro es o no primo, en un rango de 0 a 9
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
	numero db 'Ingrese  nuemro del 1 al 9 ',0xA,'....Comprobando si es o no Primo',0xA
	lenght_num equ $-numero
	msj2 db 'NO pertenece a la familia de los primos',0xA,'......Saliendo',0xA
	lenght_msj2 equ $-msj2
	msj3 db 'PERTENECE a la familia de los primos',0xA,'......Saliendo',0xA
	lenght_msj3 equ $-msj3

section .bss
	resp resb 1
section .text
	global _start
		_start:
			write numero, lenght_num
			read resp,2

			mov al,[resp]
			sub al, '0'
			cmp al,2
			jz primo
			jc primo
			jmp l1
		l1:
			mov al,[resp]
			sub al, '0'
			and al, 1
			jz no_primo
			jmp impar
		impar:
			mov al,[resp]
			sub al, '0'
			cmp al,3
			jz primo
			jmp l2
		l2:
			mov al, [resp]
			sub al, '0'
			cmp al,9
			jz no_primo
			jmp primo
		primo:
			write msj3, lenght_msj3
			jmp salir
		no_primo:
			write msj2, lenght_msj2
			jmp salir
		salir:
			mov eax, 1
			mov ebx, 0
			int 80
