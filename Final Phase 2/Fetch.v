module Fetch (
    input stall,
    clk,
    jumpBit,
    rst,
    interruptBit,
    input [31:0] branchIR,
    initPc,
    output [15:0] finalInstruction,
    instructionTest,
    immediate,
    output [31:0] samePc,
    nextPc,
    output iamBubble
);

  wire [31:0] currentCount[2:0];
  wire [31:0] nextWire;
  reg  [15:0] tempWire;

  assign currentCount[0] = jumpBit ? branchIR : initPc;

  assign currentCount[1] = interruptBit ? 32'b0 : currentCount[0];

  assign currentCount[2] = rst ? 32'b0000_0000_0000_0000_0000_0000_0010_0000 : currentCount[1];

  PC addPc (
      .CurrentPC(currentCount[2]),
      .samePc(samePc),
      .nextPc(nextPc),
      .stall(stall),
      .clk(clk)
  );

  assign nextWire = samePc;

  MemoryInstruction mem (
      .readAddress(nextWire),
      .memInstruction(instructionTest),
      .stall(stall)
  );

  always @(*) begin
    tempWire = instructionTest;
  end
  IRDetector iRImemediate (
      .iR(tempWire),
      .clk(clk),
      .jumpBit(jumpBit),
      .instruction(finalInstruction),
      .immediate(immediate),
      .iamBubble(iamBubble)
  );



endmodule
