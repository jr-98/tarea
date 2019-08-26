;Deja la pantalla de la consola de color azul
%macro write 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro

section .data 
	color    db 0x1b, "[34;44;3m",0x1b, "[2J"     ;parametros de color
 	lenght_color equ $-color
section .text
	global _start  
			_start: 
				write color, lenght_color
			salir:
				mov eax, 1  
				xor ebx, ebx 
				int 0x80