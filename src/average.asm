


segment .text
global average

average:
	push ebp
	mov ebp, esp


	mov esp, ebp
	pop ebp
	ret
