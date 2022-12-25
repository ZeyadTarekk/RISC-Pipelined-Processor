<div align="center"> <h1>Computer Architecture</h1> </div>

## Team Members

| Name           | Section | BN  |
| -------------- | ------- | --- |
| Beshoy Morad   | 1       | 20  |
| Ziad Sherif    | 1       | 27  |
| Zeyad Tarek    | 1       | 28  |
| Youssef Khaled | 2       | 38  |

## Control Unit Signals

### One Operand Instructions

| Instruction | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite |
| :---------: | :---------: | :------: | :-----: | :------: | :------: | :----------: | :------: | :--------: | :--------: | :-----------: | :--------: | :-------: | :-------: | :-------------: |
|     NOP     |     00      |    0     |    0    |    0     |    0     |      0       |    0     |    xxxx    |     x      |       x       |     0      |    xx     |     0     |        0        |
|    SETC     |     00      |    0     |    0    |    0     |    0     |      1       |    0     |    xxxx    |     x      |       x       |     0      |    11     |     0     |        0        |
|    CLRC     |     00      |    0     |    0    |    0     |    0     |      1       |    0     |    xxxx    |     x      |       x       |     0      |    01     |     0     |        0        |
|  NOT Rdst   |     00      |    1     |    0    |    0     |    1     |      1       |    1     |    0110    |     x      |       x       |     0      |    00     |     0     |        0        |
|  INC Rdst   |     00      |    1     |    0    |    0     |    1     |      1       |    1     |    1000    |     x      |       x       |     0      |    00     |     0     |        0        |
|  DEC Rdst   |     00      |    1     |    0    |    0     |    1     |      1       |    1     |    1001    |     x      |       x       |     0      |    00     |     0     |        0        |
|  OUT Rdst   |     00      |    1     |    0    |    0     |    1     |      0       |    1     |    1010    |     x      |       x       |     0      |    xx     |     0     |        0        |
|   IN Rdst   |     00      |    1     |    0    |    0     |    1     |      0       |    1     |    1010    |     x      |       x       |     0      |    xx     |     0     |        0        |

### Two Operand Instructions

| Instruction    | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite |
| -------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | --------- | --------------- |
| MOV Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 0            | 1        | 1010       | x          | x             | 0          | xx        | 0         | 0               |
| ADD Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 0000       | x          | x             | 0          | 00        | 0         | 0               |
| SUB Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 0001       | x          | x             | 0          | 00        | 0         | 0               |
| AND Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 0010       | x          | x             | 0          | 00        | 0         | 0               |
| OR Rsrc, Rdst  | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 0011       | x          | x             | 0          | 00        | 0         | 0               |
| SHL Rsrc, Imm  | 00          | 1        | 0       | 0        | 1        | 1            | 0        | 0100       | x          | x             | 0          | 00        | 0         | 0               |
| SHR Rsrc, Imm  | 00          | 1        | 0       | 0        | 1        | 1            | 0        | 0101       | x          | x             | 0          | 00        | 0         | 0               |

### Memory Instructions

| Instruction    | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite |
| -------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | --------- | --------------- |
| Push Rdst      | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 0         | 0               |
| POP Rdst       | 10          | 1        | 1       | 0        | 0        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 0         | 0               |
| LDM Rdst, Imm  | 00          | 1        | 0       | 0        | 1        | 0            | 0        | 0111       | x          | x             | 0          | xx        | 0         | 0               |
| LDD Rsrc, Rdst | 00          | 1        | 1       | 0        | 0        | 0            | x        | 1010       | 1          | x             | 0          | xx        | 0         | 0               |
| STD Rsrc, Rdst | 00          | 0        | 0       | 1        | x        | 0            | 1        | 0111       | 1          | x             | 0          | xx        | 0         | 0               |

### Branch Instructions

| Instruction   | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite | function |
| ------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | --------- | --------------- | -------- |
| JZ Rdst       | 00          | 0        | 0       | 0        | x        | 0            | x        | xxxx       | x          | 0             | 1          | xx        | 0         | 0               | 00       |
| JN Rdst       | 00          | 0        | 0       | 0        | x        | 0            | x        | xxxx       | x          | 0             | 1          | xx        | 0         | 0               | 01       |
| JC Rdst       | 00          | 0        | 0       | 0        | x        | 0            | x        | xxxx       | x          | 0             | 1          | xx        | 0         | 0               | 10       |
| JMP Rdst      | 00          | 0        | 0       | 0        | x        | 0            | x        | xxxx       | x          | 0             | 1          | xx        | 0         | 0               | 11       |
| [1] CALL Rdst | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 0         | 1               | xx       |
| [2] CALL Rdst | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | 0             | 1          | xx        | 0         | 0               | 11       |
| [1] RET       | 10          | 1        | 1       | 0        | 0        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 0         | 0               | xx       |
| [2] RET       | 10          | 1        | 1       | 0        | 0        | 0            | x        | xxxx       | 0          | 1             | 1          | xx        | 0         | 0               | 11       |
| [1] RTI       | 10          | 1        | 1       | 0        | 0        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 0         | 0               | xx       |
| [2] RTI       | 10          | 1        | 1       | 0        | 0        | 1            | x        | xxxx       | 0          | 1             | 1          | 10        | 0         | 0               | 11       |

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

