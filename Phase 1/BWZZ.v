module BWZZ(input clk, reset);

///// if
wire stall;
wire [31:0] PC, NextPC;
wire [15:0] Inst , Imm;

Fetch  fet(
    .stall(stall),
    .clk(clk),

    .samePc(PC),
    .nextPc(NextPC),
    .instruction(Inst),
    .immediate(Imm)
    );



/// IF-ID
wire flush;
wire [31:0] IF_ID_PC , IF_ID_NextPC;
wire [15:0] IF_ID_Inst , IF_ID_Imm;

IfIdBuffer ifoo(
    .clk(clk) 
    ,.flush(flush)
    ,.instruction(Inst)
    ,.imm(Imm)
    ,.pc(PC) 
    ,.nextPC(NextPC)

    ,.oPc(IF_ID_PC)
    ,.oNextPC(IF_ID_NextPC)
    ,.oInstruction(IF_ID_Inst)
    ,.oimm(IF_ID_Imm)
     );

/// Decoding Stage
wire RegWrite , MemOrReg, DestOrPrivate , MemWrite, MemRead, SPOrALUres, immOrReg, updateStatus;
wire [3:0] regDestAddress , regSrcAddress, AlUControl;
wire [15:0] RegSrc ,RegDest , imm;
wire [1:0] SPOpeartion, carryFlag, funCode ;
//stall => output from Decoding


/// Decodeing Ex Buffer

wire ID_EX_RegWrite , ID_EX_MemOrReg, ID_EX_DestOrPrivate , ID_EX_MemWrite, ID_EX_MemRead, ID_EX_SPOrALUres, ID_EX_immOrReg, ID_EX_updateStatus;
wire [3:0] ID_EX_regDestAddress , ID_EX_regSrcAddress, ID_EX_AlUControl;
wire [15:0] ID_EX_RegSrc ,ID_EX_RegDest , ID_EX_imm;
wire [1:0] ID_EX_SPOpeartion, ID_EX_carryFlag, ID_EX_funCode ;

IdExBuffer waer(
    .RegWrite(RegWrite)
    ,.MemOrReg(MemOrReg)
    ,.DestOrPrivate(DestOrPrivate)
    ,.MemWrite(MemWrite)
    ,.MemRead(MemRead)
    ,.clk(clk)
    ,.SPOrALUres(SPOrALUres)
    ,.immOrReg(immOrReg)
    ,.updateStatus(updateStatus) 
    ,.regDestAddress(regDestAddress)
    ,.regSrcAddress(regSrcAddress)
    ,.AlUControl(AlUControl)
    ,.RegSrc(RegSrc) 
    ,.RegDest(RegDest)
    ,.imm(imm)
    ,.SPOpeartion(SPOpeartion) 
    ,.carryFlag(carryFlag) 
    ,.funCode(funCode)
    
    , .oRegWrite(ID_EX_RegWrite),
     .oMemOrReg(ID_EX_MemOrReg),
     .oMemWrite(ID_EX_MemWrite) ,
     .oMemRead(ID_EX_MemRead) ,
     .oDestOrPrivate(ID_EX_DestOrPrivate) ,
     .oSPOrALUres(ID_EX_DestOrPrivate) ,
     .oimmOrReg(ID_EX_immOrReg) ,
     .oupdateStatus(ID_EX_updateStatus),
     .oRegDestAddres(ID_EX_RegDestAddres) ,
     .oRegSrcAddress(ID_EX_RegSrcAddress) ,
     .oAlUControl(ID_EX_AlUControl),
     .oRegSrc(ID_EX_RegSrc) ,
     .oRegDest(ID_EX_RegDest),
     .oimm(ID_EX_imm),
     .oSPOpeartion(ID_EX_SPOpeartion),
     .ocarryFlag(ID_EX_carryFlag),
     .ofunCode(ID_EX_funCode)
     );


// Execute

wire [15:0] ALUResult;

ExecuteStage besho(
    .updateStatus(ID_EX_updateStatus),
    .ALUControl(ID_EX_AlUControl),
    .RegSrc(ID_EX_RegSrc),
    .RegDst(ID_EX_RegDest),
    .immediate(ID_EX_imm),
    .reset(reset),

    .ALUResult(ALUResult)
);

// Execute - Memory 
wire EX_MEM_RegWrite ,EX_MEM_MemOrReg ,EX_MEM_DestOrPrivate ,EX_MEM_MemWrite ,EX_MEM_MemRead ,EX_MEM_SPOrALUres ;
wire [3:0] EX_MEM_RegDestAddress ;
wire [1:0] EX_MEM_SPOpeartion;
wire [15:0] EX_MEM_ALUResult ,EX_MEM_RegSrc ;

ExMemBuffer(
    .RegWrite(ID_EX_RegWrite), 
    .MemOrReg(ID_EX_MemOrReg),
    .DestOrPrivate(ID_EX_DestOrPrivate),
    .MemWrite(ID_EX_MemWrite),
    .MemRead(ID_EX_MemRead),
    .clk(clk),
    .SPOrALUres(ID_EX_SPOrALUres),  
    .regDestAddress(ID_EX_RegDestAddres),
    .ALUResult(ALUResult), 
    .RegSrc(ID_EX_RegSrc),
    .SPOpeartion(ID_EX_SPOpeartion),

    .oRegWrite(EX_MEM_RegWrite),
    .oMemOrReg(EX_MEM_MemOrReg),
    .oMemWrite(EX_MEM_MemWrite),
    .oMemRead(EX_MEM_MemRead),
    .oDestOrPrivate(EX_MEM_DestOrPrivate),
    .oSPOrALUres(EX_MEM_SPOrALUres),
    .oRegDestAddress(EX_MEM_RegDestAddress),
    .oALUResult(EX_MEM_ALUResult),
    .oRegSrc(EX_MEM_RegSrc),  
    .oSPOpeartion(EX_MEM_SPOpeartion)
     );


/// Data Memory 
wire [15:0] MemoryRes;

MemoryStage(
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
wire MEM_WB_RegWrite ,MEM_WB_MemOrReg, MEM_WB_DestOrPrivate;
wire [3:0] MEM_WB_RegDestAddress;
wire [15:0] MEM_WB_DataRes ,MEM_WB_Data;

MemWbBuffer MB(
    .RegWrite(EX_MEM_RegWrite),
    .MemOrReg(EX_MEM_MemOrReg),
    .DestOrPrivate(EX_MEM_DestOrPrivate),
    .clk(clk), 
    .regDestAddress(EX_MEM_RegDestAddress),
    .dataRes(EX_MEM_ALUResult),
    .data(MemoryRes),

    .oRegWrite(MEM_WB_RegWrite),
    .oMemOrReg(MEM_WB_MemOrReg),
    .oDestOrPrivate(MEM_WB_DestOrPrivate),
    .oRegDestAddress(MEM_WB_RegDestAddress),
    .oDataRes(MEM_WB_DataRes),
    .oData(MEM_WB_Data) 
    );


/// Write back
wire [15:0] outputRes;

WriteBack Wb (
      .regWrite(MEM_WB_RegWrite),
      .memOrReg(MEM_WB_MemOrReg),
      .dstOrPrivate(MEM_WB_DestOrPrivate),
      .clk(clk),
      .regDstAddress(MEM_WB_RegDestAddress),
      .memData(MEM_WB_Data),
      .aluDat(MEM_WB_DataRes),
      
      
      
      .outputRes(outputRes)
  );

endmodule