# PURPOSE:
# This program converts an input from STDIN to output STDOUT with all letters
# converted to uppercase.

.section .data

####### CONSTANTS #######
# System call numbers
.equ SYS_WRITE, 4
.equ SYS_READ, 3
.equ SYS_EXIT, 1

# Standard file descriptors
.equ STDIN, 0
.equ STDOUT, 1
.equ STDERR, 2

# System call interrupt
.equ LINUX_SYSCALL, 0x80


.section .bss
.equ BUFFER_SIZE, 128
.lcomm BUFFER_DATA, BUFFER_SIZE

.section .text

.globl _start
.extern convert_to_upper

_start:
    ### INITIALIZE PROGRAM ###
    # Save the stack pointer
    movl %esp, %ebp

    ### READ FROM STDIN ###
    movl $SYS_READ, %eax 
    movl $STDIN, %ebx 
    movl $BUFFER_DATA, %ecx 
    movl $BUFFER_SIZE, %edx 
    int $LINUX_SYSCALL
    movl %eax, %edx             # Save the number of bytes read (returned in %eax) in %edx for the write call 


    ### CONVERT THE BLOCK TO UPPER CASE ###
    pushl $BUFFER_DATA  # location of buffer
    pushl %eax          # size of the buffer
    call convert_to_upper
    popl %eax           # get the size back
    addl $4, %esp       # restore %esp

    ### WRITE THE BLOCK OUT TO THE OUTPUT STDOUT ###
    movl $SYS_WRITE, %eax
    movl $STDOUT, %ebx
    movl $BUFFER_DATA, %ecx
    int $LINUX_SYSCALL

    ### EXIT ###
    movl $SYS_EXIT, %eax
    xorl %ebx, %ebx
    int $LINUX_SYSCALL
