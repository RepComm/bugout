
; @project - bugout os
; @author - Jon
; @desc - boot sector main

; set memory origin, so when we use memory it
; will be from bootsector, not somewhere reserved for something else
org 0x7c00

; ---- BEGIN SECTOR 1 (boot sector)

; move the stack a little further away from us
; have to set base pointer register, normal registers or literals don't work here
mov bp, 0x8000
; stack pointer set to base pointer
mov sp, bp

; write a hello world message
mov bx, msg_hello
call print

; read from disk
; bx = where to read it into
mov bx, 0x9000
; dh = how many sectors to read
mov dh, 2 ; read 2 sectors
call disk_load
; disk_load puts the data into memory at bx

; print from first sector
call print

; print from second sector
mov bx, 0x9000 + 512
call print

jmp $ ; infiniloop

; must include here, not above, as we are in
; the boot sector, and including above would
; run the code directly without us calling it
include "common/print.asm"
include "common/disk.asm"

msg_hello:
  db '----Bugout OS----', 0

; bootsector needs 55AA at the end (in little endian)
; this fills with zeroes, and writes the magic value
times 510 - ($-$$) db 0
dw 0xaa55 

; ---- END SECTOR 1 (boot sector)
; ---- BEGIN SECTOR 2 (kernel)

times 128 dw 0x6869 ; hihihihi...
times 128 dw 0x0000 ; so print stops reading
times 128 dw 0x6c6f ; lolololol...
times 128 dw 0x0000 ; so print stops reading..

; ---- END SECTOR 2 (kernel)