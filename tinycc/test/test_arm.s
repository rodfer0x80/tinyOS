.section .data
hello_msg:  .asciz "Hello, ARM64!\n"

.section .text
.global main

main:
    // write the message to stdout
    mov x0, #1               // file descriptor 1 (stdout)
    ldr x1, =hello_msg       // pointer to the message
    ldr x2, =14               // message length
    mov x8, #64               // system call number for write
    svc 0                     // make the system call

    // exit the program
    mov x8, #93               // system call number for exit
    mov x0, #0                // exit code 0
    svc 0                     // make the system call

