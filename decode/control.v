module controlUnit(clk,opCode,SPOperation,RegWrite,MemRead,MemWrite,MemOrReg,UpdateStatus,ImmOrReg,ALUControl,SPOrALUres,DestOrPrivate,BranchFlag,CarryFlag,PCControl,privateRegWrite,fct,interrupt,reset);
input clk;
input[4:0] opCode;
output [3:0] ALUControl
output [1:0] SPOperation,CarryFlag,fct
output RegWrite,MemRead,MemWrite,MemOrReg,UpdateStatus,ImmOrReg,SPOrALUres,DestOrPrivate,BranchFlag,PCControl,privateRegWrite,interrupt,reset

always @(posedge clk) begin

  SPOperation=2'bxx;
  RegWrite=1'bx;
  MemRead=1'bx;
  MemWrite=1'bx;
  MemOrReg=1'bx;
  UpdateStatus=1'bx;
  ImmOrReg=1'bx;
  ALUControl=4'bxxxx;
  SPOrALUres=1'bx;
  DestOrPrivate=1'bx;
  BranchFlag=1'bx;
  CarryFlag=2'bxx;
  PCControl=1'bx;
  privateRegWrite=1'bx;
  fct=2'bxx;
  interrupt=1'bx;
  reset=1'bx;
  if(opCode == 4'b00000) begin
    // NOP
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b0;
  ImmOrReg=1'b0;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'b00001) begin
    // SETC
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b1;
  ImmOrReg=1'b0;
  BranchFlag=1'b0;
  CarryFlag=2'b11;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'00010) begin
    // CLRC
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b1;
  ImmOrReg=1'b0;
  BranchFlag=1'b0;
  CarryFlag=2'b01;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'00011) begin
    // NOT Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b1;
  ImmOrReg=1'b1;
  ALUControl=4'b0110;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'00100) begin
    // INC Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b1;
  ImmOrReg=1'b1;
  ALUControl=4'b1000;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'00101) begin
    // DEC Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b1;
  ImmOrReg=1'b1;
  ALUControl=4'b1001;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'00110) begin
    // OUT Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b0;
  ImmOrReg=1'b1;
  ALUControl=4'b1010;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'00111) begin
    // IN Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b0;
  ImmOrReg=1'b1;
  ALUControl=4'b1010;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'01000) begin
    // MOV Rsrc, Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b0;
  ImmOrReg=1'b1;
  ALUControl=4'b1010;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'01001) begin
    // ADD Rsrc, Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b1;
  ImmOrReg=1'b1;
  ALUControl=4'b0000;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'01010) begin
    // SUB Rsrc, Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b1;
  ImmOrReg=1'b1;
  ALUControl=4'b0001;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'01011) begin
    // AND Rsrc, Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b1;
  ImmOrReg=1'b1;
  ALUControl=4'b0010;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'01100) begin
    // OR Rsrc, Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b1;
  ImmOrReg=1'b1;
  ALUControl=4'b0011;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'01101) begin
    // SHL Rsrc, Imm
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b1;
  ImmOrReg=1'b0;
  ALUControl=4'b0100;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'01110) begin
    // SHR Rsrc, Imm
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b1;
  ImmOrReg=1'b0;
  ALUControl=4'b0101;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'01111) begin
    // PUSH Rdst
  SPOperation=2'b01;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b1;
  UpdateStatus=1'b0;
  SPOrALUres=1'b0;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'10000) begin
    // POP Rdst
  SPOperation=2'b10;
  RegWrite=1'b1;
  MemRead=1'b1;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b0;
  SPOrALUres=1'b0;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'10001) begin
    // LDM Rdst, Imm
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b1;
  UpdateStatus=1'b0;
  ImmOrReg=1'b0;
  ALUControl=4'b0111;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'10010) begin
    // LDD Rsrc, Rdst
  SPOperation=2'b00;
  RegWrite=1'b1;
  MemRead=1'b1;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b0;
  ALUControl=4'b1010;
  SPOrALUres=1'b1;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'10011) begin
    // STD Rsrc, Rdst
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b1;
  UpdateStatus=1'b0;
  ImmOrReg=1'b1;
  ALUControl=4'b0111;
  SPOrALUres=1'b1;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'10100) begin
    // JZ Rdst
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  UpdateStatus=1'b0;
  DestOrPrivate=1'b0;
  BranchFlag=1'b1;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  fct=2'b00;
  end
  else if(opCode == 4'10101) begin
    // JN Rdst
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  UpdateStatus=1'b0;
  DestOrPrivate=1'b0;
  BranchFlag=1'b1;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  fct=2'b01;
  end
  else if(opCode == 4'10110) begin
    // JC Rdst
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  UpdateStatus=1'b0;
  DestOrPrivate=1'b0;
  BranchFlag=1'b1;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  fct=2'b10;
  end
  else if(opCode == 4'10111) begin
    // JMP Rdst
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  UpdateStatus=1'b0;
  DestOrPrivate=1'b0;
  BranchFlag=1'b1;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  fct=2'b11;
  end
  else if(opCode == 4'11000) begin
    // CALL Rdst
  SPOperation=2'b01;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b1;
  UpdateStatus=1'b0;
  SPOrALUres=1'b0;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b1;
  end
  else if(opCode == 4'11001) begin
    // Second part of CALL
  SPOperation=2'b01;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b1;
  UpdateStatus=1'b0;
  SPOrALUres=1'b0;
  DestOrPrivate=1'b0;
  BranchFlag=1'b1;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  fct=2'b11;
  end
  else if(opCode == 4'11010) begin
    // RET
  SPOperation=2'b10;
  RegWrite=1'b1;
  MemRead=1'b1;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b0;
  SPOrALUres=1'b0;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'11011) begin
    // Second part of RET
  SPOperation=2'b10;
  RegWrite=1'b1;
  MemRead=1'b1;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b0;
  SPOrALUres=1'b0;
  DestOrPrivate=1'b1;
  BranchFlag=1'b1;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  fct=2'b11;
  end
  else if(opCode == 4'11100) begin
    // RTI
  SPOperation=2'b10;
  RegWrite=1'b1;
  MemRead=1'b1;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b0;
  SPOrALUres=1'b0;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 4'11101) begin
    // Second part of RTI
  SPOperation=2'b10;
  RegWrite=1'b1;
  MemRead=1'b1;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b1;
  SPOrALUres=1'b0;
  DestOrPrivate=1'b1;
  BranchFlag=1'b1;
  CarryFlag=2'b10;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  fct=2'b11;
  end
  else if(opCode == 4'11110) begin
    // First part of interrupt
  SPOperation=2'b01;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b1;
  UpdateStatus=1'b0;
  SPOrALUres=1'b0;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b1;
  interrupt=1'b1;
  reset=1'b0;
  end
  else if(opCode == 4'11111) begin
    // Second part of interrupt
  SPOperation=2'b01;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b1;
  UpdateStatus=1'b0;
  SPOrALUres=1'b0;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  interrupt=1'b0;
  reset=1'b0;
  end
end

endmodule