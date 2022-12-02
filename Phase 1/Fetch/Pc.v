module PC (
    a,
    b,
    samePcOut,
    nextPcOut,
    stall,
);
  input stall;
  input [31:0] a, b;
  output reg [31:0] samePcOut, nextPcOut;
  assign samePcOut = a;
  always @(*) begin
    if (!stall) nextPcOut = a + b;
    else samePcOut = a;

  end
endmodule
