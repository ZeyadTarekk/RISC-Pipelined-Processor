
/*
Module name   : Write Back 
Author	      : Ziad Sherif
Functionality : A simple write back module which received data from alu and data memory , and choose one of them dependent on Memory-Reg-Bit
*/

module WriteBack (
    memOrReg,
    memData,
    aluData,
    outputRes,
    clk
);
  input memOrReg, clk;
  input [15:0] memData, aluData;
  output reg [15:0] outputRes;

  always @(*) begin
		outputRes = memOrReg ? aluData : memData;
  end

endmodule
