segment .text
global invert


invert:
	push ebp			
	mov ebp, esp
	
	push ebx			;store ebx in stack
	mov ecx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ecx				;# of pixels 
	mov ecx, eax		;counter is set with # pixels
	mov edx, dword [ebp+8]	;the address of image is pointed by edx	
loop:
	xor al, al			;al is cleared
	add al, 255			;al=255
	dec ecx				;counter is decremented
	sub al, byte[edx]	;substraction from 255---  al=255-pixel[i]	
	mov byte [edx],al	;writing the result of substraction,
	inc edx				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loop
	
	pop ebx				;ebx take back its first value
	mov esp, ebp		;return procedures
	pop ebp
	ret
