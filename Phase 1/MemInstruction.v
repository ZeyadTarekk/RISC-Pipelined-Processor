module MemoryInstruction (
    readAddress,
    memInstruction
);

  input [31:0] readAddress;
  output [15:0] memInstruction;

  reg [15:0] memArray[2097152:0];

  assign memInstruction = memArray[readAddress];
endmodule
