segment .text
global clear
extern printf

clear:
	push ebp			
	mov ebp, esp
	
	push ebx			;stored in stack	
	mov ebx, [ebp+12]	;for width
	mov eax, [ebp+16]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor ebx, ebx		;ebx is cleared
	add bl, [ebp+20]	;value is assigned to ebx
	mov edx, [ebp+8]	;the address of image is pointed by edx
	
loop:
	dec ecx				;counter is decremented	
	mov byte [edx], bl	;values is assigned to image pixel
	inc edx				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loop
	
	pop ebx				; take back its first value
	mov esp, ebp		;return procedures
	pop ebp
	ret
