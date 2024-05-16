.align 2
.text
.global _main
//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
    cmp  x0,1
    b.le sum_exit
    pacia lr,x28             // "encrypt" the return addr
    stp   x0,lr,[sp,#-16]!
    add   x0,x0,-1
    bl    sum
    ldp   x1,lr,[sp],#16
    autia lr,x28            //"decrypt" the return addr
    add   x0,x0,x1
sum_exit:   ret

_main:
    stp lr,x28,[sp,#-16]!
    mov x28,0
    mov x0,5
    bl  sum
    ldp lr,x28,[sp],#16
    ret