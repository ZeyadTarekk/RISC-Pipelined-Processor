module WriteBack (
    input clk,
    memOrReg,
    input [15:0] memData,
    aluData,
    output [15:0] outputRes
);

		assign  outputRes = memOrReg ? aluData : memData;

endmodule
