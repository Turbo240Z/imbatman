; - - Master Memory Layout - -
; $0400 - $07e8 screen 1 memory, but we clear $0400 - $0800 for ease
; $0800 - $0C00 Screen 2 memory
; $0C01 - $3fc0 All code and data so far. 2 x 1,000bytes used for screens + 5,000 for audio
; $3800 - $3FFF Character RAM
; $8000 - $8f36 SID
; $9000 - $CFFF 16K of ram here.
; $D000 - $DFFF VIC/SID/CIA/IO registers
; $D800 - $DBFF Reserved Color ram

; $A000 - $BFFF BASIC ROM
; $E000 - $FFFF KERNEL ROM

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
RASTER_TO_COUNT_AT  .equ 0
zpPtr1          .equ $ba
zpPtr2          .equ $bc
__SID__         .equ $D400
INITIAL_WAIT    .equ 200
AFTER_WAIT      .equ 255

.org $0C01

    jsr initVblankIRQ
    lda #COLOR_BLUE
    sta SCREEN_BORDER
    lda #COLOR_BLACK
    sta SCREEN_BG_COLOR
    jsr restartDigiSound
    jsr intDigiSound
    ; switch to 38 columns
    lda $d016
    and #%11110111
    sta $d016
    ; switch to 25 rows
    lda $d011
    and #%11110111
    sta $d011
    jsr clearScreen
veryStart

    jsr clearColor
    lda #0
    sta scrollX

    ; Init where the image is located
    lda #<fsbat
    sta picPtr
    lda #>fsbat
    sta picPtr+1

    ldx #0
waitWithBlankScreen
    jsr waitFrame
    inx
    cpx #INITIAL_WAIT
    bne waitWithBlankScreen

bringInTheBat
    jsr scrollScreenUp
    inc scrollX
    jsr waitFrame
    lda scrollX
    cmp #25
    bne bringInTheBat
    ; Bat is in position
    lda #1
    sta playDigi
    jsr initRefreshCounter
    jmp mainLoop


mainLoop
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr changeFullCharScreenBatFaceToHalfOpen
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr changeFullCharScreenBatFaceToClosed
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr changeFullCharScreenBatFaceToHalfOpen
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames

    lda $d011
    and #%11111000
    ora #%00000001 ; 1
    sta $d011

    jsr waitFrames
    jsr waitFrames
    inc $d011 ; 2
    jsr changeFullCharScreenBatFaceToClosed
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    jsr waitFrames
    inc $d011 ; 3
    jsr waitFrames
    inc $d011 ; 4
    jsr waitFrames
    inc $d011 ; 5
    jsr waitFrames
    jsr changeFullCharScreenBatFaceToOpen
    inc $d011 ; 6
    jsr waitFrames
    inc $d011 ; 7
    jsr waitFrames
    dec $d011 ; 6
    jsr waitFrames
    dec $d011 ; 5
    jsr waitFrames
    dec $d011 ; 4
    jsr waitFrames
    dec $d011 ; 3
    jsr waitFrames
    dec $d011 ; 2
    jsr waitFrames
    dec $d011 ; 1
    jsr waitFrames
    dec $d011 ; 0
    jsr waitFrames
    inc $d011 ; 1
    jsr waitFrames
    inc $d011 ; 2
    jsr waitFrames
    inc $d011 ; 3
    jsr waitFrames
    inc $d011 ; 4
    jsr waitFrames
    inc $d011 ; 5
    jsr waitFrames
    inc $d011 ; 6
    jsr waitFrames
    dec $d011 ; 5
    jsr waitFrames
    dec $d011 ; 4
    jsr waitFrames
    dec $d011 ; 3
    jsr waitFrames
    dec $d011 ; 2
    jsr waitFrames
    inc $d011 ; 3
    jsr waitFrames
    inc $d011 ; 4
    jsr waitFrames
    inc $d011 ; 5
    jsr waitFrames
    inc $d011 ; 6
    jsr waitFrames
    inc $d011 ; 7
    jsr waitFrames
    dec $d011 ; 6
    jsr waitFrames
    dec $d011 ; 5
    jsr waitFrames
    dec $d011 ; 4
    jsr waitFrames
    dec $d011 ; 3
    jsr waitFrames
    dec $d011 ; 2
    jsr waitFrames
    dec $d011 ; 1
    jsr waitFrames
    dec $d011 ; 0
    jsr waitFrames
    inc $d011 ; 1
    jsr waitFrames
    inc $d011 ; 2
    jsr waitFrames
    inc $d011 ; 3
    jsr waitFrames
    inc $d011 ; 4
    jsr waitFrames
    inc $d011 ; 5
    jsr waitFrames
    inc $d011 ; 6
    jsr waitFrames
    inc $d011 ; 7
    jsr waitFrames
    dec $d011 ; 6
    jsr waitFrames
    dec $d011 ; 5
    jsr waitFrames
    dec $d011 ; 4
    jsr waitFrames
    dec $d011 ; 3
    jsr waitFrames
    dec $d011 ; 2
    jsr waitFrames
    dec $d011 ; 1
    jsr waitFrames
    dec $d011 ; 0
    jsr waitFrames
    inc $d011 ; 1
    jsr waitFrames
    inc $d011 ; 2
    jsr waitFrames
    inc $d011 ; 3
    jsr waitFrames
    inc $d011 ; 4
    jsr waitFrames
    inc $d011 ; 5
    jsr waitFrames
    inc $d011 ; 6
    jsr waitFrames
    inc $d011 ; 7
    jsr waitFrames
    jsr changeFullCharScreenBatFaceToClosed

    ldx #0
waitAfterHere
    jsr waitFrames
    inx
    cpx #AFTER_WAIT
    bne waitAfterHere
    jmp veryStart


; 17*40+19 and +1 to char 100
changeFullCharScreenBatFaceToOpen
    lda #100
    sta SCREENMEM + 699
    sta SCREENMEM + 700
    rts
changeFullCharScreenBatFaceToHalfOpen
    lda #98
    sta SCREENMEM + 699
    sta SCREENMEM + 700
    rts

changeFullCharScreenBatFaceToClosed
    lda #BLOCK_CHAR
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

waitFrames
    lda #0
    sta screenDraws
wf_loop
    lda screenDraws
    cmp #1
    bcs wf_loop ; Greater than
    rts
