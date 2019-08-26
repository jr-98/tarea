%macro write 2                 ;macro para escribir em pamtalla              
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro
push ebx
section .data
	new_line db 10, ''         ;sirve para dar un salto de linea
	file db "/home/jonathanrtj/Documents/practicas/Assambler/Practica2.0/files/txtEjercicio3.txt",0
section .bss
	result resb 30			   ;Variable para almacenar la respuesta
	idarchivo resb 1           ;Identificador de archivo, escudo fisico
section .text
	global _start
		_start:
			mov eax, 8    		;sevicio para trabajar con el archivo
			mov ebx, file 		;La adireccion del archivo o identificador
			mov ecx, 1  		;MOdo de acceso
			mov edx, 777h    	;permission
			int 80h

			test eax, eax	 	;El identificador es el objeto tipo archivo
			jz salir
			mov dword [idarchivo], eax	;open file 	
			mov ecx,9			;valores iniciales de la piramide, se iran decrementando hasta llegar a 0
			mov ebx,9
		l1:                     ;imprimir eNTER Y evaluar cada fila
			push ecx			;Guarda los valores iniciales de ecx y ebx
			push ebx
			call print_enter    ;se reemplaza el valore de cx por enter y el valor de bx por 1
			pop ecx				;devuelve el valor almacenado en la pila a ecx
			mov ebx, ecx		;realiza un intercambio entre ecx y ebx
			push ebx
		l2:                     ;Imprimir el numero y evaluar cada columna
			push ecx
			add ecx, '0'        ;Transforma de Cadena a entero
			mov [result], ecx   ;mueve el calo de ecx (el numero actual de la piramide)a la variable result
			mov ecx, result
			call print_number   ;se reemplaza el valore de cx por number y el valor de bx por 1 
			pop ecx
			loop l2				;Ciclo del l2
			;--------___------___fin de l2
			pop ebx				;Se asignas los ultomos valores almacenados en la pila 
			pop ecx
			dec ebx
			loop l1				;ciclo de l1
		print_enter:
			write new_line, 1    ;imprime el salto de linea
			ret
		print_number:		     	
			mov eax, 4
			mov ebx, [idarchivo]
			mov ecx, result
			mov edx, 10
			int 80h
			ret	

		salir:
			mov eax, 1
			mov ecx, 0
			int 80h																	
