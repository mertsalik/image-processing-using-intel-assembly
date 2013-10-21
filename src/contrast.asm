segment .text
global contrast

contrast:
        
		push ebp			
		mov ebp, esp	
		
		push ebx
		mov ebx, [ebp+12]	;for width
		mov eax, [ebp+16]	;for height
		mul ebx				;# of pixels
		mov ecx, eax		;counter is set
		xor ebx, ebx		;ebx is cleared
		add bl, [ebp+20]	;value is assigned to bl
		mov edx, [ebp+8]	;the address of image is pointed by edx
	
        
loop:
		xor eax, eax		;eax is cleared in each loop
		dec ecx             ;counter is decremented
		mov al, [edx]       ;image pixel is assigned to al
		mul bl 				;multiply by bl
		shr eax,6			;divide by 64
			
		
		cmp ax, 255			;compare ax with 255 
		jbe test			;if lower and equal	
		mov al, 255			;al is set to white
	
test:	
		cmp al, 0			;compare ax with 0 
		jae forward			;bigger and equal
		mov al, 0			;al is set to black
	
forward:
		mov byte[edx], al	;image pixel is set to al 
		inc edx				;next pixel
		cmp ecx,0			;if image isnot completed then jump back 
		jne loop
	
        pop ebx			;because ebx is pushed at the begin
        mov esp, ebp    ;return procedures
        pop ebp
        ret
