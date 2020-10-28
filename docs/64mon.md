# 64MON cartridge
64MON is a machine code monitor cartridge for the C64

to start the machine code monitor press **RUN/STOP + RESTORE** or enter

    SYS 32820

When using 64MON, the warm reset vector behaves similar to the warm reset
that **RUN/STOP + RESTORE** keypress normally does without 64MON inserted

### assemble
    .A 1000 LDA #$48
    .A 1002 RTS

### disassemble
    .D 1000 1002

### display memory
    .M 1000 1004

### run program
    .G 1000

### exit back to basic
    .X

