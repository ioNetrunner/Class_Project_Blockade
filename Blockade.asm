; Name:			Io Netrunner, Noah Shinn
; Course:		CpSc 370
; Instructor:		Dr. Conlon
; Date Started:		02/01/2015
; Last Modified:	04/06/2015
; Program Purpose:	 A game!

	.CR	6502		; Assemble 6502 Language
	.LI on,toff		; Listing on, no timings included
	.TF blockade.prg,BIN 	; Object file and format
Spaces	= $20
box	= 230
home	= $7000			; Address of home on video screen
homel	= $00
homeh	= $70
scrend	= $73e8			; Address of bottom right of video screen
screndl	= $e8			;
screndh	= $7300 		;
rowsize	= 40 			;
colsize	= 25 			;
midstrt	= scrend-$200		; Name Start
mestrt	= midstrt+85		; Enter Start
iobase 	= $8800			;
iostat 	= iobase+1		;
iocmd	= iobase+2 		;
ioctrl	= iobase+3 		;
bvar 	= $71e8			; B variable.
nvar	= $7200  		; n variable.
scearr 	= $CD 			; Screen Array.



; GAME STARTS HERE!
	.OR $0300
start	cld			; Set Binary mode.

	cli
	lda #%00001011		;
	sta iocmd		; Set command status.
	lda #%00011010		;
	sta ioctrl		; 0 stop bits, 8 bit word, 2400 baud

	jsr loadarr		; Load the array into memory.

	ldy #$ff		; Load screen size into Y.
	lda #32			; Load space into A.

	jsr clsc		; Clear Screen.
	jsr names		; Print Names.
	jsr boarderloop		; Print Boarder.
; Loop to print name.
nameloop:			; Name Loop (Enter to Start)
	lda iostat		; Read the ACIA status
	and #$08		; RX Empty?
	beq nameloop		; Yes, loop.
	jsr readnKeys       	; jump to subroutine readnKeys
	jsr clsc		; Clear space between names + Enter.
	jsr boarderloop
	lda #'B'
	sta bvar
	lda #'n'
	sta nvar
; Actual Game Loop.
gloop:
	lda iostat		; Read the ACIA status
	and #$08		; RX Empty?
	beq gloop		; Yes, loop.
	jsr readKeys		; jump to subroutine readKeys
	jsr gloop		; Jump to game loop.
	brk			; ENDS THE GAME!

;	Pointer Array
loadarr:
	lda #$00
	sta scearr
	lda #$70
	sta scearr+1
	lda #$28
	sta scearr+2
	lda #$70
	sta scearr+3
	lda #$50
	sta scearr+4
	lda #$70
	sta scearr+5
	lda #$78
	sta scearr+6
	lda #$70
	sta scearr+7
	lda #$A0
	sta scearr+8
	lda #$70
	sta scearr+9
	lda #$C8
	sta scearr+10
	lda #$70
	sta scearr+11
	lda #$F0
	sta scearr+12
	lda #$70
	sta scearr+13
	lda #$18
	sta scearr+14
	lda #$71
	sta scearr+15
	lda #$40
	sta scearr+16
	lda #$71
	sta scearr+17
	lda #$68
	sta scearr+18
	lda #$71
	sta scearr+19
	lda #$90
	sta scearr+20
	lda #$71
	sta scearr+21
	lda #$B8
	sta scearr+22
	lda #$71
	sta scearr+23
	lda #$E0
	sta scearr+24
	lda #$71
	sta scearr+25
	lda #$08
	sta scearr+26
	lda #$72
	sta scearr+27
	lda #$30
	sta scearr+28
	lda #$72
	sta scearr+29
	lda #$58
	sta scearr+30
	lda #$72
	sta scearr+31
	lda #$80
	sta scearr+32
	lda #$72
	sta scearr+33
	lda #$A8
	sta scearr+34
	lda #$72
	sta scearr+35
	lda #$D0
	sta scearr+36
	lda #$72
	sta scearr+37
	lda #$F8
	sta scearr+38
	lda #$72
	sta scearr+39
	lda #$20
	sta scearr+40
	lda #$73
	sta scearr+41
	lda #$48
	sta scearr+42
	lda #$73
	sta scearr+43
	lda #$70
	sta scearr+44
	lda #$73
	sta scearr+45
	lda #$98
	sta scearr+46
	lda #$73
	sta scearr+47
	lda #$C0
	sta scearr+48
	lda #$73
	sta scearr+49
	lda #$E8
	sta scearr+50
	lda #$73
	sta scearr+51
	rts


; Loop to Print the Boarder
boarderloop:
	lda #$E6
	ldy #0
