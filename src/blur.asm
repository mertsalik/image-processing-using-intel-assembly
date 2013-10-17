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
        
        mov ecx, dword [ebp+12]			; w
        mov ebx, dword [ebp+16]			; h

        mov esp, [ebp+8]        		; the address of image is in esp

looph:
        dec ebx                        	; decrement i
        dec ebx                        	; decrement i
		
		mov ecx, dword [ebp+12]			; width
        loopw:
			dec ecx						; decrement j
			dec ecx						; decrement j
			
			
			xor eax, eax
			add eax, dword [esp]		; 0
			inc esp
			add eax, dword [esp]		; 1
			dec esp
			add esp, dword [ebp+12]
			add eax, dword [esp]		; 2
			inc esp
			add eax, dword [esp]		; 3
			
			sar eax, 2					; buggy 
			
			mov dword [esp], eax		; 3
			dec esp
			mov dword [esp], eax		; 2
			sub esp, dword [ebp+12]
			mov dword [esp], eax		; 0
			inc esp
			mov dword [esp], eax		; 1
			
			
			inc esp
			
			cmp ecx, 0 					; if j!=0
			jne loopw
		
		add esp, dword [ebp+12]			; have to move image index current + width
		
		cmp ebx, 0						; if i!=0
		jne looph

        mov esp, ebp
        pop ebp
        ret
