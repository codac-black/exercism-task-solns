// Declare the 'steps' function globally so the linker can find it
.globl steps

steps:
    // Input 'number' is in x0
    // Check for invalid input (number <= 0)
    cmp x0, #1
    blt error           // If x0 < 1, jump to error

    mov x1, x0          // Use x1 as our current 'n'
    mov w0, #0          // Use w0 (32-bit x0) as our step counter

loop:
    cmp x1, #1          // Is n == 1?
    beq done            // If yes, we are finished

    add w0, w0, #1      // Increment step count
    
    // Check if even or odd
    // tst is a shortcut for 'ands' when we don't need the result, just flags
    tst x1, #1          
    beq is_even

is_odd:
    // n = 3n + 1
    // Optimization: (n << 1) + n + 1 is the same as 3n + 1
    mov x2, #3
    mul x1, x1, x2
    add x1, x1, #1
    b loop

is_even:
    // n = n / 2
    lsr x1, x1, #1      // Logical Shift Right
    b loop

error:
    mov w0, #-1         // Return INVALID_NUMBER (-1)
    ret

done:
    ret                 // Final count is already in w0