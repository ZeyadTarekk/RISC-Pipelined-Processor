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

  // set pc to 2^5 in startup of program
  initial begin
    nextCount <= 32'h20;
  end

  always @(posedge clk) begin
    //  if there is no stalling
    if (stall != 1) currentCount <= nextCount;
  end

endmodule
