
; @project - bugout os
; @author - Jon
; @desc - boot sector main

; set memory origin, so when we use memory it
; will be from bootsector, not somewhere reserved for something else
org 0x7c00

; ---- BEGIN SECTOR 1 (boot sector)

; move the stack a little further away from us
; have to set base pointer register, normal registers or literals don't work here
mov bp, 0x9000
; stack pointer set to base pointer
mov sp, bp

; write a hello world message
mov bx, real_mode_hello
call print

call boot32
jmp $ ; infiniloop - doesn't actual execute, as boot32 jumps over it

; must include here, not above, as including above would
; run the code directly without us calling it
include "boot/print.asm"
include "boot/gdt.asm"
include "common/vga.asm"
include "common/boot32.asm"

; tell assembler to treat as 32bit code
use32

; boot32 function jumps to this label, so this is where the kernel official starts
BEGIN_32_MODE:
  mov ebx, boot32_mode_hello
  call vga_print_cstr
  jmp $

real_mode_hello:
  db '----Bugout OS----', 0
boot32_mode_hello:
  db "32bit protected mode has now booted", 0

; bootsector needs 55AA at the end (in little endian)
; this fills with zeroes, and writes the magic value
times 510 - ($-$$) db 0
dw 0xaa55 

; ---- END SECTOR 1 (boot sector)
; ---- BEGIN SECTOR 2 (kernel)

; times 256 dw 0x0000
; times 256 dw 0x0000

; ---- END SECTOR 2 (kernel)