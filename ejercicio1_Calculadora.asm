;suma y resta de dos digitos aplicando macros (Sin desbordamiento ni acarreos)
%macro write 2             ;macro para escribir en pantalla
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro
%macro read 2             ;macro para leer datos ingresador por teclado
	mov eax, 3
	mov ebx, 2
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

section .data
	msj1 db "Ingrese el primer número: ",0xA                
	lenght1 equ $ - msj1
	msj2 db "Ingrese el segundo número: ",0xA                
	lenght2 equ $ - msj2
	msj3 db "la          es:", 0xA                
	lenght3 equ $ - msj3 
	salto db 10," ",0xA
section  .bss
	entry1 resb 1		    ;almacena el primer numero
	entry2 resb 1			;almacena el segundo numero
	result resb 1			;almacena el resultado

section .text
	global _start
			_start:
			write msj1, lenght1	
			read entry1, 10         	;se almacena el primer numero ingresado por teclado

			write msj2, lenght2
			read entry2, 10        	    ;se almacena el segundo numero ingresado por teclado

		suma:		
			mov ax, [entry1]
			mov bx, [entry2]
			sub ax, '0'					;Conviente de string a int
			sub bx, '0'				
			add ax, bx					;opereacion suma			
			add ax, '0'					;Convierte de int a string
			mov [result], ax			;Mueve el valor de la suma a la variable result
			mov [msj3 + 5],dword 'suma'	;
			write msj3, lenght3	    	;imprime el tercer mensaje
			write result, 1 			;imprime el resultado de la suma 
			write salto, 1
		resta:	
			mov ecx, 0
			mov ax, [entry1]
			mov bx, [entry2]
			sub ax, '0'
			sub bx, '0'
			sub ax, bx					;operacion resta
			add eax, '0'
			mov [result], ax
			mov [msj3 + 3],dword 'rest'
			write msj3, lenght3 		;imprime el cuarto mensaje
			write result, 1  	    ;imprime el resultado de la resta
			write salto, 1
		multiplicar:
			mov ecx, 0
			mov ax,[entry1]
			mov bx,[entry2]
			sub ax, '0'
			sub bx, '0'
			mul bx						;operacion multiplicacion	
			add ax, '0'
			mov [result], eax
			mov [msj3 + 3],dword 'mult'
			mov [result], ax
			write msj3, lenght3 
			write result, 1  
			write salto, 1
		dividir:
			mov ecx, 0
			mov al, [entry1]
			mov bl, [entry2]
			sub al, '0'
			sub bl, '0'
			div bl 						;operacion de la divicion al/bl
			add al, '0'
			add ah, '0'					;porque almacena tanto el recisup como el cociente al(cociente) ah(resuduo)
			mov [result], al 
			mov [msj3 + 3],dword 'div'	
			write msj3, lenght3 		
			write result, 1   	    
			write salto, 1	
		salir:	
			mov eax, 1
			mov ebx, 0
			int 0x80                 	;llamada de la interrupcion 80h 