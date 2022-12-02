module adder (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] samePcOut,
    nextPcOut
);
  assign samePcOut = a;
  assign nextPcOut = a + b;
endmodule
