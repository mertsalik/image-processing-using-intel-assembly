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
        push esi				; store esi in stack
        push ebx				; store ebx in stack
        
        mov esi, dword [ebp+16]			; height in esi

        mov esp, [ebp+8]        		; the address of image is in esp

looph:
        dec esi                        		; decrement i
        dec esi                        		; decrement i

	mov ecx, dword [ebp+12]			; width
        loopw:
		dec ecx				; decrement j
		dec ecx				; decrement j
		
		xor eax, eax			; clean eax register
		xor ebx, ebx			; clean ebx register
		xor edx, edx			; clean edx register
		mov al, byte [esp]		; get 0. pixel in al
		inc esp				; next pixel
		mov bl, byte [esp]		; get 1. pixel in bl
		add ax, bx			; add them in ax
		dec esp	
		add esp, dword [ebp+12]		; go to next line (i+width)
		mov bl, byte [esp]		; get 2. pixel in bl
		inc esp				; next pixel
		mov dl, byte [esp]		; get 3. pixel in dl
		add bx, dx			; add them in bx
		add ax, bx			; sum of all pixels in ax
		
		shr eax, 2			; shift right two times (divide 4)
		
		mov byte [esp], al		; store 3. pixel
		dec esp
		mov byte [esp], al		; store 2. pixel
		sub esp, dword [ebp+12]
		mov byte [esp], al		; store 0. pixel
		inc esp
		mov byte [esp], al		; store 1. pixel
		
		
		inc esp				; next pixel of image
		
		cmp ecx, 0 			; if j!=0
		jne loopw			; iterate in loopw
		; end of loopw
	
	add esp, dword [ebp+12]			; have to move image index current + width
	
	cmp esi, 0				; if i!=0
	jne looph				; iterate in looph
	; end of looph

	pop ebx					; get back ebx from stack
	pop esi					; get back esi from stack
        mov esp, ebp
        pop ebp
        ret

