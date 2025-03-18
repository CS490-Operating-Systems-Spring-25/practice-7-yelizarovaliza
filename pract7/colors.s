.section .data
prompt:    .asciz "Enter colors (up to 16): "
buffer:    .fill 17, 1, 0  // 16 chars + null terminator
reset:     .asciz "\033[0m\n" // Reset color and new line

.section .bss
output:    .skip 128 // Buffer to hold

.section .text
.global _start

_start:
    // Display prompt
    mov x0, #1
    ldr x1, =prompt
    mov x2, #28
    mov x8, #64
    svc #0

    // Read user input
    mov x0, #0
    ldr x1, =buffer
    mov x2, #16
    mov x8, #63
    svc #0

    // Process input and construct colored output
    ldr x1, =buffer
    ldr x2, =output
    mov x3, x2

process_loop:
    ldrb w4, [x1], #1
    cmp w4, #10
    beq print_output
    cbz w4, print_output

    // Match color codes
    cmp w4, 'B'
    beq set_black
    cmp w4, 'r'
    beq set_red
    cmp w4, 'g'
    beq set_green
    cmp w4, 'b'
    beq set_blue
    cmp w4, 'y'
    beq set_yellow
    cmp w4, 'w'
    beq set_white
    cmp w4, 'c'
    beq set_cyan
    cmp w4, 'm'
    beq set_magenta
    b process_loop  // Ignore invalid characters

set_black:
    adr x5, black_code
    b append_code
set_red:
    adr x5, red_code
    b append_code
set_green:
    adr x5, green_code
    b append_code
set_blue:
    adr x5, blue_code
    b append_code
set_yellow:
    adr x5, yellow_code
    b append_code
set_white:
    adr x5, white_code
    b append_code
set_cyan:
    adr x5, cyan_code
    b append_code
set_magenta:
    adr x5, magenta_code
    b append_code

append_code:
    ldrb w6, [x5], #1
    cbz w6, process_loop
    strb w6, [x3], #1
    b append_code

print_output:
    // reset color code
    ldr x5, =reset
reset_append:
    ldrb w6, [x5], #1
    cbz w6, do_write
    strb w6, [x3], #1
    b reset_append

do_write:
    // Print output
    mov x0, #1
    ldr x1, =output
    sub x2, x3, x1
    mov x8, #64
    svc #0

    // Exit program
    mov x0, #0
    mov x8, #93
    svc #0

.section .data
black_code:   .asciz "\033[40m  "  // Black
red_code:     .asciz "\033[41m  "  // Red
green_code:   .asciz "\033[42m  "  // Green
blue_code:    .asciz "\033[44m  "  // Blue
yellow_code:  .asciz "\033[43m  "  // Yellow
white_code:   .asciz "\033[47m  "  // White
cyan_code:    .asciz "\033[46m  "  // Cyan
magenta_code: .asciz "\033[45m  "  // Magenta
