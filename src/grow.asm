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
height	resd 1				; image2 height

intf db "%d", 10, 0			; for printf


segment .text
global grow
extern printf

grow:
	push ebp
	mov ebp, esp
	sub esp, 8

	mov height, [ebp+20]		; get height of image1
	mov width, [ebp+16]		; get width of image2

	push byte [height]		; lets print height
	push intf
	call printf
	add esp, 8

	push byte [width]              ; lets print width
        push intf
        call printf
        add esp, 8

	mov esp, ebp
	pop ebp
	ret
