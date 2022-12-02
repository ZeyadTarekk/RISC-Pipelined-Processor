/*
Module name   : Fetch
Author	      : Ziad Sherif
Functionality : Stage that fetch data from instruction memory
*/

// includes
`include "Mux32.v"
`include "Pc.v"
`include "MemInstruction.v"
`include "IRDetector.v"

module Fetch (
    stall,
    clk,
    jumpBit,
    rst,
    interruptBit,
    branchIR,
    samePc,
    nextPc,
    instruction,
    immediate
);
  input stall, clk, jumpBit, rst, interruptBit;
  input [31:0] branchIR;
  output [31:0] nextPc, samePc;
  output [15:0] instruction, immediate;


  wire [31:0] currentCount;

  /* first mux
    * param (next pc ,branch address , sel bit, output data)
    */

  Mux32 M1 (
      nextPc,
      branchIR,
      jumpBit,
      currentCount
  );

  /* second mux
    * param (current pc ,first instruction after interrupt , sel bit, output data)
    */
  Mux32 M2 (
      currentCount,
      32'h20,
      rst,
      currentCount
  );
  /* third mux
    * param (current pc ,first address of interrupt memory , sel bit, output data)
    */
  Mux32 M3 (
      currentCount,
      0,
      interruptBit,
      currentCount
  );


  PC addPc (
      currentCount,
      4,
      samePc,
      nextPc,
      stall
  );

  MemoryInstruction mem (
      samePc,
      instruction,
      stall
  );

  IRDetector iRImemediate (
      instruction,
      clk,
      instruction,
      immediate
  );



endmodule
