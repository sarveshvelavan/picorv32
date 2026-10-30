    .section .crt0, "ax", @progbits
    .globl _start
    .type _start, @function
_start:
    la sp, _estack
    /* Copy initialized data from its ROM load address to RAM. */
    la t0, _sidata
    la t1, _sdata
    la t2, _edata
.Lcopy_data:
    bgeu t1, t2, .Lclear_bss
    lw t3, 0(t0)
    sw t3, 0(t1)
    addi t0, t0, 4
    addi t1, t1, 4
    j .Lcopy_data
    /* Clear zero-initialized data in RAM. */
.Lclear_bss:
    la t0, _sbss
    la t1, _ebss
.Lzero_bss:
    bgeu t0, t1, .Lcall_main
    sw zero, 0(t0)
    addi t0, t0, 4
    j .Lzero_bss
.Lcall_main:
    call main
.Lhang:
    j .Lhang
    .size _start, .-_start
