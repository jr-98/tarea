;calculadora mediante la aplicacion de un menu
%macro write 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro

segment .data 
	opciones_menu db 0xA,0xA,"menu:", 0xA,0x9, "1)suma", 0xA,0x9, "2)resta", 0xA,0x9, "3)salir",0xA,0xA,0x9
	lenght_menu equ $-opciones_menu 

	num db 0xA,0x9,"ingrese el numero:  "
	lenght_num equ $-num

	msj_salir db  0xA,0x9,"saliendo... "
	lenght_salir equ $-msj_salir

segment .bss
	n1 resb 2
	n2 resb 2
segment .text
entrada:						;datos ingresados pro teclado
	mov eax, 3 
	mov ebx, 0
	int 0x80
	ret

	global _start  
_start:  
		menu:                                         ;despliega las opciones del menu
			write opciones_menu,lenght_menu
			mov ecx, n1 
			mov edx, 2
			call entrada							  ;llama a la entrada de datos
			mov al, [n1]
			sub al, '0'
			cmp al, 2								  ;compara
			jb suma									  ;si el menor a 2, es decir 1 salta a suma
			ja salir 								  ;si es mayor a 2, es decir 3 sale
			je resta								  ;si el igual a 2, salta a resta	
			jmp menu                                  ;salta a menu en caso de no elegui ninguna anterior

		suma:								
			write num,lenght_num						
			mov ecx, n1 
			mov edx, 2
			call entrada
			write num,lenght_num
			mov ecx, n2 
			mov edx, 2
			call entrada

			mov al, [n1]
			sub al,'0'
			mov bl, [n2]
			sub bl,'0'

			add al, bl

			add al, '0'
			mov [n1], al

			write n1,1

			jmp menu

		resta:
			write num,lenght_num
			mov ecx, n1 
			mov edx, 2
			call entrada

			write num,lenght_num
			mov ecx, n2 
			mov edx, 2
			call entrada

			mov al, [n1]
			sub al,'0'
			mov bl, [n2]
			sub bl,'0'

			cmp al, bl
			ja  sigue

			mov cl, al
			mov al, bl
			mov bl, cl

		sigue:
			sub al, bl
			add al, '0'
			mov [n1], al
			write n1,1
			jmp menu

		salir:
			write msj_salir, lenght_salir
			mov eax, 1  
			xor ebx, ebx 
			int 0x80