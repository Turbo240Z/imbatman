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
