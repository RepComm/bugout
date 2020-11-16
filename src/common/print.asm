
; @project - bugout os
; @author - Jon
; @desc - helper for printing to TTY in real mode

; this function uses the bx register as a pointer
; to the cstring we want to print
;
; example usage:
; 
; my_str:
;   db 'Some text here', 0
; mov bx, my_str
; call print

; -- constants
TTY_WRITE_MODE = 0x0e
INTR_VIDEO = 0x10

; @params
; register bx = pointer of where the string data is in memory
print:
  ; save a register so we don't mess up any work
  pusha

print_loop:
  ; copy string content at bx register pointer into ax register lower
  mov al, [bx]

  ; check if 0x00
  cmp al, 0
  ; finish if its equal
  je print_exit

  ; Enable TTY write
  mov ah, TTY_WRITE_MODE
  ; interrupt to let cpu know to display our changes
  int INTR_VIDEO

  ; increment string pointer
  add bx, 1
  ; loop iteration
  jmp print_loop

print_exit:
  ; put a register back since we modified it
  popa
  ; return to original code
  ret