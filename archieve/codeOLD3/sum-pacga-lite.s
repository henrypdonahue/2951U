    

.align 2
.text
.global _main
//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
sum_prologue:
            pacga x1,lr,x28
            stp   lr,x1 ,[sp,#-16]! //the code must match the return address
            
            cmp   x0,1
            b.le  sum_exit
            str   x0,[sp,#-16]!
            add   x0,x0,-1
            bl    sum
            ldr   x1,[sp],#16
            add   x0,x0,x1

sum_exit:   
sum_epilogue:
            ldp   lr,x1 ,[sp],#16
            pacga x2,lr,x28
            cmp   x1,x2
            b.eq  pac_pass          //x1 and x2 must match
            autia lr,x28            //"decrypt" an unencrypted return addr => should always fail
            pac_pass:
            ret


_main:
    stp lr,x28,[sp,#-16]!
    mov x28,23
    mov x0,11
    bl  sum
    ldp lr,x28,[sp],#16
    ret