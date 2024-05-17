
.text
.align	2
.global	_main
//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
sum_prologue:
            mov   x1,lr ; Move the contents of the link register (lr) to x1
            and   x1,x1,#0xFFFFFF000000 ; Perform a bitwise AND on x1 to mask the upper 24 bits
            and   lr,lr,#0x000000FFFFFF ; Perform a bitwise AND on lr to mask the lower 24 bits
            pacib lr,x28 ; Pointer authentication code for instruction address, using modifier x28
            pacia x1,x28 ; Pointer authentication code for data address, using modifier x28
            stp   lr,x1,[sp,#-16]! ; Store lr and x1 on the stack and update the stack pointer
            str   x28  ,[sp,#-16]! ; Store the contents of x28 on the stack, further updating the stack pointer
            eor   x28,lr,x1     ; Exclusive OR operation between lr and x1, result stored in x28 - use both halves for feedback

            
            cmp  x0,1
            b.le sum_exit
            str  x0,[sp,#-16]!
            add  x0,x0,-1
            bl   sum
            ldr  x1,[sp],#16
            add  x0,x0,x1
            
sum_exit:   
sum_epilogue:
            ldr     x28   ,[sp],#16
            ldp     lr ,x1,[sp],#16  //encrypted pair
            autib   lr ,x28
            autia   x1 ,x28
            orr     lr ,lr,x1     //restore return address
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


@ MAIN without loops
@ _main:
@     stp lr,x28,[sp,#-16]!
@     mov x28,23
@     mov x0,9
@     bl  sum
@     ldp lr,x28,[sp],#16
@     ret

