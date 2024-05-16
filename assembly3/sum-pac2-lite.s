
.text
.align	2
.global	_main
//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
sum_prologue:
            mov   x1,lr
            and   x1,x1,#0xFFFFFF000000
            and   lr,lr,#0x000000FFFFFF
            pacia lr,x28
            pacia x1,x28
            stp   lr,x1,[sp,#-16]!

            
            cmp  x0,1
            b.le sum_exit
            str  x0,[sp,#-16]!
            add  x0,x0,-1
            bl   sum
            ldr  x1,[sp],#16
            add  x0,x0,x1
            
sum_exit:   
sum_epilogue:
            ldp     lr ,x1,[sp],#16  //encrypted pair
            autia   lr ,x28
            autia   x1 ,x28
            orr     lr ,lr,x1     //restore return address
            ret


_main:
    stp lr,x28,[sp,#-16]!
    mov x28,23
    mov x0,9
    bl  sum
    ldp lr,x28,[sp],#16
    ret

