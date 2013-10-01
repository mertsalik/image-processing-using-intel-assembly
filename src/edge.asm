


segment .text
global edge


edge:
	push ebp
	mov ebp, esp


	mov esp, ebp
	pop ebp
	ret

