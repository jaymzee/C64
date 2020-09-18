; This program waits until the key "S" was pushed.
; assemble with 64tass
; start with SYS 49152

;   CIA 1 Port A = keyboard columns A thru H (output)
;   CIA 1 Port B = keyboard rows 0 thru 7 (input)

;       PB     0       1       2       7       4       5       6       3
;   PA  --------------------------------------------------------------------
;    7 |       1       ←      CTRL    STOP   SPACE     C=      Q       2
;    1 |       3       W       A    L-SHIFT    Z       S       E       4
;    2 |       5       R       D       X       C       F       T       6
;    3 |       7       Y       G       V       B       H       U       8
;    4 |       9       I       J       N       M       K       O       0
;    5 |       +       P       L       ,       .       :       @       -
;    6 |       £       *       ;       /    R-SHIFT    =       ↑    HOME/CLR
;    0 |      DEL     RET   CRSR ⇄  CRSR ⇅    F1      F3      F5      F7

	.include "cia.asm"
; constants
chrout	= $ffd2		; print character kernal routine
plot	= $fff0		; save/restore cursor kernal routine
scrRAM	= $0400		; start of screen memory
colRAM	= $d800		; start of color RAM

; entry point
*	= $c000
start	ldx #00		; print greeting
-	lda msg,x
	jsr chrout
	inx
	cpx #msglen
	bne -

	sei		; disable interrupts

	lda #%11111111	; CIA#1 port A = outputs
	sta cia1DirA
	lda #%00000000	; CIA#1 port B = inputs
	sta cia1DirB

-	clc		; plot restore cursor
	ldx #00		; row of screen
	ldy #01		; column of screen
	jsr plot

	lda #%11111101	; testing column 1 (COL1) of the matrix
	sta cia1PrtA	; write column
	lda cia1PrtB	; read row
	eor #$ff
	jsr printh
	sta scrRAM + 4
	eor #$ff
	and #%00100000	; masking row 5 (ROW5) 
	bne -		; wait until key "S" 

	lda #%11111111	; unselect all columsn of the matrix
	cli		; enable interrupts
	rts		; back to BASIC

printh	pha		; save byte for later
	.rept 4
	lsr		; select upper nibble
	.next
	cmp #10		; if A < 10
	blt +		;   A += 0x30 (convert to ASCII 0 thru 9)
	clc		; else
	adc #7		;   A += 0x37 (convert to ASCII A thru F)
+	adc #$30
	jsr chrout	; print upper nibble

	pla		; restore byte
	pha
	and #$f		; select lower nibble
	cmp #10		; if A < 10
	blt +		;   A += 0x30 (convert to ASCII 0 thru 9)
	clc		; else
	adc #7		;   A += 0x37 (convert to ASCII A thru F)
+	adc #$30
	jsr chrout	; print lower nibble

	pla		; restore byte
	rts

msg	.text $93,"$     KEYBOARD SCAN", $0d,"      PRESS S KEY TO QUIT"
msglen	= * - msg
