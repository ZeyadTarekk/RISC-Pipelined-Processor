/*
Module name   : Instruction Register Detector
Author	      : Ziad Sherif
Functionality : A block in which we detect we choose 1st 16-bit and go on, or wait to next 16-bit to fetch whole 32-bit (immediate)
*/

module IRDetector (
    input [15:0] iR,
    input clk,
    output reg [15:0] instruction,
    immediate
);
	reg flag;

	initial begin
		flag = 0;
	end

  always @(posedge clk) begin
		if (flag) begin
			immediate   = iR;
			instruction = 0;
			flag = 0;
		end else instruction = iR;

    if (iR[2] == 1'b1) begin
			flag = 1;
		end
  end


endmodule
