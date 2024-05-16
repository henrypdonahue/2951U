.align 2
.text
.global _main
//compute sum recursively of all number up to N
//where N is passed in as x0
sum:
    cmp  x0,1
    b.le sum_exit


    // PROLOGUE
    str X28, [SP, #-32]!    ; Save X28 on the stack
    stp FP, LR, [SP, #16]   ; Save Frame Pointer and Link Register

    // PACGA usage
    mov X1, Xn      ; Move the first source value into X1
    mov X2, Xm      ; Move the modifier value into X2
    PACGA X0, X1, X2 ; Compute the PAC, result in X0

    // Extract and distribute the PAC bits
    ubfx LR, X0, #16, #16  ; Extract the top 16 bits of the lower 32 bits of X0 to LR
    sbfx X27, X0, #0, #16  ; Extract the lower 16 bits of the lower 32 bits of X0 to X27



    stp   x0,lr,[sp,#-16]!
    add   x0,x0,-1
    bl    sum
    ldp   x1,lr,[sp],#16


    // EPILOGUE
    mov LR, X28      ; Restore LR from X28
    ldp FP, LR, [SP, #16] ; Restore Frame Pointer and LR
    ldr X28, [SP], #32    ; Restore X28 and adjust stack


    add   x0,x0,x1
sum_exit:   ret

_main:
    stp lr,x28,[sp,#-16]!
    mov x28,0
    mov x0,5
    bl  sum
    ldp lr,x28,[sp],#16
    ret
