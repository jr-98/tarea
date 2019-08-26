;Suma de arreglo, suma los valores del arreglo
%macro write 2 
	mov eax, 4 
	mov ebx, 1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .data
	datos db 0xA," El arreglo es x = [3,2,3,1]",0xA
	lenght_datos equ $-datos

	msj1 db 0xA,"La suma del arreglo es =   "
	lenght_msj1 equ $-msj1
	salto db 0xA, "          ",0xA
	lenght_enter equ-salto
	arreglo db 3,2,3,1
	la equ $-arreglo
section .bss
	suma resb 1
	respuesta resb 1
	
section .text
		global _start
			_start:

			l1:		
				push ecx
				mov al, [arreglo+ecx]
				add al,[suma]	
				mov [suma],al
				
				pop ecx
				inc ecx
				cmp ecx, la
				jb l1

			 	mov al,[suma]
				add al,'0'
				mov [suma],al
				
				write datos, lenght_datos	;presenta el arreglo 
				write msj1, lenght_msj1		;mensaje de oresentacion
				write suma, 1		        ;resultado
				write salto, 1			    ;enpacio entre la linea de comando y la respuesta

				jmp salir
			salir:
				mov eax,1
				mov ebx,0
				int 80h

