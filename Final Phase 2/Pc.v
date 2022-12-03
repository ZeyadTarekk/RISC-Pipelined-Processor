module PC (
    a,
    b,
    samePcOut,
    nextPcOut,
    stall,
		clk
);
  input stall, clk;
  input [31:0] a, b;
  output reg [31:0] samePcOut, nextPcOut;

  // initial begin
	// 	samePcOut=32'b0;
	// 	nextPcOut=32'b0;
  // end

  // assign samePcOut = a;
  always @(posedge clk) begin
    samePcOut = a;
    if (!stall) nextPcOut = a + b;
    else samePcOut = a;

  end
endmodule
