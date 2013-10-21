segment .text
global brightness

brightness:
	
	push ebp			
	mov ebp, esp	
	
	push ebx			;ebx should remain the same
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor ebx, ebx		;ebx is cleared
	add ebx, [ebp+20]	;value is assigned to bl
	mov edx, [ebp+8]	;the address of image is pointed by edx
	
loopb:
	xor eax, eax		;eax is cleared
	dec ecx				;counter is decremented
	mov al, [edx]		;image pixel is assigned to 8-bit (al)
	add eax, ebx			;add image pixel and value. This registers are 16-bit.Because result can be 16-bit
	cmp eax, 255			;compare ax to evaluate color of pixel. 
	jle test1			;if lower and equal	
	mov eax, 255			;al is assigned to white
	
test1:
	cmp eax, 0			;compare ax to evaluate color of pixel.
	jge forward1		;bigger and equal
	mov eax, 0			;al is assigned to black
	
forward1:
	mov byte[edx], al	;result is written to image pixel
	inc edx				;next pixel
	cmp ecx,0			;if image is not completed then jump back 
	jne loopb
	
	pop ebx				;because ebx is pushed at the begin
	mov esp, ebp		;return procedures
	pop ebp
	ret
