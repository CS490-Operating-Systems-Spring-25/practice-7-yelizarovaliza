.section .data
  buffer:   .fill 256, 1, 0
  filename: .asciz "test.txt"
  message:  .asciz "AArch64!\n"

.section .text
  .global _start

_start:
	// Get Current Working Directory (syscall 17 - getcwd)
    ldr x0, =buffer
    mov x1, #256
    mov x8, #17
    svc #0
    mov x10, x0

	// Print Directory (syscall 64 - write)
    mov x0, #1
    ldr x1, =buffer
    mov x2, x10
    mov x8, #64
    svc #0
    
    // Create and Write to a File (syscall 56 - openat)
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0x241
    mov x3, #420
    mov x8, #56
    svc #0
    mov x9, x0

    // Write Message to File (syscall 64 - write)
    ldr x1, =message
    mov x2, #9
    mov x8, #64
    svc #0

    // Close File (syscall 57 - close)
    mov x0, x9
    mov x8, #57
    svc #0

    // Change file permission (syscall 52 - change permission)
    mov x0, #-100
    ldr x1, =filename
    mov x2, #511
    mov x3, #0
    mov x8, #52
    svc #0

    // Read File Content (syscall 56 - openat for reading)
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0
    mov x8, #56
    svc #0
    mov x9, x0
    
    // Print File Content (syscall 64 - write)
    mov x0, #1
    ldr x1, =buffer
    mov x2, x10
    mov x8, #64
    svc #0

    // Close File Again (syscall 57 - close)
    mov x0, x9
    mov x8, #57
    svc #0

    // Exit with Return Code 1 (syscall 93)
    mov x0, #1
    mov x8, #93
    svc #0
