module IdExBuffer (
    input RegWrite,
    MemOrReg,
    DestOrPrivate,
    MemWrite,
    MemRead,
    clk,
    SPOrALUres,
    immOrReg,
    updateStatus,
    BranchFlag,
		makeMeBubble,
    iamTwoInstruction,
    iamBubble,
    iamNop,

    input [3:0] regDestAddress, regSrcAddress, AlUControl,
    input [2:0] funCode,
    input [15:0] RegSrc, RegDest, imm,
    input [1:0] SPOpeartion, carryFlag,
		
    output reg oRegWrite,
    oMemOrReg,
    oMemWrite,
    oMemRead,
    oDestOrPrivate,
    oSPOrALUres,
    oimmOrReg,
    oupdateStatus,
    oBranchFlag,
    oiamTwoInstruction,
    oiamBubble,
    output reg [3:0] oRegDestAddress, oRegSrcAddress, oAlUControl,
    output reg [15:0] oRegSrc, oRegDest, oimm,
    output reg [1:0] oSPOpeartion, ocarryFlag,
    output reg [2:0] ofunCode
);

  initial begin
    oRegWrite = 0;
    oMemOrReg = 0;
    oDestOrPrivate = 0;
    oRegDestAddress = 0;
    oRegSrcAddress = 0;
    oSPOpeartion = 0;
    oMemWrite = 0;
    oMemRead = 0;
    oSPOrALUres = 0;
    oRegSrc = 0;
    oRegDest = 0;
    oimmOrReg = 0;
    oupdateStatus = 0;
    oAlUControl = 0;
    ocarryFlag = 0;
    ofunCode = 0;
    oimm = 0;
    oBranchFlag = 0;
    oiamTwoInstruction = 0;
    oiamBubble=0;
  end

  always @(posedge clk) begin
    oRegWrite = RegWrite;
    oMemOrReg = MemOrReg;
    oDestOrPrivate = DestOrPrivate;
    oSPOpeartion = SPOpeartion;
    oMemWrite = MemWrite;
    oMemRead = MemRead;
    oSPOrALUres = SPOrALUres;
    oRegSrc = RegSrc;
    oRegDest = RegDest;
    oimmOrReg = immOrReg;
    oupdateStatus = updateStatus;
    oAlUControl = AlUControl;
    ocarryFlag = carryFlag;
    ofunCode = funCode;
    oimm = imm;
    oBranchFlag = BranchFlag;
    oiamTwoInstruction = iamTwoInstruction;

		if (makeMeBubble || iamNop) begin
			oRegDestAddress = 4'b1111;
			oRegSrcAddress = 4'b1111;
      oiamBubble = 1;
		end else begin
			oRegDestAddress = regDestAddress;
			oRegSrcAddress = regSrcAddress;
      oiamBubble = iamBubble;
		end
  end

endmodule
