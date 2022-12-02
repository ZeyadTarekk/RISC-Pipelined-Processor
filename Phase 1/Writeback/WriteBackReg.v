
/*
Module name   : Write Back 
Author	      : Ziad Sherif
Functionality : A simple write back module which received data from alu and data memory , and choose one of them dependent on Memory-Reg-Bit
*/

module WriteBack (
    regWrite,
    memOrReg,
    memData,
    dstOrPrivate,
    aluData,
    regDstAddress,
    outputRes,
    clk
);
  input regWrite, memOrReg, dstOrPrivate, clk;
  input [3:0] regDstAddress;
  input [15:0] memData, aluData;
  output [15:0] outputRes;

  always @(posedge clk) begin
    Mux16 DataChoosen (
        memData,
        aluData,
        memOrReg,
        outputRes
    );

  end

endmodule
