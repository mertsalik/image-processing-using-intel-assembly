;	Author: 	mertsalik
;	mail:		salik@itu.edu.tr

;	This fuction doubles the size of image and puts the result in newimage. 
;	The new image should have dimensions  of  width*2  by  height*2.  
;	You  may  assume  newimage  points  to  an  array  of width*height*4 
;	bytes. Expand the image by copying each pixel  4 times (twice horizontaly 
;	and twice vertically).

; 	PROTOTYPE
;	void grow(unsigned char *i1, unsigned char *i2, int w, int h);


;	STACK
;	|	ebp	|
;	| return address|
;	|	i1	|
;	|	i2	|
;	|	w	|
;	|	h	|


segment .text
global grow

grow:
        push ebp
        mov ebp, esp
        push ebx				; store ebx in stack
        
        mov edx, dword [ebp+20]			; height in edx

        mov ebx, [ebp+12]        		; the address of second image is in ebx
        mov esp, [ebp+8]        		; the address of image is in esp

looph:
        dec edx                        		; decrement i	
	mov ecx, dword [ebp+16]			; get width to ecx
        loopw:
		dec ecx				; decrement j
			
		mov eax, dword [esp]		; get current pixel to eax

		mov dword [ebx], eax		; save 0. pixel
		inc ebx
		mov dword [ebx], eax		; save  1. pixel
		dec ebx

		add ebx, dword [ebp+16]		; move to next line of new image
		add ebx, dword [ebp+16]		; (width * 2)

		mov dword [ebx], eax		; save 2. pixel
		inc ebx
		mov dword [ebx], eax		; save 3. pixel
		inc ebx

		sub ebx, dword [ebp+16]		; turn back to previous line
		sub ebx, dword [ebp+16]		; (width * 2)
		
		inc esp				; next pixel
		cmp ecx, 0 			; if j!=0
		jne loopw			; iterate in loopw
		; end of loop w
		
	add ebx, dword [ebp+16]			; have to move newimage index width*2
	add ebx, dword [ebp+16]
	
	cmp edx, 0				; if i!=0
	jne looph				; iterate in looph
	; end of loop h

	pop ebx					; store old ebx back
        mov esp, ebp				
        pop ebp					; store old ebp back
        ret
