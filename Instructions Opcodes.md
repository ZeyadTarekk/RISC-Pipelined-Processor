## One Operand Instructions

| Instruction | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | IncOneOrTwo | privateRegWrite |
| :---------: | :---------: | :------: | :-----: | :------: | :------: | :----------: | :------: | :--------: | :--------: | :-----------: | :--------: | :-------: | :---------: | :-------------: |
|     NOP     |     00      |    0     |    0    |    0     |    0     |      0       |    0     |    xxx     |     x      |       x       |     0      |    00     |      0      |        0        |
|    SETC     |     00      |    0     |    0    |    0     |    0     |      1       |    0     |    000     |     x      |       x       |     0      |    11     |      0      |        0        |
|    CLRC     |     00      |    0     |    0    |    0     |    0     |      1       |    0     |    000     |     x      |       x       |     0      |    01     |      0      |        0        |
|  NOT Rdst   |     00      |    1     |    0    |    0     |    1     |      1       |    1     |    110     |     x      |       x       |     0      |    00     |      0      |        0        |
|  INC Rdst   |     00      |    1     |    0    |    0     |    1     |      1       |    1     |    000     |     x      |       x       |     0      |    00     |      0      |        0        |
|  DEC Rdst   |     00      |    1     |    0    |    0     |    1     |      1       |    1     |    001     |     x      |       x       |     0      |    00     |      0      |        0        |
|  OUT Rdst   |     00      |    1     |    0    |    0     |    1     |      0       |    1     |    000     |     x      |       x       |     0      |    xx     |      0      |        0        |
|   IN Rdst   |     00      |    1     |    0    |    0     |    1     |      0       |    1     |    000     |     x      |       x       |     0      |    xx     |      0      |        0        |

## Two Operand Instructions

| Instruction    | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | IncOneOrTwo | privateRegWrite |
| -------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | ----------- | --------------- |
| MOV Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 0            | 1        | 000        | x          | x             | 0          | xx        | 0           | 0               |
| ADD Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 000        | x          | x             | 0          | 00        | 0           | 0               |
| SUB Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 001        | x          | x             | 0          | 00        | 0           | 0               |
| AND Rsrc, Rdst | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 010        | x          | x             | 0          | 00        | 0           | 0               |
| OR Rsrc, Rdst  | 00          | 1        | 0       | 0        | 1        | 1            | 1        | 011        | x          | x             | 0          | 00        | 0           | 0               |
| SHL Rsrc, Imm  | 00          | 1        | 0       | 0        | 1        | 1            | 0        | 100        | x          | x             | 0          | 00        | 0           | 0               |
| SHR Rsrc, Imm  | 00          | 1        | 0       | 0        | 1        | 1            | 0        | 101        | x          | x             | 0          | 00        | 0           | 0               |

## Memory Instructions

| Instruction    | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | IncOneOrTwo | privateRegWrite |
| -------------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | ----------- | --------------- |
| Push Rdst      | 1           | Ya rb    | ``      | ``       | ``       | ``           | ``       | ``         | ``         | ``            | ``         | ``        | c           |                 |
| POP Rdst       | 1           | Ya rb    | ``      | ``       | ``       | ``           | ``       | ``         | ``         | ``            | ``         | ``        | 0           | 0               |
| LDM Rdst, Imm  | 0           | 1        | 0       | 0        | 1        | 0            | 0        | 111        | x          | x             | 0          | xx        | 0           | 0               |
| LDD Rsrc, Rdst | 0           | 1        | 1       | 0        | 0        | 0            | 0        | 000        | 1          | x             | 0          | xx        | 0           | 0               |
| STD Rsrc, Rdst | 0           | 0        | 0       | 1        | x        | 0            | 0        | 000        | 1          | x             | 0          | xx        | 0           | 0               |

## Branch Instructions

| Instruction | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | IncOneOrTwo | privateRegWrite |
| ----------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | ----------- | --------------- |
| JZ Rdst     | 0           | 0        | 0       | 0        | x        | 0            | 1        | xxx        | x          | 0             | 1          | xx        | 0           | 0               |
| JN Rdst     | 0           | 0        | 0       | 0        | x        | 0            | 1        | xxx        | x          | 0             | 1          | xx        | 0           | 0               |
| JC Rdst     | 0           | 0        | 0       | 0        | x        | 0            | 1        | xxx        | x          | 0             | 1          | xx        | 0           | 0               |
| JMP Rdst    | 0           | 0        | 0       | 0        | x        | 0            | 1        | xxx        | x          | 0             | 1          | xx        | 0           | 0               |
| CALL Rdst   | ``          | ``       | ``      | ``       | ``       | ``           | ``       | ``         | ``         | ``            | ``         | ``        | 0           | 0               |
| RET         | ``          | ``       | ``      | ``       | ``       | ``           | ``       | ``         | ``         | ``            | ``         | ``        | 0           | 0               |
| RTI         | ``          | ``       | ``      | ``       | ``       | ``           | ``       | ``         | ``         | ``            | ``         | ``        | 0           | 0               |

## Input Signals

| Instruction | SPOperation | RegWrite | MemRead | MemWrite | MemOrReg | UpdateStatus | ImmOrReg | ALUControl | SPOrALUres | DestOrPrivate | BranchFlag | CarryFlag | IncOneOrTwo | privateRegWrite |
| ----------- | ----------- | -------- | ------- | -------- | -------- | ------------ | -------- | ---------- | ---------- | ------------- | ---------- | --------- | ----------- | --------------- |
| Reset       | `<br/>`     | `<br/>`  | `<br/>` | `<br/>`  | `<br/>`  | `<br/>`      | `<br/>`  | `<br/>`    | `<br/>`    | `<br/>`       | `<br/>`    | `<br/>`   | 0           | 0               |
| Interrupt   | `<br/>`     | `<br/>`  | `<br/>` | `<br/>`  | `<br/>`  | `<br/>`      | `<br/>`  | `<br/>`    | `<br/>`    | `<br/>`       | `<br/>`    | `<br/>`   | 0           | 0               |
