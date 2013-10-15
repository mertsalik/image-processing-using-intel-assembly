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
	mov ebx, [ebp+16]
	mov eax, [ebp+20]
	mul ebx			; # of pixels
	mov ecx, eax		; set the counter
	xor ebx, ebx		; clear ebx
	mov ebx, [ebp+12]	; the address of second image is in ebx
	mov esp, [ebp+8]	; the address of image is in esp

loop:
	dec ecx			; counter is decremented
	mov eax, dword [esp]	; get pixel value

	mov dword [ebx], eax	; then assign it 4 times
	inc ebx			;
	mov dword [ebx], eax	;
	inc ebx			;
	mov dword [ebx], eax	;
	inc ebx
	mov dword [ebx], eax	;
	inc ebx

	inc esp			; next pixel
	cmp ecx,0		; if is not completed
	jne loop

	mov esp, ebp
	pop ebp
	ret

