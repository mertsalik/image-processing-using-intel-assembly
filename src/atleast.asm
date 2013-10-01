


segment .text
global atleast

atleast:
	push ebp
	mov ebp, esp


	mov esp, ebp
	pop ebp
	ret
