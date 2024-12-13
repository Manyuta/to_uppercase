# PURPOSE:
# This function does the conversion to uppercase for a block
#
# INPUT:
# The first parameter is the location of the block of memory to convert
# The second parameter is the length of the buffer
#
# OUTPUT:
# This function overwrites the current buffer with the uppercase version
#
# VARIABLES:
# %eax - beginning of buffer
# %ebx - length of buffer
# %edi - current buffer offset
# %cl  - current byte being examined (first part of %ecx)

.section .text

.globl convert_to_upper

### CONSTANTS ###
# The lower boundary of our search
.equ LOWERCASE_A, 'a'
# The upper boundary of our search
.equ LOWERCASE_Z, 'z'
# Conversion between upper and lower case
.equ UPPER_CONVERSION, 'A' - 'a'

### STACK STUFF ###
.equ ST_BUFFER_LEN, 8  # Length of buffer
.equ ST_BUFFER, 12     # Actual buffer

    .type convert_to_upper, @function 
convert_to_upper:
    pushl %ebp
    movl %esp, %ebp

    ### SET UP VARIABLES ###
    movl ST_BUFFER(%ebp), %eax            # Move param into corresponding register for use
    movl ST_BUFFER_LEN(%ebp), %ebx
    movl $0, %edi                         # load zero into %edi

    # if a buffer with zero length was given (stored in %ebx), then exit
    cmpl $0, %ebx
    je end_convert_loop

convert_loop:
    # get the current byte
    movb (%eax,%edi,1), %cl
    # go to the next byte unless it is between 'a' and 'z'
    cmpb $LOWERCASE_A, %cl
    jl next_byte
    cmpb $LOWERCASE_Z, %cl
    jg next_byte

    # otherwise convert the byte to uppercase
    addb $UPPER_CONVERSION, %cl
    # and store it back
    movb %cl, (%eax,%edi,1)

next_byte:
    incl %edi           # next byte
    cmpl %edi, %ebx     # continue unless we've reached the end
    jne convert_loop

end_convert_loop:
    movl %ebp, %esp
    popl %ebp
    ret