### Input Signals

| Instruction   | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | PCControl | privateRegWrite | function | interrupt | reset |
| ------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | --------- | --------------- | -------- | --------- | ----- |
| Reset         | 00          | 0        | 0       | 0        | 0        | 0            | 0        | xxxx       | x          | x             | 0          | xx        | 0         | 0               | xx       | 0         | 1     |
| [1] Interrupt | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 0         | 1               | xx       | 1         | 0     |
| [2] Interrupt | 01          | 0        | 0       | 1        | x        | 0            | x        | xxxx       | 0          | x             | 0          | xx        | 0         | 0               | xx       | 0         | 0     |

### Notes

- [1] Interrupt will be the first 16-bits of the instruction and [2] Interrupt will be the second part of the instruction
  [1] Interrupt: will save the PC[15:0] to SP[0]
  [2] Interrupt: will save the PC[31:16] to SP[1] and branch to the new PC = [0]
- Interrupt will pass through the IF/ID buffer to save it as we will use it in the next cycle to update the PC = 0
- Assume that IF/ID can read the interrupt signal everytime and won't miss it.
  Then at rising edge execute the first part of the instruction, and at the falling edge execute the second part of the instruction
- 32-bits detector will hold the opcode of the interrupt instructions and will force them to the IF/ID buffer when its ready to start (highlited in the state machine diagram of the interrupt)

### Custom signals

| OpCode | SP Operations |
| ------ | ------------- |
| 00     | Do nothing    |
| 01     | PUSH          |
| 10     | POP           |

| OpCode | Carry Flag      |
| ------ | --------------- |
| 00     | Update status   |
| 01     | Clear carry     |
| 10     | Get from stored |
| 11     | Set carry       |

| OpCode | PC Control    |
| ------ | ------------- |
| 0      | Increment one |
| 1      | Same PC       |

| OpCode | ALU Operation |
| ------ | ------------- |
| 0000   | ADD           |
| 0001   | SUB           |
| 0010   | AND           |
| 0011   | OR            |
| 0100   | SHL           |
| 0101   | SHR           |
| 0110   | NOT           |
| 0111   | PASS Second   |
| 1000   | INC           |
| 1001   | DEC           |
| 1010   | PASS First    |
| 1111   | Do Nothing    |

## Instructions bits details

| Instruction Piece | No. of bits |
| ----------------- | ----------- |
| OpCode            | 5           |
| Rsrc              | 4           |
| Rdst              | 4           |
| function          | 3           |

| OpCode | Function Code |
| ------ | ------------- |
| 000    | Zero flag     |
| 001    | Negative flag |
| 010    | Carry Flag    |
| 011    | Always one    |

## Registers

| Reg       | Address |
| --------- | ------- |
| R0        | 0000    |
| R1        | 0001    |
| R2        | 0010    |
| R3        | 0011    |
| R4        | 0100    |
| R5        | 0101    |
| R6        | 0110    |
| R7        | 0111    |
| PORT      | 1000    |
| PCholder0 | 1001    |
| PCholder1 | 1010    |

## Instruction Memory Format

