/*
Module name   : Memory Instruction
Author	      : Ziad Sherif
Functionality : Container where we store instructions in it
*/

module MemoryInstruction (
    readAddress,
    memInstruction,
    stall
);

  input stall;
  input [31:0] readAddress;
  output reg [15:0] memInstruction;

  reg [15:0] memArray[2097152:0];
  // reg [15:0] memArray[63:0];

  integer i;
  initial begin
    $readmemb("./instr.txt", memArray);
  end

  always @(*) begin
    if (stall) memInstruction = 16'b0;
    else memInstruction = memArray[readAddress];
  end

endmodule
