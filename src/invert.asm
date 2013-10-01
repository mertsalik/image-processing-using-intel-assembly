


segment .text
global invert


invert:
	push ebp
	mov ebp, esp


	mov esp, ebp
	pop ebp
	ret

