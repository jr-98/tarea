
%macro write 2
   mov eax,4
   mov ebx,1
   mov ecx,%1
   mov edx,%2
   int 80h
%endmacro

%macro read 2             ;macro para leer datos ingresador por teclado
	mov eax, 3
	mov ebx, 2
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

section .data
	num1 db 0xA, "Escriba el primer numero:",0xA
	lenght_num1 equ $-num1
	
	num2 db 0xA,"Escriba el segundo numero:",0xA
	lenght_num2 equ $-num2
	
	sum db "La suma es:"
	lenght_suma equ $ - sum

	msj db 'la suma es: ' 
	len equ $ -msj
	
	suma db ' '
section .bss
	entry1 resb 1		    ;almacena el primer numero
	entry2 resb 1			;almacena el segundo numero
	result resb 1			;almacena el sum
section .text
	global _start
	
			_start:
				write num1, lenght_num1
				read entry1, 10
				write num2, lenght_num2
				read entry2, 10

				mov ecx, 3 ; numero de digitos de cada operando
				mov esi, 2 ; fuente indice
				clc        ; permite poner la bamdera del carri en 0 o apagada, siempre hay que poner para que empiecen las banderas apagadas
				

			ciclo_suma:
				;al ser cadena se empieza con 0
				mov al,[entry1+esi]  ; las suma se la hace en la parte baja y nos colocamos en la ultima posicion
				sub al, '00'
				sub bl, '00'
				sub ah, '00'
				sub bh, '00'
				adc al,[entry2+esi]  ; adc activa el carri.... hace l suma normal + el carry, es decir al(7)+entry2+esi(6)+cf
				aaa		 ; ajusta la suma cuando exite un carri
						 ; suma a AL 6 digitos y AH 1 suma el acarreo
						 ; se aplica despues de una suma con carreo 
						 ; y suma el contenido de la bandera de carry 
						 ; al primer operando y despues al segundo
				
				
				pushf		;push flat, guarda el estado de todas las banderas ala pila, es necesario ver el orden de las banderas
				or al, 30h      ;convierte de un caracter a un decimal, es similar 
				popf		; restaura le estado de las baderas de la pila hacia las banderas
			       	mov[suma+esi],al
			       	mov[result+esi], al
			        dec esi
			        loop ciclo_suma

			        write msj,len
				    write result,3
			salir:
	        mov eax, 1
	        mov ebx, 0
	        int 80h