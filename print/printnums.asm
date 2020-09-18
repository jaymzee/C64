; printing values as decimal, octal and hexadecimal

; contants
chrout	= $ffd2

*	= $1000
main:
	lda #$37
	jsr print_hex
	lda #13		; newline
	jsr chrout
	lda #$ab
	jsr print_hex
	rts

; print a single digit decimal number (0 thru 9)
print_dec:
	clc
	adc #$30
	jsr chrout
	rts

; print byte as 3 digit octal number
print_oct:
	pha	; save a copy of A for later
	.rept 6
	lsr
	.next
	ora #$30
	jsr chrout
	pla
	pha
	lsr
	lsr
	lsr
	and #7
	ora #$30
	jsr chrout
	pla
	and #7
	ora #$30
	jsr chrout
	rts

print_hex:
	pha	; save a copy of A for later
	.rept 4
	lsr
	.next
	cmp #10
	blt +
	clc
	adc #7
+	adc #$30
	jsr chrout
	pla
	and #$f
	cmp #10
	blt +
	clc
	adc #7
+	adc #$30
	jsr chrout
	rts

