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

segment .bss
image1 	resb 1				; pointer for image1 unsigned char array
image2 	resb 1				; pointer for image2 unsigned char array
width 	resd 1				; image1 width
height	resd 1				; image1 height
w2	resd 1				; new width
h2	resd 2				; new height

segment .data
intf db "%d", 10, 0			; for printf

segment .text
global grow
extern printf

grow:
	push ebp
	mov ebp, esp
	sub esp, 8

	mov eax, [ebp+20]
	mov [height], eax		; get height of image1
	shl eax, 1
	mov [h2],eax
	mov eax, [ebp+16]
	mov [width], eax		; get width of image2
	shl eax, 1
	mov [w2], eax

	push dword [h2]			; lets print height
	push intf
	call printf
	add esp, 8

	push dword [w2]			; lets print width
        push intf
        call printf
        add esp, 8

	mov esp, ebp
	pop ebp
	ret

