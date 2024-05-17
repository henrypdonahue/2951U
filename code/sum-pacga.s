.align 2
.text
.global _main
//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
sum_prologue:
            pacga x1,lr,x28
            stp   lr,x28,[sp,#-16]!
            str   x1,    [sp,#-16]! //the code must match the return address
            mov   x28,lr            //feedback into next modifier
            
            cmp   x0,1
            b.le  sum_exit
            str   x0,[sp,#-16]!
            add   x0,x0,-1
            bl    sum
            ldr   x1,[sp],#16
            add   x0,x0,x1

sum_exit:   
sum_epilogue:
            ldr   x1    ,[sp],#16
            ldp   lr,x28,[sp],#16
            pacga x2,lr,x28
            cmp   x1,x2
            b.eq  pac_pass          //x1 and x2 must match
            autia lr,x28            //"decrypt" an unencrypted return addr => should always fail
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

@ MAIN without loops
@ _main:
@     stp lr,x28,[sp,#-16]!
@     mov x28,23
@     mov x0,11
@     bl  sum
@     ldp lr,x28,[sp],#16
@     ret