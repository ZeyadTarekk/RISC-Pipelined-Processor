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
    stall,
    clk,
    jumpBit,
    rst,
    interruptBit,
    finalInstruction,
    branchIR,
    initPc,
    samePc,
    nextPc,
    instruction,
    immediate
);
  input stall, clk, jumpBit, rst, interruptBit;
  input [31:0] branchIR, initPc;
  output [31:0] nextPc, samePc;
  output [15:0] instruction, immediate, finalInstruction;



  wire [31:0] currentCount[2:0];
  wire [31:0] nextWire;
  reg  [31:0] tempWire;

  /* first mux
    * param (next pc ,branch address , sel bit, output data)
    */

  Mux32 M1 (
      initPc,
      branchIR,
      jumpBit,
      currentCount[0]
  );

  /* second mux
    * param (current pc ,first instruction after interrupt , sel bit, output data)
    */
  Mux32 M2 (
      currentCount[0],
      32'h20,
      rst,
      currentCount[1]
  );
  /* third mux
    * param (current pc ,first address of interrupt memory , sel bit, output data)
    */
  Mux32 M3 (
      currentCount[1],
      32'b0,
      interruptBit,
      currentCount[2]
  );


  PC addPc (
      .a(currentCount[2]),
      .b(32'b1),
      .samePcOut(samePc),
      .nextPcOut(nextPc),
      .stall(stall)
  );

  assign nextWire = samePc;

  MemoryInstruction mem (
      .readAddress(nextWire),
      .memInstruction(instruction),
      .stall(stall)
  );

  assign tempWire = instruction;
  IRDetector iRImemediate (
      .IR(tempWire),
      .clk(clk),
      .instruction(finalInstruction),
      .immediate(immediate)
  );



endmodule
