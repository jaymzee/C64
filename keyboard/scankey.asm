; display keyboard scans until the Q key is pressed
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

-	clc		; restore cursor
	ldx #01		; cursor row
	ldy #05		; cursor column
	jsr plot

	.for c in 7, 1, 2, 3, 4, 5, 6, 0
	lda #2**c ^ $ff
	jsr dispkey
	.if c == 7
	and #%01000000	; masking row 6
	beq +		; wait until key "Q" 
	.fi
	.next
	jmp -
+	lda #%11111111	; unselect all columns of the matrix
	cli		; enable interrupts
	rts		; back to BASIC

; write columns in reg A onto CIA 1 port A 
; display keyboard matrix rows (CIA 1 port B) as hexadecimal digits
dispkey sta cia1PrtA	; activate column
	lda cia1PrtB	; read rows
	eor #$ff
	jsr printh	; print 1's complement of row bits
	eor #$ff
	pha		; save rows
	lda #$20
	jsr chrout	; print space
	pla		; restore rows
	rts

; print byte in reg A as hex
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

msg	.text $93, "ROW   7  1  2  3  4  5  6  0", $0d
        .text "COL", $0d
	.text "KEYBOARD SCAN, PRESS Q KEY TO QUIT"
msglen	= * - msg
