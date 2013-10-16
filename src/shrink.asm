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

		mov ecx, dword [ebp+16]			; w
		mov edx, dword [ebp+20]			; h

		mov ebx, [ebp+12]        		; the address of second image is in ebx
		mov esp, [ebp+8]        		; the address of image is in esp
		
		
looph:
        dec edx                        	;
        dec edx                        	; i = i-2
		
		mov ecx, dword [ebp+16]			; width
        loopw:
			dec ecx						;
			dec ecx						; j = j-2
			
			mov eax, dword [esp]
			mov dword [ebx], eax		; 0
			inc ebx
			inc esp
			inc esp
			
			cmp ecx, 0 					; if j!=0
			jne loopw
		
		mov eax, esp					;
		add eax, dword [ebp+16]			;
		mov esp, eax					; have to move image index currentpixel + width
		
		cmp edx, 0						; if i!=0
		jne looph

		mov esp, ebp
		pop ebp
		ret

