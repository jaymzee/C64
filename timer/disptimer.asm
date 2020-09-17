; use CIA 1 timers A and B to trigger interrupt
; asssemble with
;   64tass

	.include "cia.asm"

; constants
kernISR = $ea31	; kernal's default IRQ routine
vecIRQL = $0314	; vector to low byte of IRQ routine
vecIRQH = $0315	; vector to high byte of IRQ routine
vecBRKL = $0316	; vector to low byte of BRK routine
vecBRKH = $0317	; vector to high byte of BRK routine
scrRAM  = $0400	; start of screen RAM
colRAM  = $d800	; start of color RAM

; entry point
*	= $0810
start:
	sei		; disable interrupts

	; configure Timer A
	lda #$e8
	sta cia1TAL	; timer A low byte
	lda #$03
	sta cia1TAH	; timer A high byte
	lda #%00010001	; count system cycle, load latch, uf restart, start
	sta cia1CRA	; timer A control reg

	; configure Timer B
	lda #$e8
	sta cia1TBL	; timer B low byte
	lda #$03
	sta cia1TBH	; timer B high byte
	lda #%01010001	; count uf of timer A, load latch, uf restart, start
	sta cia1CRB	; timer B control reg

	; setup and enable interrupts
	lda #<timerISR
	sta vecIRQL	; interrupt vector low byte
	lda #>timerISR
	sta vecIRQH	; interrupt vector high byte

	lda #%01111111	; clear INT MASK
	sta cia1ICR	; interrupt control and status register
	lda #%10000010	; set INT MASK for timer B underflow
	sta cia1ICR	; interrupt control and status register

	cli		; enable interrupts

main:	; display actual timer values on screen
	ldx #0		; X index for which timer register displayed
-	lda #1		; color = white
	sta colRAM + 0,x; set character color for first 4 chars in first row
	lda cia1TAL,x	; read timer A-low or A-high or B-low or B-high
	sta scrRAM + 0,x; display timer bytes as char on screen in first row
	inx		; next timer byte, next char position
	cpx #4		; if less than 4
	bne -		;   repeat for next timer byte
	beq main	; else repeat timer display forever

timerISR:
	lda #1		; color = white
	sta colRAM + 5	; set character color
	inc scrRAM + 5	; indicate interrupt serviced by incrementing char
	lda cia1ICR	; acknowledge CIA 1 IRQ
	jmp kernISR	; kernal's default IRQ routine
