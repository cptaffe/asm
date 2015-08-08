
	global _start

	section .text

_start:
	mov rax, 9      ; mmap
	xor rdi, rdi    ; addr: null
	mov rsi, 0x1000 ; len: a page
	mov rdx, 0x3    ; prot: PROT_READ | PROT_WRITE
	mov r10, 0x22   ; flags: MAP_PRIVATE | MAP_ANONYMOUS
	mov r8, -1      ; fd: -1
	xor r9, r9      ; offset: 0
	syscall
	cmp rax, 0
	jg .mmapnoerr

	; mmap has failed, exit with syscall
	mov rdi, rax
	neg rdi ; mmap returns -errno
	mov rax, 60
	syscall

.mmapnoerr:
	add rax, 0x1000 ; top of stack
	mov rbp, rax
	mov rsp, rbp
	push rbp
	; exit
	xor rdi, rdi
	mov rax, 60
	syscall
