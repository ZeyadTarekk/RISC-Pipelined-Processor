module ProgramCounter (
    clk,
    stallf,
    nextCount,
    currentCount
);


  input [31:0] nextCount;
  input stallf;
  input clk;
  output reg [31:0] currentCount;

  // set pc to 2^5 in startup of program
  initial begin
    nextCount <= 32'h20;
  end

  always @(posedge clk) begin
    if (stallf == 1) currentCount <= nextCount;
  end

endmodule
