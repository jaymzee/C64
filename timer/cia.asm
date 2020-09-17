; commodore 64 CIA 1 and CIA 2 (MOS 6526)

cia1PrtA = $dc00	; data port A (keyboard columns, joystick port 2)
cia1PrtB = $dc01	; data port B (keyboard rows, joystick port 1)
cia1DirA = $dc02	; data direction port A
cia1DirB = $dc03	; data direction port B
cia1TAL  = $dc04	; timer A low byte
cia1TAH  = $dc05	; timer A high byte
cia1TBL  = $dc06	; timer B low byte
cia1TBH  = $dc07	; timer B high byte
cia1TODT = $dc08	; real time clock 1/10 seconds
cia1TODS = $dc09	; real time clock seconds
cia1TODM = $dc0a	; real time clock minutes
cia1TODH = $dc0b	; real time clock hours
cia1SDR  = $dc0c	; serial shift register
cia1ICR  = $dc0d	; interrupt control and status
cia1CRA  = $dc0e	; control timer A
cia1CRB  = $dc0f	; control timer B

cia2PrtA = $dd00	; data port A (VIC-II bank, RS-232 TXD, serial bus)
cia2PrtB = $dd01	; data port B (userport, RS-232)
cia2DirA = $dd02	; data direction port A
cia2DirB = $dd03	; data direction port B
cia2TAL  = $dd04	; timer A low byte
cia2TAH  = $dd05	; timer A high byte
cia2TBL  = $dd06	; timer B low byte
cia2TBH  = $dd07	; timer B high byte
cia2TODT = $dd08	; real time clock 1/10 seconds
cia2TODS = $dd09	; real time clock seconds
cia2TODM = $dd0a	; real time clock minutes
cia2TODH = $dd0b	; real time clock hours
cia2SDR  = $dd0c	; serial shift register
cia2ICR  = $dd0d	; interrupt control and status
cia2CRA  = $dd0e	; control timer A
cia2CRB  = $dd0f	; control timer B