| Instruction              | OpCode | Format                          | Immediate 16-bit |
| ------------------------ | ------ | ------------------------------- | ---------------- |
| NOP                      | 00000  | OP\| 0000 \| 0000 \| 000        |                  |
| SETC                     | 00001  | OP\| 0000 \| 0000 \| 000        |                  |
| CLRC                     | 00010  | OP\| 0000 \| 0000 \| 000        |                  |
| NOT Rdst                 | 00011  | OP\| Rdst \| Rdst \| 000        |                  |
| INC Rdst                 | 00100  | OP\| Rdst \| Rdst \| 000        |                  |
| DEC Rdst                 | 00101  | OP\| Rdst \| Rdst \| 000        |                  |
| OUT Rdst                 | 00110  | OP\| Rdst \| PORTAddress \| 000 |                  |
| IN Rdst                  | 00111  | OP\| PORTAddress \| Rdst \| 000 |                  |
| MOV Rsrc, Rdst           | 01000  | OP\| Rsrc \| Rdst \| 000        |                  |
| ADD Rsrc, Rdst           | 01001  | OP\| Rsrc \| Rdst \| 000        |                  |
| SUB Rsrc, Rdst           | 01010  | OP\| Rsrc \| Rdst \| 000        |                  |
| AND Rsrc, Rdst           | 01011  | OP\| Rsrc \| Rdst \| 000        |                  |
| OR Rsrc, Rdst            | 01100  | OP\| Rsrc \| Rdst \| 000        |                  |
| SHL Rsrc, Imm            | 01101  | OP\| Rsrc \| Rsrc \| 100        | Imm              |
| SHR Rsrc, Imm            | 01110  | OP\| Rsrc \| Rsrc \| 100        | Imm              |
| PUSH Rdst                | 01111  | OP\| Rdst \| 0000 \| 000        |                  |
| POP Rdst                 | 10000  | OP\| 0000 \| Rdst \| 000        |                  |
| LDM Rdst, Imm            | 10001  | OP\| 0000 \| Rdst \| 100        | Imm              |
| LDD Rsrc, Rdst           | 10010  | OP\| Rsrc \| Rdst \| 000        |                  |
| STD Rsrc, Rdst           | 10011  | OP\| Rsrc \| Rdst \| 000        |                  |
| JZ Rdst                  | 10100  | OP\| 0000 \| Rdst \| 000        |                  |
| JN Rdst                  | 10101  | OP\| 0000 \| Rdst \| 001        |                  |
| JC Rdst                  | 10110  | OP\| 0000 \| Rdst \| 010        |                  |
| JMP Rdst                 | 10111  | OP\| 0000 \| Rdst \| 011        |                  |
| CALL Rdst                | 11000  | OP\| PCholder0 \| Rdst \| 000   |                  |
| Second part of CALL      | 11001  | OP\| PCholder1 \| Rdst \| 011   |                  |
| RET                      | 11010  | OP\| 0000 \| PCholder1 \| 000   |                  |
| Second part of RET       | 11011  | OP\| 0000 \| PCholder0 \| 011   |                  |
| RTI                      | 11100  | OP\| 0000 \| PCholder1 \| 000   |                  |
| Second part of RTI       | 11101  | OP\| 0000 \| PCholder0 \| 011   |                  |
| First part of interrupt  | 11110  | OP\| PCholder0 \| 0000 \| 000   |                  |
| Second part of interrupt | 11111  | OP\| PCholder1 \| 0000 \| 000   |                  |

## Types of hazards and our solution to solve it

- Structural hazards : solved with using 2 diffrent types of memory (data memory and instruction memory)
- Data hazards : Full forwarding unit which check for src & dis of second instruction (in decoding stage) and the dist of first instruction (in ALU stage or in Memory stage).
  - Load-use case : Hazard detector which check the type of first instruction (in ALU stage) and its dist with the src & dist of second instruction (in decoding stage) to stall cycle.
- Control hazards : Do the jump itself in decoding stages and flush the instruction which entered the IF/ID buffer if the jump will be done with static pridiction of not taken.

## Solving 32-bit instrunction problem

- check passRegister bits if it 1 i will put the 16-bit instruction in imm else will be in instruction
- at decoding if i found iam 32-bit instruction i will flush my self as (bubble) then make register (passRegister) to be one then at next cycle will come with the whole 32-bit instruction and will check the passRegister nad make it zero again

## Forwarding unit

- ALUSrcChoce =>
  - 00 - if alusrc != memsrc & alusrc != wBsrc
  - 01 - if alusrc != memsrc & alusrc == wBsrc
  - 10 - if alusrc == memsrc
  - SrcChange = ALURegsrc == AlUMEMres ? 10 : ( ALURegsrc == MEMWBres ? 01 : 00 );
- ALUDestChoce =>
  - 00 - if aludest != memsrc & aludest != wBsrc
  - 01 - if aludest != memsrc & aludest == wBsrc
  - 10 - if aludest == memsrc
  - DestChange = ALURegdest == AlUMEMres ? 10 : ( ALURegdest == MEMWBres ? 01 : 00 );

## HazardDetection Unit

- we should insert bubble before our self as MakeMeBubble then execute the instrution itself in next cycle
- if MemRead of next instruction is read from memory and the current src or the dest is the register will load on it
- MakeMeBubble = MemRead && (ALUDest == DecodeSrc || ALUDest == DecodeDest);




## Solving the Forwarding Unit problem 
- we need wire walk the instruction ot tell us if its Bubble From IRDetector then oring with (Flush in IFIDbuffer) oring with (makeMEBubble in IDEXBuffer)
- check inforwarding unit if the signali check for is bubble or not


## iamTwoInstruction
- this signal is used to detcet operations with 2 instructions used for solving the case of 
- LDM 
- CALL
- which case the second part of the instruciotn to forwarding the imm value of the imm althoght he aleread read it correctly  



## Full testCase 
- Data Hazard
- Control Hazard
- Load Use Case