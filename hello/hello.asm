; clear screen and print hello world using C64 screen functions
; assemble with dasm

	processor 6502

; constants
clrscr	= $e544
dispchr = $e716

; entry point
	org $1000
	jsr clrscr	;clear the screen

	lda #"H"
	jsr dispchr	;display H from A to screen

	lda #"E"
	jsr dispchr	;display 'E'

	lda #"L"
	jsr dispchr	;display 'L'
	jsr dispchr	;display 'L'

	lda #"O"
	jsr dispchr	;display O

	lda #$20
	jsr dispchr	;display space

	lda #"W"
	jsr dispchr	;display 'W'

	lda #"O"
	jsr dispchr	;display 'O'

	lda #"R"
	jsr dispchr	;display 'R'

	lda #"L"
	jsr dispchr	;display 'L'

	lda #"D"
	jsr dispchr	;display 'D'

	rts		;return from subroutine
