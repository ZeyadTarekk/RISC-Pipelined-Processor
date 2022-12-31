module BWZZ (
    input clk,
    reset,
    interrupt
);

  // * first pass the next pc to the interrupt handler unit to save it and will output it later when the ISR is finished
  // * then the interrupt handler unit will have an output signal indicating whether to take the pc from the handler unit or the next normal pc
  // * in BWZZ we will have a mux to select the next pc based on the signal from the interrupt handler unit


  ///// if
  wire stall, interruptRaisedToFetch,interruptRaisedInstruction, interruptRaisedPC;
  wire [31:0] PC, NextPC, selectedPC, branchAddress, privateRegResultOutput;
  wire [15:0] Inst, Imm;
  wire flush, choosedBitOutput, iamBubble, iamJMP;


  Fetch fetchStage (
      .stall(1'b0),
      .clk(clk),
      .jumpBit(flush),
      .rst(reset),
      .interruptBit(interruptRaisedToFetch),
      .finalInstruction(Inst),
      .branchIR(branchAddress),
      .initPc(selectedPC),
			// same pc is ready in case of jmp after entering the alu
      .samePc(PC),
			// next pc for the instruction in the fetch
      .nextPc(NextPC),
      .instructionTest(),
      .immediate(Imm),
      .iamBubble(iamBubble)
  );

  // IF_ID_Inst
  /// IF-ID
  wire [31:0] IF_ID_PC, IF_ID_NextPC;
  wire [15:0] IF_ID_Inst;
  wire IF_ID_iamBubble;
  wire [15:0] SELECTED_INSTRUCTION;
  wire [31:0] SELECTED_NEXT_PC;
  wire [31:0] interruptPC;
  wire [15:0] interruptInstruction;


  IfIdBuffer IF_ID_Buffer (
      .clk(clk),
      .flush(flush),
      .instruction(Inst),
			// this pc is pushed when the first interrupt instruction is added
      .pc(PC),
      .nextPC(SELECTED_NEXT_PC),
      .iamBubble(iamBubble),
      .oPc(IF_ID_PC),
      .oNextPC(IF_ID_NextPC),
      .oInstruction(IF_ID_Inst),
      .oiamBubble(IF_ID_iamBubble)
  );


  interruptHandler interruptHandler (
      .clk(clk),
      .functionBits(IF_ID_Inst[2:0]),
      .interruptBit(interrupt),
      .interruptInstruction(interruptInstruction),
      .interruptRaisedToFetch(interruptRaisedToFetch),
      .interruptRaisedInstruction(interruptRaisedInstruction),
      .nextPC(NextPC),
      .interruptRaisedPC(interruptRaisedPC),
      .interruptPC(interruptPC),
      .iamJMP(iamJMP)
  );

  assign SELECTED_INSTRUCTION = interruptRaisedInstruction ? interruptInstruction : IF_ID_Inst;
  assign SELECTED_NEXT_PC = interruptRaisedPC ? interruptPC : NextPC;


  /// Decoding Stage
  wire RegWrite , MemOrReg, DestOrPrivate , MemWrite, MemRead, SPOrALUres, immOrReg, updateStatus, BranchFlag, PCControl, privateRegWrite;
  wire [3:0] regDestAddress, regSrcAddress, AlUControl;
  wire [15:0] RegSrc, RegDest, imm;
  wire [2:0] funCode;
  wire [1:0] SPOpeartion, carryFlag;
  wire [3:0] regDestAddressID_EX, regSrcAddressID_EX;

  assign regSrcAddress  = SELECTED_INSTRUCTION[10:7];
  assign regDestAddress = SELECTED_INSTRUCTION[6:3];

  wire MakeMeBubble, ID_EX_MemRead;

  HazardDetectionUnit detectHazard (
      .MemRead(ID_EX_MemRead),
      .ALUDest(regDestAddressID_EX),
      .DecodeSrc(regSrcAddress),
      .DecodeDest(regDestAddress),

      .MakeMeBubble(MakeMeBubble)
  );


  wire iamTwoInstruction, iamNop;

  controlUnit ControlUnit (
      .makeMeBubble(MakeMeBubble),
      .opCode(SELECTED_INSTRUCTION[15:11]),
      .SPOperation(SPOpeartion),
      .RegWrite(RegWrite),
      .MemRead(MemRead),
      .MemWrite(MemWrite),
      .MemOrReg(MemOrReg),
      .UpdateStatus(updateStatus),
      .ImmOrReg(immOrReg),
      .ALUControl(AlUControl),
      .SPOrALUres(SPOrALUres),
      .DestOrPrivate(DestOrPrivate),
      .BranchFlag(BranchFlag),
      .CarryFlag(carryFlag),
      .PCControl(PCControl),
      .privateRegWrite(privateRegWrite),
      .iamTwoInstruction(iamTwoInstruction),
      .iamNop(iamNop),
      .iamJMP(iamJMP)
  );

  assign selectedPC = PCControl ? PC : SELECTED_NEXT_PC;
  assign funCode = SELECTED_INSTRUCTION[2:0];


  // Register file
  wire MEM_WB_RegWrite;
  wire [3:0] MEM_WB_RegDestAddress, MEM_WB_RegDestAddressForward;
  wire [15:0] outputRes;

  regFile RegisterFile (
      .write_enable(MEM_WB_RegWrite),
      .rst(reset),
      .clk(clk),
      .privateRegWrite(privateRegWrite),
      .PC(selectedPC),
      .write_data(outputRes),
      .read_addr1(SELECTED_INSTRUCTION[10:7]),
      .read_addr2(SELECTED_INSTRUCTION[6:3]),
      .write_addr(MEM_WB_RegDestAddress),

      .read_data1(RegSrc),
      .read_data2(RegDest),
      .privateRegResult(privateRegResultOutput)
  );


  /// Decodeing Ex Buffer
  wire ID_EX_RegWrite, ID_EX_MemOrReg, ID_EX_DestOrPrivate, ID_EX_MemWrite, ID_EX_SPOrALUres, ID_EX_immOrReg, ID_EX_updateStatus, ID_EX_iamTwoInstruction,ID_EX_iamBubble;
  wire [3:0] ID_EX_AlUControl;
  wire [15:0] ID_EX_RegSrc, ID_EX_RegDest, ID_EX_imm;
  wire [2:0] ID_EX_funCode;
  wire [1:0] ID_EX_SPOpeartion, ID_EX_carryFlag;


  IdExBuffer ID_EX_Buffer (
      .iamNop(iamNop),
      .iamTwoInstruction(iamTwoInstruction),
      .RegWrite(RegWrite),
      .MemOrReg(MemOrReg),
      .DestOrPrivate(DestOrPrivate),
      .MemWrite(MemWrite),
      .MemRead(MemRead),
      .clk(clk),
      .SPOrALUres(SPOrALUres),
      .immOrReg(immOrReg),
      .updateStatus(updateStatus),
      .regDestAddress(regDestAddress),
      .regSrcAddress(regSrcAddress),
      .AlUControl(AlUControl),
      .RegSrc(RegSrc),
      .RegDest(RegDest),
      .imm(Imm),
      .SPOpeartion(SPOpeartion),
      .carryFlag(carryFlag),
      .funCode(funCode),
      .BranchFlag(BranchFlag),
      .makeMeBubble(MakeMeBubble),
      .iamBubble(IF_ID_iamBubble),


      .oRegWrite(ID_EX_RegWrite),
      .oMemOrReg(ID_EX_MemOrReg),
      .oMemWrite(ID_EX_MemWrite),
      .oMemRead(ID_EX_MemRead),
      .oDestOrPrivate(ID_EX_DestOrPrivate),
      .oSPOrALUres(ID_EX_SPOrALUres),
      .oimmOrReg(ID_EX_immOrReg),
      .oupdateStatus(ID_EX_updateStatus),
      .oRegDestAddress(regDestAddressID_EX),
      .oRegSrcAddress(regSrcAddressID_EX),
      .oAlUControl(ID_EX_AlUControl),
      .oRegSrc(ID_EX_RegSrc),
      .oRegDest(ID_EX_RegDest),
      .oimm(ID_EX_imm),
      .oSPOpeartion(ID_EX_SPOpeartion),
      .ocarryFlag(ID_EX_carryFlag),
      .ofunCode(ID_EX_funCode),
      .oBranchFlag(ID_EX_BranchFlag),
      .oiamTwoInstruction(ID_EX_iamTwoInstruction),
      .oiamBubble(ID_EX_iamBubble)
  );

  assign flush = ID_EX_BranchFlag & choosedBitOutput;


  ///// Status register
  wire [3:0] StatusFlagsOutput, savedFlagsOutput, updatedStatusOutput;

  StatusRegister StatusRegisterBank (
      .updateStatus(ID_EX_updateStatus),
      .carryFlag(ID_EX_carryFlag),
      .functionCode(ID_EX_funCode),
      .newStatus(updatedStatusOutput),
      .savedStatus(savedFlagsOutput),
      .reset(reset),
      .choosedBit(choosedBitOutput),
      .StatusFlags(StatusFlagsOutput)
  );

  SavedFlages savedFlag (
      .interrupt(interrupt),
      .CCR(StatusFlagsOutput),
      .SavedFlages(savedFlagsOutput)
  );


  wire [3:0] EX_MEM_RegDestAddress;
  wire [1:0] SrcChange, DestChange;
  wire EX_MEM_iamBubble, MEM_WB_iamBubble;

  // Forwarding UNit
  ForwardingUnit Forwarding (
      .clk(clk),
      .doesntRequirdForwarding(ID_EX_iamTwoInstruction),
      .bubbleFromEX_MEM(EX_MEM_iamBubble),
      .bubbleFromMEM_WB(MEM_WB_iamBubble),
      .ALURegsrc(regSrcAddressID_EX),
      .ALURegdest(regDestAddressID_EX),
      .AlUMEMres(EX_MEM_RegDestAddress),
      .MEMWBres(MEM_WB_RegDestAddressForward),

      .SrcChange (SrcChange),
      .DestChange(DestChange)
  );

  // Execute
  wire [15:0] ALUResult, outputToEx;
  wire [15:0] EX_MEM_ALUResult, EX_MEM_RegSrc;
  wire [15:0] ALUfirstOperand;

  ExecuteStage ALUStage (
      .ImmOrReg(ID_EX_immOrReg),
      .ALUControl(ID_EX_AlUControl),
      .RegSrc(ID_EX_RegSrc),
      .RegDst(ID_EX_RegDest),
      .immediate(ID_EX_imm),
      .selectSrc(SrcChange),
      .selectDst(DestChange),
      .RegSrcFromEx(EX_MEM_ALUResult),
      .RegDstFromEx(EX_MEM_ALUResult),
      .RegSrcFromMem(outputToEx),
      .RegDstFromMem(outputToEx),

      .ALUfirstOperand(ALUfirstOperand),
      .newStatus(updatedStatusOutput),
      .ALUResult(ALUResult)
  );




  // Execute - Memory 
  wire EX_MEM_RegWrite ,EX_MEM_MemOrReg ,EX_MEM_DestOrPrivate ,EX_MEM_MemWrite ,EX_MEM_MemRead ,EX_MEM_SPOrALUres;
  wire [1:0] EX_MEM_SPOpeartion;

  ExMemBuffer EX_MEM_Buffer (
      .RegWrite(ID_EX_RegWrite),
      .MemOrReg(ID_EX_MemOrReg),
      .DestOrPrivate(ID_EX_DestOrPrivate),
      .MemWrite(ID_EX_MemWrite),
      .MemRead(ID_EX_MemRead),
      .clk(clk),
      .SPOrALUres(ID_EX_SPOrALUres),
      .regDestAddress(regDestAddressID_EX),
      .ALUResult(ALUResult),
      .RegSrc(ALUfirstOperand),
      .SPOpeartion(ID_EX_SPOpeartion),
      .iamBubble(ID_EX_iamBubble),

      .oRegWrite(EX_MEM_RegWrite),
      .oMemOrReg(EX_MEM_MemOrReg),
      .oMemWrite(EX_MEM_MemWrite),
      .oMemRead(EX_MEM_MemRead),
      .oDestOrPrivate(EX_MEM_DestOrPrivate),
      .oSPOrALUres(EX_MEM_SPOrALUres),
      .oRegDestAddress(EX_MEM_RegDestAddress),
      .oALUResult(EX_MEM_ALUResult),
      .oRegSrc(EX_MEM_RegSrc),
      .oSPOpeartion(EX_MEM_SPOpeartion),
      .oiamBubble(EX_MEM_iamBubble)
  );


  /// Data Memory 
  wire [15:0] MemoryRes;

  MemoryStage DataMemory (
      .MemRead(EX_MEM_MemRead),
      .MemWrite(EX_MEM_MemWrite),
      .SPOrALUres(EX_MEM_SPOrALUres),
      .clk(clk),
      .rst(reset),
      .SPOpeartion(EX_MEM_SPOpeartion),
      .RegSrc(EX_MEM_RegSrc),
      .Data_result(EX_MEM_ALUResult),

      .Data(MemoryRes)
  );

  /// Memory WB Buffer
  wire MEM_WB_MemOrReg, MEM_WB_DestOrPrivate;
  wire [15:0] MEM_WB_DataRes, MEM_WB_Data;

  MemWbBuffer MEM_WB_Buffer (
      .RegWrite(EX_MEM_RegWrite),
      .MemOrReg(EX_MEM_MemOrReg),
      .DestOrPrivate(EX_MEM_DestOrPrivate),
      .clk(clk),
      .regDestAddress(EX_MEM_RegDestAddress),
      .dataRes(EX_MEM_ALUResult),
      .data(MemoryRes),
      .iamBubble(EX_MEM_iamBubble),

      .oRegWrite(MEM_WB_RegWrite),
      .oMemOrReg(MEM_WB_MemOrReg),
      .oDestOrPrivate(MEM_WB_DestOrPrivate),
      .oRegDestAddress(MEM_WB_RegDestAddress),
      .oRegDestAddressForward(MEM_WB_RegDestAddressForward),
      .oDataRes(MEM_WB_DataRes),
      .oData(MEM_WB_Data),
      .oiamBubble(MEM_WB_iamBubble)
  );


  /// Write back
  WriteBack WriteBackStage (
      .memOrReg(MEM_WB_MemOrReg),
      .memData(MEM_WB_Data),
      .aluData(MEM_WB_DataRes),
      .clk(clk),

      .outputRes (outputRes),
      .outputToEx(outputToEx)
  );


  /// Branch address selector
  BranchAddressSelector BranchSelector (
      .RegDst(ALUResult),
      .privateRegResult(privateRegResultOutput),
      .DecodeDestOrPrivate(ID_EX_DestOrPrivate),
      .WBDestOrPrivate(MEM_WB_DestOrPrivate),

      .branchAddress(branchAddress)
  );

endmodule
