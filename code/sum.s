.align 2
.text
.global _main
//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
            cmp  x0,1
            b.le sum_exit
            stp  x0,lr,[sp,#-16]!
            add  x0,x0,-1
            bl   sum
            ldp  x1,lr,[sp],#16
            add  x0,x0,x1
sum_exit:   ret


_main:
    str lr,[sp,#-16]!

    stp x27,x26,[sp,#-16]!
    mov x27,9000
    main_repeat:mov x26,9000
        main_repeat2:   
                        mov  x0,9
                        bl   sum
                        
                        add  x26,x26,#-1
                        cmp  x26,xzr
                        b.ne main_repeat2
                add  x27,x27,#-1
                cmp  x27,xzr   
                b.ne main_repeat 
    ldp x27,x26,[sp],#16

    ldr lr,[sp],#16
    ret

@ MAIN without the loop
@ _main:
@     str lr,[sp,#-16]!
@     mov x0,30000
@     bl  sum
@     ldr lr,[sp],#16
@     ret