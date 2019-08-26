%macro write 2
	mov eax, 4 
	mov ebx, 1
	mov ecx, %1 
	mov edx, %2
	int 0x80
%endmacro

section .data 
	options db 0xA,0xA,"menu:", 0xA,0x9, "1)mostrar en pantalla", 0xA,0x9, "2)no mostar en pantalla", 0xA,0x9, "3)salir",0xA,0xA,0x9   ;opciones de munu
	lenght_op equ $- options            

	msj1 db 0xA,0x9,"PASSWORD: "
	lenght_msj1 equ $- msj1

	msj2 db  0xA,0x9,"saliendo... "
	lenght_msj2 equ $- msj2

	file db "/home/jonathanrtj/Documents/practicas/Assambler/Practica2.0/files/contrasenas.txt",0

	hind  db 0x1b, "[37;47;3m"        ;escribe sobre el texto una pelicual de color para evitar que los caracteres sean visibles
	lenght_hind equ $- hind

	black db 0x1b, "[15;1;3m"        ;evita que la pantalla permanesca siempre blanca
	lenght_black equ $- black

section .bss
	password resb 10
	idarchivo resd 1				; identificador de archivo sirve como barrera fisica 
	id resb 1
	Contenido resb 16384

section .text
	entrada:						;lee los datos del teclado
		mov eax, 3 
		mov ebx, 0
		int 0x80
		ret

	global _start  
_start:  

	mov eax,8           ;Apertura del the number of the syscall 'open'
	mov ebx,file        ;La adireccion del archivo o identificador
	mov ecx, 2  		;MOdo de acceso
	mov edx, 7777h		;permisos
	int 80h      		      

	test eax, eax		;sale si no encuentra el archivo
	jz salir			;llama a la etiqueta salir

	mov dword[idarchivo] , eax
	add eax, '0'
	mov [id], eax


menu:
	write options,lenght_op
	mov ecx, password  
	mov edx, 2
	call entrada						;llama a la entrada para leer los caracteres ingresados
	mov al, [password]
	sub al, '0'
	cmp al, 2
	jb show_pass
	ja salir 
	je hind_pass
	jmp menu

show_pass:
	write msj1,lenght_msj1
	
	mov ecx, password  
	mov edx, 10
	call entrada

	write password, 10

	mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, password
	mov edx, 10
	int 80h

	jmp menu

hind_pass:
	
	write msj1,lenght_msj1
	write hind, lenght_hind

	mov ecx, password  
	mov edx, 10
	call entrada

	write password, 10

	mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, password
	mov edx, 10
	int 80h
	write black, lenght_black
	jmp menu
salir:

	write msj2, lenght_msj2		;imprime el mensaje de salir

	mov eax, 6 
	mov ebx, [idarchivo]
	mov ecx, 0
	mov edx, 0
	int 80h

	mov eax, 1  
	xor ebx, ebx 
	int 0x80