module ExMemBuffer(
      input RegWrite, MemOrReg, DestOrPrivate, MemWrite ,MemRead , clk, SPOrALUres
    , input [3:0] regDestAddress
    , input [15:0] ALUResult, RegSrc
    , input [1:0] SPOpeartion
    , output reg oRegWrite, oMemOrReg,  oMemWrite , oMemRead  ,  oDestOrPrivate , oSPOrALUres
    , output reg [3:0] oRegDestAddress
    , output reg [15:0] oALUResult , oRegSrc
    , output reg [1:0] oSPOpeartion
     );

initial begin
    oRegWrite=0;
    oMemOrReg=0;
    oDestOrPrivate=0;
    oRegDestAddress=0;
    oSPOpeartion=0;
    oMemWrite=0;
    oMemRead=0;
    oSPOrALUres=0;
    oALUResult=0;
    oRegSrc=0;
end

always @(posedge clk)
begin 
    oRegWrite=RegWrite;
    oMemOrReg=MemOrReg;
    oDestOrPrivate=DestOrPrivate;
    oRegDestAddress=regDestAddress;
    oALUResult=ALUResult;
    oSPOpeartion=SPOpeartion;
    oMemWrite=MemWrite;
    oMemRead=MemRead;
    oSPOrALUres=SPOrALUres;
    oRegSrc=RegSrc;
end

endmodule