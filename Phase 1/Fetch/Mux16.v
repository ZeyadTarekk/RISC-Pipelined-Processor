/*
Module name   : mux 16-bit
Author	      : Ziad Sherif
Functionality : A simple multiplxer 16-bit 
*/
module Mux16 (
    firstOp,
    secondOp,
    sel,
    res
);
  input [15:0] firstOp;
  input [15:0] secondOp;
  input sel;
  output [15:0] res;
  assign res = sel ? secondOp : firstOp;
endmodule
