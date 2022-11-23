module Fetch (
    stallf,
    clk,
    nextPc,
    instruction,
    immediate
);
  input stallf;
  input clk;
  output [31:0] nextPc;
  output [15:0] instruction, immediate;

  wire [31:0] nextCount;
  wire [31:0] currentCount;

  programCounter pc (
      clk,
      stallf,
      nextCount,
      currentCount
  );
  adder addPc (
      currentCount,
      4,
      nextPc
  );

  MemoryInstruction mem (
      currentCount,
      instruction
  );

  IRDetector iRImemediate (
      instruction,
      clk,
      instruction,
      immediate
  );



endmodule
