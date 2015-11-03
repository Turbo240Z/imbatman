; Loading from fsbat 25*40 = 1,000
loadInScreenColorSet ; void ()
    ldx #0
liscs_loop
    lda fsbat, x
    sta COLORMEM, x
    cmp #BACKGROUND_CLR
    beq liscs_noPaint1
    lda #BLOCK_CHAR
    sta SCREENMEM, x
liscs_noPaint1
    lda fsbat + $100, x
    sta COLORMEM + $100, x
    cmp #BACKGROUND_CLR
    beq liscs_noPaint2
    lda #BLOCK_CHAR
    sta SCREENMEM + $100, x
liscs_noPaint2
    lda fsbat + $200, x
    sta COLORMEM + $200, x
    cmp #BACKGROUND_CLR
    beq liscs_noPaint3
    lda #BLOCK_CHAR
    sta SCREENMEM + $200, x
liscs_noPaint3
    lda fsbat + $300, x
    sta COLORMEM + $300, x
    cmp #BACKGROUND_CLR
    beq liscs_noPaint4
    lda #BLOCK_CHAR
    sta SCREENMEM + $300, x
liscs_noPaint4
    inx
    bne liscs_loop
    rts

loadInZoomOut1 ; void ()
    ldx #0
lizo1_loop
    lda batzoom1, x
    sta COLORMEM, x
    lda batzoom1 + $100, x
    sta COLORMEM + $100, x
    lda batzoom1 + $200, x
    sta COLORMEM + $200, x
    lda batzoom1 + $300, x
    sta COLORMEM + $300, x
    lda #BLOCK_CHAR
    sta SCREENMEM, x
    sta SCREENMEM + $100, x
    sta SCREENMEM + $200, x
    sta SCREENMEM + $300, x
    inx
    bne lizo1_loop
    rts


scrollScreenUp
    ldx #0
scrollScreenUp1
    lda #<COLORMEM
    sta zpPtr1
    clc
    adc #40
    sta zpPtr2

    lda #>COLORMEM
    sta zpPtr1+1
    adc #0
    sta zpPtr2+1
scrollScreenUp2

ssu_loop1
    ldy #0
ssu_loop2
    lda (zpPtr2), y ; Load from lower line
    sta (zpPtr1), y ; store on line above
    iny
    cpy #39
    bne ssu_loop2
    ; write to the next line
    clc
    lda zpPtr1
    adc #40
    sta zpPtr1
    lda zpPtr1+1
    adc #0
    sta zpPtr1+1
    ; read from the next line
    clc
    lda zpPtr2
    adc #40
    sta zpPtr2
    lda zpPtr2+1
    adc #0
    sta zpPtr2+1
    inx
    cpx #24
    bcc ssu_loop1
    jsr loadInNewLine
    rts


loadInNewLine
    ; Load in value for line of picture
    lda picPtr
    sta zpPtr2
    lda picPtr+1
    sta zpPtr2+1
    ldy #0
linl_loop
    lda (zpPtr2), y ; Load from lower line
    sta (zpPtr1), y ; store on line above
    iny
    cpy #39
    bne linl_loop
    ; Add one to our picture location
    clc
    lda picPtr
    adc #40
    sta picPtr
    lda picPtr+1
    adc #0
    sta picPtr+1
    rts
picPtr  .byte 0, 0
