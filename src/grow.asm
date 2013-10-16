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
        
        mov ecx, dword [ebp+16]			; w
        mov edx, dword [ebp+20]			; h

        mov ebx, [ebp+12]        		; the address of second image is in ebx
        mov esp, [ebp+8]        		; the address of image is in esp

looph:
        dec edx                        	; decrement i
		
		mov ecx, dword [ebp+16]			; width
        loopw:
			dec ecx
			
			mov eax, dword [esp]
			mov dword [ebx], eax		; 0
			inc ebx
			mov dword [ebx], eax		; 1
			dec ebx
			add ebx, dword [ebp+16]
			add ebx, dword [ebp+16]
			mov dword [ebx], eax		; 2
			inc ebx
			mov dword [ebx], eax		; 3
			inc ebx
			sub ebx, dword [ebp+16]
			sub ebx, dword [ebp+16]
			
			inc esp
			cmp ecx, 0 					; if j!=0
			jne loopw
		
		add ebx, dword [ebp+16]			; have to move newimage index width*2
		add ebx, dword [ebp+16]
		
		cmp edx, 0						; if i!=0
		jne looph

        mov esp, ebp
        pop ebp
        ret
