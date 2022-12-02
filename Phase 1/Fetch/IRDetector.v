/*
Module name   : Instruction Register Detector
Author	      : Ziad Sherif
Functionality : A block in which we detect we choose 1st 16-bit and go on ,, or wait to next 16-bit to fetch whole 32-bit (immediate)
*/

module IRDetector (
    input [15:0] iR,
    input clk,
    output reg [15:0] instruction,
    immediate
);

  reg flag = 0;

  always @(posedge clk) begin
    if (iR[2]) flag = 1;

    instruction = iR;

    if (flag) begin
      immediate = iR;
      flag = 0;
    end

  end


endmodule
