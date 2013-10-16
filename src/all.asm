segment .data
intf db "%d",10,0
k dd 64


segment .text
global invert
global atleast
global edge
global clear
global contrast
global brightness
extern printf

brightness:
	
	push ebp			
	mov ebp, esp	
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor ebx, ebx		;ebx is cleared
	add ebx, [ebp+20]	;value is assigned to ebx
	mov esp, [ebp+8]	;the address of image is pointed by esp
	
loopb:
	dec ecx				;counter is decremented
	add dword [esp], ebx;values are assigned to image pixel
	inc esp				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loopb
	
	mov esp, ebp		;return procedures
	pop ebp
	ret



contrast:
	
	push ebp			
	mov ebp, esp	
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor ebx, ebx		;ebx is cleared
	add ebx, [ebp+20]	;value is assigned to ebx
	mov esp, [ebp+8]	;the address of image is pointed by esp
	
loopco:
	dec ecx				;counter is decremented
	mov eax, ebx		;value is assigned to eax
	mul dword [esp]     ;values is assigned to image pixel
	div dword[k]		;
	mov dword [esp], eax;
	inc esp				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loopco
	
	mov esp, ebp		;return procedures
	pop ebp
	ret


clear:
	
	push ebp			
	mov ebp, esp	
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor ebx, ebx		;ebx is cleared
	add bl, [ebp+20]	;value is assigned to ebx
	mov edx, [ebp+8]	;the address of image is pointed by esp
	
loopc:
	dec ecx				;counter is decremented	
	mov byte [edx], bl;values is assigned to image pixel
	inc edx				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loopc
	
	mov esp, ebp		;return procedures
	pop ebp
	ret



invert:
	
	push ebp			
	mov ebp, esp	
	mov ecx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ecx				;# of pixels
	mov ecx, eax		;counter is set
	mov edx, dword [ebp+8]	;the address of image is pointed by esp	
loopi:
	xor al, al		;eax is cleared
	add al, 255
	dec ecx				;counter is decremented
	sub al, byte[edx]	;substraction from 255		
	mov byte [edx],al	;writing the result of substraction,
	inc edx				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loopi
	mov esp, ebp		;return procedures
	pop ebp
	ret
	
atleast:
	
	push ebp			
	mov ebp, esp	
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor bl, bl		;ebx is cleared
	add bl, [ebp+20]	;value is assigned to ebx
	mov edx, [ebp+8]	;the address of image is pointed by esp
	xor eax, eax		;eax =0
	
loopa:
	dec ecx				;counter is decremented
	cmp byte [edx], bl;compare with the value
	jb loopa2
	inc eax

loopa2:	
	inc edx				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loopa
	
	mov esp, ebp		;return procedures
	pop ebp
	ret
	
	
	
edge:
	
	push ebp			
	mov ebp, esp	
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor ebx, ebx		;ebx is cleared
	mov edx, [ebp+8]	;the address of image is pointed by esp
	
looping:
	dec ecx				;counter is decremented
	cmp [edx], ebx;values is assigned to image pixel
	jg	white
	mov dword [edx], 0
ending:	
	inc edx				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne looping
	
	mov esp, ebp		;return procedures
	pop ebp
	ret
white:
	mov dword [edx], 255
	jmp ending
