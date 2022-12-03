module PC (
    a,
    b,
    samePcOut,
    nextPcOut,
    stall
);
  input stall;
  input [31:0] a, b;
  output reg [31:0] samePcOut, nextPcOut;

  // initial begin
  // samePcOut=32'h20;
  // nextPcOut=32'h20;s
  // end

  // assign samePcOut = a;
  always @(*) begin
    samePcOut = a;
    if (!stall) nextPcOut = a + b;
    else samePcOut = a;

  end
endmodule
