; print Hello World! using kernal I/O
; asssemble with ascii source enabled (convert strings to petascii)
;   64tass -a
; execution
;   switch to mixed case by pressing C= and shift

; constants
chrout	= $ffd2

; entry point
*	= $1000
main	ldx #00
-	lda msg,x
	jsr chrout
	inx
	cpx #msglen
	bne -
	rts
msg	.text "Hello World!"
msglen	= * - msg
