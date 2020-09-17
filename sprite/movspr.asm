; assemble with dasm

	processor 6502

sp0xpos = $d000
sp0ypos = $d001
sp0ptr	= $07f8
sp0col	= $d027

; entry point
	org $1000
main	lda #$80
	sta sp0ptr	; sprite 0 pointer = $2000
	lda #$03
	sta sp0col	; sprite 0 color = cyan
	lda #$01
	sta $d015	; turn on sprite 0
	sta $d017	; expand sprite 0 in X
	sta $d01d	; expand sprite 0 in Y
	lda #$00
	tax
	tay
.loop	stx sp0xpos
	stx sp0xpos
	stx sp0xpos
	stx sp0xpos
	stx sp0ypos
	iny
	bne .loop
	inx
	bne .loop
	rts
