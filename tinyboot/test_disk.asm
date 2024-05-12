test_disk:
  mov ah, 2
  mov al, 1
  mov ch, 0
  mov cl, 2
  mov dh, 0
  mov dl, [BOOT_DISK]
  mov es, 0
  mov bx, byte [0x7e00]
  int 0x13

  mov ah, 0x0e
  mov al, byte [0x7e00]
  int 0x10
  
  ret

