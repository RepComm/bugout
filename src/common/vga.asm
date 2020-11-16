
; 32 bit mode, as defined by fasm
use32

VGA_MEM_OFFSET = 0xb8000
WHITE_ON_BLACK = 0x0f

; a char in vga 80 x 25 grid accessed with
; 0xb8000 + 2 * (row * 80 + col)

; @params
; register ebx = pointer to text char (lower byte is used)

vga_print_cstr:
  ; save all registers
  pusha
  ; dx is 16 bit register, we're in 32 bit
  ; so we use edx, the 32bit equivalent of dx
  mov edx, VGA_MEM_OFFSET
vga_print_cstr_loop:
  ; push our char into a lower
  mov al, [ebx]
  ; push our color data
  mov ah, WHITE_ON_BLACK

  ; check if end of string
  cmp al, 0
  ; if so, stop looping
  je vga_print_cstr_done

  ; store our text/color to the vga memory position
  mov [edx], ax
  ; increment the text pointer to the next char
  add ebx, 1 ; next char
  ; increment video memory position
  add edx, 2

  jmp vga_print_cstr_loop

vga_print_cstr_done:
  ; put all the registers back
  popa
  ; return from call to vga_print_cstr
  ret