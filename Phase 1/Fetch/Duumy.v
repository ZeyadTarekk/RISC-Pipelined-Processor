/*
Module name   : Program Counter
Author	      : Ziad Sherif
Functionality : Register we store next address instruction
*/

module ProgramCounter (
    clk,
    stall,
    nextCount,
    currentCount
);


  input [31:0] nextCount;
  input stall;
  input clk;
  output reg [31:0] currentCount;


  always @(posedge clk) begin
    //  if there is no stalling
    if (stall != 1) currentCount <= nextCount;
  end

endmodule
