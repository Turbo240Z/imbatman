initRefreshCounter
    sei       ; turn off interrupts
    lda $dc0d ; ack cia1
    lda $dd0d ; ack cia2

    lda #%10000101 ; enable cia 1 irq by timer a, bit 2 for RTC interupt trigger
    sta $dc0d

    lda #%01111111 ; Disable CIA2 through clearing
    sta $dd0d

    ;lda #$00   ;this is how to tell the VICII to generate a raster interrupt
    ;sta $d01a
    ;asl $d019  ; Ack any current events set by VICII
    ;lda #RASTER_TO_COUNT_AT     ; line to trigger interrupt
    ;sta $d012

    ;   985,248.6Hz (PAL)
    ; 1,022,727.3Hz (NTSC)
    ;
    ; 1/8,000 = .000125 * 985248.6 = 123

    lda #DIGI_AUX_SPEED
    sta $dc04 ; CIA2 timer A low byte
    ;lda #>DIGI_AUX_SPEED
    lda #0
    sta $dc05 ; CIA2 timer A high byte

    lda #%00010001 ; Start timer a, restart when counted down, load start value into timer, set timer to 50hz for RTC
    sta $dc0e

    ; Configure ROM/RAM
    lda #$35   ;we turn off the BASIC and KERNAL rom here
    sta $01    ;the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of
               ;SID/VICII/etc are visible

    lda #<irq_refreshCounter    ; low part of address of interrupt handler code
    sta $fffe
    lda #>irq_refreshCounter    ; high part of address of interrupt handler code
    sta $ffff
    cli          ; turn interrupts back on
    rts



irq_refreshCounter
    pha        ;store register A in stack
    txa
    pha        ;store register X in stack
    tya
    pha        ;store register Y in stack
    inc SCREEN_BORDER
    ; do something
    lda __SID__
    and #%11110000
firstDigiLoad
    ora imbatman
    sta __SID__+$18   ; SID Volume register
    clc
    lda firstDigiLoad+1
    adc #1
    sta firstDigiLoad+1
    lda firstDigiLoad+2
    adc #0
    sta firstDigiLoad+2


    lda firstDigiLoad+1
    cmp #<imbatman_end
    bne notFinished
    lda firstDigiLoad+2
    cmp #>imbatman_end
    bne notFinished
    ; Reset audio to start
    lda #<imbatman
    sta firstDigiLoad+1
    lda #>imbatman
    sta firstDigiLoad+2
notFinished
    dec SCREEN_BORDER
    lda $dc0d ; ACK/read what event occurred
    pla
    tay
    pla
    tax
    pla
    rti          ; return from interrupt


restartDigiSound
    lda #<imbatman
    sta firstDigiLoad+1
    lda #>imbatman
    sta firstDigiLoad+2
    rts

intDigiSound
    jsr restartDigiSound
    sta __SID__+$05   ; voice 1 ad
    lda #$f0
    sta __SID__+$06   ;         sr
    lda #$01
    sta __SID__+$04   ;         ctrl
    lda #$00
    sta __SID__+$0c   ; voice 2 ad
    lda #$f0
    sta __SID__+$0d   ;         sr
    lda #$01
    sta __SID__+$0b   ;         ctrl
    lda #$00
    sta __SID__+$13   ; voice 3 ad
    lda #$f0
    sta __SID__+$14   ;         sr
    lda #$01
    sta __SID__+$12   ;         ctrl
    lda #$00
    sta __SID__+$15   ; filter lo
    lda #$10
    sta __SID__+$16   ; filter hi
    lda #%11110111
    sta __SID__+$17   ; filter voices+reso

    ; Some levels mods from Algorithm to boost audio level
    lda #$ff
    sta $d406
    sta $d406+7
    sta $d496+14
    lda #$49
    sta $d404
    sta $d404+7
    sta $d404+14
    rts
