!cpu 6502
!to "hello.prg",cbm ; output file
!sl "labels.txt"

* = $1001 ; vic20 start of basic.

; 2020 SYS4109
!byte $0b,$10,$e4,$07,$9e,$34,$31,$30,$39
!byte $00,$00,$00

ldx #$00

loop:
  lda helloworld,x
  beq end
  jsr $ffd2
  inx
  bne loop

end:
  rts

helloworld:
  !byte 72,69,76,76,79,44,32,87,79,82,76,68,33,13,00
