



segment .text
global shrink


shrink:
	push ebp
	mov ebp, esp


	mov esp, ebp
	pop ebp
	ret

