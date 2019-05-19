!cpu 6510
!to "charset.prg",cbm    ; output file
!sl "labels.txt"

char_ram                = $3000
char_ram_bits           = char_ram / $400 ; $0c (00001100)

* = $0801
!byte $0b,$08,$e3,$07,$9e,$32,$30,$36,$31 ; 2019 SYS2061
!byte $00,$00,$00                         ; EOB (End Of Basic)

start:
           lda $d018          ; Memory setup register. 
           ora #char_ram_bits ; bits 1-3 %110, $3000-$37FF, 12288-14335.
           sta $d018

           lda $d016      ; turn off multicolor for characters
           and #$ef       ; (11101111) by cleaning Bit#4 of $D016
           sta $d016

loop_text:
           lda line1,x      ; read characters from line1 table of text...
           sta $05e0,x      ; ...and store in screen ram near the center
           lda line2,x      ; read characters from line2 table of text...
           sta $0630,x      ; ...and put below line1
           lda line3,x      ; read characters from line3 table of text...
           sta $0770,x      ; ...and put below line2
           inx              ; increase x (line column position)
           cpx #$28         ; compare to 40 (rightmost column)
           bne loop_text    ; finished when all 40 cols of a line are processed

           lda #$00         ; a = character
           ldx #$00         ; x = counter
showall    sta $0400,x      ; print the character a on screenposition x
           inx              ; increase x
           txa              ; x => a (a = x)
           cpx #$00         ; check if x has rolled from 255 to 0
           bne showall      ; if not, print and repeat

           inc $d020        ; increase bordercolor
           jmp start        ; start over, or comment out ...
           rts              ; ... if you want to go back to basic

; lines should be 40 cols wide (c64 screenwidth)
line1    !scr "***     the wanderer presents        ***"
line2    !scr "       *** charset demo by tw ***       "
line3    !scr "bla, bla...                             "

