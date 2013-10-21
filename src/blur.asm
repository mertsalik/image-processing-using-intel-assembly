;	Author: 	mertsalik
;	mail:		salik@itu.edu.tr

;	blur() is an antialiasing filter normally applied before shrink(). The image is divided into 2 by 2
;	blocks. The 4 pixels in each block are replaced with the average of those 4 pixels (rounding up or
;	down as you choose).

; 	PROTOTYPE
;	void blur(unsigned char *image, int width, int height);


;	STACK
;	|	ebp	|
;	| return address|
;	|	i1	|
;	|	w	|
;	|	h	|



segment .text
global blur

blur:
		push ebp
        mov ebp, esp
        push esi
        push ebx
        
        mov ecx, dword [ebp+12]			; w
        mov esi, dword [ebp+16]			; h

        mov esp, [ebp+8]        		; the address of image is in esp

looph:
        dec esi                        	; decrement i
        dec esi                        	; decrement i
		
		mov ecx, dword [ebp+12]			; width
        loopw:
			dec ecx						; decrement j
			dec ecx						; decrement j
			
			
			xor eax, eax
			xor ebx, ebx
			xor edx, edx
			mov al, byte [esp]		; 0
			inc esp
			mov bl, byte [esp]		; 1
			add ax, bx				; -> ax
			dec esp
			add esp, dword [ebp+12]
			mov bl, byte [esp]		; 2
			inc esp
			mov dl, byte [esp]		; 3
			add bx, dx				; -> bx
			add ax, bx				; -> ax
			
			shr eax, 2					; buggy 
			
			mov byte [esp], al		; 3
			dec esp
			mov byte [esp], al		; 2
			sub esp, dword [ebp+12]
			mov byte [esp], al		; 0
			inc esp
			mov byte [esp], al		; 1
			
			
			inc esp
			
			cmp ecx, 0 					; if j!=0
			jne loopw
		
		add esp, dword [ebp+12]			; have to move image index current + width
		
		cmp esi, 0						; if i!=0
		jne looph

		pop ebx
		pop esi
        mov esp, ebp
        pop ebp
        ret
