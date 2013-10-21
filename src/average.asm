segment .text
global average
extern printf

average:
	
	push ebp			
	mov ebp, esp
	
	push ebx			;ebx should remain the same
	push esi			;esi should remain the same
	mov ebx, [ebp+16]	;for width
	mov eax, [ebp+20]	;for height
	mul ebx				;# of pixels
	mov ecx, eax		;counter is set
	xor esi, esi		;ebx is cleared
	add esi, [ebp+12]	;image2 is assigned to esi
	mov edx, [ebp+8]	;the address of image is pointed by esp
	
loop:
	xor ebx,ebx			;ebx is cleared
	xor eax, eax		;eax is cleared
	dec ecx				;counter is decremented
	mov al,[edx]		;image pixel is assigned to al
	mov bl, [esi]		;image2 is assigned to bl
	add ax, bx			;added value of image1 and image2
	inc ax				;increment result
	shr eax, 1			;divide 2
	mov byte[edx], al	;result is written back to image pixel
	inc edx				;next pixel image1
	inc esi				;next pixel image2
	cmp ecx,0			;if image isnot completed then jump back 
	jne loop
	
	pop ebx				;because ebx is pushed at the begin
	pop esi				;because esi is pushed at the begin
	mov esp, ebp		;return procedures
	pop ebp
	ret
