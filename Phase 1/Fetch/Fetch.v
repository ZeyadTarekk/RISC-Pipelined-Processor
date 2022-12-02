/*
Module name   : Fetch
Author	      : Ziad Sherif
Functionality : Stage that fetch data from instruction memory
*/

// includes
`include "Mux32.v"
`include "Pc.v"
`include "Adder4.v"
`include "MemInstruction.v"
`include "IRDetector.v"

module Fetch (
    stall,
    clk,
    nextPc,
    instruction,
    immediate
);
  input stall;
  input clk;
  output [31:0] nextPc;
  output [15:0] instruction, immediate;

  wire [31:0] nextCount;
  wire [31:0] currentCount;

  programCounter pc (
      clk,
      stall,
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
