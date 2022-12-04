module PC (
    input [31:0] CurrentPC,
    input stall, clk,
    output reg [31:0] samePc,nextPc
);

  always @(posedge clk) begin
		#1
    samePc = CurrentPC;
    nextPc = CurrentPC + 1'b1;
  end

endmodule
