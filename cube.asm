section .data
    start_row   equ 5
    start_col   equ 10
    width       equ 20
    height      equ 9
    
    char_pixel  db  "#"        
    
    clear_scr   db  27, '[2J', 27, '[H'
    clear_len   equ $ - clear_scr

    delay_ts:
        dq 0                  
        dq 50000000           

section .bss
    cursor_buf  resb 8 

section .text
    global _start

_start:
    mov rax, 1             
    mov rdi, 1              
    mov rsi, clear_scr
    mov rdx, clear_len
    syscall

    mov r8, start_row
    mov r9, start_col
    mov r10, width
.top_loop:
    call move_cursor_and_draw
    inc r9
    dec r10
    jnz .top_loop

    mov r8, start_row
    add r8, height
    mov r9, start_col
    mov r10, width
    inc r10                    
.bottom_loop:
    call move_cursor_and_draw
    inc r9
    dec r10
    jnz .bottom_loop

    mov r8, start_row
    mov r9, start_col
    mov r10, height
.left_loop:
    call move_cursor_and_draw
    inc r8
    dec r10
    jnz .left_loop

    mov r8, start_row
    mov r9, start_col
    add r9, width
    mov r10, height
    inc r10                   
.right_loop:
    call move_cursor_and_draw
    inc r8
    dec r10
    jnz .right_loop

    mov r8, 20
    mov r9, 1
    call move_cursor
    
    mov rax, 60             
    xor rdi, rdi
    syscall

move_cursor_and_draw:
    push r8
    push r9
    push r10
    
    call move_cursor
    
    mov rax, 1
    mov rdi, 1
    mov rsi, char_pixel
    mov rdx, 1
    syscall

    mov rax, 35            
    mov rdi, delay_ts     
    xor rsi, rsi         
    syscall

    pop r10
    pop r9
    pop r8
    ret

move_cursor:
    mov byte [cursor_buf], 27
    mov byte [cursor_buf+1], '['

    movzx ax, r8b         
    mov bl, 10
    div bl               
    add al, '0'           
    add ah, '0'         
    mov [cursor_buf+2], al
    mov [cursor_buf+3], ah

    mov byte [cursor_buf+4], ';'

    movzx ax, r9b             
    mov bl, 10
    div bl
    add al, '0'
    add ah, '0'
    mov [cursor_buf+5], al
    mov [cursor_buf+6], ah

    mov byte [cursor_buf+7], 'H'

    mov rax, 1
    mov rdi, 1
    mov rsi, cursor_buf
    mov rdx, 8
    syscall
    ret
