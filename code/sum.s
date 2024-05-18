.align 2
.text
.global _main
//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
            cmp  x0,1 ; Compare x0 with 1
            b.le sum_exit ; If x0 <= 1, branch to sum_exit
            stp  x0,lr,[sp,#-16]! ; Store the pair x0 and lr on the stack, update sp
            add  x0,x0,-1 ; Decrement x0
            bl   sum ; Branch to sum with link (call sum recursively)
            ldp  x1,lr,[sp],#16 ; Load the pair x1 and lr from the stack, update sp
            add  x0,x0,x1 ; Add x1 to x0 (accumulate the result in x0)
sum_exit:   
            ret ; Return from function


_main:
    str lr,[sp,#-16]! ; Store link register (lr) on the stack

    stp x27,x26,[sp,#-16]! ; Store the pair x27 and x26 on the stack, update sp
    mov x27,9000 ; Move 9000 into x27, used as a loop counter

    main_repeat: mov x26,9000 ; Initialize x26 to 9000, used as a nested loop counter
        
        main_repeat2:   
                        mov  x0,9 ; Move 9 into x0 (argument for the sum function)
                        bl   sum ; Call sum function, compute sum(9)
                        
                        add  x26,x26,#-1 ; Decrement x26
                        cmp  x26,xzr ; Compare x26 with zero
                        b.ne main_repeat2 ; If x26 != 0, repeat the inner loop
                add  x27,x27,#-1 ; Decrement x27
                cmp  x27,xzr   ; Compare x27 with zero
                b.ne main_repeat  ; If x27 != 0, repeat the outer loop
    ldp x27,x26,[sp],#16 ; Load x27 and x26 from the stack, update sp

    ldr lr,[sp],#16 ; Load link register from stack
    ret ; Return from _main

// MAIN without the loop
// _main:
//     str lr,[sp,#-16]! ; Store link register (lr) on the stack
//     mov x0,9 ; Move 9 into x0 (argument for the sum function)
//     bl  sum ; Call sum function, compute sum(9)
//     ldr lr,[sp],#16 ; Load link register from stack
//     ret ; Return from _main