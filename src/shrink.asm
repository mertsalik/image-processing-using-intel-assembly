;	Author: 	mertsalik
;	mail:		salik@itu.edu.tr

;	This  function is the opposite of grow().  The function shrinks the image by sampling every other
;	pixel horizontally and vertically. The result should be placed in newimage, which has dimensions
;	width/2 by height/2 and points to an array of width*height/4 bytes. The sampled pixels should have
;	even numbered indices both horizontally and vertically, i.e. should sample the lower left corner of
;	each 2 by 2 block.

; 	PROTOTYPE
;	void shrink(unsigned char *image, unsigned char *newimage, int width, int height);


;	STACK
;	|	ebp	|
;	| return address|
;	|	i1	|
;	|	i2	|
;	|	w	|
;	|	h	|

segment .text
global shrink


shrink:
	push ebp
	mov ebp, esp
	push ebx

	mov edx, dword [ebp+20]			; h

	mov ebx, [ebp+12]        		; the address of second image is in ebx
	mov esp, [ebp+8]        		; the address of image is in esp
		
		
looph:
        dec edx                        		; decrement
        dec edx                        		; i = i-2
	mov ecx, dword [ebp+16]			; get width to ecx
        loopw:
		dec ecx				; decrement
		dec ecx				; j = j-2
		
		mov eax, dword [esp]		; get current pixel
		mov dword [ebx], eax		; store in new image
		inc ebx				; next pixel of new image in ebx
		inc esp				; have to move 2 pixel right
		inc esp				; 
		
		cmp ecx, 0 			; if j!=0
		jne loopw			; iterate in loopw
		; end of loopw
		
	mov eax, esp				; esp -> eax
	add eax, dword [ebp+16]			; next line ptr of image in esp
	mov esp, eax				; have to move image index currentpixel + width
	
	cmp edx, 0				; if i!=0
	jne looph				; iterate in looph
	; end of looph

	pop ebx					; get old ebx value back
	mov esp, ebp
	pop ebp
	ret