* = char_ram
; custom character set.
; -- char #0 --
!byte %00011100
!byte %00100010
!byte %01001010
!byte %01010110
!byte %01001100
!byte %00100000
!byte %00011110
!byte %00000000
; -- char #1 --
!byte %00011000
!byte %00100100
!byte %01000010
!byte %01111110
!byte %01000010
!byte %01000010
!byte %01000010
!byte %00000000
; -- char #2 --
!byte %01111100
!byte %00100010
!byte %00100010
!byte %00111100
!byte %00100010
!byte %00100010
!byte %01111100
!byte %00000000
; -- char #3 --
!byte %00011100
!byte %00100010
!byte %01000000
!byte %01000000
!byte %01000000
!byte %00100010
!byte %00011100
!byte %00000000
; -- char #4 --
!byte %01111000
!byte %00100100
!byte %00100010
!byte %00100010
!byte %00100010
!byte %00100100
!byte %01111000
!byte %00000000
; -- char #5 --
!byte %01111110
!byte %01000000
!byte %01000000
!byte %01111000
!byte %01000000
!byte %01000000
!byte %01111110
!byte %00000000
; -- char #6 --
!byte %01111110
!byte %01000000
!byte %01000000
!byte %01111000
!byte %01000000
!byte %01000000
!byte %01000000
!byte %00000000
; -- char #7 --
!byte %00011100
!byte %00100010
!byte %01000000
!byte %01001110
!byte %01000010
!byte %00100010
!byte %00011100
!byte %00000000
; -- char #8 --
!byte %01000010
!byte %01000010
!byte %01000010
!byte %01111110
!byte %01000010
!byte %01000010
!byte %01000010
!byte %00000000
; -- char #9 --
!byte %00011100
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00011100
!byte %00000000
; -- char #10 --
!byte %00001110
!byte %00000100
!byte %00000100
!byte %00000100
!byte %00000100
!byte %01000100
!byte %00111000
!byte %00000000
; -- char #11 --
!byte %01000010
!byte %01000100
!byte %01001000
!byte %01110000
!byte %01001000
!byte %01000100
!byte %01000010
!byte %00000000
; -- char #12 --
!byte %01000000
!byte %01000000
!byte %01000000
!byte %01000000
!byte %01000000
!byte %01000000
!byte %01111110
!byte %00000000
; -- char #13 --
!byte %01000010
!byte %01100110
!byte %01011010
!byte %01011010
!byte %01000010
!byte %01000010
!byte %01000010
!byte %00000000
; -- char #14 --
!byte %01000010
!byte %01100010
!byte %01010010
!byte %01001010
!byte %01000110
!byte %01000010
!byte %01000010
!byte %00000000
; -- char #15 --
!byte %00011000
!byte %00100100
!byte %01000010
!byte %01000010
!byte %01000010
!byte %00100100
!byte %00011000
!byte %00000000
; -- char #16 --
!byte %01111100
!byte %01000010
!byte %01000010
!byte %01111100
!byte %01000000
!byte %01000000
!byte %01000000
!byte %00000000
; -- char #17 --
!byte %00011000
!byte %00100100
!byte %01000010
!byte %01000010
!byte %01001010
!byte %00100100
!byte %00011010
!byte %00000000
; -- char #18 --
!byte %01111100
!byte %01000010
!byte %01000010
!byte %01111100
!byte %01001000
!byte %01000100
!byte %01000010
!byte %00000000
; -- char #19 --
!byte %00111100
!byte %01000010
!byte %01000000
!byte %00111100
!byte %00000010
!byte %01000010
!byte %00111100
!byte %00000000
; -- char #20 --
!byte %00111110
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00000000
; -- char #21 --
!byte %01000010
!byte %01000010
!byte %01000010
!byte %01000010
!byte %01000010
!byte %01000010
!byte %00111100
!byte %00000000
; -- char #22 --
!byte %01000010
!byte %01000010
!byte %01000010
!byte %00100100
!byte %00100100
!byte %00011000
!byte %00011000
!byte %00000000
; -- char #23 --
!byte %01000010
!byte %01000010
!byte %01000010
!byte %01011010
!byte %01011010
!byte %01100110
!byte %01000010
!byte %00000000
; -- char #24 --
!byte %01000010
!byte %01000010
!byte %00100100
!byte %00011000
!byte %00100100
!byte %01000010
!byte %01000010
!byte %00000000
; -- char #25 --
!byte %00100010
!byte %00100010
!byte %00100010
!byte %00011100
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00000000
; -- char #26 --
!byte %01111110
!byte %00000010
!byte %00000100
!byte %00011000
!byte %00100000
!byte %01000000
!byte %01111110
!byte %00000000
; -- char #27 --
!byte %00111100
!byte %00100000
!byte %00100000
!byte %00100000
!byte %00100000
!byte %00100000
!byte %00111100
!byte %00000000
; -- char #28 --
!byte %00001100
!byte %00010000
!byte %00010000
!byte %00111100
!byte %00010000
!byte %01110000
!byte %01101110
!byte %00000000
; -- char #29 --
!byte %00111100
!byte %00000100
!byte %00000100
!byte %00000100
!byte %00000100
!byte %00000100
!byte %00111100
!byte %00000000
; -- char #30 --
!byte %00000000
!byte %00001000
!byte %00011100
!byte %00101010
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
; -- char #31 --
!byte %00000000
!byte %00000000
!byte %00010000
!byte %00100000
!byte %01111111
!byte %00100000
!byte %00010000
!byte %00000000
; -- char #32 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #33 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00000000
!byte %00000000
!byte %00001000
!byte %00000000
; -- char #34 --
!byte %00100100
!byte %00100100
!byte %00100100
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #35 --
!byte %00100100
!byte %00100100
!byte %01111110
!byte %00100100
!byte %01111110
!byte %00100100
!byte %00100100
!byte %00000000
; -- char #36 --
!byte %00001000
!byte %00011110
!byte %00101000
!byte %00011100
!byte %00001010
!byte %00111100
!byte %00001000
!byte %00000000
; -- char #37 --
!byte %00000000
!byte %01100010
!byte %01100100
!byte %00001000
!byte %00010000
!byte %00100110
!byte %01000110
!byte %00000000
; -- char #38 --
!byte %00110000
!byte %01001000
!byte %01001000
!byte %00110000
!byte %01001010
!byte %01000100
!byte %00111010
!byte %00000000
; -- char #39 --
!byte %00000100
!byte %00001000
!byte %00010000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #40 --
!byte %00000100
!byte %00001000
!byte %00010000
!byte %00010000
!byte %00010000
!byte %00001000
!byte %00000100
!byte %00000000
; -- char #41 --
!byte %00100000
!byte %00010000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00010000
!byte %00100000
!byte %00000000
; -- char #42 --
!byte %00001000
!byte %00101010
!byte %00011100
!byte %00111110
!byte %00011100
!byte %00101010
!byte %00001000
!byte %00000000
; -- char #43 --
!byte %00000000
!byte %00001000
!byte %00001000
!byte %00111110
!byte %00001000
!byte %00001000
!byte %00000000
!byte %00000000
; -- char #44 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00001000
!byte %00001000
!byte %00010000
; -- char #45 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %01111110
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #46 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00011000
!byte %00011000
!byte %00000000
; -- char #47 --
!byte %00000000
!byte %00000010
!byte %00000100
!byte %00001000
!byte %00010000
!byte %00100000
!byte %01000000
!byte %00000000
; -- char #48 --
!byte %00111100
!byte %01000010
!byte %01000110
!byte %01011010
!byte %01100010
!byte %01000010
!byte %00111100
!byte %00000000
; -- char #49 --
!byte %00001000
!byte %00011000
!byte %00101000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00111110
!byte %00000000
; -- char #50 --
!byte %00111100
!byte %01000010
!byte %00000010
!byte %00001100
!byte %00110000
!byte %01000000
!byte %01111110
!byte %00000000
; -- char #51 --
!byte %00111100
!byte %01000010
!byte %00000010
!byte %00011100
!byte %00000010
!byte %01000010
!byte %00111100
!byte %00000000
; -- char #52 --
!byte %00000100
!byte %00001100
!byte %00010100
!byte %00100100
!byte %01111110
!byte %00000100
!byte %00000100
!byte %00000000
; -- char #53 --
!byte %01111110
!byte %01000000
!byte %01111000
!byte %00000100
!byte %00000010
!byte %01000100
!byte %00111000
!byte %00000000
; -- char #54 --
!byte %00011100
!byte %00100000
!byte %01000000
!byte %01111100
!byte %01000010
!byte %01000010
!byte %00111100
!byte %00000000
; -- char #55 --
!byte %01111110
!byte %01000010
!byte %00000100
!byte %00001000
!byte %00010000
!byte %00010000
!byte %00010000
!byte %00000000
; -- char #56 --
!byte %00111100
!byte %01000010
!byte %01000010
!byte %00111100
!byte %01000010
!byte %01000010
!byte %00111100
!byte %00000000
; -- char #57 --
!byte %00111100
!byte %01000010
!byte %01000010
!byte %00111110
!byte %00000010
!byte %00000100
!byte %00111000
!byte %00000000
; -- char #58 --
!byte %00000000
!byte %00000000
!byte %00001000
!byte %00000000
!byte %00000000
!byte %00001000
!byte %00000000
!byte %00000000
; -- char #59 --
!byte %00000000
!byte %00000000
!byte %00001000
!byte %00000000
!byte %00000000
!byte %00001000
!byte %00001000
!byte %00010000
; -- char #60 --
!byte %00001110
!byte %00011000
!byte %00110000
!byte %01100000
!byte %00110000
!byte %00011000
!byte %00001110
!byte %00000000
; -- char #61 --
!byte %00000000
!byte %00000000
!byte %01111110
!byte %00000000
!byte %01111110
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #62 --
!byte %01110000
!byte %00011000
!byte %00001100
!byte %00000110
!byte %00001100
!byte %00011000
!byte %01110000
!byte %00000000
; -- char #63 --
!byte %00111100
!byte %01000010
!byte %00000010
!byte %00001100
!byte %00010000
!byte %00000000
!byte %00010000
!byte %00000000
; -- char #64 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #65 --
!byte %00001000
!byte %00011100
!byte %00111110
!byte %01111111
!byte %01111111
!byte %00011100
!byte %00111110
!byte %00000000
; -- char #66 --
!byte %00010000
!byte %00010000
!byte %00010000
!byte %00010000
!byte %00010000
!byte %00010000
!byte %00010000
!byte %00010000
; -- char #67 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #68 --
!byte %00000000
!byte %00000000
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #69 --
!byte %00000000
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #70 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
!byte %00000000
!byte %00000000
; -- char #71 --
!byte %00100000
!byte %00100000
!byte %00100000
!byte %00100000
!byte %00100000
!byte %00100000
!byte %00100000
!byte %00100000
; -- char #72 --
!byte %00000100
!byte %00000100
!byte %00000100
!byte %00000100
!byte %00000100
!byte %00000100
!byte %00000100
!byte %00000100
; -- char #73 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11100000
!byte %00010000
!byte %00001000
!byte %00001000
; -- char #74 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00000100
!byte %00000011
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #75 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00010000
!byte %11100000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #76 --
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %11111111
; -- char #77 --
!byte %10000000
!byte %01000000
!byte %00100000
!byte %00010000
!byte %00001000
!byte %00000100
!byte %00000010
!byte %00000001
; -- char #78 --
!byte %00000001
!byte %00000010
!byte %00000100
!byte %00001000
!byte %00010000
!byte %00100000
!byte %01000000
!byte %10000000
; -- char #79 --
!byte %11111111
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
; -- char #80 --
!byte %11111111
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
; -- char #81 --
!byte %00000000
!byte %00111100
!byte %01111110
!byte %01111110
!byte %01111110
!byte %01111110
!byte %00111100
!byte %00000000
; -- char #82 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
!byte %00000000
; -- char #83 --
!byte %00110110
!byte %01111111
!byte %01111111
!byte %01111111
!byte %00111110
!byte %00011100
!byte %00001000
!byte %00000000
; -- char #84 --
!byte %01000000
!byte %01000000
!byte %01000000
!byte %01000000
!byte %01000000
!byte %01000000
!byte %01000000
!byte %01000000
; -- char #85 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000011
!byte %00000100
!byte %00001000
!byte %00001000
; -- char #86 --
!byte %10000001
!byte %01000010
!byte %00100100
!byte %00011000
!byte %00011000
!byte %00100100
!byte %01000010
!byte %10000001
; -- char #87 --
!byte %00000000
!byte %00111100
!byte %01000010
!byte %01000010
!byte %01000010
!byte %01000010
!byte %00111100
!byte %00000000
; -- char #88 --
!byte %00001000
!byte %00011100
!byte %00101010
!byte %01110111
!byte %00101010
!byte %00001000
!byte %00001000
!byte %00000000
; -- char #89 --
!byte %00000010
!byte %00000010
!byte %00000010
!byte %00000010
!byte %00000010
!byte %00000010
!byte %00000010
!byte %00000010
; -- char #90 --
!byte %00001000
!byte %00011100
!byte %00111110
!byte %01111111
!byte %00111110
!byte %00011100
!byte %00001000
!byte %00000000
; -- char #91 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %11111111
!byte %00001000
!byte %00001000
!byte %00001000
; -- char #92 --
!byte %10100000
!byte %01010000
!byte %10100000
!byte %01010000
!byte %10100000
!byte %01010000
!byte %10100000
!byte %01010000
; -- char #93 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
; -- char #94 --
!byte %00000000
!byte %00000000
!byte %00000001
!byte %00111110
!byte %01010100
!byte %00010100
!byte %00010100
!byte %00000000
; -- char #95 --
!byte %11111111
!byte %01111111
!byte %00111111
!byte %00011111
!byte %00001111
!byte %00000111
!byte %00000011
!byte %00000001
; -- char #96 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #97 --
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
; -- char #98 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #99 --
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #100 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
; -- char #101 --
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
!byte %10000000
; -- char #102 --
!byte %10101010
!byte %01010101
!byte %10101010
!byte %01010101
!byte %10101010
!byte %01010101
!byte %10101010
!byte %01010101
; -- char #103 --
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
; -- char #104 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %10101010
!byte %01010101
!byte %10101010
!byte %01010101
; -- char #105 --
!byte %11111111
!byte %11111110
!byte %11111100
!byte %11111000
!byte %11110000
!byte %11100000
!byte %11000000
!byte %10000000
; -- char #106 --
!byte %00000011
!byte %00000011
!byte %00000011
!byte %00000011
!byte %00000011
!byte %00000011
!byte %00000011
!byte %00000011
; -- char #107 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001111
!byte %00001000
!byte %00001000
!byte %00001000
; -- char #108 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
; -- char #109 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001111
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #110 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111000
!byte %00001000
!byte %00001000
!byte %00001000
; -- char #111 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
!byte %11111111
; -- char #112 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00001111
!byte %00001000
!byte %00001000
!byte %00001000
; -- char #113 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #114 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
!byte %00001000
!byte %00001000
!byte %00001000
; -- char #115 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %11111000
!byte %00001000
!byte %00001000
!byte %00001000
; -- char #116 --
!byte %11000000
!byte %11000000
!byte %11000000
!byte %11000000
!byte %11000000
!byte %11000000
!byte %11000000
!byte %11000000
; -- char #117 --
!byte %11100000
!byte %11100000
!byte %11100000
!byte %11100000
!byte %11100000
!byte %11100000
!byte %11100000
!byte %11100000
; -- char #118 --
!byte %00000111
!byte %00000111
!byte %00000111
!byte %00000111
!byte %00000111
!byte %00000111
!byte %00000111
!byte %00000111
; -- char #119 --
!byte %11111111
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #120 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #121 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #122 --
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %00000001
!byte %11111111
; -- char #123 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
; -- char #124 --
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #125 --
!byte %00001000
!byte %00001000
!byte %00001000
!byte %00001000
!byte %11111000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #126 --
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #127 --
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
; -- char #128 --
!byte %11100011
!byte %11011101
!byte %10110101
!byte %10101001
!byte %10110011
!byte %11011111
!byte %11100001
!byte %11111111
; -- char #129 --
!byte %11100111
!byte %11011011
!byte %10111101
!byte %10000001
!byte %10111101
!byte %10111101
!byte %10111101
!byte %11111111
; -- char #130 --
!byte %10000011
!byte %11011101
!byte %11011101
!byte %11000011
!byte %11011101
!byte %11011101
!byte %10000011
!byte %11111111
; -- char #131 --
!byte %11100011
!byte %11011101
!byte %10111111
!byte %10111111
!byte %10111111
!byte %11011101
!byte %11100011
!byte %11111111
; -- char #132 --
!byte %10000111
!byte %11011011
!byte %11011101
!byte %11011101
!byte %11011101
!byte %11011011
!byte %10000111
!byte %11111111
; -- char #133 --
!byte %10000001
!byte %10111111
!byte %10111111
!byte %10000111
!byte %10111111
!byte %10111111
!byte %10000001
!byte %11111111
; -- char #134 --
!byte %10000001
!byte %10111111
!byte %10111111
!byte %10000111
!byte %10111111
!byte %10111111
!byte %10111111
!byte %11111111
; -- char #135 --
!byte %11100011
!byte %11011101
!byte %10111111
!byte %10110001
!byte %10111101
!byte %11011101
!byte %11100011
!byte %11111111
; -- char #136 --
!byte %10111101
!byte %10111101
!byte %10111101
!byte %10000001
!byte %10111101
!byte %10111101
!byte %10111101
!byte %11111111
; -- char #137 --
!byte %11100011
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11100011
!byte %11111111
; -- char #138 --
!byte %11110001
!byte %11111011
!byte %11111011
!byte %11111011
!byte %11111011
!byte %10111011
!byte %11000111
!byte %11111111
; -- char #139 --
!byte %10111101
!byte %10111011
!byte %10110111
!byte %10001111
!byte %10110111
!byte %10111011
!byte %10111101
!byte %11111111
; -- char #140 --
!byte %10111111
!byte %10111111
!byte %10111111
!byte %10111111
!byte %10111111
!byte %10111111
!byte %10000001
!byte %11111111
; -- char #141 --
!byte %10111101
!byte %10011001
!byte %10100101
!byte %10100101
!byte %10111101
!byte %10111101
!byte %10111101
!byte %11111111
; -- char #142 --
!byte %10111101
!byte %10011101
!byte %10101101
!byte %10110101
!byte %10111001
!byte %10111101
!byte %10111101
!byte %11111111
; -- char #143 --
!byte %11100111
!byte %11011011
!byte %10111101
!byte %10111101
!byte %10111101
!byte %11011011
!byte %11100111
!byte %11111111
; -- char #144 --
!byte %10000011
!byte %10111101
!byte %10111101
!byte %10000011
!byte %10111111
!byte %10111111
!byte %10111111
!byte %11111111
; -- char #145 --
!byte %11100111
!byte %11011011
!byte %10111101
!byte %10111101
!byte %10110101
!byte %11011011
!byte %11100101
!byte %11111111
; -- char #146 --
!byte %10000011
!byte %10111101
!byte %10111101
!byte %10000011
!byte %10110111
!byte %10111011
!byte %10111101
!byte %11111111
; -- char #147 --
!byte %11000011
!byte %10111101
!byte %10111111
!byte %11000011
!byte %11111101
!byte %10111101
!byte %11000011
!byte %11111111
; -- char #148 --
!byte %11000001
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11111111
; -- char #149 --
!byte %10111101
!byte %10111101
!byte %10111101
!byte %10111101
!byte %10111101
!byte %10111101
!byte %11000011
!byte %11111111
; -- char #150 --
!byte %10111101
!byte %10111101
!byte %10111101
!byte %11011011
!byte %11011011
!byte %11100111
!byte %11100111
!byte %11111111
; -- char #151 --
!byte %10111101
!byte %10111101
!byte %10111101
!byte %10100101
!byte %10100101
!byte %10011001
!byte %10111101
!byte %11111111
; -- char #152 --
!byte %10111101
!byte %10111101
!byte %11011011
!byte %11100111
!byte %11011011
!byte %10111101
!byte %10111101
!byte %11111111
; -- char #153 --
!byte %11011101
!byte %11011101
!byte %11011101
!byte %11100011
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11111111
; -- char #154 --
!byte %10000001
!byte %11111101
!byte %11111011
!byte %11100111
!byte %11011111
!byte %10111111
!byte %10000001
!byte %11111111
; -- char #155 --
!byte %11000011
!byte %11011111
!byte %11011111
!byte %11011111
!byte %11011111
!byte %11011111
!byte %11000011
!byte %11111111
; -- char #156 --
!byte %11110011
!byte %11101111
!byte %11101111
!byte %11000011
!byte %11101111
!byte %10001111
!byte %10010001
!byte %11111111
; -- char #157 --
!byte %11000011
!byte %11111011
!byte %11111011
!byte %11111011
!byte %11111011
!byte %11111011
!byte %11000011
!byte %11111111
; -- char #158 --
!byte %11111111
!byte %11110111
!byte %11100011
!byte %11010101
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
; -- char #159 --
!byte %11111111
!byte %11111111
!byte %11101111
!byte %11011111
!byte %10000000
!byte %11011111
!byte %11101111
!byte %11111111
; -- char #160 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #161 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11111111
!byte %11111111
!byte %11110111
!byte %11111111
; -- char #162 --
!byte %11011011
!byte %11011011
!byte %11011011
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #163 --
!byte %11011011
!byte %11011011
!byte %10000001
!byte %11011011
!byte %10000001
!byte %11011011
!byte %11011011
!byte %11111111
; -- char #164 --
!byte %11110111
!byte %11100001
!byte %11010111
!byte %11100011
!byte %11110101
!byte %11000011
!byte %11110111
!byte %11111111
; -- char #165 --
!byte %11111111
!byte %10011101
!byte %10011011
!byte %11110111
!byte %11101111
!byte %11011001
!byte %10111001
!byte %11111111
; -- char #166 --
!byte %11001111
!byte %10110111
!byte %10110111
!byte %11001111
!byte %10110101
!byte %10111011
!byte %11000101
!byte %11111111
; -- char #167 --
!byte %11111011
!byte %11110111
!byte %11101111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #168 --
!byte %11111011
!byte %11110111
!byte %11101111
!byte %11101111
!byte %11101111
!byte %11110111
!byte %11111011
!byte %11111111
; -- char #169 --
!byte %11011111
!byte %11101111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11101111
!byte %11011111
!byte %11111111
; -- char #170 --
!byte %11110111
!byte %11010101
!byte %11100011
!byte %11000001
!byte %11100011
!byte %11010101
!byte %11110111
!byte %11111111
; -- char #171 --
!byte %11111111
!byte %11110111
!byte %11110111
!byte %11000001
!byte %11110111
!byte %11110111
!byte %11111111
!byte %11111111
; -- char #172 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11110111
!byte %11110111
!byte %11101111
; -- char #173 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %10000001
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #174 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11100111
!byte %11100111
!byte %11111111
; -- char #175 --
!byte %11111111
!byte %11111101
!byte %11111011
!byte %11110111
!byte %11101111
!byte %11011111
!byte %10111111
!byte %11111111
; -- char #176 --
!byte %11000011
!byte %10111101
!byte %10111001
!byte %10100101
!byte %10011101
!byte %10111101
!byte %11000011
!byte %11111111
; -- char #177 --
!byte %11110111
!byte %11100111
!byte %11010111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11000001
!byte %11111111
; -- char #178 --
!byte %11000011
!byte %10111101
!byte %11111101
!byte %11110011
!byte %11001111
!byte %10111111
!byte %10000001
!byte %11111111
; -- char #179 --
!byte %11000011
!byte %10111101
!byte %11111101
!byte %11100011
!byte %11111101
!byte %10111101
!byte %11000011
!byte %11111111
; -- char #180 --
!byte %11111011
!byte %11110011
!byte %11101011
!byte %11011011
!byte %10000001
!byte %11111011
!byte %11111011
!byte %11111111
; -- char #181 --
!byte %10000001
!byte %10111111
!byte %10000111
!byte %11111011
!byte %11111101
!byte %10111011
!byte %11000111
!byte %11111111
; -- char #182 --
!byte %11100011
!byte %11011111
!byte %10111111
!byte %10000011
!byte %10111101
!byte %10111101
!byte %11000011
!byte %11111111
; -- char #183 --
!byte %10000001
!byte %10111101
!byte %11111011
!byte %11110111
!byte %11101111
!byte %11101111
!byte %11101111
!byte %11111111
; -- char #184 --
!byte %11000011
!byte %10111101
!byte %10111101
!byte %11000011
!byte %10111101
!byte %10111101
!byte %11000011
!byte %11111111
; -- char #185 --
!byte %11000011
!byte %10111101
!byte %10111101
!byte %11000001
!byte %11111101
!byte %11111011
!byte %11000111
!byte %11111111
; -- char #186 --
!byte %11111111
!byte %11111111
!byte %11110111
!byte %11111111
!byte %11111111
!byte %11110111
!byte %11111111
!byte %11111111
; -- char #187 --
!byte %11111111
!byte %11111111
!byte %11110111
!byte %11111111
!byte %11111111
!byte %11110111
!byte %11110111
!byte %11101111
; -- char #188 --
!byte %11110001
!byte %11100111
!byte %11001111
!byte %10011111
!byte %11001111
!byte %11100111
!byte %11110001
!byte %11111111
; -- char #189 --
!byte %11111111
!byte %11111111
!byte %10000001
!byte %11111111
!byte %10000001
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #190 --
!byte %10001111
!byte %11100111
!byte %11110011
!byte %11111001
!byte %11110011
!byte %11100111
!byte %10001111
!byte %11111111
; -- char #191 --
!byte %11000011
!byte %10111101
!byte %11111101
!byte %11110011
!byte %11101111
!byte %11111111
!byte %11101111
!byte %11111111
; -- char #192 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #193 --
!byte %11110111
!byte %11100011
!byte %11000001
!byte %10000000
!byte %10000000
!byte %11100011
!byte %11000001
!byte %11111111
; -- char #194 --
!byte %11101111
!byte %11101111
!byte %11101111
!byte %11101111
!byte %11101111
!byte %11101111
!byte %11101111
!byte %11101111
; -- char #195 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #196 --
!byte %11111111
!byte %11111111
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #197 --
!byte %11111111
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #198 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
!byte %11111111
!byte %11111111
; -- char #199 --
!byte %11011111
!byte %11011111
!byte %11011111
!byte %11011111
!byte %11011111
!byte %11011111
!byte %11011111
!byte %11011111
; -- char #200 --
!byte %11111011
!byte %11111011
!byte %11111011
!byte %11111011
!byte %11111011
!byte %11111011
!byte %11111011
!byte %11111011
; -- char #201 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00011111
!byte %11101111
!byte %11110111
!byte %11110111
; -- char #202 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11111011
!byte %11111100
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #203 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11101111
!byte %00011111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #204 --
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %00000000
; -- char #205 --
!byte %01111111
!byte %10111111
!byte %11011111
!byte %11101111
!byte %11110111
!byte %11111011
!byte %11111101
!byte %11111110
; -- char #206 --
!byte %11111110
!byte %11111101
!byte %11111011
!byte %11110111
!byte %11101111
!byte %11011111
!byte %10111111
!byte %01111111
; -- char #207 --
!byte %00000000
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
; -- char #208 --
!byte %00000000
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
; -- char #209 --
!byte %11111111
!byte %11000011
!byte %10000001
!byte %10000001
!byte %10000001
!byte %10000001
!byte %11000011
!byte %11111111
; -- char #210 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
!byte %11111111
; -- char #211 --
!byte %11001001
!byte %10000000
!byte %10000000
!byte %10000000
!byte %11000001
!byte %11100011
!byte %11110111
!byte %11111111
; -- char #212 --
!byte %10111111
!byte %10111111
!byte %10111111
!byte %10111111
!byte %10111111
!byte %10111111
!byte %10111111
!byte %10111111
; -- char #213 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111100
!byte %11111011
!byte %11110111
!byte %11110111
; -- char #214 --
!byte %01111110
!byte %10111101
!byte %11011011
!byte %11100111
!byte %11100111
!byte %11011011
!byte %10111101
!byte %01111110
; -- char #215 --
!byte %11111111
!byte %11000011
!byte %10111101
!byte %10111101
!byte %10111101
!byte %10111101
!byte %11000011
!byte %11111111
; -- char #216 --
!byte %11110111
!byte %11100011
!byte %11010101
!byte %10001000
!byte %11010101
!byte %11110111
!byte %11110111
!byte %11111111
; -- char #217 --
!byte %11111101
!byte %11111101
!byte %11111101
!byte %11111101
!byte %11111101
!byte %11111101
!byte %11111101
!byte %11111101
; -- char #218 --
!byte %11110111
!byte %11100011
!byte %11000001
!byte %10000000
!byte %11000001
!byte %11100011
!byte %11110111
!byte %11111111
; -- char #219 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %00000000
!byte %11110111
!byte %11110111
!byte %11110111
; -- char #220 --
!byte %01011111
!byte %10101111
!byte %01011111
!byte %10101111
!byte %01011111
!byte %10101111
!byte %01011111
!byte %10101111
; -- char #221 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
; -- char #222 --
!byte %11111111
!byte %11111111
!byte %11111110
!byte %11000001
!byte %10101011
!byte %11101011
!byte %11101011
!byte %11111111
; -- char #223 --
!byte %00000000
!byte %10000000
!byte %11000000
!byte %11100000
!byte %11110000
!byte %11111000
!byte %11111100
!byte %11111110
; -- char #224 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #225 --
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
; -- char #226 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #227 --
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #228 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
; -- char #229 --
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
!byte %01111111
; -- char #230 --
!byte %01010101
!byte %10101010
!byte %01010101
!byte %10101010
!byte %01010101
!byte %10101010
!byte %01010101
!byte %10101010
; -- char #231 --
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
; -- char #232 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %01010101
!byte %10101010
!byte %01010101
!byte %10101010
; -- char #233 --
!byte %00000000
!byte %00000001
!byte %00000011
!byte %00000111
!byte %00001111
!byte %00011111
!byte %00111111
!byte %01111111
; -- char #234 --
!byte %11111100
!byte %11111100
!byte %11111100
!byte %11111100
!byte %11111100
!byte %11111100
!byte %11111100
!byte %11111100
; -- char #235 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110000
!byte %11110111
!byte %11110111
!byte %11110111
; -- char #236 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
; -- char #237 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110000
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #238 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000111
!byte %11110111
!byte %11110111
!byte %11110111
; -- char #239 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
!byte %00000000
; -- char #240 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11110000
!byte %11110111
!byte %11110111
!byte %11110111
; -- char #241 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #242 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
!byte %11110111
!byte %11110111
!byte %11110111
; -- char #243 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %00000111
!byte %11110111
!byte %11110111
!byte %11110111
; -- char #244 --
!byte %00111111
!byte %00111111
!byte %00111111
!byte %00111111
!byte %00111111
!byte %00111111
!byte %00111111
!byte %00111111
; -- char #245 --
!byte %00011111
!byte %00011111
!byte %00011111
!byte %00011111
!byte %00011111
!byte %00011111
!byte %00011111
!byte %00011111
; -- char #246 --
!byte %11111000
!byte %11111000
!byte %11111000
!byte %11111000
!byte %11111000
!byte %11111000
!byte %11111000
!byte %11111000
; -- char #247 --
!byte %00000000
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #248 --
!byte %00000000
!byte %00000000
!byte %00000000
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #249 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00000000
!byte %00000000
!byte %00000000
; -- char #250 --
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %11111110
!byte %00000000
; -- char #251 --
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
; -- char #252 --
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #253 --
!byte %11110111
!byte %11110111
!byte %11110111
!byte %11110111
!byte %00000111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #254 --
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
!byte %11111111
!byte %11111111
!byte %11111111
!byte %11111111
; -- char #255 --
!byte %00001111
!byte %00001111
!byte %00001111
!byte %00001111
!byte %11110000
!byte %11110000
!byte %11110000
!byte %11110000

end:

