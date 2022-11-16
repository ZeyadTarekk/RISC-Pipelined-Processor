## One Operand Instructions

| Instruction | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite |
| :---------: | :---------: | :------: | :-----: | :------: | :------: | :----------: | :------: | :--------: | :--------: | :-----------: | :--------: | :-------: | :-------: | :-------------: |
|     NOP     |     00     |    0    |    0    |    0    |    0    |      0      |    0    |    xxxx    |     x     |       x       |     0     |    xx    |    00    |        0        |
|    SETC    |     00     |    0    |    0    |    0    |    0    |      1      |    0    |    xxxx    |     x     |       x       |     0     |    11    |    00    |        0        |
|    CLRC    |     00     |    0    |    0    |    0    |    0    |      1      |    0    |    xxxx    |     x     |       x       |     0     |    01    |    00    |        0        |
|  NOT Rdst  |     00     |    1    |    0    |    0    |    1    |      1      |    1    |    0110    |     x     |       x       |     0     |    00    |    00    |        0        |
|  INC Rdst  |     00     |    1    |    0    |    0    |    1    |      1      |    1    |    1000    |     x     |       x       |     0     |    00    |    00    |        0        |
|  DEC Rdst  |     00     |    1    |    0    |    0    |    1    |      1      |    1    |    1001    |     x     |       x       |     0     |    00    |    00    |        0        |
|  OUT Rdst  |     00     |    1    |    0    |    0    |    1    |      0      |    1    |    1010    |     x     |       x       |     0     |    xx    |    00    |        0        |
|   IN Rdst   |     00     |    1    |    0    |    0    |    1    |      0      |    1    |    1010    |     x     |       x       |     0     |    xx    |    00    |        0        |

## Two Operand Instructions

| Instruction    | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite |
| -------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | --------- | --------------- |
| MOV Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 0            | 1        | 1010       | x          | x             | 0          | xx        | 00        | 0               |
| ADD Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 0000       | x          | x             | 0          | 00        | 00        | 0               |
| SUB Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 0001       | x          | x             | 0          | 00        | 00        | 0               |
| AND Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 0010       | x          | x             | 0          | 00        | 00        | 0               |
| OR Rsrc, Rdst  | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 0011       | x          | x             | 0          | 00        | 00        | 0               |
| SHL Rsrc, Imm  | 00          | 1        | 0       | 0        | 1        | 1            | 0        | 0100       | x          | x             | 0          | 00        | 11        | 0               |
| SHR Rsrc, Imm  | 00          | 1        | 0       | 0        | 1        | 1            | 0        | 0101       | x          | x             | 0          | 00        | 11        | 0               |

## Memory Instructions

| Instruction    | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite |
| -------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | --------- | --------------- |
| Push Rdst      | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 00        | 0               |
| POP Rdst       | 10          | 1        | 1       | 0        | 0        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 00        | 0               |
| LDM Rdst, Imm  | 00          | 1        | 0       | 0        | 1        | 0            | 0        | 0111       | x          | x             | 0          | xx        | 11        | 0               |
| LDD Rsrc, Rdst | 00          | 1        | 1       | 0        | 0        | 0            | x        | 1010       | 1          | x             | 0          | xx        | 00        | 0               |
| STD Rsrc, Rdst | 00          | 0        | 0       | 1        | x        | 0            | 1        | 0111       | 1          | x             | 0          | xx        | 00        | 0               |

## Branch Instructions

| Instruction   | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite | function |
| ------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | --------- | --------------- | -------- |
| JZ Rdst       | 00          | 0        | 0       | 0        | x        | 0            | x        | xxxx       | x          | 0             | 1          | xx        | 00        | 0               | 00       |
| JN Rdst       | 00          | 0        | 0       | 0        | x        | 0            | x        | xxxx       | x          | 0             | 1          | xx        | 00        | 0               | 01       |
| JC Rdst       | 00          | 0        | 0       | 0        | x        | 0            | x        | xxxx       | x          | 0             | 1          | xx        | 00        | 0               | 10       |
| JMP Rdst      | 00          | 0        | 0       | 0        | x        | 0            | x        | xxxx       | x          | 0             | 1          | xx        | 00        | 0               | 11       |
| [1] CALL Rdst | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 00        | 1               | xx       |
| [2] CALL Rdst | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | 0             | 1          | xx        | 00        | 0               | 11       |
| [1] RET       | 10          | 1        | 1       | 0        | 0        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 00        | 0               | xx       |
| [2] RET       | 10          | 1        | 1       | 0        | 0        | 0            | x        | xxxx       | 0          | 1             | 1          | xx        | 00        | 0               | 11       |
| [1] RTI       | 10          | 1        | 1       | 0        | 0        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 00        | 0               | xx       |
| [2] RTI       | 10          | 1        | 1       | 0        | 0        | 1            | x        | xxxx       | 0          | 1             | 1          | 10        | 00        | 0               | 11       |

### Notes

- In case of any jump instrutions [JZ, JN, JC, JMP, CALL, RET, RTI] the instruction will be 32-bits
  first 16-bits will be the main jump instruction
  second 16-bits will be the second part of call or ret instructions
- [1] CALL Rdst will be the first 16-bits of the instruction and [2] CALL Rdst will be the second part of the instruction
  [1] CALL Rdst: will save the PC[15:0] to SP[0]
  [2] CALL Rdst: will save the PC[31:16] to SP[1] and branch to the new PC = [0 : Rdst]
- [1] RET will be the first 16-bits of the instruction and [2] RET will be the second part of the instruction
  [1] RET: will return the PC[31:16] from SP[1]
  [2] RET: will return the PC[15:0] from SP[0] and branch to the new PC = [private register]
- [1] RTI will be the first 16-bits of the instruction and [2] RTI will be the second part of the instruction
  [1] RTI: will return the PC[31:16] from SP[1]
  [2] RTI: will return the PC[15:0] from SP[0] and branch to the new PC = [private register]

## Input Signals

| Instruction   | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite | function | interrupt | reset |
| ------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | --------- | --------------- | -------- | --------- | ----- |
| Reset         | 00          | 0        | 0       | 0        | 0        | 0            | 0        | xxxx       | x          | x             | 0          | xx        | 00        | 0               | xx       | 0         | 1     |
| [1] Interrupt | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 01        | 1               | xx       | 1         | 0     |
| [2] Interrupt | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 00        | 0               | xx       | 0         | 0     |

### Notes

- [1] Interrupt will be the first 16-bits of the instruction and [2] Interrupt will be the second part of the instruction
  [1] Interrupt: will save the PC[15:0] to SP[0]
  [2] Interrupt: will save the PC[31:16] to SP[1] and branch to the new PC = [0]
- Interrupt will pass through the IF/ID buffer to save it as we will use it in the next cycle to update the PC = 0
- Assume that IF/ID can read the interrupt signal everytime and won't miss it.
  Then at rising edge execute the first part of the instruction, and at the falling edge execute the second part of the instruction
