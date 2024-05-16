.align 2
.text
.global	_main

//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
            str   x27,[sp,#-16]!
            mov   x27,lr
            and   x27,x27,#0xFFFFFF000000
            and   lr,lr  ,#0x000000FFFFFF
            pacib x27,x28
            pacia lr ,x28
            str   lr ,[sp,#-16]!
            
            cmp  x0,1
            b.le sum_exit
            str  x0,[sp,#-16]!
            add  x0,x0,-1
            bl   sum
            ldr  x1,[sp],#16
            add  x0,x0,x1
            
sum_exit:   
            ldr     lr ,[sp],#16  //encrypted bottom-half
            autia   lr ,x28
            autib   x27,x28
            orr     lr ,lr,x27   //restore return address
            ldr     x27,[sp],#16  //restore original x27
            ret


_main:
    stp lr,x28,[sp,#-16]!
    mov x28,23
    mov x0,7
    bl  sum
    ldp lr,x28,[sp],#16
    ret