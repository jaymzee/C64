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

; entry point
*	= $c000
start	sei		; disable interrupts

	lda #$ff;	; CIA#1 port A = outputs
	sta cia1DirA

	lda #$00	; CIA#1 port B = inputs
	sta cia1DirB

	lda #%11111101	; testing column 1 (COL1) of the matrix
	sta cia1PrtA	; write column
-	lda cia1PrtB	; read row
	and #%00100000	; masking row 5 (ROW5) 
	bne -		; wait until key "S" 

	cli		; interrupts activated

	rts		; back to BASIC