bbloop:
	sta (scearr), Y
	iny
	cpy #40
	bne bbloop
	ldy #0
	sta (scearr+2), Y
	ldy #39
	sta (scearr+2), Y
	ldy #0
	sta (scearr+4), Y
	ldy #39
	sta (scearr+4), Y
	ldy #0
	sta (scearr+6), Y
	ldy #39
	sta (scearr+6), Y
	ldy #0
	sta (scearr+8), Y
	ldy #39
	sta (scearr+8), Y
	ldy #0
	sta (scearr+10), Y
	ldy #39
	sta (scearr+10), Y
	ldy #0
	sta (scearr+12), Y
	ldy #39
	sta (scearr+12), Y
	ldy #0
	sta (scearr+14), Y
	ldy #39
	sta (scearr+14), Y
	ldy #0
	sta (scearr+16), Y
	ldy #39
	sta (scearr+16), Y
	ldy #0
	sta (scearr+18), Y
	ldy #39
	sta (scearr+18), Y
	ldy #0
	sta (scearr+20), Y
	ldy #39
	sta (scearr+20), Y
	ldy #0
	sta (scearr+22), Y
	ldy #39
	sta (scearr+22), Y
	ldy #0
	sta (scearr+24), Y
	ldy #39
	sta (scearr+24), Y
	ldy #0
	sta (scearr+26), Y
	ldy #39
	sta (scearr+26), Y
	ldy #0
	sta (scearr+28), Y
	ldy #39
	sta (scearr+28), Y
	ldy #0
	sta (scearr+30), Y
	ldy #39
	sta (scearr+30), Y
	ldy #0
	sta (scearr+32), Y
	ldy #39
	sta (scearr+32), Y
	ldy #0
	sta (scearr+34), Y
	ldy #39
	sta (scearr+34), Y
	ldy #0
	sta (scearr+36), Y
	ldy #39
	sta (scearr+36), Y
	ldy #0
	sta (scearr+38), Y
	ldy #39
	sta (scearr+38), Y
	ldy #0
	sta (scearr+40), Y
	ldy #39
	sta (scearr+40), Y
	ldy #0
	sta (scearr+42), Y
	ldy #39
	sta (scearr+42), Y
	ldy #0
	sta (scearr+44), Y
	ldy #39
	sta (scearr+44), Y
	ldy #0
	sta (scearr+46), Y
	ldy #39
	sta (scearr+46), Y
	ldy #0
ebloop:
	sta (scearr+48), Y
	iny
	cpy #40
	bne ebloop
	rts



; Clear the screen.
clsc:
	ldy #$ff		; Load MAX into Y.
	lda #32			; Load space into A.
cloop:
	sta $7000, Y		; Clear screen.
	sta $7100, Y		;
	sta $7200, Y		;
	sta $7300, Y		;
	dey			; Decrement Y.
	cpy #-1			; Compare Y to Neg 1.
	bne cloop		; Loop while Y <= zero.
	rts			; Return from Subroutine.

; Print our names.
names:
	ldx #0			; Load zero into X.
nloop:
	lda nameMsg, X		; Load Names into A.
	bmi enter 		; Branch on equal zero to enter loop.
	sta midstrt, X		; Store A into Names.
	inx			; Increase X.
	jmp nloop		; Jump to loop, repeat.

nameMsg	.AS 'Io Netrunner & Noah Shinn'

; Print "Enter to Start" to screen
enter:
	ldx #0 			; Load zero into X.
enterloop:
	lda enterMsg, X		; Load Enter into A.
	bmi eout		; Branch on equal zero to out.
	sta mestrt, X		; Store A into Enter.
	inx			; Increase X.
	jmp enterloop		; Jump to loop, repeat.
eout:
	rts			; Return from Subroutine.

enterMsg .AS ' Enter to Start'

; Enter Key Read-in
readnKeys:
  lda iostat			; Read ACIA status.
  and #$10			; Is the rx register empty?
  beq nokey			; Nothing from kbd at this time.
  lda iobase			; Read into accumulator.
  cmp #$0D
  bne readnKeys
  rts

; Key reading Subroutine
readKeys:
  lda iostat			; Read ACIA status.
  and #$10			; Is the rx register empty?
  beq nokey			; Nothing from kbd at this time.
  lda iobase			; Read into accumulator.
  cmp #$77			; Compare to 'w'.
  beq bupKey
  cmp #$73			; Compare to 's'.
  beq bdownKey
  cmp #$61			; Compare to 'a'.
  beq bleftKey
  cmp #$64			; Compare to 'd'.
  beq brightKey
  cmp #$6f			; Compare to 'o'.
  beq nupKey
  cmp #$6c			; Compare to 'l'.
  beq ndownKey
  cmp #$6b			; Compare to 'k'.
  beq nleftKey
  cmp #$3b			; Compare to ';'.
  beq nrightKey
nokey:
	rts            		;return

; Various Direction Subroutines
bupKey:
	lda #'B'
	sta bvar-40		; Store B into screen.
;	bvar=bvar-40
	rts 			; Return

bdownKey:
	lda #'B'
	sta bvar+40		; Store B into screen.
	rts 			; Return

bleftKey:
	lda #'B'
	sta bvar-1		; Store B into screen.
	rts 			; Return

brightKey:
	lda #'B'
	sta bvar+1		; Store B into screen.
	rts 			; Return

nupKey:
	lda #'n'
	sta nvar-40		; Store n into screen.
	rts 			; Return

ndownKey:
	lda #'n'
	sta nvar+40		; Store n into screen.
	rts 			; Return

nleftKey:
	lda #'n'
	sta nvar-1		; Store n into screen.
	rts 			; Return

nrightKey:
	lda #'n'
	sta nvar+1		; Store n into screen.
	rts 			; Return
