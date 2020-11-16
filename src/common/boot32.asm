
use16
boot32:
  ; disable interupts
  cli
  ; load the GDT descriptor
  lgdt [gdt_descriptor]
  ; set 32 bit mode flag
  ; copy current data into 32bit version of ax register
  mov eax, cr0
  ; perform a bit-or operation on the data to set the bit/flag
  or eax, 0x1
  ; put the modified data back
  mov cr0, eax
  ; jump to 32 bit code segment init_boot32
  jmp CODE_SEG:init_boot32

use32
init_boot32:
  ; update GDT segment registers
  ; push constant from gdt.asm into ax
  mov ax, DATA_SEG

  ; push that data into the segment
  ; registers to update them
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  ; update stack memory at the top of free space
  ; push stack value into base pointer so we can use it
  ; to modify the stack pointer
  mov ebp, 0x90000
  ; copy to stack pointer
  mov esp, ebp

  ; hop on over to our label with 32bit mode, we're all done
  call BEGIN_32_MODE