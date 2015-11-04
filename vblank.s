initVblankIRQ
    sei       ; turn off interrupts
    lda #%01111111
    sta $dc0d ; Disable CIA1
    sta $dd0d ; Disable CIA2 through clearing
    lda $dc0d ; ack cia1
    lda $dd0d ; ack cia2

    lda #$01   ;this is how to tell the VICII to generate a raster interrupt
    sta $d01a
    asl $d019  ; Ack any current events set by VICII
    lda #RASTER_TO_COUNT_AT     ; line to trigger interrupt
    sta $d012
    ; Configure ROM/RAM
    lda #$35   ;we turn off the BASIC and KERNAL rom here
    sta $01    ;the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of
               ;SID/VICII/etc are visible
    lda #<irq_vblankHandler
    sta $fffe
    lda #>irq_vblankHandler
    sta $ffff
    cli
    rts

irq_vblankHandler
    pha        ;store register A in stack
    txa
    pha        ;store register X in stack
    tya
    pha        ;store register Y in stack
    inc screenDraws
    inc SCREEN_BORDER

    dec SCREEN_BORDER
    asl $d019    ; ACK interrupt (to re-enable it)
    pla
    tay
    pla
    tax
    pla
    rti
screenDraws .byte 0
