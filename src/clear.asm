


segment .text
global clear


clear:
	push ebp
	mov ebp, esp


	mov esp, ebp
	pop ebp
	ret

