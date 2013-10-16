segment .text
global edge


edge:
	
	push ebp			
	mov ebp, esp	
	mov ebx, [ebp+12]	;for width
	mov dword[width],ebx
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	sub eax, ebx		;top row is substracted from width*height
	mov ecx, eax		;counter is set without top row
	mov edx, [ebp+8]	;the address of image is pointed by esp
	add ebx, edx		;width+address
	xor eax,eax			;eax is cleaned for use of al
looping:
	dec ecx				;counter is decremented
	mov al,byte[ebx]	;upper pixel -> pixel[i+width]
	cmp byte [edx],al	;compare pixel[i] and pixel[i+width]
	ja	white			;if smaller then jump white
	mov byte [edx], 0	;else it becomes black
ending:		
	inc edx				;next pixel
	inc	ebx				;next pixel from the above row
	cmp ecx,0			;if image isnot completed then jump back 
	jne looping		
	mov ecx,[width]		;counter is set for the top row
inloop:
	dec ecx				;ebx keeps width and decremented because there is one row at the top
	mov byte[edx],0		;and all pixels at the top row become black
	inc edx
	cmp ecx,0		
	jne inloop
				
	mov esp, ebp		;return procedures
	pop ebp
	ret
white:
	mov byte [edx], 255
	jmp ending


