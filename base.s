SCREENMEM       .equ $0400 ; Start of character screen map, color map is + $D400
COLORMEM        .equ $D800
VMEM            .equ $D000
SCREEN_BORDER   .equ VMEM + 32
SCREEN_BG_COLOR .equ VMEM + 33
COLOR_BLACK     .equ $00
COLOR_WHITE     .equ $01
COLOR_RED       .equ $02
COLOR_CYAN      .equ $03
COLOR_MAGENTA   .equ $04
COLOR_GREEN     .equ $05
COLOR_BLUE      .equ $06
COLOR_YELLOW    .equ $07
COLOR_ORANGE    .equ $08
COLOR_BROWN     .equ $09
COLOR_PINK      .equ $0a
COLOR_DARK_GREY .equ $0b
COLOR_GREY      .equ $0c
COLOR_L_GREEN   .equ $0d
COLOR_L_BLUE    .equ $0e
COLOR_L_GREY    .equ $0f
BACKGROUND_CHAR .equ ' '
BACKGROUND_CLR  .equ COLOR_BLUE
BLOCK_CHAR      .equ 160 ; BLOCK
DIGI_AUX_SPEED  .equ 123
zpPtr1          .equ $ba
__SID__         .equ $D400

.org $0801
;Tells BASIC to run SYS 2064 to start our program
.byte $0C,$08,$0A,$00,$9E,' ','2','0','6','4',$00,$00,$00,$00,$00


jsr intDigiSound
jsr initRefreshCounter

lda #COLOR_BLUE
sta SCREEN_BORDER
sta SCREEN_BG_COLOR

jsr clearScreen


; switch to 38 columns
lda $d016
and #%11110111
sta $d016
; switch to 25 rows
lda $d011
and #%11110111
sta $d011

mainLoop
;    jsr clearScreen
    jsr loadInScreenColorSet
    lda #COLOR_BLUE
    sta SCREEN_BORDER
    sta SCREEN_BG_COLOR
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr changeFullCharScreenBatFaceToOpen

    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr changeFullCharScreenBatFaceToClosed


    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    lda $d011
    and #%11111000
    ora #%00000001
    sta $d011

    jsr waitFrame
    jsr waitFrame
    lda $d011
    and #%11111000
    ora #%00000010
    sta $d011

    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    lda $d011
    and #%11111000
    ora #%00000011
    sta $d011

    jsr waitFrame
    jsr waitFrame

    lda $d011
    and #%11111000
    ora #%00000100
    sta $d011
    jsr waitFrame
    jsr waitFrame

    lda $d011
    and #%11111000
    ora #%00000101
    sta $d011


    jsr waitFrame
    jsr waitFrame
    jsr changeFullCharScreenBatFaceToOpen
    lda $d011
    and #%11111000
    ora #%00000111
    sta $d011

lda #COLOR_L_BLUE
sta SCREEN_BORDER
sta SCREEN_BG_COLOR

    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr changeFullCharScreenBatFaceToClosed
lda #COLOR_CYAN
sta SCREEN_BORDER
sta SCREEN_BG_COLOR

    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame


    lda $d011
    and #%11111000
    sta $d011

;    jsr loadInZoomOut1

    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame
    jsr waitFrame

;    jsr restartDigiSound

    jmp mainLoop

clearScreen ; void ()
    ldx #$00
cs_loop
    lda clearingChar
    sta SCREENMEM, X
    sta SCREENMEM + $100, x
    sta SCREENMEM + $200, x
    sta SCREENMEM + $300, x
    inx
    bne cs_loop
    rts
clearingChar    .byte ' ' ; Can be set before using routine

; 17*40+19 and +1 to char 100
changeFullCharScreenBatFaceToOpen
    lda #100
    sta SCREENMEM + 699
    sta SCREENMEM + 700
    rts
changeFullCharScreenBatFaceToClosed
    lda clearingChar
    sta SCREENMEM + 699
    sta SCREENMEM + 700
    rts



waitFrame
    lda $d012
    cmp #0
    beq waitFrame
waitStep2   lda $d012
    cmp #0
    bne waitStep2
    rts