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


  initial begin

    // fd = $fopen("my_file.txt", "r");

    // $readmemb("./instr.txt", memArray);
    $readmemb("./manga.txt", memArray);
  end

  // assign memInstruction = memArray[readAddress];

  always @(*) begin
    if (stall) memInstruction = 16'b0;
    else memInstruction = memArray[readAddress];
  end

endmodule
