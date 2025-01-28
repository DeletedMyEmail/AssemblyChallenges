section .text
	default rel
	extern printf
  	global main
	
main:
	push rbp
	mov rbp, rsp
	sub rsp, 32

	mov dword [rbp-4], 15
	mov dword [rbp-8], 11
	mov dword [rbp-12], 7
	mov dword [rbp-16], 2
	mov dword [rbp-20], 9	; target
	mov dword [rbp-24], 0	; i
	mov dword [rbp-28], 0 	; j
	jmp .l1

.l1:
	; j = i+1
	mov eax, dword [rbp-24]
	inc eax
	mov [rbp-28], eax

	cmp dword [rbp-24], 4
	jne .l2

	lea rdi, [rel msg]
	xor rax, rax	
    call printf wrt ..plt

	jmp .exit

.l2:
	cmp dword [rbp-28], 4
	jne .l3

	inc dword [rbp-24]
	jmp .l1

.l3:
	; sum = arr[i] + arr[j]
	mov esi, dword [rbp-24]
	mov eax, dword [rbp-16 + rsi*4]
	
	mov esi, dword [rbp-28]
	add eax, dword [rbp-16 + rsi*4]

	; sum != target => next j iteration
	cmp eax, dword [rbp-20]
	jne .l4

	; sum == target => print target, i and j
	lea rdi, [rel fmt]
    mov	esi, dword [rbp-20]
	mov edx, dword [rbp-24] 
	mov ecx, dword [rbp-28]
	xor rax, rax	
    call printf wrt ..plt

	jmp .exit

.l4:
	inc dword [rbp-28]
	jmp .l2

.exit:
	mov rsp, rbp
	pop rbp
	mov rax, 60
	xor rdi, rdi
	syscall

section .data
    fmt: db "Target: %d, i: %d, j: %d", 10, 0
	msg: db "Not found", 10, 0
