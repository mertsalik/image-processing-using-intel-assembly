
segment .text
global contrast
extern printf

segment .data
k dd 64

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
	
loop:
	dec ecx				;counter is decremented
	mov eax, ebx		;value is assigned to eax
	mul dword [esp]     ;values is assigned to image pixel
	div dword[k]		;
	mov dword [esp], eax;
	inc esp				;next pixel
	cmp ecx,0			;if image isnot completed then jump back 
	jne loop
	
	mov esp, ebp		;return procedures
	pop ebp
	ret


