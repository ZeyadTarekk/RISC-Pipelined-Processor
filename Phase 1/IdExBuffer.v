module IdExBuffer(
      input RegWrite, MemOrReg, DestOrPrivate, MemWrite ,MemRead , clk, SPOrALUres , immOrReg, updateStatus 
    , input [3:0] regDestAddress, regSrcAddress, AlUControl
    , input [15:0]  RegSrc , RegDest, imm
    , input [1:0] SPOpeartion , carryFlag , funCode
    
    , output reg oRegWrite, oMemOrReg,  oMemWrite , oMemRead  ,  oDestOrPrivate , oSPOrALUres , oimmOrReg , oupdateStatus
    , output reg [3:0] oRegDestAddress, oRegSrcAddress , oAlUControl
    , output reg [15:0]  oRegSrc , oRegDest, oimm
    , output reg [1:0] oSPOpeartion , ocarryFlag, ofunCode
     );

initial begin
    oRegWrite=0;
    oMemOrReg=0;
    oDestOrPrivate=0;
    oRegDestAddress=0;
    oRegSrcAddress=0;
    oSPOpeartion=0;
    oMemWrite=0;
    oMemRead=0;
    oSPOrALUres=0;
    oRegSrc=0;
    oRegDest=0;
    oimmOrReg=0;
    oupdateStatus=0;
    oAlUControl=0;
    ocarryFlag=0;
    ofunCode=0;
    oimm=0;
end

always @(posedge clk)
begin 
    oRegWrite=RegWrite;
    oMemOrReg=MemOrReg;
    oDestOrPrivate=DestOrPrivate;
    oRegDestAddress=regDestAddress;
    oRegSrcAddress=regSrcAddress;
    oSPOpeartion=SPOpeartion;
    oMemWrite=MemWrite;
    oMemRead=MemRead;
    oSPOrALUres=SPOrALUres;
    oRegSrc=RegSrc;
    oRegDest=RegDest;
    oimmOrReg=immOrReg;
    oupdateStatus=updateStatus;
    oAlUControl=AlUControl;
    ocarryFlag=carryFlag;
    ofunCode=funCode;
    oimm=imm;
end

endmodule