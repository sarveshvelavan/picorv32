ENTRY(_start)

MEMORY
{
    RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 16K
    ROM (rx)  : ORIGIN = 0x20000000, LENGTH = 2K
}

SECTIONS
{
    .boot ORIGIN(ROM) : { KEEP(*(.crt0)) KEEP(*(.init)) } > ROM
    .text : { *(.text .text.*) *(.rodata .rodata.*) } > ROM
    .data : ALIGN(4) { _sdata = .; *(.data .data.*) . = ALIGN(4); _edata = .; } > RAM AT > ROM
    _sidata = LOADADDR(.data);
    .bss (NOLOAD) : ALIGN(4) { _sbss = .; *(.bss .bss.*) *(COMMON) . = ALIGN(4); _ebss = .; } > RAM
    _estack = ORIGIN(RAM) + LENGTH(RAM);
}
