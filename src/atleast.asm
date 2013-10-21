segment .text
global atleast


atleast:
	
	push ebp			
	mov ebp, esp
	
	push ebx			;stored in stack
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor bl, bl			;ebx is cleared
	add bl, [ebp+20]	;value is assigned to ebx
	mov edx, [ebp+8]	;the address of image is pointed by esp
	xor eax, eax		;eax =0
	
loop:
	dec ecx				;counter is decremented
	cmp byte [edx], bl	;compare with the value
	jb loop2			;if jump occurs it wont be count
	inc eax				;it is counted
loop2:					
	inc edx				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loop
	
	pop ebx
	mov esp, ebp		;return procedures
	pop ebp
	ret
