!cpu 6510
!to "irq.prg",cbm    ; output file
!sl "labels.txt"

* = $0801
!byte $0b,$08,$e3,$07,$9e,$32,$30,$36,$31 ; 2019 SYS2061
!byte $00,$00,$00

start:
   lda #%01111111  ; "Switch off" interrupts signals from CIA-1
   sta $dc0d       ; (timer interrupt)

   and $d011       ; Clear most significant bit in VIC's raster register
   sta $d011       ; (high bit of raster(0))

   lda #100        ; Set the raster line number where interrupt should occur.
   sta $d012       ; (low bit of raster)

   lda #<irq       ; Set the interrupt vector to point to interrupt service
   sta $0314       ; routine below.
   lda #>irq
   sta $0315

   lda #%00000001  ; Enable raster interrupt signals from VIC
   sta $d01a

   rts             ; Initialization done; return to BASIC.

irq:
   nop             ; Some delay to stabilize raster.
   nop
   nop
   nop

   lda $d020       ; Get background color
   sta bg          ; And save it.

   lda $d021       ; Get foreground color
   sta fg          ; And save it.

   inc $d020       ; bgcolor +1
   lda $d020       ; Get new color
   sta $d021       ; Set foreground to same color as background to
                   ; create the suggestion of a horizontal bar.

   ldx #88         ; Empty loop that "does nothing" for a little under 
   dex             ; a half millisecond.
   bne *-1         ; (heigth of horizontal bar)

   inc $d020       ; Increase background color
   inc $d021       ; Increase foreground color

   ldx #90         ; Empty loop that "does nothing" for a little under
   dex             ; a half millisecond.
   bne *-1

   inc $d020       ; Increase background color again.
   inc $d021       ; Increase foreground color again.

   ldx #90         ; Empty loop that "does nothing" for a little under
   dex             ; a half millisecond.
   bne *-1
   
   lda bg          ; Get original background color.
   sta $d020       ; Set original background color.
   lda fg          ; Get original foreground color.
   sta $d021       ; Set original foreground color.

   asl $d019       ; "Acknowledge" the interrupt by clearing the 
                   ; VIC's interrupt flag.

   jmp $ea31       ; Jump into KERNAL's standard interrupt service 
                   ; routine to handle keyboard scan, cursor display etc.

bg:
   !byte $00       ; Byte assigned to save the background color.

fg:
   !byte $00       ; Byte assigned to save the foreground color.

