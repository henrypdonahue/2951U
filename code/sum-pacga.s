.align 2
.text
.global _main
//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
sum_prologue:
            pacga x1,lr,x28 ; Calculate a 32-bit Pointer Authentication Code (PAC) using lr and x28 as inputs, store the result in x1
            stp   lr,x28,[sp,#-16]!
            ; Store the values of lr and x28 onto the stack and pre-decrement the stack pointer by 16 bytes
            ; This effectively pushes lr and x28 onto the stack as part of the function prologue
            str   x1,    [sp,#-16]! //the code must match the return address
            ; Store the value of x1 onto the stack and pre-decrement the stack pointer by 16 bytes
            ; x1 holds a PAC that needs to match with the return address (or another critical pointer) for validation during the epilogue
            mov   x28,lr            ;feedback into next modifier
            
            cmp   x0,1
            b.le  sum_exit
            str   x0,[sp,#-16]!
            add   x0,x0,-1
            bl    sum
            ldr   x1,[sp],#16
            add   x0,x0,x1

sum_exit:   
sum_epilogue:
            ldr   x1    ,[sp],#16 ; Load the previously stored Pointer Authentication Code (PAC) from the stack into x1
            ldp   lr,x28,[sp],#16 ;Load the values of lr (link register) and x28 from the stack into their respective registers
            pacga x2,lr,x28 ; Recalculate the PAC using the current values of lr and x28, and store the result in x2
            cmp   x1,x2 ; Compare the recalculated PAC (x2) with the previously stored PAC (x1)
            b.eq  pac_pass ; If x1 and x2 match, branch to the label 'pac_pass' to continue with the function return
            //x1 and x2 must match
            
            ; If x1 and x2 do not match, "decrypt" or authenticate the potentially corrupted return address in lr using x28
            ; This step should always fail if there is an attack, as the PACs do not match
            autia lr,x28            //"decrypt" an unencrypted return addr => should always fail
            ; Label for a successful PAC match and subsequent return
            pac_pass:
            ret


_main:
    stp lr,x28,[sp,#-16]!

    stp x27,x26,[sp,#-16]!
    mov x27,9000
    main_repeat:mov x26,9000
        main_repeat2:   
                        mov x28,23
                        mov x0,9
                        bl  sum

                        add  x26,x26,#-1
                        cmp  x26,xzr
                        b.ne main_repeat2
                add  x27,x27,#-1
                cmp  x27,xzr
                b.ne main_repeat
    ldp x27,x26,[sp],#16

    ldp lr,x28,[sp],#16
    ret

// MAIN without loops
// _main:
//     stp lr,x28,[sp,#-16]!
//     mov x28,23
//     mov x0,11
//     bl  sum
//     ldp lr,x28,[sp],#16
//     ret