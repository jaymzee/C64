; print numeric values as decimal, octal and hexadecimal

; contants
chrout	= $ffd2

; entry
*	= $1000
main:
	lda #$37
	jsr print_hex	; print reg A as hex
	lda #13
	jsr chrout	; print newline
	lda #$ab
	jsr print_hex	; print reg A as hex
	rts

; print a single digit decimal number (0 thru 9)
print_dec:
	clc
	adc #$30	; convert to ASCII
	jsr chrout	; print digit
	rts

; print byte as 3 digit octal number
print_oct:
	pha		; save a copy of A for later
	.rept 6		; select bits 7 and 6
	lsr
	.next
	ora #$30	; convert to ASCII
	jsr chrout	; print bits 7 and 6
	pla		; restore A
	pha
	lsr
	lsr		; select bits 5, 4, and 3
	lsr
	and #7
	ora #$30	; convert to ASCII
	jsr chrout	; print bits 5, 4 and 3
	pla		; restore A
	and #7		; select bits 2, 1, and 0
	ora #$30	; convert to ASCII
	jsr chrout	; print bits 2, 1, and 0
	rts

print_hex:
	pha		; save a copy of A for later
	.rept 4
	lsr		; select upper nibble
	.next
	cmp #10		; if A < 10
	blt +		;   A += 0x30 (convert to ASCII 0 thru 9)
	clc		; else
	adc #7		;   A += 0x37 (convert to ASCII A thru F)
+	adc #$30
	jsr chrout	; print upper nibble
	pla		; restore original A
	and #$f		; select lower nibble
	cmp #10		; if A < 10
	blt +		;   A += 0x30 (convert to ASCII 0 thru 9)
	clc		; else
	adc #7		;   A += 0x37 (convert to ASCII A thru F)
+	adc #$30	
	jsr chrout	; print lower nibble
	rts

