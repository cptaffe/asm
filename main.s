
.globl start
start:
movq $0x9, %rax // mmap
xorq %rdi, %rdi // addr: null
movq $0x1000, %rsi // len: a page
movq $0x3, %rdx // prot: PROT_READ | PROT_WRITE
movq $0x2, %r10 // flags: MAP_PRIVATE
movq $0xffffffff, %r8 // fd: -1
movq $0x0, %r9 // offset: 0
syscall
cmpq $0x0, %rax
jg .mmapnoerr
// damn you mmap!
movq %rax, %rdi
movq $0xc3, %rax
syscall
.mmapnoerr:
movq %rax, %rbp
movq %rbp, %rsp
pushq %rbp
pushq $0x1
pushq $0x2
// exit
movq $0x0, %rdi
movq $0xc3, %rax
syscall
