segment .text
global edge


edge:
	
	push ebp			
	mov ebp, esp	
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor ebx, ebx		;ebx is cleared
	add ebx, [ebp+20]	;value is assigned to ebx
	mov edx, [ebp+8]	;the address of image is pointed by esp
	
looping:
	dec ecx				;counter is decremented
	cmp [edx], ebx;values is assigned to image pixel
	jg	white
	mov dword [edx], 0
ending:	
	inc edx				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loop
	
	mov esp, ebp		;return procedures
	pop ebp
	ret
white:
	mov dword [edx], 255
	jmp ending



