clearScreen ; void ()
    ldx #0
cs_loop
    lda clearingChar
    lda #BLOCK_CHAR
    sta SCREENMEM, X
    sta SCREENMEM + $100, x
    sta SCREENMEM + $200, x
    sta SCREENMEM + $300, x
    lda #COLOR_BLUE
    sta COLORMEM, x
    sta COLORMEM + $100, x
    sta COLORMEM + $200, x
    sta COLORMEM + $300, x
    inx
    bne cs_loop
    rts
clearingChar    .byte ' ' ; Can be set before using routine

clearColor
    ldx #0
cc_loop
    lda #COLOR_BLUE
    sta COLORMEM, x
    sta COLORMEM + $100, x
    sta COLORMEM + $200, x
    sta COLORMEM + $300, x
    inx
    bne cc_loop
    rts
    