[org 0x7C00]
[bits 16]

BOOT_DISK db 0
BOOT_STRING db "Starting tinyOS...", 0
STAGE_2_LOC equ 0x7e00

_main16:
	;save boot disk number
  mov [BOOT_DISK], dl
  
	;set up segment registers
	cli
	mov ax, 0x00
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00
	sti
   	
	;clear the screen
	mov ah, 0x00
	mov al, 0x03
	int 0x10
  
  ;print welcome msg
  mov bx, BOOT_STRING
  call print_string

	xor bx, bx
  mov es, bx

	; Load stage 2 bootloader (2 sectors)
	mov ax, 0x0201      ; AH = 02h (read sectors), AL = 01h (number of sectors to read)
	mov ch, 0x00        ; Cylinder number
	mov cl, 0x02        ; Sector number
	mov dh, 0x00        ; Head number
	mov dl, [BOOT_DISK] ; Boot disk number
  mov bx, STAGE_2_LOC ; ES:BX points to the buffer to read into
  int 0x13            ; BIOS interrupt for disk I/O
  
 ; Print a character from the loaded sector
  mov si, STAGE_2_LOC ; SI points to the buffer
  mov al, byte [si]   ; Load the character from the buffer
  mov ah, 0x0e        ; AH = 0x0e (print character)
  int 0x10            ; BIOS interrupt to print character

   ; Fill sector 2 with 'A's
  mov cx, 512         ; Set CX to 512, the size of a sector
  mov di, STAGE_2_LOC ; DI points to the buffer
  mov al, 'A'         ; Load 'A' into AL
  rep stosb           ; Repeat CX times, store AL at [DI], and increment DI
  
 jmp $ ;STAGE_2_LOC

%include"print_string.asm"
;%include"print_dec.asm"
;%include"disk.asm"


times 510-($-$$) db 0x00
db 0x55, 0xAA
times 512 db 'A'

