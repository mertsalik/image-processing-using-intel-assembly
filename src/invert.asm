segment .text
global invert


invert:
	
	push ebp			
	mov ebp, esp	
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor ebx, ebx		;ebx is cleared
	add ebx, 255		;value is assigned to ebx
	mov edx, [ebp+8]	;the address of image is pointed by esp
	
loop:
	dec ecx				;counter is decremented
	sub ebx, [edx]		;substraction from 255
	mov dword [edx],ebx	;writing the result of sub
	inc edx				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loop
	
	mov esp, ebp		;return procedures
	pop ebp
	ret


