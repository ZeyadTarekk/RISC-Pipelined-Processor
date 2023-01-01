module controlUnit(
	opCode, makeMeBubble, SPOperation, RegWrite, 
	MemRead, MemWrite, MemOrReg, UpdateStatus,
	ImmOrReg, ALUControl, SPOrALUres, DestOrPrivate,
	BranchFlag, CarryFlag, PCControl, privateRegWrite,
	iamTwoInstruction, iamNop, iamJMP, pushFlags);
input[4:0] opCode;
input makeMeBubble;
output reg [3:0] ALUControl;
output reg [1:0] SPOperation,CarryFlag;
output reg RegWrite,MemRead,MemWrite,MemOrReg,UpdateStatus,ImmOrReg,SPOrALUres,DestOrPrivate,BranchFlag,PCControl,privateRegWrite,iamTwoInstruction,iamNop, iamJMP, pushFlags;


  always @(*) begin
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b0;
  ImmOrReg=1'b1;
  ALUControl=4'b1111;
  SPOrALUres=1'b0;
  DestOrPrivate=1'b0;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  iamTwoInstruction=1'b0;
  iamJMP = 1'b0;
  pushFlags = 1'b0;
  iamNop = !(|opCode);
  if(makeMeBubble == 1'b1) begin
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b0;
  ImmOrReg=1'b0;
  ALUControl=4'b1111;
  SPOrALUres=1'b0;
  DestOrPrivate=1'b0;
  BranchFlag=1'b0;
  CarryFlag=2'b00;
  PCControl=1'b1;
  end
  else if(opCode == 5'b00000) begin
    // NOP
  SPOperation=2'b00;
  RegWrite=1'b0;
  MemRead=1'b0;
  MemWrite=1'b0;
  MemOrReg=1'b0;
  UpdateStatus=1'b0;
  ALUControl=4'b0111;
  ImmOrReg=1'b0;
  BranchFlag=1'b0;
  PCControl=1'b0;
  privateRegWrite=1'b0;
  end
  else if(opCode == 5'b00001) begin
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
  else if(opCode == 5'b00010) begin
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
  else if(opCode == 5'b00011) begin
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
  else if(opCode == 5'b00100) begin
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
  else if(opCode == 5'b00101) begin
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
  else if(opCode == 5'b00110) begin
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
  else if(opCode == 5'b00111) begin
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
  else if(opCode == 5'b01000) begin
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
  else if(opCode == 5'b01001) begin
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
  else if(opCode == 5'b01010) begin
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
  else if(opCode == 5'b01011) begin
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
  else if(opCode == 5'b01100) begin
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
  else if(opCode == 5'b01101) begin
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
  else if(opCode == 5'b01110) begin
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
  else if(opCode == 5'b01111) begin
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
  else if(opCode == 5'b10000) begin
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
  else if(opCode == 5'b10001) begin
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
	iamTwoInstruction=1'b1;
  end
  else if(opCode == 5'b10010) begin
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
  else if(opCode == 5'b10011) begin
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
  else if(opCode == 5'b10100) begin
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
  // edits for jumps
  ALUControl=4'b0111;
  ImmOrReg=1'b1;
  iamJMP = 1'b1;
  end
  else if(opCode == 5'b10101) begin
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
	// edits for jumps
  ALUControl=4'b0111;
  ImmOrReg=1'b1;
  iamJMP = 1'b1;
  end
  else if(opCode == 5'b10110) begin
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
	// edits for jumps
  ALUControl=4'b0111;
  ImmOrReg=1'b1;
  iamJMP = 1'b1;

  end
  else if(opCode == 5'b10111) begin
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
	// edits for jumps
  ALUControl=4'b0111;
  ImmOrReg=1'b1;
  iamJMP = 1'b1;
  end
  else if(opCode == 5'b11000) begin
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
  else if(opCode == 5'b11001) begin
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
	ALUControl=4'b0111;
  iamTwoInstruction=1'b1;
  iamJMP = 1'b1;

  end
  else if(opCode == 5'b11010) begin
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
  else if(opCode == 5'b11011) begin
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
  iamTwoInstruction=1'b1;
  end
  else if(opCode == 5'b11100) begin
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
  else if(opCode == 5'b11101) begin
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
  iamTwoInstruction=1'b1;
  end
  else if(opCode == 5'b11110) begin
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
  pushFlags = 1'b1;
  end
  else if(opCode == 5'b11111) begin
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
  iamTwoInstruction=1'b1;

  end
end

endmodule
