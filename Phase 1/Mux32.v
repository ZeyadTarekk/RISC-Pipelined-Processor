
module Mux32 (
    firstOp,
    secondOp,
    sel,
    res
);
  input [31:0] firstOp;
  input [31:0] secondOp;
  input sel;
  output [31:0] res;
  assign res = sel ? secondOp : firstOp;
endmodule
