
; @project - bugout os
; @author - Jon
; @desc - utilities for using the disk

; @params
; register bx = pointer of where to write the read data in memory
; register dh = num sectors to read
; register dl = drive number (0 floppy, 1, floopy, 0x80 hdd, 0x81 hdd) (set by bios, not code)

DISK_READ = 0x02
INTR_DISK = 0x13

disk_load:
  ; save all registers
  pusha
  push dx

  ; arguments for interrupt 0x13
  mov ah, DISK_READ
  ; our passed argument for how many sectors to read
  mov al, dh

  ; arguments for interrupt 0x13, sector / cylinder
  mov cl, 0x02 ; sector 2 (1 is boot)
  mov ch, 0x00 ; cylinder 0

  ; reuse dh
  mov dh, 0x00 ; drive head

  ; [es:bx] where data is stored
  ; interrupt for disk usage
  int INTR_DISK
  ; carry bit is set when error occures
  ; so jump if carry to error handling code
  jc disk_error

  ; restore dx
  pop dx
  ; compare how many sectors were read vs how many we asked to read
  cmp al, dh
  ; if not equal, not enough sectors read error handle
  jne disk_sectors_error
  ; restore a
  popa

  ; break out of routine
  ret
disk_error:
  ; print the error
  mov bx, DISK_ERROR
  call print
  ; println

  ; a higher is the error code
  ; d lower is the drive that errored
  mov dh, ah
  ; printhex
  jmp disk_loop

disk_sectors_error:
  mov bx, SECTORS_ERROR
  call print

disk_loop:
  jmp $

DISK_ERROR:
  db "Disk read error", 0

SECTORS_ERROR:
  db "Incorrect number of sectors read", 0