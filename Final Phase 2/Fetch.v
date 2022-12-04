/*
Module name   : Fetch
Author	      : Ziad Sherif
Functionality : Stage that fetch data from instruction memory
*/

// includes
`include "Mux32.v"
`include "PC.v"
`include "MemInstruction.v"
`include "IRDetector.v"


module Fetch (
    input stall, clk, jumpBit, rst, interruptBit,
    input [31:0] branchIR,initPc,
    output [15:0] finalInstruction,instructionTest,immediate,
    output [31:0] samePc,nextPc
);

  wire [31:0] currentCount[2:0];
  wire [31:0] nextWire;
  reg  [15:0] tempWire;

  assign currentCount[0] = jumpBit ? branchIR : initPc;
 
  assign currentCount[1] = interruptBit ? 32'b0 : currentCount[0];

  assign currentCount[2] = rst ? -1 : currentCount[1];

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
      .instruction(finalInstruction),
      .immediate(immediate)
  );



endmodule
