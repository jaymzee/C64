; print HELLO WORLD using kernal I/O
; assemble with dasm

	processor 6502

; constants
chrout	= $ffd2

; entry point
	org $1000
main	subroutine
	ldx #0
.loop	lda msg,x
	jsr chrout
	inx
	cpx #msglen
	bne .loop
	rts

; data
msg	.byte "HELLO WORLD"
msglen  = * - msg
